# AzureBillingAccountsAssociatedTenant

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AssociatedTenantId** | Key | String | The ID that uniquely identifies a tenant. | |
| **DisplayName** | Write | String | The name of the associated tenant. | |
| **BillingAccount** | Write | String | Name of the billing account. | |
| **BillingManagementState** | Write | String | The state determines whether users from the associated tenant can be assigned roles for commerce activities like viewing and downloading invoices, managing payments, and making purchases. | |
| **ProvisioningManagementState** | Write | String | The state determines whether subscriptions and licenses can be provisioned in the associated tenant. It can be set to 'Pending' to initiate a billing request. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures associated tenants to billing accounts in the Microsoft Admin Center.

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
        AzureBillingAccountsAssociatedTenant "AzureBillingAccountsAssociatedTenantIntegration Tenant"
        {
            ApplicationId               = $ApplicationId;
            AssociatedTenantId          = "7a575036-2dac-4713-8e23-2963cc2c5f37";
            BillingAccount              = "My Test Account";
            BillingManagementState      = "Active";
            CertificateThumbprint       = $CertificateThumbprint;
            DisplayName                 = "Integration Tenant";
            Ensure                      = "Present";
            ProvisioningManagementState = "Pending";
            TenantId                    = $TenantId;
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
        AzureBillingAccountsAssociatedTenant "AzureBillingAccountsAssociatedTenantIntegration Tenant"
        {
            ApplicationId               = $ApplicationId;
            AssociatedTenantId          = "7a575036-2dac-4713-8e23-2963cc2c5f37";
            BillingAccount              = "My Test Account";
            BillingManagementState      = "NotAllowed"; # Drift
            CertificateThumbprint       = $CertificateThumbprint;
            DisplayName                 = "Integration Tenant";
            Ensure                      = "Present";
            ProvisioningManagementState = "Pending";
            TenantId                    = $TenantId;
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
        AzureBillingAccountsAssociatedTenant "AzureBillingAccountsAssociatedTenantIntegration Tenant"
        {
            ApplicationId               = $ApplicationId;
            AssociatedTenantId          = "7a575036-2dac-4713-8e23-2963cc2c5f37";
            BillingAccount              = "My Test Account";
            BillingManagementState      = "Active";
            CertificateThumbprint       = $CertificateThumbprint;
            DisplayName                 = "Integration Tenant";
            Ensure                      = "Absent";
            ProvisioningManagementState = "Pending";
            TenantId                    = $TenantId;
        }
    }
}
```

