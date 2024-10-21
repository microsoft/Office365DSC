# IntuneDeviceConfigurationVpnPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AssociatedApps** | Write | MSFT_MicrosoftGraphwindows10AssociatedApps[] | Associated Apps. This collection can contain a maximum of 10000 elements. | |
| **AuthenticationMethod** | Write | String | Authentication method. Possible values are: certificate, usernameAndPassword, customEapXml, derivedCredential. | `certificate`, `usernameAndPassword`, `customEapXml`, `derivedCredential` |
| **ConnectionType** | Write | String | Connection type. Possible values are: pulseSecure, f5EdgeClient, dellSonicWallMobileConnect, checkPointCapsuleVpn, automatic, ikEv2, l2tp, pptp, citrix, paloAltoGlobalProtect, ciscoAnyConnect, unknownFutureValue, microsoftTunnel. | `pulseSecure`, `f5EdgeClient`, `dellSonicWallMobileConnect`, `checkPointCapsuleVpn`, `automatic`, `ikEv2`, `l2tp`, `pptp`, `citrix`, `paloAltoGlobalProtect`, `ciscoAnyConnect`, `unknownFutureValue`, `microsoftTunnel` |
| **CryptographySuite** | Write | MSFT_MicrosoftGraphcryptographySuite | Cryptography Suite security settings for IKEv2 VPN in Windows10 and above | |
| **DnsRules** | Write | MSFT_MicrosoftGraphvpnDnsRule[] | DNS rules. This collection can contain a maximum of 1000 elements. | |
| **DnsSuffixes** | Write | StringArray[] | Specify DNS suffixes to add to the DNS search list to properly route short names. | |
| **EapXml** | Write | String | Extensible Authentication Protocol (EAP) XML. (UTF8 encoded byte array) | |
| **EnableAlwaysOn** | Write | Boolean | Enable Always On mode. | |
| **EnableConditionalAccess** | Write | Boolean | Enable conditional access. | |
| **EnableDeviceTunnel** | Write | Boolean | Enable device tunnel. | |
| **EnableDnsRegistration** | Write | Boolean | Enable IP address registration with internal DNS. | |
| **EnableSingleSignOnWithAlternateCertificate** | Write | Boolean | Enable single sign-on (SSO) with alternate certificate. | |
| **EnableSplitTunneling** | Write | Boolean | Enable split tunneling. | |
| **MicrosoftTunnelSiteId** | Write | String | ID of the Microsoft Tunnel site associated with the VPN profile. | |
| **OnlyAssociatedAppsCanUseConnection** | Write | Boolean | Only associated Apps can use connection (per-app VPN). | |
| **ProfileTarget** | Write | String | Profile target type. Possible values are: user, device, autoPilotDevice. | `user`, `device`, `autoPilotDevice` |
| **ProxyServer** | Write | MSFT_MicrosoftGraphwindows10VpnProxyServer | Proxy Server. | |
| **RememberUserCredentials** | Write | Boolean | Remember user credentials. | |
| **Routes** | Write | MSFT_MicrosoftGraphvpnRoute[] | Routes (optional for third-party providers). This collection can contain a maximum of 1000 elements. | |
| **SingleSignOnEku** | Write | MSFT_MicrosoftGraphextendedKeyUsage | Single sign-on Extended Key Usage (EKU). | |
| **SingleSignOnIssuerHash** | Write | String | Single sign-on issuer hash. | |
| **TrafficRules** | Write | MSFT_MicrosoftGraphvpnTrafficRule[] | Traffic rules. This collection can contain a maximum of 1000 elements. | |
| **TrustedNetworkDomains** | Write | StringArray[] | Trusted Network Domains | |
| **WindowsInformationProtectionDomain** | Write | String | Windows Information Protection (WIP) domain to associate with this connection. | |
| **ConnectionName** | Write | String | Connection name displayed to the user. | |
| **CustomXml** | Write | String | Custom XML commands that configures the VPN connection. (UTF8 encoded byte array) | |
| **ServerCollection** | Write | MSFT_MicrosoftGraphvpnServer[] | List of VPN Servers on the network. Make sure end users can access these network locations. This collection can contain a maximum of 500 elements. | |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_DeviceManagementConfigurationPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_MicrosoftGraphWindows10AssociatedApps

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AppType** | Write | String | Application type. Possible values are: desktop, universal. | `desktop`, `universal` |
| **Identifier** | Write | String | Identifier. | |

### MSFT_MicrosoftGraphCryptographySuite

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AuthenticationTransformConstants** | Write | String | Authentication Transform Constants. Possible values are: md5_96, sha1_96, sha_256_128, aes128Gcm, aes192Gcm, aes256Gcm. | `md5_96`, `sha1_96`, `sha_256_128`, `aes128Gcm`, `aes192Gcm`, `aes256Gcm` |
| **CipherTransformConstants** | Write | String | Cipher Transform Constants. Possible values are: aes256, des, tripleDes, aes128, aes128Gcm, aes256Gcm, aes192, aes192Gcm, chaCha20Poly1305. | `aes256`, `des`, `tripleDes`, `aes128`, `aes128Gcm`, `aes256Gcm`, `aes192`, `aes192Gcm`, `chaCha20Poly1305` |
| **DhGroup** | Write | String | Diffie Hellman Group. Possible values are: group1, group2, group14, ecp256, ecp384, group24. | `group1`, `group2`, `group14`, `ecp256`, `ecp384`, `group24` |
| **EncryptionMethod** | Write | String | Encryption Method. Possible values are: aes256, des, tripleDes, aes128, aes128Gcm, aes256Gcm, aes192, aes192Gcm, chaCha20Poly1305. | `aes256`, `des`, `tripleDes`, `aes128`, `aes128Gcm`, `aes256Gcm`, `aes192`, `aes192Gcm`, `chaCha20Poly1305` |
| **IntegrityCheckMethod** | Write | String | Integrity Check Method. Possible values are: sha2_256, sha1_96, sha1_160, sha2_384, sha2_512, md5. | `sha2_256`, `sha1_96`, `sha1_160`, `sha2_384`, `sha2_512`, `md5` |
| **PfsGroup** | Write | String | Perfect Forward Secrecy Group. Possible values are: pfs1, pfs2, pfs2048, ecp256, ecp384, pfsMM, pfs24. | `pfs1`, `pfs2`, `pfs2048`, `ecp256`, `ecp384`, `pfsMM`, `pfs24` |

### MSFT_MicrosoftGraphVpnDnsRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AutoTrigger** | Write | Boolean | Automatically connect to the VPN when the device connects to this domain: Default False. | |
| **Name** | Write | String | Name. | |
| **Persistent** | Write | Boolean | Keep this rule active even when the VPN is not connected: Default False | |
| **ProxyServerUri** | Write | String | Proxy Server Uri. | |
| **Servers** | Write | StringArray[] | Servers. | |

### MSFT_MicrosoftGraphWindows10VpnProxyServer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BypassProxyServerForLocalAddress** | Write | Boolean | Bypass proxy server for local address. | |
| **Address** | Write | String | Address. | |
| **AutomaticConfigurationScriptUrl** | Write | String | Proxy's automatic configuration script url. | |
| **Port** | Write | UInt32 | Port. Valid values 0 to 65535 | |
| **AutomaticallyDetectProxySettings** | Write | Boolean | Automatically detect proxy settings. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.windows10VpnProxyServer`, `#microsoft.graph.windows81VpnProxyServer` |

### MSFT_MicrosoftGraphVpnRoute

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DestinationPrefix** | Write | String | Destination prefix (IPv4/v6 address). | |
| **PrefixSize** | Write | UInt32 | Prefix size. (1-32). Valid values 1 to 32 | |

### MSFT_MicrosoftGraphExtendedKeyUsage

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Extended Key Usage Name | |
| **ObjectIdentifier** | Write | String | Extended Key Usage Object Identifier | |

### MSFT_MicrosoftGraphVpnTrafficRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AppId** | Write | String | App identifier, if this traffic rule is triggered by an app. | |
| **AppType** | Write | String | App type, if this traffic rule is triggered by an app. Possible values are: none, desktop, universal. | `none`, `desktop`, `universal` |
| **Claims** | Write | String | Claims associated with this traffic rule. | |
| **LocalAddressRanges** | Write | MSFT_MicrosoftGraphIPv4Range[] | Local address range. This collection can contain a maximum of 500 elements. | |
| **LocalPortRanges** | Write | MSFT_MicrosoftGraphNumberRange[] | Local port range can be set only when protocol is either TCP or UDP (6 or 17). This collection can contain a maximum of 500 elements. | |
| **Name** | Write | String | Name. | |
| **Protocols** | Write | UInt32 | Protocols (0-255). Valid values 0 to 255 | |
| **RemoteAddressRanges** | Write | MSFT_MicrosoftGraphIPv4Range[] | Remote address range. This collection can contain a maximum of 500 elements. | |
| **RemotePortRanges** | Write | MSFT_MicrosoftGraphNumberRange[] | Remote port range can be set only when protocol is either TCP or UDP (6 or 17). This collection can contain a maximum of 500 elements. | |
| **RoutingPolicyType** | Write | String | When app triggered, indicates whether to enable split tunneling along this route. Possible values are: none, splitTunnel, forceTunnel. | `none`, `splitTunnel`, `forceTunnel` |
| **VpnTrafficDirection** | Write | String | Specify whether the rule applies to inbound traffic or outbound traffic. Possible values are: outbound, inbound, unknownFutureValue. | `outbound`, `inbound`, `unknownFutureValue` |

### MSFT_MicrosoftGraphIPv4Range

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LowerAddress** | Write | String | Lower address. | |
| **UpperAddress** | Write | String | Upper address. | |
| **CidrAddress** | Write | String | IPv4 address in CIDR notation. Not nullable. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.iPv4CidrRange`, `#microsoft.graph.iPv6CidrRange`, `#microsoft.graph.iPv4Range`, `#microsoft.graph.iPv6Range` |

### MSFT_MicrosoftGraphNumberRange

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LowerNumber** | Write | UInt32 | Lower number. | |
| **UpperNumber** | Write | UInt32 | Upper number. | |

### MSFT_MicrosoftGraphVpnServer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Address** | Write | String | Address (IP address, FQDN or URL) | |
| **Description** | Write | String | Description. | |
| **IsDefaultServer** | Write | Boolean | Default server. | |


## Description

Intune Device Configuration Vpn Policy for Windows10

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

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
        IntuneDeviceConfigurationVpnPolicyWindows10 'Example'
        {
            Assignments                                = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            AuthenticationMethod                       = "usernameAndPassword";
            ConnectionName                             = "Cisco VPN";
            ConnectionType                             = "ciscoAnyConnect";
            CustomXml                                  = "";
            DisplayName                                = "VPN";
            DnsRules                                   = @(
                MSFT_MicrosoftGraphvpnDnsRule{
                    Servers = @('10.0.1.10')
                    Name = 'NRPT rule'
                    Persistent = $True
                    AutoTrigger = $True
                }
            );
            DnsSuffixes                                = @("mydomain.com");
            EnableAlwaysOn                             = $True;
            EnableConditionalAccess                    = $True;
            EnableDnsRegistration                      = $True;
            EnableSingleSignOnWithAlternateCertificate = $False;
            EnableSplitTunneling                       = $False;
            Ensure                                     = "Present";
            ProfileTarget                              = "user";
            ProxyServer                                = MSFT_MicrosoftGraphwindows10VpnProxyServer{
                Port = 8081
                BypassProxyServerForLocalAddress = $True
                AutomaticConfigurationScriptUrl = ''
                Address = '10.0.10.100'
            };
            RememberUserCredentials                    = $True;
            ServerCollection                           = @(
                MSFT_MicrosoftGraphvpnServer{
                    IsDefaultServer = $True
                    Description = 'gateway1'
                    Address = '10.0.1.10'
                }
            );
            TrafficRules                               = @(
                MSFT_MicrosoftGraphvpnTrafficRule{
                    Name = 'VPN rule'
                    AppType = 'none'
                    LocalAddressRanges = @(
                        MSFT_MicrosoftGraphIPv4Range{
                            UpperAddress = '10.0.2.240'
                            LowerAddress = '10.0.2.0'
                        }
                    )
                    RoutingPolicyType = 'forceTunnel'
                    VpnTrafficDirection = 'outbound'
                }
            );
            TrustedNetworkDomains                      = @();
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
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
        IntuneDeviceConfigurationVpnPolicyWindows10 'Example'
        {
            Assignments                                = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            AuthenticationMethod                       = "usernameAndPassword";
            ConnectionName                             = "Cisco VPN";
            ConnectionType                             = "ciscoAnyConnect";
            CustomXml                                  = "";
            DisplayName                                = "VPN";
            DnsRules                                   = @(
                MSFT_MicrosoftGraphvpnDnsRule{
                    Servers = @('10.0.1.10')
                    Name = 'NRPT rule'
                    Persistent = $True
                    AutoTrigger = $True
                }
            );
            DnsSuffixes                                = @("mydomain.com");
            EnableAlwaysOn                             = $True;
            EnableConditionalAccess                    = $True;
            EnableDnsRegistration                      = $True;
            EnableSingleSignOnWithAlternateCertificate = $True; # Updated Property
            EnableSplitTunneling                       = $False;
            Ensure                                     = "Present";
            ProfileTarget                              = "user";
            ProxyServer                                = MSFT_MicrosoftGraphwindows10VpnProxyServer{
                Port = 8081
                BypassProxyServerForLocalAddress = $True
                AutomaticConfigurationScriptUrl = ''
                Address = '10.0.10.100'
            };
            RememberUserCredentials                    = $True;
            ServerCollection                           = @(
                MSFT_MicrosoftGraphvpnServer{
                    IsDefaultServer = $True
                    Description = 'gateway1'
                    Address = '10.0.1.10'
                }
            );
            TrafficRules                               = @(
                MSFT_MicrosoftGraphvpnTrafficRule{
                    Name = 'VPN rule'
                    AppType = 'none'
                    LocalAddressRanges = @(
                        MSFT_MicrosoftGraphIPv4Range{
                            UpperAddress = '10.0.2.240'
                            LowerAddress = '10.0.2.0'
                        }
                    )
                    RoutingPolicyType = 'forceTunnel'
                    VpnTrafficDirection = 'outbound'
                }
            );
            TrustedNetworkDomains                      = @();
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
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
        IntuneDeviceConfigurationVpnPolicyWindows10 'Example'
        {
            DisplayName                                = "VPN";
            Ensure                                     = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

