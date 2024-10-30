# IntuneSecurityBaselineDefenderForEndpoint

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DeviceSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint | Scope for Device Setting | |
| **UserSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint | Scope for Device Setting | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_DeviceManagementConfigurationPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DeviceInstall_Classes_Deny** | Write | String | Prevent installation of devices using drivers that match these device setup classes (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_Classes_Deny_List** | Write | StringArray[] | Prevented Classes - Depends on DeviceInstall_Classes_Deny | |
| **DeviceInstall_Classes_Deny_Retroactive** | Write | String | Also apply to matching devices that are already installed. - Depends on DeviceInstall_Classes_Deny (0: False, 1: True) | `0`, `1` |
| **EncryptionMethodWithXts_Name** | Write | String | Choose drive encryption method and cipher strength (Windows 10 [Version 1511] and later) (0: Disabled, 1: Enabled) | `0`, `1` |
| **EncryptionMethodWithXtsOsDropDown_Name** | Write | String | Select the encryption method for operating system drives: - Depends on EncryptionMethodWithXts_Name (3: AES-CBC 128-bit, 4: AES-CBC 256-bit, 6: XTS-AES 128-bit (default), 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **EncryptionMethodWithXtsFdvDropDown_Name** | Write | String | Select the encryption method for fixed data drives: - Depends on EncryptionMethodWithXts_Name (3: AES-CBC 128-bit, 4: AES-CBC 256-bit, 6: XTS-AES 128-bit (default), 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **EncryptionMethodWithXtsRdvDropDown_Name** | Write | String | Select the encryption method for removable data drives: - Depends on EncryptionMethodWithXts_Name (3: AES-CBC 128-bit  (default), 4: AES-CBC 256-bit, 6: XTS-AES 128-bit, 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **FDVRecoveryUsage_Name** | Write | String | Choose how BitLocker-protected fixed drives can be recovered (0: Disabled, 1: Enabled) | `0`, `1` |
| **FDVActiveDirectoryBackup_Name** | Write | String | Save BitLocker recovery information to AD DS for fixed data drives - Depends on FDVRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **FDVHideRecoveryPage_Name** | Write | String | Omit recovery options from the BitLocker setup wizard - Depends on FDVRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **FDVRecoveryPasswordUsageDropDown_Name** | Write | String | Configure user storage of BitLocker recovery information: - Depends on FDVRecoveryUsage_Name (2: Allow 48-digit recovery password, 1: Require 48-digit recovery password, 0: Do not allow 48-digit recovery password) | `2`, `1`, `0` |
| **FDVRequireActiveDirectoryBackup_Name** | Write | String | Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives - Depends on FDVRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **FDVAllowDRA_Name** | Write | String | Allow data recovery agent - Depends on FDVRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **FDVActiveDirectoryBackupDropDown_Name** | Write | String | Configure storage of BitLocker recovery information to AD DS: - Depends on FDVRecoveryUsage_Name (1: Backup recovery passwords and key packages, 2: Backup recovery passwords only) | `1`, `2` |
| **FDVRecoveryKeyUsageDropDown_Name** | Write | String |  - Depends on FDVRecoveryUsage_Name (2: Allow 256-bit recovery key, 1: Require 256-bit recovery key, 0: Do not allow 256-bit recovery key) | `2`, `1`, `0` |
| **FDVDenyWriteAccess_Name** | Write | String | Deny write access to fixed drives not protected by BitLocker (0: Disabled, 1: Enabled) | `0`, `1` |
| **FDVEncryptionType_Name** | Write | String | Enforce drive encryption type on fixed data drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **FDVEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) - Depends on FDVEncryptionType_Name (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **EnablePreBootPinExceptionOnDECapableDevice_Name** | Write | String | Allow devices compliant with InstantGo or HSTI to opt out of pre-boot PIN. (0: Disabled, 1: Enabled) | `0`, `1` |
| **EnhancedPIN_Name** | Write | String | Allow enhanced PINs for startup (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSRecoveryUsage_Name** | Write | String | Choose how BitLocker-protected operating system drives can be recovered (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSRequireActiveDirectoryBackup_Name** | Write | String | Do not enable BitLocker until recovery information is stored to AD DS for operating system drives - Depends on OSRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **OSActiveDirectoryBackup_Name** | Write | String | Save BitLocker recovery information to AD DS for operating system drives - Depends on OSRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **OSRecoveryPasswordUsageDropDown_Name** | Write | String | Configure user storage of BitLocker recovery information: - Depends on OSRecoveryUsage_Name (2: Allow 48-digit recovery password, 1: Require 48-digit recovery password, 0: Do not allow 48-digit recovery password) | `2`, `1`, `0` |
| **OSHideRecoveryPage_Name** | Write | String | Omit recovery options from the BitLocker setup wizard - Depends on OSRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **OSAllowDRA_Name** | Write | String | Allow data recovery agent - Depends on OSRecoveryUsage_Name (0: False, 1: True) | `0`, `1` |
| **OSRecoveryKeyUsageDropDown_Name** | Write | String |  - Depends on OSRecoveryUsage_Name (2: Allow 256-bit recovery key, 1: Require 256-bit recovery key, 0: Do not allow 256-bit recovery key) | `2`, `1`, `0` |
| **OSActiveDirectoryBackupDropDown_Name** | Write | String | Configure storage of BitLocker recovery information to AD DS: - Depends on OSRecoveryUsage_Name (1: Store recovery passwords and key packages, 2: Store recovery passwords only) | `1`, `2` |
| **EnablePrebootInputProtectorsOnSlates_Name** | Write | String | Enable use of BitLocker authentication requiring preboot keyboard input on slates (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSEncryptionType_Name** | Write | String | Enforce drive encryption type on operating system drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) - Depends on OSEncryptionType_Name (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **ConfigureAdvancedStartup_Name** | Write | String | Require additional authentication at startup (0: Disabled, 1: Enabled) | `0`, `1` |
| **ConfigureTPMStartupKeyUsageDropDown_Name** | Write | String | Configure TPM startup key: - Depends on ConfigureAdvancedStartup_Name (2: Allow startup key with TPM, 1: Require startup key with TPM, 0: Do not allow startup key with TPM) | `2`, `1`, `0` |
| **ConfigureTPMPINKeyUsageDropDown_Name** | Write | String | Configure TPM startup key and PIN: - Depends on ConfigureAdvancedStartup_Name (2: Allow startup key and PIN with TPM, 1: Require startup key and PIN with TPM, 0: Do not allow startup key and PIN with TPM) | `2`, `1`, `0` |
| **ConfigureTPMUsageDropDown_Name** | Write | String | Configure TPM startup: - Depends on ConfigureAdvancedStartup_Name (2: Allow TPM, 1: Require TPM, 0: Do not allow TPM) | `2`, `1`, `0` |
| **ConfigureNonTPMStartupKeyUsage_Name** | Write | String | Allow BitLocker without a compatible TPM (requires a password or a startup key on a USB flash drive) - Depends on ConfigureAdvancedStartup_Name (0: False, 1: True) | `0`, `1` |
| **ConfigurePINUsageDropDown_Name** | Write | String | Configure TPM startup PIN: - Depends on ConfigureAdvancedStartup_Name (2: Allow startup PIN with TPM, 1: Require startup PIN with TPM, 0: Do not allow startup PIN with TPM) | `2`, `1`, `0` |
| **RDVConfigureBDE** | Write | String | Control use of BitLocker on removable drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVAllowBDE_Name** | Write | String | Allow users to apply BitLocker protection on removable data drives (Device) - Depends on RDVConfigureBDE (0: False, 1: True) | `0`, `1` |
| **RDVEncryptionType_Name** | Write | String | Enforce drive encryption type on removable data drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **RDVDisableBDE_Name** | Write | String | Allow users to suspend and decrypt BitLocker protection on removable data drives (Device) - Depends on RDVConfigureBDE (0: False, 1: True) | `0`, `1` |
| **RDVDenyWriteAccess_Name** | Write | String | Deny write access to removable drives not protected by BitLocker (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVCrossOrg** | Write | String | Do not allow write access to devices configured in another organization - Depends on RDVDenyWriteAccess_Name (0: False, 1: True) | `0`, `1` |
| **EnableSmartScreen** | Write | String | Configure Windows Defender SmartScreen (0: Disabled, 1: Enabled) | `0`, `1` |
| **EnableSmartScreenDropdown** | Write | String | Pick one of the following settings: (Device) - Depends on EnableSmartScreen (block: Warn and prevent bypass, warn: Warn) | `block`, `warn` |
| **DisableSafetyFilterOverrideForAppRepUnknown** | Write | String | Prevent bypassing SmartScreen Filter warnings about files that are not commonly downloaded from the Internet (0: Disabled, 1: Enabled) | `0`, `1` |
| **Disable_Managing_Safety_Filter_IE9** | Write | String | Prevent managing SmartScreen Filter (0: Disabled, 1: Enabled) | `0`, `1` |
| **IE9SafetyFilterOptions** | Write | String | Select SmartScreen Filter mode - Depends on Disable_Managing_Safety_Filter_IE9 (0: Off, 1: On) | `0`, `1` |
| **AllowWarningForOtherDiskEncryption** | Write | String | Allow Warning For Other Disk Encryption (0: Disabled, 1: Enabled) | `0`, `1` |
| **AllowStandardUserEncryption** | Write | String | Allow Standard User Encryption - Depends on AllowWarningForOtherDiskEncryption (0: This is the default, when the policy is not set. If current logged on user is a standard user, 'RequireDeviceEncryption' policy will not try to enable encryption on any drive., 1: 'RequireDeviceEncryption' policy will try to enable encryption on all fixed drives even if a current logged in user is standard user.) | `0`, `1` |
| **ConfigureRecoveryPasswordRotation** | Write | String | Configure Recovery Password Rotation (0: Refresh off (default), 1: Refresh on for Azure AD-joined devices, 2: Refresh on for both Azure AD-joined and hybrid-joined devices) | `0`, `1`, `2` |
| **RequireDeviceEncryption** | Write | String | Require Device Encryption (0: Disabled, 1: Enabled) | `0`, `1` |
| **AllowArchiveScanning** | Write | String | Allow Archive Scanning (0: Not allowed. Turns off scanning on archived files., 1: Allowed. Scans the archive files.) | `0`, `1` |
| **AllowBehaviorMonitoring** | Write | String | Allow Behavior Monitoring (0: Not allowed. Turns off behavior monitoring., 1: Allowed. Turns on real-time behavior monitoring.) | `0`, `1` |
| **AllowCloudProtection** | Write | String | Allow Cloud Protection (0: Not allowed. Turns off the Microsoft Active Protection Service., 1: Allowed. Turns on the Microsoft Active Protection Service.) | `0`, `1` |
| **AllowEmailScanning** | Write | String | Allow Email Scanning (0: Not allowed. Turns off email scanning., 1: Allowed. Turns on email scanning.) | `0`, `1` |
| **AllowFullScanRemovableDriveScanning** | Write | String | Allow Full Scan Removable Drive Scanning (0: Not allowed. Turns off scanning on removable drives., 1: Allowed. Scans removable drives.) | `0`, `1` |
| **AllowOnAccessProtection** | Write | String | Allow On Access Protection (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **AllowRealtimeMonitoring** | Write | String | Allow Realtime Monitoring (0: Not allowed. Turns off the real-time monitoring service., 1: Allowed. Turns on and runs the real-time monitoring service.) | `0`, `1` |
| **AllowScanningNetworkFiles** | Write | String | Allow Scanning Network Files (0: Not allowed. Turns off scanning of network files., 1: Allowed. Scans network files.) | `0`, `1` |
| **AllowIOAVProtection** | Write | String | Allow scanning of all downloaded files and attachments (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **AllowScriptScanning** | Write | String | Allow Script Scanning (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **AllowUserUIAccess** | Write | String | Allow User UI Access (0: Not allowed. Prevents users from accessing UI., 1: Allowed. Lets users access UI.) | `0`, `1` |
| **BlockExecutionOfPotentiallyObfuscatedScripts** | Write | String | Block execution of potentially obfuscated scripts - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockExecutionOfPotentiallyObfuscatedScripts_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockWin32APICallsFromOfficeMacros** | Write | String | Block Win32 API calls from Office macros - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion** | Write | String | Block executable files from running unless they meet a prevalence, age, or trusted list criterion - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockExecutableFilesRunningUnlessTheyMeetPrevalenceAgeTrustedListCriterion_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockOfficeCommunicationAppFromCreatingChildProcesses** | Write | String | Block Office communication application from creating child processes - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockOfficeCommunicationAppFromCreatingChildProcesses_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockAllOfficeApplicationsFromCreatingChildProcesses** | Write | String | Block all Office applications from creating child processes - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockAllOfficeApplicationsFromCreatingChildProcesses_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockAdobeReaderFromCreatingChildProcesses** | Write | String | Block Adobe Reader from creating child processes - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem** | Write | String | Block credential stealing from the Windows local security authority subsystem - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent** | Write | String | Block JavaScript or VBScript from launching downloaded executable content - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockJavaScriptOrVBScriptFromLaunchingDownloadedExecutableContent_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockWebshellCreationForServers** | Write | String | Block Webshell creation for Servers - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockWebshellCreationForServers_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockUntrustedUnsignedProcessesThatRunFromUSB** | Write | String | Block untrusted and unsigned processes that run from USB - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockUntrustedUnsignedProcessesThatRunFromUSB_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockPersistenceThroughWMIEventSubscription** | Write | String | Block persistence through WMI event subscription - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockUseOfCopiedOrImpersonatedSystemTools** | Write | String | [PREVIEW] Block use of copied or impersonated system tools - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockUseOfCopiedOrImpersonatedSystemTools_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockAbuseOfExploitedVulnerableSignedDrivers** | Write | String | Block abuse of exploited vulnerable signed drivers (Device) - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockAbuseOfExploitedVulnerableSignedDrivers_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockProcessCreationsFromPSExecAndWMICommands** | Write | String | Block process creations originating from PSExec and WMI commands - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockProcessCreationsFromPSExecAndWMICommands_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockOfficeApplicationsFromCreatingExecutableContent** | Write | String | Block Office applications from creating executable content - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockOfficeApplicationsFromCreatingExecutableContent_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses** | Write | String | Block Office applications from injecting code into other processes - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockOfficeApplicationsFromInjectingCodeIntoOtherProcesses_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockRebootingMachineInSafeMode** | Write | String | [PREVIEW] Block rebooting machine in Safe Mode - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockRebootingMachineInSafeMode_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **UseAdvancedProtectionAgainstRansomware** | Write | String | Use advanced protection against ransomware - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **UseAdvancedProtectionAgainstRansomware_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **BlockExecutableContentFromEmailClientAndWebmail** | Write | String | Block executable content from email client and webmail - Depends on AttackSurfaceReductionRules (off: Off, block: Block, audit: Audit, warn: Warn) | `off`, `block`, `audit`, `warn` |
| **BlockExecutableContentFromEmailClientAndWebmail_ASROnlyPerRuleExclusions** | Write | StringArray[] | ASR Only Per Rule Exclusions | |
| **CheckForSignaturesBeforeRunningScan** | Write | String | Check For Signatures Before Running Scan (0: Disabled, 1: Enabled) | `0`, `1` |
| **CloudBlockLevel** | Write | String | Cloud Block Level (0: NotConfigured, 2: High, 4: HighPlus, 6: ZeroTolerance) | `0`, `2`, `4`, `6` |
| **CloudExtendedTimeout** | Write | SInt32 | Cloud Extended Timeout | |
| **DisableLocalAdminMerge** | Write | String | Disable Local Admin Merge (0: Enable Local Admin Merge, 1: Disable Local Admin Merge) | `0`, `1` |
| **EnableNetworkProtection** | Write | String | Enable Network Protection (0: Disabled, 1: Enabled (block mode), 2: Enabled (audit mode)) | `0`, `1`, `2` |
| **HideExclusionsFromLocalAdmins** | Write | String | Hide Exclusions From Local Admins (1: If you enable this setting, local admins will no longer be able to see the exclusion list in Windows Security App or via PowerShell., 0: If you disable or do not configure this setting, local admins will be able to see exclusions in the Windows Security App and via PowerShell.) | `1`, `0` |
| **HideExclusionsFromLocalUsers** | Write | String | Hide Exclusions From Local Users (1: If you enable this setting, local users will no longer be able to see the exclusion list in Windows Security App or via PowerShell., 0: If you disable or do not configure this setting, local users will be able to see exclusions in the Windows Security App and via PowerShell.) | `1`, `0` |
| **OobeEnableRtpAndSigUpdate** | Write | String | Oobe Enable Rtp And Sig Update (1: If you enable this setting, real-time protection and Security Intelligence Updates are enabled during OOBE., 0: If you either disable or do not configure this setting, real-time protection and Security Intelligence Updates during OOBE is not enabled.) | `1`, `0` |
| **PUAProtection** | Write | String | PUA Protection (0: PUA Protection off. Windows Defender will not protect against potentially unwanted applications., 1: PUA Protection on. Detected items are blocked. They will show in history along with other threats., 2: Audit mode. Windows Defender will detect potentially unwanted applications, but take no action. You can review information about the applications Windows Defender would have taken action against by searching for events created by Windows Defender in the Event Viewer.) | `0`, `1`, `2` |
| **RealTimeScanDirection** | Write | String | Real Time Scan Direction (0: Monitor all files (bi-directional)., 1: Monitor incoming files., 2: Monitor outgoing files.) | `0`, `1`, `2` |
| **ScanParameter** | Write | String | Scan Parameter (1: Quick scan, 2: Full scan) | `1`, `2` |
| **ScheduleQuickScanTime** | Write | SInt32 | Schedule Quick Scan Time | |
| **ScheduleScanDay** | Write | String | Schedule Scan Day (0: Every day, 1: Sunday, 2: Monday, 3: Tuesday, 4: Wednesday, 5: Thursday, 6: Friday, 7: Saturday, 8: No scheduled scan) | `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8` |
| **ScheduleScanTime** | Write | SInt32 | Schedule Scan Time | |
| **SignatureUpdateInterval** | Write | SInt32 | Signature Update Interval | |
| **SubmitSamplesConsent** | Write | String | Submit Samples Consent (0: Always prompt., 1: Send safe samples automatically., 2: Never send., 3: Send all samples automatically.) | `0`, `1`, `2`, `3` |
| **LsaCfgFlags** | Write | String | Credential Guard (0: (Disabled) Turns off Credential Guard remotely if configured previously without UEFI Lock., 1: (Enabled with UEFI lock) Turns on Credential Guard with UEFI lock., 2: (Enabled without lock) Turns on Credential Guard without UEFI lock.) | `0`, `1`, `2` |
| **DeviceEnumerationPolicy** | Write | String | Device Enumeration Policy (0: Block all (Most restrictive), 1: Only after log in/screen unlock, 2: Allow all (Least restrictive)) | `0`, `1`, `2` |
| **SmartScreenEnabled** | Write | String | Configure Microsoft Defender SmartScreen (0: Disabled, 1: Enabled) | `0`, `1` |
| **SmartScreenPuaEnabled** | Write | String | Configure Microsoft Defender SmartScreen to block potentially unwanted apps (0: Disabled, 1: Enabled) | `0`, `1` |
| **SmartScreenDnsRequestsEnabled** | Write | String | Enable Microsoft Defender SmartScreen DNS requests (0: Disabled, 1: Enabled) | `0`, `1` |
| **NewSmartScreenLibraryEnabled** | Write | String | Enable new SmartScreen library (0: Disabled, 1: Enabled) | `0`, `1` |
| **SmartScreenForTrustedDownloadsEnabled** | Write | String | Force Microsoft Defender SmartScreen checks on downloads from trusted sources (0: Disabled, 1: Enabled) | `0`, `1` |
| **PreventSmartScreenPromptOverride** | Write | String | Prevent bypassing Microsoft Defender SmartScreen prompts for sites (0: Disabled, 1: Enabled) | `0`, `1` |
| **PreventSmartScreenPromptOverrideForFiles** | Write | String | Prevent bypassing of Microsoft Defender SmartScreen warnings about downloads (0: Disabled, 1: Enabled) | `0`, `1` |

### MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisableSafetyFilterOverrideForAppRepUnknown** | Write | String | Prevent bypassing SmartScreen Filter warnings about files that are not commonly downloaded from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |


## Description

Intune Security Baseline Defender For Endpoint

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineDefenderForEndpoint 'mySecurityBaselineDefenderForEndpoint'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                AllowRealtimeMonitoring = '1'
                BlockWin32APICallsFromOfficeMacros = 'warn'
                CloudBlockLevel = '2'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                DisableSafetyFilterOverrideForAppRepUnknown = '1'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineDefenderForEndpoint 'mySecurityBaselineDefenderForEndpoint'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                AllowRealtimeMonitoring = '0' #drift
                BlockWin32APICallsFromOfficeMacros = 'warn'
                CloudBlockLevel = '2'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                DisableSafetyFilterOverrideForAppRepUnknown = '1'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineDefenderForEndpoint 'mySecurityBaselineDefenderForEndpoint'
        {
            DisplayName           = 'test'
            Ensure                = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

