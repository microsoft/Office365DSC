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
        AADAuthenticationMethodPolicyExternal "AADAuthenticationMethodPolicyExternal-Cisco Duo"
        {
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            AppId                 = "e35c54ff-bd24-4c52-921a-4b90a35808eb";
            DisplayName           = "Cisco Duo";
            Ensure                = "Present";
            ExcludeTargets        = @(
                MSFT_AADAuthenticationMethodPolicyExternalExcludeTarget{
                    Id = 'Design'
                    TargetType = 'group'
                }
            );
            IncludeTargets        = @(
                MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget{
                    Id = 'Contoso'
                    TargetType = 'group'
                }
            );
            OpenIdConnectSetting  = MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting{
                discoveryUrl = 'https://graph.microsoft.com/'
                clientId = '7698a352-4939-486e-9974-4ea5aff93f74'
            };
            State                 = "disabled";
        }
    }
}
