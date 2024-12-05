<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param
    (
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
        EXOTeamsProtectionPolicy 'EXOTeamsProtectionPolicy'
        {
            IsSingleInstance                 = 'Yes'
            AdminDisplayName                 = 'Contoso Administrator'
            HighConfidencePhishQuarantineTag = 'DefaultFullAccessPolicy'
            MalwareQuarantineTag             = 'AdminOnlyAccessPolicy'
            ZapEnabled                       = $true
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            CertificateThumbprint            = $CertificateThumbprint
        }
    }
}
