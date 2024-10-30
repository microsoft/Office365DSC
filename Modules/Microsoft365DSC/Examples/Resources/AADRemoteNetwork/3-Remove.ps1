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
        AADRemoteNetwork "AADRemoteNetwork-Test Remote Network"
        {
            Ensure                = "Absent";
            ForwardingProfiles    = @("Microsoft 365 traffic forwarding profile");
            Id                    = "c60c41bb-e512-48e3-8134-c312439a5343";
            Name                  = "Test Remote Network";
            Region                = "australiaSouthEast";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DeviceLinks           = @(
                MSFT_AADRemoteNetworkDeviceLink {
                    Name                    = 'Test Link'
                    IPAddress               = '1.1.1.1'
                    BandwidthCapacityInMbps = 'mbps500'
                    DeviceVendor            = 'ciscoCatalyst'
                    BgpConfiguration        = MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration {
                        Asn                 = 82
                        LocalIPAddress      = '1.1.1.87'
                        PeerIPAddress       = '1.1.1.2'
                    }
                    RedundancyConfiguration = MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration {
                        RedundancyTier      = 'zoneRedundancy'
                        ZoneLocalIPAddress  = '1.1.1.8'
                    }
                    TunnelConfiguration     = MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration {
                        PreSharedKey               = 'blah'
                        ZoneRedundancyPreSharedKey = 'blah'
                        SaLifeTimeSeconds          = 300
                        IPSecEncryption            = 'gcmAes192'
                        IPSecIntegrity             = 'gcmAes192'
                        IKEEncryption              = 'aes192'
                        IKEIntegrity               = 'gcmAes128'
                        DHGroup                    = 'ecp256'
                        PFSGroup                   = 'pfsmm'
                        ODataType                  = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Custom'
                    }
                }
            );
        }
    }
}
