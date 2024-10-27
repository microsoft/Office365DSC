# IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name for the enrollment profile. | |
| **Id** | Write | String | Unique GUID for the enrollment profile. Read-Only. | |
| **AccountId** | Write | String | Intune AccountId GUID the enrollment profile belongs to. | |
| **Description** | Write | String | Description for the enrollment profile. | |
| **EnrollmentMode** | Write | String | The enrollment mode of devices that use this enrollment profile. | `corporateOwnedDedicatedDevice`, `corporateOwnedFullyManaged`, `corporateOwnedWorkProfile`, `corporateOwnedAOSPUserlessDevice`, `corporateOwnedAOSPUserAssociatedDevice` |
| **EnrollmentTokenType** | Write | String | The enrollment token type for an enrollment profile. | `default`, `corporateOwnedDedicatedDeviceWithAzureADSharedMode`, `deviceStaging` |
| **TokenValue** | Write | String | Value of the most recently created token for this enrollment profile. | |
| **TokenCreationDateTime** | Write | String | Date time the most recently created token was created. | |
| **TokenExpirationDateTime** | Write | String | Date time the most recently created token will expire. | |
| **EnrolledDeviceCount** | Write | UInt32 | Total number of Android devices that have enrolled using this enrollment profile. | |
| **EnrollmentTokenUsageCount** | Write | UInt32 | Total number of AOSP devices that have enrolled using the current token. Valid values 0 to 20000 | |
| **QrCodeContent** | Write | String | String used to generate a QR code for the token. | |
| **QrCodeImage** | Write | String | String used to generate a QR code for the token. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **ConfigureWifi** | Write | Boolean | Boolean that indicates that the Wi-Fi network should be configured during device provisioning. When set to TRUE, device provisioning will use Wi-Fi related properties to automatically connect to Wi-Fi networks. When set to FALSE or undefined, other Wi-Fi related properties will be ignored. Default value is TRUE. Returned by default. | |
| **WifiSsid** | Write | String | String that contains the wi-fi login ssid | |
| **WifiPassword** | Write | PSCredential | String that contains the wi-fi login password. The parameter is a PSCredential object. | |
| **WifiSecurityType** | Write | String | String that contains the wi-fi security type. | `none`, `wpa`, `wep` |
| **WifiHidden** | Write | Boolean | Boolean that indicates if hidden wifi networks are enabled | |
| **IsTeamsDeviceProfile** | Write | Boolean | Boolean indicating if this profile is an Android AOSP for Teams device profile. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfileQRImage

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **type** | Write | String | Indicates the content mime type. | |
| **value** | Write | String | The byte array that contains the actual content. | |

## Description

Enrollment Profile used to enroll Android Enterprise devices using Google's Cloud Management.

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
        IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile "IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile-MyTestEnrollmentProfile"
        {
            AccountId                 = "8d2ac1fd-0ac9-4047-af2f-f1e6323c9a34e";
            ApplicationId             = $ApplicationId;
            CertificateThumbprint     = $CertificateThumbprint;
            ConfigureWifi             = $True;
            Description               = "This is my enrollment profile";
            DisplayName               = "MyTestEnrollmentProfile";
            EnrolledDeviceCount       = 0;
            EnrollmentMode            = "corporateOwnedDedicatedDevice";
            EnrollmentTokenType       = "default";
            EnrollmentTokenUsageCount = 0;
            Ensure                    = "Present";
            IsTeamsDeviceProfile      = $False;
            RoleScopeTagIds           = @("0");
            TenantId                  = $TenantId;
            TokenCreationDateTime     = "10/26/2024 1:02:29 AM";
            TokenExpirationDateTime   = "10/31/2024 3:59:59 AM";
            WifiHidden                = $False;
            WifiSecurityType          = "none";
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
        IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile "IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile-MyTestEnrollmentProfile"
        {
            AccountId                 = "8d2ac1fd-0ac9-4047-af2f-f1e6323c9a34e";
            ApplicationId             = $ApplicationId;
            CertificateThumbprint     = $CertificateThumbprint;
            ConfigureWifi             = $True;
            Description               = "This is my enrollment profile";
            DisplayName               = "MyTestEnrollmentProfile";
            EnrolledDeviceCount       = 0;
            EnrollmentMode            = "corporateOwnedDedicatedDevice";
            EnrollmentTokenType       = "default";
            EnrollmentTokenUsageCount = 0;
            Ensure                    = "Present";
            IsTeamsDeviceProfile      = $False;
            RoleScopeTagIds           = @("0");
            TenantId                  = $TenantId;
            TokenCreationDateTime     = "10/26/2024 1:02:29 AM";
            TokenExpirationDateTime   = "10/31/2024 3:59:59 AM";
            WifiHidden                = $True; #Drift
            WifiSecurityType          = "none";
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
        IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile "IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile-MyTestEnrollmentProfile"
        {
            AccountId                 = "8d2ac1fd-0ac9-4047-af2f-f1e6323c9a34e";
            ApplicationId             = $ApplicationId;
            CertificateThumbprint     = $CertificateThumbprint;
            ConfigureWifi             = $True;
            Description               = "This is my enrollment profile";
            DisplayName               = "MyTestEnrollmentProfile";
            EnrolledDeviceCount       = 0;
            EnrollmentMode            = "corporateOwnedDedicatedDevice";
            EnrollmentTokenType       = "default";
            EnrollmentTokenUsageCount = 0;
            Ensure                    = "Absent";
            IsTeamsDeviceProfile      = $False;
            RoleScopeTagIds           = @("0");
            TenantId                  = $TenantId;
            TokenCreationDateTime     = "10/26/2024 1:02:29 AM";
            TokenExpirationDateTime   = "10/31/2024 3:59:59 AM";
            WifiHidden                = $False;
            WifiSecurityType          = "none";
        }
    }
}
```

