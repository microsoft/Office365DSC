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
        AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
        {
            DidMethod            = "web";
            Ensure               = "Present";
            KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                ResourceName = 'xtakeyvault'
                ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                ResourceGroup = 'TBD'
            };
            LinkedDomainUrl      = "https://nik-charlebois.com/";
            Name                 = "Contoso 2"; # drift
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
