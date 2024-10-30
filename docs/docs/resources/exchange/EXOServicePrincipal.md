# EXOServicePrincipal

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AppName** | Key | String | The AppName parameter specifies the corresponding friendly name of the unique AppId GUID value for the service principal. | |
| **DisplayName** | Write | String | The DisplayName parameter specifies the friendly name of the service principal. | |
| **Identity** | Write | String | The Identity parameter specifies the service principal that you want to view. | |
| **AppId** | Write | String | The AppId parameter specifies the unique AppId GUID value for the service principal. | |
| **Ensure** | Write | String | Present ensures the group exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Exchange Global Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

Use the ServicePrincipal cmdlets to create, change service principals in your cloud-based organization.

## Parameters

- Identity: The Identity parameter specifies the service principal that you want to modify. You can use any value that uniquely identifies the service principal. For example: Name, Distinguished name (DN), GUID, AppId, ObjectId
- AppName: The AppName parameter specifies the corresponding friendly name of the unique AppId GUID value for the service principal.
- DisplayName: The DisplayName parameter specifies the friendly name of the service principal. If the name contains spaces, enclose the name in quotation marks (").
- AppId: The AppId parameter specifies the unique AppId GUID value for the service principal.
- ObjectId: The ObjectId parameter specifies the unique ObjectId GUID value for the service principal.

## Examples

- Set-ServicePrincipal -Identity dc873ad4-0397-4d74-b5c0-897cd3a94731 -DisplayName "Another App Name"
- New-ServicePrincipal -AppId 71487acd-ec93-476d-bd0e-6c8b31831053 -ObjectId 6233fba6-0198-4277-892f-9275bf728bcc

## Parameters present in New and not in Set

- AppId
- ObjectId

## Parameters present in Set and not in New

- Identity

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
        EXOServicePrincipal 'ServicePrincipal'
        {
            AppId                = "c6871074-3ded-4935-a5dc-b8f8d91d7d06";
            AppName              = "ISV Portal";
            DisplayName          = "Arpita";
            Ensure               = "Present";
            Identity             = "00f6b0e4-1d00-427b-9a5b-ce6c43c43fc7";
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
        EXOServicePrincipal 'ServicePrincipal'
        {
            AppId                = "c6871074-3ded-4935-a5dc-b8f8d91d7d06";
            AppName              = "ISV Portal";
            DisplayName          = "Kartikeya";
            Ensure               = "Present";
            Identity             = "00f6b0e4-1d00-427b-9a5b-ce6c43c43fc7";
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
        EXOServicePrincipal 'ServicePrincipal'
        {
            AppId                = "c6871074-3ded-4935-a5dc-b8f8d91d7d06";
            AppName              = "ISV Portal";
            DisplayName          = "Arpita";
            Ensure               = "Absent";
            Identity             = "00f6b0e4-1d00-427b-9a5b-ce6c43c43fc7";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

