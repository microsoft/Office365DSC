# AADVerifiedIdAuthority

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Name of the Verified ID Authority. | |
| **Id** | Write | String | Id of the Verified ID Authority. | |
| **LinkedDomainUrl** | Key | String | URL of the linked domain. | |
| **DidMethod** | Write | String | DID method used by the Verified ID Authority. | |
| **KeyVaultMetadata** | Write | MSFT_AADVerifiedIdAuthorityKeyVaultMetadata | Key Vault metadata for the Verified ID Authority. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADVerifiedIdAuthorityKeyVaultMetadata

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SubscriptionId** | Write | String | Subscription ID of the Key Vault. | |
| **ResourceGroup** | Write | String | Resource group of the Key Vault. | |
| **ResourceName** | Write | String | Resource name of the Key Vault. | |
| **ResourceUrl** | Write | String | Resource URL of the Key Vault. | |


## Description

Azure AD Verified Identity Authority
Use the VerifiableCredential.Authority.ReadWrite permission to read and write the authority.
Documentation Link: https://learn.microsoft.com/en-us/entra/verified-id/admin-api#authorities

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

    - None

- **Update**

    - None

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
        AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
        {
            DidMethod            = "web";
            Ensure               = "Present";
            KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                ResourceName = 'xtakeyvault'
                ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                ResourceGroup = 'TBD'
            };
            LinkedDomainUrl      = "https://nik-charlebois.com/";
            Name                 = "Contoso";
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
        AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
        {
            DidMethod            = "web";
            Ensure               = "Present";
            KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                ResourceName = 'xtakeyvault'
                ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                ResourceGroup = 'TBD'
            };
            LinkedDomainUrl      = "https://nik-charlebois.com/";
            Name                 = "Contoso 2"; # drift
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
        AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
        {
            DidMethod            = "web";
            Ensure               = "Absent";
            KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                ResourceName = 'xtakeyvault'
                ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                ResourceGroup = 'TBD'
            };
            LinkedDomainUrl      = "https://nik-charlebois.com/";
            Name                 = "Contoso";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

