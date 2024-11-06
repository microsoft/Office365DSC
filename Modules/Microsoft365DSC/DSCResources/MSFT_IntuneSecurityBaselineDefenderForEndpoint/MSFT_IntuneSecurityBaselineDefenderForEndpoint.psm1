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

        $nullResult = $PSBoundParameters
        $nullResult.Ensure = 'Absent'

        $getValue = $null
        #region resource generator code
        $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Security Baseline Defender For Endpoint with Id {$Id}"

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
            Write-Verbose -Message "Could not find an Intune Security Baseline Defender For Endpoint with Name {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Security Baseline Defender For Endpoint with Id {$Id} and Name {$DisplayName} was found"

        # Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementConfigurationPolicySetting `
            -DeviceManagementConfigurationPolicyId $Id `
            -ExpandProperty 'settingDefinitions' `
            -All `
            -ErrorAction Stop

        $policySettings = @{}
        $policySettings = Export-IntuneSettingCatalogPolicySettings -Settings $settings -ReturnHashtable $policySettings -ContainsDeviceAndUserSettings

        #region resource generator code
        $complexDeviceSettings = @{}

        # Add device settings with conditional checks
        if ($null -ne $policySettings.DeviceSettings.deviceInstall_Classes_Deny) {
            $complexDeviceSettings.Add('DeviceInstall_Classes_Deny', $policySettings.DeviceSettings.deviceInstall_Classes_Deny)
        }
        if ($null -ne $policySettings.DeviceSettings.deviceInstall_Classes_Deny_List) {
            $complexDeviceSettings.Add('DeviceInstall_Classes_Deny_List', $policySettings.DeviceSettings.deviceInstall_Classes_Deny_List)
        }
        if ($null -ne $policySettings.DeviceSettings.deviceInstall_Classes_Deny_Retroactive) {
            $complexDeviceSettings.Add('DeviceInstall_Classes_Deny_Retroactive', $policySettings.DeviceSettings.deviceInstall_Classes_Deny_Retroactive)
        }
        if ($null -ne $policySettings.DeviceSettings.encryptionMethodWithXts_Name) {
            $complexDeviceSettings.Add('EncryptionMethodWithXts_Name', $policySettings.DeviceSettings.encryptionMethodWithXts_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.encryptionMethodWithXtsOsDropDown_Name) {
            $complexDeviceSettings.Add('EncryptionMethodWithXtsOsDropDown_Name', $policySettings.DeviceSettings.encryptionMethodWithXtsOsDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.encryptionMethodWithXtsFdvDropDown_Name) {
            $complexDeviceSettings.Add('EncryptionMethodWithXtsFdvDropDown_Name', $policySettings.DeviceSettings.encryptionMethodWithXtsFdvDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.encryptionMethodWithXtsRdvDropDown_Name) {
            $complexDeviceSettings.Add('EncryptionMethodWithXtsRdvDropDown_Name', $policySettings.DeviceSettings.encryptionMethodWithXtsRdvDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVRecoveryUsage_Name) {
            $complexDeviceSettings.Add('FDVRecoveryUsage_Name', $policySettings.DeviceSettings.fDVRecoveryUsage_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVActiveDirectoryBackup_Name) {
            $complexDeviceSettings.Add('FDVActiveDirectoryBackup_Name', $policySettings.DeviceSettings.fDVActiveDirectoryBackup_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVHideRecoveryPage_Name) {
            $complexDeviceSettings.Add('FDVHideRecoveryPage_Name', $policySettings.DeviceSettings.fDVHideRecoveryPage_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVRecoveryPasswordUsageDropDown_Name) {
            $complexDeviceSettings.Add('FDVRecoveryPasswordUsageDropDown_Name', $policySettings.DeviceSettings.fDVRecoveryPasswordUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVRequireActiveDirectoryBackup_Name) {
            $complexDeviceSettings.Add('FDVRequireActiveDirectoryBackup_Name', $policySettings.DeviceSettings.fDVRequireActiveDirectoryBackup_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVAllowDRA_Name) {
            $complexDeviceSettings.Add('FDVAllowDRA_Name', $policySettings.DeviceSettings.fDVAllowDRA_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVActiveDirectoryBackupDropDown_Name) {
            $complexDeviceSettings.Add('FDVActiveDirectoryBackupDropDown_Name', $policySettings.DeviceSettings.fDVActiveDirectoryBackupDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVRecoveryKeyUsageDropDown_Name) {
            $complexDeviceSettings.Add('FDVRecoveryKeyUsageDropDown_Name', $policySettings.DeviceSettings.fDVRecoveryKeyUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVDenyWriteAccess_Name) {
            $complexDeviceSettings.Add('FDVDenyWriteAccess_Name', $policySettings.DeviceSettings.fDVDenyWriteAccess_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVEncryptionType_Name) {
            $complexDeviceSettings.Add('FDVEncryptionType_Name', $policySettings.DeviceSettings.fDVEncryptionType_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.fDVEncryptionTypeDropDown_Name) {
            $complexDeviceSettings.Add('FDVEncryptionTypeDropDown_Name', $policySettings.DeviceSettings.fDVEncryptionTypeDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.enablePreBootPinExceptionOnDECapableDevice_Name) {
            $complexDeviceSettings.Add('EnablePreBootPinExceptionOnDECapableDevice_Name', $policySettings.DeviceSettings.enablePreBootPinExceptionOnDECapableDevice_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.enhancedPIN_Name) {
            $complexDeviceSettings.Add('EnhancedPIN_Name', $policySettings.DeviceSettings.enhancedPIN_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSRecoveryUsage_Name) {
            $complexDeviceSettings.Add('OSRecoveryUsage_Name', $policySettings.DeviceSettings.OSRecoveryUsage_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSRequireActiveDirectoryBackup_Name) {
            $complexDeviceSettings.Add('OSRequireActiveDirectoryBackup_Name', $policySettings.DeviceSettings.OSRequireActiveDirectoryBackup_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSActiveDirectoryBackup_Name) {
            $complexDeviceSettings.Add('OSActiveDirectoryBackup_Name', $policySettings.DeviceSettings.OSActiveDirectoryBackup_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSRecoveryPasswordUsageDropDown_Name) {
            $complexDeviceSettings.Add('OSRecoveryPasswordUsageDropDown_Name', $policySettings.DeviceSettings.OSRecoveryPasswordUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSHideRecoveryPage_Name) {
            $complexDeviceSettings.Add('OSHideRecoveryPage_Name', $policySettings.DeviceSettings.OSHideRecoveryPage_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSAllowDRA_Name) {
            $complexDeviceSettings.Add('OSAllowDRA_Name', $policySettings.DeviceSettings.OSAllowDRA_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSRecoveryKeyUsageDropDown_Name) {
            $complexDeviceSettings.Add('OSRecoveryKeyUsageDropDown_Name', $policySettings.DeviceSettings.OSRecoveryKeyUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSActiveDirectoryBackupDropDown_Name) {
            $complexDeviceSettings.Add('OSActiveDirectoryBackupDropDown_Name', $policySettings.DeviceSettings.OSActiveDirectoryBackupDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.enablePrebootInputProtectorsOnSlates_Name) {
            $complexDeviceSettings.Add('EnablePrebootInputProtectorsOnSlates_Name', $policySettings.DeviceSettings.enablePrebootInputProtectorsOnSlates_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSEncryptionType_Name) {
            $complexDeviceSettings.Add('OSEncryptionType_Name', $policySettings.DeviceSettings.OSEncryptionType_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.OSEncryptionTypeDropDown_Name) {
            $complexDeviceSettings.Add('OSEncryptionTypeDropDown_Name', $policySettings.DeviceSettings.OSEncryptionTypeDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configureAdvancedStartup_Name) {
            $complexDeviceSettings.Add('ConfigureAdvancedStartup_Name', $policySettings.DeviceSettings.configureAdvancedStartup_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configureTPMStartupKeyUsageDropDown_Name) {
            $complexDeviceSettings.Add('ConfigureTPMStartupKeyUsageDropDown_Name', $policySettings.DeviceSettings.configureTPMStartupKeyUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configureTPMPINKeyUsageDropDown_Name) {
            $complexDeviceSettings.Add('ConfigureTPMPINKeyUsageDropDown_Name', $policySettings.DeviceSettings.configureTPMPINKeyUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configureTPMUsageDropDown_Name) {
            $complexDeviceSettings.Add('ConfigureTPMUsageDropDown_Name', $policySettings.DeviceSettings.configureTPMUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configureNonTPMStartupKeyUsage_Name) {
            $complexDeviceSettings.Add('ConfigureNonTPMStartupKeyUsage_Name', $policySettings.DeviceSettings.configureNonTPMStartupKeyUsage_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.configurePINUsageDropDown_Name) {
            $complexDeviceSettings.Add('ConfigurePINUsageDropDown_Name', $policySettings.DeviceSettings.configurePINUsageDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVConfigureBDE) {
            $complexDeviceSettings.Add('RDVConfigureBDE', $policySettings.DeviceSettings.RDVConfigureBDE)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVAllowBDE_Name) {
            $complexDeviceSettings.Add('RDVAllowBDE_Name', $policySettings.DeviceSettings.RDVAllowBDE_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVEncryptionType_Name) {
            $complexDeviceSettings.Add('RDVEncryptionType_Name', $policySettings.DeviceSettings.RDVEncryptionType_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVEncryptionTypeDropDown_Name) {
            $complexDeviceSettings.Add('RDVEncryptionTypeDropDown_Name', $policySettings.DeviceSettings.RDVEncryptionTypeDropDown_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVDisableBDE_Name) {
            $complexDeviceSettings.Add('RDVDisableBDE_Name', $policySettings.DeviceSettings.RDVDisableBDE_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVDenyWriteAccess_Name) {
            $complexDeviceSettings.Add('RDVDenyWriteAccess_Name', $policySettings.DeviceSettings.RDVDenyWriteAccess_Name)
        }
        if ($null -ne $policySettings.DeviceSettings.RDVCrossOrg) {
            $complexDeviceSettings.Add('RDVCrossOrg', $policySettings.DeviceSettings.RDVCrossOrg)
        }
        if ($null -ne $policySettings.DeviceSettings.EnableSmartScreen) {
            $complexDeviceSettings.Add('EnableSmartScreen', $policySettings.DeviceSettings.EnableSmartScreen)
        }
        if ($null -ne $policySettings.DeviceSettings.EnableSmartScreenDropdown) {
            $complexDeviceSettings.Add('EnableSmartScreenDropdown', $policySettings.DeviceSettings.EnableSmartScreenDropdown)
        }
        if ($null -ne $policySettings.DeviceSettings.DisableSafetyFilterOverrideForAppRepUnknown) {
            $complexDeviceSettings.Add('DisableSafetyFilterOverrideForAppRepUnknown', $policySettings.DeviceSettings.DisableSafetyFilterOverrideForAppRepUnknown)
        }
        if ($null -ne $policySettings.DeviceSettings.Disable_Managing_Safety_Filter_IE9) {
            $complexDeviceSettings.Add('Disable_Managing_Safety_Filter_IE9', $policySettings.DeviceSettings.Disable_Managing_Safety_Filter_IE9)
        }
        if ($null -ne $policySettings.DeviceSettings.IE9SafetyFilterOptions) {
            $complexDeviceSettings.Add('IE9SafetyFilterOptions', $policySettings.DeviceSettings.IE9SafetyFilterOptions)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowWarningForOtherDiskEncryption) {
            $complexDeviceSettings.Add('AllowWarningForOtherDiskEncryption', $policySettings.DeviceSettings.AllowWarningForOtherDiskEncryption)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowStandardUserEncryption) {
            $complexDeviceSettings.Add('AllowStandardUserEncryption', $policySettings.DeviceSettings.AllowStandardUserEncryption)
        }
        if ($null -ne $policySettings.DeviceSettings.ConfigureRecoveryPasswordRotation) {
            $complexDeviceSettings.Add('ConfigureRecoveryPasswordRotation', $policySettings.DeviceSettings.ConfigureRecoveryPasswordRotation)
        }
        if ($null -ne $policySettings.DeviceSettings.RequireDeviceEncryption) {
            $complexDeviceSettings.Add('RequireDeviceEncryption', $policySettings.DeviceSettings.RequireDeviceEncryption)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowArchiveScanning) {
            $complexDeviceSettings.Add('AllowArchiveScanning', $policySettings.DeviceSettings.AllowArchiveScanning)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowBehaviorMonitoring) {
            $complexDeviceSettings.Add('AllowBehaviorMonitoring', $policySettings.DeviceSettings.AllowBehaviorMonitoring)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowCloudProtection) {
            $complexDeviceSettings.Add('AllowCloudProtection', $policySettings.DeviceSettings.AllowCloudProtection)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowEmailScanning) {
            $complexDeviceSettings.Add('AllowEmailScanning', $policySettings.DeviceSettings.AllowEmailScanning)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowFullScanRemovableDriveScanning) {
            $complexDeviceSettings.Add('AllowFullScanRemovableDriveScanning', $policySettings.DeviceSettings.AllowFullScanRemovableDriveScanning)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowOnAccessProtection) {
            $complexDeviceSettings.Add('AllowOnAccessProtection', $policySettings.DeviceSettings.AllowOnAccessProtection)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowRealtimeMonitoring) {
            $complexDeviceSettings.Add('AllowRealtimeMonitoring', $policySettings.DeviceSettings.AllowRealtimeMonitoring)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowScanningNetworkFiles) {
            $complexDeviceSettings.Add('AllowScanningNetworkFiles', $policySettings.DeviceSettings.AllowScanningNetworkFiles)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowIOAVProtection) {
            $complexDeviceSettings.Add('AllowIOAVProtection', $policySettings.DeviceSettings.AllowIOAVProtection)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowScriptScanning) {
            $complexDeviceSettings.Add('AllowScriptScanning', $policySettings.DeviceSettings.AllowScriptScanning)
        }
        if ($null -ne $policySettings.DeviceSettings.AllowUserUIAccess) {
            $complexDeviceSettings.Add('AllowUserUIAccess', $policySettings.DeviceSettings.AllowUserUIAccess)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutionOfPotentiallyObfuscatedScripts) {
            $complexDeviceSettings.Add('BlockExecutionOfPotentiallyObfuscatedScripts', $policySettings.DeviceSettings.BlockExecutionOfPotentiallyObfuscatedScripts)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutionOfPotentiallyObfuscatedScripts_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockExecutionOfPotentiallyObfuscatedScripts_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockExecutionOfPotentiallyObfuscatedScripts_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockWin32APICallsFromOfficeMacros) {
            $complexDeviceSettings.Add('BlockWin32APICallsFromOfficeMacros', $policySettings.DeviceSettings.BlockWin32APICallsFromOfficeMacros)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion) {
            $complexDeviceSettings.Add('BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion', $policySettings.DeviceSettings.BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeCommunicationAppFromCreatingChildProcesses) {
            $complexDeviceSettings.Add('BlockOfficeCommunicationAppFromCreatingChildProcesses', $policySettings.DeviceSettings.BlockOfficeCommunicationAppFromCreatingChildProcesses)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeCommunicationAppFromCreatingChildProcesses_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockOfficeCommunicationAppFromCreatingChildProcesses_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockOfficeCommunicationAppFromCreatingChildProcesses_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAllOfficeApplicationsFromCreatingChildProcesses) {
            $complexDeviceSettings.Add('BlockAllOfficeApplicationsFromCreatingChildProcesses', $policySettings.DeviceSettings.BlockAllOfficeApplicationsFromCreatingChildProcesses)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAllOfficeApplicationsFromCreatingChildProcesses_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockAllOfficeApplicationsFromCreatingChildProcesses_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockAllOfficeApplicationsFromCreatingChildProcesses_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAdobeReaderFromCreatingChildProcesses) {
            $complexDeviceSettings.Add('BlockAdobeReaderFromCreatingChildProcesses', $policySettings.DeviceSettings.BlockAdobeReaderFromCreatingChildProcesses)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem) {
            $complexDeviceSettings.Add('BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem', $policySettings.DeviceSettings.BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent) {
            $complexDeviceSettings.Add('BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent', $policySettings.DeviceSettings.BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockWebshellCreationForServers) {
            $complexDeviceSettings.Add('BlockWebshellCreationForServers', $policySettings.DeviceSettings.BlockWebshellCreationForServers)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockWebshellCreationForServers_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockWebshellCreationForServers_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockWebshellCreationForServers_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockUntrustedUnsignedProcessesThatRunFromUSB) {
            $complexDeviceSettings.Add('BlockUntrustedUnsignedProcessesThatRunFromUSB', $policySettings.DeviceSettings.BlockUntrustedUnsignedProcessesThatRunFromUSB)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockUntrustedUnsignedProcessesThatRunFromUSB_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockUntrustedUnsignedProcessesThatRunFromUSB_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockUntrustedUnsignedProcessesThatRunFromUSB_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockPersistenceThroughWMIEventSubscription) {
            $complexDeviceSettings.Add('BlockPersistenceThroughWMIEventSubscription', $policySettings.DeviceSettings.BlockPersistenceThroughWMIEventSubscription)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockUseOfCopiedOrImpersonatedSystemTools) {
            $complexDeviceSettings.Add('BlockUseOfCopiedOrImpersonatedSystemTools', $policySettings.DeviceSettings.BlockUseOfCopiedOrImpersonatedSystemTools)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockUseOfCopiedOrImpersonatedSystemTools_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockUseOfCopiedOrImpersonatedSystemTools_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockUseOfCopiedOrImpersonatedSystemTools_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAbuseOfExploitedVulnerableSignedDrivers) {
            $complexDeviceSettings.Add('BlockAbuseOfExploitedVulnerableSignedDrivers', $policySettings.DeviceSettings.BlockAbuseOfExploitedVulnerableSignedDrivers)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockAbuseOfExploitedVulnerableSignedDrivers_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockAbuseOfExploitedVulnerableSignedDrivers_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockAbuseOfExploitedVulnerableSignedDrivers_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockProcessCreationsFromPSExecAndWMICommands) {
            $complexDeviceSettings.Add('BlockProcessCreationsFromPSExecAndWMICommands', $policySettings.DeviceSettings.BlockProcessCreationsFromPSExecAndWMICommands)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockProcessCreationsFromPSExecAndWMICommands_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockProcessCreationsFromPSExecAndWMICommands_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockProcessCreationsFromPSExecAndWMICommands_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeApplicationsFromCreatingExecutableContent) {
            $complexDeviceSettings.Add('BlockOfficeApplicationsFromCreatingExecutableContent', $policySettings.DeviceSettings.BlockOfficeApplicationsFromCreatingExecutableContent)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeApplicationsFromCreatingExecutableContent_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockOfficeApplicationsFromCreatingExecutableContent_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockOfficeApplicationsFromCreatingExecutableContent_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses) {
            $complexDeviceSettings.Add('BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses', $policySettings.DeviceSettings.BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockRebootingMachineInSafeMode) {
            $complexDeviceSettings.Add('BlockRebootingMachineInSafeMode', $policySettings.DeviceSettings.BlockRebootingMachineInSafeMode)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockRebootingMachineInSafeMode_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockRebootingMachineInSafeMode_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockRebootingMachineInSafeMode_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.UseAdvancedProtectionAgainstRansomware) {
            $complexDeviceSettings.Add('UseAdvancedProtectionAgainstRansomware', $policySettings.DeviceSettings.UseAdvancedProtectionAgainstRansomware)
        }
        if ($null -ne $policySettings.DeviceSettings.UseAdvancedProtectionAgainstRansomware_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('UseAdvancedProtectionAgainstRansomware_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.UseAdvancedProtectionAgainstRansomware_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutableContentFromEmailClientAndWebmail) {
            $complexDeviceSettings.Add('BlockExecutableContentFromEmailClientAndWebmail', $policySettings.DeviceSettings.BlockExecutableContentFromEmailClientAndWebmail)
        }
        if ($null -ne $policySettings.DeviceSettings.BlockExecutableContentFromEmailClientAndWebmail_ASROnlyPerRuleExclusions) {
            $complexDeviceSettings.Add('BlockExecutableContentFromEmailClientAndWebmail_ASROnlyPerRuleExclusions', $policySettings.DeviceSettings.BlockExecutableContentFromEmailClientAndWebmail_ASROnlyPerRuleExclusions)
        }
        if ($null -ne $policySettings.DeviceSettings.CheckForSignaturesBeforeRunningScan) {
            $complexDeviceSettings.Add('CheckForSignaturesBeforeRunningScan', $policySettings.DeviceSettings.CheckForSignaturesBeforeRunningScan)
        }
        if ($null -ne $policySettings.DeviceSettings.CloudBlockLevel) {
            $complexDeviceSettings.Add('CloudBlockLevel', $policySettings.DeviceSettings.CloudBlockLevel)
        }
        if ($null -ne $policySettings.DeviceSettings.CloudExtendedTimeout) {
            $complexDeviceSettings.Add('CloudExtendedTimeout', $policySettings.DeviceSettings.CloudExtendedTimeout)
        }
        if ($null -ne $policySettings.DeviceSettings.DisableLocalAdminMerge) {
            $complexDeviceSettings.Add('DisableLocalAdminMerge', $policySettings.DeviceSettings.DisableLocalAdminMerge)
        }
        if ($null -ne $policySettings.DeviceSettings.EnableNetworkProtection) {
            $complexDeviceSettings.Add('EnableNetworkProtection', $policySettings.DeviceSettings.EnableNetworkProtection)
        }
        if ($null -ne $policySettings.DeviceSettings.HideExclusionsFromLocalAdmins) {
            $complexDeviceSettings.Add('HideExclusionsFromLocalAdmins', $policySettings.DeviceSettings.HideExclusionsFromLocalAdmins)
        }
        if ($null -ne $policySettings.DeviceSettings.HideExclusionsFromLocalUsers) {
            $complexDeviceSettings.Add('HideExclusionsFromLocalUsers', $policySettings.DeviceSettings.HideExclusionsFromLocalUsers)
        }
        if ($null -ne $policySettings.DeviceSettings.OobeEnableRtpAndSigUpdate) {
            $complexDeviceSettings.Add('OobeEnableRtpAndSigUpdate', $policySettings.DeviceSettings.OobeEnableRtpAndSigUpdate)
        }
        if ($null -ne $policySettings.DeviceSettings.PUAProtection) {
            $complexDeviceSettings.Add('PUAProtection', $policySettings.DeviceSettings.PUAProtection)
        }
        if ($null -ne $policySettings.DeviceSettings.RealTimeScanDirection) {
            $complexDeviceSettings.Add('RealTimeScanDirection', $policySettings.DeviceSettings.RealTimeScanDirection)
        }
        if ($null -ne $policySettings.DeviceSettings.ScanParameter) {
            $complexDeviceSettings.Add('ScanParameter', $policySettings.DeviceSettings.ScanParameter)
        }
        if ($null -ne $policySettings.DeviceSettings.ScheduleQuickScanTime) {
            $complexDeviceSettings.Add('ScheduleQuickScanTime', $policySettings.DeviceSettings.ScheduleQuickScanTime)
        }
        if ($null -ne $policySettings.DeviceSettings.ScheduleScanDay) {
            $complexDeviceSettings.Add('ScheduleScanDay', $policySettings.DeviceSettings.ScheduleScanDay)
        }
        if ($null -ne $policySettings.DeviceSettings.ScheduleScanTime) {
            $complexDeviceSettings.Add('ScheduleScanTime', $policySettings.DeviceSettings.ScheduleScanTime)
        }
        if ($null -ne $policySettings.DeviceSettings.SignatureUpdateInterval) {
            $complexDeviceSettings.Add('SignatureUpdateInterval', $policySettings.DeviceSettings.SignatureUpdateInterval)
        }
        if ($null -ne $policySettings.DeviceSettings.SubmitSamplesConsent) {
            $complexDeviceSettings.Add('SubmitSamplesConsent', $policySettings.DeviceSettings.SubmitSamplesConsent)
        }
        if ($null -ne $policySettings.DeviceSettings.LsaCfgFlags) {
            $complexDeviceSettings.Add('LsaCfgFlags', $policySettings.DeviceSettings.LsaCfgFlags)
        }
        if ($null -ne $policySettings.DeviceSettings.DeviceEnumerationPolicy) {
            $complexDeviceSettings.Add('DeviceEnumerationPolicy', $policySettings.DeviceSettings.DeviceEnumerationPolicy)
        }
        if ($null -ne $policySettings.DeviceSettings.SmartScreenEnabled) {
            $complexDeviceSettings.Add('SmartScreenEnabled', $policySettings.DeviceSettings.SmartScreenEnabled)
        }
        if ($null -ne $policySettings.DeviceSettings.SmartScreenPuaEnabled) {
            $complexDeviceSettings.Add('SmartScreenPuaEnabled', $policySettings.DeviceSettings.SmartScreenPuaEnabled)
        }
        if ($null -ne $policySettings.DeviceSettings.SmartScreenDnsRequestsEnabled) {
            $complexDeviceSettings.Add('SmartScreenDnsRequestsEnabled', $policySettings.DeviceSettings.SmartScreenDnsRequestsEnabled)
        }
        if ($null -ne $policySettings.DeviceSettings.NewSmartScreenLibraryEnabled) {
            $complexDeviceSettings.Add('NewSmartScreenLibraryEnabled', $policySettings.DeviceSettings.NewSmartScreenLibraryEnabled)
        }
        if ($null -ne $policySettings.DeviceSettings.SmartScreenForTrustedDownloadsEnabled) {
            $complexDeviceSettings.Add('SmartScreenForTrustedDownloadsEnabled', $policySettings.DeviceSettings.SmartScreenForTrustedDownloadsEnabled)
        }
        if ($null -ne $policySettings.DeviceSettings.PreventSmartScreenPromptOverride) {
            $complexDeviceSettings.Add('PreventSmartScreenPromptOverride', $policySettings.DeviceSettings.PreventSmartScreenPromptOverride)
        }
        if ($null -ne $policySettings.DeviceSettings.PreventSmartScreenPromptOverrideForFiles) {
            $complexDeviceSettings.Add('PreventSmartScreenPromptOverrideForFiles', $policySettings.DeviceSettings.PreventSmartScreenPromptOverrideForFiles)
        }

        # Check if $complexDeviceSettings is empty
        if ($complexDeviceSettings.Values.Where({ $null -ne $_ }).Count -eq 0) {
            $complexDeviceSettings = $null
        }
        $policySettings.Remove('DeviceSettings') | Out-Null

        $complexUserSettings = @{}

        # Add user settings with conditional checks
        if ($null -ne $policySettings.UserSettings.DisableSafetyFilterOverrideForAppRepUnknown) {
            $complexUserSettings.Add('DisableSafetyFilterOverrideForAppRepUnknown', $policySettings.UserSettings.DisableSafetyFilterOverrideForAppRepUnknown)
        }

        # Check if $complexUserSettings is empty
        if ($complexUserSettings.Values.Where({ $null -ne $_ }).Count -eq 0) {
            $complexUserSettings = $null
        }
        $policySettings.Remove('UserSettings') | Out-Null
        #endregion
      
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

    $templateReferenceId = '49b8320f-e179-472e-8e2c-2fde00289ca2_1'
    $platforms = 'windows10'
    $technologies = 'mdm'

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Security Baseline Defender For Endpoint with Name {$DisplayName}"
        $BoundParameters.Remove("Assignments") | Out-Null

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
        Write-Verbose -Message "Updating the Intune Security Baseline Defender For Endpoint with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove("Assignments") | Out-Null

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
        Write-Verbose -Message "Removing the Intune Security Baseline Defender For Endpoint with Id {$($currentInstance.Id)}"
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

    Write-Verbose -Message "Testing configuration of the Intune Security Baseline Defender For Endpoint with Id {$Id} and Name {$DisplayName}"

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
        $policyTemplateID = "49b8320f-e179-472e-8e2c-2fde00289ca2_1"
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
                DisplayName           =  $config.Name
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
            if ($null -ne $Results.DeviceSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.DeviceSettings `
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint'
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
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint'
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
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "DeviceSettings" -IsCIMArray:$False
            }
            if ($Results.UserSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "UserSettings" -IsCIMArray:$False
            }

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
