# AADOrganizationCertificateBasedAuthConfiguration

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **CertificateAuthorities** | Write | MSFT_MicrosoftGraphcertificateAuthority[] | Collection of certificate authorities which creates a trusted certificate chain. | |
| **OrganizationId** | Key | String | The Organization ID. Read-only. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_MicrosoftGraphCertificateAuthority

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Certificate** | Write | String | Required. The base64 encoded string representing the public certificate. | |
| **CertificateRevocationListUrl** | Write | String | The URL of the certificate revocation list. | |
| **DeltaCertificateRevocationListUrl** | Write | String | The URL contains the list of all revoked certificates since the last time a full certificate revocaton list was created. | |
| **IsRootAuthority** | Write | Boolean | Required. true if the trusted certificate is a root authority, false if the trusted certificate is an intermediate authority. | |


## Description

Azure AD Organization Certificate Based Auth Configuration

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Organization.Read.All

- **Update**

    - None

#### Application permissions

- **Read**

    - Organization.Read.All

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
        AADOrganizationCertificateBasedAuthConfiguration "AADOrganizationCertificateBasedAuthConfiguration-58b6e58e-10d1-4b8c-845d-d6aefaaecba2"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            CertificateAuthorities = @(
                MSFT_MicrosoftGraphcertificateAuthority{
                    IsRootAuthority = $True
					DeltaCertificateRevocationListUrl = 'pqr.com'
                    Certificate = '<Base64 encoded cert>'
                }
                MSFT_MicrosoftGraphcertificateAuthority{
                    IsRootAuthority = $True
                    CertificateRevocationListUrl = 'xyz.com'
                    DeltaCertificateRevocationListUrl = 'pqr.com'
                    Certificate = '<Base64 encoded cert>'
                }
            );
            Ensure                 = "Present";
            OrganizationId         = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
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
        AADOrganizationCertificateBasedAuthConfiguration "AADOrganizationCertificateBasedAuthConfiguration-58b6e58e-10d1-4b8c-845d-d6aefaaecba2"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            Ensure                 = "Absent";
            OrganizationId         = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
        }
    }
}
```

