# IntuneDiskEncryptionMacOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | The user given description | |
| **DisplayName** | Key | String | Display name of the disk encryption file vault policy for MacOS | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Enabled** | Write | Boolean | If not already enabled, FileVault will be enabled at the next logout. | |
| **PersonalRecoveryKeyRotationInMonths** | Write | UInt32 | Specify how frequently in months (1-12) the device's personal recovery key will rotate. Range: 1-12 | |
| **DisablePromptAtSignOut** | Write | Boolean | Disable the prompt for the user to enable FileVault when they sign out. | |
| **SelectedRecoveryKeyTypes** | Write | StringArray[] | Determine which type(s) of recovery key should be generated for this device. Only supported value is 'personalRecoveryKey'. Required, if Enabled is True. | |
| **AllowDeferralUntilSignOut** | Write | Boolean | Defer the prompt until the user signs out. Only True is supported. | |
| **NumberOfTimesUserCanIgnore** | Write | SInt32 | Number of times allowed to bypass (1-10). Special cases: -1 = Not Configured, 11 = No limit, always prompt.  | |
| **HidePersonalRecoveryKey** | Write | Boolean | Hide recovery key. | |
| **PersonalRecoveryKeyHelpMessage** | Write | String | Escrow location description of personal recovery key. Required, if Enabled is True. | |
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


## Description

Intune Disk Encryption for macOS

Please note: Once the FileVault requirement is enabled, it cannot be disabled. To disable the requirement, the policy has to be deleted.

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
        IntuneDiskEncryptionMacOS "IntuneDiskEncryptionMacOS"
        {
            AllowDeferralUntilSignOut           = $True;
            Assignments                         = @();
            Description                         = "test";
            DisplayName                         = "test";
            Enabled                             = $True;
            Ensure                              = "Present";
            NumberOfTimesUserCanIgnore          = -1;
            PersonalRecoveryKeyHelpMessage      = "eeee";
            PersonalRecoveryKeyRotationInMonths = 2;
            RoleScopeTagIds                     = @("0");
            SelectedRecoveryKeyTypes            = @("personalRecoveryKey");
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
        IntuneDiskEncryptionMacOS "IntuneDiskEncryptionMacOS"
        {
            AllowDeferralUntilSignOut           = $True;
            Assignments                         = @();
            Description                         = "test";
            DisplayName                         = "test";
            Enabled                             = $True;
            Ensure                              = "Present";
            NumberOfTimesUserCanIgnore          = -1;
            PersonalRecoveryKeyHelpMessage      = "eeee";
            PersonalRecoveryKeyRotationInMonths = 3; # Updated property
            RoleScopeTagIds                     = @("0");
            SelectedRecoveryKeyTypes            = @("personalRecoveryKey");
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
        IntuneDiskEncryptionMacOS 'IntuneDiskEncryptionMacOS'
        {
            DisplayName = 'test'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

