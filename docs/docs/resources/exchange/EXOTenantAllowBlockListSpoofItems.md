# EXOTenantAllowBlockListSpoofItems

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SpoofedUser** | Key | String | The SpoofedUser parameter specifies the email address or domain for the spoofed sender entry. | |
| **Action** | Write | String | The Action parameter specifies whether is an allowed or blocked spoofed sender entry. | |
| **Identity** | Write | String | Unique identified for the blocked item. | |
| **SendingInfrastructure** | Write | String | The SendingInfrastructure parameter specifies the source of the messages sent by the spoofed sender that's defined in the SpoofedUser parameter.. | |
| **SpoofType** | Write | String | The SpoofType parameter specifies whether this is an internal or external spoofed sender entry. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures blocked spoofed items in Exchange Online.

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
        EXOTenantAllowBlockListSpoofItems "EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71"
        {
            Action                = "Allow";
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Present";
            SendingInfrastructure = "121.0.0.7";
            SpoofedUser           = "contoso.com";
            SpoofType             = "Internal";
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
        EXOTenantAllowBlockListSpoofItems "EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71"
        {
            Action                = "Block"; #Drift
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Present";
            SendingInfrastructure = "121.0.0.7";
            SpoofedUser           = "contoso.com";
            SpoofType             = "Internal";
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
        EXOTenantAllowBlockListSpoofItems "EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71"
        {
            Action                = "Allow";
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Absent";
            SendingInfrastructure = "121.0.0.7";
            SpoofedUser           = "contoso.com";
            SpoofType             = "Internal";
            TenantId              = $TenantId;
        }
    }
}
```

