function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune resource parameters

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $Developer,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $Publisher,

        [Parameter()]
        [System.String]
        [ValidateSet('notPublished', 'processing','published')]
        $PublishingState,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $LargeIcon,

        [Parameter()]
        [System.String]
        $AppUrl,

        [Parameter()]
        [System.Int32]
        $SupersededAppCount,

        [Parameter()]
        [System.Int32]
        $SupersedingAppCount,

        [Parameter()]
        [System.Int32]
        $DependentAppCount,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Int32]
        $UploadState,

        [Parameter()]
        [System.DateTime]
        $CreatedDateTime,

        [Parameter()]
        [System.DateTime]
        $LastModifiedDateTime,

        [Parameter()]
        [System.Boolean]
        $UseManagedBrowser,

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
        $instance = Get-MgBetaDeviceAppManagementMobileApp `
            -Filter "(isof('microsoft.graph.webApp') and displayName eq '$DisplayName')" `
            -ExpandProperty "categories,assignments" `
            -ErrorAction SilentlyContinue | Where-Object `
            -FilterScript { $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.webApp' }

        if ($null -eq $instance)
        {
            Write-Verbose -Message "No Mobile app with DisplayName {$DisplayName} was found. Search with DisplayName."
            $instance = Get-MgBetaDeviceAppManagementMobileApp `
                -MobileAppId $Id `
                -ExpandProperty "categories,assignments" `
                -ErrorAction Stop | Where-Object `
                -FilterScript { $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.webApp' }
        }

        if ($null -eq $instance)
        {
            Write-Verbose -Message "No Mobile app with {$Id} was found."
            return $nullResult
        }

        $results = @{
            Id                    = $instance.Id
            Description           = $instance.Description
            Developer             = $instance.Developer
            DisplayName           = $instance.DisplayName
            InformationUrl        = $instance.InformationUrl
            IsFeatured            = $instance.IsFeatured
            Notes                 = $instance.Notes
            Owner                 = $instance.Owner
            PrivacyInformationUrl = $instance.PrivacyInformationUrl
            Publisher             = $instance.Publisher
            PublishingState       = $instance.PublishingState.ToString()
            RoleScopeTagIds       = $instance.RoleScopeTagIds
            AppUrl                = $instance.AppUrl
            SupersededAppCount    = $instance.SupersededAppCount
            SupersedingAppCount   = $instance.SupersedingAppCount
            DependentAppCount     = $instance.DependentAppCount
            IsAssigned            = $instance.IsAssigned
            UploadState           = $instance.UploadState
            CreatedDateTime       = $instance.CreatedDateTime
            LastModifiedDateTime  = $instance.LastModifiedDateTime
            UseManagedBrowser     = $instance.UseManagedBrowser

            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ApplicationSecret     = $ApplicationSecret
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }

        #region complex types

        #Categories
        if($null -ne $instance.Categories)
        {
            $results.Add('Categories', $instance.Categories)
        }
        else {
            $results.Add('Categories', "")
        }

        #Assignments
        $resultAssignments = @()
        $appAssignments = Get-MgBetaDeviceAppManagementMobileAppAssignment -MobileAppId $instance.Id
        if ($null -ne $appAssignments -and $appAssignments.count -gt 0)
        {
            $resultAssignments += ConvertFrom-IntuneMobileAppAssignment `
                                -IncludeDeviceFilter:$true `
                                -Assignments ($appAssignments)

            $results.Add('Assignments', $resultAssignments)
        }

        #LargeIcon
        # The large is returned only when Get cmdlet is called with Id parameter. The large icon is a base64 encoded string, so we need to convert it to a byte array.
        $instanceWithLargeIcon = Get-MgBetaDeviceAppManagementMobileApp -MobileAppId $instance.Id
        if($null -ne $instanceWithLargeIcon.LargeIcon)
        {
            $results.Add('LargeIcon', $instanceWithLargeIcon.LargeIcon)
        }
        else {
            $results.Add('LargeIcon', "")
        }

        #end region complex types

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
        [System.String]
        $Developer,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $Publisher,

        [Parameter()]
        [System.String]
        [ValidateSet('notPublished', 'processing','published')]
        $PublishingState,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $LargeIcon,

        [Parameter()]
        [System.String]
        $AppUrl,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Boolean]
        $useManagedBrowser,

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
    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null
    $PSBoundParameters.Remove('ManagedIdentity') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    $CreateParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Host "Create web app: $DisplayName"

        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters

        $AdditionalProperties = Get-M365DSCIntuneMobileWebAppAdditionalProperties -Properties ($CreateParameters)
        foreach ($key in $AdditionalProperties.keys)
        {
            if ($key -ne '@odata.type')
            {
                $keyName = $key.substring(0, 1).ToUpper() + $key.substring(1, $key.length - 1)
                $CreateParameters.remove($keyName)
            }
        }

        $CreateParameters.remove('Id') | Out-Null
        $CreateParameters.remove('Ensure') | Out-Null
        $CreateParameters.remove('Categories') | Out-Null
        $CreateParameters.remove('Assignments') | Out-Null
        $CreateParameters.remove('childApps') | Out-Null
        $CreateParameters.remove('IgnoreVersionDetection') | Out-Null
        $CreateParameters.Remove('Verbose') | Out-Null
        $CreateParameters.Remove('PublishingState') | Out-Null #Not allowed to update as it's a computed property
        $CreateParameters.Remove('LargeIcon') | Out-Null

        foreach ($key in ($CreateParameters.clone()).Keys)
        {
            if ($CreateParameters[$key].getType().Fullname -like '*CimInstance*')
            {
                $CreateParameters[$key] = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters[$key]
            }
        }

        if ($AdditionalProperties)
        {
            $CreateParameters.add('AdditionalProperties', $AdditionalProperties)
        }

        #LargeIcon
        if($LargeIcon)
        {
            [System.Object]$LargeIconValue = ConvertTo-M365DSCIntuneAppLargeIcon -LargeIcon $LargeIcon
            $CreateParameters.Add('LargeIcon', $LargeIconValue)
        }

        $app = New-MgBetaDeviceAppManagementMobileApp @CreateParameters

        #Assignments
        $assignmentsHash = ConvertTo-IntuneMobileAppAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        if ($app.id)
        {
            Update-MgBetaDeviceAppManagementMobileAppAssignment -MobileAppId $app.id `
                -Target $assignmentsHash `
                -Repository 'deviceAppManagement/mobileAppAssignments'
        }
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Host "Update web app: $DisplayName"

        $PSBoundParameters.Remove('Assignments') | Out-Null
        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters

        $AdditionalProperties = Get-M365DSCIntuneMobileWebAppAdditionalProperties -Properties ($UpdateParameters)
        foreach ($key in $AdditionalProperties.keys)
        {
            if ($key -ne '@odata.type')
            {
                $keyName = $key.substring(0, 1).ToUpper() + $key.substring(1, $key.length - 1)
                #Remove additional keys, so that later they can be added as 'AdditionalProperties'
                $UpdateParameters.Remove($keyName)
            }
        }

        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters.Remove('Verbose') | Out-Null
        $UpdateParameters.Remove('Categories') | Out-Null
        $UpdateParameters.Remove('PublishingState') | Out-Null #Not allowed to update as it's a computed property

        foreach ($key in ($UpdateParameters.clone()).Keys)
        {
            if ($UpdateParameters[$key].getType().Fullname -like '*CimInstance*')
            {
                $value = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters[$key]
                $UpdateParameters[$key] = $value
            }
        }

        if ($AdditionalProperties)
        {
            $UpdateParameters.Add('AdditionalProperties', $AdditionalProperties)
        }

         #LargeIcon
         if($LargeIcon)
         {
             [System.Object]$LargeIconValue = ConvertTo-M365DSCIntuneAppLargeIcon -LargeIcon $LargeIcon
             $UpdateParameters.Add('LargeIcon', $LargeIconValue)
         }

        Update-MgBetaDeviceAppManagementMobileApp -MobileAppId $currentInstance.Id @UpdateParameters
        Write-Host "Updated web App: $DisplayName."

        #Assignments
        $assignmentsHash = ConvertTo-IntuneMobileAppAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-MgBetaDeviceAppManagementMobileAppAssignment -MobileAppId $currentInstance.id `
            -Target $assignmentsHash `
            -Repository 'deviceAppManagement/mobileAppAssignments'
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Host "Remove web app: $DisplayName"
        Remove-MgBetaDeviceAppManagementMobileApp -MobileAppId $currentInstance.Id -Confirm:$false
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource parameters

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
        [System.String]
        $Developer,

        [Parameter()]
        [System.String]
        $InformationUrl,

        [Parameter()]
        [System.Boolean]
        $IsFeatured,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter()]
        [System.String]
        $PrivacyInformationUrl,

        [Parameter()]
        [System.String]
        $Publisher,

        [Parameter()]
        [System.String]
        [ValidateSet('notPublished', 'processing','published')]
        $PublishingState,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Categories,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $LargeIcon,

        [Parameter()]
        [System.String]
        $AppUrl,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Boolean]
        $useManagedBrowser

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

    Write-Verbose -Message "Testing configuration of Intune Mobile web App: {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $CurrentValues))
    {
        Write-Verbose "An error occured in Get-TargetResource, the app {$displayName} will not be processed"
        throw "An error occured in Get-TargetResource, the app {$displayName} will not be processed. Refer to the event viewer logs for more information."
    }
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck
    $ValuesToCheck.Remove('Id') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

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
        if ($source.getType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

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
            -Filter "isof('microsoft.graph.webApp')" `
            -ExpandProperty "categories,assignments" `
            -ErrorAction Stop | Where-Object `
            -FilterScript { $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.webApp' }

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

            if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $Results))
            {
                Write-Verbose "An error occured in Get-TargetResource, the app {$($params.displayName)} will not be processed."
                throw "An error occured in Get-TargetResource, the app {$($params.displayName)} will not be processed. Refer to the event viewer logs for more information."
            }

            #region complex types

            #Categories
            if($null -ne $Results.Categories)
            {
                $Results.Categories = Get-M365DSCIntuneAppCategoriesAsString -Categories $Results.Categories
            }
            else {
                $Results.Remove('Categories') | Out-Null
            }

            #ChildApps
            if($null -ne $Results.childApps)
            {
                $Results.childApps = Get-M365DSCIntuneAppChildAppsAsString -ChildApps $Results.childApps
            }
            else {
                $Results.Remove('childApps') | Out-Null
            }

            #Assignments
            if ($null -ne $Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.Assignments) -CIMInstanceName DeviceManagementMobileAppAssignment

                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }

            #LargeIcon
            if($null -ne $Results.LargeIcon)
            {
                $Results.LargeIcon = Get-M365DSCIntuneAppLargeIconAsString -LargeIcon $Results.LargeIcon
            }
            else
            {
                $Results.Remove('LargeIcon') | Out-Null
            }

            #endregion complex types

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            #region complex types

            #Categories
            if ($null -ne $Results.Categories)
            {
                $isCIMArray = $false
                if ($Results.Categories.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }

                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Categories' -IsCIMArray:$isCIMArray
            }

            #ChildApps
            if ($null -ne $Results.childApps)
            {
                $isCIMArray = $false
                if ($Results.childApps.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }

                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ChildApps' -IsCIMArray:$isCIMArray
            }

            #Assignments
            if ($null -ne $Results.Assignments)
            {
                $isCIMArray = $false
                if ($Results.Assignments.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }

                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$isCIMArray
            }

            #LargeIcon
            if ($null -ne $Results.LargeIcon)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'LargeIcon' -IsCIMArray:$false
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

#region Helper functions

function Get-M365DSCIntuneAppCategoriesAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $Categories
    )

    $StringContent = '@('
    $space = '                '
    $indent = '    '

    $i = 1
    foreach ($category in $Categories)
    {
        if ($Categories.Count -gt 1)
        {
            $StringContent += "`r`n"
            $StringContent += "$space"
        }

        #Only export the displayName, not Id
        $StringContent += "MSFT_DeviceManagementMobileAppCategory { `r`n"
        $StringContent += "$($space)$($indent)displayName = '" + $category.displayName + "'`r`n"
        $StringContent += "$space}"

        $i++
    }

    $StringContent += ')'

    return $StringContent
}

function Get-M365DSCIntuneMobileWebAppAdditionalProperties
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $Properties
    )

    $additionalProperties = @(
        'AppUrl'
        'SupersededAppCount'
        'SupersedingAppCount'
        'DependentAppCount'
        'IsAssigned'
        'UploadState'
        'CreatedDateTime'
        'LastModifiedDateTime'
        'UseManagedBrowser'
    )

    $results = @{'@odata.type' = '#microsoft.graph.webApp' }
    $cloneProperties = $Properties.clone()
    foreach ($property in $cloneProperties.Keys)
    {
        if ($property -in $additionalProperties)
        {
            $propertyName = $property[0].ToString().ToLower() + $property.Substring(1, $property.Length - 1)
            if ($properties.$property -and $properties.$property.getType().FullName -like '*CIMInstance*')
            {
                if ($properties.$property.getType().FullName -like '*[[\]]')
                {
                    $array = @()
                    foreach ($item in $properties.$property)
                    {
                        $array += Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $item

                    }
                    $propertyValue = $array
                }
                else
                {
                    $propertyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $properties.$property
                }

            }
            else
            {
                $propertyValue = $properties.$property
            }

            $results.Add($propertyName, $propertyValue)
        }
    }

    if ($results.Count -eq 1)
    {
        return $null
    }
    return $results
}

function Get-M365DSCIntuneAppLargeIconAsString #Get and Export
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Object]
        $LargeIcon
    )

     $space = '                '
     $indent = '    '

    if ($null -ne $LargeIcon.Value)
    {
        $StringContent += "`r`n"
        $StringContent += "$space"

        $base64String = [System.Convert]::ToBase64String($LargeIcon.Value) # This exports the base64 string (blob) of the byte array, same as we see in Graph API response

        $StringContent += "MSFT_DeviceManagementMimeContent { `r`n"
        $StringContent += "$($space)$($indent)type  = '" + $LargeIcon.Type + "'`r`n"
        $StringContent += "$($space)$($indent)value = '" + $base64String + "'`r`n"
        $StringContent += "$space}"
    }

    return $StringContent
 }

function ConvertTo-M365DSCIntuneAppLargeIcon #set
{
    [OutputType([System.Object])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Object]
        $LargeIcon
    )

    $result = @{
        type  = $LargeIcon.Type
        value = $iconValue
    }

    return $result
}

#endregion Helper functions

Export-ModuleMember -Function *-TargetResource
