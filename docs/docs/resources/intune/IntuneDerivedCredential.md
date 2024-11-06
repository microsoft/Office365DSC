# IntuneDerivedCredential

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The name of the app category. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **HelpUrl** | Write | String | The URL that will be accessible to end users as they retrieve a derived credential using the Company Portal. | |
| **RenewalThresholdPercentage** | Write | UInt32 | The nominal percentage of time before certificate renewal is initiated by the client. | |
| **Issuer** | Write | String | Supported values for the derived credential issuer. | `intercede`, `entrustDatacard`, `purebred` |
| **NotificationType** | Write | String | Supported values for the notification type to use. | `none`, `email`, `companyPortal`, `companyPortal,email` |
| **Ensure** | Write | String | Supported values for the notification type to use. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

## Create new navigation property to derivedCredentials for deviceManagement for Intune.

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


```powershell
Configuration Example {
    param(
        [Parameter()]
        [System.String] $ApplicationId,

        [Parameter()]
        [System.String] $TenantId,

        [Parameter()]
        [System.String] $CertificateThumbprint
    )

    Import-DscResource -ModuleName Microsoft365DSC

    node localhost {
        IntuneDerivedCredential "IntuneDerivedCredential-K5"
        {
            DisplayName          = "K5";
            HelpUrl              = "http://www.ff.com/";
            Id                   = "a409d85f-2a49-440d-884a-80fb52a557ab";
            Issuer               = "purebred";
            NotificationType     = "email";
            Ensure               = "Present";
        }
    }
}
```

### Example 2


```powershell
Configuration Example {
    param(
        [Parameter()]
        [System.String] $ApplicationId,

        [Parameter()]
        [System.String] $TenantId,

        [Parameter()]
        [System.String] $CertificateThumbprint
    )

    Import-DscResource -ModuleName Microsoft365DSC

    node localhost {
        IntuneDerivedCredential "IntuneDerivedCredential-K5"
        {
            DisplayName          = "K5";
            HelpUrl              = "http://www.ff.com/";
            Id                   = "a409d85f-2a49-440d-884a-80fb52a557ab";
            Issuer               = "purebred";
            NotificationType     = "email";
            Ensure               = "Present";
        }
    }
}
```

### Example 3


```powershell
Configuration Example {
    param(
        [Parameter()]
        [System.String] $ApplicationId,

        [Parameter()]
        [System.String] $TenantId,

        [Parameter()]
        [System.String] $CertificateThumbprint
    )

    Import-DscResource -ModuleName Microsoft365DSC

    node localhost {
        IntuneDerivedCredential "IntuneDerivedCredential-K5"
        {
            DisplayName          = "K5";
            HelpUrl              = "http://www.ff.com/";
            Id                   = "a409d85f-2a49-440d-884a-80fb52a557ab";
            Issuer               = "purebred";
            NotificationType     = "email";
            Ensure               = "Absent";
        }
    }
}
```

