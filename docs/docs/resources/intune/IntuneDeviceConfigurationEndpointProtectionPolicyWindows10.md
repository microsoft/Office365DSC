# IntuneDeviceConfigurationEndpointProtectionPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ApplicationGuardAllowCameraMicrophoneRedirection** | Write | Boolean | Gets or sets whether applications inside Microsoft Defender Application Guard can access the devices camera and microphone. | |
| **ApplicationGuardAllowFileSaveOnHost** | Write | Boolean | Allow users to download files from Edge in the application guard container and save them on the host file system | |
| **ApplicationGuardAllowPersistence** | Write | Boolean | Allow persisting user generated data inside the App Guard Containter (favorites, cookies, web passwords, etc.) | |
| **ApplicationGuardAllowPrintToLocalPrinters** | Write | Boolean | Allow printing to Local Printers from Container | |
| **ApplicationGuardAllowPrintToNetworkPrinters** | Write | Boolean | Allow printing to Network Printers from Container | |
| **ApplicationGuardAllowPrintToPDF** | Write | Boolean | Allow printing to PDF from Container | |
| **ApplicationGuardAllowPrintToXPS** | Write | Boolean | Allow printing to XPS from Container | |
| **ApplicationGuardAllowVirtualGPU** | Write | Boolean | Allow application guard to use virtual GPU | |
| **ApplicationGuardBlockClipboardSharing** | Write | String | Block clipboard to share data from Host to Container, or from Container to Host, or both ways, or neither ways. Possible values are: notConfigured, blockBoth, blockHostToContainer, blockContainerToHost, blockNone. | `notConfigured`, `blockBoth`, `blockHostToContainer`, `blockContainerToHost`, `blockNone` |
| **ApplicationGuardBlockFileTransfer** | Write | String | Block clipboard to transfer image file, text file or neither of them. Possible values are: notConfigured, blockImageAndTextFile, blockImageFile, blockNone, blockTextFile. | `notConfigured`, `blockImageAndTextFile`, `blockImageFile`, `blockNone`, `blockTextFile` |
| **ApplicationGuardBlockNonEnterpriseContent** | Write | Boolean | Block enterprise sites to load non-enterprise content, such as third party plug-ins | |
| **ApplicationGuardCertificateThumbprints** | Write | StringArray[] | Allows certain device level Root Certificates to be shared with the Microsoft Defender Application Guard container. | |
| **ApplicationGuardEnabled** | Write | Boolean | Enable Windows Defender Application Guard | |
| **ApplicationGuardEnabledOptions** | Write | String | Enable Windows Defender Application Guard for newer Windows builds. Possible values are: notConfigured, enabledForEdge, enabledForOffice, enabledForEdgeAndOffice. | `notConfigured`, `enabledForEdge`, `enabledForOffice`, `enabledForEdgeAndOffice` |
| **ApplicationGuardForceAuditing** | Write | Boolean | Force auditing will persist Windows logs and events to meet security/compliance criteria (sample events are user login-logoff, use of privilege rights, software installation, system changes, etc.) | |
| **AppLockerApplicationControl** | Write | String | Enables the Admin to choose what types of app to allow on devices. Possible values are: notConfigured, enforceComponentsAndStoreApps, auditComponentsAndStoreApps, enforceComponentsStoreAppsAndSmartlocker, auditComponentsStoreAppsAndSmartlocker. | `notConfigured`, `enforceComponentsAndStoreApps`, `auditComponentsAndStoreApps`, `enforceComponentsStoreAppsAndSmartlocker`, `auditComponentsStoreAppsAndSmartlocker` |
| **BitLockerAllowStandardUserEncryption** | Write | Boolean | Allows the admin to allow standard users to enable encrpytion during Azure AD Join. | |
| **BitLockerDisableWarningForOtherDiskEncryption** | Write | Boolean | Allows the Admin to disable the warning prompt for other disk encryption on the user machines. | |
| **BitLockerEnableStorageCardEncryptionOnMobile** | Write | Boolean | Allows the admin to require encryption to be turned on using BitLocker. This policy is valid only for a mobile SKU. | |
| **BitLockerEncryptDevice** | Write | Boolean | Allows the admin to require encryption to be turned on using BitLocker. | |
| **BitLockerFixedDrivePolicy** | Write | MSFT_MicrosoftGraphbitLockerFixedDrivePolicy | BitLocker Fixed Drive Policy. | |
| **BitLockerRecoveryPasswordRotation** | Write | String | This setting initiates a client-driven recovery password rotation after an OS drive recovery (either by using bootmgr or WinRE). Possible values are: notConfigured, disabled, enabledForAzureAd, enabledForAzureAdAndHybrid. | `notConfigured`, `disabled`, `enabledForAzureAd`, `enabledForAzureAdAndHybrid` |
| **BitLockerRemovableDrivePolicy** | Write | MSFT_MicrosoftGraphbitLockerRemovableDrivePolicy | BitLocker Removable Drive Policy. | |
| **BitLockerSystemDrivePolicy** | Write | MSFT_MicrosoftGraphbitLockerSystemDrivePolicy | BitLocker System Drive Policy. | |
| **DefenderAdditionalGuardedFolders** | Write | StringArray[] | List of folder paths to be added to the list of protected folders | |
| **DefenderAdobeReaderLaunchChildProcess** | Write | String | Value indicating the behavior of Adobe Reader from creating child processes. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderAdvancedRansomewareProtectionType** | Write | String | Value indicating use of advanced protection against ransomeware. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderAllowBehaviorMonitoring** | Write | Boolean | Allows or disallows Windows Defender Behavior Monitoring functionality. | |
| **DefenderAllowCloudProtection** | Write | Boolean | To best protect your PC, Windows Defender will send information to Microsoft about any problems it finds. Microsoft will analyze that information, learn more about problems affecting you and other customers, and offer improved solutions. | |
| **DefenderAllowEndUserAccess** | Write | Boolean | Allows or disallows user access to the Windows Defender UI. If disallowed, all Windows Defender notifications will also be suppressed. | |
| **DefenderAllowIntrusionPreventionSystem** | Write | Boolean | Allows or disallows Windows Defender Intrusion Prevention functionality. | |
| **DefenderAllowOnAccessProtection** | Write | Boolean | Allows or disallows Windows Defender On Access Protection functionality. | |
| **DefenderAllowRealTimeMonitoring** | Write | Boolean | Allows or disallows Windows Defender Realtime Monitoring functionality. | |
| **DefenderAllowScanArchiveFiles** | Write | Boolean | Allows or disallows scanning of archives. | |
| **DefenderAllowScanDownloads** | Write | Boolean | Allows or disallows Windows Defender IOAVP Protection functionality. | |
| **DefenderAllowScanNetworkFiles** | Write | Boolean | Allows or disallows a scanning of network files. | |
| **DefenderAllowScanRemovableDrivesDuringFullScan** | Write | Boolean | Allows or disallows a full scan of removable drives. During a quick scan, removable drives may still be scanned. | |
| **DefenderAllowScanScriptsLoadedInInternetExplorer** | Write | Boolean | Allows or disallows Windows Defender Script Scanning functionality. | |
| **DefenderAttackSurfaceReductionExcludedPaths** | Write | StringArray[] | List of exe files and folders to be excluded from attack surface reduction rules | |
| **DefenderBlockEndUserAccess** | Write | Boolean | Allows or disallows user access to the Windows Defender UI. If disallowed, all Windows Defender notifications will also be suppressed. | |
| **DefenderBlockPersistenceThroughWmiType** | Write | String | Value indicating the behavior ofBlock persistence through WMI event subscription. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderCheckForSignaturesBeforeRunningScan** | Write | Boolean | This policy setting allows you to manage whether a check for new virus and spyware definitions will occur before running a scan. | |
| **DefenderCloudBlockLevel** | Write | String | Added in Windows 10, version 1709. This policy setting determines how aggressive Windows Defender Antivirus will be in blocking and scanning suspicious files. Value type is integer. This feature requires the 'Join Microsoft MAPS' setting enabled in order to function. Possible values are: notConfigured, high, highPlus, zeroTolerance. | `notConfigured`, `high`, `highPlus`, `zeroTolerance` |
| **DefenderCloudExtendedTimeoutInSeconds** | Write | UInt32 | Added in Windows 10, version 1709. This feature allows Windows Defender Antivirus to block a suspicious file for up to 60 seconds, and scan it in the cloud to make sure it's safe. Value type is integer, range is 0 - 50. This feature depends on three other MAPS settings the must all be enabled- 'Configure the 'Block at First Sight' feature 'Join Microsoft MAPS' 'Send file samples when further analysis is required'. Valid values 0 to 50 | |
| **DefenderDaysBeforeDeletingQuarantinedMalware** | Write | UInt32 | Time period (in days) that quarantine items will be stored on the system. Valid values 0 to 90 | |
| **DefenderDetectedMalwareActions** | Write | MSFT_MicrosoftGraphdefenderDetectedMalwareActions | Allows an administrator to specify any valid threat severity levels and the corresponding default action ID to take. | |
| **DefenderDisableBehaviorMonitoring** | Write | Boolean | Allows or disallows Windows Defender Behavior Monitoring functionality. | |
| **DefenderDisableCatchupFullScan** | Write | Boolean | This policy setting allows you to configure catch-up scans for scheduled full scans. A catch-up scan is a scan that is initiated because a regularly scheduled scan was missed. Usually these scheduled scans are missed because the computer was turned off at the scheduled time. | |
| **DefenderDisableCatchupQuickScan** | Write | Boolean | This policy setting allows you to configure catch-up scans for scheduled quick scans. A catch-up scan is a scan that is initiated because a regularly scheduled scan was missed. Usually these scheduled scans are missed because the computer was turned off at the scheduled time. | |
| **DefenderDisableCloudProtection** | Write | Boolean | To best protect your PC, Windows Defender will send information to Microsoft about any problems it finds. Microsoft will analyze that information, learn more about problems affecting you and other customers, and offer improved solutions. | |
| **DefenderDisableIntrusionPreventionSystem** | Write | Boolean | Allows or disallows Windows Defender Intrusion Prevention functionality. | |
| **DefenderDisableOnAccessProtection** | Write | Boolean | Allows or disallows Windows Defender On Access Protection functionality. | |
| **DefenderDisableRealTimeMonitoring** | Write | Boolean | Allows or disallows Windows Defender Realtime Monitoring functionality. | |
| **DefenderDisableScanArchiveFiles** | Write | Boolean | Allows or disallows scanning of archives. | |
| **DefenderDisableScanDownloads** | Write | Boolean | Allows or disallows Windows Defender IOAVP Protection functionality. | |
| **DefenderDisableScanNetworkFiles** | Write | Boolean | Allows or disallows a scanning of network files. | |
| **DefenderDisableScanRemovableDrivesDuringFullScan** | Write | Boolean | Allows or disallows a full scan of removable drives. During a quick scan, removable drives may still be scanned. | |
| **DefenderDisableScanScriptsLoadedInInternetExplorer** | Write | Boolean | Allows or disallows Windows Defender Script Scanning functionality. | |
| **DefenderEmailContentExecution** | Write | String | Value indicating if execution of executable content (exe, dll, ps, js, vbs, etc) should be dropped from email (webmail/mail-client). Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderEmailContentExecutionType** | Write | String | Value indicating if execution of executable content (exe, dll, ps, js, vbs, etc) should be dropped from email (webmail/mail-client). Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderEnableLowCpuPriority** | Write | Boolean | This policy setting allows you to enable or disable low CPU priority for scheduled scans. | |
| **DefenderEnableScanIncomingMail** | Write | Boolean | Allows or disallows scanning of email. | |
| **DefenderEnableScanMappedNetworkDrivesDuringFullScan** | Write | Boolean | Allows or disallows a full scan of mapped network drives. | |
| **DefenderExploitProtectionXml** | Write | String | Xml content containing information regarding exploit protection details. | |
| **DefenderExploitProtectionXmlFileName** | Write | String | Name of the file from which DefenderExploitProtectionXml was obtained. | |
| **DefenderFileExtensionsToExclude** | Write | StringArray[] | File extensions to exclude from scans and real time protection. | |
| **DefenderFilesAndFoldersToExclude** | Write | StringArray[] | Files and folder to exclude from scans and real time protection. | |
| **DefenderGuardedFoldersAllowedAppPaths** | Write | StringArray[] | List of paths to exe that are allowed to access protected folders | |
| **DefenderGuardMyFoldersType** | Write | String | Value indicating the behavior of protected folders. Possible values are: userDefined, enable, auditMode, blockDiskModification, auditDiskModification. | `userDefined`, `enable`, `auditMode`, `blockDiskModification`, `auditDiskModification` |
| **DefenderNetworkProtectionType** | Write | String | Value indicating the behavior of NetworkProtection. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeAppsExecutableContentCreationOrLaunch** | Write | String | Value indicating the behavior of Office applications/macros creating or launching executable content. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeAppsExecutableContentCreationOrLaunchType** | Write | String | Value indicating the behavior of Office applications/macros creating or launching executable content. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderOfficeAppsLaunchChildProcess** | Write | String | Value indicating the behavior of Office application launching child processes. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeAppsLaunchChildProcessType** | Write | String | Value indicating the behavior of Office application launching child processes. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderOfficeAppsOtherProcessInjection** | Write | String | Value indicating the behavior of Office applications injecting into other processes. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeAppsOtherProcessInjectionType** | Write | String | Value indicating the behavior ofOffice applications injecting into other processes. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderOfficeCommunicationAppsLaunchChildProcess** | Write | String | Value indicating the behavior of Office communication applications, including Microsoft Outlook, from creating child processes. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeMacroCodeAllowWin32Imports** | Write | String | Value indicating the behavior of Win32 imports from Macro code in Office. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderOfficeMacroCodeAllowWin32ImportsType** | Write | String | Value indicating the behavior of Win32 imports from Macro code in Office. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderPotentiallyUnwantedAppAction** | Write | String | Added in Windows 10, version 1607. Specifies the level of detection for potentially unwanted applications (PUAs). Windows Defender alerts you when potentially unwanted software is being downloaded or attempts to install itself on your computer. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderPreventCredentialStealingType** | Write | String | Value indicating if credential stealing from the Windows local security authority subsystem is permitted. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderProcessCreation** | Write | String | Value indicating response to process creations originating from PSExec and WMI commands. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderProcessCreationType** | Write | String | Value indicating response to process creations originating from PSExec and WMI commands. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderProcessesToExclude** | Write | StringArray[] | Processes to exclude from scans and real time protection. | |
| **DefenderScanDirection** | Write | String | Controls which sets of files should be monitored. Possible values are: monitorAllFiles, monitorIncomingFilesOnly, monitorOutgoingFilesOnly. | `monitorAllFiles`, `monitorIncomingFilesOnly`, `monitorOutgoingFilesOnly` |
| **DefenderScanMaxCpuPercentage** | Write | UInt32 | Represents the average CPU load factor for the Windows Defender scan (in percent). The default value is 50. Valid values 0 to 100 | |
| **DefenderScanType** | Write | String | Selects whether to perform a quick scan or full scan. Possible values are: userDefined, disabled, quick, full. | `userDefined`, `disabled`, `quick`, `full` |
| **DefenderScheduledQuickScanTime** | Write | String | Selects the time of day that the Windows Defender quick scan should run. For example, a value of 0=12:00AM, a value of 60=1:00AM, a value of 120=2:00, and so on, up to a value of 1380=11:00PM. The default value is 120 | |
| **DefenderScheduledScanDay** | Write | String | Selects the day that the Windows Defender scan should run. Possible values are: userDefined, everyday, sunday, monday, tuesday, wednesday, thursday, friday, saturday, noScheduledScan. | `userDefined`, `everyday`, `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `noScheduledScan` |
| **DefenderScheduledScanTime** | Write | String | Selects the time of day that the Windows Defender scan should run. | |
| **DefenderScriptDownloadedPayloadExecution** | Write | String | Value indicating the behavior of js/vbs executing payload downloaded from Internet. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderScriptDownloadedPayloadExecutionType** | Write | String | Value indicating the behavior of js/vbs executing payload downloaded from Internet. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderScriptObfuscatedMacroCode** | Write | String | Value indicating the behavior of obfuscated js/vbs/ps/macro code. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderScriptObfuscatedMacroCodeType** | Write | String | Value indicating the behavior of obfuscated js/vbs/ps/macro code. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderSecurityCenterBlockExploitProtectionOverride** | Write | Boolean | Indicates whether or not to block user from overriding Exploit Protection settings. | |
| **DefenderSecurityCenterDisableAccountUI** | Write | Boolean | Used to disable the display of the account protection area. | |
| **DefenderSecurityCenterDisableAppBrowserUI** | Write | Boolean | Used to disable the display of the app and browser protection area. | |
| **DefenderSecurityCenterDisableClearTpmUI** | Write | Boolean | Used to disable the display of the Clear TPM button. | |
| **DefenderSecurityCenterDisableFamilyUI** | Write | Boolean | Used to disable the display of the family options area. | |
| **DefenderSecurityCenterDisableHardwareUI** | Write | Boolean | Used to disable the display of the hardware protection area. | |
| **DefenderSecurityCenterDisableHealthUI** | Write | Boolean | Used to disable the display of the device performance and health area. | |
| **DefenderSecurityCenterDisableNetworkUI** | Write | Boolean | Used to disable the display of the firewall and network protection area. | |
| **DefenderSecurityCenterDisableNotificationAreaUI** | Write | Boolean | Used to disable the display of the notification area control. The user needs to either sign out and sign in or reboot the computer for this setting to take effect. | |
| **DefenderSecurityCenterDisableRansomwareUI** | Write | Boolean | Used to disable the display of the ransomware protection area. | |
| **DefenderSecurityCenterDisableSecureBootUI** | Write | Boolean | Used to disable the display of the secure boot area under Device security. | |
| **DefenderSecurityCenterDisableTroubleshootingUI** | Write | Boolean | Used to disable the display of the security process troubleshooting under Device security. | |
| **DefenderSecurityCenterDisableVirusUI** | Write | Boolean | Used to disable the display of the virus and threat protection area. | |
| **DefenderSecurityCenterDisableVulnerableTpmFirmwareUpdateUI** | Write | Boolean | Used to disable the display of update TPM Firmware when a vulnerable firmware is detected. | |
| **DefenderSecurityCenterHelpEmail** | Write | String | The email address that is displayed to users. | |
| **DefenderSecurityCenterHelpPhone** | Write | String | The phone number or Skype ID that is displayed to users. | |
| **DefenderSecurityCenterHelpURL** | Write | String | The help portal URL this is displayed to users. | |
| **DefenderSecurityCenterITContactDisplay** | Write | String | Configure where to display IT contact information to end users. Possible values are: notConfigured, displayInAppAndInNotifications, displayOnlyInApp, displayOnlyInNotifications. | `notConfigured`, `displayInAppAndInNotifications`, `displayOnlyInApp`, `displayOnlyInNotifications` |
| **DefenderSecurityCenterNotificationsFromApp** | Write | String | Notifications to show from the displayed areas of app. Possible values are: notConfigured, blockNoncriticalNotifications, blockAllNotifications. | `notConfigured`, `blockNoncriticalNotifications`, `blockAllNotifications` |
| **DefenderSecurityCenterOrganizationDisplayName** | Write | String | The company name that is displayed to the users. | |
| **DefenderSignatureUpdateIntervalInHours** | Write | UInt32 | Specifies the interval (in hours) that will be used to check for signatures, so instead of using the ScheduleDay and ScheduleTime the check for new signatures will be set according to the interval. Valid values 0 to 24 | |
| **DefenderSubmitSamplesConsentType** | Write | String | Checks for the user consent level in Windows Defender to send data. Possible values are: sendSafeSamplesAutomatically, alwaysPrompt, neverSend, sendAllSamplesAutomatically. | `sendSafeSamplesAutomatically`, `alwaysPrompt`, `neverSend`, `sendAllSamplesAutomatically` |
| **DefenderUntrustedExecutable** | Write | String | Value indicating response to executables that don't meet a prevalence, age, or trusted list criteria. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderUntrustedExecutableType** | Write | String | Value indicating response to executables that don't meet a prevalence, age, or trusted list criteria. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DefenderUntrustedUSBProcess** | Write | String | Value indicating response to untrusted and unsigned processes that run from USB. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderUntrustedUSBProcessType** | Write | String | Value indicating response to untrusted and unsigned processes that run from USB. Possible values are: userDefined, block, auditMode, warn, disable. | `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **DeviceGuardEnableSecureBootWithDMA** | Write | Boolean | This property will be deprecated in May 2019 and will be replaced with property DeviceGuardSecureBootWithDMA. Specifies whether Platform Security Level is enabled at next reboot. | |
| **DeviceGuardEnableVirtualizationBasedSecurity** | Write | Boolean | Turns On Virtualization Based Security(VBS). | |
| **DeviceGuardLaunchSystemGuard** | Write | String | Allows the IT admin to configure the launch of System Guard. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **DeviceGuardLocalSystemAuthorityCredentialGuardSettings** | Write | String | Turn on Credential Guard when Platform Security Level with Secure Boot and Virtualization Based Security are both enabled. Possible values are: notConfigured, enableWithUEFILock, enableWithoutUEFILock, disable. | `notConfigured`, `enableWithUEFILock`, `enableWithoutUEFILock`, `disable` |
| **DeviceGuardSecureBootWithDMA** | Write | String | Specifies whether Platform Security Level is enabled at next reboot. Possible values are: notConfigured, withoutDMA, withDMA. | `notConfigured`, `withoutDMA`, `withDMA` |
| **DmaGuardDeviceEnumerationPolicy** | Write | String | This policy is intended to provide additional security against external DMA capable devices. It allows for more control over the enumeration of external DMA capable devices incompatible with DMA Remapping/device memory isolation and sandboxing. This policy only takes effect when Kernel DMA Protection is supported and enabled by the system firmware. Kernel DMA Protection is a platform feature that cannot be controlled via policy or by end user. It has to be supported by the system at the time of manufacturing. To check if the system supports Kernel DMA Protection, please check the Kernel DMA Protection field in the Summary page of MSINFO32.exe. Possible values are: deviceDefault, blockAll, allowAll. | `deviceDefault`, `blockAll`, `allowAll` |
| **FirewallBlockStatefulFTP** | Write | Boolean | Blocks stateful FTP connections to the device | |
| **FirewallCertificateRevocationListCheckMethod** | Write | String | Specify how the certificate revocation list is to be enforced. Possible values are: deviceDefault, none, attempt, require. | `deviceDefault`, `none`, `attempt`, `require` |
| **FirewallIdleTimeoutForSecurityAssociationInSeconds** | Write | UInt32 | Configures the idle timeout for security associations, in seconds, from 300 to 3600 inclusive. This is the period after which security associations will expire and be deleted. Valid values 300 to 3600 | |
| **FirewallIPSecExemptionsAllowDHCP** | Write | Boolean | Configures IPSec exemptions to allow both IPv4 and IPv6 DHCP traffic | |
| **FirewallIPSecExemptionsAllowICMP** | Write | Boolean | Configures IPSec exemptions to allow ICMP | |
| **FirewallIPSecExemptionsAllowNeighborDiscovery** | Write | Boolean | Configures IPSec exemptions to allow neighbor discovery IPv6 ICMP type-codes | |
| **FirewallIPSecExemptionsAllowRouterDiscovery** | Write | Boolean | Configures IPSec exemptions to allow router discovery IPv6 ICMP type-codes | |
| **FirewallIPSecExemptionsNone** | Write | Boolean | Configures IPSec exemptions to no exemptions | |
| **FirewallMergeKeyingModuleSettings** | Write | Boolean | If an authentication set is not fully supported by a keying module, direct the module to ignore only unsupported authentication suites rather than the entire set | |
| **FirewallPacketQueueingMethod** | Write | String | Configures how packet queueing should be applied in the tunnel gateway scenario. Possible values are: deviceDefault, disabled, queueInbound, queueOutbound, queueBoth. | `deviceDefault`, `disabled`, `queueInbound`, `queueOutbound`, `queueBoth` |
| **FirewallPreSharedKeyEncodingMethod** | Write | String | Select the preshared key encoding to be used. Possible values are: deviceDefault, none, utF8. | `deviceDefault`, `none`, `utF8` |
| **FirewallProfileDomain** | Write | MSFT_MicrosoftGraphwindowsFirewallNetworkProfile | Configures the firewall profile settings for domain networks | |
| **FirewallProfilePrivate** | Write | MSFT_MicrosoftGraphwindowsFirewallNetworkProfile | Configures the firewall profile settings for private networks | |
| **FirewallProfilePublic** | Write | MSFT_MicrosoftGraphwindowsFirewallNetworkProfile | Configures the firewall profile settings for public networks | |
| **FirewallRules** | Write | MSFT_MicrosoftGraphwindowsFirewallRule[] | Configures the firewall rule settings. This collection can contain a maximum of 150 elements. | |
| **LanManagerAuthenticationLevel** | Write | String | This security setting determines which challenge/response authentication protocol is used for network logons. Possible values are: lmAndNltm, lmNtlmAndNtlmV2, lmAndNtlmOnly, lmAndNtlmV2, lmNtlmV2AndNotLm, lmNtlmV2AndNotLmOrNtm. | `lmAndNltm`, `lmNtlmAndNtlmV2`, `lmAndNtlmOnly`, `lmAndNtlmV2`, `lmNtlmV2AndNotLm`, `lmNtlmV2AndNotLmOrNtm` |
| **LanManagerWorkstationDisableInsecureGuestLogons** | Write | Boolean | If enabled,the SMB client will allow insecure guest logons. If not configured, the SMB client will reject insecure guest logons. | |
| **LocalSecurityOptionsAdministratorAccountName** | Write | String | Define a different account name to be associated with the security identifier (SID) for the account 'Administrator'. | |
| **LocalSecurityOptionsAdministratorElevationPromptBehavior** | Write | String | Define the behavior of the elevation prompt for admins in Admin Approval Mode. Possible values are: notConfigured, elevateWithoutPrompting, promptForCredentialsOnTheSecureDesktop, promptForConsentOnTheSecureDesktop, promptForCredentials, promptForConsent, promptForConsentForNonWindowsBinaries. | `notConfigured`, `elevateWithoutPrompting`, `promptForCredentialsOnTheSecureDesktop`, `promptForConsentOnTheSecureDesktop`, `promptForCredentials`, `promptForConsent`, `promptForConsentForNonWindowsBinaries` |
| **LocalSecurityOptionsAllowAnonymousEnumerationOfSAMAccountsAndShares** | Write | Boolean | This security setting determines whether to allows anonymous users to perform certain activities, such as enumerating the names of domain accounts and network shares. | |
| **LocalSecurityOptionsAllowPKU2UAuthenticationRequests** | Write | Boolean | Block PKU2U authentication requests to this device to use online identities. | |
| **LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManager** | Write | String | Edit the default Security Descriptor Definition Language string to allow or deny users and groups to make remote calls to the SAM. | |
| **LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManagerHelperBool** | Write | Boolean | UI helper boolean for LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManager entity | |
| **LocalSecurityOptionsAllowSystemToBeShutDownWithoutHavingToLogOn** | Write | Boolean | This security setting determines whether a computer can be shut down without having to log on to Windows. | |
| **LocalSecurityOptionsAllowUIAccessApplicationElevation** | Write | Boolean | Allow UIAccess apps to prompt for elevation without using the secure desktop. | |
| **LocalSecurityOptionsAllowUIAccessApplicationsForSecureLocations** | Write | Boolean | Allow UIAccess apps to prompt for elevation without using the secure desktop.Default is enabled | |
| **LocalSecurityOptionsAllowUndockWithoutHavingToLogon** | Write | Boolean | Prevent a portable computer from being undocked without having to log in. | |
| **LocalSecurityOptionsBlockMicrosoftAccounts** | Write | Boolean | Prevent users from adding new Microsoft accounts to this computer. | |
| **LocalSecurityOptionsBlockRemoteLogonWithBlankPassword** | Write | Boolean | Enable Local accounts that are not password protected to log on from locations other than the physical device.Default is enabled | |
| **LocalSecurityOptionsBlockRemoteOpticalDriveAccess** | Write | Boolean | Enabling this settings allows only interactively logged on user to access CD-ROM media. | |
| **LocalSecurityOptionsBlockUsersInstallingPrinterDrivers** | Write | Boolean | Restrict installing printer drivers as part of connecting to a shared printer to admins only. | |
| **LocalSecurityOptionsClearVirtualMemoryPageFile** | Write | Boolean | This security setting determines whether the virtual memory pagefile is cleared when the system is shut down. | |
| **LocalSecurityOptionsClientDigitallySignCommunicationsAlways** | Write | Boolean | This security setting determines whether packet signing is required by the SMB client component. | |
| **LocalSecurityOptionsClientSendUnencryptedPasswordToThirdPartySMBServers** | Write | Boolean | If this security setting is enabled, the Server Message Block (SMB) redirector is allowed to send plaintext passwords to non-Microsoft SMB servers that do not support password encryption during authentication. | |
| **LocalSecurityOptionsDetectApplicationInstallationsAndPromptForElevation** | Write | Boolean | App installations requiring elevated privileges will prompt for admin credentials.Default is enabled | |
| **LocalSecurityOptionsDisableAdministratorAccount** | Write | Boolean | Determines whether the Local Administrator account is enabled or disabled. | |
| **LocalSecurityOptionsDisableClientDigitallySignCommunicationsIfServerAgrees** | Write | Boolean | This security setting determines whether the SMB client attempts to negotiate SMB packet signing. | |
| **LocalSecurityOptionsDisableGuestAccount** | Write | Boolean | Determines if the Guest account is enabled or disabled. | |
| **LocalSecurityOptionsDisableServerDigitallySignCommunicationsAlways** | Write | Boolean | This security setting determines whether packet signing is required by the SMB server component. | |
| **LocalSecurityOptionsDisableServerDigitallySignCommunicationsIfClientAgrees** | Write | Boolean | This security setting determines whether the SMB server will negotiate SMB packet signing with clients that request it. | |
| **LocalSecurityOptionsDoNotAllowAnonymousEnumerationOfSAMAccounts** | Write | Boolean | This security setting determines what additional permissions will be granted for anonymous connections to the computer. | |
| **LocalSecurityOptionsDoNotRequireCtrlAltDel** | Write | Boolean | Require CTRL+ALT+DEL to be pressed before a user can log on. | |
| **LocalSecurityOptionsDoNotStoreLANManagerHashValueOnNextPasswordChange** | Write | Boolean | This security setting determines if, at the next password change, the LAN Manager (LM) hash value for the new password is stored. Its not stored by default. | |
| **LocalSecurityOptionsFormatAndEjectOfRemovableMediaAllowedUser** | Write | String | Define who is allowed to format and eject removable NTFS media. Possible values are: notConfigured, administrators, administratorsAndPowerUsers, administratorsAndInteractiveUsers. | `notConfigured`, `administrators`, `administratorsAndPowerUsers`, `administratorsAndInteractiveUsers` |
| **LocalSecurityOptionsGuestAccountName** | Write | String | Define a different account name to be associated with the security identifier (SID) for the account 'Guest'. | |
| **LocalSecurityOptionsHideLastSignedInUser** | Write | Boolean | Do not display the username of the last person who signed in on this device. | |
| **LocalSecurityOptionsHideUsernameAtSignIn** | Write | Boolean | Do not display the username of the person signing in to this device after credentials are entered and before the devices desktop is shown. | |
| **LocalSecurityOptionsInformationDisplayedOnLockScreen** | Write | String | Configure the user information that is displayed when the session is locked. If not configured, user display name, domain and username are shown. Possible values are: notConfigured, administrators, administratorsAndPowerUsers, administratorsAndInteractiveUsers. | `notConfigured`, `administrators`, `administratorsAndPowerUsers`, `administratorsAndInteractiveUsers` |
| **LocalSecurityOptionsInformationShownOnLockScreen** | Write | String | Configure the user information that is displayed when the session is locked. If not configured, user display name, domain and username are shown. Possible values are: notConfigured, userDisplayNameDomainUser, userDisplayNameOnly, doNotDisplayUser. | `notConfigured`, `userDisplayNameDomainUser`, `userDisplayNameOnly`, `doNotDisplayUser` |
| **LocalSecurityOptionsLogOnMessageText** | Write | String | Set message text for users attempting to log in. | |
| **LocalSecurityOptionsLogOnMessageTitle** | Write | String | Set message title for users attempting to log in. | |
| **LocalSecurityOptionsMachineInactivityLimit** | Write | UInt32 | Define maximum minutes of inactivity on the interactive desktops login screen until the screen saver runs. Valid values 0 to 9999 | |
| **LocalSecurityOptionsMachineInactivityLimitInMinutes** | Write | UInt32 | Define maximum minutes of inactivity on the interactive desktops login screen until the screen saver runs. Valid values 0 to 9999 | |
| **LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedClients** | Write | String | This security setting allows a client to require the negotiation of 128-bit encryption and/or NTLMv2 session security. Possible values are: none, requireNtmlV2SessionSecurity, require128BitEncryption, ntlmV2And128BitEncryption. | `none`, `requireNtmlV2SessionSecurity`, `require128BitEncryption`, `ntlmV2And128BitEncryption` |
| **LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedServers** | Write | String | This security setting allows a server to require the negotiation of 128-bit encryption and/or NTLMv2 session security. Possible values are: none, requireNtmlV2SessionSecurity, require128BitEncryption, ntlmV2And128BitEncryption. | `none`, `requireNtmlV2SessionSecurity`, `require128BitEncryption`, `ntlmV2And128BitEncryption` |
| **LocalSecurityOptionsOnlyElevateSignedExecutables** | Write | Boolean | Enforce PKI certification path validation for a given executable file before it is permitted to run. | |
| **LocalSecurityOptionsRestrictAnonymousAccessToNamedPipesAndShares** | Write | Boolean | By default, this security setting restricts anonymous access to shares and pipes to the settings for named pipes that can be accessed anonymously and Shares that can be accessed anonymously | |
| **LocalSecurityOptionsSmartCardRemovalBehavior** | Write | String | This security setting determines what happens when the smart card for a logged-on user is removed from the smart card reader. Possible values are: noAction, lockWorkstation, forceLogoff, disconnectRemoteDesktopSession. | `noAction`, `lockWorkstation`, `forceLogoff`, `disconnectRemoteDesktopSession` |
| **LocalSecurityOptionsStandardUserElevationPromptBehavior** | Write | String | Define the behavior of the elevation prompt for standard users. Possible values are: notConfigured, automaticallyDenyElevationRequests, promptForCredentialsOnTheSecureDesktop, promptForCredentials. | `notConfigured`, `automaticallyDenyElevationRequests`, `promptForCredentialsOnTheSecureDesktop`, `promptForCredentials` |
| **LocalSecurityOptionsSwitchToSecureDesktopWhenPromptingForElevation** | Write | Boolean | Enable all elevation requests to go to the interactive user's desktop rather than the secure desktop. Prompt behavior policy settings for admins and standard users are used. | |
| **LocalSecurityOptionsUseAdminApprovalMode** | Write | Boolean | Defines whether the built-in admin account uses Admin Approval Mode or runs all apps with full admin privileges.Default is enabled | |
| **LocalSecurityOptionsUseAdminApprovalModeForAdministrators** | Write | Boolean | Define whether Admin Approval Mode and all UAC policy settings are enabled, default is enabled | |
| **LocalSecurityOptionsVirtualizeFileAndRegistryWriteFailuresToPerUserLocations** | Write | Boolean | Virtualize file and registry write failures to per user locations | |
| **SmartScreenBlockOverrideForFiles** | Write | Boolean | Allows IT Admins to control whether users can can ignore SmartScreen warnings and run malicious files. | |
| **SmartScreenEnableInShell** | Write | Boolean | Allows IT Admins to configure SmartScreen for Windows. | |
| **UserRightsAccessCredentialManagerAsTrustedCaller** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right is used by Credential Manager during Backup/Restore. Users' saved credentials might be compromised if this privilege is given to other entities. Only states NotConfigured and Allowed are supported | |
| **UserRightsActAsPartOfTheOperatingSystem** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right allows a process to impersonate any user without authentication. The process can therefore gain access to the same local resources as that user. Only states NotConfigured and Allowed are supported | |
| **UserRightsAllowAccessFromNetwork** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups are allowed to connect to the computer over the network. State Allowed is supported. | |
| **UserRightsBackupData** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can bypass file, directory, registry, and other persistent objects permissions when backing up files and directories. Only states NotConfigured and Allowed are supported | |
| **UserRightsBlockAccessFromNetwork** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups are block from connecting to the computer over the network. State Block is supported. | |
| **UserRightsChangeSystemTime** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups can change the time and date on the internal clock of the computer. Only states NotConfigured and Allowed are supported | |
| **UserRightsCreateGlobalObjects** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This security setting determines whether users can create global objects that are available to all sessions. Users who can create global objects could affect processes that run under other users' sessions, which could lead to application failure or data corruption. Only states NotConfigured and Allowed are supported | |
| **UserRightsCreatePageFile** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups can call an internal API to create and change the size of a page file. Only states NotConfigured and Allowed are supported | |
| **UserRightsCreatePermanentSharedObjects** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which accounts can be used by processes to create a directory object using the object manager. Only states NotConfigured and Allowed are supported | |
| **UserRightsCreateSymbolicLinks** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines if the user can create a symbolic link from the computer to which they are logged on. Only states NotConfigured and Allowed are supported | |
| **UserRightsCreateToken** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users/groups can be used by processes to create a token that can then be used to get access to any local resources when the process uses an internal API to create an access token. Only states NotConfigured and Allowed are supported | |
| **UserRightsDebugPrograms** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can attach a debugger to any process or to the kernel. Only states NotConfigured and Allowed are supported | |
| **UserRightsDelegation** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can set the Trusted for Delegation setting on a user or computer object. Only states NotConfigured and Allowed are supported. | |
| **UserRightsDenyLocalLogOn** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users cannot log on to the computer. States NotConfigured, Blocked are supported | |
| **UserRightsGenerateSecurityAudits** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which accounts can be used by a process to add entries to the security log. The security log is used to trace unauthorized system access.  Only states NotConfigured and Allowed are supported. | |
| **UserRightsImpersonateClient** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | Assigning this user right to a user allows programs running on behalf of that user to impersonate a client. Requiring this user right for this kind of impersonation prevents an unauthorized user from convincing a client to connect to a service that they have created and then impersonating that client, which can elevate the unauthorized user's permissions to administrative or system levels. Only states NotConfigured and Allowed are supported. | |
| **UserRightsIncreaseSchedulingPriority** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which accounts can use a process with Write Property access to another process to increase the execution priority assigned to the other process. Only states NotConfigured and Allowed are supported. | |
| **UserRightsLoadUnloadDrivers** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can dynamically load and unload device drivers or other code in to kernel mode. Only states NotConfigured and Allowed are supported. | |
| **UserRightsLocalLogOn** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can log on to the computer. States NotConfigured, Allowed are supported | |
| **UserRightsLockMemory** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which accounts can use a process to keep data in physical memory, which prevents the system from paging the data to virtual memory on disk. Only states NotConfigured and Allowed are supported. | |
| **UserRightsManageAuditingAndSecurityLogs** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can specify object access auditing options for individual resources, such as files, Active Directory objects, and registry keys. Only states NotConfigured and Allowed are supported. | |
| **UserRightsManageVolumes** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups can run maintenance tasks on a volume, such as remote defragmentation. Only states NotConfigured and Allowed are supported. | |
| **UserRightsModifyFirmwareEnvironment** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines who can modify firmware environment values. Only states NotConfigured and Allowed are supported. | |
| **UserRightsModifyObjectLabels** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which user accounts can modify the integrity label of objects, such as files, registry keys, or processes owned by other users. Only states NotConfigured and Allowed are supported. | |
| **UserRightsProfileSingleProcess** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can use performance monitoring tools to monitor the performance of system processes. Only states NotConfigured and Allowed are supported. | |
| **UserRightsRemoteDesktopServicesLogOn** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users and groups are prohibited from logging on as a Remote Desktop Services client. Only states NotConfigured and Blocked are supported | |
| **UserRightsRemoteShutdown** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users are allowed to shut down a computer from a remote location on the network. Misuse of this user right can result in a denial of service. Only states NotConfigured and Allowed are supported. | |
| **UserRightsRestoreData** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can bypass file, directory, registry, and other persistent objects permissions when restoring backed up files and directories, and determines which users can set any valid security principal as the owner of an object. Only states NotConfigured and Allowed are supported. | |
| **UserRightsTakeOwnership** | Write | MSFT_MicrosoftGraphdeviceManagementUserRightsSetting | This user right determines which users can take ownership of any securable object in the system, including Active Directory objects, files and folders, printers, registry keys, processes, and threads. Only states NotConfigured and Allowed are supported. | |
| **WindowsDefenderTamperProtection** | Write | String | Configure windows defender TamperProtection settings. Possible values are: notConfigured, enable, disable. | `notConfigured`, `enable`, `disable` |
| **XboxServicesAccessoryManagementServiceStartupMode** | Write | String | This setting determines whether the Accessory management service's start type is Automatic(2), Manual(3), Disabled(4). Default: Manual. Possible values are: manual, automatic, disabled. | `manual`, `automatic`, `disabled` |
| **XboxServicesEnableXboxGameSaveTask** | Write | Boolean | This setting determines whether xbox game save is enabled (1) or disabled (0). | |
| **XboxServicesLiveAuthManagerServiceStartupMode** | Write | String | This setting determines whether Live Auth Manager service's start type is Automatic(2), Manual(3), Disabled(4). Default: Manual. Possible values are: manual, automatic, disabled. | `manual`, `automatic`, `disabled` |
| **XboxServicesLiveGameSaveServiceStartupMode** | Write | String | This setting determines whether Live Game save service's start type is Automatic(2), Manual(3), Disabled(4). Default: Manual. Possible values are: manual, automatic, disabled. | `manual`, `automatic`, `disabled` |
| **XboxServicesLiveNetworkingServiceStartupMode** | Write | String | This setting determines whether Networking service's start type is Automatic(2), Manual(3), Disabled(4). Default: Manual. Possible values are: manual, automatic, disabled. | `manual`, `automatic`, `disabled` |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **SupportsScopeTags** | Write | Boolean | Indicates whether or not the underlying Device Configuration supports the assignment of scope tags. Assigning to the ScopeTags property is not allowed when this value is false and entities will not be visible to scoped users. This occurs for Legacy policies created in Silverlight and can be resolved by deleting and recreating the policy in the Azure Portal. This property is read-only. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
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

### MSFT_MicrosoftGraphBitLockerFixedDrivePolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EncryptionMethod** | Write | String | Select the encryption method for fixed drives. Possible values are: aesCbc128, aesCbc256, xtsAes128, xtsAes256. | `aesCbc128`, `aesCbc256`, `xtsAes128`, `xtsAes256` |
| **RecoveryOptions** | Write | MSFT_MicrosoftGraphBitLockerRecoveryOptions | This policy setting allows you to control how BitLocker-protected fixed data drives are recovered in the absence of the required credentials. This policy setting is applied when you turn on BitLocker. | |
| **RequireEncryptionForWriteAccess** | Write | Boolean | This policy setting determines whether BitLocker protection is required for fixed data drives to be writable on a computer. | |

### MSFT_MicrosoftGraphBitLockerRecoveryOptions

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BlockDataRecoveryAgent** | Write | Boolean | Indicates whether to block certificate-based data recovery agent. | |
| **EnableBitLockerAfterRecoveryInformationToStore** | Write | Boolean | Indicates whether or not to enable BitLocker until recovery information is stored in AD DS. | |
| **EnableRecoveryInformationSaveToStore** | Write | Boolean | Indicates whether or not to allow BitLocker recovery information to store in AD DS. | |
| **HideRecoveryOptions** | Write | Boolean | Indicates whether or not to allow showing recovery options in BitLocker Setup Wizard for fixed or system disk. | |
| **RecoveryInformationToStore** | Write | String | Configure what pieces of BitLocker recovery information are stored to AD DS. Possible values are: passwordAndKey, passwordOnly. | `passwordAndKey`, `passwordOnly` |
| **RecoveryKeyUsage** | Write | String | Indicates whether users are allowed or required to generate a 256-bit recovery key for fixed or system disk. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **RecoveryPasswordUsage** | Write | String | Indicates whether users are allowed or required to generate a 48-digit recovery password for fixed or system disk. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |

### MSFT_MicrosoftGraphBitLockerRemovableDrivePolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BlockCrossOrganizationWriteAccess** | Write | Boolean | This policy setting determines whether BitLocker protection is required for removable data drives to be writable on a computer. | |
| **EncryptionMethod** | Write | String | Select the encryption method for removable  drives. Possible values are: aesCbc128, aesCbc256, xtsAes128, xtsAes256. | `aesCbc128`, `aesCbc256`, `xtsAes128`, `xtsAes256` |
| **RequireEncryptionForWriteAccess** | Write | Boolean | Indicates whether to block write access to devices configured in another organization.  If requireEncryptionForWriteAccess is false, this value does not affect. | |

### MSFT_MicrosoftGraphBitLockerSystemDrivePolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EncryptionMethod** | Write | String | Select the encryption method for operating system drives. Possible values are: aesCbc128, aesCbc256, xtsAes128, xtsAes256. | `aesCbc128`, `aesCbc256`, `xtsAes128`, `xtsAes256` |
| **MinimumPinLength** | Write | UInt32 | Indicates the minimum length of startup pin. Valid values 4 to 20 | |
| **PrebootRecoveryEnableMessageAndUrl** | Write | Boolean | Enable pre-boot recovery message and Url. If requireStartupAuthentication is false, this value does not affect. | |
| **PrebootRecoveryMessage** | Write | String | Defines a custom recovery message. | |
| **PrebootRecoveryUrl** | Write | String | Defines a custom recovery URL. | |
| **RecoveryOptions** | Write | MSFT_MicrosoftGraphBitLockerRecoveryOptions | Allows to recover BitLocker encrypted operating system drives in the absence of the required startup key information. This policy setting is applied when you turn on BitLocker. | |
| **StartupAuthenticationBlockWithoutTpmChip** | Write | Boolean | Indicates whether to allow BitLocker without a compatible TPM (requires a password or a startup key on a USB flash drive). | |
| **StartupAuthenticationRequired** | Write | Boolean | Require additional authentication at startup. | |
| **StartupAuthenticationTpmKeyUsage** | Write | String | Indicates if TPM startup key is allowed/required/disallowed. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **StartupAuthenticationTpmPinAndKeyUsage** | Write | String | Indicates if TPM startup pin key and key are allowed/required/disallowed. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **StartupAuthenticationTpmPinUsage** | Write | String | Indicates if TPM startup pin is allowed/required/disallowed. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **StartupAuthenticationTpmUsage** | Write | String | Indicates if TPM startup is allowed/required/disallowed. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |

### MSFT_MicrosoftGraphDefenderDetectedMalwareActions

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **HighSeverity** | Write | String | Indicates a Defender action to take for high severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **LowSeverity** | Write | String | Indicates a Defender action to take for low severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **ModerateSeverity** | Write | String | Indicates a Defender action to take for moderate severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **SevereSeverity** | Write | String | Indicates a Defender action to take for severe severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |

### MSFT_MicrosoftGraphWindowsFirewallNetworkProfile

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AuthorizedApplicationRulesFromGroupPolicyMerged** | Write | Boolean | Configures the firewall to merge authorized application rules from group policy with those from local store instead of ignoring the local store rules. When AuthorizedApplicationRulesFromGroupPolicyNotMerged and AuthorizedApplicationRulesFromGroupPolicyMerged are both true, AuthorizedApplicationRulesFromGroupPolicyMerged takes priority. | |
| **AuthorizedApplicationRulesFromGroupPolicyNotMerged** | Write | Boolean | Configures the firewall to prevent merging authorized application rules from group policy with those from local store instead of ignoring the local store rules. When AuthorizedApplicationRulesFromGroupPolicyNotMerged and AuthorizedApplicationRulesFromGroupPolicyMerged are both true, AuthorizedApplicationRulesFromGroupPolicyMerged takes priority. | |
| **ConnectionSecurityRulesFromGroupPolicyMerged** | Write | Boolean | Configures the firewall to merge connection security rules from group policy with those from local store instead of ignoring the local store rules. When ConnectionSecurityRulesFromGroupPolicyNotMerged and ConnectionSecurityRulesFromGroupPolicyMerged are both true, ConnectionSecurityRulesFromGroupPolicyMerged takes priority. | |
| **ConnectionSecurityRulesFromGroupPolicyNotMerged** | Write | Boolean | Configures the firewall to prevent merging connection security rules from group policy with those from local store instead of ignoring the local store rules. When ConnectionSecurityRulesFromGroupPolicyNotMerged and ConnectionSecurityRulesFromGroupPolicyMerged are both true, ConnectionSecurityRulesFromGroupPolicyMerged takes priority. | |
| **FirewallEnabled** | Write | String | Configures the host device to allow or block the firewall and advanced security enforcement for the network profile. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **GlobalPortRulesFromGroupPolicyMerged** | Write | Boolean | Configures the firewall to merge global port rules from group policy with those from local store instead of ignoring the local store rules. When GlobalPortRulesFromGroupPolicyNotMerged and GlobalPortRulesFromGroupPolicyMerged are both true, GlobalPortRulesFromGroupPolicyMerged takes priority. | |
| **GlobalPortRulesFromGroupPolicyNotMerged** | Write | Boolean | Configures the firewall to prevent merging global port rules from group policy with those from local store instead of ignoring the local store rules. When GlobalPortRulesFromGroupPolicyNotMerged and GlobalPortRulesFromGroupPolicyMerged are both true, GlobalPortRulesFromGroupPolicyMerged takes priority. | |
| **InboundConnectionsBlocked** | Write | Boolean | Configures the firewall to block all incoming connections by default. When InboundConnectionsRequired and InboundConnectionsBlocked are both true, InboundConnectionsBlocked takes priority. | |
| **InboundConnectionsRequired** | Write | Boolean | Configures the firewall to allow all incoming connections by default. When InboundConnectionsRequired and InboundConnectionsBlocked are both true, InboundConnectionsBlocked takes priority. | |
| **InboundNotificationsBlocked** | Write | Boolean | Prevents the firewall from displaying notifications when an application is blocked from listening on a port. When InboundNotificationsRequired and InboundNotificationsBlocked are both true, InboundNotificationsBlocked takes priority. | |
| **InboundNotificationsRequired** | Write | Boolean | Allows the firewall to display notifications when an application is blocked from listening on a port. When InboundNotificationsRequired and InboundNotificationsBlocked are both true, InboundNotificationsBlocked takes priority. | |
| **IncomingTrafficBlocked** | Write | Boolean | Configures the firewall to block all incoming traffic regardless of other policy settings. When IncomingTrafficRequired and IncomingTrafficBlocked are both true, IncomingTrafficBlocked takes priority. | |
| **IncomingTrafficRequired** | Write | Boolean | Configures the firewall to allow incoming traffic pursuant to other policy settings. When IncomingTrafficRequired and IncomingTrafficBlocked are both true, IncomingTrafficBlocked takes priority. | |
| **OutboundConnectionsBlocked** | Write | Boolean | Configures the firewall to block all outgoing connections by default. When OutboundConnectionsRequired and OutboundConnectionsBlocked are both true, OutboundConnectionsBlocked takes priority. This setting will get applied to Windows releases version 1809 and above. | |
| **OutboundConnectionsRequired** | Write | Boolean | Configures the firewall to allow all outgoing connections by default. When OutboundConnectionsRequired and OutboundConnectionsBlocked are both true, OutboundConnectionsBlocked takes priority. This setting will get applied to Windows releases version 1809 and above. | |
| **PolicyRulesFromGroupPolicyMerged** | Write | Boolean | Configures the firewall to merge Firewall Rule policies from group policy with those from local store instead of ignoring the local store rules. When PolicyRulesFromGroupPolicyNotMerged and PolicyRulesFromGroupPolicyMerged are both true, PolicyRulesFromGroupPolicyMerged takes priority. | |
| **PolicyRulesFromGroupPolicyNotMerged** | Write | Boolean | Configures the firewall to prevent merging Firewall Rule policies from group policy with those from local store instead of ignoring the local store rules. When PolicyRulesFromGroupPolicyNotMerged and PolicyRulesFromGroupPolicyMerged are both true, PolicyRulesFromGroupPolicyMerged takes priority. | |
| **SecuredPacketExemptionAllowed** | Write | Boolean | Configures the firewall to allow the host computer to respond to unsolicited network traffic of that traffic is secured by IPSec even when stealthModeBlocked is set to true. When SecuredPacketExemptionBlocked and SecuredPacketExemptionAllowed are both true, SecuredPacketExemptionAllowed takes priority. | |
| **SecuredPacketExemptionBlocked** | Write | Boolean | Configures the firewall to block the host computer to respond to unsolicited network traffic of that traffic is secured by IPSec even when stealthModeBlocked is set to true. When SecuredPacketExemptionBlocked and SecuredPacketExemptionAllowed are both true, SecuredPacketExemptionAllowed takes priority. | |
| **StealthModeBlocked** | Write | Boolean | Prevent the server from operating in stealth mode. When StealthModeRequired and StealthModeBlocked are both true, StealthModeBlocked takes priority. | |
| **StealthModeRequired** | Write | Boolean | Allow the server to operate in stealth mode. When StealthModeRequired and StealthModeBlocked are both true, StealthModeBlocked takes priority. | |
| **UnicastResponsesToMulticastBroadcastsBlocked** | Write | Boolean | Configures the firewall to block unicast responses to multicast broadcast traffic. When UnicastResponsesToMulticastBroadcastsRequired and UnicastResponsesToMulticastBroadcastsBlocked are both true, UnicastResponsesToMulticastBroadcastsBlocked takes priority. | |
| **UnicastResponsesToMulticastBroadcastsRequired** | Write | Boolean | Configures the firewall to allow unicast responses to multicast broadcast traffic. When UnicastResponsesToMulticastBroadcastsRequired and UnicastResponsesToMulticastBroadcastsBlocked are both true, UnicastResponsesToMulticastBroadcastsBlocked takes priority. | |

### MSFT_MicrosoftGraphWindowsFirewallRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Action** | Write | String | The action the rule enforces. If not specified, the default is Allowed. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **Description** | Write | String | The description of the rule. | |
| **DisplayName** | Write | String | The display name of the rule. Does not need to be unique. | |
| **EdgeTraversal** | Write | String | Indicates whether edge traversal is enabled or disabled for this rule. The EdgeTraversal setting indicates that specific inbound traffic is allowed to tunnel through NATs and other edge devices using the Teredo tunneling technology. In order for this setting to work correctly, the application or service with the inbound firewall rule needs to support IPv6. The primary application of this setting allows listeners on the host to be globally addressable through a Teredo IPv6 address. New rules have the EdgeTraversal property disabled by default. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **FilePath** | Write | String | The full file path of an app that's affected by the firewall rule. | |
| **InterfaceTypes** | Write | StringArray[] | The interface types of the rule. Possible values are: notConfigured, remoteAccess, wireless, lan. | `notConfigured`, `remoteAccess`, `wireless`, `lan` |
| **LocalAddressRanges** | Write | StringArray[] | List of local addresses covered by the rule. Default is any address. Valid tokens include:'' indicates any local address. If present, this must be the only token included.A subnet can be specified using either the subnet mask or network prefix notation. If neither a subnet mask nor a network prefix is specified, the subnet mask defaults to 255.255.255.255.A valid IPv6 address.An IPv4 address range in the format of 'start address - end address' with no spaces included.An IPv6 address range in the format of 'start address - end address' with no spaces included. | |
| **LocalPortRanges** | Write | StringArray[] | List of local port ranges. For example, '100-120', '200', '300-320'. If not specified, the default is All. | |
| **LocalUserAuthorizations** | Write | String | Specifies the list of authorized local users for the app container. This is a string in Security Descriptor Definition Language (SDDL) format. | |
| **PackageFamilyName** | Write | String | The package family name of a Microsoft Store application that's affected by the firewall rule. | |
| **ProfileTypes** | Write | String | Specifies the profiles to which the rule belongs. If not specified, the default is All. Possible values are: notConfigured, domain, private, public. | |
| **Protocol** | Write | UInt32 | 0-255 number representing the IP protocol (TCP = 6, UDP = 17). If not specified, the default is All. Valid values 0 to 255 | |
| **RemoteAddressRanges** | Write | StringArray[] | List of tokens specifying the remote addresses covered by the rule. Tokens are case insensitive. Default is any address. Valid tokens include:'' indicates any remote address. If present, this must be the only token included.'Defaultgateway''DHCP''DNS''WINS''Intranet' (supported on Windows versions 1809+)'RmtIntranet' (supported on Windows versions 1809+)'Internet' (supported on Windows versions 1809+)'Ply2Renders' (supported on Windows versions 1809+)'LocalSubnet' indicates any local address on the local subnet.A subnet can be specified using either the subnet mask or network prefix notation. If neither a subnet mask nor a network prefix is specified, the subnet mask defaults to 255.255.255.255.A valid IPv6 address.An IPv4 address range in the format of 'start address - end address' with no spaces included.An IPv6 address range in the format of 'start address - end address' with no spaces included. | |
| **RemotePortRanges** | Write | StringArray[] | List of remote port ranges. For example, '100-120', '200', '300-320'. If not specified, the default is All. | |
| **ServiceName** | Write | String | The name used in cases when a service, not an application, is sending or receiving traffic. | |
| **TrafficDirection** | Write | String | The traffic direction that the rule is enabled for. If not specified, the default is Out. Possible values are: notConfigured, out, in. | `notConfigured`, `out`, `in` |

### MSFT_MicrosoftGraphDeviceManagementUserRightsSetting

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LocalUsersOrGroups** | Write | MSFT_MicrosoftGraphDeviceManagementUserRightsLocalUserOrGroup[] | Representing a collection of local users or groups which will be set on device if the state of this setting is Allowed. This collection can contain a maximum of 500 elements. | |
| **State** | Write | String | Representing the current state of this user rights setting. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |

### MSFT_MicrosoftGraphDeviceManagementUserRightsLocalUserOrGroup

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Admins description of this local user or group. | |
| **Name** | Write | String | The name of this local user or group. | |
| **SecurityIdentifier** | Write | String | The security identifier of this local user or group (e.g. S-1-5-32-544). | |


## Description

Intune Device Configuration Endpoint Protection Policy for Windows10

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

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
        IntuneDeviceConfigurationEndpointProtectionPolicyWindows10 'Example'
        {
            ApplicationGuardAllowFileSaveOnHost                                          = $True;
            ApplicationGuardAllowPersistence                                             = $True;
            ApplicationGuardAllowPrintToLocalPrinters                                    = $True;
            ApplicationGuardAllowPrintToNetworkPrinters                                  = $True;
            ApplicationGuardAllowPrintToPDF                                              = $True;
            ApplicationGuardAllowPrintToXPS                                              = $True;
            ApplicationGuardAllowVirtualGPU                                              = $True;
            ApplicationGuardBlockClipboardSharing                                        = "blockContainerToHost";
            ApplicationGuardBlockFileTransfer                                            = "blockImageFile";
            ApplicationGuardBlockNonEnterpriseContent                                    = $True;
            ApplicationGuardCertificateThumbprints                                       = @();
            ApplicationGuardEnabled                                                      = $True;
            ApplicationGuardEnabledOptions                                               = "enabledForEdge";
            ApplicationGuardForceAuditing                                                = $True;
            AppLockerApplicationControl                                                  = "enforceComponentsStoreAppsAndSmartlocker";
            Assignments                                                                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BitLockerAllowStandardUserEncryption                                         = $True;
            BitLockerDisableWarningForOtherDiskEncryption                                = $True;
            BitLockerEnableStorageCardEncryptionOnMobile                                 = $True;
            BitLockerEncryptDevice                                                       = $True;
            BitLockerFixedDrivePolicy                                                    = MSFT_MicrosoftGraphbitLockerFixedDrivePolicy{
                RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                    RecoveryInformationToStore = 'passwordAndKey'
                    HideRecoveryOptions = $True
                    BlockDataRecoveryAgent = $True
                    RecoveryKeyUsage = 'allowed'
                    EnableBitLockerAfterRecoveryInformationToStore = $True
                    EnableRecoveryInformationSaveToStore = $True
                    RecoveryPasswordUsage = 'allowed'
                }
                            RequireEncryptionForWriteAccess = $True
                EncryptionMethod = 'xtsAes128'
            };
            BitLockerRecoveryPasswordRotation                                            = "notConfigured";
            BitLockerRemovableDrivePolicy                                                = MSFT_MicrosoftGraphbitLockerRemovableDrivePolicy{
                RequireEncryptionForWriteAccess = $True
                BlockCrossOrganizationWriteAccess = $True
                EncryptionMethod = 'aesCbc128'
            };
            BitLockerSystemDrivePolicy                                                   = MSFT_MicrosoftGraphbitLockerSystemDrivePolicy{
                PrebootRecoveryEnableMessageAndUrl = $True
                StartupAuthenticationTpmPinUsage = 'allowed'
                EncryptionMethod = 'xtsAes128'
                StartupAuthenticationTpmPinAndKeyUsage = 'allowed'
                StartupAuthenticationRequired = $True
                RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                    RecoveryInformationToStore = 'passwordAndKey'
                    HideRecoveryOptions = $False
                    BlockDataRecoveryAgent = $True
                    RecoveryKeyUsage = 'allowed'
                    EnableBitLockerAfterRecoveryInformationToStore = $True
                    EnableRecoveryInformationSaveToStore = $False
                    RecoveryPasswordUsage = 'allowed'
                }
                            StartupAuthenticationTpmUsage = 'allowed'
                StartupAuthenticationTpmKeyUsage = 'allowed'
                StartupAuthenticationBlockWithoutTpmChip = $False
            };
            DefenderAdditionalGuardedFolders                                             = @();
            DefenderAdobeReaderLaunchChildProcess                                        = "notConfigured";
            DefenderAdvancedRansomewareProtectionType                                    = "notConfigured";
            DefenderAttackSurfaceReductionExcludedPaths                                  = @();
            DefenderBlockPersistenceThroughWmiType                                       = "userDefined";
            DefenderEmailContentExecution                                                = "userDefined";
            DefenderEmailContentExecutionType                                            = "userDefined";
            DefenderExploitProtectionXml                                                 = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxNaXRpZ2F0aW9uUG9saWN5Pg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IkFjcm9SZDMyLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJBY3JvUmQzMkluZm8uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImNsdmlldy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iY25mbm90MzIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImV4Y2VsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJleGNlbGNudi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iRXh0RXhwb3J0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJncmFwaC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iaWU0dWluaXQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllaW5zdGFsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJpZWxvd3V0aWwuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllVW5hdHQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImlleHBsb3JlLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJseW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2FjY2Vzcy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNjb3JzdncuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zZmVlZHNzeW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2h0YS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvYWRmc2IuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb2FzYi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvaHRtZWQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3NyZWMuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3htbGVkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc3B1Yi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNxcnkzMi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iTXNTZW5zZS5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgICA8SW1hZ2VMb2FkIFByZWZlclN5c3RlbTMyPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VuLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VudGFzay5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZW0uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im9yZ2NoYXJ0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJvdXRsb29rLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJwb3dlcnBudC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUHJlc2VudGF0aW9uSG9zdC5leGUiPg0KICAgIDxERVAgRW5hYmxlPSJ0cnVlIiBFbXVsYXRlQXRsVGh1bmtzPSJmYWxzZSIgLz4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIEJvdHRvbVVwPSJ0cnVlIiBIaWdoRW50cm9weT0idHJ1ZSIgLz4NCiAgICA8U0VIT1AgRW5hYmxlPSJ0cnVlIiBUZWxlbWV0cnlPbmx5PSJmYWxzZSIgLz4NCiAgICA8SGVhcCBUZXJtaW5hdGVPbkVycm9yPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJQcmludERpYWxvZy5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUmRyQ0VGLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJSZHJTZXJ2aWNlc1VwZGF0ZXIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InJ1bnRpbWVicm9rZXIuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5vc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5wc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNkeGhlbHBlci5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ic2VsZmNlcnQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNldGxhbmcuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IlN5c3RlbVNldHRpbmdzLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3aW53b3JkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3b3JkY29udi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQo8L01pdGlnYXRpb25Qb2xpY3k+";
            DefenderExploitProtectionXmlFileName                                         = "Settings.xml";
            DefenderFileExtensionsToExclude                                              = @();
            DefenderFilesAndFoldersToExclude                                             = @();
            DefenderGuardedFoldersAllowedAppPaths                                        = @();
            DefenderGuardMyFoldersType                                                   = "auditMode";
            DefenderNetworkProtectionType                                                = "enable";
            DefenderOfficeAppsExecutableContentCreationOrLaunch                          = "userDefined";
            DefenderOfficeAppsExecutableContentCreationOrLaunchType                      = "userDefined";
            DefenderOfficeAppsLaunchChildProcess                                         = "userDefined";
            DefenderOfficeAppsLaunchChildProcessType                                     = "userDefined";
            DefenderOfficeAppsOtherProcessInjection                                      = "userDefined";
            DefenderOfficeAppsOtherProcessInjectionType                                  = "userDefined";
            DefenderOfficeCommunicationAppsLaunchChildProcess                            = "notConfigured";
            DefenderOfficeMacroCodeAllowWin32Imports                                     = "userDefined";
            DefenderOfficeMacroCodeAllowWin32ImportsType                                 = "userDefined";
            DefenderPreventCredentialStealingType                                        = "enable";
            DefenderProcessCreation                                                      = "userDefined";
            DefenderProcessCreationType                                                  = "userDefined";
            DefenderProcessesToExclude                                                   = @();
            DefenderScriptDownloadedPayloadExecution                                     = "userDefined";
            DefenderScriptDownloadedPayloadExecutionType                                 = "userDefined";
            DefenderScriptObfuscatedMacroCode                                            = "userDefined";
            DefenderScriptObfuscatedMacroCodeType                                        = "userDefined";
            DefenderSecurityCenterBlockExploitProtectionOverride                         = $False;
            DefenderSecurityCenterDisableAccountUI                                       = $False;
            DefenderSecurityCenterDisableClearTpmUI                                      = $True;
            DefenderSecurityCenterDisableFamilyUI                                        = $False;
            DefenderSecurityCenterDisableHardwareUI                                      = $True;
            DefenderSecurityCenterDisableHealthUI                                        = $False;
            DefenderSecurityCenterDisableNetworkUI                                       = $False;
            DefenderSecurityCenterDisableNotificationAreaUI                              = $False;
            DefenderSecurityCenterDisableRansomwareUI                                    = $False;
            DefenderSecurityCenterDisableVirusUI                                         = $False;
            DefenderSecurityCenterDisableVulnerableTpmFirmwareUpdateUI                   = $True;
            DefenderSecurityCenterHelpEmail                                              = "me@domain.com";
            DefenderSecurityCenterHelpPhone                                              = "yes";
            DefenderSecurityCenterITContactDisplay                                       = "displayInAppAndInNotifications";
            DefenderSecurityCenterNotificationsFromApp                                   = "blockNoncriticalNotifications";
            DefenderSecurityCenterOrganizationDisplayName                                = "processes.exe";
            DefenderUntrustedExecutable                                                  = "userDefined";
            DefenderUntrustedExecutableType                                              = "userDefined";
            DefenderUntrustedUSBProcess                                                  = "userDefined";
            DefenderUntrustedUSBProcessType                                              = "userDefined";
            DeviceGuardEnableSecureBootWithDMA                                           = $True;
            DeviceGuardEnableVirtualizationBasedSecurity                                 = $True;
            DeviceGuardLaunchSystemGuard                                                 = "notConfigured";
            DeviceGuardLocalSystemAuthorityCredentialGuardSettings                       = "enableWithoutUEFILock";
            DeviceGuardSecureBootWithDMA                                                 = "notConfigured";
            DisplayName                                                                  = "endpoint protection legacy - dsc v2.0";
            DmaGuardDeviceEnumerationPolicy                                              = "deviceDefault";
            Ensure                                                                       = "Present";
            FirewallCertificateRevocationListCheckMethod                                 = "deviceDefault";
            FirewallIPSecExemptionsAllowDHCP                                             = $False;
            FirewallIPSecExemptionsAllowICMP                                             = $False;
            FirewallIPSecExemptionsAllowNeighborDiscovery                                = $False;
            FirewallIPSecExemptionsAllowRouterDiscovery                                  = $False;
            FirewallIPSecExemptionsNone                                                  = $False;
            FirewallPacketQueueingMethod                                                 = "deviceDefault";
            FirewallPreSharedKeyEncodingMethod                                           = "deviceDefault";
            FirewallProfileDomain                                                        = MSFT_MicrosoftGraphwindowsFirewallNetworkProfile{
                PolicyRulesFromGroupPolicyNotMerged = $False
                InboundNotificationsBlocked = $True
                OutboundConnectionsRequired = $True
                GlobalPortRulesFromGroupPolicyNotMerged = $True
                ConnectionSecurityRulesFromGroupPolicyNotMerged = $True
                UnicastResponsesToMulticastBroadcastsRequired = $True
                PolicyRulesFromGroupPolicyMerged = $False
                UnicastResponsesToMulticastBroadcastsBlocked = $False
                IncomingTrafficRequired = $False
                IncomingTrafficBlocked = $True
                ConnectionSecurityRulesFromGroupPolicyMerged = $False
                StealthModeRequired = $False
                InboundNotificationsRequired = $False
                AuthorizedApplicationRulesFromGroupPolicyMerged = $False
                InboundConnectionsBlocked = $True
                OutboundConnectionsBlocked = $False
                StealthModeBlocked = $True
                GlobalPortRulesFromGroupPolicyMerged = $False
                SecuredPacketExemptionBlocked = $False
                SecuredPacketExemptionAllowed = $False
                InboundConnectionsRequired = $False
                FirewallEnabled = 'allowed'
                AuthorizedApplicationRulesFromGroupPolicyNotMerged = $True
            };
            FirewallRules                                                                = @(
                MSFT_MicrosoftGraphwindowsFirewallRule{
                    Action = 'allowed'
                    InterfaceTypes = 'notConfigured'
                    DisplayName = 'ICMP'
                    TrafficDirection = 'in'
                    ProfileTypes = 'domain'
                    EdgeTraversal = 'notConfigured'
                }
            );
            LanManagerAuthenticationLevel                                                = "lmNtlmAndNtlmV2";
            LanManagerWorkstationDisableInsecureGuestLogons                              = $False;
            LocalSecurityOptionsAdministratorElevationPromptBehavior                     = "notConfigured";
            LocalSecurityOptionsAllowAnonymousEnumerationOfSAMAccountsAndShares          = $False;
            LocalSecurityOptionsAllowPKU2UAuthenticationRequests                         = $False;
            LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManagerHelperBool      = $False;
            LocalSecurityOptionsAllowSystemToBeShutDownWithoutHavingToLogOn              = $True;
            LocalSecurityOptionsAllowUIAccessApplicationElevation                        = $False;
            LocalSecurityOptionsAllowUIAccessApplicationsForSecureLocations              = $False;
            LocalSecurityOptionsAllowUndockWithoutHavingToLogon                          = $True;
            LocalSecurityOptionsBlockMicrosoftAccounts                                   = $True;
            LocalSecurityOptionsBlockRemoteLogonWithBlankPassword                        = $True;
            LocalSecurityOptionsBlockRemoteOpticalDriveAccess                            = $True;
            LocalSecurityOptionsBlockUsersInstallingPrinterDrivers                       = $True;
            LocalSecurityOptionsClearVirtualMemoryPageFile                               = $True;
            LocalSecurityOptionsClientDigitallySignCommunicationsAlways                  = $False;
            LocalSecurityOptionsClientSendUnencryptedPasswordToThirdPartySMBServers      = $False;
            LocalSecurityOptionsDetectApplicationInstallationsAndPromptForElevation      = $False;
            LocalSecurityOptionsDisableAdministratorAccount                              = $True;
            LocalSecurityOptionsDisableClientDigitallySignCommunicationsIfServerAgrees   = $False;
            LocalSecurityOptionsDisableGuestAccount                                      = $True;
            LocalSecurityOptionsDisableServerDigitallySignCommunicationsAlways           = $False;
            LocalSecurityOptionsDisableServerDigitallySignCommunicationsIfClientAgrees   = $False;
            LocalSecurityOptionsDoNotAllowAnonymousEnumerationOfSAMAccounts              = $True;
            LocalSecurityOptionsDoNotRequireCtrlAltDel                                   = $True;
            LocalSecurityOptionsDoNotStoreLANManagerHashValueOnNextPasswordChange        = $False;
            LocalSecurityOptionsFormatAndEjectOfRemovableMediaAllowedUser                = "administrators";
            LocalSecurityOptionsHideLastSignedInUser                                     = $False;
            LocalSecurityOptionsHideUsernameAtSignIn                                     = $False;
            LocalSecurityOptionsInformationDisplayedOnLockScreen                         = "notConfigured";
            LocalSecurityOptionsInformationShownOnLockScreen                             = "notConfigured";
            LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedClients             = "none";
            LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedServers             = "none";
            LocalSecurityOptionsOnlyElevateSignedExecutables                             = $False;
            LocalSecurityOptionsRestrictAnonymousAccessToNamedPipesAndShares             = $True;
            LocalSecurityOptionsSmartCardRemovalBehavior                                 = "lockWorkstation";
            LocalSecurityOptionsStandardUserElevationPromptBehavior                      = "notConfigured";
            LocalSecurityOptionsSwitchToSecureDesktopWhenPromptingForElevation           = $False;
            LocalSecurityOptionsUseAdminApprovalMode                                     = $False;
            LocalSecurityOptionsUseAdminApprovalModeForAdministrators                    = $False;
            LocalSecurityOptionsVirtualizeFileAndRegistryWriteFailuresToPerUserLocations = $False;
            SmartScreenBlockOverrideForFiles                                             = $True;
            SmartScreenEnableInShell                                                     = $True;
            SupportsScopeTags                                                            = $True;
            UserRightsAccessCredentialManagerAsTrustedCaller                             = MSFT_MicrosoftGraphdeviceManagementUserRightsSetting{
                State = 'allowed'
                LocalUsersOrGroups = @(
                    MSFT_MicrosoftGraphDeviceManagementUserRightsLocalUserOrGroup{
                        Name = 'NT AUTHORITY\Local service'
                        SecurityIdentifier = '*S-1-5-19'
                    }
                )
            };
            WindowsDefenderTamperProtection                                              = "enable";
            XboxServicesAccessoryManagementServiceStartupMode                            = "manual";
            XboxServicesEnableXboxGameSaveTask                                           = $True;
            XboxServicesLiveAuthManagerServiceStartupMode                                = "manual";
            XboxServicesLiveGameSaveServiceStartupMode                                   = "manual";
            XboxServicesLiveNetworkingServiceStartupMode                                 = "manual";
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
        IntuneDeviceConfigurationEndpointProtectionPolicyWindows10 'Example'
        {
            ApplicationGuardAllowFileSaveOnHost                                          = $True;
            ApplicationGuardAllowPersistence                                             = $True;
            ApplicationGuardAllowPrintToLocalPrinters                                    = $True;
            ApplicationGuardAllowPrintToNetworkPrinters                                  = $False; # Updated Property
            ApplicationGuardAllowPrintToPDF                                              = $True;
            ApplicationGuardAllowPrintToXPS                                              = $True;
            ApplicationGuardAllowVirtualGPU                                              = $True;
            ApplicationGuardBlockClipboardSharing                                        = "blockContainerToHost";
            ApplicationGuardBlockFileTransfer                                            = "blockImageFile";
            ApplicationGuardBlockNonEnterpriseContent                                    = $True;
            ApplicationGuardCertificateThumbprints                                       = @();
            ApplicationGuardEnabled                                                      = $True;
            ApplicationGuardEnabledOptions                                               = "enabledForEdge";
            ApplicationGuardForceAuditing                                                = $True;
            AppLockerApplicationControl                                                  = "enforceComponentsStoreAppsAndSmartlocker";
            Assignments                                                                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BitLockerAllowStandardUserEncryption                                         = $True;
            BitLockerDisableWarningForOtherDiskEncryption                                = $True;
            BitLockerEnableStorageCardEncryptionOnMobile                                 = $True;
            BitLockerEncryptDevice                                                       = $True;
            BitLockerFixedDrivePolicy                                                    = MSFT_MicrosoftGraphbitLockerFixedDrivePolicy{
                RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                    RecoveryInformationToStore = 'passwordAndKey'
                    HideRecoveryOptions = $True
                    BlockDataRecoveryAgent = $True
                    RecoveryKeyUsage = 'allowed'
                    EnableBitLockerAfterRecoveryInformationToStore = $True
                    EnableRecoveryInformationSaveToStore = $True
                    RecoveryPasswordUsage = 'allowed'
                }
                            RequireEncryptionForWriteAccess = $True
                EncryptionMethod = 'xtsAes128'
            };
            BitLockerRecoveryPasswordRotation                                            = "notConfigured";
            BitLockerRemovableDrivePolicy                                                = MSFT_MicrosoftGraphbitLockerRemovableDrivePolicy{
                RequireEncryptionForWriteAccess = $True
                BlockCrossOrganizationWriteAccess = $True
                EncryptionMethod = 'aesCbc128'
            };
            BitLockerSystemDrivePolicy                                                   = MSFT_MicrosoftGraphbitLockerSystemDrivePolicy{
                PrebootRecoveryEnableMessageAndUrl = $True
                StartupAuthenticationTpmPinUsage = 'allowed'
                EncryptionMethod = 'xtsAes128'
                StartupAuthenticationTpmPinAndKeyUsage = 'allowed'
                StartupAuthenticationRequired = $True
                RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                    RecoveryInformationToStore = 'passwordAndKey'
                    HideRecoveryOptions = $False
                    BlockDataRecoveryAgent = $True
                    RecoveryKeyUsage = 'allowed'
                    EnableBitLockerAfterRecoveryInformationToStore = $True
                    EnableRecoveryInformationSaveToStore = $False
                    RecoveryPasswordUsage = 'allowed'
                }
                            StartupAuthenticationTpmUsage = 'allowed'
                StartupAuthenticationTpmKeyUsage = 'allowed'
                StartupAuthenticationBlockWithoutTpmChip = $False
            };
            DefenderAdditionalGuardedFolders                                             = @();
            DefenderAdobeReaderLaunchChildProcess                                        = "notConfigured";
            DefenderAdvancedRansomewareProtectionType                                    = "notConfigured";
            DefenderAttackSurfaceReductionExcludedPaths                                  = @();
            DefenderBlockPersistenceThroughWmiType                                       = "userDefined";
            DefenderEmailContentExecution                                                = "userDefined";
            DefenderEmailContentExecutionType                                            = "userDefined";
            DefenderExploitProtectionXml                                                 = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxNaXRpZ2F0aW9uUG9saWN5Pg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IkFjcm9SZDMyLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJBY3JvUmQzMkluZm8uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImNsdmlldy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iY25mbm90MzIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImV4Y2VsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJleGNlbGNudi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iRXh0RXhwb3J0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJncmFwaC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iaWU0dWluaXQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllaW5zdGFsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJpZWxvd3V0aWwuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllVW5hdHQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImlleHBsb3JlLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJseW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2FjY2Vzcy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNjb3JzdncuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zZmVlZHNzeW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2h0YS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvYWRmc2IuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb2FzYi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvaHRtZWQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3NyZWMuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3htbGVkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc3B1Yi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNxcnkzMi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iTXNTZW5zZS5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgICA8SW1hZ2VMb2FkIFByZWZlclN5c3RlbTMyPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VuLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VudGFzay5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZW0uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im9yZ2NoYXJ0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJvdXRsb29rLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJwb3dlcnBudC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUHJlc2VudGF0aW9uSG9zdC5leGUiPg0KICAgIDxERVAgRW5hYmxlPSJ0cnVlIiBFbXVsYXRlQXRsVGh1bmtzPSJmYWxzZSIgLz4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIEJvdHRvbVVwPSJ0cnVlIiBIaWdoRW50cm9weT0idHJ1ZSIgLz4NCiAgICA8U0VIT1AgRW5hYmxlPSJ0cnVlIiBUZWxlbWV0cnlPbmx5PSJmYWxzZSIgLz4NCiAgICA8SGVhcCBUZXJtaW5hdGVPbkVycm9yPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJQcmludERpYWxvZy5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUmRyQ0VGLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJSZHJTZXJ2aWNlc1VwZGF0ZXIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InJ1bnRpbWVicm9rZXIuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5vc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5wc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNkeGhlbHBlci5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ic2VsZmNlcnQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNldGxhbmcuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IlN5c3RlbVNldHRpbmdzLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3aW53b3JkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3b3JkY29udi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQo8L01pdGlnYXRpb25Qb2xpY3k+";
            DefenderExploitProtectionXmlFileName                                         = "Settings.xml";
            DefenderFileExtensionsToExclude                                              = @();
            DefenderFilesAndFoldersToExclude                                             = @();
            DefenderGuardedFoldersAllowedAppPaths                                        = @();
            DefenderGuardMyFoldersType                                                   = "auditMode";
            DefenderNetworkProtectionType                                                = "enable";
            DefenderOfficeAppsExecutableContentCreationOrLaunch                          = "userDefined";
            DefenderOfficeAppsExecutableContentCreationOrLaunchType                      = "userDefined";
            DefenderOfficeAppsLaunchChildProcess                                         = "userDefined";
            DefenderOfficeAppsLaunchChildProcessType                                     = "userDefined";
            DefenderOfficeAppsOtherProcessInjection                                      = "userDefined";
            DefenderOfficeAppsOtherProcessInjectionType                                  = "userDefined";
            DefenderOfficeCommunicationAppsLaunchChildProcess                            = "notConfigured";
            DefenderOfficeMacroCodeAllowWin32Imports                                     = "userDefined";
            DefenderOfficeMacroCodeAllowWin32ImportsType                                 = "userDefined";
            DefenderPreventCredentialStealingType                                        = "enable";
            DefenderProcessCreation                                                      = "userDefined";
            DefenderProcessCreationType                                                  = "userDefined";
            DefenderProcessesToExclude                                                   = @();
            DefenderScriptDownloadedPayloadExecution                                     = "userDefined";
            DefenderScriptDownloadedPayloadExecutionType                                 = "userDefined";
            DefenderScriptObfuscatedMacroCode                                            = "userDefined";
            DefenderScriptObfuscatedMacroCodeType                                        = "userDefined";
            DefenderSecurityCenterBlockExploitProtectionOverride                         = $False;
            DefenderSecurityCenterDisableAccountUI                                       = $False;
            DefenderSecurityCenterDisableClearTpmUI                                      = $True;
            DefenderSecurityCenterDisableFamilyUI                                        = $False;
            DefenderSecurityCenterDisableHardwareUI                                      = $True;
            DefenderSecurityCenterDisableHealthUI                                        = $False;
            DefenderSecurityCenterDisableNetworkUI                                       = $False;
            DefenderSecurityCenterDisableNotificationAreaUI                              = $False;
            DefenderSecurityCenterDisableRansomwareUI                                    = $False;
            DefenderSecurityCenterDisableVirusUI                                         = $False;
            DefenderSecurityCenterDisableVulnerableTpmFirmwareUpdateUI                   = $True;
            DefenderSecurityCenterHelpEmail                                              = "me@domain.com";
            DefenderSecurityCenterHelpPhone                                              = "yes";
            DefenderSecurityCenterITContactDisplay                                       = "displayInAppAndInNotifications";
            DefenderSecurityCenterNotificationsFromApp                                   = "blockNoncriticalNotifications";
            DefenderSecurityCenterOrganizationDisplayName                                = "processes.exe";
            DefenderUntrustedExecutable                                                  = "userDefined";
            DefenderUntrustedExecutableType                                              = "userDefined";
            DefenderUntrustedUSBProcess                                                  = "userDefined";
            DefenderUntrustedUSBProcessType                                              = "userDefined";
            DeviceGuardEnableSecureBootWithDMA                                           = $True;
            DeviceGuardEnableVirtualizationBasedSecurity                                 = $True;
            DeviceGuardLaunchSystemGuard                                                 = "notConfigured";
            DeviceGuardLocalSystemAuthorityCredentialGuardSettings                       = "enableWithoutUEFILock";
            DeviceGuardSecureBootWithDMA                                                 = "notConfigured";
            DisplayName                                                                  = "endpoint protection legacy - dsc v2.0";
            DmaGuardDeviceEnumerationPolicy                                              = "deviceDefault";
            Ensure                                                                       = "Present";
            FirewallCertificateRevocationListCheckMethod                                 = "deviceDefault";
            FirewallIPSecExemptionsAllowDHCP                                             = $False;
            FirewallIPSecExemptionsAllowICMP                                             = $False;
            FirewallIPSecExemptionsAllowNeighborDiscovery                                = $False;
            FirewallIPSecExemptionsAllowRouterDiscovery                                  = $False;
            FirewallIPSecExemptionsNone                                                  = $False;
            FirewallPacketQueueingMethod                                                 = "deviceDefault";
            FirewallPreSharedKeyEncodingMethod                                           = "deviceDefault";
            FirewallProfileDomain                                                        = MSFT_MicrosoftGraphwindowsFirewallNetworkProfile{
                PolicyRulesFromGroupPolicyNotMerged = $False
                InboundNotificationsBlocked = $True
                OutboundConnectionsRequired = $True
                GlobalPortRulesFromGroupPolicyNotMerged = $True
                ConnectionSecurityRulesFromGroupPolicyNotMerged = $True
                UnicastResponsesToMulticastBroadcastsRequired = $True
                PolicyRulesFromGroupPolicyMerged = $False
                UnicastResponsesToMulticastBroadcastsBlocked = $False
                IncomingTrafficRequired = $False
                IncomingTrafficBlocked = $True
                ConnectionSecurityRulesFromGroupPolicyMerged = $False
                StealthModeRequired = $False
                InboundNotificationsRequired = $False
                AuthorizedApplicationRulesFromGroupPolicyMerged = $False
                InboundConnectionsBlocked = $True
                OutboundConnectionsBlocked = $False
                StealthModeBlocked = $True
                GlobalPortRulesFromGroupPolicyMerged = $False
                SecuredPacketExemptionBlocked = $False
                SecuredPacketExemptionAllowed = $False
                InboundConnectionsRequired = $False
                FirewallEnabled = 'allowed'
                AuthorizedApplicationRulesFromGroupPolicyNotMerged = $True
            };
            FirewallRules                                                                = @(
                MSFT_MicrosoftGraphwindowsFirewallRule{
                    Action = 'allowed'
                    InterfaceTypes = 'notConfigured'
                    DisplayName = 'ICMP'
                    TrafficDirection = 'in'
                    ProfileTypes = 'domain'
                    EdgeTraversal = 'notConfigured'
                }
            );
            LanManagerAuthenticationLevel                                                = "lmNtlmAndNtlmV2";
            LanManagerWorkstationDisableInsecureGuestLogons                              = $False;
            LocalSecurityOptionsAdministratorElevationPromptBehavior                     = "notConfigured";
            LocalSecurityOptionsAllowAnonymousEnumerationOfSAMAccountsAndShares          = $False;
            LocalSecurityOptionsAllowPKU2UAuthenticationRequests                         = $False;
            LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManagerHelperBool      = $False;
            LocalSecurityOptionsAllowSystemToBeShutDownWithoutHavingToLogOn              = $True;
            LocalSecurityOptionsAllowUIAccessApplicationElevation                        = $False;
            LocalSecurityOptionsAllowUIAccessApplicationsForSecureLocations              = $False;
            LocalSecurityOptionsAllowUndockWithoutHavingToLogon                          = $True;
            LocalSecurityOptionsBlockMicrosoftAccounts                                   = $True;
            LocalSecurityOptionsBlockRemoteLogonWithBlankPassword                        = $True;
            LocalSecurityOptionsBlockRemoteOpticalDriveAccess                            = $True;
            LocalSecurityOptionsBlockUsersInstallingPrinterDrivers                       = $True;
            LocalSecurityOptionsClearVirtualMemoryPageFile                               = $True;
            LocalSecurityOptionsClientDigitallySignCommunicationsAlways                  = $False;
            LocalSecurityOptionsClientSendUnencryptedPasswordToThirdPartySMBServers      = $False;
            LocalSecurityOptionsDetectApplicationInstallationsAndPromptForElevation      = $False;
            LocalSecurityOptionsDisableAdministratorAccount                              = $True;
            LocalSecurityOptionsDisableClientDigitallySignCommunicationsIfServerAgrees   = $False;
            LocalSecurityOptionsDisableGuestAccount                                      = $True;
            LocalSecurityOptionsDisableServerDigitallySignCommunicationsAlways           = $False;
            LocalSecurityOptionsDisableServerDigitallySignCommunicationsIfClientAgrees   = $False;
            LocalSecurityOptionsDoNotAllowAnonymousEnumerationOfSAMAccounts              = $True;
            LocalSecurityOptionsDoNotRequireCtrlAltDel                                   = $True;
            LocalSecurityOptionsDoNotStoreLANManagerHashValueOnNextPasswordChange        = $False;
            LocalSecurityOptionsFormatAndEjectOfRemovableMediaAllowedUser                = "administrators";
            LocalSecurityOptionsHideLastSignedInUser                                     = $False;
            LocalSecurityOptionsHideUsernameAtSignIn                                     = $False;
            LocalSecurityOptionsInformationDisplayedOnLockScreen                         = "notConfigured";
            LocalSecurityOptionsInformationShownOnLockScreen                             = "notConfigured";
            LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedClients             = "none";
            LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedServers             = "none";
            LocalSecurityOptionsOnlyElevateSignedExecutables                             = $False;
            LocalSecurityOptionsRestrictAnonymousAccessToNamedPipesAndShares             = $True;
            LocalSecurityOptionsSmartCardRemovalBehavior                                 = "lockWorkstation";
            LocalSecurityOptionsStandardUserElevationPromptBehavior                      = "notConfigured";
            LocalSecurityOptionsSwitchToSecureDesktopWhenPromptingForElevation           = $False;
            LocalSecurityOptionsUseAdminApprovalMode                                     = $False;
            LocalSecurityOptionsUseAdminApprovalModeForAdministrators                    = $False;
            LocalSecurityOptionsVirtualizeFileAndRegistryWriteFailuresToPerUserLocations = $False;
            SmartScreenBlockOverrideForFiles                                             = $True;
            SmartScreenEnableInShell                                                     = $True;
            SupportsScopeTags                                                            = $True;
            UserRightsAccessCredentialManagerAsTrustedCaller                             = MSFT_MicrosoftGraphdeviceManagementUserRightsSetting{
                State = 'allowed'
                LocalUsersOrGroups = @(
                    MSFT_MicrosoftGraphDeviceManagementUserRightsLocalUserOrGroup{
                        Name = 'NT AUTHORITY\Local service'
                        SecurityIdentifier = '*S-1-5-19'
                    }
                )
            };
            WindowsDefenderTamperProtection                                              = "enable";
            XboxServicesAccessoryManagementServiceStartupMode                            = "manual";
            XboxServicesEnableXboxGameSaveTask                                           = $True;
            XboxServicesLiveAuthManagerServiceStartupMode                                = "manual";
            XboxServicesLiveGameSaveServiceStartupMode                                   = "manual";
            XboxServicesLiveNetworkingServiceStartupMode                                 = "manual";
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
        IntuneDeviceConfigurationEndpointProtectionPolicyWindows10 'Example'
        {
            DisplayName                                                                  = "endpoint protection legacy - dsc v2.0";
            Ensure                                                                       = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

