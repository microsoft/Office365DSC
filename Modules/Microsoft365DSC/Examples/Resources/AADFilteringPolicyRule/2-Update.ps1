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
        AADFilteringPolicyRule "AADFilteringPolicyRule-FQDN"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    value = 'contoso.com' #Drift
                }
            );
            Ensure                = "Present";
            Name                  = "MyFQDN";
            Policy                = "AMyPolicy";
            RuleType              = "fqdn";
            TenantId              = $TenantId;
        }
    }
}
