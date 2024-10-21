# AADDomain

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Key | String | Custom domain name. | |
| **AuthenticationType** | Write | String | Indicates the configured authentication type for the domain. The value is either Managed or Federated. Managed indicates a cloud managed domain where Microsoft Entra ID performs user authentication. Federated indicates authentication is federated with an identity provider such as the tenant's on-premises Active Directory via Active Directory Federation Services. | |
| **AvailabilityStatus** | Write | String | This property is always null except when the verify action is used. When the verify action is used, a domain entity is returned in the response. The availabilityStatus property of the domain entity in the response is either AvailableImmediately or EmailVerifiedDomainTakeoverScheduled. | |
| **IsAdminManaged** | Write | Boolean | The value of the property is false if the DNS record management of the domain is delegated to Microsoft 365. Otherwise, the value is true. Not nullable | |
| **IsDefault** | Write | Boolean | True if this is the default domain that is used for user creation. There's only one default domain per company. Not nullable. | |
| **IsRoot** | Write | Boolean | True if the domain is a verified root domain. Otherwise, false if the domain is a subdomain or unverified. Not nullable. | |
| **IsVerified** | Write | Boolean | True if the domain completed domain ownership verification. Not nullable. | |
| **PasswordNotificationWindowInDays** | Write | UInt32 | Specifies the number of days before a user receives notification that their password expires. If the property isn't set, a default value of 14 days is used. | |
| **PasswordValidityPeriodInDays** | Write | UInt32 | Specifies the length of time that a password is valid before it must be changed. If the property isn't set, a default value of 90 days is used. | |
| **SupportedServices** | Write | StringArray[] | The capabilities assigned to the domain. Can include 0, 1 or more of following values: Email, Sharepoint, EmailInternalRelayOnly, OfficeCommunicationsOnline, SharePointDefaultDomain, FullRedelegation, SharePointPublic, OrgIdAuthentication, Yammer, Intune. The values that you can add or remove using the API include: Email, OfficeCommunicationsOnline, Yammer. Not nullable. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory application to authenticate with. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures custom domain names in Entra Id.

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

    - Domain.ReadWrite.All

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
        AADDomain "AADDomain-Contoso"
        {
            ApplicationId                    = $ApplicationId;
            AuthenticationType               = "Managed";
            CertificateThumbprint            = $CertificateThumbprint;
            Ensure                           = "Present";
            Id                               = "contoso.com";
            IsAdminManaged                   = $True;
            IsDefault                        = $True;
            IsRoot                           = $True;
            IsVerified                       = $True;
            PasswordNotificationWindowInDays = 14;
            PasswordValidityPeriodInDays     = 2147483647;
            TenantId                         = $TenantId;
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
        AADDomain "AADDomain-Contoso"
        {
            ApplicationId                    = $ApplicationId;
            AuthenticationType               = "Managed";
            CertificateThumbprint            = $CertificateThumbprint;
            Ensure                           = "Present";
            Id                               = "contoso.com";
            IsAdminManaged                   = $True;
            IsDefault                        = $True;
            IsRoot                           = $True;
            IsVerified                       = $False; #Drift
            PasswordNotificationWindowInDays = 14;
            PasswordValidityPeriodInDays     = 2147483647;
            TenantId                         = $TenantId;
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
        AADDomain "AADDomain-Contoso"
        {
            ApplicationId                    = $ApplicationId;
            CertificateThumbprint            = $CertificateThumbprint;
            Ensure                           = "Absent";
            Id                               = "contoso.com";
            TenantId                         = $TenantId;
        }
    }
}
```

