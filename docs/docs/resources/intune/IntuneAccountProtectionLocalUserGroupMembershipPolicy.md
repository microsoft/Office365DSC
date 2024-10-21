# IntuneAccountProtectionLocalUserGroupMembershipPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Write | String | Identity of the account protection policy. | |
| **DisplayName** | Key | String | Display name of the account protection rules policy. | |
| **Description** | Write | String | Description of the account protection rules policy. | |
| **Assignments** | Write | MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments[] | Assignments of the Intune Policy. | |
| **LocalUserGroupCollection** | Write | MSFT_IntuneAccountProtectionLocalUserGroupCollection[] | Local User Group Collections of the Intune Policy. | |
| **Ensure** | Write | String | Present ensures the site collection exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_IntuneAccountProtectionLocalUserGroupCollection

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Action** | Write | String | The action to use for adding / removing members. | `add_update`, `remove_update`, `add_replace` |
| **LocalGroups** | Write | StringArray[] | The local groups to add / remove the members to / from. List of the following values: `administrators`, `users`, `guests`, `powerusers`, `remotedesktopusers`, `remotemanagementusers` | |
| **Members** | Write | StringArray[] | The members to add / remove to / from the group. For AzureAD Users, use the format `AzureAD\<UserPrincipalName>`. For groups, use the security identifier (SID). | |
| **UserSelectionType** | Write | String | The type of the selection. Either users / groups from AzureAD, or by manual identifier. | `users`, `manual` |


## Description

This resource configures a Intune Account Protection Local User Group Membership policy.


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
        IntuneAccountProtectionLocalUserGroupMembershipPolicy "My Account Protection Local User Group Membership Policy"
        {
            DisplayName              = "Account Protection LUGM Policy";
            Description              = "My revised description";
            Ensure                   = "Present";
            Assignments              = @(
                MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            LocalUserGroupCollection = @(
                MSFT_IntuneAccountProtectionLocalUserGroupCollection{
                    LocalGroups = @('administrators', 'users')
                    Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                    Action = 'add_update'
                    UserSelectionType = 'users'
                }
            );
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
        IntuneAccountProtectionLocalUserGroupMembershipPolicy "My Account Protection Local User Group Membership Policy"
        {
            DisplayName              = "Account Protection LUGM Policy";
            Description              = "My revised description";
            Ensure                   = "Present";
            Assignments              = @(); # Updated Property
            LocalUserGroupCollection = @(
                MSFT_IntuneAccountProtectionLocalUserGroupCollection{
                    LocalGroups = @('administrators', 'users')
                    Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                    Action = 'add_update'
                    UserSelectionType = 'users'
                }
            );
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
        IntuneAccountProtectionLocalUserGroupMembershipPolicy "My Account Protection Local User Group Membership Policy"
        {
            DisplayName              = "Account Protection LUGM Policy";
            Description              = "My revised description";
            Ensure                   = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

