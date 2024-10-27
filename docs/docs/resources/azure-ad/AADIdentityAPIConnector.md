# AADIdentityAPIConnector

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Required | String | The name of the API connector. | |
| **TargetUrl** | Write | String | The URL of the API endpoint to call. | |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
| **Username** | Write | String | The username of the password | |
| **Password** | Write | PSCredential | The password of certificate/basic auth | |
| **Certificates** | Write | MSFT_AADIdentityAPIConnectionCertificate[] | List of certificates to be used in the API connector | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADIdentityAPIConnectionCertificate

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Pkcs12Value** | Write | PSCredential | Pkcs12Value of the certificate as a secure string in Base64 encoding | |
| **Thumbprint** | Write | String | Thumbprint of the certificate in Base64 encoding | |
| **Password** | Write | PSCredential | Password of the certificate as a secure string | |
| **IsActive** | Write | Boolean | Tells if the certificate is in use or not | |


## Description

Azure AD Identity API Connector

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
        AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
        {
            DisplayName           = "NewTestConnector";
            Id                    = "RestApi_NewTestConnector";
            Username              = "anexas";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
            TargetUrl             = "https://graph.microsoft.com";
            Ensure                = "Present"
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
        AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
        {
            DisplayName           = "NewTestConnector";
            Id                    = "RestApi_NewTestConnector";
            Username              = "anexas 1"; #drift
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
            TargetUrl             = "https://graph.microsoft.com";
            Ensure                = "Present"
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
        AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
        {
            DisplayName           = "NewTestConnector";
            Id                    = "RestApi_NewTestConnector";
            Username              = "anexas";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
            TargetUrl             = "https://graph.microsoft.com";
            Ensure                = "Absent"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

