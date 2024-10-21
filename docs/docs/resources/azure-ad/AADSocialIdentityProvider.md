# AADSocialIdentityProvider

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ClientId** | Key | String | The client identifier for the application obtained when registering the application with the identity provider. | |
| **ClientSecret** | Write | String | The client secret for the application that is obtained when the application is registered with the identity provider. This is write-only. A read operation returns ****. | |
| **DisplayName** | Write | String | The display name of the identity provider. | |
| **IdentityProviderType** | Write | String | For a B2B scenario, possible values: Google, Facebook. For a B2C scenario, possible values: Microsoft, Google, Amazon, LinkedIn, Facebook, GitHub, Twitter, Weibo, QQ, WeChat. | `AADSignup`, `EmailOTP`, `Microsoft`, `MicrosoftAccount`, `Google`, `Amazon`, `LinkedIn`, `Facebook`, `GitHub`, `Twitter`, `Weibo`, `QQ`, `WeChat` |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


# AADIdentityProvider

## Description

Represents identity providers with External Identities for both Microsoft Entra ID and Azure AD B2C tenants. For Microsoft Entra B2B scenarios in a Microsoft Entra tenant, the identity provider type can be Google or Facebook.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - IdentityProvider.Read.All

- **Update**

    - IdentityProvider.ReadWrite.All

#### Application permissions

- **Read**

    - IdentityProvider.Read.All

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
        AADSocialIdentityProvider "AADSocialIdentityProvider-Google"
        {
            ClientId             = "Google-OAUTH";
            ClientSecret         = "FakeSecret";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DisplayName          = "My Google Provider";
            Ensure               = "Present";
            IdentityProviderType = "Google";
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
        AADSocialIdentityProvider "AADSocialIdentityProvider-Google"
        {
            ClientId             = "Google-OAUTH";
            ClientSecret         = "FakeSecret-Updated"; # Updated Property
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DisplayName          = "My Google Provider";
            Ensure               = "Present";
            IdentityProviderType = "Google";
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
        AADSocialIdentityProvider "AADSocialIdentityProvider-Google"
        {
            ClientId             = "Google-OAUTH";
            ClientSecret         = "FakeSecret-Updated"; # Updated Property
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DisplayName          = "My Google Provider";
            Ensure               = "Absent";
            IdentityProviderType = "Google";
        }
    }
}
```

