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
        SentinelThreatIntelligenceIndicator "SentinelThreatIntelligenceIndicator-ipv6-addr Indicator"
        {
            ApplicationId          = $ApplicationId;
            CertificateThumbprint  = $CertificateThumbprint;
            DisplayName            = "MyIndicator";
            Ensure                 = "Present";
            Labels                 = @("Tag1", "Tag2", "Tag3"); #Drift
            Pattern                = "[ipv6-addr:value = '2607:fa49:d340:f600:c8d5:6961:247f:a238']";
            PatternType            = "ipv6-addr";
            ResourceGroupName      = "MyResourceGroup";
            Source                 = "Microsoft Sentinel";
            SubscriptionId         = "12345-12345-12345-12345-12345";
            TenantId               = $TenantId;
            ThreatIntelligenceTags = @();
            ValidFrom              = "2024-10-21T19:03:57.24Z";
            ValidUntil             = "2024-10-21T19:03:57.24Z";
            WorkspaceName          = "SentinelWorkspace";
        }
    }
}
