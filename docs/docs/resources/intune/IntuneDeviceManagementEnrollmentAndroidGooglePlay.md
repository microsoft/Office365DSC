# IntuneDeviceManagementEnrollmentAndroidGooglePlay

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Key | String | Primary key identifier of the Android Managed Store Account Enterprise Setting. | |
| **BindStatus** | Write | String | Binding status of the Android Managed Store Account Enterprise Setting (e.g., 'bound', 'notBound'). | |
| **OwnerUserPrincipalName** | Write | String | The user principal name of the owner of the Android Managed Store Account. | |
| **OwnerOrganizationName** | Write | String | The organization name of the owner of the Android Managed Store Account. | |
| **EnrollmentTarget** | Write | String | Specifies the enrollment target for the account enterprise setting (e.g., 'defaultEnrollmentRestrictions', 'targetedAsEnrollmentRestrictions'). | |
| **DeviceOwnerManagementEnabled** | Write | Boolean | Specifies whether device owner management is enabled. | |
| **AndroidDeviceOwnerFullyManagedEnrollmentEnabled** | Write | Boolean | Specifies whether fully managed enrollment is enabled for Android devices. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin. | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Credential for the application secret used in authentication. | |
| **ManagedIdentity** | Write | Boolean | Indicates whether a Managed Identity is used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access tokens used for authentication in scenarios requiring multiple tokens. | |


## Description

This resource configures Android Enterprise enrollment settings for device management within Microsoft Intune.
Note: Currently the bind API to enroll is waiting for the product team to make changes so the API can be called outside of an Intune portal. Until those changes are made, we can only unbind (disconnect/unenroll). For that reason we have commented out certain parameters that cannot be set. This will be uncommented once those changes are made.

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
        IntuneDeviceManagementEnrollmentAndroidGooglePlay "RemoveAndroidGooglePlayEnrollment"
        {
            Id                    = "androidManagedStoreAccountEnterpriseSettings"
            Ensure                = "Absent"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

