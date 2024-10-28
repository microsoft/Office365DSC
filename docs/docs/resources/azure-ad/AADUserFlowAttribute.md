# AADUserFlowAttribute

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | User flow attribute Id. | |
| **DisplayName** | Key | String | Display name of the user flow attribute. | |
| **Description** | Write | String | Description of the user flow attribute. | |
| **DataType** | Write | String | Defines the user flow attribute data type. | |
| **Ensure** | Write | String | Specify if the Azure AD role setting should exist or not. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials for the Microsoft Graph delegated permissions. | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory application to authenticate with. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource configure User flow attributes which are custom attributes that you can define and use in your user flows, which are predefined, configurable policies that control the user experience during sign-up, sign-in, and profile editing processes.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - IdentityUserFlow.Read.All, IdentityUserFlow.ReadWrite.All

- **Update**

    - IdentityUserFlow.ReadWrite.All

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
        AADUserFlowAttribute 'SaiTest'
        {
            Id                 = "testIdSai"
            DisplayName        = "saitest"
            Description        = "sai test description"
            DataType           = "string"
            Ensure             = "Present"
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
        AADUserFlowAttribute 'SaiTest'
        {
            Id                 = "testIdSai"
            DisplayName        = "saitest"
            Description        = "sai test description"
            DataType           = "string"
            Ensure             = "Present"
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
        AADUserFlowAttribute 'SaiTest'
        {
            Id                 = "testIdSai"
            DisplayName        = "saitest"
            Ensure             = "Absent"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

