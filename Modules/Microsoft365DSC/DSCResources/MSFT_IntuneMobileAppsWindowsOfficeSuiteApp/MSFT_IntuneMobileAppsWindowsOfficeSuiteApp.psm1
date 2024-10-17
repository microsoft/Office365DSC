function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.Boolean]
        $AutoAcceptEula,

        [Parameter()]
        [System.String[]]
        [ValidateSet('O365ProPlusRetail', 'O365BusinessRetail', 'VisioProRetail', 'ProjectProRetail')]
        $ProductIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExcludedApps,

        [Parameter()]
        [System.Boolean]
        $UseSharedComputerActivation,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Current', 'Deferred', 'FirstReleaseCurrent', 'FirstReleaseDeferred', 'MonthlyEnterprise')]
        $UpdateChannel,

        [Parameter()]
        [System.String]
        [ValidateSet('NotConfigured', 'OfficeOpenXMLFormat', 'OfficeOpenDocumentFormat', 'UnknownFutureValue')]
        $OfficeSuiteAppDefaultFileFormat,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'X86', 'X64', 'Arm', 'Neutral', 'Arm64')]
        $OfficePlatformArchitecture,

        [Parameter()]
        [System.String[]]
        $LocalesToInstall,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Full')]
        $InstallProgressDisplayLevel,

        [Parameter()]
        [System.Boolean]
        $ShouldUninstallOlderVersionsOfOffice,

        [Parameter()]
        [System.String]
        $TargetVersion,

        [Parameter()]
        [System.String]
        $UpdateVersion,

        [Parameter()]
        [System.Byte[]]
        $OfficeConfigurationXml,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        # [Parameter()]
        # [Microsoft.Management.Infrastructure.CimInstance]
        # $LargeIcon,

        #endregion

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters | Out-Null

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullResult = $PSBoundParameters
    $nullResult.Ensure = 'Absent'
    try
    {
        $instance = Get-MgBetaDeviceAppManagementMobileApp -MobileAppId $Id `
            -ExpandProperty "categories" `
            -ErrorAction SilentlyContinue

        if ($null -eq $instance)
        {
            Write-Verbose -Message "Could not find an Intune Windows Office Suite App with Id {$Id}."

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $instance = Get-MgBetaDeviceAppManagementMobileApp `
                    -Filter "(isof('microsoft.graph.officeSuiteApp') and displayName eq '$DisplayName')" `
                    -ErrorAction SilentlyContinue
            }

            if ($null -ne $instance)
            {
                $instance = Get-MgBetaDeviceAppManagementMobileApp -MobileAppId $instance.Id `
                    -ExpandProperty "categories" `
                    -ErrorAction SilentlyContinue
                $Id = $instance.Id
            }
        }

        if ($null -eq $instance)
        {
            Write-Verbose -Message "Could not find an Intune Windows Office Suite App with DisplayName {$DisplayName} was found."
            return $nullResult
        }

        Write-Verbose "An Intune Windows Office Suite App with Id {$Id} and DisplayName {$DisplayName} was found."

        #region complex types
        $complexCategories = @()
        foreach ($category in $instance.Categories)
        {
            $myCategory = @{}
            $myCategory.Add('Id', $category.id)
            $myCategory.Add('DisplayName', $category.displayName)
            $complexCategories += $myCategory
        }

        $complexExcludedApps = @{}
        if ($null -ne $instance.AdditionalProperties.excludedApps)
        {
            $instance.AdditionalProperties.excludedApps.GetEnumerator() | Foreach-Object {
                $complexExcludedApps.Add($_.Key, $_.Value)
            }
        }

        # $complexLargeIcon = @{}
        # if ($null -ne $instance.LargeIcon.Value)
        # {
        #     $complexLargeIcon.Add('Value', [System.Convert]::ToBase64String($instance.LargeIcon.Value))
        #     $complexLargeIcon.Add('Type', $instance.LargeIcon.Type)
        # }

        $results = @{
            Id                              = $instance.Id
            DisplayName                     = $instance.DisplayName
            Description                     = $instance.Description
            IsFeatured                      = $instance.IsFeatured
            PrivacyInformationUrl           = $instance.PrivacyInformationUrl
            InformationUrl                  = $instance.InformationUrl
            Notes                           = $instance.Notes
            RoleScopeTagIds                 = $instance.RoleScopeTagIds
            AutoAcceptEula                  = $instance.AdditionalProperties.autoAcceptEula
            ProductIds                      = $instance.AdditionalProperties.productIds
            UseSharedComputerActivation     = $instance.AdditionalProperties.useSharedComputerActivation
            UpdateChannel                   = $instance.AdditionalProperties.updateChannel
            OfficeSuiteAppDefaultFileFormat = $instance.AdditionalProperties.officeSuiteAppDefaultFileFormat
            OfficePlatformArchitecture      = $instance.AdditionalProperties.officePlatformArchitecture
            LocalesToInstall                = $instance.AdditionalProperties.localesToInstall
            InstallProgressDisplayLevel     = $instance.AdditionalProperties.installProgressDisplayLevel
            ShouldUninstallOlderVersionsOfOffice = $instance.AdditionalProperties.shouldUninstallOlderVersionsOfOffice
            TargetVersion                   = $instance.AdditionalProperties.targetVersion
            UpdateVersion                   = $instance.AdditionalProperties.updateVersion
            OfficeConfigurationXml          = $instance.AdditionalProperties.officeConfigurationXml
            # LargeIcon                       = $complexLargeIcon
            ExcludedApps                    = $complexExcludedApps
            Categories                      = $complexCategories
            Ensure                          = 'Present'
            Credential                      = $Credential
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            CertificateThumbprint           = $CertificateThumbprint
            ApplicationSecret               = $ApplicationSecret
            ManagedIdentity                 = $ManagedIdentity.IsPresent
            AccessTokens                    = $AccessTokens
        }

        #Assignments
        $resultAssignments = @()
        $appAssignments = Get-MgBetaDeviceAppManagementMobileAppAssignment -MobileAppId $instance.Id
        if ($null -ne $appAssignments -and $appAssignments.count -gt 0)
        {
            $convertedAssignments = ConvertFrom-IntuneMobileAppAssignment `
                                    -IncludeDeviceFilter:$true `
                                    -Assignments ($appAssignments)

            # Filter out 'source' from the assignment objects
            foreach ($assignment in $convertedAssignments) {
                if ($assignment.ContainsKey('source')) {
                    $assignment.Remove('source')
                }
            }

            $resultAssignments += $convertedAssignments
        }
        $results.Add('Assignments', $resultAssignments)
        return [System.Collections.Hashtable] $results
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
     param
    (
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.Boolean]
        $AutoAcceptEula,

        [Parameter()]
        [System.String[]]
        [ValidateSet('O365ProPlusRetail', 'O365BusinessRetail', 'VisioProRetail', 'ProjectProRetail')]
        $ProductIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExcludedApps,

        [Parameter()]
        [System.Boolean]
        $UseSharedComputerActivation,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Current', 'Deferred', 'FirstReleaseCurrent', 'FirstReleaseDeferred', 'MonthlyEnterprise')]
        $UpdateChannel,

        [Parameter()]
        [System.String]
        [ValidateSet('NotConfigured', 'OfficeOpenXMLFormat', 'OfficeOpenDocumentFormat', 'UnknownFutureValue')]
        $OfficeSuiteAppDefaultFileFormat,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'X86', 'X64', 'Arm', 'Neutral', 'Arm64')]
        $OfficePlatformArchitecture,

        [Parameter()]
        [System.String[]]
        $LocalesToInstall,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Full')]
        $InstallProgressDisplayLevel,

        [Parameter()]
        [System.Boolean]
        $ShouldUninstallOlderVersionsOfOffice,

        [Parameter()]
        [System.String]
        $TargetVersion,

        [Parameter()]
        [System.String]
        $UpdateVersion,

        [Parameter()]
        [System.Byte[]]
        $OfficeConfigurationXml,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        # [Parameter()]
        # [Microsoft.Management.Infrastructure.CimInstance]
        # $LargeIcon,

        #endregion

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentInstance = Get-TargetResource @PSBoundParameters
    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Windows Office Suite App with DisplayName {$DisplayName}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $CreateParameters = ([Hashtable]$BoundParameters).Clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $CreateParameters.Remove('Id') | Out-Null
        $CreateParameters.Remove('Categories') | Out-Null
        $CreateParameters.Add('Publisher', 'Microsoft')
        $CreateParameters.Add('Developer', 'Microsoft')
        $CreateParameters.Add('Owner', 'Microsoft')

        foreach ($key in ($CreateParameters.Clone()).Keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }

        $CreateParameters.Add('@odata.type', '#microsoft.graph.officeSuiteApp')
        $app = New-MgBetaDeviceAppManagementMobileApp -BodyParameter $CreateParameters

        foreach ($category in $Categories)
        {
            if ($category.Id)
            {
                $currentCategory = Get-MgBetaDeviceAppManagementMobileAppCategory -MobileAppCategoryId $category.Id
            }
            else
            {
                $currentCategory = Get-MgBetaDeviceAppManagementMobileAppCategory -Filter "displayName eq '$($category.DisplayName)'"
            }

            if ($null -eq $currentCategory)
            {
                throw "Mobile App Category with DisplayName $($category.DisplayName) not found."
            }

            Invoke-MgGraphRequest -Uri "/beta/deviceAppManagement/mobileApps/$($app.Id)/categories/`$ref" -Method 'POST' -Body @{
                '@odata.id' = "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppCategories/$($currentCategory.Id)"
            }
        }

        #Assignments
        if ($app.Id)
        {
            $assignmentsHash = ConvertTo-IntuneMobileAppAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
            Update-DeviceAppManagementPolicyAssignment -AppManagementPolicyId $app.Id `
                -Assignments $assignmentsHash
        }
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Host "Updating the Intune Windows Office Suite App with DisplayName {$DisplayName}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $UpdateParameters = ([Hashtable]$BoundParameters).Clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters
        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters.Remove('Categories') | Out-Null
        $UpdateParameters.Remove('OfficePlatformArchitecture') | Out-Null

        foreach ($key in ($UpdateParameters.Clone()).Keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }

        $UpdateParameters.Add('@odata.type', '#microsoft.graph.officeSuiteApp')
        Update-MgBetaDeviceAppManagementMobileApp -MobileAppId $currentInstance.Id -BodyParameter $UpdateParameters

        [array]$referenceObject = if ($null -ne $currentInstance.Categories.DisplayName) { $currentInstance.Categories.DisplayName } else { ,@() }
        [array]$differenceObject = if ($null -ne $Categories.DisplayName) { $Categories.DisplayName } else { ,@() }
        $delta = Compare-Object -ReferenceObject $referenceObject -DifferenceObject $differenceObject -PassThru
        foreach ($diff in $delta)
        {
            if ($diff.SideIndicator -eq '=>')
            {
                $category = $Categories | Where-Object { $_.DisplayName -eq $diff }
                if ($category.Id)
                {
                    $currentCategory = Get-MgBetaDeviceAppManagementMobileAppCategory -MobileAppCategoryId $category.Id
                }
                else
                {
                    $currentCategory = Get-MgBetaDeviceAppManagementMobileAppCategory -Filter "displayName eq '$($category.DisplayName)'"
                }

                if ($null -eq $currentCategory)
                {
                    throw "Mobile App Category with DisplayName $($category.DisplayName) not found."
                }

                Invoke-MgGraphRequest -Uri "/beta/deviceAppManagement/mobileApps/$($currentInstance.Id)/categories/`$ref" -Method 'POST' -Body @{
                    '@odata.id' = "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppCategories/$($currentCategory.Id)"
                }
            }
            else
            {
                $category = $currentInstance.Categories | Where-Object { $_.DisplayName -eq $diff }
                Invoke-MgGraphRequest -Uri "/beta/deviceAppManagement/mobileApps/$($currentInstance.Id)/categories/$($category.Id)/`$ref" -Method 'DELETE'
            }
        }

        #Assignments
        $assignmentsHash = ConvertTo-IntuneMobileAppAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceAppManagementPolicyAssignment -AppManagementPolicyId $currentInstance.Id `
            -Assignments $assignmentsHash
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Host "Remove the Intune Windows Office Suite App with Id {$($currentInstance.Id)}"
        Remove-MgBetaDeviceAppManagementMobileApp -MobileAppId $currentInstance.Id -Confirm:$false
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
     param
    (
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.Boolean]
        $AutoAcceptEula,

        [Parameter()]
        [System.String[]]
        [ValidateSet('O365ProPlusRetail', 'O365BusinessRetail', 'VisioProRetail', 'ProjectProRetail')]
        $ProductIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExcludedApps,

        [Parameter()]
        [System.Boolean]
        $UseSharedComputerActivation,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Current', 'Deferred', 'FirstReleaseCurrent', 'FirstReleaseDeferred', 'MonthlyEnterprise')]
        $UpdateChannel,

        [Parameter()]
        [System.String]
        [ValidateSet('NotConfigured', 'OfficeOpenXMLFormat', 'OfficeOpenDocumentFormat', 'UnknownFutureValue')]
        $OfficeSuiteAppDefaultFileFormat,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'X86', 'X64', 'Arm', 'Neutral', 'Arm64')]
        $OfficePlatformArchitecture,

        [Parameter()]
        [System.String[]]
        $LocalesToInstall,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Full')]
        $InstallProgressDisplayLevel,

        [Parameter()]
        [System.Boolean]
        $ShouldUninstallOlderVersionsOfOffice,

        [Parameter()]
        [System.String]
        $TargetVersion,

        [Parameter()]
        [System.String]
        $UpdateVersion,

        [Parameter()]
        [System.Byte[]]
        $OfficeConfigurationXml,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        # [Parameter()]
        # [Microsoft.Management.Infrastructure.CimInstance]
        # $LargeIcon,

        #endregion

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of the Intune Windows Suite App with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($null -ne $source -and $source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    # Prevent screen from filling up with the LargeIcon value
    # Comparison will already be done because it's a CimInstance
    # $CurrentValues.Remove('LargeIcon') | Out-Null
    # $PSBoundParameters.Remove('LargeIcon') | Out-Null

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck.Remove('OfficePlatformArchitecture') | Out-Null # Cannot be changed after creation
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    if ($testResult)
    {
        $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        $Script:ExportMode = $true
        [array] $Script:getInstances = Get-MgBetaDeviceAppManagementMobileApp `
            -Filter "isof('microsoft.graph.officeSuiteApp')" `
            -ErrorAction Stop

        $i = 1
        $dscContent = ''
        if ($Script:getInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }

        foreach ($config in $Script:getInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Id
            Write-Host "    |---[$i/$($Script:getInstances.Count)] $displayedKey" -NoNewline

            $params = @{
                Id                    = $config.Id
                DisplayName           = $config.DisplayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ApplicationSecret     = $ApplicationSecret
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            #region complex types
            if ($null -ne $Results.Categories)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Categories `
                    -CIMInstanceName 'DeviceManagementMobileAppCategory'

                if (-not [System.String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Categories = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Categories') | Out-Null
                }
            }

            if ($null -ne $Results.ExcludedApps)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ExcludedApps `
                    -CIMInstanceName 'DeviceManagementMobileAppExcludedApp'

                if (-not [System.String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ExcludedApps = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ExcludedApps') | Out-Null
                }
            }

            # if ($null -ne $Results.LargeIcon)
            # {
            #     $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
            #         -ComplexObject $Results.LargeIcon `
            #         -CIMInstanceName 'DeviceManagementMimeContent'

            #     if (-not [System.String]::IsNullOrWhiteSpace($complexTypeStringResult))
            #     {
            #         $Results.LargeIcon = $complexTypeStringResult
            #     }
            #     else
            #     {
            #         $Results.Remove('LargeIcon') | Out-Null
            #     }
            # }

            if ($null -ne $Results.Assignments)
            {
                if ($Results.Assignments)
                {
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.Assignments `
                        -CIMInstanceName DeviceManagementMobileAppAssignment

                    if ($complexTypeStringResult)
                    {
                        $Results.Assignments = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('Assignments') | Out-Null
                    }
                }
            }
            #endregion complex types

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            #region complex types
            if ($null -ne $Results.Categories)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Categories' -IsCIMArray:$true
            }

            if ($null -ne $Results.ExcludedApps)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ExcludedApps' -IsCIMArray:$false
            }

            # if ($null -ne $Results.LargeIcon)
            # {
            #     $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'LargeIcon' -IsCIMArray:$false
            # }

            if ($null -ne $Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
            }
            #endregion complex types

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }

        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

Export-ModuleMember -Function *-TargetResource
