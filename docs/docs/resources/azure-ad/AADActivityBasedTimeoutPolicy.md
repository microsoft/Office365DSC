# AADActivityBasedTimeoutPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name for this policy. Required. | |
| **Id** | Write | String | Id of the policy | |
| **AzurePortalTimeOut** | Write | String | Timeout value in hh:mm:ss for c44b4083-3bb0-49c1-b47d-974e53cbdf3c: applies the policy to the Azure portal. | |
| **DefaultTimeOut** | Write | String | Timeout value in hh:mm:ss for default: applies the policy to all applications that support activity-based timeout functionality but don't have application-specific override. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configure the Azure AD Activity Based Timeout Policy

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Policy.Read.All, Policy.Read.All

- **Update**

    - Policy.Read.All

#### Application permissions

- **Read**

    - Policy.Read.All, Policy.Read.All

- **Update**

    - Policy.Read.All

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
        AADActivityBasedTimeoutPolicy "AADActivityBasedTimeoutPolicy-displayName-value"
        {
            AzurePortalTimeOut    = "02:00:00";
            DefaultTimeOut        = "03:00:00";
            DisplayName           = "displayName-value";
            Ensure                = "Present";
            Id                    = "000000-0000-0000-0000-000000000000";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

