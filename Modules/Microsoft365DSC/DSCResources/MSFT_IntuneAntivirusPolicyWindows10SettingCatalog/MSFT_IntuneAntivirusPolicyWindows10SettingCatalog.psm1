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
        [ValidateSet('0', '1')]
        [System.String]
        $AllowArchiveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowBehaviorMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCloudProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowDatagramProcessingOnWinServer,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowEmailScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanOnMappedNetworkDrives,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanRemovableDriveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIntrusionPreventionSystem,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIOAVProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowNetworkProtectionDownLevel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowOnAccessProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowRealtimeMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScanningNetworkFiles,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScriptScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowUserUIAccess,

        [Parameter()]
        [System.int32]
        $AvgCPULoadFactor,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxDepth,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxSize,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $CheckForSignaturesBeforeRunningScan,

        [Parameter()]
        [ValidateSet('0', '2', '4', '6')]
        [System.String]
        $CloudBlockLevel,

        [Parameter()]
        [System.Int32]
        $CloudExtendedTimeout,

        [Parameter()]
        [System.String]
        $CompanyName,

        [Parameter()]
        [System.Int32]
        $DaysToRetainCleanedMalware,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAccountProtectionUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAppBrowserUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableClearTpmButton,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDeviceSecurityUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDnsOverTcpParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableEnhancedNotifications,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableFamilyUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHealthUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHttpParsing,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $DisableSshParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableNetworkUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTpmFirmwareUpdateWarning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableVirusUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupFullScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupQuickScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceECSIntegration,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceTelemetry,

        [Parameter()]
        [System.String]
        $Email,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableCustomizedToasts,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableInAppCustomization,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableLowCPUPriority,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $EnableNetworkProtection,

        [Parameter()]
        [System.String[]]
        $ExcludedExtensions,

        [Parameter()]
        [System.String[]]
        $ExcludedPaths,

        [Parameter()]
        [System.String[]]
        $ExcludedProcesses,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideRansomwareDataRecovery,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideWindowsSecurityNotificationAreaControl,

        [Parameter()]
        [System.String]
        $Phone,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $PUAProtection,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $EngineUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $MeteredConnectionUpdates,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $PlatformUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '4', '5')]
        [System.String]
        $SecurityIntelligenceUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $RealTimeScanDirection,

        [Parameter()]
        [ValidateSet('1', '2')]
        [System.String]
        $ScanParameter,

        [Parameter()]
        [System.Int32]
        $ScheduleQuickScanTime,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3', '4', '5', '6', '7', '8')]
        [System.String]
        $ScheduleScanDay,

        [Parameter()]
        [ValidateRange(0, 1380)]
        [System.Int32]
        $ScheduleScanTime,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTlsParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $RandomizeScheduleTaskTimes,

        [Parameter()]
        [ValidateRange(1, 23)]
        [System.Int32]
        $SchedulerRandomizationTime,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFallbackOrder,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFileSharesSources,

        [Parameter()]
        [ValidateRange(0, 24)]
        [System.Int32]
        $SignatureUpdateInterval,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $SubmitSamplesConsent,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $TamperProtection,

        [Parameter()]
        [System.String]
        $URL,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableLocalAdminMerge,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $LowSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $ModerateSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $SevereThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $HighSeverityThreats,

        [Parameter()]
        [ValidateSet('d948ff9b-99cb-4ee0-8012-1fbc09685377_1', 'e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1', '45fea5e9-280d-4da1-9792-fb5736da0ca9_1', '804339ad-1553-4478-a742-138fb5807418_1')]
        [System.String]
        $TemplateId,

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

    try
    {
        Write-Verbose -Message "Checking for the Intune Endpoint Protection Policy {$DisplayName}"

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

        $templateReferences = 'd948ff9b-99cb-4ee0-8012-1fbc09685377_1', 'e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1', '45fea5e9-280d-4da1-9792-fb5736da0ca9_1', '804339ad-1553-4478-a742-138fb5807418_1'

        if ($PSBoundParameters.ContainsKey('Identity'))
        {
            Write-Verbose -Message 'PolicyID was specified'
            try
            {
                $policy = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Identity -ErrorAction Stop
            }
            catch
            {
                Write-Verbose -Message "No Intune Antivirus Policy for Windows10 Setting Catalog with Id {$Identity} was found"
                $policy = Get-MgBetaDeviceManagementConfigurationPolicy -All -Filter "Name eq '$DisplayName'" | Where-Object -FilterScript {$_.TemplateReference.TemplateId -in $templateReferences}
                if ($policy.Length -gt 1)
                {
                    throw "Duplicate Intune Antivirus Policy for Windows10 Setting Catalog named $DisplayName exist in tenant"
                }
            }
        }
        else
        {
            Write-Verbose -Message 'Id was NOT specified'
            ## Can retreive multiple Intune Policies since displayname is not unique
            $policy = Get-MgBetaDeviceManagementConfigurationPolicy -All -Filter "Name eq '$DisplayName'"
            if ($policy.Length -gt 1)
            {
                throw "Duplicate Intune Antivirus Policy for Windows10 Setting Catalog named $DisplayName exist in tenant"
            }
        }

        if ([String]::IsNullOrEmpty($policy.Id))
        {
            Write-Verbose -Message "No Intune Antivirus Policy for Windows10 Setting Catalog with Name {$DisplayName} were found"
            $currentValues = $PSBoundParameters
            $currentValues.Ensure = 'Absent'
            return $currentValues
        }

        $Identity = $policy.Id
        Write-Verbose -Message "An Intune Antivirus Policy for Windows10 Setting Catalog with Id {$Identity} and Name {$DisplayName} was found"

        #Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementConfigurationPolicySetting `
            -DeviceManagementConfigurationPolicyId $Identity `
            -ExpandProperty 'settingDefinitions' `
            -ErrorAction Stop

        $policySettings = @{}
        $policySettings = Export-IntuneSettingCatalogPolicySettings -Settings $settings -ReturnHashtable $policySettings

        $returnHashtable = @{}
        $returnHashtable.Add('Identity', $Identity)
        $returnHashtable.Add('DisplayName', $policy.name)
        $returnHashtable.Add('Description', $policy.description)
        $returnHashtable.Add('TemplateId', $policy.templateReference.TemplateId)

        if ($null -ne $policySettings.SevereThreatDefaultAction)
        {
            $returnHashtable.Add('SevereThreats', $policySettings.SevereThreatDefaultAction)
            $policySettings.Remove('SevereThreatDefaultAction')
        }
        if ($null -ne $policySettings.HighSeverityThreatDefaultAction)
        {
            $returnHashtable.Add('HighSeverityThreats', $policySettings.HighSeverityThreatDefaultAction)
            $policySettings.Remove('HighSeverityThreatDefaultAction')
        }
        if ($null -ne $policySettings.ModerateSeverityThreatDefaultAction)
        {
            $returnHashtable.Add('ModerateSeverityThreats', $policySettings.ModerateSeverityThreatDefaultAction)
            $policySettings.Remove('ModerateSeverityThreatDefaultAction')
        }
        if ($null -ne $policySettings.LowSeverityThreatDefaultAction)
        {
            $returnHashtable.Add('LowSeverityThreats', $policySettings.LowSeverityThreatDefaultAction)
            $policySettings.Remove('LowSeverityThreatDefaultAction')
        }
        $returnHashtable += $policySettings

        $returnAssignments = @()
        $graphAssignments = Get-MgBetaDeviceManagementConfigurationPolicyAssignment -DeviceManagementConfigurationPolicyId $Identity
        if ($graphAssignments.Count -gt 0)
        {
            $returnAssignments += ConvertFrom-IntunePolicyAssignment `
                -IncludeDeviceFilter:$true `
                -Assignments ($graphAssignments)
        }
        $returnHashtable.Add('Assignments', $returnAssignments)

        $returnHashtable.Add('Ensure', 'Present')
        $returnHashtable.Add('Credential', $Credential)
        $returnHashtable.Add('ApplicationId', $ApplicationId)
        $returnHashtable.Add('TenantId', $TenantId)
        $returnHashtable.Add('ApplicationSecret', $ApplicationSecret)
        $returnHashtable.Add('CertificateThumbprint', $CertificateThumbprint)
        $returnHashtable.Add('ManagedIdentity', $ManagedIdentity.IsPresent)
        $returnHashtable.Add('AccessTokens', $AccessTokens)

        return $returnHashtable
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

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
        [ValidateSet('0', '1')]
        [System.String]
        $AllowArchiveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowBehaviorMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCloudProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowDatagramProcessingOnWinServer,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowEmailScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanOnMappedNetworkDrives,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanRemovableDriveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIntrusionPreventionSystem,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIOAVProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowNetworkProtectionDownLevel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowOnAccessProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowRealtimeMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScanningNetworkFiles,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScriptScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowUserUIAccess,

        [Parameter()]
        [System.int32]
        $AvgCPULoadFactor,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxDepth,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxSize,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $CheckForSignaturesBeforeRunningScan,

        [Parameter()]
        [ValidateSet('0', '2', '4', '6')]
        [System.String]
        $CloudBlockLevel,

        [Parameter()]
        [System.Int32]
        $CloudExtendedTimeout,

        [Parameter()]
        [System.String]
        $CompanyName,

        [Parameter()]
        [System.Int32]
        $DaysToRetainCleanedMalware,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAccountProtectionUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAppBrowserUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableClearTpmButton,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDeviceSecurityUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDnsOverTcpParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableEnhancedNotifications,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableFamilyUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHealthUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHttpParsing,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $DisableSshParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableNetworkUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTpmFirmwareUpdateWarning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableVirusUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupFullScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupQuickScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceECSIntegration,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceTelemetry,

        [Parameter()]
        [System.String]
        $Email,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableCustomizedToasts,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableInAppCustomization,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableLowCPUPriority,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $EnableNetworkProtection,

        [Parameter()]
        [System.String[]]
        $ExcludedExtensions,

        [Parameter()]
        [System.String[]]
        $ExcludedPaths,

        [Parameter()]
        [System.String[]]
        $ExcludedProcesses,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideRansomwareDataRecovery,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideWindowsSecurityNotificationAreaControl,

        [Parameter()]
        [System.String]
        $Phone,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $PUAProtection,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $EngineUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $MeteredConnectionUpdates,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $PlatformUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '4', '5')]
        [System.String]
        $SecurityIntelligenceUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $RealTimeScanDirection,

        [Parameter()]
        [ValidateSet('1', '2')]
        [System.String]
        $ScanParameter,

        [Parameter()]
        [System.Int32]
        $ScheduleQuickScanTime,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3', '4', '5', '6', '7', '8')]
        [System.String]
        $ScheduleScanDay,

        [Parameter()]
        [ValidateRange(0, 1380)]
        [System.Int32]
        $ScheduleScanTime,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTlsParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $RandomizeScheduleTaskTimes,

        [Parameter()]
        [ValidateRange(1, 23)]
        [System.Int32]
        $SchedulerRandomizationTime,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFallbackOrder,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFileSharesSources,

        [Parameter()]
        [ValidateRange(0, 24)]
        [System.Int32]
        $SignatureUpdateInterval,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $SubmitSamplesConsent,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $TamperProtection,

        [Parameter()]
        [System.String]
        $URL,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableLocalAdminMerge,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $LowSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $ModerateSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $SevereThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $HighSeverityThreats,

        [Parameter()]
        [ValidateSet('d948ff9b-99cb-4ee0-8012-1fbc09685377_1', 'e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1', '45fea5e9-280d-4da1-9792-fb5736da0ca9_1', '804339ad-1553-4478-a742-138fb5807418_1')]
        [System.String]
        $TemplateId,

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
    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($BoundParameters.ContainsKey('SevereThreats'))
    {
        $BoundParameters.Add('SevereThreatDefaultAction', $BoundParameters['SevereThreats'])
        $BoundParameters.Remove('SevereThreats')
    }
    if ($BoundParameters.ContainsKey('HighSeverityThreats'))
    {
        $BoundParameters.Add('HighSeverityThreatDefaultAction', $BoundParameters['HighSeverityThreats'])
        $BoundParameters.Remove('HighSeverityThreats')
    }
    if ($BoundParameters.ContainsKey('ModerateSeverityThreats'))
    {
        $BoundParameters.Add('ModerateSeverityThreatDefaultAction', $BoundParameters['ModerateSeverityThreats'])
        $BoundParameters.Remove('ModerateSeverityThreats')
    }
    if ($BoundParameters.ContainsKey('LowSeverityThreats'))
    {
        $BoundParameters.Add('LowSeverityThreatDefaultAction', $BoundParameters['LowSeverityThreats'])
        $BoundParameters.Remove('LowSeverityThreats')
    }

    $templateReferenceId = $TemplateId
    $platforms = 'windows10'
    $technologies = 'mdm,microsoftSense'

    if ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating new Endpoint Protection Policy {$DisplayName}"
        $BoundParameters.Remove('Identity') | Out-Null
        $BoundParameters.Remove('Assignments') | Out-Null

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

        $policy = New-MgBetaDeviceManagementConfigurationPolicy -BodyParameter $createParameters

        if ($policy.Id)
        {
            $assignmentsHash = ConvertTo-IntunePolicyAssignment -Assignments $Assignments -IncludeDeviceFilter:$true
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $policy.Id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/configurationPolicies'
        }
    }
    elseif ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating existing Endpoint Protection Policy {$($currentPolicy.DisplayName)}"
        $BoundParameters.Remove('Identity') | Out-Null
        $BoundParameters.Remove('Assignments') | Out-Null
        $BoundParameters.Remove('TemplateId') | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId

        Update-IntuneDeviceConfigurationPolicy `
            -DeviceConfigurationPolicyId $currentPolicy.Identity `
            -Name $DisplayName `
            -Description $Description `
            -TemplateReferenceId $templateReferenceId `
            -Platforms $platforms `
            -Technologies $technologies `
            -Settings $settings

        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentPolicy.Identity `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/configurationPolicies'
    }
    elseif ($Ensure -eq 'Absent' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing Endpoint Protection Policy {$($currentPolicy.DisplayName)}"
        Remove-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $currentPolicy.Identity
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
        [ValidateSet('0', '1')]
        [System.String]
        $AllowArchiveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowBehaviorMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowCloudProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowDatagramProcessingOnWinServer,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowEmailScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanOnMappedNetworkDrives,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowFullScanRemovableDriveScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIntrusionPreventionSystem,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowIOAVProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowNetworkProtectionDownLevel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowOnAccessProtection,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowRealtimeMonitoring,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScanningNetworkFiles,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowScriptScanning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $AllowUserUIAccess,

        [Parameter()]
        [System.int32]
        $AvgCPULoadFactor,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxDepth,

        [Parameter()]
        [System.Int32]
        $ArchiveMaxSize,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $CheckForSignaturesBeforeRunningScan,

        [Parameter()]
        [ValidateSet('0', '2', '4', '6')]
        [System.String]
        $CloudBlockLevel,

        [Parameter()]
        [System.Int32]
        $CloudExtendedTimeout,

        [Parameter()]
        [System.String]
        $CompanyName,

        [Parameter()]
        [System.Int32]
        $DaysToRetainCleanedMalware,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAccountProtectionUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableAppBrowserUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableClearTpmButton,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDeviceSecurityUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableDnsOverTcpParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableEnhancedNotifications,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableFamilyUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHealthUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableHttpParsing,

        [Parameter()]
        [ValidateSet('1', '0')]
        [System.String]
        $DisableSshParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableNetworkUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTpmFirmwareUpdateWarning,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableVirusUI,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupFullScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCatchupQuickScan,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceECSIntegration,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableCoreServiceTelemetry,

        [Parameter()]
        [System.String]
        $Email,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableCustomizedToasts,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableInAppCustomization,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $EnableLowCPUPriority,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $EnableNetworkProtection,

        [Parameter()]
        [System.String[]]
        $ExcludedExtensions,

        [Parameter()]
        [System.String[]]
        $ExcludedPaths,

        [Parameter()]
        [System.String[]]
        $ExcludedProcesses,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideRansomwareDataRecovery,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $HideWindowsSecurityNotificationAreaControl,

        [Parameter()]
        [System.String]
        $Phone,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $PUAProtection,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $EngineUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $MeteredConnectionUpdates,

        [Parameter()]
        [ValidateSet('0', '2', '3', '4', '5', '6')]
        [System.String]
        $PlatformUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '4', '5')]
        [System.String]
        $SecurityIntelligenceUpdatesChannel,

        [Parameter()]
        [ValidateSet('0', '1', '2')]
        [System.String]
        $RealTimeScanDirection,

        [Parameter()]
        [ValidateSet('1', '2')]
        [System.String]
        $ScanParameter,

        [Parameter()]
        [System.Int32]
        $ScheduleQuickScanTime,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3', '4', '5', '6', '7', '8')]
        [System.String]
        $ScheduleScanDay,

        [Parameter()]
        [ValidateRange(0, 1380)]
        [System.Int32]
        $ScheduleScanTime,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableTlsParsing,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $RandomizeScheduleTaskTimes,

        [Parameter()]
        [ValidateRange(1, 23)]
        [System.Int32]
        $SchedulerRandomizationTime,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFallbackOrder,

        [Parameter()]
        [System.String[]]
        $SignatureUpdateFileSharesSources,

        [Parameter()]
        [ValidateRange(0, 24)]
        [System.Int32]
        $SignatureUpdateInterval,

        [Parameter()]
        [ValidateSet('0', '1', '2', '3')]
        [System.String]
        $SubmitSamplesConsent,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $TamperProtection,

        [Parameter()]
        [System.String]
        $URL,

        [Parameter()]
        [ValidateSet('0', '1')]
        [System.String]
        $DisableLocalAdminMerge,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $LowSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $ModerateSeverityThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $SevereThreats,

        [Parameter()]
        [ValidateSet('clean', 'quarantine', 'remove', 'allow', 'userdefined', 'block')]
        [System.String]
        $HighSeverityThreats,

        [Parameter()]
        [ValidateSet('d948ff9b-99cb-4ee0-8012-1fbc09685377_1', 'e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1', '45fea5e9-280d-4da1-9792-fb5736da0ca9_1', '804339ad-1553-4478-a742-138fb5807418_1')]
        [System.String]
        $TemplateId,

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
    Write-Verbose -Message "Testing configuration of Endpoint Protection Policy {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $CurrentValues))
    {
        Write-Verbose "An error occured in Get-TargetResource, the policy {$displayName} will not be processed"
        throw "An error occured in Get-TargetResource, the policy {$displayName} will not be processed. Refer to the event viewer logs for more information."
    }

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

    $ValuesToCheck.Remove('Identity') | Out-Null
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
        -InboundParameters $PSBoundParameters `
        -SkipModuleReload:$true

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
        $templateFamily = 'endpointSecurityAntivirus'
        $templateReferences = 'd948ff9b-99cb-4ee0-8012-1fbc09685377_1', 'e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1', '45fea5e9-280d-4da1-9792-fb5736da0ca9_1', '804339ad-1553-4478-a742-138fb5807418_1'
        [array]$policies = Get-MgBetaDeviceManagementConfigurationPolicy -Filter $Filter -All:$true `
            -ErrorAction Stop | Where-Object -FilterScript {
            $_.TemplateReference.TemplateFamily -eq $templateFamily -and
            $_.TemplateReference.TemplateId -in $templateReferences
        }

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

            Write-Host "    |---[$i/$($policies.Count)] $($policy.Name)" -NoNewline

            $params = @{
                Identity              = $policy.Id
                DisplayName           = $policy.Name
                TemplateId            = $policy.TemplateReference.TemplateId
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @params
            if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $Results))
            {
                Write-Verbose "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed"
                throw "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed. Refer to the event viewer logs for more information."
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.Assignments) -CIMInstanceName DeviceManagementConfigurationPolicyAssignments
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
                -Credential $Credential -Verbose

            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
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
                $_.Exception -like '*Request not applicable to target tenant*')
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

Export-ModuleMember -Function *-TargetResource
