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
        AADFederationConfiguration "MyFederation"
        {
            IssuerUri                       = 'https://contoso.com/issuerUri'
            DisplayName                     = 'contoso display name'
            MetadataExchangeUri             ='https://contoso.com/metadataExchangeUri'
            PassiveSignInUri                = 'https://contoso.com/signin'
            PreferredAuthenticationProtocol = 'wsFed'
            Domains                         = @('contoso.com')
            SigningCertificate              = 'MIIDADCCAeigAwIBAgIQEX41y8r6'
            Ensure                          = 'Absent'
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            CertificateThumbprint           = $CertificateThumbprint
        }
    }
}
