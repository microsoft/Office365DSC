# AADHomeRealmDiscoveryPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name for this policy. Required. | |
| **Definition** | Write | MSFT_AADHomeRealDiscoveryPolicyDefinition[] | A string collection containing a complex object array that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required. | |
| **IsOrganizationDefault** | Write | Boolean | If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false. | |
| **Description** | Write | String | Description for this policy. Required. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADHomeRealDiscoveryPolicyDefinition

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AccelerateToFederatedDomain** | Write | Boolean | Accelerate to Federated Domain. | |
| **AllowCloudPasswordValidation** | Write | Boolean | Allow cloud password validation. | |
| **AlternateIdLogin** | Write | MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin | AlternateIdLogin complex object. | |
| **PreferredDomain** | Write | String | Preffered Domain value. | |

### MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Enabled** | Write | Boolean | Boolean for whether AlternateIdLogin is enabled. | |


## Description

Azure AD Home Realm Discovery Policy

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Policy.Read.All

- **Update**

    - Policy.ReadWrite.ApplicationConfiguration

#### Application permissions

- **Read**

    - Policy.Read.All

- **Update**

    - Policy.ReadWrite.ApplicationConfiguration

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
        AADHomeRealmDiscoveryPolicy "AADHomeRealmDiscoveryPolicy-displayName-value"
        {
            Definition            = @(
                MSFT_AADHomeRealDiscoveryPolicyDefinition {
                    PreferredDomain       = 'federated.example.edu'
                    AccelerateToFederatedDomain         = $False
                    AlternateIdLogin = MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin {
                        Enabled = $True
                    }
                }
            );
            DisplayName           = "displayName-value";
            Ensure                = "Present";
            IsOrganizationDefault = $False;
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        AADHomeRealmDiscoveryPolicy "AADHomeRealmDiscoveryPolicy-displayName-value"
        {
            Definition            = @(
                MSFT_AADHomeRealDiscoveryPolicyDefinition {
                    PreferredDomain       = 'federated.example.edu'
                    AccelerateToFederatedDomain         = $True # updating here
                    AlternateIdLogin = MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin {
                        Enabled = $True
                    }
                }
            );
            DisplayName           = "displayName-value";
            Ensure                = "Present";
            IsOrganizationDefault = $False;
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        AADHomeRealmDiscoveryPolicy "AADHomeRealmDiscoveryPolicy-displayName-value"
        {
            Definition            = @(
                MSFT_AADHomeRealDiscoveryPolicyDefinition {
                    PreferredDomain       = 'federated.example.edu'
                    AccelerateToFederatedDomain         = $False
                    AlternateIdLogin = MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin {
                        Enabled = $True
                    }
                }
            );
            DisplayName           = "displayName-value";
            Ensure                = "Absent";
            IsOrganizationDefault = $False;
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

