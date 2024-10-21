# IntunePolicySets

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Description of the PolicySet. | |
| **DisplayName** | Key | String | DisplayName of the PolicySet. | |
| **GuidedDeploymentTags** | Write | StringArray[] | Tags of the guided deployment | |
| **RoleScopeTags** | Write | StringArray[] | RoleScopeTags of the PolicySet | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Items** | Write | MSFT_DeviceManagementConfigurationPolicyItems[] | Represents the assignment to the Intune policy. | |
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

### MSFT_DeviceManagementConfigurationPolicyItems

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of policy the item represents. | |
| **payloadId** | Write | String | The group Id of the policy the item represents. | |
| **displayName** | Write | String | The collection display name of the policy the item represents | |
| **itemType** | Write | String | The type of policy the item represents. | |
| **guidedDeploymentTags** | Write | StringArray[] | Tags of the guided deployment | |


## Description

Intune Policy Sets

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
    Import-DscResource -ModuleName 'Microsoft365DSC'
    Node localhost
    {
        IntunePolicySets "Example"
        {
            Assignments          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '12345678-1234-1234-1234-1234567890ab'
                }
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.exclusionGroupAssignmentTarget'
                    groupId = '12345678-4321-4321-4321-1234567890ab'
                }
            );
            Description          = "Example";
            DisplayName          = "Example";
            Ensure               = "Present";
            GuidedDeploymentTags = @();
            Items                = @(
                MSFT_DeviceManagementConfigurationPolicyItems{
                    guidedDeploymentTags = @()
                    payloadId = 'T_12345678-90ab-90ab-90ab-1234567890ab'
                    displayName = 'Example-Policy'
                    dataType = '#microsoft.graph.managedAppProtectionPolicySetItem'
                    itemType = '#microsoft.graph.androidManagedAppProtection'
                }
            );
            RoleScopeTags        = @("0","1");
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
    Import-DscResource -ModuleName 'Microsoft365DSC'
    Node localhost
    {
        IntunePolicySets "Example"
        {
            Assignments          = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '12345678-1234-1234-1234-1234567890ab'
                }
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.exclusionGroupAssignmentTarget'
                    groupId = '12345678-4321-4321-4321-1234567890ab'
                }
            );
            Description          = "Example";
            DisplayName          = "Example";
            Ensure               = "Present";
            GuidedDeploymentTags = @();
            Items                = @(
                MSFT_DeviceManagementConfigurationPolicyItems{
                    guidedDeploymentTags = @()
                    payloadId = 'T_12345678-90ab-90ab-90ab-1234567890ab'
                    displayName = 'Example-Policy'
                    dataType = '#microsoft.graph.managedAppProtectionPolicySetItem'
                    itemType = '#microsoft.graph.androidManagedAppProtection'
                }
            );
            RoleScopeTags        = @("0","1","2"); # Updated Property
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
    Import-DscResource -ModuleName 'Microsoft365DSC'
    Node localhost
    {
        IntunePolicySets "Example"
        {
            DisplayName          = "Example";
            Ensure               = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
   }
}
```

