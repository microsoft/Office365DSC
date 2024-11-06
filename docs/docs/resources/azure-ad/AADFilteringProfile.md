# AADFilteringProfile

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Profile name. | |
| **Id** | Write | String | Unique identifier for the profile. | |
| **Description** | Write | String | Description of the profile. | |
| **State** | Write | String | State of the profile. | |
| **Priority** | Write | UInt32 | Priority level for the profile. | |
| **Policies** | Write | MSFT_AADFilteringProfilePolicyLink[] | List of filtering policy names associated with the profile. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADFilteringProfilePolicyLink

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LoggingState** | Write | String | Logging state for the associated policy. | |
| **Priority** | Write | UInt32 | Priority of the associated policy. | |
| **State** | Write | String | State of the associated policy. | |
| **PolicyName** | Write | String | Name of the associated policy. | |


## Description

Configures filtering profiles in Entra Id.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - None

- **Update**

    - None

#### Application permissions

- **Read**

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

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
        AADFilteringProfile "AADFilteringProfile-My Profile"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Description of profile";
            Ensure                = "Present";
            Name                  = "My PRofile";
            Policies              = @(
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 100
                    LoggingState = 'enabled'
                    PolicyName = 'MyPolicyChoseBine'
                    State = 'enabled'
                }
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 200
                    LoggingState = 'enabled'
                    PolicyName = 'MyTopPolicy'
                    State = 'enabled'
                }
            );
            Priority              = 120;
            State                 = "enabled";
            TenantId              = $TenantId;
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
        AADFilteringProfile "AADFilteringProfile-My Profile"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Description of profile";
            Ensure                = "Present";
            Name                  = "My PRofile";
            Policies              = @(
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 100
                    LoggingState = 'enabled'
                    PolicyName = 'MyPolicyChoseBine'
                    State = 'enabled'
                }
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 200
                    LoggingState = 'enabled'
                    PolicyName = 'MyTopPolicy'
                    State = 'enabled'
                }
            );
            Priority              = 130; #Drift
            State                 = "enabled";
            TenantId              = $TenantId;
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
        AADFilteringProfile "AADFilteringProfile-My Profile"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Description of profile";
            Ensure                = "Absent";
            Name                  = "My PRofile";
            Policies              = @(
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 100
                    LoggingState = 'enabled'
                    PolicyName = 'MyPolicyChoseBine'
                    State = 'enabled'
                }
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 200
                    LoggingState = 'enabled'
                    PolicyName = 'MyTopPolicy'
                    State = 'enabled'
                }
            );
            Priority              = 120;
            State                 = "enabled";
            TenantId              = $TenantId;
        }
    }
}
```

