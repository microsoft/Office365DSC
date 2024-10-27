# AzureBillingaccountsRoleAssignment

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **PrincipalName** | Key | String | Name of the principal associated to the role assignment. | |
| **RoleDefinition** | Key | String | Name of the role assigned to the principal. | |
| **PrincipalType** | Write | String | Principal type. Can be User, Group or ServicePrincipal. | |
| **BillingAccount** | Write | String | Name of the billing account. | |
| **PrincipalTenantId** | Write | String | The principal tenant id of the user to whom the role was assigned. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Manages roles on billing accounts.

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
        AzureBillingAccountsRoleAssignment "AzureBillingAccountsRoleAssignment"
        {
            ApplicationId         = $ApplicationId;
            BillingAccount        = "MyTestAccount";
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Present";
            PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
            PrincipalType         = "User";
            PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
            RoleDefinition        = "Billing account owner";
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
        AzureBillingAccountsRoleAssignment "AzureBillingAccountsRoleAssignment"
        {
            ApplicationId         = $ApplicationId;
            BillingAccount        = "MyTestAccount";
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Present";
            PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
            PrincipalType         = "User";
            PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
            RoleDefinition        = "Billing account contributor";
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
        AzureBillingAccountsRoleAssignment "AzureBillingAccountsRoleAssignment"
        {
            ApplicationId         = $ApplicationId;
            BillingAccount        = "MyTestAccount";
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Absent";
            PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
            PrincipalType         = "User";
            PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
            RoleDefinition        = "Billing account owner";
            TenantId              = $TenantId;
        }
    }
}
```

