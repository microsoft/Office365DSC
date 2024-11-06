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
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [ValidateRange(1, 12)]
        [System.Int32]
        $PersonalRecoveryKeyRotationInMonths,

        [Parameter()]
        [System.Boolean]
        $DisablePromptAtSignOut,

        [Parameter()]
        [ValidateSet('personalRecoveryKey')]
        [System.String[]]
        $SelectedRecoveryKeyTypes,

        [Parameter()]
        [System.Boolean]
        $AllowDeferralUntilSignOut,

        [Parameter()]
        [ValidateRange(-1, 11)]
        [System.Int32]
        $NumberOfTimesUserCanIgnore,

        [Parameter()]
        [System.Boolean]
        $HidePersonalRecoveryKey,

        [Parameter()]
        [System.String]
        $PersonalRecoveryKeyHelpMessage,

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
        $getValue = Get-MgBetaDeviceManagementIntent -DeviceManagementIntentId $Id -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Disk Encryption for macOS with Id {$Id}"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementIntent `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue | Where-Object `
                    -FilterScript { `
                        $_.TemplateId -eq 'a239407c-698d-4ef8-b314-e3ae409204b8' `
                    }
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Disk Encryption for macOS with DisplayName {$DisplayName}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Disk Encryption for macOS with Id {$Id} and DisplayName {$DisplayName} was found."

        #Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementIntentSetting `
            -DeviceManagementIntentId $getValue.Id `
            -ErrorAction Stop

        $results = @{
            Description                      = $getValue.Description
            DisplayName                      = $getValue.DisplayName
            RoleScopeTagIds                  = $getValue.RoleScopeTagIds
            Id                               = $getValue.Id
        }

        foreach ($setting in $settings)
        {
            $settingName = $setting.definitionId.replace('deviceConfiguration--macOSEndpointProtectionConfiguration_fileVault', '')
            $settingValue = $setting.ValueJson | ConvertFrom-Json

            $results.Add($settingName, $settingValue)
        }

        $results.Add('Ensure', 'Present')
        $results.Add('Credential', $Credential)
        $results.Add('ApplicationId', $ApplicationId)
        $results.Add('TenantId', $TenantId)
        $results.Add('ApplicationSecret', $ApplicationSecret)
        $results.Add('CertificateThumbprint', $CertificateThumbprint)
        $results.Add('ManagedIdentity', $ManagedIdentity.IsPresent)
        $results.Add('AccessTokens', $AccessTokens)

        $assignmentsValues = Get-MgBetaDeviceManagementIntentAssignment -DeviceManagementIntentId $Id
        $assignmentResult = @()
        if ($assignmentsValues.Count -gt 0)
        {
            $assignmentResult += ConvertFrom-IntunePolicyAssignment `
                                -IncludeDeviceFilter:$true `
                                -Assignments ($assignmentsValues)
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
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [ValidateRange(1, 12)]
        [System.Int32]
        $PersonalRecoveryKeyRotationInMonths,

        [Parameter()]
        [System.Boolean]
        $DisablePromptAtSignOut,

        [Parameter()]
        [ValidateSet('personalRecoveryKey')]
        [System.String[]]
        $SelectedRecoveryKeyTypes,

        [Parameter()]
        [System.Boolean]
        $AllowDeferralUntilSignOut,

        [Parameter()]
        [ValidateRange(-1, 11)]
        [System.Int32]
        $NumberOfTimesUserCanIgnore,

        [Parameter()]
        [System.Boolean]
        $HidePersonalRecoveryKey,

        [Parameter()]
        [System.String]
        $PersonalRecoveryKeyHelpMessage,

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

    if ($Enabled -and ($null -eq $SelectedRecoveryKeyTypes -or $null -eq $PersonalRecoveryKeyHelpMessage))
    {
        throw 'SelectedRecoveryKeyTypes and PersonalRecoveryKeyHelpMessage must be specified when Enabled is $true'
    }

    $currentInstance = Get-TargetResource @PSBoundParameters

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters
    $policyTemplateId = 'a239407c-698d-4ef8-b314-e3ae409204b8'

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Disk Encryption for macOS with DisplayName {$DisplayName}"

        if (-not $AllowDeferralUntilSignOut)
        {
            throw 'AllowDeferralUntilSignOut must be $true'
        }

        $BoundParameters.Remove('Assignments') | Out-Null
        $BoundParameters.Remove('Id') | Out-Null
        $BoundParameters.Remove('DisplayName') | Out-Null
        $BoundParameters.Remove('Description') | Out-Null
        $BoundParameters.Remove('RoleScopeTagIds') | Out-Null

        $settings = Get-M365DSCIntuneDeviceConfigurationSettings `
            -Properties ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $policyTemplateId

        $CreateParameters = ([Hashtable]$BoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $CreateParameters.Add('DisplayName', $DisplayName)
        $CreateParameters.Add('Description', $Description)
        $CreateParameters.Add('RoleScopeTagIds', $RoleScopeTagIds)
        $CreateParameters.Add('Settings', $settings)
        $CreateParameters.Add('TemplateId', $policyTemplateId)

        #region resource generator code
        $policy = New-MgBetaDeviceManagementIntent -BodyParameter $CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId  $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/intents'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Disk Encryption for macOS with Id {$($currentInstance.Id)}"

        if (-not $AllowDeferralUntilSignOut)
        {
            throw 'AllowDeferralUntilSignOut must be $true'
        }

        $BoundParameters.Remove("Assignments") | Out-Null
        $BoundParameters.Remove('Id') | Out-Null
        $BoundParameters.Remove('DisplayName') | Out-Null
        $BoundParameters.Remove('Description') | Out-Null
        $BoundParameters.Remove('RoleScopeTagIds') | Out-Null

        $settings = Get-M365DSCIntuneDeviceConfigurationSettings `
            -Properties ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $policyTemplateId

        $UpdateParameters = @{}
        $UpdateParameters.Add('DisplayName', $DisplayName)
        $UpdateParameters.Add('Description', $Description)
        Update-MgBetaDeviceManagementIntent -DeviceManagementIntentId $currentInstance.Id -BodyParameter $UpdateParameters

        #region resource generator code
        $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/intents/$($currentInstance.Id)/updateSettings"
        $body = @{'settings' = $settings }
        Invoke-MgGraphRequest -Method POST -Uri $Uri -Body ($body | ConvertTo-Json -Depth 20) -ContentType 'application/json' 4> $null

        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/intents'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Disk Encryption for macOS with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementIntent -DeviceManagementIntentId $currentInstance.Id
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
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [ValidateRange(1, 12)]
        [System.Int32]
        $PersonalRecoveryKeyRotationInMonths,

        [Parameter()]
        [System.Boolean]
        $DisablePromptAtSignOut,

        [Parameter()]
        [ValidateSet('personalRecoveryKey')]
        [System.String[]]
        $SelectedRecoveryKeyTypes,

        [Parameter()]
        [System.Boolean]
        $AllowDeferralUntilSignOut,

        [Parameter()]
        [ValidateRange(-1, 11)]
        [System.Int32]
        $NumberOfTimesUserCanIgnore,

        [Parameter()]
        [System.Boolean]
        $HidePersonalRecoveryKey,

        [Parameter()]
        [System.String]
        $PersonalRecoveryKeyHelpMessage,

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

    Write-Verbose -Message "Testing configuration of the Intune Disk Encryption for macOS with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = @{}
    $MyInvocation.MyCommand.Parameters.GetEnumerator() | ForEach-Object {
        if ($_.Key -notlike '*Variable' -or $_.Key -notin @('Verbose', 'Debug', 'ErrorAction', 'WarningAction', 'InformationAction'))
        {
            if ($null -ne $CurrentValues[$_.Key] -or $null -ne $PSBoundParameters[$_.Key])
            {
                $ValuesToCheck.Add($_.Key, $null)
                if (-not $PSBoundParameters.ContainsKey($_.Key))
                {
                    $value = $null
                    switch -Regex ($CurrentValues[$_.Key].GetType().Name)
                    {
                        '^String$'
                        {
                            $value = ''
                        }
                        '^Int32$'
                        {
                            $value = 0
                        }
                        '^Boolean$'
                        {
                            $value = $false
                        }
                        '^.*\[\]$'
                        {
                            $value = @()
                        }
                    }
                    $PSBoundParameters.Add($_.Key, $value)
                }
            }
        }
    }

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

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    $testResult = $true
    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys -Verbose
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
        [array]$getValue = Get-MgBetaDeviceManagementIntent -Filter $Filter `
            -All `
            -ErrorAction Stop | Where-Object `
            -FilterScript { `
                $_.TemplateId -eq 'a239407c-698d-4ef8-b314-e3ae409204b8' `
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
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.Id
                DisplayName           =  $config.DisplayName
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
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Assignments" -isCIMArray:$true
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

function Get-M365DSCIntuneDeviceConfigurationSettings
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $Properties,

        [Parameter()]
        [System.String]
        $TemplateId
    )

    $templateCategoryId = (Get-MgBetaDeviceManagementTemplateCategory -DeviceManagementTemplateId $TemplateId).Id
    $templateSettings = Get-MgBetaDeviceManagementTemplateCategoryRecommendedSetting `
        -DeviceManagementTemplateId $TemplateId `
        -DeviceManagementTemplateSettingCategoryId $templateCategoryId

    $results = @()
    foreach ($setting in $templateSettings)
    {
        $result = @{}
        $settingType = $setting.AdditionalProperties.'@odata.type'
        $settingValue = $null
        $currentValueKey = $Properties.keys | Where-Object -FilterScript { $setting.DefinitionId -like "*$_" }
        if ($null -ne $currentValueKey)
        {
            $settingValue = $Properties.$currentValueKey
        }

        $requiresValueJson = $false
        switch ($settingType)
        {
            {
                ( $_ -eq '#microsoft.graph.deviceManagementStringSettingInstance' ) -or
                ( $_ -eq '#microsoft.graph.deviceManagementBooleanSettingInstance' )
            }
            {
                if ([String]::IsNullOrEmpty($settingValue))
                {
                    $settingValue = $setting.ValueJson | ConvertFrom-Json
                }
            }
            '#microsoft.graph.deviceManagementCollectionSettingInstance'
            {
                $requiresValueJson = $true
                if ($null -eq $settingValue)
                {
                    $settingValue = ConvertTo-Json -InputObject @() -Compress
                }
                else
                {
                    $settingValue = ConvertTo-Json -InputObject ([Array]$settingValue) -Compress
                }
            }
            Default
            {
                if ($null -eq $settingValue)
                {
                    $settingValue = $setting.ValueJson | ConvertFrom-Json
                }
            }
        }
        $result.Add('@odata.type', $settingType)
        $result.Add('Id', $setting.Id)
        $result.Add('definitionId', $setting.DefinitionId)
        if ($requiresValueJson)
        {
            $result.Add('valueJson', ($settingValue))
        }
        else
        {
            $result.Add('value', ($settingValue))
        }

        $results += $result
    }
    return $results
}

Export-ModuleMember -Function *-TargetResource
