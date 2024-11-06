# EXOActiveSyncMailboxPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Specifies the name of the policy. | |
| **AllowApplePushNotifications** | Write | Boolean | Specifies whether push notifications are allowed for Apple mobile devices. | |
| **AllowBluetooth** | Write | String | Specifies whether the Bluetooth capabilities of the mobile phone are allowed. | `Disable`, `HandsfreeOnly`, `Allow` |
| **AllowBrowser** | Write | Boolean | Specifies whether Microsoft Pocket Internet Explorer is allowed on the mobile phone. | |
| **AllowCamera** | Write | Boolean | Specifies whether the mobile phone's camera is allowed. | |
| **AllowConsumerEmail** | Write | Boolean | Specifies whether the mobile phone user can configure a personal email account on the device. | |
| **AllowDesktopSync** | Write | Boolean | Specifies whether the mobile phone can synchronize with a desktop computer through a cable. | |
| **AllowExternalDeviceManagement** | Write | Boolean | Specifies whether an external device management program is allowed to manage the device. | |
| **AllowHTMLEmail** | Write | Boolean | Specifies whether HTML email is enabled on the device. | |
| **AllowInternetSharing** | Write | Boolean | Specifies whether the mobile phone can be used as a modem to connect a computer to the Internet. | |
| **AllowIrDA** | Write | Boolean | Specifies whether infrared connections are allowed to the mobile phone. | |
| **AllowMobileOTAUpdate** | Write | Boolean | Specifies whether certain updates are seen by devices that implemented support for this restricting functionality. | |
| **AllowNonProvisionableDevices** | Write | Boolean | Enables all devices to synchronize with the computer running Exchange, regardless of whether the device can enforce all the specific settings established in the Mobile Device mailbox policy. | |
| **AllowPOPIMAPEmail** | Write | Boolean | Specifies whether the user can configure a POP3 or IMAP4 email account on the device. | |
| **AllowRemoteDesktop** | Write | Boolean | Specifies whether the mobile phone can initiate a remote desktop connection. | |
| **AllowSimpleDevicePassword** | Write | Boolean | Specifies whether a simple device password is allowed. | |
| **AllowSMIMEEncryptionAlgorithmNegotiation** | Write | String | Specifies whether the messaging application on the device can negotiate the encryption algorithm in case a recipient's certificate doesn't support the specified encryption algorithm. | |
| **AllowSMIMESoftCerts** | Write | Boolean | Specifies whether S/MIME software certificates are allowed. | |
| **AllowStorageCard** | Write | Boolean | Specifies whether the device can access information stored on a storage card. | |
| **AllowTextMessaging** | Write | Boolean | Specifies whether text messaging is allowed from the device. | |
| **AllowUnsignedApplications** | Write | Boolean | Specifies whether unsigned applications can be installed on the device. | |
| **AllowUnsignedInstallationPackages** | Write | Boolean | Specifies whether unsigned installation packages can be run on the device. | |
| **AllowWiFi** | Write | Boolean | Specifies whether wireless Internet access is allowed on the device. | |
| **AlphanumericDevicePasswordRequired** | Write | Boolean | Specifies whether the device password must be alphanumeric. | |
| **ApprovedApplicationList** | Write | StringArray[] | Specifies a list of approved applications for the device. | |
| **AttachmentsEnabled** | Write | Boolean | Specifies whether the user can download attachments. | |
| **DeviceEncryptionEnabled** | Write | Boolean | Enables device encryption on the mobile phone. | |
| **DevicePasswordEnabled** | Write | Boolean | Specifies that the user set a password for the device. | |
| **DevicePasswordExpiration** | Write | String | Specifies the length of time, in days, that a password can be used. | |
| **DevicePasswordHistory** | Write | SInt32 | Specifies the number of previously used passwords to store. | |
| **DevicePolicyRefreshInterval** | Write | String | Specifies how often the policy is sent from the server to the mobile phone | |
| **IrmEnabled** | Write | Boolean | Specifies whether Information Rights Management (IRM) is enabled for the mailbox policy. | |
| **IsDefault** | Write | Boolean | Specifies whether this policy is the default Mobile Device mailbox policy. | |
| **IsDefaultPolicy** | Write | Boolean | Specifies whether this policy is the default Mobile Device mailbox policy. | |
| **MaxAttachmentSize** | Write | String | Specifies the maximum size of attachments that can be downloaded to the mobile phone. | |
| **MaxCalendarAgeFilter** | Write | String | Specifies the maximum range of calendar days that can be synchronized to the device. | `All`, `TwoWeeks`, `OneMonth`, `ThreeMonths`, `SixMonths` |
| **MaxDevicePasswordFailedAttempts** | Write | String | Specifies the number of attempts a user can make to enter the correct password for the device. | |
| **MaxEmailAgeFilter** | Write | String | Specifies the maximum number of days of email items to synchronize to the device. | `All`, `OneDay`, `ThreeDays`, `OneWeek`, `TwoWeeks`, `OneMonth`, `ThreeMonths`, `SixMonths` |
| **MaxEmailBodyTruncationSize** | Write | String | Specifies the maximum size at which email messages are truncated when synchronized to the device. | |
| **MaxEmailHTMLBodyTruncationSize** | Write | String | Specifies the maximum size at which HTML-formatted email messages are synchronized to the device. | |
| **MaxInactivityTimeDeviceLock** | Write | String | Specifies the length of time that the device can be inactive before the password is required to reactivate the device. | |
| **MinDevicePasswordComplexCharacters** | Write | SInt32 | Specifies the minimum number of complex characters required in a device password. | |
| **MinDevicePasswordLength** | Write | SInt32 | Specifies the minimum number of characters in the device password. | |
| **PasswordRecoveryEnabled** | Write | Boolean | Specifies whether you can store the recovery password for the device on an Exchange server. | |
| **RequireDeviceEncryption** | Write | Boolean | Specifies whether encryption is required on the device. | |
| **RequireEncryptedSMIMEMessages** | Write | Boolean | Specifies whether you must encrypt S/MIME messages. | |
| **RequireEncryptionSMIMEAlgorithm** | Write | String | Specifies what required algorithm must be used when encrypting a message. | |
| **RequireManualSyncWhenRoaming** | Write | Boolean | Specifies whether the device must synchronize manually while roaming. | |
| **RequireSignedSMIMEAlgorithm** | Write | String | Specifies what required algorithm must be used when signing a message. | |
| **RequireSignedSMIMEMessages** | Write | Boolean | Specifies whether the device must send signed S/MIME messages. | |
| **RequireStorageCardEncryption** | Write | Boolean | Specifies whether encryption of a storage card is required. | |
| **UnapprovedInROMApplicationList** | Write | StringArray[] | Specifies a list of applications that can't be run in ROM. | |
| **UNCAccessEnabled** | Write | Boolean | Specifies whether access to Microsoft Windows file shares is enabled. | |
| **WSSAccessEnabled** | Write | Boolean | Specifies whether access to Microsoft Windows SharePoint Services is enabled. | |
| **Identity** | Key | String | Specifies the Mobile Device mailbox policy. | |
| **Ensure** | Write | String | Specifies if this AddressList should exist. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource manages Mobile Device mailbox policy for mailboxes accessed by mobile devices.

## Permissions

### Exchange

To authenticate with Microsoft Exchange, this resource required the following permissions:

#### Roles

- Organization Client Access, View-Only Configuration

#### Role Groups

- Organization Management

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
        EXOActiveSyncMailboxPolicy 'TestActiveSyncMailboxPolicy'
        {
            AllowApplePushNotifications              = $True;
            AllowBluetooth                           = "Allow";
            AllowBrowser                             = $True;
            AllowCamera                              = $True;
            AllowConsumerEmail                       = $True;
            AllowDesktopSync                         = $True;
            AllowExternalDeviceManagement            = $False;
            AllowHTMLEmail                           = $True;
            AllowInternetSharing                     = $True;
            AllowIrDA                                = $True;
            AllowMobileOTAUpdate                     = $True;
            AllowNonProvisionableDevices             = $True;
            AllowPOPIMAPEmail                        = $True;
            AllowRemoteDesktop                       = $True;
            AllowSimpleDevicePassword                = $True;
            AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
            AllowSMIMESoftCerts                      = $True;
            AllowStorageCard                         = $True;
            AllowTextMessaging                       = $True;
            AllowUnsignedApplications                = $True;
            AllowUnsignedInstallationPackages        = $True;
            AllowWiFi                                = $True;
            AlphanumericDevicePasswordRequired       = $False;
            ApprovedApplicationList                  = @();
            AttachmentsEnabled                       = $True;
            DeviceEncryptionEnabled                  = $False;
            DevicePasswordEnabled                    = $False;
            DevicePasswordExpiration                 = "Unlimited";
            DevicePasswordHistory                    = 0;
            DevicePolicyRefreshInterval              = "Unlimited";
            Identity                                 = "Test";
            IrmEnabled                               = $True;
            IsDefault                                = $True;
            IsDefaultPolicy                          = $True;
            MaxAttachmentSize                        = "Unlimited";
            MaxCalendarAgeFilter                     = "All";
            MaxDevicePasswordFailedAttempts          = "Unlimited";
            MaxEmailAgeFilter                        = "All";
            MaxEmailBodyTruncationSize               = "Unlimited";
            MaxEmailHTMLBodyTruncationSize           = "Unlimited";
            MaxInactivityTimeDeviceLock              = "Unlimited";
            MinDevicePasswordComplexCharacters       = 1;
            MinDevicePasswordLength                  = 1;
            Name                                     = "Test";
            PasswordRecoveryEnabled                  = $False;
            RequireDeviceEncryption                  = $False;
            RequireEncryptedSMIMEMessages            = $False;
            RequireEncryptionSMIMEAlgorithm          = "TripleDES";
            RequireManualSyncWhenRoaming             = $False;
            RequireSignedSMIMEAlgorithm              = "SHA1";
            RequireSignedSMIMEMessages               = $False;
            RequireStorageCardEncryption             = $False;
            UnapprovedInROMApplicationList           = @();
            UNCAccessEnabled                         = $True;
            WSSAccessEnabled                         = $True;
            Ensure               = "Present"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        EXOActiveSyncMailboxPolicy 'TestActiveSyncMailboxPolicy'
        {
            AllowApplePushNotifications              = $True;
            AllowBluetooth                           = "Allow";
            AllowBrowser                             = $True;
            AllowCamera                              = $False; #drift
            AllowConsumerEmail                       = $True;
            AllowDesktopSync                         = $True;
            AllowExternalDeviceManagement            = $False;
            AllowHTMLEmail                           = $True;
            AllowInternetSharing                     = $True;
            AllowIrDA                                = $True;
            AllowMobileOTAUpdate                     = $True;
            AllowNonProvisionableDevices             = $True;
            AllowPOPIMAPEmail                        = $True;
            AllowRemoteDesktop                       = $True;
            AllowSimpleDevicePassword                = $True;
            AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
            AllowSMIMESoftCerts                      = $True;
            AllowStorageCard                         = $True;
            AllowTextMessaging                       = $True;
            AllowUnsignedApplications                = $True;
            AllowUnsignedInstallationPackages        = $True;
            AllowWiFi                                = $True;
            AlphanumericDevicePasswordRequired       = $False;
            ApprovedApplicationList                  = @();
            AttachmentsEnabled                       = $True;
            DeviceEncryptionEnabled                  = $False;
            DevicePasswordEnabled                    = $False;
            DevicePasswordExpiration                 = "Unlimited";
            DevicePasswordHistory                    = 0;
            DevicePolicyRefreshInterval              = "Unlimited";
            Identity                                 = "Test";
            IrmEnabled                               = $True;
            IsDefault                                = $True;
            IsDefaultPolicy                          = $True;
            MaxAttachmentSize                        = "Unlimited";
            MaxCalendarAgeFilter                     = "All";
            MaxDevicePasswordFailedAttempts          = "Unlimited";
            MaxEmailAgeFilter                        = "All";
            MaxEmailBodyTruncationSize               = "Unlimited";
            MaxEmailHTMLBodyTruncationSize           = "Unlimited";
            MaxInactivityTimeDeviceLock              = "Unlimited";
            MinDevicePasswordComplexCharacters       = 1;
            MinDevicePasswordLength                  = 1;
            Name                                     = "Test";
            PasswordRecoveryEnabled                  = $False;
            RequireDeviceEncryption                  = $False;
            RequireEncryptedSMIMEMessages            = $False;
            RequireEncryptionSMIMEAlgorithm          = "TripleDES";
            RequireManualSyncWhenRoaming             = $False;
            RequireSignedSMIMEAlgorithm              = "SHA1";
            RequireSignedSMIMEMessages               = $False;
            RequireStorageCardEncryption             = $False;
            UnapprovedInROMApplicationList           = @();
            UNCAccessEnabled                         = $True;
            WSSAccessEnabled                         = $True;
            Ensure               = "Present"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        EXOActiveSyncMailboxPolicy 'TestActiveSyncMailboxPolicy'
        {
            AllowApplePushNotifications              = $True;
            AllowBluetooth                           = "Allow";
            AllowBrowser                             = $True;
            AllowCamera                              = $True;
            AllowConsumerEmail                       = $True;
            AllowDesktopSync                         = $True;
            AllowExternalDeviceManagement            = $False;
            AllowHTMLEmail                           = $True;
            AllowInternetSharing                     = $True;
            AllowIrDA                                = $True;
            AllowMobileOTAUpdate                     = $True;
            AllowNonProvisionableDevices             = $True;
            AllowPOPIMAPEmail                        = $True;
            AllowRemoteDesktop                       = $True;
            AllowSimpleDevicePassword                = $True;
            AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
            AllowSMIMESoftCerts                      = $True;
            AllowStorageCard                         = $True;
            AllowTextMessaging                       = $True;
            AllowUnsignedApplications                = $True;
            AllowUnsignedInstallationPackages        = $True;
            AllowWiFi                                = $True;
            AlphanumericDevicePasswordRequired       = $False;
            ApprovedApplicationList                  = @();
            AttachmentsEnabled                       = $True;
            DeviceEncryptionEnabled                  = $False;
            DevicePasswordEnabled                    = $False;
            DevicePasswordExpiration                 = "Unlimited";
            DevicePasswordHistory                    = 0;
            DevicePolicyRefreshInterval              = "Unlimited";
            Identity                                 = "Test";
            IrmEnabled                               = $True;
            IsDefault                                = $True;
            IsDefaultPolicy                          = $True;
            MaxAttachmentSize                        = "Unlimited";
            MaxCalendarAgeFilter                     = "All";
            MaxDevicePasswordFailedAttempts          = "Unlimited";
            MaxEmailAgeFilter                        = "All";
            MaxEmailBodyTruncationSize               = "Unlimited";
            MaxEmailHTMLBodyTruncationSize           = "Unlimited";
            MaxInactivityTimeDeviceLock              = "Unlimited";
            MinDevicePasswordComplexCharacters       = 1;
            MinDevicePasswordLength                  = 1;
            Name                                     = "Test";
            PasswordRecoveryEnabled                  = $False;
            RequireDeviceEncryption                  = $False;
            RequireEncryptedSMIMEMessages            = $False;
            RequireEncryptionSMIMEAlgorithm          = "TripleDES";
            RequireManualSyncWhenRoaming             = $False;
            RequireSignedSMIMEAlgorithm              = "SHA1";
            RequireSignedSMIMEMessages               = $False;
            RequireStorageCardEncryption             = $False;
            UnapprovedInROMApplicationList           = @();
            UNCAccessEnabled                         = $True;
            WSSAccessEnabled                         = $True;
            Ensure               = "Absent"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

