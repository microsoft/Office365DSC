# AADRemoteNetwork

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Name of the remote network. | |
| **Id** | Write | String | Id of the remote network | |
| **Region** | Write | String | Region | |
| **ForwardingProfiles** | Write | StringArray[] | List of the forwarding profile names associated to this remote network | |
| **DeviceLinks** | Write | MSFT_AADRemoteNetworkDeviceLink[] | Device Links associated to this remote network | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LocalIPAddress** | Write | String | LocalIpAddress. | |
| **PeerIPAddress** | Write | String | PeerIpAddress. | |
| **Asn** | Write | UInt32 | Asn. | |

### MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ZoneLocalIPAddress** | Write | String | ZoneLocalIpAddress. | |
| **RedundancyTier** | Write | String | RedundancyTier. | |

### MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **PreSharedKey** | Write | String | PreSharedKey | |
| **ZoneRedundancyPreSharedKey** | Write | String | ZoneRedundancyPreSharedKey | |
| **SaLifeTimeSeconds** | Write | UInt32 | SaLifeTimeSeconds | |
| **IPSecEncryption** | Write | String | IpSecEncryption | |
| **IPSecIntegrity** | Write | String | IpSecIntegrity | |
| **IKEEncryption** | Write | String | IkeEncryption | |
| **IKEIntegrity** | Write | String | IkeIntegrity | |
| **DHGroup** | Write | String | DhGroup | |
| **PFSGroup** | Write | String | PfsGroup | |
| **ODataType** | Write | String | ODataType | |

### MSFT_AADRemoteNetworkDeviceLink

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Name of the Device Link | |
| **IPAddress** | Write | String | IP Address | |
| **BandwidthCapacityInMbps** | Write | String | Bandwidth Capacity in Mbps | |
| **DeviceVendor** | Write | String | Device Vendor | |
| **BgpConfiguration** | Write | MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration | BgpConfiguration. | |
| **RedundancyConfiguration** | Write | MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration | redundancyConfiguration. | |
| **TunnelConfiguration** | Write | MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration | tunnelConfiguration | |


## Description

Use this resource to manage the Entra's Network Access Remote Networks, and related Device links.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

#### Application permissions

- **Read**

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            Ensure                = "Present";
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
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            Ensure                = "Present";
            ForwardingProfiles    = @(); #creating drift here
            Id                    = "c60c41bb-e512-48e3-8134-c312439a5343";
            Name                  = "Test Remote Network";
            Region                = "australiaSouthEast";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DeviceLinks           = @(
                MSFT_AADRemoteNetworkDeviceLink {
                    Name                    = 'Test Link Random' # creating drift here
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
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
```

