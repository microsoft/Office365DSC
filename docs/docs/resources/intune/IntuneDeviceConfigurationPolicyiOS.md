# IntuneDeviceConfigurationPolicyIOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Description of the Intune policy. | |
| **AccountBlockModification** | Write | Boolean | Indicates whether or not to allow account modification when the device is in supervised mode. | |
| **ActivationLockAllowWhenSupervised** | Write | Boolean | Activation Lock makes it harder for a lost or stolen device to be reactivated. | |
| **AirDropBlocked** | Write | Boolean | Indicates whether or not to allow AirDrop when the device is in supervised mode. | |
| **AirDropForceUnmanagedDropTarget** | Write | Boolean | Force AirDrop to be considered an unmanaged drop target. | |
| **AirPlayForcePairingPasswordForOutgoingRequests** | Write | Boolean | Force requiring a pairing password for outgoing AirPlay requests. | |
| **AirPrintBlockCredentialsStorage** | Write | Boolean | Blocks keychain storage of username and password for outgoing AirPrint request. | |
| **AirPrintBlocked** | Write | Boolean | Blocks AirPrint request. | |
| **AirPrintBlockiBeaconDiscovery** | Write | Boolean | Blocking prevents malicious AirPrint Bluetooth beacons phishing for network traffic. | |
| **AirPrintForceTrustedTLS** | Write | Boolean | Forces trusted certificates for TLS printing communication | |
| **AppClipsBlocked** | Write | Boolean | Block app clips. | |
| **AppleNewsBlocked** | Write | Boolean | Block Apple News | |
| **ApplePersonalizedAdsBlocked** | Write | Boolean | Block Apple PersonalizedAdsBlocked | |
| **AppleWatchBlockPairing** | Write | Boolean | Indicates whether or not to allow Apple Watch pairing when the device is in supervised mode (iOS 9.0 and later). | |
| **AppleWatchForceWristDetection** | Write | Boolean | Force paired Apple watch to use wrist detection. | |
| **AppRemovalBlocked** | Write | Boolean | Block app removal. | |
| **AppsSingleAppModeList** | Write | MSFT_MicrosoftGraphapplistitem[] | Apps you add to this list and assign to a device can lock the device to run only that app once launched, or lock the device while a certain action is running (for example, taking a test). Once the action is complete, or you remove the restriction, the device returns to its normal state. | |
| **AppStoreBlockAutomaticDownloads** | Write | Boolean | Blocks automatic downloading of apps purchased on other devices. Does not affect updates to existing apps. | |
| **AppStoreBlocked** | Write | Boolean | For supervised devices as of iOS 13.0. | |
| **AppStoreBlockInAppPurchases** | Write | Boolean | Block AppStore in-app purchases. | |
| **AppStoreBlockUIAppInstallation** | Write | Boolean | Block App Store from Home Screen. Users may continue to use iTunes or Apple Configurator to install or update apps. | |
| **AppStoreRequirePassword** | Write | Boolean | Users must enter Apple ID password for each in-app and iTunes purchase. | |
| **AppsVisibilityList** | Write | MSFT_MicrosoftGraphapplistitem[] | Enter the iTunes App Store URL of the app you want. For example, to specify the Microsoft Work Folders app for iOS, enter https://itunes.apple.com/us/app/work-folders/id950878067?mt=8. To find the URL of an app, use a search engine to locate the store page. For example, to find the Work Folders app, you could search Microsoft Work Folders ITunes. | |
| **AppsVisibilityListType** | Write | String | Set whether the list is a list of apps to hide or a list of apps to make visible. | `none`, `appsInListCompliant`, `appsNotInListCompliant` |
| **AutoFillForceAuthentication** | Write | Boolean | Require Touch ID or Face ID before passwords or credit card information can be auto filled in Safari and Apps. Available with iOS 12.0 and later. | |
| **AutoUnlockBlocked** | Write | Boolean | Block auto unlock. | |
| **BlockSystemAppRemoval** | Write | Boolean | Blocking disables the ability to remove system apps from the device. | |
| **BluetoothBlockModification** | Write | Boolean | Block modification of Bluetooth settings. To use this setting, the device must be in supervised mode (iOS 10.0+). | |
| **CameraBlocked** | Write | Boolean | Indicates whether or not to block the user from accessing the camera of the device. Requires a supervised device for iOS 13 and later. | |
| **CellularBlockDataRoaming** | Write | Boolean | Block data roaming over the cellular network. This won't show in the device's management profile, but a block will be enforced for data roaming every time the device checks in (typically every 8 hours). | |
| **CellularBlockGlobalBackgroundFetchWhileRoaming** | Write | Boolean | Block global background fetch while roaming over the cellular network. | |
| **CellularBlockPerAppDataModification** | Write | Boolean | Block changes to app cellular data usage settings. | |
| **CellularBlockPersonalHotspot** | Write | Boolean | This value is available only with certain carriers. This won't show in the device's management profile, but a block will be enforced for personal hotspot every time the device checks in (typically every 8 hours). Block modification of personal hotspot in addition to this setting to ensure personal hotspot will always be blocked. | |
| **CellularBlockPersonalHotspotModification** | Write | Boolean | For devices running iOS 12.2 and later. Users can't turn Personal Hotspot on or off. If you block this setting and block Personal Hotspot, Personal Hotspot will be turned off. | |
| **CellularBlockPlanModification** | Write | Boolean | Indicates whether or not to allow users to change the settings of the cellular plan on a supervised device. | |
| **CellularBlockVoiceRoaming** | Write | Boolean | Block voice roaming over the cellular network. | |
| **CertificatesBlockUntrustedTlsCertificates** | Write | Boolean | Block untrusted Transport Layer Security (TLS) certificates. | |
| **ClassroomAppBlockRemoteScreenObservation** | Write | Boolean | Block remote screen observation by Classroom app. To use this setting, the device must be in supervised mode (iOS 9.3+). | |
| **ClassroomAppForceUnpromptedScreenObservation** | Write | Boolean | Student devices enrolled in a class via the Classroom app will automatically give permission to that course's teacher to silently observe the student's screen. | |
| **ClassroomForceAutomaticallyJoinClasses** | Write | Boolean | Students can join a class without prompting the teacher. | |
| **ClassroomForceRequestPermissionToLeaveClasses** | Write | Boolean | Requires a student enrolled in an unmanaged course via Classroom to request permission from the teacher when attempting to leave the course. Only available in iOS 11.3+ | |
| **ClassroomForceUnpromptedAppAndDeviceLock** | Write | Boolean | Teachers can lock an app open or lock the device without first prompting the user. | |
| **CompliantAppListType** | Write | String | Device compliance can be viewed in the Restricted Apps Compliance report. | `none`, `appsInListCompliant`, `appsNotInListCompliant` |
| **CompliantAppsList** | Write | MSFT_MicrosoftGraphapplistitem[] | Enter the iTunes App Store URL of the app you want. For example, to specify the Microsoft Work Folders app for iOS, enter https://itunes.apple.com/us/app/work-folders/id950878067?mt=8. To find the URL of an app, use a search engine to locate the store page. For example, to find the Work Folders app, you could search Microsoft Work Folders ITunes. | |
| **ConfigurationProfileBlockChanges** | Write | Boolean | Indicates whether or not to block the user from installing configuration profiles and certificates interactively when the device is in supervised mode. | |
| **ContactsAllowManagedToUnmanagedWrite** | Write | Boolean | Users can sync and add their managed contacts (including business and corporate ones) to an unmanaged app, such as the device's built-in contacts app. | |
| **ContactsAllowUnmanagedToManagedRead** | Write | Boolean | An unmanaged app, such as the device's built-in contacts app, can access contact info in a managed app, such as Outlook. | |
| **ContinuousPathKeyboardBlocked** | Write | Boolean | QuickPath enables continuous input on the device keyboard. Available for iOS/iPadOS 13.0 and later. | |
| **DateAndTimeForceSetAutomatically** | Write | Boolean | Forces device to Set Date & Time Automatically. The device's time zone will only be updated when the device has cellular connections or wifi with location services enabled. | |
| **DefinitionLookupBlocked** | Write | Boolean | Indicates whether or not to block definition lookup when the device is in supervised mode (iOS 8.1.3 and later ). | |
| **DeviceBlockEnableRestrictions** | Write | Boolean | On iOS 12.0 and later, this blocks users from setting their own Screen Time settings, which includes device restrictions. On iOS 11.4.1 and earlier, this blocks the user from enabling restrictions in the device settings. The blocking effect is the same on any supervised iOS device. | |
| **DeviceBlockEraseContentAndSettings** | Write | Boolean | Block the use of the erase all content and settings option on the device. | |
| **DeviceBlockNameModification** | Write | Boolean | Indicates whether or not to allow device name modification when the device is in supervised mode (iOS 9.0 and later). | |
| **DiagnosticDataBlockSubmission** | Write | Boolean | Block the device from sending diagnostic and usage telemetry data. | |
| **DiagnosticDataBlockSubmissionModification** | Write | Boolean | Block the modification of the diagnostic submission and app analytics settings in the Diagnostics and Usage pane in Settings. To use this setting, the device must be in supervised mode (iOS 9.3.2+). | |
| **DocumentsBlockManagedDocumentsInUnmanagedApps** | Write | Boolean | Indicates whether or not to block the user from viewing managed documents in unmanaged apps. | |
| **DocumentsBlockUnmanagedDocumentsInManagedApps** | Write | Boolean | Indicates whether or not to block the user from viewing unmanaged documents in managed apps. | |
| **EmailInDomainSuffixes** | Write | StringArray[] | Emails that the user sends or receives which don't match the domains you specify here will be marked as untrusted. | |
| **EnterpriseAppBlockTrust** | Write | Boolean | Removes the Trust Enterprise Developer button in Settings->General->Profiles & Device Management. | |
| **EnterpriseAppBlockTrustModification** | Write | Boolean | Block the changing of enterprise app trust settings. | |
| **EnterpriseBookBlockBackup** | Write | Boolean | Indicates whether or not to backup enterprise book. | |
| **EnterpriseBookBlockMetadataSync** | Write | Boolean | Indicates whether or not to sync enterprise book metadata. | |
| **EsimBlockModification** | Write | Boolean | Indicates whether or not to allow the addition or removal of cellular plans on the eSIM of a supervised device. | |
| **FaceTimeBlocked** | Write | Boolean | Indicates whether or not to block the user from using FaceTime. Requires a supervised device for iOS 13 and later. | |
| **FilesNetworkDriveAccessBlocked** | Write | Boolean | Using the Server Message Block (SMB) protocol, devices can access files or other resources on a network server. Available for devices running iOS and iPadOS, versions 13.0 and later. | |
| **FilesUsbDriveAccessBlocked** | Write | Boolean | Devices with access can connect to and open files on a USB drive. Available for devices running iOS and iPadOS, versions 13.0 and later. | |
| **FindMyDeviceInFindMyAppBlocked** | Write | Boolean | A Find My app feature. Available for iOS/iPadOS 13.0 and later. | |
| **FindMyFriendsBlocked** | Write | Boolean | Block changes to the Find My Friends app settings. | |
| **FindMyFriendsInFindMyAppBlocked** | Write | Boolean | A Find My app feature. Used to locate family and friends from an Apple device or iCloud.com. Available for iOS/iPadOS 13.0 and later. | |
| **GameCenterBlocked** | Write | Boolean | Indicates whether or not to block the user from using Game Center when the device is in supervised mode. | |
| **GamingBlockGameCenterFriends** | Write | Boolean | Block adding Game Center friends. For supervised devices as of iOS 13.0. | |
| **GamingBlockMultiplayer** | Write | Boolean | For supervised devices as of iOS 13.0. | |
| **HostPairingBlocked** | Write | Boolean | Host pairing allows you to control which devices the device can pair with. | |
| **IBooksStoreBlocked** | Write | Boolean | Indicates whether or not to block the user from using the iBooks Store when the device is in supervised mode. | |
| **IBooksStoreBlockErotica** | Write | Boolean | User will not be able to download media from the iBook store that has been tagged as erotica. | |
| **ICloudBlockActivityContinuation** | Write | Boolean | Handoff lets users start work on one iOS device, and continue it on another MacOS or iOS device. | |
| **ICloudBlockBackup** | Write | Boolean | Block backing up device to iCloud. | |
| **ICloudBlockDocumentSync** | Write | Boolean | Blocks iCloud from syncing documents and data. | |
| **ICloudBlockManagedAppsSync** | Write | Boolean | Block managed apps from syncing to cloud. | |
| **ICloudBlockPhotoLibrary** | Write | Boolean | Any photos not fully downloaded from iCloud Photo Library to device will be removed from local storage. | |
| **ICloudBlockPhotoStreamSync** | Write | Boolean | Block photo stream syncing to iCloud. | |
| **ICloudBlockSharedPhotoStream** | Write | Boolean | Block shared photo streaming. Blocking can cause data loss. | |
| **ICloudPrivateRelayBlocked** | Write | Boolean | Block iCloud private relay. | |
| **ICloudRequireEncryptedBackup** | Write | Boolean | Require encryption on device backup. | |
| **ITunesBlocked** | Write | Boolean | Block iTunes. | |
| **ITunesBlockExplicitContent** | Write | Boolean | Block explicit iTunes music, podcast, and news content from iTunes. For supervised devices as of 13.0. | |
| **ITunesBlockMusicService** | Write | Boolean | Block Music service. If true, Music app reverts to classic mode and Music service is disabled. | |
| **ITunesBlockRadio** | Write | Boolean | Indicates whether or not to block the user from using iTunes Radio when the device is in supervised mode (iOS 9.3 and later). | |
| **KeyboardBlockAutoCorrect** | Write | Boolean | Indicates whether or not to block keyboard auto-correction when the device is in supervised mode (iOS 8.1.3 and later). | |
| **KeyboardBlockDictation** | Write | Boolean | Indicates whether or not to block the user from using dictation input when the device is in supervised mode. | |
| **KeyboardBlockPredictive** | Write | Boolean | Indicates whether or not to block predictive keyboards when device is in supervised mode (iOS 8.1.3 and later). | |
| **KeyboardBlockShortcuts** | Write | Boolean | Indicates whether or not to block keyboard shortcuts when the device is in supervised mode (iOS 9.0 and later). | |
| **KeyboardBlockSpellCheck** | Write | Boolean | Indicates whether or not to block keyboard spell-checking when the device is in supervised mode (iOS 8.1.3 and later). | |
| **KeychainBlockCloudSync** | Write | Boolean | Disables syncing credentials stored in the Keychain to iCloud. | |
| **KioskModeAllowAssistiveSpeak** | Write | Boolean | Indicates whether or not to allow assistive speak while in kiosk mode. | |
| **KioskModeAllowAssistiveTouchSettings** | Write | Boolean | Users can turn AssistiveTouch on or off. | |
| **KioskModeAllowAutoLock** | Write | Boolean | Kiosk mode allow auto lock | |
| **KioskModeAllowColorInversionSettings** | Write | Boolean | Users can turn invert colors on or off. | |
| **KioskModeAllowRingerSwitch** | Write | Boolean | Kiosk mode allow ringer switch | |
| **KioskModeAllowScreenRotation** | Write | Boolean | Kiosk mode allow screen rotation | |
| **KioskModeAllowSleepButton** | Write | Boolean | Kiosk mode allow sleep button | |
| **KioskModeAllowTouchscreen** | Write | Boolean | Kiosk mode allow touchscreen | |
| **KioskModeAllowVoiceControlModification** | Write | Boolean | Indicates whether or not to allow the user to toggle voice control in kiosk mode. | |
| **KioskModeAllowVoiceOverSettings** | Write | Boolean | Users can turn VoiceOver on or off. | |
| **KioskModeAllowVolumeButtons** | Write | Boolean | Kiosk mode allow volume buttons | |
| **KioskModeAllowZoomSettings** | Write | Boolean | Users can turn zoom on or off. | |
| **KioskModeAppStoreUrl** | Write | String | URL of app for kiosk mode, e.g. https://itunes.apple.com/us/app/work-folders/id950878067?mt=8 | |
| **KioskModeAppType** | Write | String | Indicates type of app in kiosk mode. | `notConfigured`, `appStoreApp`, `managedApp`, `builtInApp` |
| **KioskModeBlockAutoLock** | Write | Boolean | Indicates whether or not to block the auto-lock while in Kiosk Mode. | |
| **KioskModeBlockRingerSwitch** | Write | Boolean | Indicates whether or not to block the ringer switch while in Kiosk Mode. | |
| **KioskModeBlockScreenRotation** | Write | Boolean | Indicates whether or not to block the screen rotation while in Kiosk Mode. | |
| **KioskModeBlockSleepButton** | Write | Boolean | Indicates whether or not to block the sleep button while in Kiosk Mode. | |
| **KioskModeBlockTouchscreen** | Write | Boolean | Indicates whether or not to block the touchscreen while in Kiosk Mode. | |
| **KioskModeBlockVolumeButtons** | Write | Boolean | Indicates whether or not to block the volume buttons while in Kiosk Mode. | |
| **KioskModeBuiltInAppId** | Write | String | To see a list of bundle IDs for common built-in iOS apps, see the Intune documentation. | |
| **KioskModeEnableVoiceControl** | Write | Boolean | Indicates whether or not to enable the voice control while in Kiosk Mode. | |
| **KioskModeManagedAppId** | Write | String | Add managed Intune apps from the Software Node. | |
| **KioskModeRequireAssistiveTouch** | Write | Boolean | Indicates whether or not to enforce assistive touch while in Kiosk Mode. | |
| **KioskModeRequireColorInversion** | Write | Boolean | Indicates whether or not to enforce color inversion while in Kiosk Mode. | |
| **KioskModeRequireMonoAudio** | Write | Boolean | Indicates whether or not to enforce mono audio while in Kiosk Mode. | |
| **KioskModeRequireVoiceOver** | Write | Boolean | Indicates whether or not to enforce voice control while in Kiosk Mode. | |
| **KioskModeRequireZoom** | Write | Boolean | Indicates whether or not to enforce zoom while in Kiosk Mode. | |
| **LockScreenBlockControlCenter** | Write | Boolean | Indicates whether or not to block the user from using control center on the lock screen. | |
| **LockScreenBlockNotificationView** | Write | Boolean | Indicates whether or not to block the user from using the notification view on the lock screen. | |
| **LockScreenBlockPassbook** | Write | Boolean | Indicates whether or not to block the user from using passbook when the device is locked. | |
| **LockScreenBlockTodayView** | Write | Boolean | Indicates whether or not to block the user from using the Today View on the lock screen. | |
| **ManagedPasteboardRequired** | Write | Boolean | Indicates whether or not to enforce managed pasteboard. | |
| **MediaContentRatingApps** | Write | String | Media content rating settings for apps. | `allAllowed`, `allBlocked`, `agesAbove4`, `agesAbove9`, `agesAbove12`, `agesAbove17` |
| **MediaContentRatingAustralia** | Write | MSFT_MicrosoftGraphmediacontentratingaustralia | Media content rating settings for Australia | |
| **MediaContentRatingCanada** | Write | MSFT_MicrosoftGraphmediacontentratingcanada | Media content rating settings for Canada | |
| **MediaContentRatingFrance** | Write | MSFT_MicrosoftGraphmediacontentratingfrance | Media content rating settings for France | |
| **MediaContentRatingGermany** | Write | MSFT_MicrosoftGraphmediacontentratinggermany | Media content rating settings for Germany | |
| **MediaContentRatingIreland** | Write | MSFT_MicrosoftGraphmediacontentratingireland | Media content rating settings for Ireland | |
| **MediaContentRatingJapan** | Write | MSFT_MicrosoftGraphmediacontentratingjapan | Media content rating settings for Japan | |
| **MediaContentRatingNewZealand** | Write | MSFT_MicrosoftGraphmediacontentratingnewzealand | Media content rating settings for New Zealand | |
| **MediaContentRatingUnitedKingdom** | Write | MSFT_MicrosoftGraphmediacontentratingunitedkingdom | Media content rating settings for United Kingdom | |
| **MediaContentRatingUnitedStates** | Write | MSFT_MicrosoftGraphmediacontentratingunitedstates | Media content rating settings for United States | |
| **MessagesBlocked** | Write | Boolean | Indicates whether or not to block the user from using the Messages app on the supervised device. | |
| **NetworkUsageRules** | Write | MSFT_MicrosoftGraphiosnetworkusagerule[] | If you don't add any managed apps, the configured settings will apply to all managed apps by default. If you add specific managed apps, the configured settings will apply to only those apps. | |
| **NfcBlocked** | Write | Boolean | Indicates whether or not to block the user from using nfc on the supervised device. | |
| **NotificationsBlockSettingsModification** | Write | Boolean | Indicates whether or not to allow notifications settings modification (iOS 9.3 and later). | |
| **OnDeviceOnlyDictationForced** | Write | Boolean | Indicates whether or not to enforce on device only dictation. | |
| **OnDeviceOnlyTranslationForced** | Write | Boolean | Indicates whether or not to enforce on device only translation. | |
| **PasscodeBlockFingerprintModification** | Write | Boolean | Block users from adding, changing, or removing fingerprints and faces. Face ID is avaliable in iOS 11.0 and later. | |
| **PasscodeBlockFingerprintUnlock** | Write | Boolean | Face ID is avaliable on iOS 11.0 and later. | |
| **PasscodeBlockModification** | Write | Boolean | Block passcode from being added, changed or removed. Changes to passcode restrictions will be ignored on supervised devices after blocking passcode modification. | |
| **PasscodeBlockSimple** | Write | Boolean | Block simple password sequences, such as 1234 or 1111. | |
| **PasscodeExpirationDays** | Write | UInt32 | Number of days until device password must be changed. (1-65535) | |
| **PasscodeMinimumCharacterSetCount** | Write | UInt32 | Minimum number (0-4) of non-alphanumeric characters, such as #, %, !, etc., required in the password. The default value is 0. | |
| **PasscodeMinimumLength** | Write | UInt32 | Minimum number of digits or characters in password. (4-14) | |
| **PasscodeMinutesOfInactivityBeforeLock** | Write | UInt32 | Set to 0 to require a password immediately. There is no maximum number of minutes, and this number overrides the number currently set on the device. (This compliance check is supported for devices with OS versions iOS 8.0 and above) | |
| **PasscodeMinutesOfInactivityBeforeScreenTimeout** | Write | UInt32 | Set to 0 to use the device's minimum possible value. This number (0-60) overrides the number currently set on the device. If set to Immediately, devices will use the minimum possible value per device. | |
| **PasscodePreviousPasscodeBlockCount** | Write | UInt32 | Number of new passwords that must be used until an old one can be reused. (1-24) | |
| **PasscodeRequired** | Write | Boolean | In addition to requiring a password on all devices, this setting enforces a non-simple, 6-digit password requirement (regardless of other password settings you configure) on devices that are enrolled with Apple user enrollment. | |
| **PasscodeRequiredType** | Write | String | Type of passcode that is required. | `deviceDefault`, `alphanumeric`, `numeric` |
| **PasscodeSignInFailureCountBeforeWipe** | Write | UInt32 | Number of consecutive times an incorrect password can be entered before device is wiped of all data. (2-11) | |
| **PasswordBlockAirDropSharing** | Write | Boolean | Indicates whether or not to block AirDrop password sharing | |
| **PasswordBlockAutoFill** | Write | Boolean | Indicates whether or not to block password autofill. | |
| **PasswordBlockProximityRequests** | Write | Boolean | Indicates whether or not to block password proximity requests. | |
| **PkiBlockOTAUpdates** | Write | Boolean | Allows your users to receive software updates without connecting their devices to a computer | |
| **PodcastsBlocked** | Write | Boolean | Indicates whether or not to block podcasts. | |
| **PrivacyForceLimitAdTracking** | Write | Boolean | Disables device advertising identifier | |
| **ProximityBlockSetupToNewDevice** | Write | Boolean | Block user's from using their Apple devices to set up and configure other Apple devices. | |
| **SafariBlockAutofill** | Write | Boolean | Indicates whether or not to block Safari autofill. | |
| **SafariBlocked** | Write | Boolean | Indicates whether or not to block Safari. For supervised devices as of iOS 13.0. | |
| **SafariBlockJavaScript** | Write | Boolean | Indicates whether or not to block javascript in Safari. | |
| **SafariBlockPopups** | Write | Boolean | Indicates whether or not to block popups on Safari. | |
| **SafariCookieSettings** | Write | String | Cookie settings for Safari. | `browserDefault`, `blockAlways`, `allowCurrentWebSite`, `allowFromWebsitesVisited`, `allowAlways` |
| **SafariManagedDomains** | Write | StringArray[] | Documents downloaded from the URLs you specify here will be considered managed (Safari only). | |
| **SafariPasswordAutoFillDomains** | Write | StringArray[] | Users can save passwords in Safari only from URLs matching the patterns you specify here. To use this setting, the device must be in supervised mode and not configured for multiple users. (iOS 9.3+) | |
| **SafariRequireFraudWarning** | Write | Boolean | Indicates whether or not to require fraud warning in Safari. | |
| **ScreenCaptureBlocked** | Write | Boolean | Indicates whether or not to block the user from taking Screenshots | |
| **SharedDeviceBlockTemporarySessions** | Write | Boolean | Indicates whether or not to block temporary sessions on shared devices. | |
| **SiriBlocked** | Write | Boolean | Indicates whether or not to block Siri. | |
| **SiriBlockedWhenLocked** | Write | Boolean | Indicates whether or not to block Siri when locked. | |
| **SiriBlockUserGeneratedContent** | Write | Boolean | Block Siri from querying user-generated content from the internet. | |
| **SiriRequireProfanityFilter** | Write | Boolean | Prevents Siri from dictating, or speaking profane language. | |
| **SoftwareUpdatesEnforcedDelayInDays** | Write | UInt32 | Delay the user's software update for this many days. The maximum is 90 days. (1-90) | |
| **SoftwareUpdatesForceDelayed** | Write | Boolean | Delay user visibility of Software Updates. This does not impact any scheduled updates. It represents days before software updates are visible to end users after release. | |
| **SpotlightBlockInternetResults** | Write | Boolean | Blocks Spotlight from returning any results from an Internet search. | |
| **UnpairedExternalBootToRecoveryAllowed** | Write | Boolean | Allow users to boot devices into recovery mode with unpaired devices. Available for devices running iOS and iPadOS versions 14.5 and later. | |
| **UsbRestrictedModeBlocked** | Write | Boolean | Blocks USB Restricted mode. USB Restricted mode blocks USB accessories from exchanging data with a device that has been locked over an hour. | |
| **VoiceDialingBlocked** | Write | Boolean | Indicates whether or not to block voice dialing. | |
| **VpnBlockCreation** | Write | Boolean | Blocks the creation of VPN configurations | |
| **WallpaperBlockModification** | Write | Boolean | Block wallpaper from being changed. | |
| **WiFiConnectOnlyToConfiguredNetworks** | Write | Boolean | Force the device to use only Wi-Fi networks set up through configuration profiles. | |
| **WiFiConnectToAllowedNetworksOnlyForced** | Write | Boolean | Require devices to use Wi-Fi networks set up via configuration profiles. Available for devices running iOS and iPadOS versions 14.5 and later. | |
| **WifiPowerOnForced** | Write | Boolean | Wi-Fi can't be turned off in the Settings app or in the Control Center, even when the device is in airplane mode. Available for iOS/iPadOS 13.0 and later. | |
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

### MSFT_MicrosoftGraphmediacontentratingaustralia

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for Australia | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `mature`, `agesAbove15`, `agesAbove18` |
| **tvRating** | Write | String | TV rating selected for Australia | `allAllowed`, `allBlocked`, `preschoolers`, `children`, `general`, `parentalGuidance`, `mature`, `agesAbove15`, `agesAbove15AdultViolence` |

### MSFT_MicrosoftGraphmediacontentratingcanada

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for Canada | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `agesAbove14`, `agesAbove18`, `restricted` |
| **tvRating** | Write | String | TV rating selected for Canada | `allAllowed`, `allBlocked`, `children`, `childrenAbove8`, `general`, `parentalGuidance`, `agesAbove14`, `agesAbove18` |

### MSFT_MicrosoftGraphmediacontentratingfrance

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for France | `allAllowed`, `allBlocked`, `agesAbove10`, `agesAbove12`, `agesAbove16`, `agesAbove18` |
| **tvRating** | Write | String | TV rating selected for France | `allAllowed`, `allBlocked`, `agesAbove10`, `agesAbove12`, `agesAbove16`, `agesAbove18` |

### MSFT_MicrosoftGraphmediacontentratinggermany

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for Germany | `allAllowed`, `allBlocked`, `general`, `agesAbove6`, `agesAbove12`, `agesAbove16`, `adults` |
| **tvRating** | Write | String | TV rating selected for Germany | `allAllowed`, `allBlocked`, `general`, `agesAbove6`, `agesAbove12`, `agesAbove16`, `adults` |

### MSFT_MicrosoftGraphmediacontentratingireland

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for Ireland | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `agesAbove12`, `agesAbove15`, `agesAbove16`, `adults` |
| **tvRating** | Write | String | TV rating selected for Ireland | `allAllowed`, `allBlocked`, `general`, `children`, `youngAdults`, `parentalSupervision`, `mature` |

### MSFT_MicrosoftGraphmediacontentratingjapan

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for Japan | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `agesAbove15`, `agesAbove18` |
| **tvRating** | Write | String | TV rating selected for Japan | `allAllowed`, `allBlocked`, `explicitAllowed` |

### MSFT_MicrosoftGraphmediacontentratingnewzealand

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for New Zealand | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `mature`, `agesAbove13`, `agesAbove15`, `agesAbove16`, `agesAbove18`, `restricted`, `agesAbove16Restricted` |
| **tvRating** | Write | String | TV rating selected for New Zealand | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `adults` |

### MSFT_MicrosoftGraphmediacontentratingunitedkingdom

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for UK | `allAllowed`, `allBlocked`, `general`, `universalChildren`, `parentalGuidance`, `agesAbove12Video`, `agesAbove12Cinema`, `agesAbove15`, `adults` |
| **tvRating** | Write | String | TV rating selected for UK | `allAllowed`, `allBlocked`, `caution` |

### MSFT_MicrosoftGraphmediacontentratingunitedstates

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **movieRating** | Write | String | Movies rating selected for USA | `allAllowed`, `allBlocked`, `general`, `parentalGuidance`, `parentalGuidance13`, `restricted`, `adults` |
| **tvRating** | Write | String | TV rating selected for USA | `allAllowed`, `allBlocked`, `childrenAll`, `childrenAbove7`, `general`, `parentalGuidance`, `childrenAbove14`, `adults` |

### MSFT_MicrosoftGraphiosnetworkusagerule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **cellularDataBlocked** | Write | Boolean | If set to true, corresponding managed apps will not be allowed to use cellular data at any time. | |
| **cellularDataBlockWhenRoaming** | Write | Boolean | If set to true, corresponding managed apps will not be allowed to use cellular data when roaming. | |
| **managedApps** | Write | MSFT_MicrosoftGraphapplistitem[] | Information about the managed apps that this rule is going to apply to. | |


## Description

This resource configures an Intune Device Configuration Policy for iOS.

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

This example creates a new Device Configuration Policy for iOS.

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
        IntuneDeviceConfigurationPolicyiOS 'ConfigureDeviceConfigurationPolicyiOS'
        {
            DisplayName                                    = 'iOS DSC Policy'
            AccountBlockModification                       = $False
            ActivationLockAllowWhenSupervised              = $False
            AirDropBlocked                                 = $False
            AirDropForceUnmanagedDropTarget                = $False
            AirPlayForcePairingPasswordForOutgoingRequests = $False
            AppleNewsBlocked                               = $False
            AppleWatchBlockPairing                         = $False
            AppleWatchForceWristDetection                  = $False
            AppStoreBlockAutomaticDownloads                = $False
            AppStoreBlocked                                = $False
            AppStoreBlockInAppPurchases                    = $False
            AppStoreBlockUIAppInstallation                 = $False
            AppStoreRequirePassword                        = $False
            AppsVisibilityList                             = @()
            AppsVisibilityListType                         = 'none'
            BluetoothBlockModification                     = $True
            CameraBlocked                                  = $False
            CellularBlockDataRoaming                       = $False
            CellularBlockGlobalBackgroundFetchWhileRoaming = $False
            CellularBlockPerAppDataModification            = $False
            CellularBlockVoiceRoaming                      = $False
            CertificatesBlockUntrustedTlsCertificates      = $False
            ClassroomAppBlockRemoteScreenObservation       = $False
            CompliantAppListType                           = 'none'
            CompliantAppsList                              = @()
            ConfigurationProfileBlockChanges               = $False
            DefinitionLookupBlocked                        = $False
            Description                                    = 'iOS Device Restriction Policy'
            DeviceBlockEnableRestrictions                  = $True
            DeviceBlockEraseContentAndSettings             = $False
            DeviceBlockNameModification                    = $False
            DiagnosticDataBlockSubmission                  = $False
            DiagnosticDataBlockSubmissionModification      = $False
            DocumentsBlockManagedDocumentsInUnmanagedApps  = $False
            DocumentsBlockUnmanagedDocumentsInManagedApps  = $False
            EmailInDomainSuffixes                          = @()
            EnterpriseAppBlockTrust                        = $False
            EnterpriseAppBlockTrustModification            = $False
            FaceTimeBlocked                                = $False
            FindMyFriendsBlocked                           = $False
            GameCenterBlocked                              = $False
            GamingBlockGameCenterFriends                   = $True
            GamingBlockMultiplayer                         = $False
            HostPairingBlocked                             = $False
            iBooksStoreBlocked                             = $False
            iBooksStoreBlockErotica                        = $False
            iCloudBlockActivityContinuation                = $False
            iCloudBlockBackup                              = $True
            iCloudBlockDocumentSync                        = $True
            iCloudBlockManagedAppsSync                     = $False
            iCloudBlockPhotoLibrary                        = $False
            iCloudBlockPhotoStreamSync                     = $True
            iCloudBlockSharedPhotoStream                   = $False
            iCloudRequireEncryptedBackup                   = $False
            iTunesBlockExplicitContent                     = $False
            iTunesBlockMusicService                        = $False
            iTunesBlockRadio                               = $False
            KeyboardBlockAutoCorrect                       = $False
            KeyboardBlockPredictive                        = $False
            KeyboardBlockShortcuts                         = $False
            KeyboardBlockSpellCheck                        = $False
            KioskModeAllowAssistiveSpeak                   = $False
            KioskModeAllowAssistiveTouchSettings           = $False
            KioskModeAllowAutoLock                         = $False
            KioskModeAllowColorInversionSettings           = $False
            KioskModeAllowRingerSwitch                     = $False
            KioskModeAllowScreenRotation                   = $False
            KioskModeAllowSleepButton                      = $False
            KioskModeAllowTouchscreen                      = $False
            KioskModeAllowVoiceOverSettings                = $False
            KioskModeAllowVolumeButtons                    = $False
            KioskModeAllowZoomSettings                     = $False
            KioskModeRequireAssistiveTouch                 = $False
            KioskModeRequireColorInversion                 = $False
            KioskModeRequireMonoAudio                      = $False
            KioskModeRequireVoiceOver                      = $False
            KioskModeRequireZoom                           = $False
            LockScreenBlockControlCenter                   = $False
            LockScreenBlockNotificationView                = $False
            LockScreenBlockPassbook                        = $False
            LockScreenBlockTodayView                       = $False
            MediaContentRatingApps                         = 'allAllowed'
            messagesBlocked                                = $False
            NotificationsBlockSettingsModification         = $False
            PasscodeBlockFingerprintUnlock                 = $False
            PasscodeBlockModification                      = $False
            PasscodeBlockSimple                            = $True
            PasscodeMinimumLength                          = 4
            PasscodeRequired                               = $True
            PasscodeRequiredType                           = 'deviceDefault'
            PodcastsBlocked                                = $False
            SafariBlockAutofill                            = $False
            SafariBlocked                                  = $False
            SafariBlockJavaScript                          = $False
            SafariBlockPopups                              = $False
            SafariCookieSettings                           = 'browserDefault'
            SafariManagedDomains                           = @()
            SafariPasswordAutoFillDomains                  = @()
            SafariRequireFraudWarning                      = $False
            ScreenCaptureBlocked                           = $False
            SiriBlocked                                    = $False
            SiriBlockedWhenLocked                          = $False
            SiriBlockUserGeneratedContent                  = $False
            SiriRequireProfanityFilter                     = $False
            SpotlightBlockInternetResults                  = $False
            VoiceDialingBlocked                            = $False
            WallpaperBlockModification                     = $False
            Ensure                                         = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Configuration Policy for iOS.

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
        IntuneDeviceConfigurationPolicyiOS 'ConfigureDeviceConfigurationPolicyiOS'
        {
            DisplayName                                    = 'iOS DSC Policy'
            AccountBlockModification                       = $False
            ActivationLockAllowWhenSupervised              = $False
            AirDropBlocked                                 = $True # Updated Property
            AirDropForceUnmanagedDropTarget                = $False
            AirPlayForcePairingPasswordForOutgoingRequests = $False
            AppleNewsBlocked                               = $False
            AppleWatchBlockPairing                         = $False
            AppleWatchForceWristDetection                  = $False
            AppStoreBlockAutomaticDownloads                = $False
            AppStoreBlocked                                = $False
            AppStoreBlockInAppPurchases                    = $False
            AppStoreBlockUIAppInstallation                 = $False
            AppStoreRequirePassword                        = $False
            AppsVisibilityList                             = @()
            AppsVisibilityListType                         = 'none'
            BluetoothBlockModification                     = $True
            CameraBlocked                                  = $False
            CellularBlockDataRoaming                       = $False
            CellularBlockGlobalBackgroundFetchWhileRoaming = $False
            CellularBlockPerAppDataModification            = $False
            CellularBlockVoiceRoaming                      = $False
            CertificatesBlockUntrustedTlsCertificates      = $False
            ClassroomAppBlockRemoteScreenObservation       = $False
            CompliantAppListType                           = 'none'
            CompliantAppsList                              = @()
            ConfigurationProfileBlockChanges               = $False
            DefinitionLookupBlocked                        = $False
            Description                                    = 'iOS Device Restriction Policy'
            DeviceBlockEnableRestrictions                  = $True
            DeviceBlockEraseContentAndSettings             = $False
            DeviceBlockNameModification                    = $False
            DiagnosticDataBlockSubmission                  = $False
            DiagnosticDataBlockSubmissionModification      = $False
            DocumentsBlockManagedDocumentsInUnmanagedApps  = $False
            DocumentsBlockUnmanagedDocumentsInManagedApps  = $False
            EmailInDomainSuffixes                          = @()
            EnterpriseAppBlockTrust                        = $False
            EnterpriseAppBlockTrustModification            = $False
            FaceTimeBlocked                                = $False
            FindMyFriendsBlocked                           = $False
            GameCenterBlocked                              = $False
            GamingBlockGameCenterFriends                   = $True
            GamingBlockMultiplayer                         = $False
            HostPairingBlocked                             = $False
            iBooksStoreBlocked                             = $False
            iBooksStoreBlockErotica                        = $False
            iCloudBlockActivityContinuation                = $False
            iCloudBlockBackup                              = $True
            iCloudBlockDocumentSync                        = $True
            iCloudBlockManagedAppsSync                     = $False
            iCloudBlockPhotoLibrary                        = $False
            iCloudBlockPhotoStreamSync                     = $True
            iCloudBlockSharedPhotoStream                   = $False
            iCloudRequireEncryptedBackup                   = $False
            iTunesBlockExplicitContent                     = $False
            iTunesBlockMusicService                        = $False
            iTunesBlockRadio                               = $False
            KeyboardBlockAutoCorrect                       = $False
            KeyboardBlockPredictive                        = $False
            KeyboardBlockShortcuts                         = $False
            KeyboardBlockSpellCheck                        = $False
            KioskModeAllowAssistiveSpeak                   = $False
            KioskModeAllowAssistiveTouchSettings           = $False
            KioskModeAllowAutoLock                         = $False
            KioskModeAllowColorInversionSettings           = $False
            KioskModeAllowRingerSwitch                     = $False
            KioskModeAllowScreenRotation                   = $False
            KioskModeAllowSleepButton                      = $False
            KioskModeAllowTouchscreen                      = $False
            KioskModeAllowVoiceOverSettings                = $False
            KioskModeAllowVolumeButtons                    = $False
            KioskModeAllowZoomSettings                     = $False
            KioskModeRequireAssistiveTouch                 = $False
            KioskModeRequireColorInversion                 = $False
            KioskModeRequireMonoAudio                      = $False
            KioskModeRequireVoiceOver                      = $False
            KioskModeRequireZoom                           = $False
            LockScreenBlockControlCenter                   = $False
            LockScreenBlockNotificationView                = $False
            LockScreenBlockPassbook                        = $False
            LockScreenBlockTodayView                       = $False
            MediaContentRatingApps                         = 'allAllowed'
            messagesBlocked                                = $False
            NotificationsBlockSettingsModification         = $False
            PasscodeBlockFingerprintUnlock                 = $False
            PasscodeBlockModification                      = $False
            PasscodeBlockSimple                            = $True
            PasscodeMinimumLength                          = 4
            PasscodeRequired                               = $True
            PasscodeRequiredType                           = 'deviceDefault'
            PodcastsBlocked                                = $False
            SafariBlockAutofill                            = $False
            SafariBlocked                                  = $False
            SafariBlockJavaScript                          = $False
            SafariBlockPopups                              = $False
            SafariCookieSettings                           = 'browserDefault'
            SafariManagedDomains                           = @()
            SafariPasswordAutoFillDomains                  = @()
            SafariRequireFraudWarning                      = $False
            ScreenCaptureBlocked                           = $False
            SiriBlocked                                    = $False
            SiriBlockedWhenLocked                          = $False
            SiriBlockUserGeneratedContent                  = $False
            SiriRequireProfanityFilter                     = $False
            SpotlightBlockInternetResults                  = $False
            VoiceDialingBlocked                            = $False
            WallpaperBlockModification                     = $False
            Ensure                                         = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Configuration Policy for iOS.

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
        IntuneDeviceConfigurationPolicyiOS 'ConfigureDeviceConfigurationPolicyiOS'
        {
            DisplayName                                    = 'iOS DSC Policy'
            Ensure                                         = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

