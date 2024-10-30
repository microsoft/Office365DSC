function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $AllowWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $ClipboardSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $SaveFilesToHost,

        [Parameter()]
        [ValidateSet('install')]
        [System.String]
        $InstallWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('1', '2', '3')]
        [System.String]
        $ClipboardFileType,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowPersistence,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowVirtualGPU,

        [Parameter()]
        [ValidateSet('0', '1', '2', '4', '8')]
        [System.Int32[]]
        $PrintingSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCameraMicrophoneRedirection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AuditApplicationGuard,

        [Parameter()]
        [System.String[]]
        $CertificateThumbprints,

        [Parameter()]
        [System.String[]]
        $EnterpriseIPRange,

        [Parameter()]
        [System.String[]]
        $EnterpriseCloudResources,

        [Parameter()]
        [System.String[]]
        $EnterpriseNetworkDomainNames,

        [Parameter()]
        [System.String[]]
        $EnterpriseProxyServers,

        [Parameter()]
        [System.String[]]
        $EnterpriseInternalProxyServers,

        [Parameter()]
        [System.String[]]
        $NeutralResources,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseProxyServersAreAuthoritative,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseIPRangesAreAuthoritative,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
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

        $nullResult = $PSBoundParameters
        $nullResult.Ensure = 'Absent'

        $getValue = $null
        #region resource generator code
        $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune App And Browser Isolation Policy for Windows10 Config Mgr with Id {$Id}"

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementConfigurationPolicy `
                    -Filter "Name eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune App And Browser Isolation Policy for Windows10 Config Mgr with Name {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune App And Browser Isolation Policy for Windows10 Config Mgr with Id {$Id} and Name {$DisplayName} was found"

        # Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementConfigurationPolicySetting `
            -DeviceManagementConfigurationPolicyId $Id `
            -ExpandProperty 'settingDefinitions' `
            -ErrorAction Stop

        $policySettings = @{}
        $policySettings = Export-IntuneSettingCatalogPolicySettings -Settings $settings -ReturnHashtable $policySettings

        $results = @{
            #region resource generator code
            Description           = $getValue.Description
            DisplayName           = $getValue.Name
            RoleScopeTagIds       = $getValue.RoleScopeTagIds
            Id                    = $getValue.Id
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            #endregion
        }
        $results += $policySettings

        $assignmentsValues = Get-MgBetaDeviceManagementConfigurationPolicyAssignment -DeviceManagementConfigurationPolicyId $Id
        $assignmentResult = @()
        if ($assignmentsValues.Count -gt 0)
        {
            $assignmentResult += ConvertFrom-IntunePolicyAssignment -Assignments $assignmentsValues -IncludeDeviceFilter $true
        }
        $results.Add('Assignments', $assignmentResult)

        return [System.Collections.Hashtable] $results
    }
    catch
    {
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
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $AllowWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $ClipboardSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $SaveFilesToHost,

        [Parameter()]
        [ValidateSet('install')]
        [System.String]
        $InstallWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('1', '2', '3')]
        [System.String]
        $ClipboardFileType,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowPersistence,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowVirtualGPU,

        [Parameter()]
        [ValidateSet('0', '1', '2', '4', '8')]
        [System.Int32[]]
        $PrintingSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCameraMicrophoneRedirection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AuditApplicationGuard,

        [Parameter()]
        [System.String[]]
        $CertificateThumbprints,

        [Parameter()]
        [System.String[]]
        $EnterpriseIPRange,

        [Parameter()]
        [System.String[]]
        $EnterpriseCloudResources,

        [Parameter()]
        [System.String[]]
        $EnterpriseNetworkDomainNames,

        [Parameter()]
        [System.String[]]
        $EnterpriseProxyServers,

        [Parameter()]
        [System.String[]]
        $EnterpriseInternalProxyServers,

        [Parameter()]
        [System.String[]]
        $NeutralResources,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseProxyServersAreAuthoritative,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseIPRangesAreAuthoritative,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion
        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

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

    $templateReferenceId = 'e373ebb7-c1c5-4ffb-9ce0-698f1834fd9d_1'
    $platforms = 'windows10'
    $technologies = 'configManager'

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune App And Browser Isolation Policy for Windows10 Config Mgr with Name {$DisplayName}"
        $BoundParameters.Remove("Assignments") | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId

        $createParameters = @{
            Name              = $DisplayName
            Description       = $Description
            TemplateReference = @{ templateId = $templateReferenceId }
            Platforms         = $platforms
            Technologies      = $technologies
            Settings          = $settings
        }

        #region resource generator code
        $policy = New-MgBetaDeviceManagementConfigurationPolicy -BodyParameter $createParameters

        if ($policy.Id)
        {
            $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
            Update-DeviceConfigurationPolicyAssignment `
                -DeviceConfigurationPolicyId $policy.Id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/configurationPolicies'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune App And Browser Isolation Policy for Windows10 Config Mgr with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove("Assignments") | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId

        Update-IntuneDeviceConfigurationPolicy `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Name $DisplayName `
            -Description $Description `
            -TemplateReferenceId $templateReferenceId `
            -Platforms $platforms `
            -Technologies $technologies `
            -Settings $settings

        #region resource generator code
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/configurationPolicies'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune App And Browser Isolation Policy for Windows10 Config Mgr with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $AllowWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $ClipboardSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $SaveFilesToHost,

        [Parameter()]
        [ValidateSet('install')]
        [System.String]
        $InstallWindowsDefenderApplicationGuard,

        [Parameter()]
        [ValidateSet('1', '2', '3')]
        [System.String]
        $ClipboardFileType,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowPersistence,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowVirtualGPU,

        [Parameter()]
        [ValidateSet('0', '1', '2', '4', '8')]
        [System.Int32[]]
        $PrintingSettings,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCameraMicrophoneRedirection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AuditApplicationGuard,

        [Parameter()]
        [System.String[]]
        $CertificateThumbprints,

        [Parameter()]
        [System.String[]]
        $EnterpriseIPRange,

        [Parameter()]
        [System.String[]]
        $EnterpriseCloudResources,

        [Parameter()]
        [System.String[]]
        $EnterpriseNetworkDomainNames,

        [Parameter()]
        [System.String[]]
        $EnterpriseProxyServers,

        [Parameter()]
        [System.String[]]
        $EnterpriseInternalProxyServers,

        [Parameter()]
        [System.String[]]
        $NeutralResources,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseProxyServersAreAuthoritative,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $EnterpriseIPRangesAreAuthoritative,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

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

    Write-Verbose -Message "Testing configuration of the Intune App And Browser Isolation Policy for Windows10 Config Mgr with Id {$Id} and Name {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    [Hashtable]$ValuesToCheck = @{}
    $MyInvocation.MyCommand.Parameters.GetEnumerator() | ForEach-Object {
        if ($_.Key -notlike '*Variable' -or $_.Key -notin @('Verbose', 'Debug', 'ErrorAction', 'WarningAction', 'InformationAction'))
        {
            if ($null -ne $CurrentValues[$_.Key] -or $null -ne $PSBoundParameters[$_.Key])
            {
                $ValuesToCheck.Add($_.Key, $null)
                if (-not $PSBoundParameters.ContainsKey($_.Key))
                {
                    $PSBoundParameters.Add($_.Key, $null)
                }
            }
        }
    }

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

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

    Write-Verbose -Message "Test-TargetResource returned $testResult"

    return $testResult
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

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
        #region resource generator code
        $policyTemplateID = "e373ebb7-c1c5-4ffb-9ce0-698f1834fd9d_1"
        [array]$getValue = Get-MgBetaDeviceManagementConfigurationPolicy `
            -Filter $Filter `
            -All `
            -ErrorAction Stop | Where-Object `
            -FilterScript {
                $_.TemplateReference.TemplateId -eq $policyTemplateID
            }
        #endregion

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            elseif (-not [string]::IsNullOrEmpty($config.name))
            {
                $displayedKey = $config.name
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                DisplayName = $config.Name
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity = $ManagedIdentity.IsPresent
                AccessTokens = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Assignments -CIMInstanceName DeviceManagementConfigurationPolicyAssignments
                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Assignments" -IsCIMArray:$true
            }

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
