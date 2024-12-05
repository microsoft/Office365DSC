# IntuneTrustedRootCertificateAndroidDeviceOwner

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Admin provided description of the Device Configuration. Inherited from managedDeviceMobileAppConfiguration | |
| **certFileName** | Write | String | File name to display in UI. | |
| **trustedRootCertificate** | Write | String | Trusted Root Certificate. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
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


## Description

This resource configures an Intune Android Device Owner Trusted Root Certificate Policy.

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

This example creates a new Intune Trusted Root Certificate Configuration Policy for Android Device Owner/Administrator devices

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
    Import-DscResource -ModuleName 'Microsoft365DSC'

    Node localhost
    {
        IntuneTrustedRootCertificateAndroidDeviceOwner "ConfigureIntuneTrustedRootCertificateAndroidDeviceOwner"
        {
            Description            = "IntuneTrustedRootCertificateAndroidDeviceOwner Description";
            DisplayName            = "IntuneTrustedRootCertificateAndroidDeviceOwner DisplayName";
            Ensure                 = "Present";
            certFileName           = "fakename.cer";
            trustedRootCertificate = "insertValidBase64StringHere";
            ApplicationId          = $ApplicationId;
            TenantId               = $TenantId;
            CertificateThumbprint  = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Intune Trusted Root Certificate Configuration Policy for Android Device Owner/Administrator devices

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
    Import-DscResource -ModuleName 'Microsoft365DSC'

    Node localhost
    {
        IntuneTrustedRootCertificateAndroidDeviceOwner "ConfigureIntuneTrustedRootCertificateAndroidDeviceOwner"
        {
            Description            = "IntuneTrustedRootCertificateAndroidDeviceOwner Description";
            DisplayName            = "IntuneTrustedRootCertificateAndroidDeviceOwner DisplayName";
            Ensure                 = "Present";
            certFileName           = "newfakename.cer"; #changed value
            trustedRootCertificate = "insertValidBase64StringHereForAnotherCert" #changed value
            ApplicationId          = $ApplicationId;
            TenantId               = $TenantId;
            CertificateThumbprint  = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Intune Trusted Root Certificate Configuration Policy for Android Device Owner/Administrator devices

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
    Import-DscResource -ModuleName 'Microsoft365DSC'

    Node localhost
    {
        IntuneTrustedRootCertificateAndroidDeviceOwner "ConfigureIntuneTrustedRootCertificateAndroidDeviceOwner"
        {
            Description            = "IntuneTrustedRootCertificateAndroidDeviceOwner Description";
            DisplayName            = "IntuneTrustedRootCertificateAndroidDeviceOwner DisplayName";
            Ensure                 = "Absent";
            ApplicationId          = $ApplicationId;
            TenantId               = $TenantId;
            CertificateThumbprint  = $CertificateThumbprint;
        }
    }
}
```

