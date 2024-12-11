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
        IntuneVPNConfigurationPolicyAndroidDeviceOwner "IntuneVPNConfigurationPolicyAndroidDeviceOwner-Example"
        {
            ApplicationId                           = $ApplicationId;
            TenantId                                = $TenantId;
            CertificateThumbprint                   = $CertificateThumbprint;
            Assignments                             = @();
            alwaysOn                                = $False;
            authenticationMethod                    = "azureAD";
            connectionName                          = "IntuneVPNConfigurationPolicyAndroidDeviceOwner ConnectionName";
            connectionType                          = "microsoftProtect";
            Description                             = "IntuneVPNConfigurationPolicyAndroidDeviceOwner Description";
            DisplayName                             = "IntuneVPNConfigurationPolicyAndroidDeviceOwner DisplayName";
            Ensure                                  = "Present";
            Id                                      = "12345678-1234-abcd-1234-12345678ABCD";
            customData                              = @(
                MSFT_CustomData{
                    key                             = 'fakeCustomData'
                    value                           = '[{"key":"fakestring1","type":"int","value":"1"},{"type":"int","key":"fakestring2","value":"0"}]'
                }
            );
            customKeyValueData                      = @(
                MSFT_customKeyValueData{
                    value                           = '[{"key":"fakestring1","type":"int","value":"1"},{"type":"int","key":"fakestring2","value":"0"}]'
                    name                            = 'fakeCustomKeyValueData'
                }
            );
            microsoftTunnelSiteId                   = "12345678-1234-abcd-1234-12345678ABCD";
            proxyExclusionList                      = @();
            proxyServer                             = @(
                MSFT_MicrosoftvpnProxyServer{
                    port                            = 8080
                    automaticConfigurationScriptUrl = ''
                    address                         = 'fake-proxy-adress.com'
                }
            );
            servers                                 = @(
                MSFT_MicrosoftGraphvpnServer{
                    isDefaultServer                 = $True
                    description                     = 'fakestringvalue'
                    address                         = 'fake.NEWserver.com:8080' #CHANGED VALUE
                }
            );
            targetedMobileApps                      = @(
                MSFT_targetedMobileApps{
                    name                            = 'fakestringvalue'
                    publisher                       = 'Fake Corporation'
                    appId                           = 'com.fake.emmx'
                }
            );
        }
    }
}
