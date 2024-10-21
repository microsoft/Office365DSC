# IntuneDeviceConfigurationPolicyMacOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Description of the Intune policy. | |
| **AddingGameCenterFriendsBlocked** | Write | Boolean | Configures users from adding friends to Game Center. Available for devices running macOS versions 10.13 and later. | |
| **AirDropBlocked** | Write | Boolean | Configures whether or not to allow AirDrop. | |
| **AppleWatchBlockAutoUnlock** | Write | Boolean | Blocks users from unlocking their Mac with Apple Watch. | |
| **CameraBlocked** | Write | Boolean | Blocks users from taking photographs and videos. | |
| **ClassroomAppBlockRemoteScreenObservation** | Write | Boolean | Blocks AirPlay, screen sharing to other devices, and a Classroom app feature used by teachers to view their students' screens. This setting isn't available if you've blocked screenshots. | |
| **ClassroomAppForceUnpromptedScreenObservation** | Write | Boolean | Unprompted observation means that teachers can view screens without warning students first. This setting isn't available if you've blocked screenshots. | |
| **ClassroomForceAutomaticallyJoinClasses** | Write | Boolean | Students can join a class without prompting the teacher. | |
| **ClassroomForceRequestPermissionToLeaveClasses** | Write | Boolean | Students enrolled in an unmanaged Classroom course must get teacher consent to leave the course. | |
| **ClassroomForceUnpromptedAppAndDeviceLock** | Write | Boolean | Teachers can lock a student's device or app without the student's approval. | |
| **CompliantAppListType** | Write | String | Device compliance can be viewed in the Restricted Apps Compliance report. | `none`, `appsInListCompliant`, `appsNotInListCompliant` |
| **CompliantAppsList** | Write | MSFT_MicrosoftGraphapplistitemMacOS[] | List of apps in the compliance (either allow list or block list, controlled by CompliantAppListType). | |
| **ContentCachingBlocked** | Write | Boolean | Configures whether or not to allow content caching. | |
| **DefinitionLookupBlocked** | Write | Boolean | Block look up, a feature that looks up the definition of a highlighted word. | |
| **EmailInDomainSuffixes** | Write | StringArray[] | Emails that the user sends or receives which don't match the domains you specify here will be marked as untrusted.  | |
| **EraseContentAndSettingsBlocked** | Write | Boolean | Configures the reset option on supervised devices. Available for devices running macOS versions 12.0 and later. | |
| **GameCenterBlocked** | Write | Boolean | Configured if the Game Center icon is removed from the Home screen. Available for devices running macOS versions 10.13 and later. | |
| **ICloudBlockActivityContinuation** | Write | Boolean | Handoff lets users start work on one MacOS device, and continue it on another MacOS or iOS device. Available for macOS 10.15 and later. | |
| **ICloudBlockAddressBook** | Write | Boolean | Blocks iCloud from syncing contacts. | |
| **ICloudBlockBookmarks** | Write | Boolean | Blocks iCloud from syncing bookmarks. | |
| **ICloudBlockCalendar** | Write | Boolean | Blocks iCloud from syncing calendars. | |
| **ICloudBlockDocumentSync** | Write | Boolean | Blocks iCloud from syncing documents and data. | |
| **ICloudBlockMail** | Write | Boolean | Blocks iCloud from syncing mail. | |
| **ICloudBlockNotes** | Write | Boolean | Blocks iCloud from syncing notes. | |
| **ICloudBlockPhotoLibrary** | Write | Boolean | Any photos not fully downloaded from iCloud Photo Library to device will be removed from local storage. | |
| **ICloudBlockReminders** | Write | Boolean | Blocks iCloud from syncing reminders. | |
| **ICloudDesktopAndDocumentsBlocked** | Write | Boolean | Configures if the synchronization of cloud desktop and documents is blocked. Available for devices running macOS 10.12.4 and later. | |
| **ICloudPrivateRelayBlocked** | Write | Boolean | Configures if iCloud private relay is blocked or not. Available for devices running macOS 12 and later. | |
| **ITunesBlockFileSharing** | Write | Boolean | Blocks files from being transferred using iTunes. | |
| **ITunesBlockMusicService** | Write | Boolean | Configures  whether or not to block files from being transferred using iTunes. | |
| **KeyboardBlockDictation** | Write | Boolean | Block dictation, which is a feature that converts the user's voice to text. | |
| **KeychainBlockCloudSync** | Write | Boolean | Disables syncing credentials stored in the Keychain to iCloud | |
| **MultiplayerGamingBlocked** | Write | Boolean | Configures whether multiplayer gaming when using Game Center is blocked. Available for devices running macOS versions 10.13 and later. | |
| **PasswordBlockAirDropSharing** | Write | Boolean | Configures whether or not to block sharing passwords with the AirDrop passwords feature. | |
| **PasswordBlockAutoFill** | Write | Boolean | Configures whether or not to block the AutoFill Passwords feature. | |
| **PasswordBlockFingerprintUnlock** | Write | Boolean | Requires user to set a non-biometric passcode or password to unlock the device. | |
| **PasswordBlockModification** | Write | Boolean | Blocks user from changing the set passcode. | |
| **PasswordBlockProximityRequests** | Write | Boolean | Configures whether or not to block requesting passwords from nearby devices. | |
| **PasswordBlockSimple** | Write | Boolean | Block simple password sequences, such as 1234 or 1111. | |
| **PasswordExpirationDays** | Write | UInt32 | Number of days until device password must be changed. (1-65535) | |
| **PasswordMaximumAttemptCount** | Write | UInt32 | Configures the number of allowed failed attempts to enter the passcode at the device's lock screen. Valid values 2 to 11 | |
| **PasswordMinimumCharacterSetCount** | Write | UInt32 | Minimum number (0-4) of non-alphanumeric characters, such as #, %, !, etc., required in the password. The default value is 0. | |
| **PasswordMinimumLength** | Write | UInt32 | Minimum number of digits or characters in password (4-16). | |
| **PasswordMinutesOfInactivityBeforeLock** | Write | UInt32 | Set to 0 to require a password immediately. There is no maximum number of minutes, and this number overrides the number currently set on the device. | |
| **PasswordMinutesOfInactivityBeforeScreenTimeout** | Write | UInt32 | Set to 0 to use the device's minimum possible value. This number (0-60 minutes) overrides the number currently set on the device. | |
| **PasswordMinutesUntilFailedLoginReset** | Write | UInt32 | Configures the number of minutes before the login is reset after the maximum number of unsuccessful login attempts is reached. | |
| **PasswordPreviousPasswordBlockCount** | Write | UInt32 | Number of new passwords that must be used until an old one can be reused. (1-24) | |
| **PasswordRequired** | Write | Boolean | Specify the type of password required. | |
| **PasswordRequiredType** | Write | String | Specify the type of password required. | `deviceDefault`, `alphanumeric`, `numeric` |
| **PrivacyAccessControls** | Write | MSFT_MicrosoftGraphmacosprivacyaccesscontrolitem[] | Configure an app's access to specific data, folders, and apps on a device. These settings apply to devices running macOS Mojave 10.14 and later. | |
| **SafariBlockAutofill** | Write | Boolean | Blocks Safari from remembering what users enter in web forms. | |
| **ScreenCaptureBlocked** | Write | Boolean | Configures whether or not to block the user from taking Screenshots. | |
| **SoftwareUpdateMajorOSDeferredInstallDelayInDays** | Write | UInt32 | Specify the number of days (1-90) to delay visibility of major OS software updates. Available for devices running macOS versions 11.3 and later. Valid values 0 to 90 | |
| **SoftwareUpdateMinorOSDeferredInstallDelayInDays** | Write | UInt32 | Specify the number of days (1-90) to delay visibility of minor OS software updates. Available for devices running macOS versions 11.3 and later. Valid values 0 to 90 | |
| **SoftwareUpdateNonOSDeferredInstallDelayInDays** | Write | UInt32 | Specify the number of days (1-90) to delay visibility of non-OS software updates. Available for devices running macOS versions 11.3 and later. Valid values 0 to 90 | |
| **SoftwareUpdatesEnforcedDelayInDays** | Write | UInt32 | Delay the user's software update for this many days. The maximum is 90 days. (1-90) | |
| **SpotlightBlockInternetResults** | Write | Boolean | Blocks Spotlight from returning any results from an Internet search | |
| **TouchIdTimeoutInHours** | Write | UInt32 | Configures the maximum hours after which the user must enter their password to unlock the device instead of using Touch ID. Available for devices running macOS 12 and later. Valid values 0 to 2147483647 | |
| **UpdateDelayPolicy** | Write | StringArray[] | Configures whether to delay OS and/or app updates for macOS. | `none`, `delayOSUpdateVisibility`, `delayAppUpdateVisibility`, `unknownFutureValue`, `delayMajorOsUpdateVisibility` |
| **WallpaperModificationBlocked** | Write | Boolean | Configures whether the wallpaper can be changed. Available for devices running macOS versions 10.13 and later. | |
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

### MSFT_MicrosoftGraphapplistitemMacOS

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | Specify the odataType | `#microsoft.graph.appleAppListItem` |
| **appId** | Write | String | The application or bundle identifier of the application | |
| **appStoreUrl** | Write | String | The Store URL of the application | |
| **name** | Write | String | The application name | |
| **publisher** | Write | String | The publisher of the application | |

### MSFT_MicrosoftGraphmacosprivacyaccesscontrolitem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **accessibility** | Write | String | Allow the app or process to control the Mac via the Accessibility subsystem. | `notConfigured`, `enabled`, `disabled` |
| **addressBook** | Write | String | Allow or block access to contact information managed by Contacts. | `notConfigured`, `enabled`, `disabled` |
| **appleEventsAllowedReceivers** | Write | MSFT_MicrosoftGraphmacosappleeventreceiver[] | Allow or deny the app or process to send a restricted Apple event to another app or process. You will need to know the identifier, identifier type, and code requirement of the receiving app or process. | |
| **blockCamera** | Write | Boolean | Block access to camera app. | |
| **blockListenEvent** | Write | Boolean | Block the app or process from listening to events from input devices such as mouse, keyboard, and trackpad.Requires macOS 10.15 or later. | |
| **blockMicrophone** | Write | Boolean | Block access to microphone. | |
| **blockScreenCapture** | Write | Boolean | Block app from capturing contents of system display. Requires macOS 10.15 or later. | |
| **calendar** | Write | String | Allow or block access to event information managed by Calendar. | `notConfigured`, `enabled`, `disabled` |
| **codeRequirement** | Write | String | Enter the code requirement, which can be obtained with the command 'codesign -display -r -' in the Terminal app. Include everything after '=>'. | |
| **displayName** | Write | String | The display name of the app, process, or executable. | |
| **fileProviderPresence** | Write | String | Allow the app or process to access files managed by another app's file provider extension. Requires macOS 10.15 or later. | `notConfigured`, `enabled`, `disabled` |
| **identifier** | Write | String | The bundle ID or path of the app, process, or executable. | |
| **identifierType** | Write | String | A bundle ID is used to identify an app. A path is used to identify a process or executable. | `bundleID`, `path` |
| **mediaLibrary** | Write | String | Allow or block access to music and the media library. | `notConfigured`, `enabled`, `disabled` |
| **photos** | Write | String | Allow or block access to images managed by Photos. | `notConfigured`, `enabled`, `disabled` |
| **postEvent** | Write | String | Control access to CoreGraphics APIs, which are used to send CGEvents to the system event stream. | `notConfigured`, `enabled`, `disabled` |
| **reminders** | Write | String | Allow or block access to information managed by Reminders. | `notConfigured`, `enabled`, `disabled` |
| **speechRecognition** | Write | String | Allow or block access to system speech recognition facility. | `notConfigured`, `enabled`, `disabled` |
| **staticCodeValidation** | Write | Boolean | Statically validates the code requirement. Use this setting if the process invalidates its dynamic code signature. | |
| **systemPolicyAllFiles** | Write | String | Control access to all protected files on a device. Files might be in locations such as emails, messages, apps, and administrative settings. Apply this setting with caution. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicyDesktopFolder** | Write | String | Allow or block access to Desktop folder. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicyDocumentsFolder** | Write | String | Allow or block access to Documents folder. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicyDownloadsFolder** | Write | String | Allow or block access to Downloads folder. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicyNetworkVolumes** | Write | String | Allow or block access to network volumes. Requires macOS 10.15 or later. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicyRemovableVolumes** | Write | String | Control access to removable volumes on the device, such as an external hard drive. Requires macOS 10.15 or later. | `notConfigured`, `enabled`, `disabled` |
| **systemPolicySystemAdminFiles** | Write | String | Allow app or process to access files used in system administration. | `notConfigured`, `enabled`, `disabled` |

### MSFT_MicrosoftGraphmacosappleeventreceiver

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **allowed** | Write | Boolean | Allow or block this app from receiving Apple events. | |
| **codeRequirement** | Write | String | Code requirement for the app or binary that receives the Apple Event. | |
| **identifier** | Write | String | Bundle ID of the app or file path of the process or executable that receives the Apple Event. | |
| **identifierType** | Write | String | Use bundle ID for an app or path for a process or executable that receives the Apple Event. | `bundleID`, `path` |


## Description

This resource configures an Intune device configuration profile for an MacOS Device.

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
        IntuneDeviceConfigurationPolicyMacOS 'myMacOSDevicePolicy'
        {
            DisplayName                                     = 'MacOS device restriction'
            AddingGameCenterFriendsBlocked                  = $True
            AirDropBlocked                                  = $False
            AppleWatchBlockAutoUnlock                       = $False
            Assignments                                     = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                    groupId                                    = 'e8cbd84d-be6a-4b72-87f0-0e677541fda0'
                }
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                    groupId                                    = 'ea9199b8-3e6e-407b-afdc-e0943e0d3c20'
                })
            CameraBlocked                                   = $False
            ClassroomAppBlockRemoteScreenObservation        = $False
            ClassroomAppForceUnpromptedScreenObservation    = $False
            ClassroomForceAutomaticallyJoinClasses          = $False
            ClassroomForceRequestPermissionToLeaveClasses   = $False
            ClassroomForceUnpromptedAppAndDeviceLock        = $False
            CompliantAppListType                            = 'appsNotInListCompliant'
            CompliantAppsList                               = @(
                MSFT_MicrosoftGraphapplistitemMacOS {
                    name      = 'appname2'
                    publisher = 'publisher'
                    appId     = 'bundle'
                }
            )
            ContentCachingBlocked                           = $False
            DefinitionLookupBlocked                         = $True
            EmailInDomainSuffixes                           = @()
            EraseContentAndSettingsBlocked                  = $False
            GameCenterBlocked                               = $False
            ICloudBlockActivityContinuation                 = $False
            ICloudBlockAddressBook                          = $False
            ICloudBlockBookmarks                            = $False
            ICloudBlockCalendar                             = $False
            ICloudBlockDocumentSync                         = $False
            ICloudBlockMail                                 = $False
            ICloudBlockNotes                                = $False
            ICloudBlockPhotoLibrary                         = $False
            ICloudBlockReminders                            = $False
            ICloudDesktopAndDocumentsBlocked                = $False
            ICloudPrivateRelayBlocked                       = $False
            ITunesBlockFileSharing                          = $False
            ITunesBlockMusicService                         = $False
            KeyboardBlockDictation                          = $False
            KeychainBlockCloudSync                          = $False
            MultiplayerGamingBlocked                        = $False
            PasswordBlockAirDropSharing                     = $False
            PasswordBlockAutoFill                           = $False
            PasswordBlockFingerprintUnlock                  = $False
            PasswordBlockModification                       = $False
            PasswordBlockProximityRequests                  = $False
            PasswordBlockSimple                             = $False
            PasswordRequired                                = $False
            PasswordRequiredType                            = 'deviceDefault'
            PrivacyAccessControls                           = @(
                MSFT_MicrosoftGraphmacosprivacyaccesscontrolitem {
                    displayName                  = 'test'
                    identifier                   = 'test45'
                    identifierType               = 'path'
                    codeRequirement              = 'test'
                    blockCamera                  = $True
                    speechRecognition            = 'notConfigured'
                    accessibility                = 'notConfigured'
                    addressBook                  = 'enabled'
                    calendar                     = 'notConfigured'
                    reminders                    = 'notConfigured'
                    photos                       = 'notConfigured'
                    mediaLibrary                 = 'notConfigured'
                    fileProviderPresence         = 'notConfigured'
                    systemPolicyAllFiles         = 'notConfigured'
                    systemPolicySystemAdminFiles = 'notConfigured'
                    systemPolicyDesktopFolder    = 'notConfigured'
                    systemPolicyDocumentsFolder  = 'notConfigured'
                    systemPolicyDownloadsFolder  = 'notConfigured'
                    systemPolicyNetworkVolumes   = 'notConfigured'
                    systemPolicyRemovableVolumes = 'notConfigured'
                    postEvent                    = 'notConfigured'
                }
            )
            SafariBlockAutofill                             = $False
            ScreenCaptureBlocked                            = $False
            SoftwareUpdateMajorOSDeferredInstallDelayInDays = 30
            SoftwareUpdateMinorOSDeferredInstallDelayInDays = 30
            SoftwareUpdateNonOSDeferredInstallDelayInDays   = 30
            SoftwareUpdatesEnforcedDelayInDays              = 30
            SpotlightBlockInternetResults                   = $False
            UpdateDelayPolicy                               = @('delayOSUpdateVisibility', 'delayAppUpdateVisibility', 'delayMajorOsUpdateVisibility')
            WallpaperModificationBlocked                    = $False
            Ensure                                          = 'Present'
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
        IntuneDeviceConfigurationPolicyMacOS 'myMacOSDevicePolicy'
        {
            DisplayName                                     = 'MacOS device restriction'
            AddingGameCenterFriendsBlocked                  = $True
            AirDropBlocked                                  = $True # Updated Property
            AppleWatchBlockAutoUnlock                       = $False
            Assignments                                     = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                    groupId                                    = 'e8cbd84d-be6a-4b72-87f0-0e677541fda0'
                }
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                    groupId                                    = 'ea9199b8-3e6e-407b-afdc-e0943e0d3c20'
                })
            CameraBlocked                                   = $False
            ClassroomAppBlockRemoteScreenObservation        = $False
            ClassroomAppForceUnpromptedScreenObservation    = $False
            ClassroomForceAutomaticallyJoinClasses          = $False
            ClassroomForceRequestPermissionToLeaveClasses   = $False
            ClassroomForceUnpromptedAppAndDeviceLock        = $False
            CompliantAppListType                            = 'appsNotInListCompliant'
            CompliantAppsList                               = @(
                MSFT_MicrosoftGraphapplistitemMacOS {
                    name      = 'appname2'
                    publisher = 'publisher'
                    appId     = 'bundle'
                }
            )
            ContentCachingBlocked                           = $False
            DefinitionLookupBlocked                         = $True
            EmailInDomainSuffixes                           = @()
            EraseContentAndSettingsBlocked                  = $False
            GameCenterBlocked                               = $False
            ICloudBlockActivityContinuation                 = $False
            ICloudBlockAddressBook                          = $False
            ICloudBlockBookmarks                            = $False
            ICloudBlockCalendar                             = $False
            ICloudBlockDocumentSync                         = $False
            ICloudBlockMail                                 = $False
            ICloudBlockNotes                                = $False
            ICloudBlockPhotoLibrary                         = $False
            ICloudBlockReminders                            = $False
            ICloudDesktopAndDocumentsBlocked                = $False
            ICloudPrivateRelayBlocked                       = $False
            ITunesBlockFileSharing                          = $False
            ITunesBlockMusicService                         = $False
            KeyboardBlockDictation                          = $False
            KeychainBlockCloudSync                          = $False
            MultiplayerGamingBlocked                        = $False
            PasswordBlockAirDropSharing                     = $False
            PasswordBlockAutoFill                           = $False
            PasswordBlockFingerprintUnlock                  = $False
            PasswordBlockModification                       = $False
            PasswordBlockProximityRequests                  = $False
            PasswordBlockSimple                             = $False
            PasswordRequired                                = $False
            PasswordRequiredType                            = 'deviceDefault'
            PrivacyAccessControls                           = @(
                MSFT_MicrosoftGraphmacosprivacyaccesscontrolitem {
                    displayName                  = 'test'
                    identifier                   = 'test45'
                    identifierType               = 'path'
                    codeRequirement              = 'test'
                    blockCamera                  = $True
                    speechRecognition            = 'notConfigured'
                    accessibility                = 'notConfigured'
                    addressBook                  = 'enabled'
                    calendar                     = 'notConfigured'
                    reminders                    = 'notConfigured'
                    photos                       = 'notConfigured'
                    mediaLibrary                 = 'notConfigured'
                    fileProviderPresence         = 'notConfigured'
                    systemPolicyAllFiles         = 'notConfigured'
                    systemPolicySystemAdminFiles = 'notConfigured'
                    systemPolicyDesktopFolder    = 'notConfigured'
                    systemPolicyDocumentsFolder  = 'notConfigured'
                    systemPolicyDownloadsFolder  = 'notConfigured'
                    systemPolicyNetworkVolumes   = 'notConfigured'
                    systemPolicyRemovableVolumes = 'notConfigured'
                    postEvent                    = 'notConfigured'
                }
            )
            SafariBlockAutofill                             = $False
            ScreenCaptureBlocked                            = $False
            SoftwareUpdateMajorOSDeferredInstallDelayInDays = 30
            SoftwareUpdateMinorOSDeferredInstallDelayInDays = 30
            SoftwareUpdateNonOSDeferredInstallDelayInDays   = 30
            SoftwareUpdatesEnforcedDelayInDays              = 30
            SpotlightBlockInternetResults                   = $False
            UpdateDelayPolicy                               = @('delayOSUpdateVisibility', 'delayAppUpdateVisibility', 'delayMajorOsUpdateVisibility')
            WallpaperModificationBlocked                    = $False
            Ensure                                          = 'Present'
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
        IntuneDeviceConfigurationPolicyMacOS 'myMacOSDevicePolicy'
        {
            DisplayName                                     = 'MacOS device restriction'
            Ensure                                          = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

