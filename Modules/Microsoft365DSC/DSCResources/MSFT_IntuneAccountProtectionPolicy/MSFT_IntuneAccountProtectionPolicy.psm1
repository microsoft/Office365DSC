function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'true', 'false')]
        $WindowsHelloForBusinessBlocked,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMinimumLength,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMaximumLength,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinLowercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinUppercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinSpecialCharactersUsage,

        [Parameter()]
        [ValidateRange(0, 730)]
        [System.Int32]
        $PinExpirationInDays,

        [Parameter()]
        [ValidateRange(0, 50)]
        [System.Int32]
        $PinPreviousBlockCount,

        [Parameter()]
        [System.Boolean]
        $PinRecoveryEnabled,

        [Parameter()]
        [System.Boolean]
        $SecurityDeviceRequired,

        [Parameter()]
        [System.Boolean]
        $UnlockWithBiometricsEnabled,

        [Parameter()]
        [System.Boolean]
        $EnhancedAntiSpoofingForFacialFeaturesEnabled,

        [Parameter()]
        [System.Boolean]
        $UseCertificatesForOnPremisesAuthEnabled,

        [Parameter()]
        [System.Boolean]
        $UseSecurityKeyForSignin,

        [Parameter()]
        [ValidateSet('notConfigured', 'disable', 'enableWithUEFILock', 'enableWithoutUEFILock')]
        [System.String]
        $DeviceGuardLocalSystemAuthorityCredentialGuardSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

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

    Write-Verbose -Message "Checking for the Intune Account Protection Policy {$DisplayName}"

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters `
        -ErrorAction Stop

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
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
        #Retrieve policy general settings

        $policy = Get-MgBetaDeviceManagementIntent -DeviceManagementIntentId $Identity -ExpandProperty settings,assignments -ErrorAction SilentlyContinue

        if ($null -eq $policy)
        {
            Write-Verbose -Message "No Account Protection Policy with identity {$Identity} was found"
            if (-not [String]::IsNullOrEmpty($DisplayName))
            {
                $policy = Get-MgBetaDeviceManagementIntent -Filter "DisplayName eq '$DisplayName'" -ErrorAction SilentlyContinue
            }

            if ($null -eq $policy)
            {
                Write-Verbose -Message "No Account Protection Policy with displayName {$DisplayName} was found"
                return $nullResult
            }

            if(([array]$policy).count -gt 1)
            {
                throw "A policy with a duplicated displayName {'$DisplayName'} was found - Ensure displayName is unique"
            }

            $policy = Get-MgBetaDeviceManagementIntent -DeviceManagementIntentId $policy.id -ExpandProperty settings,assignments -ErrorAction SilentlyContinue

        }


        $Identity = $policy.id
        [array]$settings = $policy.settings

        $returnHashtable = @{}
        $returnHashtable.Add('Identity', $policy.Id)
        $returnHashtable.Add('DisplayName', $policy.DisplayName)
        $returnHashtable.Add('Description', $policy.Description)

        foreach ($setting in $settings)
        {
            $settingName = $setting.definitionId.Split("_")[1]
            $settingValue = $setting.ValueJson | ConvertFrom-Json

            if ($settingName -eq 'WindowsHelloForBusinessBlocked')
            {
                if ($null -eq $settingValue)
                {
                    $settingValue = 'notConfigured'
                }
                else
                {
                    $settingValue = $settingValue.ToString()
                }

            }

            $returnHashtable.Add($settingName, $settingValue)
        }

        Write-Verbose -Message "Found Account Protection Policy {$DisplayName}"

        $returnHashtable.Add('Ensure', 'Present')
        $returnHashtable.Add('Credential', $Credential)
        $returnHashtable.Add('ApplicationId', $ApplicationId)
        $returnHashtable.Add('TenantId', $TenantId)
        $returnHashtable.Add('ApplicationSecret', $ApplicationSecret)
        $returnHashtable.Add('CertificateThumbprint', $CertificateThumbprint)
        $returnHashtable.Add('ManagedIdentity', $ManagedIdentity.IsPresent)
        $returnHashtable.Add('AccessTokens', $AccessTokens)

        $returnAssignments = @()
        if ($policy.assignments.count -gt 0)
        {
            $returnAssignments += ConvertFrom-IntunePolicyAssignment -Assignments $policy.assignments -IncludeDeviceFilter $true
        }
        $returnHashtable.Add('Assignments', $returnAssignments)

        return $returnHashtable
    }
    catch
    {
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
            $_.Exception -like "*Unable to perform redirect as Location Header is not set in response*")
        {
            if (Assert-M365DSCIsNonInteractiveShell)
            {
                Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for Intune."
            }
        }
        else
        {
            New-M365DSCLogEntry -Message 'Error retrieving data:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

        $nullResult = Clear-M365DSCAuthenticationParameter -BoundParameters $nullResult
        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'true', 'false')]
        $WindowsHelloForBusinessBlocked,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMinimumLength,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMaximumLength,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinLowercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinUppercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinSpecialCharactersUsage,

        [Parameter()]
        [ValidateRange(0, 730)]
        [System.Int32]
        $PinExpirationInDays,

        [Parameter()]
        [ValidateRange(0, 50)]
        [System.Int32]
        $PinPreviousBlockCount,

        [Parameter()]
        [System.Boolean]
        $PinRecoveryEnabled,

        [Parameter()]
        [System.Boolean]
        $SecurityDeviceRequired,

        [Parameter()]
        [System.Boolean]
        $UnlockWithBiometricsEnabled,

        [Parameter()]
        [System.Boolean]
        $EnhancedAntiSpoofingForFacialFeaturesEnabled,

        [Parameter()]
        [System.Boolean]
        $UseCertificatesForOnPremisesAuthEnabled,

        [Parameter()]
        [System.Boolean]
        $UseSecurityKeyForSignin,

        [Parameter()]
        [ValidateSet('notConfigured', 'disable', 'enableWithUEFILock', 'enableWithoutUEFILock')]
        [System.String]
        $DeviceGuardLocalSystemAuthorityCredentialGuardSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

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

    Write-Warning -Message "The resource 'IntuneAccountProtectionPolicy' is deprecated. It will be removed in a future release. Please use 'IntuneAccountProtectionPolicyWindows10' instead."
    Write-Warning -Message "For more information, please visit https://learn.microsoft.com/en-us/mem/intune/fundamentals/whats-new#consolidation-of-intune-profiles-for-identity-protection-and-account-protection-"

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentPolicy = Get-TargetResource @PSBoundParameters
    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null
    $PSBoundParameters.Remove('ManagedIdentity') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    $policyTemplateID = '0f2b5d70-d4e9-4156-8c16-1397eb6c54a5'

    if ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating new Account Protection Policy {$DisplayName}"
        $PSBoundParameters.Remove('Identity') | Out-Null
        $PSBoundParameters.Remove('Assignments') | Out-Null
        $PSBoundParameters.Remove('DisplayName') | Out-Null
        $PSBoundParameters.Remove('Description') | Out-Null

        $settings = Get-M365DSCIntuneDeviceConfigurationSettings `
            -Properties ([System.Collections.Hashtable]$PSBoundParameters) `
            -TemplateId $policyTemplateID

        $createParameters = @{}
        $createParameters.add('DisplayName', $DisplayName)
        $createParameters.add('Description', $Description)
        $createParameters.add('Settings', $settings)
        $createParameters.add('TemplateId', $policyTemplateID)
        $policy = New-MgBetaDeviceManagementIntent -BodyParameter $createParameters

        #region Assignments
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId  $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/intents'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating existing Account Protection Policy {$DisplayName}"

        $PSBoundParameters.Remove('Identity') | Out-Null
        $PSBoundParameters.Remove('DisplayName') | Out-Null
        $PSBoundParameters.Remove('Description') | Out-Null
        $PSBoundParameters.Remove('Assignments') | Out-Null

        $settings = Get-M365DSCIntuneDeviceConfigurationSettings `
            -Properties ([System.Collections.Hashtable]$PSBoundParameters) `
            -TemplateId $policyTemplateID

        $updateParameters = @{}
        $updateParameters.add('DisplayName', $DisplayName)
        $updateParameters.add('Description', $Description)
        Update-MgBetaDeviceManagementIntent -DeviceManagementIntentId $currentPolicy.Identity -BodyParameter $updateParameters

        #Update-MgBetaDeviceManagementIntent does not support updating the property settings
        #Update-MgBetaDeviceManagementIntentSetting only support updating a single setting at a time
        #Using Rest to reduce the number of calls
        
        $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/intents/$($currentPolicy.Identity)/updateSettings"
        $body = @{'settings' = $settings }
        Invoke-MgGraphRequest -Method POST -Uri $Uri -Body ($body | ConvertTo-Json -Depth 20) -ContentType 'application/json' 4> $null

        #region Assignments
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId  $currentPolicy.Identity `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/intents'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing Account Protection Policy {$DisplayName}"
        Remove-MgBetaDeviceManagementIntent -DeviceManagementIntentId $currentPolicy.Identity -Confirm:$false
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'true', 'false')]
        $WindowsHelloForBusinessBlocked,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMinimumLength,

        [Parameter()]
        [ValidateRange(4, 127)]
        [System.Int32]
        $PinMaximumLength,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinLowercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinUppercaseCharactersUsage,

        [Parameter()]
        [ValidateSet('notConfigured', 'blocked', 'required', 'allowed')]
        [System.String]
        $PinSpecialCharactersUsage,

        [Parameter()]
        [ValidateRange(0, 730)]
        [System.Int32]
        $PinExpirationInDays,

        [Parameter()]
        [ValidateRange(0, 50)]
        [System.Int32]
        $PinPreviousBlockCount,

        [Parameter()]
        [System.Boolean]
        $PinRecoveryEnabled,

        [Parameter()]
        [System.Boolean]
        $SecurityDeviceRequired,

        [Parameter()]
        [System.Boolean]
        $UnlockWithBiometricsEnabled,

        [Parameter()]
        [System.Boolean]
        $EnhancedAntiSpoofingForFacialFeaturesEnabled,

        [Parameter()]
        [System.Boolean]
        $UseCertificatesForOnPremisesAuthEnabled,

        [Parameter()]
        [System.Boolean]
        $UseSecurityKeyForSignin,

        [Parameter()]
        [ValidateSet('notConfigured', 'disable', 'enableWithUEFILock', 'enableWithoutUEFILock')]
        [System.String]
        $DeviceGuardLocalSystemAuthorityCredentialGuardSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion
    Write-Verbose -Message "Testing configuration of Account Protection Policy {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $CurrentValues))
    {
        Write-Verbose "An error occured in Get-TargetResource, the policy {$displayName} will not be processed"
        throw "An error occured in Get-TargetResource, the policy {$displayName} will not be processed. Refer to the event viewer logs for more information."
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()
    $ValuesToCheck.Remove('Identity') | Out-Null

    $testResult = $true
    if ($CurrentValues.Ensure -ne $Ensure)
    {
        $testResult = $false
    }

    #region assignments
    if ($testResult)
    {
        $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $PSBoundParameters.Assignments
        $target = $CurrentValues.Assignments
        $testResult = Compare-M365DSCIntunePolicyAssignment -Source $source -Target $target
        $ValuesToCheck.Remove('Assignments') | Out-Null
    }
    #endregion

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $dscContent = ''
    $i = 1

    try
    {
        $policyTemplateID = '0f2b5d70-d4e9-4156-8c16-1397eb6c54a5'
        [array]$policies = Get-MgBetaDeviceManagementIntent -Filter $Filter -All:$true `
            -ErrorAction Stop | Where-Object -FilterScript { $_.TemplateId -eq $policyTemplateID }

        if ($policies.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($policy in $policies)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($policies.Count)] $($policy.DisplayName)" -NoNewline

            $params = @{
                Identity              = $policy.Id
                DisplayName           = $policy.DisplayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @params
            if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $Results))
            {
                Write-Verbose "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed"
                throw "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed. Refer to the event viewer logs for more information."
            }

            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.Assignments) -CIMInstanceName IntuneAccountProtectionPolicyAssignments

                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential


            if ($Results.Assignments)
            {
                $isCIMArray = $false
                if ($Results.Assignments.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$isCIMArray
            }

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName

            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $i++

        }
        return $dscContent
    }
    catch
    {
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
        $_.Exception -like "*Unable to perform redirect as Location Header is not set in response*" -or `
        $_.Exception -like "*Request not applicable to target tenant*")
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for Intune."
        }
        else
        {
            Write-Host $Global:M365DSCEmojiRedX

            New-M365DSCLogEntry -Message 'Error during Export:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

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
        $currentValueKey = $Properties.keys | Where-Object -FilterScript { $_ -eq $setting.DefinitionId.Split("_")[1] }

        if ($null -ne $currentValueKey)
        {
            $settingValue = $Properties.$currentValueKey
        }

        if ($currentValueKey -eq 'WindowsHelloForBusinessBlocked' -and $settingValue -eq 'notConfigured')
        {
            $settingValue = $null
        }

        switch ($settingType)
        {
            '#microsoft.graph.deviceManagementStringSettingInstance'
            {
                if ([String]::IsNullOrEmpty($settingValue))
                {
                    $settingValue = $setting.ValueJson | ConvertFrom-Json
                }
            }
            '#microsoft.graph.deviceManagementCollectionSettingInstance'
            {
                if ($null -eq $settingValue)
                {
                    $settingValue = @()
                }
                else
                {
                    [array]$settingValue = [array]$settingValue
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
        $result.Add('value', $settingValue)

        $results += $result
    }
    return $results
}

Export-ModuleMember -Function *-TargetResource
