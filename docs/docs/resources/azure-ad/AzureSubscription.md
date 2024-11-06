# AzureSubscription

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name of the subscription. | |
| **Id** | Write | String | The unique identifier of the subscription. | |
| **InvoiceSectionId** | Write | String | The unique identifier of the invoice section associated with the subscription. | |
| **Status** | Write | String | Status of the subscription. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource controls the properties of an Azure subscription.

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
        AzureSubscription "AzureSubscription-MySubscription"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            DisplayName           = "My Subscription";
            Ensure                = "Present";
            InvoiceSectionId      = "/providers/Microsoft.Billing/billingAccounts/0b32abd9-f0e6-4fc9-8b2f-404350313179:0b32abd9-f0e6-4fc9-8b2f-404350313179_2019-05-31/billingProfiles/OHZY-JSSA-BG7-M77W-XXX/invoiceSections/E6RO-KYS7-P2D-MAOR-SGB";
            Status                = "Active";
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
        AzureSubscription "AzureSubscription-MySubscription"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            DisplayName           = "My Subscription";
            Ensure                = "Present";
            InvoiceSectionId      = "/providers/Microsoft.Billing/billingAccounts/0b32abd9-f0e6-4fc9-8b2f-404350313179:0b32abd9-f0e6-4fc9-8b2f-404350313179_2019-05-31/billingProfiles/OHZY-JSSA-BG7-M77W-XXX/invoiceSections/E6RO-KYS7-P2D-MAOR-SGB";
            Status                = "Disabled"; #Drift
            TenantId              = $TenantId;
        }
    }
}
```

