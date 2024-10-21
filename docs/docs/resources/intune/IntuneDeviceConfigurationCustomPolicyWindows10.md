# IntuneDeviceConfigurationCustomPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **OmaSettings** | Write | MSFT_MicrosoftGraphomaSetting[] | OMA settings. This collection can contain a maximum of 1000 elements. | |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
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

### MSFT_MicrosoftGraphOmaSetting

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Description. | |
| **DisplayName** | Write | String | Display Name. | |
| **IsEncrypted** | Write | Boolean | Indicates whether the value field is encrypted. This property is read-only. | |
| **OmaUri** | Write | String | OMA. | |
| **SecretReferenceValueId** | Write | String | ReferenceId for looking up secret for decryption. This property is read-only. | |
| **FileName** | Write | String | File name associated with the Value property (.cer) | |
| **Value** | Write | String | Value. (Base64 encoded string) | |
| **IsReadOnly** | Write | Boolean | By setting to true, the CSP (configuration service provider) specified in the OMA-URI will perform a get, instead of set | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.omaSettingBase64`, `#microsoft.graph.omaSettingBoolean`, `#microsoft.graph.omaSettingDateTime`, `#microsoft.graph.omaSettingFloatingPoint`, `#microsoft.graph.omaSettingInteger`, `#microsoft.graph.omaSettingString`, `#microsoft.graph.omaSettingStringXml` |


## Description

Intune Device Configuration Custom Policy for Windows10

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

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
        IntuneDeviceConfigurationCustomPolicyWindows10 'Example'
        {
            Assignments          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName          = "custom";
            Ensure               = "Present";
            OmaSettings          = @(
                MSFT_MicrosoftGraphomaSetting{
                    Description = 'custom'
                    OmaUri = '/oma/custom'
                    odataType = '#microsoft.graph.omaSettingString'
                    SecretReferenceValueId = '5b0e1dba-4523-455e-9fdd-e36c833b57bf_e072d616-12bc-4ea3-9171-ab080e4c120d_1f958162-15d4-42ba-92c4-17c2544b2179'
                    Value = '****'
                    IsEncrypted = $True
                    DisplayName = 'oma'
                }
                MSFT_MicrosoftGraphomaSetting{
                    Description = 'custom 2'
                    OmaUri = '/oma/custom2'
                    odataType = '#microsoft.graph.omaSettingInteger'
                    Value = 2
                    IsReadOnly = $False
                    IsEncrypted = $False
                    DisplayName = 'custom 2'
                }
            );
            SupportsScopeTags    = $True;
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
        IntuneDeviceConfigurationCustomPolicyWindows10 'Example'
        {
            Assignments          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName          = "custom";
            Ensure               = "Present";
            OmaSettings          = @(
                MSFT_MicrosoftGraphomaSetting{
                    Description = 'custom'
                    OmaUri = '/oma/custom'
                    odataType = '#microsoft.graph.omaSettingString'
                    SecretReferenceValueId = '5b0e1dba-4523-455e-9fdd-e36c833b57bf_e072d616-12bc-4ea3-9171-ab080e4c120d_1f958162-15d4-42ba-92c4-17c2544b2179'
                    Value = '****'
                    IsEncrypted = $True
                    DisplayName = 'oma'
                }
                MSFT_MicrosoftGraphomaSetting{ # Updated Property
                    Description = 'custom 3'
                    OmaUri = '/oma/custom3'
                    odataType = '#microsoft.graph.omaSettingInteger'
                    Value = 2
                    IsReadOnly = $False
                    IsEncrypted = $False
                    DisplayName = 'custom 3'
                }
            );
            SupportsScopeTags    = $True;
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
        IntuneDeviceConfigurationCustomPolicyWindows10 'Example'
        {
            DisplayName          = "custom";
            Ensure               = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

