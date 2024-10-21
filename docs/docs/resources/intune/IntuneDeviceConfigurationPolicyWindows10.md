# IntuneDeviceConfigurationPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AccountsBlockAddingNonMicrosoftAccountEmail** | Write | Boolean | Indicates whether or not to Block the user from adding email accounts to the device that are not associated with a Microsoft account. | |
| **ActivateAppsWithVoice** | Write | String | Specifies if Windows apps can be activated by voice. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **AntiTheftModeBlocked** | Write | Boolean | Indicates whether or not to block the user from selecting an AntiTheft mode preference (Windows 10 Mobile only). | |
| **AppManagementMSIAllowUserControlOverInstall** | Write | Boolean | This policy setting permits users to change installation options that typically are available only to system administrators. | |
| **AppManagementMSIAlwaysInstallWithElevatedPrivileges** | Write | Boolean | This policy setting directs Windows Installer to use elevated permissions when it installs any program on the system. | |
| **AppManagementPackageFamilyNamesToLaunchAfterLogOn** | Write | StringArray[] | List of semi-colon delimited Package Family Names of Windows apps. Listed Windows apps are to be launched after logon. | |
| **AppsAllowTrustedAppsSideloading** | Write | String | Indicates whether apps from AppX packages signed with a trusted certificate can be side loaded. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **AppsBlockWindowsStoreOriginatedApps** | Write | Boolean | Indicates whether or not to disable the launch of all apps from Windows Store that came pre-installed or were downloaded. | |
| **AuthenticationAllowSecondaryDevice** | Write | Boolean | Allows secondary authentication devices to work with Windows. | |
| **AuthenticationPreferredAzureADTenantDomainName** | Write | String | Specifies the preferred domain among available domains in the Azure AD tenant. | |
| **AuthenticationWebSignIn** | Write | String | Indicates whether or not Web Credential Provider will be enabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **BluetoothAllowedServices** | Write | StringArray[] | Specify a list of allowed Bluetooth services and profiles in hex formatted strings. | |
| **BluetoothBlockAdvertising** | Write | Boolean | Whether or not to Block the user from using bluetooth advertising. | |
| **BluetoothBlockDiscoverableMode** | Write | Boolean | Whether or not to Block the user from using bluetooth discoverable mode. | |
| **BluetoothBlocked** | Write | Boolean | Whether or not to Block the user from using bluetooth. | |
| **BluetoothBlockPrePairing** | Write | Boolean | Whether or not to block specific bundled Bluetooth peripherals to automatically pair with the host device. | |
| **BluetoothBlockPromptedProximalConnections** | Write | Boolean | Whether or not to block the users from using Swift Pair and other proximity based scenarios. | |
| **CameraBlocked** | Write | Boolean | Whether or not to Block the user from accessing the camera of the device. | |
| **CellularBlockDataWhenRoaming** | Write | Boolean | Whether or not to Block the user from using data over cellular while roaming. | |
| **CellularBlockVpn** | Write | Boolean | Whether or not to Block the user from using VPN over cellular. | |
| **CellularBlockVpnWhenRoaming** | Write | Boolean | Whether or not to Block the user from using VPN when roaming over cellular. | |
| **CellularData** | Write | String | Whether or not to allow the cellular data channel on the device. If not configured, the cellular data channel is allowed and the user can turn it off. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **CertificatesBlockManualRootCertificateInstallation** | Write | Boolean | Whether or not to Block the user from doing manual root certificate installation. | |
| **ConfigureTimeZone** | Write | String | Specifies the time zone to be applied to the device. This is the standard Windows name for the target time zone. | |
| **ConnectedDevicesServiceBlocked** | Write | Boolean | Whether or not to block Connected Devices Service which enables discovery and connection to other devices, remote messaging, remote app sessions and other cross-device experiences. | |
| **CopyPasteBlocked** | Write | Boolean | Whether or not to Block the user from using copy paste. | |
| **CortanaBlocked** | Write | Boolean | Whether or not to Block the user from using Cortana. | |
| **CryptographyAllowFipsAlgorithmPolicy** | Write | Boolean | Specify whether to allow or disallow the Federal Information Processing Standard (FIPS) policy. | |
| **DataProtectionBlockDirectMemoryAccess** | Write | Boolean | This policy setting allows you to block direct memory access (DMA) for all hot pluggable PCI downstream ports until a user logs into Windows. | |
| **DefenderBlockEndUserAccess** | Write | Boolean | Whether or not to block end user access to Defender. | |
| **DefenderBlockOnAccessProtection** | Write | Boolean | Allows or disallows Windows Defender On Access Protection functionality. | |
| **DefenderCloudBlockLevel** | Write | String | Specifies the level of cloud-delivered protection. Possible values are: notConfigured, high, highPlus, zeroTolerance. | `notConfigured`, `high`, `highPlus`, `zeroTolerance` |
| **DefenderCloudExtendedTimeout** | Write | UInt32 | Timeout extension for file scanning by the cloud. Valid values 0 to 50 | |
| **DefenderCloudExtendedTimeoutInSeconds** | Write | UInt32 | Timeout extension for file scanning by the cloud. Valid values 0 to 50 | |
| **DefenderDaysBeforeDeletingQuarantinedMalware** | Write | UInt32 | Number of days before deleting quarantined malware. Valid values 0 to 90 | |
| **DefenderDetectedMalwareActions** | Write | MSFT_MicrosoftGraphdefenderDetectedMalwareActions1 | Gets or sets Defenders actions to take on detected Malware per threat level. | |
| **DefenderDisableCatchupFullScan** | Write | Boolean | When blocked, catch-up scans for scheduled full scans will be turned off. | |
| **DefenderDisableCatchupQuickScan** | Write | Boolean | When blocked, catch-up scans for scheduled quick scans will be turned off. | |
| **DefenderFileExtensionsToExclude** | Write | StringArray[] | File extensions to exclude from scans and real time protection. | |
| **DefenderFilesAndFoldersToExclude** | Write | StringArray[] | Files and folder to exclude from scans and real time protection. | |
| **DefenderMonitorFileActivity** | Write | String | Value for monitoring file activity. Possible values are: userDefined, disable, monitorAllFiles, monitorIncomingFilesOnly, monitorOutgoingFilesOnly. | `userDefined`, `disable`, `monitorAllFiles`, `monitorIncomingFilesOnly`, `monitorOutgoingFilesOnly` |
| **DefenderPotentiallyUnwantedAppAction** | Write | String | Gets or sets Defenders action to take on Potentially Unwanted Application (PUA), which includes software with behaviors of ad-injection, software bundling, persistent solicitation for payment or subscription, etc. Defender alerts user when PUA is being downloaded or attempts to install itself. Added in Windows 10 for desktop. Possible values are: deviceDefault, block, audit. | `deviceDefault`, `block`, `audit` |
| **DefenderPotentiallyUnwantedAppActionSetting** | Write | String | Gets or sets Defenders action to take on Potentially Unwanted Application (PUA), which includes software with behaviors of ad-injection, software bundling, persistent solicitation for payment or subscription, etc. Defender alerts user when PUA is being downloaded or attempts to install itself. Added in Windows 10 for desktop. Possible values are: userDefined, enable, auditMode, warn, notConfigured. | `userDefined`, `enable`, `auditMode`, `warn`, `notConfigured` |
| **DefenderProcessesToExclude** | Write | StringArray[] | Processes to exclude from scans and real time protection. | |
| **DefenderPromptForSampleSubmission** | Write | String | The configuration for how to prompt user for sample submission. Possible values are: userDefined, alwaysPrompt, promptBeforeSendingPersonalData, neverSendData, sendAllDataWithoutPrompting. | `userDefined`, `alwaysPrompt`, `promptBeforeSendingPersonalData`, `neverSendData`, `sendAllDataWithoutPrompting` |
| **DefenderRequireBehaviorMonitoring** | Write | Boolean | Indicates whether or not to require behavior monitoring. | |
| **DefenderRequireCloudProtection** | Write | Boolean | Indicates whether or not to require cloud protection. | |
| **DefenderRequireNetworkInspectionSystem** | Write | Boolean | Indicates whether or not to require network inspection system. | |
| **DefenderRequireRealTimeMonitoring** | Write | Boolean | Indicates whether or not to require real time monitoring. | |
| **DefenderScanArchiveFiles** | Write | Boolean | Indicates whether or not to scan archive files. | |
| **DefenderScanDownloads** | Write | Boolean | Indicates whether or not to scan downloads. | |
| **DefenderScanIncomingMail** | Write | Boolean | Indicates whether or not to scan incoming mail messages. | |
| **DefenderScanMappedNetworkDrivesDuringFullScan** | Write | Boolean | Indicates whether or not to scan mapped network drives during full scan. | |
| **DefenderScanMaxCpu** | Write | UInt32 | Max CPU usage percentage during scan. Valid values 0 to 100 | |
| **DefenderScanNetworkFiles** | Write | Boolean | Indicates whether or not to scan files opened from a network folder. | |
| **DefenderScanRemovableDrivesDuringFullScan** | Write | Boolean | Indicates whether or not to scan removable drives during full scan. | |
| **DefenderScanScriptsLoadedInInternetExplorer** | Write | Boolean | Indicates whether or not to scan scripts loaded in Internet Explorer browser. | |
| **DefenderScanType** | Write | String | The defender system scan type. Possible values are: userDefined, disabled, quick, full. | `userDefined`, `disabled`, `quick`, `full` |
| **DefenderScheduledQuickScanTime** | Write | String | The time to perform a daily quick scan. | |
| **DefenderScheduledScanTime** | Write | String | The defender time for the system scan. | |
| **DefenderScheduleScanEnableLowCpuPriority** | Write | Boolean | When enabled, low CPU priority will be used during scheduled scans. | |
| **DefenderSignatureUpdateIntervalInHours** | Write | UInt32 | The signature update interval in hours. Specify 0 not to check. Valid values 0 to 24 | |
| **DefenderSubmitSamplesConsentType** | Write | String | Checks for the user consent level in Windows Defender to send data. Possible values are: sendSafeSamplesAutomatically, alwaysPrompt, neverSend, sendAllSamplesAutomatically. | `sendSafeSamplesAutomatically`, `alwaysPrompt`, `neverSend`, `sendAllSamplesAutomatically` |
| **DefenderSystemScanSchedule** | Write | String | Defender day of the week for the system scan. Possible values are: userDefined, everyday, sunday, monday, tuesday, wednesday, thursday, friday, saturday, noScheduledScan. | `userDefined`, `everyday`, `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `noScheduledScan` |
| **DeveloperUnlockSetting** | Write | String | Indicates whether or not to allow developer unlock. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **DeviceManagementBlockFactoryResetOnMobile** | Write | Boolean | Indicates whether or not to Block the user from resetting their phone. | |
| **DeviceManagementBlockManualUnenroll** | Write | Boolean | Indicates whether or not to Block the user from doing manual un-enrollment from device management. | |
| **DiagnosticsDataSubmissionMode** | Write | String | Gets or sets a value allowing the device to send diagnostic and usage telemetry data, such as Watson. Possible values are: userDefined, none, basic, enhanced, full. | `userDefined`, `none`, `basic`, `enhanced`, `full` |
| **DisplayAppListWithGdiDPIScalingTurnedOff** | Write | StringArray[] | List of legacy applications that have GDI DPI Scaling turned off. | |
| **DisplayAppListWithGdiDPIScalingTurnedOn** | Write | StringArray[] | List of legacy applications that have GDI DPI Scaling turned on. | |
| **EdgeAllowStartPagesModification** | Write | Boolean | Allow users to change Start pages on Edge. Use the EdgeHomepageUrls to specify the Start pages that the user would see by default when they open Edge. | |
| **EdgeBlockAccessToAboutFlags** | Write | Boolean | Indicates whether or not to prevent access to about flags on Edge browser. | |
| **EdgeBlockAddressBarDropdown** | Write | Boolean | Block the address bar dropdown functionality in Microsoft Edge. Disable this settings to minimize network connections from Microsoft Edge to Microsoft services. | |
| **EdgeBlockAutofill** | Write | Boolean | Indicates whether or not to block auto fill. | |
| **EdgeBlockCompatibilityList** | Write | Boolean | Block Microsoft compatibility list in Microsoft Edge. This list from Microsoft helps Edge properly display sites with known compatibility issues. | |
| **EdgeBlockDeveloperTools** | Write | Boolean | Indicates whether or not to block developer tools in the Edge browser. | |
| **EdgeBlocked** | Write | Boolean | Indicates whether or not to Block the user from using the Edge browser. | |
| **EdgeBlockEditFavorites** | Write | Boolean | Indicates whether or not to Block the user from making changes to Favorites. | |
| **EdgeBlockExtensions** | Write | Boolean | Indicates whether or not to block extensions in the Edge browser. | |
| **EdgeBlockFullScreenMode** | Write | Boolean | Allow or prevent Edge from entering the full screen mode. | |
| **EdgeBlockInPrivateBrowsing** | Write | Boolean | Indicates whether or not to block InPrivate browsing on corporate networks, in the Edge browser. | |
| **EdgeBlockJavaScript** | Write | Boolean | Indicates whether or not to Block the user from using JavaScript. | |
| **EdgeBlockLiveTileDataCollection** | Write | Boolean | Block the collection of information by Microsoft for live tile creation when users pin a site to Start from Microsoft Edge. | |
| **EdgeBlockPasswordManager** | Write | Boolean | Indicates whether or not to Block password manager. | |
| **EdgeBlockPopups** | Write | Boolean | Indicates whether or not to block popups. | |
| **EdgeBlockPrelaunch** | Write | Boolean | Decide whether Microsoft Edge is prelaunched at Windows startup. | |
| **EdgeBlockPrinting** | Write | Boolean | Configure Edge to allow or block printing. | |
| **EdgeBlockSavingHistory** | Write | Boolean | Configure Edge to allow browsing history to be saved or to never save browsing history. | |
| **EdgeBlockSearchEngineCustomization** | Write | Boolean | Indicates whether or not to block the user from adding new search engine or changing the default search engine. | |
| **EdgeBlockSearchSuggestions** | Write | Boolean | Indicates whether or not to block the user from using the search suggestions in the address bar. | |
| **EdgeBlockSendingDoNotTrackHeader** | Write | Boolean | Indicates whether or not to Block the user from sending the do not track header. | |
| **EdgeBlockSendingIntranetTrafficToInternetExplorer** | Write | Boolean | Indicates whether or not to switch the intranet traffic from Edge to Internet Explorer. Note: the name of this property is misleading the property is obsolete, use EdgeSendIntranetTrafficToInternetExplorer instead. | |
| **EdgeBlockSideloadingExtensions** | Write | Boolean | Indicates whether the user can sideload extensions. | |
| **EdgeBlockTabPreloading** | Write | Boolean | Configure whether Edge preloads the new tab page at Windows startup. | |
| **EdgeBlockWebContentOnNewTabPage** | Write | Boolean | Configure to load a blank page in Edge instead of the default New tab page and prevent users from changing it. | |
| **EdgeClearBrowsingDataOnExit** | Write | Boolean | Clear browsing data on exiting Microsoft Edge. | |
| **EdgeCookiePolicy** | Write | String | Indicates which cookies to block in the Edge browser. Possible values are: userDefined, allow, blockThirdParty, blockAll. | `userDefined`, `allow`, `blockThirdParty`, `blockAll` |
| **EdgeDisableFirstRunPage** | Write | Boolean | Block the Microsoft web page that opens on the first use of Microsoft Edge. This policy allows enterprises, like those enrolled in zero emissions configurations, to block this page. | |
| **EdgeEnterpriseModeSiteListLocation** | Write | String | Indicates the enterprise mode site list location. Could be a local file, local network or http location. | |
| **EdgeFavoritesBarVisibility** | Write | String | Get or set a value that specifies whether to set the favorites bar to always be visible or hidden on any page. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **EdgeFavoritesListLocation** | Write | String | The location of the favorites list to provision. Could be a local file, local network or http location. | |
| **EdgeFirstRunUrl** | Write | String | The first run URL for when Edge browser is opened for the first time. | |
| **EdgeHomeButtonConfiguration** | Write | MSFT_MicrosoftGraphedgeHomeButtonConfiguration | Causes the Home button to either hide, load the default Start page, load a New tab page, or a custom URL | |
| **EdgeHomeButtonConfigurationEnabled** | Write | Boolean | Enable the Home button configuration. | |
| **EdgeHomepageUrls** | Write | StringArray[] | The list of URLs for homepages shodwn on MDM-enrolled devices on Edge browser. | |
| **EdgeKioskModeRestriction** | Write | String | Controls how the Microsoft Edge settings are restricted based on the configure kiosk mode. Possible values are: notConfigured, digitalSignage, normalMode, publicBrowsingSingleApp, publicBrowsingMultiApp. | `notConfigured`, `digitalSignage`, `normalMode`, `publicBrowsingSingleApp`, `publicBrowsingMultiApp` |
| **EdgeKioskResetAfterIdleTimeInMinutes** | Write | UInt32 | Specifies the time in minutes from the last user activity before Microsoft Edge kiosk resets.  Valid values are 0-1440. The default is 5. 0 indicates no reset. Valid values 0 to 1440 | |
| **EdgeNewTabPageURL** | Write | String | Specify the page opened when new tabs are created. | |
| **EdgeOpensWith** | Write | String | Specify what kind of pages are open at start. Possible values are: notConfigured, startPage, newTabPage, previousPages, specificPages. | `notConfigured`, `startPage`, `newTabPage`, `previousPages`, `specificPages` |
| **EdgePreventCertificateErrorOverride** | Write | Boolean | Allow or prevent users from overriding certificate errors. | |
| **EdgeRequiredExtensionPackageFamilyNames** | Write | StringArray[] | Specify the list of package family names of browser extensions that are required and cannot be turned off by the user. | |
| **EdgeRequireSmartScreen** | Write | Boolean | Indicates whether or not to Require the user to use the smart screen filter. | |
| **EdgeSearchEngine** | Write | MSFT_MicrosoftGraphedgeSearchEngineBase | Allows IT admins to set a default search engine for MDM-Controlled devices. Users can override this and change their default search engine provided the AllowSearchEngineCustomization policy is not set. | |
| **EdgeSendIntranetTrafficToInternetExplorer** | Write | Boolean | Indicates whether or not to switch the intranet traffic from Edge to Internet Explorer. | |
| **EdgeShowMessageWhenOpeningInternetExplorerSites** | Write | String | Controls the message displayed by Edge before switching to Internet Explorer. Possible values are: notConfigured, disabled, enabled, keepGoing. | `notConfigured`, `disabled`, `enabled`, `keepGoing` |
| **EdgeSyncFavoritesWithInternetExplorer** | Write | Boolean | Enable favorites sync between Internet Explorer and Microsoft Edge. Additions, deletions, modifications and order changes to favorites are shared between browsers. | |
| **EdgeTelemetryForMicrosoft365Analytics** | Write | String | Specifies what type of telemetry data (none, intranet, internet, both) is sent to Microsoft 365 Analytics. Possible values are: notConfigured, intranet, internet, intranetAndInternet. | `notConfigured`, `intranet`, `internet`, `intranetAndInternet` |
| **EnableAutomaticRedeployment** | Write | Boolean | Allow users with administrative rights to delete all user data and settings using CTRL + Win + R at the device lock screen so that the device can be automatically re-configured and re-enrolled into management. | |
| **EnergySaverOnBatteryThresholdPercentage** | Write | UInt32 | This setting allows you to specify battery charge level at which Energy Saver is turned on. While on battery, Energy Saver is automatically turned on at (and below) the specified battery charge level. Valid input range (0-100). Valid values 0 to 100 | |
| **EnergySaverPluggedInThresholdPercentage** | Write | UInt32 | This setting allows you to specify battery charge level at which Energy Saver is turned on. While plugged in, Energy Saver is automatically turned on at (and below) the specified battery charge level. Valid input range (0-100). Valid values 0 to 100 | |
| **EnterpriseCloudPrintDiscoveryEndPoint** | Write | String | Endpoint for discovering cloud printers. | |
| **EnterpriseCloudPrintDiscoveryMaxLimit** | Write | UInt32 | Maximum number of printers that should be queried from a discovery endpoint. This is a mobile only setting. Valid values 1 to 65535 | |
| **EnterpriseCloudPrintMopriaDiscoveryResourceIdentifier** | Write | String | OAuth resource URI for printer discovery service as configured in Azure portal. | |
| **EnterpriseCloudPrintOAuthAuthority** | Write | String | Authentication endpoint for acquiring OAuth tokens. | |
| **EnterpriseCloudPrintOAuthClientIdentifier** | Write | String | GUID of a client application authorized to retrieve OAuth tokens from the OAuth Authority. | |
| **EnterpriseCloudPrintResourceIdentifier** | Write | String | OAuth resource URI for print service as configured in the Azure portal. | |
| **ExperienceBlockDeviceDiscovery** | Write | Boolean | Indicates whether or not to enable device discovery UX. | |
| **ExperienceBlockErrorDialogWhenNoSIM** | Write | Boolean | Indicates whether or not to allow the error dialog from displaying if no SIM card is detected. | |
| **ExperienceBlockTaskSwitcher** | Write | Boolean | Indicates whether or not to enable task switching on the device. | |
| **ExperienceDoNotSyncBrowserSettings** | Write | String | Allow or prevent the syncing of Microsoft Edge Browser settings. Option for IT admins to prevent syncing across devices, but allow user override. Possible values are: notConfigured, blockedWithUserOverride, blocked. | `notConfigured`, `blockedWithUserOverride`, `blocked` |
| **FindMyFiles** | Write | String | Controls if the user can configure search to Find My Files mode, which searches files in secondary hard drives and also outside of the user profile. Find My Files does not allow users to search files or locations to which they do not have access. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **GameDvrBlocked** | Write | Boolean | Indicates whether or not to block DVR and broadcasting. | |
| **InkWorkspaceAccess** | Write | String | Controls the user access to the ink workspace, from the desktop and from above the lock screen. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **InkWorkspaceAccessState** | Write | String | Controls the user access to the ink workspace, from the desktop and from above the lock screen. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **InkWorkspaceBlockSuggestedApps** | Write | Boolean | Specify whether to show recommended app suggestions in the ink workspace. | |
| **InternetSharingBlocked** | Write | Boolean | Indicates whether or not to Block the user from using internet sharing. | |
| **LocationServicesBlocked** | Write | Boolean | Indicates whether or not to Block the user from location services. | |
| **LockScreenActivateAppsWithVoice** | Write | String | This policy setting specifies whether Windows apps can be activated by voice while the system is locked. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **LockScreenAllowTimeoutConfiguration** | Write | Boolean | Specify whether to show a user-configurable setting to control the screen timeout while on the lock screen of Windows 10 Mobile devices. If this policy is set to Allow, the value set by lockScreenTimeoutInSeconds is ignored. | |
| **LockScreenBlockActionCenterNotifications** | Write | Boolean | Indicates whether or not to block action center notifications over lock screen. | |
| **LockScreenBlockCortana** | Write | Boolean | Indicates whether or not the user can interact with Cortana using speech while the system is locked. | |
| **LockScreenBlockToastNotifications** | Write | Boolean | Indicates whether to allow toast notifications above the device lock screen. | |
| **LockScreenTimeoutInSeconds** | Write | UInt32 | Set the duration (in seconds) from the screen locking to the screen turning off for Windows 10 Mobile devices. Supported values are 11-1800. Valid values 11 to 1800 | |
| **LogonBlockFastUserSwitching** | Write | Boolean | Disables the ability to quickly switch between users that are logged on simultaneously without logging off. | |
| **MessagingBlockMMS** | Write | Boolean | Indicates whether or not to block the MMS send/receive functionality on the device. | |
| **MessagingBlockRichCommunicationServices** | Write | Boolean | Indicates whether or not to block the RCS send/receive functionality on the device. | |
| **MessagingBlockSync** | Write | Boolean | Indicates whether or not to block text message back up and restore and Messaging Everywhere. | |
| **MicrosoftAccountBlocked** | Write | Boolean | Indicates whether or not to Block a Microsoft account. | |
| **MicrosoftAccountBlockSettingsSync** | Write | Boolean | Indicates whether or not to Block Microsoft account settings sync. | |
| **MicrosoftAccountSignInAssistantSettings** | Write | String | Controls the Microsoft Account Sign-In Assistant (wlidsvc) NT service. Possible values are: notConfigured, disabled. | `notConfigured`, `disabled` |
| **NetworkProxyApplySettingsDeviceWide** | Write | Boolean | If set, proxy settings will be applied to all processes and accounts in the device. Otherwise, it will be applied to the user account thats enrolled into MDM. | |
| **NetworkProxyAutomaticConfigurationUrl** | Write | String | Address to the proxy auto-config (PAC) script you want to use. | |
| **NetworkProxyDisableAutoDetect** | Write | Boolean | Disable automatic detection of settings. If enabled, the system will try to find the path to a proxy auto-config (PAC) script. | |
| **NetworkProxyServer** | Write | MSFT_MicrosoftGraphwindows10NetworkProxyServer | Specifies manual proxy server settings. | |
| **NfcBlocked** | Write | Boolean | Indicates whether or not to Block the user from using near field communication. | |
| **OneDriveDisableFileSync** | Write | Boolean | Gets or sets a value allowing IT admins to prevent apps and features from working with files on OneDrive. | |
| **PasswordBlockSimple** | Write | Boolean | Specify whether PINs or passwords such as '1111' or '1234' are allowed. For Windows 10 desktops, it also controls the use of picture passwords. | |
| **PasswordExpirationDays** | Write | UInt32 | The password expiration in days. Valid values 0 to 730 | |
| **PasswordMinimumAgeInDays** | Write | UInt32 | This security setting determines the period of time (in days) that a password must be used before the user can change it. Valid values 0 to 998 | |
| **PasswordMinimumCharacterSetCount** | Write | UInt32 | The number of character sets required in the password. | |
| **PasswordMinimumLength** | Write | UInt32 | The minimum password length. Valid values 4 to 16 | |
| **PasswordMinutesOfInactivityBeforeScreenTimeout** | Write | UInt32 | The minutes of inactivity before the screen times out. | |
| **PasswordPreviousPasswordBlockCount** | Write | UInt32 | The number of previous passwords to prevent reuse of. Valid values 0 to 50 | |
| **PasswordRequired** | Write | Boolean | Indicates whether or not to require the user to have a password. | |
| **PasswordRequiredType** | Write | String | The required password type. Possible values are: deviceDefault, alphanumeric, numeric. | `deviceDefault`, `alphanumeric`, `numeric` |
| **PasswordRequireWhenResumeFromIdleState** | Write | Boolean | Indicates whether or not to require a password upon resuming from an idle state. | |
| **PasswordSignInFailureCountBeforeFactoryReset** | Write | UInt32 | The number of sign in failures before factory reset. Valid values 0 to 999 | |
| **PersonalizationDesktopImageUrl** | Write | String | A http or https Url to a jpg, jpeg or png image that needs to be downloaded and used as the Desktop Image or a file Url to a local image on the file system that needs to used as the Desktop Image. | |
| **PersonalizationLockScreenImageUrl** | Write | String | A http or https Url to a jpg, jpeg or png image that neeeds to be downloaded and used as the Lock Screen Image or a file Url to a local image on the file system that needs to be used as the Lock Screen Image. | |
| **PowerButtonActionOnBattery** | Write | String | This setting specifies the action that Windows takes when a user presses the Power button while on battery. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PowerButtonActionPluggedIn** | Write | String | This setting specifies the action that Windows takes when a user presses the Power button while plugged in. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PowerHybridSleepOnBattery** | Write | String | This setting allows you to turn off hybrid sleep while on battery. If you set this setting to disable, a hiberfile is not generated when the system transitions to sleep (Stand By). If you set this setting to enable or do not configure this policy setting, users control this setting. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **PowerHybridSleepPluggedIn** | Write | String | This setting allows you to turn off hybrid sleep while plugged in. If you set this setting to disable, a hiberfile is not generated when the system transitions to sleep (Stand By). If you set this setting to enable or do not configure this policy setting, users control this setting. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **PowerLidCloseActionOnBattery** | Write | String | This setting specifies the action that Windows takes when a user closes the lid on a mobile PC while on battery. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PowerLidCloseActionPluggedIn** | Write | String | This setting specifies the action that Windows takes when a user closes the lid on a mobile PC while plugged in. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PowerSleepButtonActionOnBattery** | Write | String | This setting specifies the action that Windows takes when a user presses the Sleep button while on battery. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PowerSleepButtonActionPluggedIn** | Write | String | This setting specifies the action that Windows takes when a user presses the Sleep button while plugged in. Possible values are: notConfigured, noAction, sleep, hibernate, shutdown. | `notConfigured`, `noAction`, `sleep`, `hibernate`, `shutdown` |
| **PrinterBlockAddition** | Write | Boolean | Prevent user installation of additional printers from printers settings. | |
| **PrinterDefaultName** | Write | String | Name (network host name) of an installed printer. | |
| **PrinterNames** | Write | StringArray[] | Automatically provision printers based on their names (network host names). | |
| **PrivacyAdvertisingId** | Write | String | Enables or disables the use of advertising ID. Added in Windows 10, version 1607. Possible values are: notConfigured, blocked, allowed. | `notConfigured`, `blocked`, `allowed` |
| **PrivacyAutoAcceptPairingAndConsentPrompts** | Write | Boolean | Indicates whether or not to allow the automatic acceptance of the pairing and privacy user consent dialog when launching apps. | |
| **PrivacyBlockActivityFeed** | Write | Boolean | Blocks the usage of cloud based speech services for Cortana, Dictation, or Store applications. | |
| **PrivacyBlockInputPersonalization** | Write | Boolean | Indicates whether or not to block the usage of cloud based speech services for Cortana, Dictation, or Store applications. | |
| **PrivacyBlockPublishUserActivities** | Write | Boolean | Blocks the shared experiences/discovery of recently used resources in task switcher etc. | |
| **PrivacyDisableLaunchExperience** | Write | Boolean | This policy prevents the privacy experience from launching during user logon for new and upgraded users. | |
| **ResetProtectionModeBlocked** | Write | Boolean | Indicates whether or not to Block the user from reset protection mode. | |
| **SafeSearchFilter** | Write | String | Specifies what filter level of safe search is required. Possible values are: userDefined, strict, moderate. | `userDefined`, `strict`, `moderate` |
| **ScreenCaptureBlocked** | Write | Boolean | Indicates whether or not to Block the user from taking Screenshots. | |
| **SearchBlockDiacritics** | Write | Boolean | Specifies if search can use diacritics. | |
| **SearchBlockWebResults** | Write | Boolean | Indicates whether or not to block the web search. | |
| **SearchDisableAutoLanguageDetection** | Write | Boolean | Specifies whether to use automatic language detection when indexing content and properties. | |
| **SearchDisableIndexerBackoff** | Write | Boolean | Indicates whether or not to disable the search indexer backoff feature. | |
| **SearchDisableIndexingEncryptedItems** | Write | Boolean | Indicates whether or not to block indexing of WIP-protected items to prevent them from appearing in search results for Cortana or Explorer. | |
| **SearchDisableIndexingRemovableDrive** | Write | Boolean | Indicates whether or not to allow users to add locations on removable drives to libraries and to be indexed. | |
| **SearchDisableLocation** | Write | Boolean | Specifies if search can use location information. | |
| **SearchDisableUseLocation** | Write | Boolean | Specifies if search can use location information. | |
| **SearchEnableAutomaticIndexSizeManangement** | Write | Boolean | Specifies minimum amount of hard drive space on the same drive as the index location before indexing stops. | |
| **SearchEnableRemoteQueries** | Write | Boolean | Indicates whether or not to block remote queries of this computers index. | |
| **SecurityBlockAzureADJoinedDevicesAutoEncryption** | Write | Boolean | Specify whether to allow automatic device encryption during OOBE when the device is Azure AD joined (desktop only). | |
| **SettingsBlockAccountsPage** | Write | Boolean | Indicates whether or not to block access to Accounts in Settings app. | |
| **SettingsBlockAddProvisioningPackage** | Write | Boolean | Indicates whether or not to block the user from installing provisioning packages. | |
| **SettingsBlockAppsPage** | Write | Boolean | Indicates whether or not to block access to Apps in Settings app. | |
| **SettingsBlockChangeLanguage** | Write | Boolean | Indicates whether or not to block the user from changing the language settings. | |
| **SettingsBlockChangePowerSleep** | Write | Boolean | Indicates whether or not to block the user from changing power and sleep settings. | |
| **SettingsBlockChangeRegion** | Write | Boolean | Indicates whether or not to block the user from changing the region settings. | |
| **SettingsBlockChangeSystemTime** | Write | Boolean | Indicates whether or not to block the user from changing date and time settings. | |
| **SettingsBlockDevicesPage** | Write | Boolean | Indicates whether or not to block access to Devices in Settings app. | |
| **SettingsBlockEaseOfAccessPage** | Write | Boolean | Indicates whether or not to block access to Ease of Access in Settings app. | |
| **SettingsBlockEditDeviceName** | Write | Boolean | Indicates whether or not to block the user from editing the device name. | |
| **SettingsBlockGamingPage** | Write | Boolean | Indicates whether or not to block access to Gaming in Settings app. | |
| **SettingsBlockNetworkInternetPage** | Write | Boolean | Indicates whether or not to block access to Network & Internet in Settings app. | |
| **SettingsBlockPersonalizationPage** | Write | Boolean | Indicates whether or not to block access to Personalization in Settings app. | |
| **SettingsBlockPrivacyPage** | Write | Boolean | Indicates whether or not to block access to Privacy in Settings app. | |
| **SettingsBlockRemoveProvisioningPackage** | Write | Boolean | Indicates whether or not to block the runtime configuration agent from removing provisioning packages. | |
| **SettingsBlockSettingsApp** | Write | Boolean | Indicates whether or not to block access to Settings app. | |
| **SettingsBlockSystemPage** | Write | Boolean | Indicates whether or not to block access to System in Settings app. | |
| **SettingsBlockTimeLanguagePage** | Write | Boolean | Indicates whether or not to block access to Time & Language in Settings app. | |
| **SettingsBlockUpdateSecurityPage** | Write | Boolean | Indicates whether or not to block access to Update & Security in Settings app. | |
| **SharedUserAppDataAllowed** | Write | Boolean | Indicates whether or not to block multiple users of the same app to share data. | |
| **SmartScreenAppInstallControl** | Write | String | Added in Windows 10, version 1703. Allows IT Admins to control whether users are allowed to install apps from places other than the Store. Possible values are: notConfigured, anywhere, storeOnly, recommendations, preferStore. | `notConfigured`, `anywhere`, `storeOnly`, `recommendations`, `preferStore` |
| **SmartScreenBlockPromptOverride** | Write | Boolean | Indicates whether or not users can override SmartScreen Filter warnings about potentially malicious websites. | |
| **SmartScreenBlockPromptOverrideForFiles** | Write | Boolean | Indicates whether or not users can override the SmartScreen Filter warnings about downloading unverified files | |
| **SmartScreenEnableAppInstallControl** | Write | Boolean | This property will be deprecated in July 2019 and will be replaced by property SmartScreenAppInstallControl. Allows IT Admins to control whether users are allowed to install apps from places other than the Store. | |
| **StartBlockUnpinningAppsFromTaskbar** | Write | Boolean | Indicates whether or not to block the user from unpinning apps from taskbar. | |
| **StartMenuAppListVisibility** | Write | String | Setting the value of this collapses the app list, removes the app list entirely, or disables the corresponding toggle in the Settings app. Possible values are: userDefined, collapse, remove, disableSettingsApp. | `userDefined`, `collapse`, `remove`, `disableSettingsApp` |
| **StartMenuHideChangeAccountSettings** | Write | Boolean | Enabling this policy hides the change account setting from appearing in the user tile in the start menu. | |
| **StartMenuHideFrequentlyUsedApps** | Write | Boolean | Enabling this policy hides the most used apps from appearing on the start menu and disables the corresponding toggle in the Settings app. | |
| **StartMenuHideHibernate** | Write | Boolean | Enabling this policy hides hibernate from appearing in the power button in the start menu. | |
| **StartMenuHideLock** | Write | Boolean | Enabling this policy hides lock from appearing in the user tile in the start menu. | |
| **StartMenuHidePowerButton** | Write | Boolean | Enabling this policy hides the power button from appearing in the start menu. | |
| **StartMenuHideRecentJumpLists** | Write | Boolean | Enabling this policy hides recent jump lists from appearing on the start menu/taskbar and disables the corresponding toggle in the Settings app. | |
| **StartMenuHideRecentlyAddedApps** | Write | Boolean | Enabling this policy hides recently added apps from appearing on the start menu and disables the corresponding toggle in the Settings app. | |
| **StartMenuHideRestartOptions** | Write | Boolean | Enabling this policy hides 'Restart/Update and Restart' from appearing in the power button in the start menu. | |
| **StartMenuHideShutDown** | Write | Boolean | Enabling this policy hides shut down/update and shut down from appearing in the power button in the start menu. | |
| **StartMenuHideSignOut** | Write | Boolean | Enabling this policy hides sign out from appearing in the user tile in the start menu. | |
| **StartMenuHideSleep** | Write | Boolean | Enabling this policy hides sleep from appearing in the power button in the start menu. | |
| **StartMenuHideSwitchAccount** | Write | Boolean | Enabling this policy hides switch account from appearing in the user tile in the start menu. | |
| **StartMenuHideUserTile** | Write | Boolean | Enabling this policy hides the user tile from appearing in the start menu. | |
| **StartMenuLayoutEdgeAssetsXml** | Write | String | This policy setting allows you to import Edge assets to be used with startMenuLayoutXml policy. Start layout can contain secondary tile from Edge app which looks for Edge local asset file. Edge local asset would not exist and cause Edge secondary tile to appear empty in this case. This policy only gets applied when startMenuLayoutXml policy is modified. The value should be a UTF-8 Base64 encoded byte array. | |
| **StartMenuLayoutXml** | Write | String | Allows admins to override the default Start menu layout and prevents the user from changing it. The layout is modified by specifying an XML file based on a layout modification schema. XML needs to be in a UTF8 encoded byte array format. | |
| **StartMenuMode** | Write | String | Allows admins to decide how the Start menu is displayed. Possible values are: userDefined, fullScreen, nonFullScreen. | `userDefined`, `fullScreen`, `nonFullScreen` |
| **StartMenuPinnedFolderDocuments** | Write | String | Enforces the visibility (Show/Hide) of the Documents folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderDownloads** | Write | String | Enforces the visibility (Show/Hide) of the Downloads folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderFileExplorer** | Write | String | Enforces the visibility (Show/Hide) of the FileExplorer shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderHomeGroup** | Write | String | Enforces the visibility (Show/Hide) of the HomeGroup folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderMusic** | Write | String | Enforces the visibility (Show/Hide) of the Music folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderNetwork** | Write | String | Enforces the visibility (Show/Hide) of the Network folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderPersonalFolder** | Write | String | Enforces the visibility (Show/Hide) of the PersonalFolder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderPictures** | Write | String | Enforces the visibility (Show/Hide) of the Pictures folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderSettings** | Write | String | Enforces the visibility (Show/Hide) of the Settings folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StartMenuPinnedFolderVideos** | Write | String | Enforces the visibility (Show/Hide) of the Videos folder shortcut on the Start menu. Possible values are: notConfigured, hide, show. | `notConfigured`, `hide`, `show` |
| **StorageBlockRemovableStorage** | Write | Boolean | Indicates whether or not to Block the user from using removable storage. | |
| **StorageRequireMobileDeviceEncryption** | Write | Boolean | Indicating whether or not to require encryption on a mobile device. | |
| **StorageRestrictAppDataToSystemVolume** | Write | Boolean | Indicates whether application data is restricted to the system drive. | |
| **StorageRestrictAppInstallToSystemVolume** | Write | Boolean | Indicates whether the installation of applications is restricted to the system drive. | |
| **SystemTelemetryProxyServer** | Write | String | Gets or sets the fully qualified domain name (FQDN) or IP address of a proxy server to forward Connected User Experiences and Telemetry requests. | |
| **TaskManagerBlockEndTask** | Write | Boolean | Specify whether non-administrators can use Task Manager to end tasks. | |
| **TenantLockdownRequireNetworkDuringOutOfBoxExperience** | Write | Boolean | Whether the device is required to connect to the network. | |
| **UninstallBuiltInApps** | Write | Boolean | Indicates whether or not to uninstall a fixed list of built-in Windows apps. | |
| **UsbBlocked** | Write | Boolean | Indicates whether or not to Block the user from USB connection. | |
| **VoiceRecordingBlocked** | Write | Boolean | Indicates whether or not to Block the user from voice recording. | |
| **WebRtcBlockLocalhostIpAddress** | Write | Boolean | Indicates whether or not user's localhost IP address is displayed while making phone calls using the WebRTC | |
| **WiFiBlockAutomaticConnectHotspots** | Write | Boolean | Indicating whether or not to block automatically connecting to Wi-Fi hotspots. Has no impact if Wi-Fi is blocked. | |
| **WiFiBlocked** | Write | Boolean | Indicates whether or not to Block the user from using Wi-Fi. | |
| **WiFiBlockManualConfiguration** | Write | Boolean | Indicates whether or not to Block the user from using Wi-Fi manual configuration. | |
| **WiFiScanInterval** | Write | UInt32 | Specify how often devices scan for Wi-Fi networks. Supported values are 1-500, where 100 = default, and 500 = low frequency. Valid values 1 to 500 | |
| **Windows10AppsForceUpdateSchedule** | Write | MSFT_MicrosoftGraphwindows10AppsForceUpdateSchedule | Windows 10 force update schedule for Apps. | |
| **WindowsSpotlightBlockConsumerSpecificFeatures** | Write | Boolean | Allows IT admins to block experiences that are typically for consumers only, such as Start suggestions, Membership notifications, Post-OOBE app install and redirect tiles. | |
| **WindowsSpotlightBlocked** | Write | Boolean | Allows IT admins to turn off all Windows Spotlight features | |
| **WindowsSpotlightBlockOnActionCenter** | Write | Boolean | Block suggestions from Microsoft that show after each OS clean install, upgrade or in an on-going basis to introduce users to what is new or changed | |
| **WindowsSpotlightBlockTailoredExperiences** | Write | Boolean | Block personalized content in Windows spotlight based on users device usage. | |
| **WindowsSpotlightBlockThirdPartyNotifications** | Write | Boolean | Block third party content delivered via Windows Spotlight | |
| **WindowsSpotlightBlockWelcomeExperience** | Write | Boolean | Block Windows Spotlight Windows welcome experience | |
| **WindowsSpotlightBlockWindowsTips** | Write | Boolean | Allows IT admins to turn off the popup of Windows Tips. | |
| **WindowsSpotlightConfigureOnLockScreen** | Write | String | Specifies the type of Spotlight. Possible values are: notConfigured, disabled, enabled. | `notConfigured`, `disabled`, `enabled` |
| **WindowsStoreBlockAutoUpdate** | Write | Boolean | Indicates whether or not to block automatic update of apps from Windows Store. | |
| **WindowsStoreBlocked** | Write | Boolean | Indicates whether or not to Block the user from using the Windows store. | |
| **WindowsStoreEnablePrivateStoreOnly** | Write | Boolean | Indicates whether or not to enable Private Store Only. | |
| **WirelessDisplayBlockProjectionToThisDevice** | Write | Boolean | Indicates whether or not to allow other devices from discovering this PC for projection. | |
| **WirelessDisplayBlockUserInputFromReceiver** | Write | Boolean | Indicates whether or not to allow user input from wireless display receiver. | |
| **WirelessDisplayRequirePinForPairing** | Write | Boolean | Indicates whether or not to require a PIN for new devices to initiate pairing. | |
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

### MSFT_MicrosoftGraphDefenderDetectedMalwareActions1

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **HighSeverity** | Write | String | Indicates a Defender action to take for high severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **LowSeverity** | Write | String | Indicates a Defender action to take for low severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **ModerateSeverity** | Write | String | Indicates a Defender action to take for moderate severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |
| **SevereSeverity** | Write | String | Indicates a Defender action to take for severe severity Malware threat detected. Possible values are: deviceDefault, clean, quarantine, remove, allow, userDefined, block. | `deviceDefault`, `clean`, `quarantine`, `remove`, `allow`, `userDefined`, `block` |

### MSFT_MicrosoftGraphEdgeHomeButtonConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **HomeButtonCustomURL** | Write | String | The specific URL to load. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.edgeHomeButtonHidden`, `#microsoft.graph.edgeHomeButtonLoadsStartPage`, `#microsoft.graph.edgeHomeButtonOpensCustomURL`, `#microsoft.graph.edgeHomeButtonOpensNewTab` |

### MSFT_MicrosoftGraphEdgeSearchEngineBase

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EdgeSearchEngineType** | Write | String | Allows IT admins to set a predefined default search engine for MDM-Controlled devices. Possible values are: default, bing. | `default`, `bing` |
| **EdgeSearchEngineOpenSearchXmlUrl** | Write | String | Points to a https link containing the OpenSearch xml file that contains, at minimum, the short name and the URL to the search Engine. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.edgeSearchEngine`, `#microsoft.graph.edgeSearchEngineCustom` |

### MSFT_MicrosoftGraphWindows10NetworkProxyServer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Address** | Write | String | Address to the proxy server. Specify an address in the format ':' | |
| **Exceptions** | Write | StringArray[] | Addresses that should not use the proxy server. The system will not use the proxy server for addresses beginning with what is specified in this node. | |
| **UseForLocalAddresses** | Write | Boolean | Specifies whether the proxy server should be used for local (intranet) addresses. | |

### MSFT_MicrosoftGraphWindows10AppsForceUpdateSchedule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Recurrence** | Write | String | Recurrence schedule. Possible values are: none, daily, weekly, monthly. | `none`, `daily`, `weekly`, `monthly` |
| **RunImmediatelyIfAfterStartDateTime** | Write | Boolean | If true, runs the task immediately if StartDateTime is in the past, else, runs at the next recurrence. | |
| **StartDateTime** | Write | String | The start time for the force restart. | |


## Description

Intune Device Configuration Policy for Windows10

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
        IntuneDeviceConfigurationPolicyWindows10 'Example'
        {
            AccountsBlockAddingNonMicrosoftAccountEmail          = $False;
            ActivateAppsWithVoice                                = "notConfigured";
            AntiTheftModeBlocked                                 = $False;
            AppManagementMSIAllowUserControlOverInstall          = $False;
            AppManagementMSIAlwaysInstallWithElevatedPrivileges  = $False;
            AppManagementPackageFamilyNamesToLaunchAfterLogOn    = @();
            AppsAllowTrustedAppsSideloading                      = "notConfigured";
            AppsBlockWindowsStoreOriginatedApps                  = $False;
            Assignments                                          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            AuthenticationAllowSecondaryDevice                   = $False;
            AuthenticationWebSignIn                              = "notConfigured";
            BluetoothAllowedServices                             = @();
            BluetoothBlockAdvertising                            = $True;
            BluetoothBlockDiscoverableMode                       = $False;
            BluetoothBlocked                                     = $True;
            BluetoothBlockPrePairing                             = $True;
            BluetoothBlockPromptedProximalConnections            = $False;
            CameraBlocked                                        = $False;
            CellularBlockDataWhenRoaming                         = $False;
            CellularBlockVpn                                     = $True;
            CellularBlockVpnWhenRoaming                          = $True;
            CellularData                                         = "allowed";
            CertificatesBlockManualRootCertificateInstallation   = $False;
            ConnectedDevicesServiceBlocked                       = $False;
            CopyPasteBlocked                                     = $False;
            CortanaBlocked                                       = $False;
            CryptographyAllowFipsAlgorithmPolicy                 = $False;
            DefenderBlockEndUserAccess                           = $False;
            DefenderBlockOnAccessProtection                      = $False;
            DefenderCloudBlockLevel                              = "notConfigured";
            DefenderDisableCatchupFullScan                       = $False;
            DefenderDisableCatchupQuickScan                      = $False;
            DefenderFileExtensionsToExclude                      = @();
            DefenderFilesAndFoldersToExclude                     = @();
            DefenderMonitorFileActivity                          = "userDefined";
            DefenderPotentiallyUnwantedAppActionSetting          = "userDefined";
            DefenderProcessesToExclude                           = @();
            DefenderPromptForSampleSubmission                    = "userDefined";
            DefenderRequireBehaviorMonitoring                    = $False;
            DefenderRequireCloudProtection                       = $False;
            DefenderRequireNetworkInspectionSystem               = $False;
            DefenderRequireRealTimeMonitoring                    = $False;
            DefenderScanArchiveFiles                             = $False;
            DefenderScanDownloads                                = $False;
            DefenderScanIncomingMail                             = $False;
            DefenderScanMappedNetworkDrivesDuringFullScan        = $False;
            DefenderScanNetworkFiles                             = $False;
            DefenderScanRemovableDrivesDuringFullScan            = $False;
            DefenderScanScriptsLoadedInInternetExplorer          = $False;
            DefenderScanType                                     = "userDefined";
            DefenderScheduleScanEnableLowCpuPriority             = $False;
            DefenderSystemScanSchedule                           = "userDefined";
            DeveloperUnlockSetting                               = "notConfigured";
            DeviceManagementBlockFactoryResetOnMobile            = $False;
            DeviceManagementBlockManualUnenroll                  = $False;
            DiagnosticsDataSubmissionMode                        = "userDefined";
            DisplayAppListWithGdiDPIScalingTurnedOff             = @();
            DisplayAppListWithGdiDPIScalingTurnedOn              = @();
            DisplayName                                          = "device config";
            EdgeAllowStartPagesModification                      = $False;
            EdgeBlockAccessToAboutFlags                          = $False;
            EdgeBlockAddressBarDropdown                          = $False;
            EdgeBlockAutofill                                    = $False;
            EdgeBlockCompatibilityList                           = $False;
            EdgeBlockDeveloperTools                              = $False;
            EdgeBlocked                                          = $False;
            EdgeBlockEditFavorites                               = $False;
            EdgeBlockExtensions                                  = $False;
            EdgeBlockFullScreenMode                              = $False;
            EdgeBlockInPrivateBrowsing                           = $False;
            EdgeBlockJavaScript                                  = $False;
            EdgeBlockLiveTileDataCollection                      = $False;
            EdgeBlockPasswordManager                             = $False;
            EdgeBlockPopups                                      = $False;
            EdgeBlockPrelaunch                                   = $False;
            EdgeBlockPrinting                                    = $False;
            EdgeBlockSavingHistory                               = $False;
            EdgeBlockSearchEngineCustomization                   = $False;
            EdgeBlockSearchSuggestions                           = $False;
            EdgeBlockSendingDoNotTrackHeader                     = $False;
            EdgeBlockSendingIntranetTrafficToInternetExplorer    = $False;
            EdgeBlockSideloadingExtensions                       = $False;
            EdgeBlockTabPreloading                               = $False;
            EdgeBlockWebContentOnNewTabPage                      = $False;
            EdgeClearBrowsingDataOnExit                          = $False;
            EdgeCookiePolicy                                     = "userDefined";
            EdgeDisableFirstRunPage                              = $False;
            EdgeFavoritesBarVisibility                           = "notConfigured";
            EdgeHomeButtonConfigurationEnabled                   = $False;
            EdgeHomepageUrls                                     = @();
            EdgeKioskModeRestriction                             = "notConfigured";
            EdgeOpensWith                                        = "notConfigured";
            EdgePreventCertificateErrorOverride                  = $False;
            EdgeRequiredExtensionPackageFamilyNames              = @();
            EdgeRequireSmartScreen                               = $False;
            EdgeSendIntranetTrafficToInternetExplorer            = $False;
            EdgeShowMessageWhenOpeningInternetExplorerSites      = "notConfigured";
            EdgeSyncFavoritesWithInternetExplorer                = $False;
            EdgeTelemetryForMicrosoft365Analytics                = "notConfigured";
            EnableAutomaticRedeployment                          = $False;
            Ensure                                               = "Present";
            ExperienceBlockDeviceDiscovery                       = $False;
            ExperienceBlockErrorDialogWhenNoSIM                  = $False;
            ExperienceBlockTaskSwitcher                          = $False;
            ExperienceDoNotSyncBrowserSettings                   = "notConfigured";
            FindMyFiles                                          = "notConfigured";
            GameDvrBlocked                                       = $True;
            InkWorkspaceAccess                                   = "notConfigured";
            InkWorkspaceAccessState                              = "notConfigured";
            InkWorkspaceBlockSuggestedApps                       = $False;
            InternetSharingBlocked                               = $False;
            LocationServicesBlocked                              = $False;
            LockScreenActivateAppsWithVoice                      = "notConfigured";
            LockScreenAllowTimeoutConfiguration                  = $False;
            LockScreenBlockActionCenterNotifications             = $False;
            LockScreenBlockCortana                               = $False;
            LockScreenBlockToastNotifications                    = $False;
            LogonBlockFastUserSwitching                          = $False;
            MessagingBlockMMS                                    = $False;
            MessagingBlockRichCommunicationServices              = $False;
            MessagingBlockSync                                   = $False;
            MicrosoftAccountBlocked                              = $False;
            MicrosoftAccountBlockSettingsSync                    = $False;
            MicrosoftAccountSignInAssistantSettings              = "notConfigured";
            NetworkProxyApplySettingsDeviceWide                  = $False;
            NetworkProxyDisableAutoDetect                        = $True;
            NetworkProxyServer                                   = MSFT_MicrosoftGraphwindows10NetworkProxyServer{
                UseForLocalAddresses = $True
                Exceptions = @('*.domain2.com')
                Address = 'proxy.domain.com:8080'
            };
            NfcBlocked                                           = $False;
            OneDriveDisableFileSync                              = $False;
            PasswordBlockSimple                                  = $False;
            PasswordRequired                                     = $False;
            PasswordRequiredType                                 = "deviceDefault";
            PasswordRequireWhenResumeFromIdleState               = $False;
            PowerButtonActionOnBattery                           = "notConfigured";
            PowerButtonActionPluggedIn                           = "notConfigured";
            PowerHybridSleepOnBattery                            = "notConfigured";
            PowerHybridSleepPluggedIn                            = "notConfigured";
            PowerLidCloseActionOnBattery                         = "notConfigured";
            PowerLidCloseActionPluggedIn                         = "notConfigured";
            PowerSleepButtonActionOnBattery                      = "notConfigured";
            PowerSleepButtonActionPluggedIn                      = "notConfigured";
            PrinterBlockAddition                                 = $False;
            PrinterNames                                         = @();
            PrivacyAdvertisingId                                 = "notConfigured";
            PrivacyAutoAcceptPairingAndConsentPrompts            = $False;
            PrivacyBlockActivityFeed                             = $False;
            PrivacyBlockInputPersonalization                     = $False;
            PrivacyBlockPublishUserActivities                    = $False;
            PrivacyDisableLaunchExperience                       = $False;
            ResetProtectionModeBlocked                           = $False;
            SafeSearchFilter                                     = "userDefined";
            ScreenCaptureBlocked                                 = $False;
            SearchBlockDiacritics                                = $False;
            SearchBlockWebResults                                = $False;
            SearchDisableAutoLanguageDetection                   = $False;
            SearchDisableIndexerBackoff                          = $False;
            SearchDisableIndexingEncryptedItems                  = $False;
            SearchDisableIndexingRemovableDrive                  = $False;
            SearchDisableLocation                                = $False;
            SearchDisableUseLocation                             = $False;
            SearchEnableAutomaticIndexSizeManangement            = $False;
            SearchEnableRemoteQueries                            = $False;
            SecurityBlockAzureADJoinedDevicesAutoEncryption      = $False;
            SettingsBlockAccountsPage                            = $False;
            SettingsBlockAddProvisioningPackage                  = $False;
            SettingsBlockAppsPage                                = $False;
            SettingsBlockChangeLanguage                          = $False;
            SettingsBlockChangePowerSleep                        = $False;
            SettingsBlockChangeRegion                            = $False;
            SettingsBlockChangeSystemTime                        = $False;
            SettingsBlockDevicesPage                             = $False;
            SettingsBlockEaseOfAccessPage                        = $False;
            SettingsBlockEditDeviceName                          = $False;
            SettingsBlockGamingPage                              = $False;
            SettingsBlockNetworkInternetPage                     = $False;
            SettingsBlockPersonalizationPage                     = $False;
            SettingsBlockPrivacyPage                             = $False;
            SettingsBlockRemoveProvisioningPackage               = $False;
            SettingsBlockSettingsApp                             = $False;
            SettingsBlockSystemPage                              = $False;
            SettingsBlockTimeLanguagePage                        = $False;
            SettingsBlockUpdateSecurityPage                      = $False;
            SharedUserAppDataAllowed                             = $False;
            SmartScreenAppInstallControl                         = "notConfigured";
            SmartScreenBlockPromptOverride                       = $False;
            SmartScreenBlockPromptOverrideForFiles               = $False;
            SmartScreenEnableAppInstallControl                   = $False;
            StartBlockUnpinningAppsFromTaskbar                   = $False;
            StartMenuAppListVisibility                           = "userDefined";
            StartMenuHideChangeAccountSettings                   = $False;
            StartMenuHideFrequentlyUsedApps                      = $False;
            StartMenuHideHibernate                               = $False;
            StartMenuHideLock                                    = $False;
            StartMenuHidePowerButton                             = $False;
            StartMenuHideRecentJumpLists                         = $False;
            StartMenuHideRecentlyAddedApps                       = $False;
            StartMenuHideRestartOptions                          = $False;
            StartMenuHideShutDown                                = $False;
            StartMenuHideSignOut                                 = $False;
            StartMenuHideSleep                                   = $False;
            StartMenuHideSwitchAccount                           = $False;
            StartMenuHideUserTile                                = $False;
            StartMenuMode                                        = "userDefined";
            StartMenuPinnedFolderDocuments                       = "notConfigured";
            StartMenuPinnedFolderDownloads                       = "notConfigured";
            StartMenuPinnedFolderFileExplorer                    = "notConfigured";
            StartMenuPinnedFolderHomeGroup                       = "notConfigured";
            StartMenuPinnedFolderMusic                           = "notConfigured";
            StartMenuPinnedFolderNetwork                         = "notConfigured";
            StartMenuPinnedFolderPersonalFolder                  = "notConfigured";
            StartMenuPinnedFolderPictures                        = "notConfigured";
            StartMenuPinnedFolderSettings                        = "notConfigured";
            StartMenuPinnedFolderVideos                          = "notConfigured";
            StorageBlockRemovableStorage                         = $False;
            StorageRequireMobileDeviceEncryption                 = $False;
            StorageRestrictAppDataToSystemVolume                 = $False;
            StorageRestrictAppInstallToSystemVolume              = $False;
            SupportsScopeTags                                    = $True;
            TaskManagerBlockEndTask                              = $False;
            TenantLockdownRequireNetworkDuringOutOfBoxExperience = $False;
            UninstallBuiltInApps                                 = $False;
            UsbBlocked                                           = $False;
            VoiceRecordingBlocked                                = $False;
            WebRtcBlockLocalhostIpAddress                        = $False;
            WiFiBlockAutomaticConnectHotspots                    = $False;
            WiFiBlocked                                          = $True;
            WiFiBlockManualConfiguration                         = $True;
            WindowsSpotlightBlockConsumerSpecificFeatures        = $False;
            WindowsSpotlightBlocked                              = $False;
            WindowsSpotlightBlockOnActionCenter                  = $False;
            WindowsSpotlightBlockTailoredExperiences             = $False;
            WindowsSpotlightBlockThirdPartyNotifications         = $False;
            WindowsSpotlightBlockWelcomeExperience               = $False;
            WindowsSpotlightBlockWindowsTips                     = $False;
            WindowsSpotlightConfigureOnLockScreen                = "notConfigured";
            WindowsStoreBlockAutoUpdate                          = $False;
            WindowsStoreBlocked                                  = $False;
            WindowsStoreEnablePrivateStoreOnly                   = $False;
            WirelessDisplayBlockProjectionToThisDevice           = $False;
            WirelessDisplayBlockUserInputFromReceiver            = $False;
            WirelessDisplayRequirePinForPairing                  = $False;
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
        IntuneDeviceConfigurationPolicyWindows10 'Example'
        {
            AccountsBlockAddingNonMicrosoftAccountEmail          = $False;
            ActivateAppsWithVoice                                = "notConfigured";
            AntiTheftModeBlocked                                 = $True; # Updated Property
            AppManagementMSIAllowUserControlOverInstall          = $False;
            AppManagementMSIAlwaysInstallWithElevatedPrivileges  = $False;
            AppManagementPackageFamilyNamesToLaunchAfterLogOn    = @();
            AppsAllowTrustedAppsSideloading                      = "notConfigured";
            AppsBlockWindowsStoreOriginatedApps                  = $False;
            Assignments                                          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            AuthenticationAllowSecondaryDevice                   = $False;
            AuthenticationWebSignIn                              = "notConfigured";
            BluetoothAllowedServices                             = @();
            BluetoothBlockAdvertising                            = $True;
            BluetoothBlockDiscoverableMode                       = $False;
            BluetoothBlocked                                     = $True;
            BluetoothBlockPrePairing                             = $True;
            BluetoothBlockPromptedProximalConnections            = $False;
            CameraBlocked                                        = $False;
            CellularBlockDataWhenRoaming                         = $False;
            CellularBlockVpn                                     = $True;
            CellularBlockVpnWhenRoaming                          = $True;
            CellularData                                         = "allowed";
            CertificatesBlockManualRootCertificateInstallation   = $False;
            ConnectedDevicesServiceBlocked                       = $False;
            CopyPasteBlocked                                     = $False;
            CortanaBlocked                                       = $False;
            CryptographyAllowFipsAlgorithmPolicy                 = $False;
            DefenderBlockEndUserAccess                           = $False;
            DefenderBlockOnAccessProtection                      = $False;
            DefenderCloudBlockLevel                              = "notConfigured";
            DefenderDisableCatchupFullScan                       = $False;
            DefenderDisableCatchupQuickScan                      = $False;
            DefenderFileExtensionsToExclude                      = @();
            DefenderFilesAndFoldersToExclude                     = @();
            DefenderMonitorFileActivity                          = "userDefined";
            DefenderPotentiallyUnwantedAppActionSetting          = "userDefined";
            DefenderProcessesToExclude                           = @();
            DefenderPromptForSampleSubmission                    = "userDefined";
            DefenderRequireBehaviorMonitoring                    = $False;
            DefenderRequireCloudProtection                       = $False;
            DefenderRequireNetworkInspectionSystem               = $False;
            DefenderRequireRealTimeMonitoring                    = $False;
            DefenderScanArchiveFiles                             = $False;
            DefenderScanDownloads                                = $False;
            DefenderScanIncomingMail                             = $False;
            DefenderScanMappedNetworkDrivesDuringFullScan        = $False;
            DefenderScanNetworkFiles                             = $False;
            DefenderScanRemovableDrivesDuringFullScan            = $False;
            DefenderScanScriptsLoadedInInternetExplorer          = $False;
            DefenderScanType                                     = "userDefined";
            DefenderScheduleScanEnableLowCpuPriority             = $False;
            DefenderSystemScanSchedule                           = "userDefined";
            DeveloperUnlockSetting                               = "notConfigured";
            DeviceManagementBlockFactoryResetOnMobile            = $False;
            DeviceManagementBlockManualUnenroll                  = $False;
            DiagnosticsDataSubmissionMode                        = "userDefined";
            DisplayAppListWithGdiDPIScalingTurnedOff             = @();
            DisplayAppListWithGdiDPIScalingTurnedOn              = @();
            DisplayName                                          = "device config";
            EdgeAllowStartPagesModification                      = $False;
            EdgeBlockAccessToAboutFlags                          = $False;
            EdgeBlockAddressBarDropdown                          = $False;
            EdgeBlockAutofill                                    = $False;
            EdgeBlockCompatibilityList                           = $False;
            EdgeBlockDeveloperTools                              = $False;
            EdgeBlocked                                          = $False;
            EdgeBlockEditFavorites                               = $False;
            EdgeBlockExtensions                                  = $False;
            EdgeBlockFullScreenMode                              = $False;
            EdgeBlockInPrivateBrowsing                           = $False;
            EdgeBlockJavaScript                                  = $False;
            EdgeBlockLiveTileDataCollection                      = $False;
            EdgeBlockPasswordManager                             = $False;
            EdgeBlockPopups                                      = $False;
            EdgeBlockPrelaunch                                   = $False;
            EdgeBlockPrinting                                    = $False;
            EdgeBlockSavingHistory                               = $False;
            EdgeBlockSearchEngineCustomization                   = $False;
            EdgeBlockSearchSuggestions                           = $False;
            EdgeBlockSendingDoNotTrackHeader                     = $False;
            EdgeBlockSendingIntranetTrafficToInternetExplorer    = $False;
            EdgeBlockSideloadingExtensions                       = $False;
            EdgeBlockTabPreloading                               = $False;
            EdgeBlockWebContentOnNewTabPage                      = $False;
            EdgeClearBrowsingDataOnExit                          = $False;
            EdgeCookiePolicy                                     = "userDefined";
            EdgeDisableFirstRunPage                              = $False;
            EdgeFavoritesBarVisibility                           = "notConfigured";
            EdgeHomeButtonConfigurationEnabled                   = $False;
            EdgeHomepageUrls                                     = @();
            EdgeKioskModeRestriction                             = "notConfigured";
            EdgeOpensWith                                        = "notConfigured";
            EdgePreventCertificateErrorOverride                  = $False;
            EdgeRequiredExtensionPackageFamilyNames              = @();
            EdgeRequireSmartScreen                               = $False;
            EdgeSendIntranetTrafficToInternetExplorer            = $False;
            EdgeShowMessageWhenOpeningInternetExplorerSites      = "notConfigured";
            EdgeSyncFavoritesWithInternetExplorer                = $False;
            EdgeTelemetryForMicrosoft365Analytics                = "notConfigured";
            EnableAutomaticRedeployment                          = $False;
            Ensure                                               = "Present";
            ExperienceBlockDeviceDiscovery                       = $False;
            ExperienceBlockErrorDialogWhenNoSIM                  = $False;
            ExperienceBlockTaskSwitcher                          = $False;
            ExperienceDoNotSyncBrowserSettings                   = "notConfigured";
            FindMyFiles                                          = "notConfigured";
            GameDvrBlocked                                       = $True;
            InkWorkspaceAccess                                   = "notConfigured";
            InkWorkspaceAccessState                              = "notConfigured";
            InkWorkspaceBlockSuggestedApps                       = $False;
            InternetSharingBlocked                               = $False;
            LocationServicesBlocked                              = $False;
            LockScreenActivateAppsWithVoice                      = "notConfigured";
            LockScreenAllowTimeoutConfiguration                  = $False;
            LockScreenBlockActionCenterNotifications             = $False;
            LockScreenBlockCortana                               = $False;
            LockScreenBlockToastNotifications                    = $False;
            LogonBlockFastUserSwitching                          = $False;
            MessagingBlockMMS                                    = $False;
            MessagingBlockRichCommunicationServices              = $False;
            MessagingBlockSync                                   = $False;
            MicrosoftAccountBlocked                              = $False;
            MicrosoftAccountBlockSettingsSync                    = $False;
            MicrosoftAccountSignInAssistantSettings              = "notConfigured";
            NetworkProxyApplySettingsDeviceWide                  = $False;
            NetworkProxyDisableAutoDetect                        = $True;
            NetworkProxyServer                                   = MSFT_MicrosoftGraphwindows10NetworkProxyServer{
                UseForLocalAddresses = $True
                Exceptions = @('*.domain2.com')
                Address = 'proxy.domain.com:8080'
            };
            NfcBlocked                                           = $False;
            OneDriveDisableFileSync                              = $False;
            PasswordBlockSimple                                  = $False;
            PasswordRequired                                     = $False;
            PasswordRequiredType                                 = "deviceDefault";
            PasswordRequireWhenResumeFromIdleState               = $False;
            PowerButtonActionOnBattery                           = "notConfigured";
            PowerButtonActionPluggedIn                           = "notConfigured";
            PowerHybridSleepOnBattery                            = "notConfigured";
            PowerHybridSleepPluggedIn                            = "notConfigured";
            PowerLidCloseActionOnBattery                         = "notConfigured";
            PowerLidCloseActionPluggedIn                         = "notConfigured";
            PowerSleepButtonActionOnBattery                      = "notConfigured";
            PowerSleepButtonActionPluggedIn                      = "notConfigured";
            PrinterBlockAddition                                 = $False;
            PrinterNames                                         = @();
            PrivacyAdvertisingId                                 = "notConfigured";
            PrivacyAutoAcceptPairingAndConsentPrompts            = $False;
            PrivacyBlockActivityFeed                             = $False;
            PrivacyBlockInputPersonalization                     = $False;
            PrivacyBlockPublishUserActivities                    = $False;
            PrivacyDisableLaunchExperience                       = $False;
            ResetProtectionModeBlocked                           = $False;
            SafeSearchFilter                                     = "userDefined";
            ScreenCaptureBlocked                                 = $False;
            SearchBlockDiacritics                                = $False;
            SearchBlockWebResults                                = $False;
            SearchDisableAutoLanguageDetection                   = $False;
            SearchDisableIndexerBackoff                          = $False;
            SearchDisableIndexingEncryptedItems                  = $False;
            SearchDisableIndexingRemovableDrive                  = $False;
            SearchDisableLocation                                = $False;
            SearchDisableUseLocation                             = $False;
            SearchEnableAutomaticIndexSizeManangement            = $False;
            SearchEnableRemoteQueries                            = $False;
            SecurityBlockAzureADJoinedDevicesAutoEncryption      = $False;
            SettingsBlockAccountsPage                            = $False;
            SettingsBlockAddProvisioningPackage                  = $False;
            SettingsBlockAppsPage                                = $False;
            SettingsBlockChangeLanguage                          = $False;
            SettingsBlockChangePowerSleep                        = $False;
            SettingsBlockChangeRegion                            = $False;
            SettingsBlockChangeSystemTime                        = $False;
            SettingsBlockDevicesPage                             = $False;
            SettingsBlockEaseOfAccessPage                        = $False;
            SettingsBlockEditDeviceName                          = $False;
            SettingsBlockGamingPage                              = $False;
            SettingsBlockNetworkInternetPage                     = $False;
            SettingsBlockPersonalizationPage                     = $False;
            SettingsBlockPrivacyPage                             = $False;
            SettingsBlockRemoveProvisioningPackage               = $False;
            SettingsBlockSettingsApp                             = $False;
            SettingsBlockSystemPage                              = $False;
            SettingsBlockTimeLanguagePage                        = $False;
            SettingsBlockUpdateSecurityPage                      = $False;
            SharedUserAppDataAllowed                             = $False;
            SmartScreenAppInstallControl                         = "notConfigured";
            SmartScreenBlockPromptOverride                       = $False;
            SmartScreenBlockPromptOverrideForFiles               = $False;
            SmartScreenEnableAppInstallControl                   = $False;
            StartBlockUnpinningAppsFromTaskbar                   = $False;
            StartMenuAppListVisibility                           = "userDefined";
            StartMenuHideChangeAccountSettings                   = $False;
            StartMenuHideFrequentlyUsedApps                      = $False;
            StartMenuHideHibernate                               = $False;
            StartMenuHideLock                                    = $False;
            StartMenuHidePowerButton                             = $False;
            StartMenuHideRecentJumpLists                         = $False;
            StartMenuHideRecentlyAddedApps                       = $False;
            StartMenuHideRestartOptions                          = $False;
            StartMenuHideShutDown                                = $False;
            StartMenuHideSignOut                                 = $False;
            StartMenuHideSleep                                   = $False;
            StartMenuHideSwitchAccount                           = $False;
            StartMenuHideUserTile                                = $False;
            StartMenuMode                                        = "userDefined";
            StartMenuPinnedFolderDocuments                       = "notConfigured";
            StartMenuPinnedFolderDownloads                       = "notConfigured";
            StartMenuPinnedFolderFileExplorer                    = "notConfigured";
            StartMenuPinnedFolderHomeGroup                       = "notConfigured";
            StartMenuPinnedFolderMusic                           = "notConfigured";
            StartMenuPinnedFolderNetwork                         = "notConfigured";
            StartMenuPinnedFolderPersonalFolder                  = "notConfigured";
            StartMenuPinnedFolderPictures                        = "notConfigured";
            StartMenuPinnedFolderSettings                        = "notConfigured";
            StartMenuPinnedFolderVideos                          = "notConfigured";
            StorageBlockRemovableStorage                         = $False;
            StorageRequireMobileDeviceEncryption                 = $False;
            StorageRestrictAppDataToSystemVolume                 = $False;
            StorageRestrictAppInstallToSystemVolume              = $False;
            SupportsScopeTags                                    = $True;
            TaskManagerBlockEndTask                              = $False;
            TenantLockdownRequireNetworkDuringOutOfBoxExperience = $False;
            UninstallBuiltInApps                                 = $False;
            UsbBlocked                                           = $False;
            VoiceRecordingBlocked                                = $False;
            WebRtcBlockLocalhostIpAddress                        = $False;
            WiFiBlockAutomaticConnectHotspots                    = $False;
            WiFiBlocked                                          = $True;
            WiFiBlockManualConfiguration                         = $True;
            WindowsSpotlightBlockConsumerSpecificFeatures        = $False;
            WindowsSpotlightBlocked                              = $False;
            WindowsSpotlightBlockOnActionCenter                  = $False;
            WindowsSpotlightBlockTailoredExperiences             = $False;
            WindowsSpotlightBlockThirdPartyNotifications         = $False;
            WindowsSpotlightBlockWelcomeExperience               = $False;
            WindowsSpotlightBlockWindowsTips                     = $False;
            WindowsSpotlightConfigureOnLockScreen                = "notConfigured";
            WindowsStoreBlockAutoUpdate                          = $False;
            WindowsStoreBlocked                                  = $False;
            WindowsStoreEnablePrivateStoreOnly                   = $False;
            WirelessDisplayBlockProjectionToThisDevice           = $False;
            WirelessDisplayBlockUserInputFromReceiver            = $False;
            WirelessDisplayRequirePinForPairing                  = $False;
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
        IntuneDeviceConfigurationPolicyWindows10 'Example'
        {
            DisplayName                                          = "device config";
            Ensure                                               = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

