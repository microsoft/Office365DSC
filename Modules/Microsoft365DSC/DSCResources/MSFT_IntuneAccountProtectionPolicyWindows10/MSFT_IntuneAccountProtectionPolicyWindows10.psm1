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
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

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

        if ($PSBoundParameters.ContainsKey('Id'))
        {
            Write-Verbose -Message 'PolicyID was specified'
            try
            {
                $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Id -ErrorAction Stop
            }
            catch
            {
                Write-Verbose -Message "No Account Protection Policy for Windows10 with Id {$Id} was found"
                $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -All -Filter "Name eq '$DisplayName'"
                if ($getValue.Length -gt 1)
                {
                    throw "Duplicate Intune Account Protection Policy for Windows10 named $DisplayName exist in tenant"
                }
            }
        }
        else
        {
            Write-Verbose -Message 'Id was NOT specified'
            ## Can retreive multiple Intune Policies since displayname is not unique
            $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -All -Filter "Name eq '$DisplayName'"
            if ($getValue.Length -gt 1)
            {
                throw "Duplicate Intune Account Protection Policy for Windows10 named $DisplayName exist in tenant"
            }
        }

        if ([String]::IsNullOrEmpty($getValue.Id))
        {
            Write-Verbose -Message "No Account Protection Policy for Windows10 with Name {$DisplayName} were found"
            $currentValues = $PSBoundParameters
            $currentValues.Ensure = 'Absent'
            return $currentValues
        }

        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Account Protection Policy for Windows10 with Id {$Id} and Name {$DisplayName} was found"

        # Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementConfigurationPolicySetting `
            -DeviceManagementConfigurationPolicyId $Id `
            -ExpandProperty 'settingDefinitions' `
            -ErrorAction Stop

        $policySettings = @{}
        $policySettings = Export-IntuneSettingCatalogPolicySettings -Settings $settings -ReturnHashtable $policySettings -ContainsDeviceAndUserSettings

        #region resource generator code
        $complexDeviceSettings = @{}
        if ($null -ne $policySettings.deviceSettings.lsaCfgFlags)
        {
            $complexDeviceSettings.Add('LsaCfgFlags', $policySettings.deviceSettings.lsaCfgFlags)
        }
        if ($null -ne $policySettings.deviceSettings.facialFeaturesUseEnhancedAntiSpoofing)
        {
            $complexDeviceSettings.Add('FacialFeaturesUseEnhancedAntiSpoofing', $policySettings.deviceSettings.facialFeaturesUseEnhancedAntiSpoofing)
        }
        if ($null -ne $policySettings.deviceSettings.enablePinRecovery)
        {
            $complexDeviceSettings.Add('EnablePinRecovery', $policySettings.deviceSettings.enablePinRecovery)
        }
        if ($null -ne $policySettings.deviceSettings.expiration)
        {
            $complexDeviceSettings.Add('Expiration', $policySettings.deviceSettings.expiration)
        }
        if ($null -ne $policySettings.deviceSettings.history)
        {
            $complexDeviceSettings.Add('History', $policySettings.deviceSettings.history)
        }
        if ($null -ne $policySettings.deviceSettings.lowercaseLetters)
        {
            $complexDeviceSettings.Add('LowercaseLetters', $policySettings.deviceSettings.lowercaseLetters)
        }
        if ($null -ne $policySettings.deviceSettings.maximumPINLength)
        {
            $complexDeviceSettings.Add('MaximumPINLength', $policySettings.deviceSettings.maximumPINLength)
        }
        if ($null -ne $policySettings.deviceSettings.minimumPINLength)
        {
            $complexDeviceSettings.Add('MinimumPINLength', $policySettings.deviceSettings.minimumPINLength)
        }
        if ($null -ne $policySettings.deviceSettings.specialCharacters)
        {
            $complexDeviceSettings.Add('SpecialCharacters', $policySettings.deviceSettings.specialCharacters)
        }
        if ($null -ne $policySettings.deviceSettings.uppercaseLetters)
        {
            $complexDeviceSettings.Add('UppercaseLetters', $policySettings.deviceSettings.uppercaseLetters)
        }
        if ($null -ne $policySettings.deviceSettings.requireSecurityDevice)
        {
            $complexDeviceSettings.Add('RequireSecurityDevice', $policySettings.deviceSettings.requireSecurityDevice)
        }
        if ($null -ne $policySettings.deviceSettings.useCertificateForOnPremAuth)
        {
            $complexDeviceSettings.Add('UseCertificateForOnPremAuth', $policySettings.deviceSettings.useCertificateForOnPremAuth)
        }
        if ($null -ne $policySettings.deviceSettings.usePassportForWork)
        {
            $complexDeviceSettings.Add('UsePassportForWork', $policySettings.deviceSettings.usePassportForWork)
        }
        if ($complexDeviceSettings.Values.Where({ $_ -ne $null }).Count -eq 0)
        {
            $complexDeviceSettings = $null
        }

        $complexUserSettings = @{}
        if ($null -ne $policySettings.userSettings.enablePinRecovery)
        {
            $complexUserSettings.Add('EnablePinRecovery', $policySettings.userSettings.enablePinRecovery)
        }
        if ($null -ne $policySettings.userSettings.expiration)
        {
            $complexUserSettings.Add('Expiration', $policySettings.userSettings.expiration)
        }
        if ($null -ne $policySettings.userSettings.history)
        {
            $complexUserSettings.Add('History', $policySettings.userSettings.history)
        }
        if ($null -ne $policySettings.userSettings.lowercaseLetters)
        {
            $complexUserSettings.Add('LowercaseLetters', $policySettings.userSettings.lowercaseLetters)
        }
        if ($null -ne $policySettings.userSettings.maximumPINLength)
        {
            $complexUserSettings.Add('MaximumPINLength', $policySettings.userSettings.maximumPINLength)
        }
        if ($null -ne $policySettings.userSettings.minimumPINLength)
        {
            $complexUserSettings.Add('MinimumPINLength', $policySettings.userSettings.minimumPINLength)
        }
        if ($null -ne $policySettings.userSettings.specialCharacters)
        {
            $complexUserSettings.Add('SpecialCharacters', $policySettings.userSettings.specialCharacters)
        }
        if ($null -ne $policySettings.userSettings.uppercaseLetters)
        {
            $complexUserSettings.Add('UppercaseLetters', $policySettings.userSettings.uppercaseLetters)
        }
        if ($null -ne $policySettings.userSettings.requireSecurityDevice)
        {
            $complexUserSettings.Add('RequireSecurityDevice', $policySettings.userSettings.requireSecurityDevice)
        }
        if ($null -ne $policySettings.userSettings.usePassportForWork)
        {
            $complexUserSettings.Add('UsePassportForWork', $policySettings.userSettings.usePassportForWork)
        }
        if ($complexUserSettings.Values.Where({ $_ -ne $null }).Count -eq 0)
        {
            $complexUserSettings = $null
        }

        $policySettings.Remove('deviceSettings') | Out-Null
        $policySettings.Remove('userSettings') | Out-Null
        #endregion

        $results = @{
            #region resource generator code
            Description           = $getValue.Description
            DisplayName           = $getValue.Name
            RoleScopeTagIds       = $getValue.RoleScopeTagIds
            Id                    = $getValue.Id
            DeviceSettings        = $complexDeviceSettings
            UserSettings          = $complexUserSettings
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
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

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

    $templateReferenceId = 'fcef01f2-439d-4c3f-9184-823fd6e97646_1'
    $platforms = 'windows10'
    $technologies = 'mdm'

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Account Protection Policy for Windows10 with Name {$DisplayName}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId `
            -ContainsDeviceAndUserSettings

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
        Write-Verbose -Message "Updating the Intune Account Protection Policy for Windows10 with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId `
            -ContainsDeviceAndUserSettings

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
        Write-Verbose -Message "Removing the Intune Account Protection Policy for Windows10 with Id {$($currentInstance.Id)}"
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
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

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

    Write-Verbose -Message "Testing configuration of the Intune Account Protection Policy for Windows10 with Id {$Id} and Name {$DisplayName}"

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
        $policyTemplateID = 'fcef01f2-439d-4c3f-9184-823fd6e97646_1'
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
                Id                    = $config.Id
                DisplayName           = $config.Name
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($null -ne $Results.DeviceSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.DeviceSettings `
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.DeviceSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('DeviceSettings') | Out-Null
                }
            }
            if ($null -ne $Results.UserSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.UserSettings `
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.UserSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('UserSettings') | Out-Null
                }
            }

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
            if ($Results.DeviceSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'DeviceSettings' -IsCIMArray:$True
            }
            if ($Results.UserSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'UserSettings' -IsCIMArray:$True
            }

            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
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
