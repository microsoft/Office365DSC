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
        IntuneVPNConfigurationPolicyIOS "IntuneVPNConfigurationPolicyIOS-Example"
        {
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
            Assignments            = @();
            associatedDomains      = @();
            authenticationMethod   = "usernameAndPassword";
            connectionName         = "IntuneVPNConfigurationPolicyIOS-ConnectionName";
            connectionType         = "ciscoAnyConnectV2";
            Description            = "IntuneVPNConfigurationPolicyIOS-Example Description";
            DisplayName            = "IntuneVPNConfigurationPolicyIOS-Example";
            enableSplitTunneling   = $False;
            Ensure                 = "Present";
            excludedDomains        = @();
            excludeList            = @();
            Id                     = "ec5432ff-d536-40cb-ba0a-e16260b01382";
            optInToDeviceIdSharing = $True;
            proxyServer            = @(
                MSFT_MicrosoftvpnProxyServer{
                    port = 80
                    automaticConfigurationScriptUrl = 'https://www.test.com'
                    address = 'proxy.test.com'
                }
            );
            safariDomains          = @();
            server                 = @(
                MSFT_MicrosoftGraphvpnServer{
                    isDefaultServer = $True
                    description = 'server'
                    address = 'vpn.test.com'
                }
            );
            targetedMobileApps     = @();
        }
    }
}
