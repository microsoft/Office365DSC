# IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name for the profile. | |
| **Description** | Write | String | The description of the profile. | |
| **ExpeditedUpdateSettings** | Write | MSFT_MicrosoftGraphexpeditedWindowsQualityUpdateSettings | Expedited update settings. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Quality Update entity. | |
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

### MSFT_MicrosoftGraphExpeditedWindowsQualityUpdateSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DaysUntilForcedReboot** | Write | UInt32 | The number of days after installation that forced reboot will happen. Must be in range from 0 to 2. | |
| **QualityUpdateRelease** | Write | String | The release date to identify a quality update. Format is yyyy-MM-ddT00:00:00Z. | |


## Description

Intune Windows Update For Business Quality Update Profile for Windows10

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
        IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10 'Example'
        {
            Assignments             = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    groupDisplayName = 'Exclude'
                    dataType         = '#microsoft.graph.exclusionGroupAssignmentTarget'
                    groupId          = '258a1749-8408-4dd0-8028-fab6208a28d7'
                }
            );
            DisplayName              = 'Windows Quality Update'
            Description              = ''
            ExpeditedUpdateSettings = MSFT_MicrosoftGraphexpeditedWindowsQualityUpdateSettings{
                QualityUpdateRelease  = '2024-06-11T00:00:00Z'
                DaysUntilForcedReboot = 0
            }
            RoleScopeTagIds           = @("0")
            Ensure                    = 'Present'
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
        IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10 'Example'
        {
            Assignments             = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    groupDisplayName = 'Exclude'
                    dataType         = '#microsoft.graph.exclusionGroupAssignmentTarget'
                    groupId          = '258a1749-8408-4dd0-8028-fab6208a28d7'
                }
            );
            DisplayName              = 'Windows Quality Update'
            Description              = ''
            ExpeditedUpdateSettings = MSFT_MicrosoftGraphexpeditedWindowsQualityUpdateSettings{
                QualityUpdateRelease  = '2024-06-11T00:00:00Z'
                DaysUntilForcedReboot = 1 # Updated property
            }
            RoleScopeTagIds           = @("0")
            Ensure                    = 'Present'
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
        IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10 'Example'
        {
            DisplayName = 'Windows Quality Update'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

