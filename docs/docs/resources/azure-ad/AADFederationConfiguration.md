# AADFederationConfiguration

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name of the SAML/WS-Fed based identity provider. Inherited from identityProviderBase. | |
| **IssuerUri** | Write | String | Issuer URI of the federation server. Inherited from samlOrWsFedProvider. | |
| **MetadataExchangeUri** | Write | String | URI of the metadata exchange endpoint used for authentication from rich client applications. Inherited from samlOrWsFedProvider. | |
| **PassiveSignInUri** | Write | String | URI that web-based clients are directed to when signing in to Microsoft Entra services. Inherited from samlOrWsFedProvider. | |
| **PreferredAuthenticationProtocol** | Write | String | Preferred authentication protocol. The possible values are: wsFed, saml. Inherited from samlOrWsFedProvider. | |
| **SigningCertificate** | Write | String | Current certificate used to sign tokens passed to the Microsoft identity platform. The certificate is formatted as a Base64 encoded string of the public portion of the federated IdP's token signing certificate and must be compatible with the X509Certificate2 class. | |
| **Domains** | Write | StringArray[] | List of associated domains. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures federation in Entra Id.

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

    - Domain.Read.All

- **Update**

    - IdentityProvider.ReadWrite.All

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
        AADFederationConfiguration "MyFederation"
        {
            IssuerUri                       = 'https://contoso.com/issuerUri'
            DisplayName                     = 'contoso display name'
            MetadataExchangeUri             ='https://contoso.com/metadataExchangeUri'
            PassiveSignInUri                = 'https://contoso.com/signin'
            PreferredAuthenticationProtocol = 'wsFed'
            Domains                         = @('contoso.com')
            SigningCertificate              = 'MIIDADCCAeigAwIBAgIQEX41y8r6'
            Ensure                          = 'Present'
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            CertificateThumbprint           = $CertificateThumbprint
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
        AADFederationConfiguration "MyFederation"
        {
            IssuerUri                       = 'https://contoso.com/issuerUri'
            DisplayName                     = 'contoso display name'
            MetadataExchangeUri             ='https://contoso.com/metadataExchangeUri'
            PassiveSignInUri                = 'https://contoso.com/drift' # drift
            PreferredAuthenticationProtocol = 'wsFed'
            Domains                         = @('contoso.com')
            SigningCertificate              = 'MIIDADCCAeigAwIBAgIQEX41y8r6'
            Ensure                          = 'Present'
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            CertificateThumbprint           = $CertificateThumbprint
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
        AADFederationConfiguration "MyFederation"
        {
            IssuerUri                       = 'https://contoso.com/issuerUri'
            DisplayName                     = 'contoso display name'
            MetadataExchangeUri             ='https://contoso.com/metadataExchangeUri'
            PassiveSignInUri                = 'https://contoso.com/signin'
            PreferredAuthenticationProtocol = 'wsFed'
            Domains                         = @('contoso.com')
            SigningCertificate              = 'MIIDADCCAeigAwIBAgIQEX41y8r6'
            Ensure                          = 'Absent'
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            CertificateThumbprint           = $CertificateThumbprint
        }
    }
}
```

