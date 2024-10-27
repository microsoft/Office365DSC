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
        AADCustomAuthenticationExtension "AADCustomAuthenticationExtension1"
        {
            AuthenticationConfigurationResourceId  = "api://microsoft365dsc.com/11105949-846e-42a1-a873-f12db8345013"
            AuthenticationConfigurationType        = "#microsoft.graph.azureAdTokenAuthentication"
            ClaimsForTokenConfiguration            = @(
                MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration{
                    ClaimIdInApiResponse = 'MyClaim'
                }
                MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration{
                    ClaimIdInApiResponse = 'My2ndClaim'
                }
            )
            ClientConfigurationMaximumRetries      = 1
            ClientConfigurationTimeoutMilliseconds = 2000
            CustomAuthenticationExtensionType      = "#microsoft.graph.onTokenIssuanceStartCustomExtension"
            Description                            = "DSC Testing 1"
            DisplayName                            = "DSCTestExtension"
            EndPointConfiguration                  = MSFT_AADCustomAuthenticationExtensionEndPointConfiguration{
                EndpointType = '#microsoft.graph.httpRequestEndpoint'
                TargetUrl = 'https://Microsoft365DSC.com'
            }
            Ensure                                 = "Present";
            Id                                     = "11105949-846e-42a1-a873-f12db8345013"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
