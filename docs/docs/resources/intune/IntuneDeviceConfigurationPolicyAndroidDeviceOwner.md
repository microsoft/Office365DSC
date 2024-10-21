# IntuneDeviceConfigurationPolicyAndroidDeviceOwner

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | The Id of the policy. | |
| **DisplayName** | Key | String | The display name of hte policy. | |
| **Description** | Write | String | The description of the policy. | |
| **AccountsBlockModification** | Write | Boolean | Block modification of accounts. Only supported on Dedicated devices. | |
| **AppsAllowInstallFromUnknownSources** | Write | Boolean | When allowed, users can enable the 'unknown sources' setting to install apps from sources other than the Google Play Store. | |
| **AppsAutoUpdatePolicy** | Write | String | Devices check for app updates daily. The default behavior is to let device users decide. They'll be able to set their preferences in the managed Google Play app. | `notConfigured`, `userChoice`, `never`, `wiFiOnly`, `always` |
| **AppsDefaultPermissionPolicy** | Write | String | Define the default permission policy for requests for runtime permissions. | `deviceDefault`, `prompt`, `autoGrant`, `autoDeny` |
| **AppsRecommendSkippingFirstUseHints** | Write | Boolean | Enable a suggestion to apps that they skip their user tutorials and any introductory hints when they first start up, if applicable. | |
| **AzureAdSharedDeviceDataClearApps** | Write | MSFT_MicrosoftGraphapplistitem[] | A list of managed apps that will have their data cleared during a global sign-out in AAD shared device mode. This collection can contain a maximum of 500 elements. | |
| **BluetoothBlockConfiguration** | Write | Boolean | Block configuring Bluetooth. | |
| **BluetoothBlockContactSharing** | Write | Boolean | Block access to work contacts from another device such as a car system when an Android device is paired via Bluetooth. | |
| **CameraBlocked** | Write | Boolean | Block all cameras on the device | |
| **CellularBlockWiFiTethering** | Write | Boolean | Block tethering and access to portable hotspots. | |
| **CertificateCredentialConfigurationDisabled** | Write | Boolean | Blocks users from making any changes to credentials associated with certificates associated with certificates assigned to them. | |
| **CrossProfilePoliciesAllowCopyPaste** | Write | Boolean | Indicates whether or not text copied from one profile (personal or work) can be pasted in the other. | |
| **CrossProfilePoliciesAllowDataSharing** | Write | String | Indicates whether data from one profile (personal or work) can be shared with apps in the other profile. | `notConfigured`, `crossProfileDataSharingBlocked`, `dataSharingFromWorkToPersonalBlocked`, `crossProfileDataSharingAllowed`, `unkownFutureValue` |
| **CrossProfilePoliciesShowWorkContactsInPersonalProfile** | Write | Boolean | Indicates whether or not contacts stored in work profile are shown in personal profile contact searches/incoming calls. | |
| **DataRoamingBlocked** | Write | Boolean | Block data roaming. | |
| **DateTimeConfigurationBlocked** | Write | Boolean | Block user from manually setting the date and time. | |
| **DetailedHelpText** | Write | MSFT_MicrosoftGraphandroiddeviceowneruserfacingmessage | Represents the customized detailed help text provided to users when they attempt to modify managed settings on their device. | |
| **DeviceOwnerLockScreenMessage** | Write | MSFT_MicrosoftGraphandroiddeviceowneruserfacingmessage | Represents the customized lock screen message provided to users when they attempt to modify managed settings on their device. | |
| **EnrollmentProfile** | Write | String | Represents the enrollment profile type. | `notConfigured`, `dedicatedDevice`, `fullyManaged` |
| **FactoryResetBlocked** | Write | Boolean | Block factory resetting from settings. | |
| **FactoryResetDeviceAdministratorEmails** | Write | StringArray[] | Email addresses of device admins for factory reset protection. When a device is factory reset, it will require that one of these admins log in with their Google account to unlock the device. If none are specified, factory reset protection is not enabled. | |
| **GlobalProxy** | Write | MSFT_MicrosoftGraphandroiddeviceownerglobalproxy | Proxy is set up directly with host, port and excluded hosts. | |
| **GoogleAccountsBlocked** | Write | Boolean | Blocking prevents users from adding their personal Google account to their device. | |
| **KioskCustomizationDeviceSettingsBlocked** | Write | Boolean | Indicates whether a user can access the device's Settings app while in Kiosk Mode. | |
| **KioskCustomizationPowerButtonActionsBlocked** | Write | Boolean | Whether the power menu is shown when a user long presses the Power button of a device in Kiosk Mode. | |
| **KioskCustomizationStatusBar** | Write | String | Indicates whether system info and notifications are disabled in Kiosk Mode | `notConfigured`, `notificationsAndSystemInfoEnabled`, `systemInfoOnly` |
| **KioskCustomizationSystemErrorWarnings** | Write | Boolean | Indicates whether system error dialogs for crashed or unresponsive apps are shown in Kiosk Mode. | |
| **KioskCustomizationSystemNavigation** | Write | String | Indicates which navigation features are enabled in Kiosk Mode. | `notConfigured`, `navigationEnabled`, `homeButtonOnly` |
| **KioskModeAppOrderEnabled** | Write | Boolean | Whether or not to enable app ordering in Kiosk Mode. | |
| **KioskModeAppPositions** | Write | MSFT_MicrosoftGraphandroiddeviceownerkioskmodeapppositionitem[] | The ordering of items on Kiosk Mode Managed Home Screen. This collection can contain a maximum of 500 elements. | |
| **KioskModeApps** | Write | MSFT_MicrosoftGraphapplistitem[] | A list of managed apps that will be shown when the device is in Kiosk Mode. This collection can contain a maximum of 500 elements. | |
| **KioskModeAppsInFolderOrderedByName** | Write | Boolean | Whether or not to alphabetize applications within a folder in Kiosk Mode. | |
| **KioskModeBluetoothConfigurationEnabled** | Write | Boolean | Enable end-users to configure and pair devices over Bluetooth. | |
| **KioskModeDebugMenuEasyAccessEnabled** | Write | Boolean | Whether or not to allow a user to easy access to the debug menu in Kiosk Mode | |
| **KioskModeExitCode** | Write | String | The 4-6 digit PIN will be the code an IT administrator enters on a multi-app dedicated device to pause kiosk mode. | |
| **KioskModeFlashlightConfigurationEnabled** | Write | Boolean | Whether or not to allow a user to use the flashlight in Kiosk Mode. | |
| **KioskModeFolderIcon** | Write | String | Folder icon configuration for managed home screen in Kiosk Mode. | `notConfigured`, `darkSquare`, `darkCircle`, `lightSquare`, `lightCircle` |
| **KioskModeGridHeight** | Write | UInt32 | Number of rows for Managed Home Screen grid with app ordering enabled in Kiosk Mode. Valid values 1 to 9999999. | |
| **KioskModeGridWidth** | Write | UInt32 | Number of columns for Managed Home Screen grid with app ordering enabled in Kiosk Mode. Valid values 1 to 9999999. | |
| **KioskModeIconSize** | Write | String | Icon size configuration for managed home screen in Kiosk Mode. | `notConfigured`, `smallest`, `small`, `regular`, `large`, `largest` |
| **KioskModeLockHomeScreen** | Write | Boolean | Whether or not to lock home screen to the end user in Kiosk Mode. | |
| **KioskModeManagedFolders** | Write | MSFT_MicrosoftGraphandroiddeviceownerkioskmodemanagedfolder[] | A list of managed folders for a device in Kiosk Mode. This collection can contain a maximum of 500 elements. | |
| **KioskModeManagedHomeScreenAutoSignout** | Write | Boolean | Whether or not to automatically sign-out of MHS and Shared device mode applications after inactive for Managed Home Screen. | |
| **KioskModeManagedHomeScreenInactiveSignOutDelayInSeconds** | Write | UInt32 | Number of seconds to give user notice before automatically signing them out for Managed Home Screen. Valid values 0 to 9999999. | |
| **KioskModeManagedHomeScreenInactiveSignOutNoticeInSeconds** | Write | UInt32 | Number of seconds device is inactive before automatically signing user out for Managed Home Screen. Valid values 0 to 9999999. | |
| **KioskModeManagedHomeScreenPinComplexity** | Write | String | Complexity of PIN for sign-in session for Managed Home Screen. | `notConfigured`, `simple`, `complex` |
| **KioskModeManagedHomeScreenPinRequired** | Write | Boolean | Whether or not require user to set a PIN for sign-in session for Managed Home Screen. | |
| **KioskModeManagedHomeScreenPinRequiredToResume** | Write | Boolean | Whether or not required user to enter session PIN if screensaver has appeared for Managed Home Screen. | |
| **KioskModeManagedHomeScreenSignInBackground** | Write | String | Custom URL background for sign-in screen for Managed Home Screen. | |
| **KioskModeManagedHomeScreenSignInBrandingLogo** | Write | String | Custom URL branding logo for sign-in screen and session pin page for Managed Home Screen. | |
| **KioskModeManagedHomeScreenSignInEnabled** | Write | Boolean | Whether or not show sign-in screen for Managed Home Screen. | |
| **KioskModeManagedSettingsEntryDisabled** | Write | Boolean | Whether or not to use single app kiosk mode or multi-app kiosk mode. | |
| **KioskModeMediaVolumeConfigurationEnabled** | Write | Boolean | Whether or not to allow a user to change the media volume in Kiosk Mode. | |
| **KioskModeScreenOrientation** | Write | String | Screen orientation configuration for managed home screen in Kiosk Mode. | `notConfigured`, `portrait`, `landscape`, `autoRotate` |
| **KioskModeScreenSaverConfigurationEnabled** | Write | Boolean | Start screen saver when the device screen times out or locks. | |
| **KioskModeScreenSaverDetectMediaDisabled** | Write | Boolean | Whether or not the device screen should show the screen saver if audio/video is playing in Kiosk Mode. | |
| **KioskModeScreenSaverDisplayTimeInSeconds** | Write | UInt32 | The number of seconds that the device will display the screen saver for in Kiosk Mode. Valid values 0 to 9999999 | |
| **KioskModeScreenSaverImageUrl** | Write | String | URL for an image that will be the device's screen saver in Kiosk Mode. | |
| **KioskModeScreenSaverStartDelayInSeconds** | Write | UInt32 | The number of seconds the device needs to be inactive for before the screen saver is shown in Kiosk Mode. Valid values 1 to 9999999 | |
| **KioskModeShowAppNotificationBadge** | Write | Boolean | Whether or not to display application notification badges in Kiosk Mode. | |
| **KioskModeShowDeviceInfo** | Write | Boolean | Whether or not to allow a user to access basic device information. | |
| **KioskModeUseManagedHomeScreenApp** | Write | String | Whether or not to use single app kiosk mode or multi-app kiosk mode. | `notConfigured`, `singleAppMode`, `multiAppMode` |
| **KioskModeVirtualHomeButtonEnabled** | Write | Boolean | Enable IT administrators to temporarily leave multi-app kiosk mode to make changes on the device. | |
| **KioskModeVirtualHomeButtonType** | Write | String | Enable a soft-key button that returns users to the Managed Home Screen. Choose between a persistent, floating button or a button activated by a swipe-up gesture. | `notConfigured`, `swipeUp`, `floating` |
| **KioskModeWallpaperUrl** | Write | String | Customize the appearance of the screen background for assigned groups. | |
| **KioskModeWifiAllowedSsids** | Write | StringArray[] | The restricted set of WIFI SSIDs available for the user to configure in Kiosk Mode. This collection can contain a maximum of 500 elements. | |
| **KioskModeWiFiConfigurationEnabled** | Write | Boolean | Enable end-users to connect to different Wi-Fi networks. | |
| **MicrophoneForceMute** | Write | Boolean | Block unmuting the microphone and adjusting the microphone volume. | |
| **MicrosoftLauncherConfigurationEnabled** | Write | Boolean | Indicates whether or not to you want configure Microsoft Launcher. | |
| **MicrosoftLauncherCustomWallpaperAllowUserModification** | Write | Boolean | Indicates whether or not the user can modify the wallpaper to personalize their device. | |
| **MicrosoftLauncherCustomWallpaperEnabled** | Write | Boolean | Indicates whether or not to configure the wallpaper on the targeted devices. | |
| **MicrosoftLauncherCustomWallpaperImageUrl** | Write | String | Indicates the URL for the image file to use as the wallpaper on the targeted devices. | |
| **MicrosoftLauncherDockPresenceAllowUserModification** | Write | Boolean | Indicates whether or not the user can modify the device dock configuration on the device. | |
| **MicrosoftLauncherDockPresenceConfiguration** | Write | String | Indicates whether or not you want to configure the device dock.  | `notConfigured`, `show`, `hide`, `disabled` |
| **MicrosoftLauncherFeedAllowUserModification** | Write | Boolean | Indicates whether or not the user can modify the launcher feed on the device. | |
| **MicrosoftLauncherFeedEnabled** | Write | Boolean | Indicates whether or not the user can modify the launcher feed on the device. | |
| **MicrosoftLauncherSearchBarPlacementConfiguration** | Write | String | Indicates whether or not you want to configure the device dock. | `notConfigured`, `top`, `bottom`, `hide` |
| **NetworkEscapeHatchAllowed** | Write | Boolean | Whether the network escape hatch is enabled. If a network connection can't be made at boot time, the escape hatch prompts the user to temporarily connect to a network in order to refresh the device policy. After applying policy, the temporary network will be forgotten and the device will continue booting. This prevents being unable to connect to a network if there is no suitable network in the last policy and the device boots into an app in lock task mode, or the user is otherwise unable to reach device settings. | |
| **NfcBlockOutgoingBeam** | Write | Boolean | Block usage of NFC to beam data from apps. | |
| **PasswordBlockKeyguard** | Write | Boolean | Disable lock screen | |
| **PasswordBlockKeyguardFeatures** | Write | StringArray[] | These features are accessible to users when the device is locked. Users will not be able to see or access disabled features. | `notConfigured`, `camera`, `notifications`, `unredactedNotifications`, `trustAgents`, `fingerprint`, `remoteInput`, `allFeatures`, `face`, `iris`, `biometrics` |
| **PasswordExpirationDays** | Write | UInt32 | Number of days until device password must be changed. (1-365) | |
| **PasswordMinimumLength** | Write | UInt32 | Indicates the minimum length of the password required on the device. Valid values 4 to 16 | |
| **PasswordMinimumLetterCharacters** | Write | UInt32 | Indicates the minimum number of letter characters required for device password. Valid values 1 to 16 | |
| **PasswordMinimumLowerCaseCharacters** | Write | UInt32 | Indicates the minimum number of lower case characters required for device password. Valid values 1 to 16 | |
| **PasswordMinimumNonLetterCharacters** | Write | UInt32 | Indicates the minimum number of non-letter characters required for device password. Valid values 1 to 16 | |
| **PasswordMinimumNumericCharacters** | Write | UInt32 | Indicates the minimum number of numeric characters required for device password. Valid values 1 to 16 | |
| **PasswordMinimumSymbolCharacters** | Write | UInt32 | Indicates the minimum number of symbol characters required for device password. Valid values 1 to 16 | |
| **PasswordMinimumUpperCaseCharacters** | Write | UInt32 | Indicates the minimum number of upper case letter characters required for device password. Valid values 1 to 16 | |
| **PasswordMinutesOfInactivityBeforeScreenTimeout** | Write | UInt32 | Maximum time after which the device will lock. Can disable screen lock as well so that it never times out. | |
| **PasswordPreviousPasswordCountToBlock** | Write | UInt32 | Enter the number of unique passwords required before a user can reuse an old one. (1-24) | |
| **PasswordRequiredType** | Write | String | Set the password's complexity requirements. Additional password requirements will become available based on your selection. | `deviceDefault`, `required`, `numeric`, `numericComplex`, `alphabetic`, `alphanumeric`, `alphanumericWithSymbols`, `lowSecurityBiometric`, `customPassword` |
| **PasswordRequireUnlock** | Write | String | Indicates the timeout period after which a device must be unlocked using a form of strong authentication. | `deviceDefault`, `daily`, `unkownFutureValue` |
| **PasswordSignInFailureCountBeforeFactoryReset** | Write | UInt32 | Number of consecutive times an incorrect password can be entered before device is wiped of all data. (4-11) | |
| **PersonalProfileAppsAllowInstallFromUnknownSources** | Write | Boolean | Indicates whether the user can install apps from unknown sources on the personal profile. | |
| **PersonalProfileCameraBlocked** | Write | Boolean | Indicates whether to disable the use of the camera on the personal profile. | |
| **PersonalProfilePersonalApplications** | Write | MSFT_MicrosoftGraphapplistitem[] | Policy applied to applications in the personal profile. This collection can contain a maximum of 500 elements. | |
| **PersonalProfilePlayStoreMode** | Write | String | Used together with PersonalProfilePersonalApplications to control how apps in the personal profile are allowed or blocked | `notConfigured`, `blockedApps`, `allowedApps` |
| **PersonalProfileScreenCaptureBlocked** | Write | Boolean | Indicates whether to disable the capability to take screenshots on the personal profile. | |
| **PlayStoreMode** | Write | String | Users get access to all apps, except the ones you've required uninstall in Client Apps. If you choose 'Not configured' for this setting, users can only access the apps you've listed as available or required in Client Apps. | `notConfigured`, `allowList`, `blockList` |
| **ScreenCaptureBlocked** | Write | Boolean | Block screen capture | |
| **SecurityCommonCriteriaModeEnabled** | Write | Boolean | Represents the security common criteria mode enabled provided to users when they attempt to modify managed settings on their device. | |
| **SecurityDeveloperSettingsEnabled** | Write | Boolean | Indicates whether or not the user is allowed to access developer settings like developer options and safe boot on the device. | |
| **SecurityRequireVerifyApps** | Write | Boolean | Enable Google Play Protect to scan apps before and after they're installed. If it detects a threat, it might warn the user to remove the app from the device. Required by default. | |
| **ShortHelpText** | Write | MSFT_MicrosoftGraphandroiddeviceowneruserfacingmessage | Represents the customized short help text provided to users when they attempt to modify managed settings on their device. | |
| **StatusBarBlocked** | Write | Boolean | Block access to the status bar, including notifications and quick settings. | |
| **StayOnModes** | Write | StringArray[] | The battery plugged in modes for which the device stays on. When using this setting, it is recommended to clear the Time to lock screen setting so that the device doesn't lock itself while it stays on. | `notConfigured`, `ac`, `usb`, `wireless` |
| **StorageAllowUsb** | Write | Boolean | Allow USB storage. | |
| **StorageBlockExternalMedia** | Write | Boolean | Block mounting of external media. | |
| **StorageBlockUsbFileTransfer** | Write | Boolean | Block transfer of files over USB. | |
| **SystemUpdateFreezePeriods** | Write | MSFT_MicrosoftGraphandroiddeviceownersystemupdatefreezeperiod[] | Indicates the annually repeating time periods during which system updates are postponed. This collection can contain a maximum of 500 elements. | |
| **SystemUpdateInstallType** | Write | String | When over-the-air updates are available for this device, they will be installed based on this policy.? | `deviceDefault`, `postpone`, `windowed`, `automatic` |
| **SystemUpdateWindowEndMinutesAfterMidnight** | Write | UInt32 | End of the maintenance window in the device's time zone.? | |
| **SystemUpdateWindowStartMinutesAfterMidnight** | Write | UInt32 | Beginning of the maintenance window in the device's time zone.? | |
| **SystemWindowsBlocked** | Write | Boolean | Disable window notifications such as toasts, incoming calls, outgoing calls, system alerts, and system errors.? | |
| **UsersBlockAdd** | Write | Boolean | Blocks users from adding and signing in to personal accounts while on the device. | |
| **UsersBlockRemove** | Write | Boolean | Block removal of users. | |
| **VolumeBlockAdjustment** | Write | Boolean | Block changes to volume. | |
| **VpnAlwaysOnLockdownMode** | Write | Boolean | Enabling this forces all network traffic through the VPN tunnel. If a connection to the VPN can't be established, no network traffic will be allowed. | |
| **VpnAlwaysOnPackageIdentifier** | Write | String | Android app package name for app that will handle an always-on VPN connection. | |
| **WifiBlockEditConfigurations** | Write | Boolean | Block user creation or editing of any Wi-Fi configurations. | |
| **WifiBlockEditPolicyDefinedConfigurations** | Write | Boolean | Block changes to Wi-Fi configurations created by the device owner. Users can create their own Wi-Fi configurations. | |
| **WorkProfilePasswordExpirationDays** | Write | UInt32 | Indicates the number of days that a work profile password can be set before it expires and a new password will be required. Valid values 1 to 365 | |
| **WorkProfilePasswordMinimumLength** | Write | UInt32 | Indicates the minimum length of the work profile password. Valid values 4 to 16 | |
| **WorkProfilePasswordMinimumLetterCharacters** | Write | UInt32 | Indicates the minimum number of numeric characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordMinimumLowerCaseCharacters** | Write | UInt32 | Indicates the minimum number of non-letter characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordMinimumNonLetterCharacters** | Write | UInt32 | Indicates the minimum number of letter characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordMinimumNumericCharacters** | Write | UInt32 | Indicates the minimum number of lower-case characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordMinimumSymbolCharacters** | Write | UInt32 | Indicates the minimum number of upper-case letter characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordMinimumUpperCaseCharacters** | Write | UInt32 | Indicates the minimum number of symbol characters required for the work profile password. Valid values 1 to 16 | |
| **WorkProfilePasswordPreviousPasswordCountToBlock** | Write | UInt32 | Indicates the length of the work profile password history, where the user will not be able to enter a new password that is the same as any password in the history. Valid values 0 to 24 | |
| **WorkProfilePasswordRequiredType** | Write | String | Indicates the minimum password quality required on the work profile password. | `deviceDefault`, `required`, `numeric`, `numericComplex`, `alphabetic`, `alphanumeric`, `alphanumericWithSymbols`, `lowSecurityBiometric`, `customPassword` |
| **WorkProfilePasswordRequireUnlock** | Write | String | Indicates the timeout period after which a work profile must be unlocked using a form of strong authentication. | `deviceDefault`, `daily`, `unkownFutureValue` |
| **WorkProfilePasswordSignInFailureCountBeforeFactoryReset** | Write | UInt32 | Indicates the number of times a user can enter an incorrect work profile password before the device is wiped. Valid values 4 to 11 | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
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

### MSFT_MicrosoftGraphapplistitem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | odatatype of the item. | `#microsoft.graph.appleAppListItem` |
| **appId** | Write | String | Kiosk mode managed app id | |
| **appStoreUrl** | Write | String | Define the app store URL. | |
| **name** | Write | String | Define the name of the app. | |
| **publisher** | Write | String | Define the publisher of the app. | |

### MSFT_MicrosoftGraphandroiddeviceowneruserfacingmessage

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **defaultMessage** | Write | String | The default message displayed if the user's locale doesn't match with any of the localized messages. | |
| **localizedMessages** | Write | MSFT_MicrosoftGraphkeyvaluepair[] | The list of <locale, message> pairs. This collection can contain a maximum of 500 elements. | |

### MSFT_MicrosoftGraphkeyvaluepair

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Name of the message localizedMessages. | |
| **Value** | Write | String | Value of the message localizedMessages. | |

### MSFT_MicrosoftGraphandroiddeviceownerglobalproxy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | The type of the global proxy. | `#microsoft.graph.androidDeviceOwnerGlobalProxyAutoConfig`, `#microsoft.graph.androidDeviceOwnerGlobalProxyDirect` |
| **proxyAutoConfigURL** | Write | String | The proxy auto-config URL. | |
| **excludedHosts** | Write | StringArray[] | The excluded hosts. | |
| **host** | Write | String | The host name. | |
| **port** | Write | UInt32 | The port. | |

### MSFT_MicrosoftGraphandroiddeviceownerkioskmodeapppositionitem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **item** | Write | MSFT_MicrosoftGraphandroiddeviceownerkioskmodehomescreenitem | Item to be arranged. | |
| **position** | Write | UInt32 | Position of the item on the grid. Valid values 0 to 9999999. | |

### MSFT_MicrosoftGraphandroiddeviceownerkioskmodehomescreenitem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | Type of the item. | `#microsoft.graph.androidDeviceOwnerKioskModeApp`, `#microsoft.graph.androidDeviceOwnerKioskModeWeblink`, `#microsoft.graph.androidDeviceOwnerKioskModeManagedFolder` |
| **folderIdentifier** | Write | String | The folder identifier. | |
| **folderName** | Write | String | The folder name. | |
| **items** | Write | MSFT_MicrosoftGraphandroiddeviceownerkioskmodefolderitem[] | Item to be arranged. | |
| **className** | Write | String | The class name of the item. | |
| **package** | Write | String | The package of the item. | |
| **label** | Write | String | The label of the item. | |
| **link** | Write | String | The link of the item. | |

### MSFT_MicrosoftGraphandroiddeviceownerkioskmodemanagedfolder

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **folderIdentifier** | Write | String | The folder identifier. | |
| **folderName** | Write | String | The folder name. | |
| **items** | Write | MSFT_MicrosoftGraphandroiddeviceownerkioskmodefolderitem[] | Item to be arranged. | |

### MSFT_MicrosoftGraphandroiddeviceownerkioskmodefolderitem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | The type of the item. | `#microsoft.graph.androidDeviceOwnerKioskModeApp`, `#microsoft.graph.androidDeviceOwnerKioskModeWeblink` |
| **className** | Write | String | The class name of the item. | |
| **package** | Write | String | The package of the item. | |
| **label** | Write | String | The label of the item. | |
| **link** | Write | String | The link of the item. | |

### MSFT_MicrosoftGraphandroiddeviceownersystemupdatefreezeperiod

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **endDay** | Write | UInt32 | The day of the end date of the freeze period. Valid values 1 to 31. | |
| **endMonth** | Write | UInt32 | The month of the end date of the freeze period. Valid values 1 to 12. | |
| **startDay** | Write | UInt32 | The day of the start date of the freeze period. Valid values 1 to 31. | |
| **startMonth** | Write | UInt32 | The month of the start date of the freeze period. Valid values 1 to 12. | |


## Description

This resource configures an Intune Device Configuration Policy Android Device Owner.

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
        IntuneDeviceConfigurationPolicyAndroidDeviceOwner 'myAndroidDeviceOwnerPolicy'
        {
            DisplayName                           = 'general confi - AndroidDeviceOwner'
            Assignments                           = @()
            AzureAdSharedDeviceDataClearApps      = @()
            CameraBlocked                         = $True
            CrossProfilePoliciesAllowDataSharing  = 'notConfigured'
            EnrollmentProfile                     = 'notConfigured'
            FactoryResetDeviceAdministratorEmails = @()
            GlobalProxy                           = MSFT_MicrosoftGraphandroiddeviceownerglobalproxy {
                odataType = '#microsoft.graph.androidDeviceOwnerGlobalProxyDirect'
                host      = 'myproxy.com'
                port      = 8083
            }
            KioskCustomizationStatusBar           = 'notConfigured'
            KioskCustomizationSystemNavigation    = 'notConfigured'
            KioskModeAppPositions                 = @()
            KioskModeApps                         = @()
            KioskModeManagedFolders               = @()
            KioskModeUseManagedHomeScreenApp      = 'notConfigured'
            KioskModeWifiAllowedSsids             = @()
            MicrophoneForceMute                   = $True
            NfcBlockOutgoingBeam                  = $True
            PasswordBlockKeyguardFeatures         = @()
            PasswordRequiredType                  = 'deviceDefault'
            PasswordRequireUnlock                 = 'deviceDefault'
            PersonalProfilePersonalApplications   = @()
            PersonalProfilePlayStoreMode          = 'notConfigured'
            ScreenCaptureBlocked                  = $True
            SecurityRequireVerifyApps             = $True
            StayOnModes                           = @()
            StorageBlockExternalMedia             = $True
            SystemUpdateFreezePeriods             = @(
                MSFT_MicrosoftGraphandroiddeviceownersystemupdatefreezeperiod {
                    startMonth = 12
                    startDay   = 23
                    endMonth   = 12
                    endDay     = 30
                })
            VpnAlwaysOnLockdownMode               = $False
            VpnAlwaysOnPackageIdentifier          = ''
            WorkProfilePasswordRequiredType       = 'deviceDefault'
            WorkProfilePasswordRequireUnlock      = 'deviceDefault'
            Ensure                                = 'Present'
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
        IntuneDeviceConfigurationPolicyAndroidDeviceOwner 'myAndroidDeviceOwnerPolicy'
        {
            DisplayName                           = 'general confi - AndroidDeviceOwner'
            Assignments                           = @()
            AzureAdSharedDeviceDataClearApps      = @()
            CameraBlocked                         = $False # Updated Property
            CrossProfilePoliciesAllowDataSharing  = 'notConfigured'
            EnrollmentProfile                     = 'notConfigured'
            FactoryResetDeviceAdministratorEmails = @()
            GlobalProxy                           = MSFT_MicrosoftGraphandroiddeviceownerglobalproxy {
                odataType = '#microsoft.graph.androidDeviceOwnerGlobalProxyDirect'
                host      = 'myproxy.com'
                port      = 8083
            }
            KioskCustomizationStatusBar           = 'notConfigured'
            KioskCustomizationSystemNavigation    = 'notConfigured'
            KioskModeAppPositions                 = @()
            KioskModeApps                         = @()
            KioskModeManagedFolders               = @()
            KioskModeUseManagedHomeScreenApp      = 'notConfigured'
            KioskModeWifiAllowedSsids             = @()
            MicrophoneForceMute                   = $True
            NfcBlockOutgoingBeam                  = $True
            PasswordBlockKeyguardFeatures         = @()
            PasswordRequiredType                  = 'deviceDefault'
            PasswordRequireUnlock                 = 'deviceDefault'
            PersonalProfilePersonalApplications   = @()
            PersonalProfilePlayStoreMode          = 'notConfigured'
            ScreenCaptureBlocked                  = $True
            SecurityRequireVerifyApps             = $True
            StayOnModes                           = @()
            StorageBlockExternalMedia             = $True
            SystemUpdateFreezePeriods             = @(
                MSFT_MicrosoftGraphandroiddeviceownersystemupdatefreezeperiod {
                    startMonth = 12
                    startDay   = 23
                    endMonth   = 12
                    endDay     = 30
                })
            VpnAlwaysOnLockdownMode               = $False
            VpnAlwaysOnPackageIdentifier          = ''
            WorkProfilePasswordRequiredType       = 'deviceDefault'
            WorkProfilePasswordRequireUnlock      = 'deviceDefault'
            Ensure                                = 'Present'
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
        IntuneDeviceConfigurationPolicyAndroidDeviceOwner 'myAndroidDeviceOwnerPolicy'
        {
            DisplayName                           = 'general confi - AndroidDeviceOwner'
            Ensure                                = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

