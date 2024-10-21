# IntuneAppProtectionPolicyiOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the iOS App Protection Policy. | |
| **Identity** | Write | String | Identity of the iOS App Protection Policy. | |
| **Description** | Write | String | Description of the iOS App Protection Policy. | |
| **PeriodOfflineBeforeAccessCheck** | Write | String | The period after which access is checked when the device is not connected to the internet. | |
| **PeriodOnlineBeforeAccessCheck** | Write | String | The period after which access is checked when the device is connected to the internet. | |
| **AllowedInboundDataTransferSources** | Write | String | Sources from which data is allowed to be transferred. Possible values are: allApps, managedApps, none. | `allApps`, `managedApps`, `none` |
| **AllowedOutboundDataTransferDestinations** | Write | String | Destinations to which data is allowed to be transferred. Possible values are: allApps, managedApps, none. | `allApps`, `managedApps`, `none` |
| **OrganizationalCredentialsRequired** | Write | Boolean | Indicates whether organizational credentials are required for app use. | |
| **AllowedOutboundClipboardSharingLevel** | Write | String | The level to which the clipboard may be shared between apps on the managed device. Possible values are: allApps, managedAppsWithPasteIn, managedApps, blocked. | `allApps`, `managedAppsWithPasteIn`, `managedApps`, `blocked` |
| **DataBackupBlocked** | Write | Boolean | Indicates whether the backup of a managed app's data is blocked. | |
| **DeviceComplianceRequired** | Write | Boolean | Indicates whether device compliance is required. | |
| **ManagedBrowserToOpenLinksRequired** | Write | Boolean | Indicates whether internet links should be opened in the managed browser app, or any custom browser specified by CustomBrowserProtocol (for iOS) or CustomBrowserPackageId/CustomBrowserDisplayName (for Android). | |
| **SaveAsBlocked** | Write | Boolean | Indicates whether users may use the Save As menu item to save a copy of protected files. | |
| **PeriodOfflineBeforeWipeIsEnforced** | Write | String | The amount of time an app is allowed to remain disconnected from the internet before all managed data it is wiped. | |
| **PinRequired** | Write | Boolean | Indicates whether an app-level pin is required. | |
| **DisableAppPinIfDevicePinIsSet** | Write | Boolean | Indicates whether use of the app pin is required if the device pin is set. | |
| **MaximumPinRetries** | Write | UInt32 | Maximum number of incorrect pin retry attempts before the managed app is either blocked or wiped. | |
| **SimplePinBlocked** | Write | Boolean | Block simple PIN and require complex PIN to be set. | |
| **MinimumPinLength** | Write | UInt32 | Minimum pin length required for an app-level pin if PinRequired is set to True. | |
| **PinCharacterSet** | Write | String | Character set which may be used for an app-level pin if PinRequired is set to True. Possible values are: numeric, alphanumericAndSymbol. | `numeric`, `alphanumericAndSymbol` |
| **AllowedDataStorageLocations** | Write | StringArray[] | Data storage locations where a user may store managed data. | |
| **ContactSyncBlocked** | Write | Boolean | Indicates whether contacts can be synced to the user's device. | |
| **PeriodBeforePinReset** | Write | String | TimePeriod before the all-level pin must be reset if PinRequired is set to True. | |
| **PrintBlocked** | Write | Boolean | Indicates whether printing is allowed from managed apps. | |
| **FingerprintBlocked** | Write | Boolean | Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True. | |
| **FaceIdBlocked** | Write | Boolean | Indicates whether use of the FaceID is allowed in place of a pin if PinRequired is set to True. | |
| **ManagedBrowser** | Write | String | Indicates in which managed browser(s) that internet links should be opened. When this property is configured, ManagedBrowserToOpenLinksRequired should be true. Possible values are: notConfigured, microsoftEdge. | `notConfigured`, `microsoftEdge` |
| **MinimumRequiredAppVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumWarningAppVersion** | Write | String | Versions less than the specified version will result in warning message on the managed app from accessing company data. | |
| **MinimumRequiredOSVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumWarningOSVersion** | Write | String | Versions less than the specified version will result in warning message on the managed app from accessing company data. | |
| **MinimumRequiredSdkVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumWipeOSVersion** | Write | String | Versions less than or equal to the specified version will wipe the managed app and the associated company data. | |
| **MinimumWipeAppVersion** | Write | String | Versions less than or equal to the specified version will wipe the managed app and the associated company data. | |
| **AppActionIfDeviceComplianceRequired** | Write | String | Defines a managed app behavior, either block or wipe, when the device is either rooted or jailbroken, if DeviceComplianceRequired is set to true. | `block`, `wipe`, `warn` |
| **AppActionIfMaximumPinRetriesExceeded** | Write | String | Defines a managed app behavior, either block or wipe, based on maximum number of incorrect pin retry attempts. | `block`, `wipe`, `warn` |
| **PinRequiredInsteadOfBiometricTimeout** | Write | String | Timeout in minutes for an app pin instead of non biometrics passcode . | |
| **AllowedOutboundClipboardSharingExceptionLength** | Write | UInt32 | Specify the number of characters that may be cut or copied from Org data and accounts to any application. This setting overrides the AllowedOutboundClipboardSharingLevel restriction. Default value of '0' means no exception is allowed. | |
| **NotificationRestriction** | Write | String | Specify app notification restriction. | `allow`, `blockOrganizationalData`, `block` |
| **TargetedAppManagementLevels** | Write | StringArray[] | The intended app management levels for this policy. | `unspecified`, `unmanaged`, `mdm`, `androidEnterprise` |
| **AppDataEncryptionType** | Write | String | Require app data to be encrypted. | `useDeviceSettings`, `afterDeviceRestart`, `whenDeviceLockedExceptOpenFiles`, `whenDeviceLocked` |
| **ExemptedAppProtocols** | Write | StringArray[] | Apps in this list will be exempt from the policy and will be able to receive data from managed apps. | |
| **MinimumWipeSdkVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **AllowedIosDeviceModels** | Write | StringArray[] | Semicolon seperated list of device models allowed, as a string, for the managed app to work. | |
| **AppActionIfIosDeviceModelNotAllowed** | Write | String | Defines a managed app behavior, either block or wipe, if the specified device model is not allowed. | `block`, `wipe`, `warn` |
| **FilterOpenInToOnlyManagedApps** | Write | Boolean | Defines if open-in operation is supported from the managed app to the filesharing locations selected. This setting only applies when AllowedOutboundDataTransferDestinations is set to ManagedApps and DisableProtectionOfManagedOutboundOpenInData is set to False. | |
| **DisableProtectionOfManagedOutboundOpenInData** | Write | Boolean | Disable protection of data transferred to other apps through IOS OpenIn option. This setting is only allowed to be True when AllowedOutboundDataTransferDestinations is set to ManagedApps. | |
| **ProtectInboundDataFromUnknownSources** | Write | Boolean | Protect incoming data from unknown source. This setting is only allowed to be True when AllowedInboundDataTransferSources is set to AllApps. | |
| **CustomBrowserProtocol** | Write | String | A custom browser protocol to open weblink on iOS. | |
| **Apps** | Write | StringArray[] | List of IDs representing the iOS apps controlled by this protection policy. | |
| **Assignments** | Write | StringArray[] | List of IDs of the groups assigned to this iOS Protection Policy. | |
| **ExcludedGroups** | Write | StringArray[] | List of IDs of the groups that are excluded from this iOS Protection Policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin. | |
| **ApplicationId** | Write | String | ID of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | ID of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures an Intune app protection policy for an iOS Device.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

## Examples

### Example 1

This example creates a new App ProtectionPolicy for iOS.

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
        IntuneAppProtectionPolicyiOS 'MyCustomiOSPolicy'
        {
            DisplayName                             = 'My DSC iOS App Protection Policy'
            AllowedDataStorageLocations             = @('sharePoint')
            AllowedInboundDataTransferSources       = 'managedApps'
            AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
            AllowedOutboundDataTransferDestinations = 'managedApps'
            AppDataEncryptionType                   = 'whenDeviceLocked'
            Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
            ContactSyncBlocked                      = $False
            DataBackupBlocked                       = $False
            Description                             = ''
            DeviceComplianceRequired                = $True
            FingerprintBlocked                      = $False
            ManagedBrowserToOpenLinksRequired       = $True
            MaximumPinRetries                       = 5
            MinimumPinLength                        = 4
            OrganizationalCredentialsRequired       = $False
            PeriodOfflineBeforeAccessCheck          = 'PT12H'
            PeriodOfflineBeforeWipeIsEnforced       = 'P90D'
            PeriodOnlineBeforeAccessCheck           = 'PT30M'
            PinCharacterSet                         = 'alphanumericAndSymbol'
            PinRequired                             = $True
            PrintBlocked                            = $False
            SaveAsBlocked                           = $True
            SimplePinBlocked                        = $False
            Ensure                                  = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new App ProtectionPolicy for iOS.

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
        IntuneAppProtectionPolicyiOS 'MyCustomiOSPolicy'
        {
            DisplayName                             = 'My DSC iOS App Protection Policy'
            AllowedDataStorageLocations             = @('sharePoint')
            AllowedInboundDataTransferSources       = 'managedApps'
            AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
            AllowedOutboundDataTransferDestinations = 'managedApps'
            AppDataEncryptionType                   = 'whenDeviceLocked'
            Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
            ContactSyncBlocked                      = $False
            DataBackupBlocked                       = $False
            Description                             = ''
            DeviceComplianceRequired                = $True
            FingerprintBlocked                      = $False
            ManagedBrowserToOpenLinksRequired       = $True
            MaximumPinRetries                       = 7 # Updated Property
            MinimumPinLength                        = 4
            OrganizationalCredentialsRequired       = $False
            PeriodOfflineBeforeAccessCheck          = 'PT12H'
            PeriodOfflineBeforeWipeIsEnforced       = 'P90D'
            PeriodOnlineBeforeAccessCheck           = 'PT30M'
            PinCharacterSet                         = 'alphanumericAndSymbol'
            PinRequired                             = $True
            PrintBlocked                            = $False
            SaveAsBlocked                           = $True
            SimplePinBlocked                        = $False
            Ensure                                  = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new App ProtectionPolicy for iOS.

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
        IntuneAppProtectionPolicyiOS 'MyCustomiOSPolicy'
        {
            DisplayName                             = 'My DSC iOS App Protection Policy'
            Ensure                                  = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

