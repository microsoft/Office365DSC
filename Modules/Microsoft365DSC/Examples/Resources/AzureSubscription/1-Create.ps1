<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

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
