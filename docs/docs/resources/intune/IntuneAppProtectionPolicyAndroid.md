# IntuneAppProtectionPolicyAndroid

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the Android App Protection Policy. | |
| **Description** | Write | String | Description of the Android App Protection Policy. | |
| **PeriodOfflineBeforeAccessCheck** | Write | String | The period after which access is checked when the device is not connected to the internet. | |
| **PeriodOnlineBeforeAccessCheck** | Write | String | The period after which access is checked when the device is connected to the internet. | |
| **AllowedInboundDataTransferSources** | Write | String | Sources from which data is allowed to be transferred. Possible values are: allApps, managedApps, none. | `allApps`, `managedApps`, `none` |
| **AllowedOutboundDataTransferDestinations** | Write | String | Destinations to which data is allowed to be transferred. Possible values are: allApps, managedApps, none. | `allApps`, `managedApps`, `none` |
| **OrganizationalCredentialsRequired** | Write | Boolean | Indicates whether organizational credentials are required for app use. | |
| **AllowedOutboundClipboardSharingLevel** | Write | String | The level to which the clipboard may be shared between apps on the managed device. Possible values are: allApps, managedAppsWithPasteIn, managedApps, blocked. | `allApps`, `managedAppsWithPasteIn`, `managedApps`, `blocked` |
| **DataBackupBlocked** | Write | Boolean | Indicates whether the backup of a managed app's data is blocked. | |
| **DeviceComplianceRequired** | Write | Boolean | Indicates whether device compliance is required. | |
| **ManagedBrowserToOpenLinksRequired** | Write | Boolean | Indicates whether internet links should be opened in the managed browser app, or any custom browser specified by CustomBrowserProtocol (for Android) or CustomBrowserPackageId/CustomBrowserDisplayName (for Android). | |
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
| **RequireClass3Biometrics** | Write | Boolean | Require user to apply Class 3 Biometrics on their Android device. | |
| **RequirePinAfterBiometricChange** | Write | Boolean | A PIN prompt will override biometric prompts if class 3 biometrics are updated on the device. | |
| **FingerprintBlocked** | Write | Boolean | Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True. | |
| **Apps** | Write | StringArray[] | List of IDs representing the Android apps controlled by this protection policy. | |
| **Assignments** | Write | StringArray[] | List of IDs of the groups assigned to this Android Protection Policy. | |
| **ExcludedGroups** | Write | StringArray[] | List of IDs of the groups that are excluded from this Android Protection Policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | ID of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | ID of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **ManagedBrowser** | Write | String | Indicates in which managed browser(s) that internet links should be opened. Used in conjunction with CustomBrowserPackageId, CustomBrowserDisplayName and ManagedBrowserToOpenLinksRequired. Possible values are: notConfigured, microsoftEdge. | `notConfigured`, `microsoftEdge` |
| **MinimumRequiredAppVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumRequiredOSVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumRequiredPatchVersion** | Write | String | Versions less than the specified version will block the managed app from accessing company data. | |
| **MinimumWarningAppVersion** | Write | String | Versions less than the specified version will result in warning message on the managed app | |
| **MinimumWarningOSVersion** | Write | String | Versions less than the specified version will result in warning message on the managed app | |
| **MinimumWarningPatchVersion** | Write | String | Versions less than the specified version will result in warning message on the managed app | |
| **AppGroupType** | Write | String | The apps controlled by this protection policy, overrides any values in Apps unless this value is 'selectedPublicApps'. | `allApps`, `allMicrosoftApps`, `allCoreMicrosoftApps`, `selectedPublicApps` |
| **IsAssigned** | Write | Boolean | Indicates if the policy is deployed to any inclusion groups or not. Inherited from targetedManagedAppProtection. | |
| **ScreenCaptureBlocked** | Write | Boolean | Indicates whether or not to Block the user from taking Screenshots. | |
| **EncryptAppData** | Write | Boolean | Indicates whether or not the 'Encrypt org data' value is enabled.  True = require | |
| **DisableAppEncryptionIfDeviceEncryptionIsEnabled** | Write | Boolean | Indicates whether or not the 'Encrypt org data on enrolled devices' value is enabled.  False = require.  Only functions if EncryptAppData is set to True | |
| **CustomBrowserDisplayName** | Write | String | The application name for browser associated with the 'Unmanaged Browser ID'. This name will be displayed to users if the specified browser is not installed. | |
| **CustomBrowserPackageId** | Write | String | The application ID for a single browser. Web content (http/s) from policy managed applications will open in the specified browser. | |
| **Id** | Write | String | Id of the Intune policy. To avoid creation of duplicate policies DisplayName will be searched for if the ID is not found | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures an Intune app protection policy for an Android Device.

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

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param
    (
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
        IntuneAppProtectionPolicyAndroid 'ConfigureAppProtectionPolicyAndroid'
        {
            DisplayName                             = 'My DSC Android App Protection Policy'
            AllowedDataStorageLocations             = @('sharePoint')
            AllowedInboundDataTransferSources       = 'managedApps'
            AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
            AllowedOutboundDataTransferDestinations = 'managedApps'
            Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
            ContactSyncBlocked                      = $false
            DataBackupBlocked                       = $false
            Description                             = ''
            DeviceComplianceRequired                = $True
            DisableAppPinIfDevicePinIsSet           = $True
            FingerprintBlocked                      = $False
            ManagedBrowserToOpenLinksRequired       = $True
            MaximumPinRetries                       = 5
            MinimumPinLength                        = 4
            OrganizationalCredentialsRequired       = $false
            PinRequired                             = $True
            PrintBlocked                            = $True
            SaveAsBlocked                           = $True
            SimplePinBlocked                        = $True
            Ensure                                  = 'Present'
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
    param
    (
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
        IntuneAppProtectionPolicyAndroid 'ConfigureAppProtectionPolicyAndroid'
        {
            DisplayName                             = 'My DSC Android App Protection Policy'
            AllowedDataStorageLocations             = @('sharePoint')
            AllowedInboundDataTransferSources       = 'managedApps'
            AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
            AllowedOutboundDataTransferDestinations = 'managedApps'
            Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
            ContactSyncBlocked                      = $true # Updated Property
            DataBackupBlocked                       = $false
            Description                             = ''
            DeviceComplianceRequired                = $True
            DisableAppPinIfDevicePinIsSet           = $True
            FingerprintBlocked                      = $False
            ManagedBrowserToOpenLinksRequired       = $True
            MaximumPinRetries                       = 5
            MinimumPinLength                        = 4
            OrganizationalCredentialsRequired       = $false
            PinRequired                             = $True
            PrintBlocked                            = $True
            SaveAsBlocked                           = $True
            SimplePinBlocked                        = $True
            Ensure                                  = 'Present'
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
    param
    (
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
        IntuneAppProtectionPolicyAndroid 'ConfigureAppProtectionPolicyAndroid'
        {
            DisplayName                             = 'My DSC Android App Protection Policy'
            Ensure                                  = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

