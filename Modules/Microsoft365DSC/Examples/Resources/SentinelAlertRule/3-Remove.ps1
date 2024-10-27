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
        SentinelAlertRule "SentinelAlertRule-MyNRTRule"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Test";
            DisplayName           = "MyNRTRule";
            Ensure                = "Absent";
            ResourceGroupName     = "ResourceGroupName";
            Severity              = "Medium";
            SubscriptionId        = "xxxx";
            TenantId              = $TenantId;
            WorkspaceName         = "SentinelWorkspace";
        }
    }
}
