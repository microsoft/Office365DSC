# IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Write | String | Identity of the account protection local administrator password solution policy. | |
| **DisplayName** | Key | String | Display name of the account protection local administrator password solution policy. | |
| **Description** | Write | String | Description of the account protection local administrator password solution policy. | |
| **Assignments** | Write | MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments[] | Assignments of the account protection local administrator password solution policy. | |
| **BackupDirectory** | Write | UInt32 | Configures which directory the local admin account password is backed up to. 0 - Disabled, 1 - Azure AD, 2 - AD | `0`, `1`, `2` |
| **PasswordAgeDays_AAD** | Write | UInt32 | Configures the maximum password age of the managed local administrator account for Azure AD. Minimum - 7, Maximum - 365 | |
| **PasswordAgeDays** | Write | UInt32 | Configures the maximum password age of the managed local administrator account for Active Directory. Minimum - 1, Maximum - 365 | |
| **PasswordExpirationProtectionEnabled** | Write | Boolean | Configures additional enforcement of maximum password age for the managed local administrator account. | |
| **AdEncryptedPasswordHistorySize** | Write | UInt32 | Configures how many previous encrypted passwords will be remembered in Active Directory. Minimum - 0, Maximum - 12 | |
| **AdPasswordEncryptionEnabled** | Write | Boolean | Configures whether the password is encrypted before being stored in Active Directory. | |
| **AdPasswordEncryptionPrincipal** | Write | String | Configures the name or SID of a user or group that can decrypt the password stored in Active Directory. | |
| **AdministratorAccountName** | Write | String | Configures the name of the managed local administrator account. | |
| **PasswordComplexity** | Write | UInt32 | Configures the password complexity of the managed local administrator account. 1 - Large letters, 2 - Large + small letters, 3 - Large + small letters + numbers, 4 - Large + small letters + numbers + special characters, 5 - Large letters + small letters + numbers + special characters (improved readability) | `1`, `2`, `3`, `4`, `5` |
| **PasswordLength** | Write | UInt32 | Configures the length of the password of the managed local administrator account. Minimum - 8, Maximum - 64 | |
| **PostAuthenticationActions** | Write | UInt32 | Specifies the actions to take upon expiration of the configured grace period. 1 - Reset password, 3 - Reset password and log off, 5 - Reset password and restart | `1`, `3`, `5` |
| **PostAuthenticationResetDelay** | Write | UInt32 | Specifies the amount of time (in hours) to wait after an authentication before executing the specified post-authentication actions. Minimum - 0, Maximum - 24 | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments

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

This resource configures an Intune Account Protection Local Administrator Password Solution Policy.

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
        IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy "My Account Protection LAPS Policy"
        {
            DisplayName              = "Account Protection LAPS Policy";
            Description              = "My revised description";
            Ensure                   = "Present";
            Assignments              = @(
                MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BackupDirectory          = "1";
            PasswordAgeDays_AAD      = 10;
            AdministratorAccountName = "Administrator";
            PasswordAgeDays          = 20;
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
        IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy "My Account Protection LAPS Policy"
        {
            DisplayName              = "Account Protection LAPS Policy";
            Description              = "My revised description";
            Ensure                   = "Present";
            Assignments              = @(
                MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BackupDirectory          = "1";
            PasswordAgeDays_AAD      = 15; # Updated Property
            AdministratorAccountName = "Administrator";
            PasswordAgeDays          = 20;
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
        IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy "My Account Protection LAPS Policy"
        {
            DisplayName              = "Account Protection LAPS Policy";
            Description              = "My revised description";
            Ensure                   = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

