# IntuneVPNConfigurationPolicyIOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Description of the Intune policy. | |
| **connectionName** | Write | String | Connection name displayed to the user. | |
| **connectionType** | Write | String | Connection type. Possible values are: ciscoAnyConnect, pulseSecure, f5EdgeClient, dellSonicWallMobileConnect, checkPointCapsuleVpn, customVpn, ciscoIPSec, citrix, ciscoAnyConnectV2, paloAltoGlobalProtect, zscalerPrivateAccess, f5Access2018, citrixSso, paloAltoGlobalProtectV2, ikEv2, alwaysOn, microsoftTunnel, netMotionMobility, microsoftProtect. | `ciscoAnyConnect`, `pulseSecure`, `f5EdgeClient`, `dellSonicWallMobileConnect`, `checkPointCapsuleVpn`, `customVpn`, `ciscoIPSec`, `citrix`, `ciscoAnyConnectV2`, `paloAltoGlobalProtect`, `zscalerPrivateAccess`, `f5Access2018`, `citrixSso`, `paloAltoGlobalProtectV2`, `ikEv2`, `alwaysOn`, `microsoftTunnel`, `netMotionMobility`, `microsoftProtect` |
| **enableSplitTunneling** | Write | Boolean | Send all network traffic through VPN. | |
| **authenticationMethod** | Write | String | Authentication method for this VPN connection. | `certificate`, `usernameAndPassword`, `sharedSecret`, `derivedCredential`, `azureAD` |
| **safariDomains** | Write | StringArray[] | Safari domains when this VPN per App setting is enabled. In addition to the apps associated with this VPN, Safari domains specified here will also be able to trigger this VPN connection. | |
| **associatedDomains** | Write | StringArray[] | Associated Domains. These domains will be linked with the VPN configuration. | |
| **excludedDomains** | Write | StringArray[] | Domains that are accessed through the public internet instead of through VPN, even when per-app VPN is activated. | |
| **proxyServer** | Write | MSFT_MicrosoftvpnProxyServer[] | Represents the assignment to the Intune policy. | |
| **optInToDeviceIdSharing** | Write | Boolean | Opt-In to sharing the device's Id to third-party vpn clients for use during network access control validation. | |
| **excludeList** | Write | StringArray[] | Not documented on https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-applevpnconfiguration?view=graph-rest-beta. | |
| **server** | Write | MSFT_MicrosoftGraphvpnServer[] | VPN Server on the network. Make sure end users can access this network location. | |
| **customData** | Write | MSFT_customData[] | Use this field to enable functionality not supported by Intune, but available in your VPN solution. Contact your VPN vendor to learn how to add these key/value pairs. This collection can contain a maximum of 25 elements | |
| **customKeyValueData** | Write | MSFT_customKeyValueData[] | Use this field to enable functionality not supported by Intune, but available in your VPN solution. Contact your VPN vendor to learn how to add these key/value pairs. This collection can contain a maximum of 25 elements | |
| **onDemandRules** | Write | MSFT_DeviceManagementConfigurationPolicyVpnOnDemandRule[] | On-Demand Rules. This collection can contain a maximum of 500 elements. | |
| **targetedMobileApps** | Write | StringArray[] | Not documented on https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-applevpnconfiguration?view=graph-rest-beta. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |
| **version** | Write | UInt32 | Version of the device configuration. Inherited from deviceConfiguration. | |
| **loginGroupOrDomain** | Write | String | Login group or domain when connection type is set to Dell SonicWALL Mobile Connection. Inherited from appleVpnConfiguration. | |
| **role** | Write | String | Role when connection type is set to Pulse Secure. Inherited from appleVpnConfiguration. | |
| **realm** | Write | String | Realm when connection type is set to Pulse Secure. Inherited from appleVpnConfiguration. | |
| **identifier** | Write | String | Identifier provided by VPN vendor when connection type is set to Custom VPN. For example: Cisco AnyConnect uses an identifier of the form com.cisco.anyconnect.applevpn.plugin Inherited from appleVpnConfiguration. | |
| **enablePerApp** | Write | Boolean | Setting this to true creates Per-App VPN payload which can later be associated with Apps that can trigger this VPN conneciton on the end user's iOS device. Inherited from appleVpnConfiguration. | |
| **providerType** | Write | String | Provider type for per-app VPN. Inherited from appleVpnConfiguration. Possible values are: notConfigured, appProxy, packetTunnel. | `notConfigured`, `appProxy`, `packetTunnel` |
| **disableOnDemandUserOverride** | Write | Boolean | Toggle to prevent user from disabling automatic VPN in the Settings app Inherited from appleVpnConfiguration. | |
| **disconnectOnIdle** | Write | Boolean | Whether to disconnect after on-demand connection idles Inherited from appleVpnConfiguration | |
| **disconnectOnIdleTimerInSeconds** | Write | UInt32 | The length of time in seconds to wait before disconnecting an on-demand connection. Valid values 0 to 65535 Inherited from appleVpnConfiguration. | |
| **microsoftTunnelSiteId** | Write | String | Microsoft Tunnel site ID. | |
| **cloudName** | Write | String | Zscaler only. Zscaler cloud which the user is assigned to. | |
| **strictEnforcement** | Write | Boolean | Zscaler only. Blocks network traffic until the user signs into Zscaler app. True means traffic is blocked. | |
| **userDomain** | Write | String | Zscaler only. Enter a static domain to pre-populate the login field with in the Zscaler app. If this is left empty, the user's Azure Active Directory domain will be used instead. | |

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

### MSFT_DeviceManagementConfigurationPolicyVpnOnDemandRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ssids** | Write | StringArray[] | Network Service Set Identifiers (SSIDs). | |
| **dnsSearchDomains** | Write | StringArray[] | DNS Search Domains. | |
| **probeUrl** | Write | String | A URL to probe. If this URL is successfully fetched, returning a 200 HTTP status code, without redirection, this rule matches. | |
| **action** | Write | String | Action. Possible values are: connect, evaluateConnection, ignore, disconnect. | `connect`, `evaluateConnection`, `ignore`, `disconnect` |
| **domainAction** | Write | String | Domain Action, Only applicable when Action is evaluate connection. Possible values are: connectIfNeeded, neverConnect. | `connectIfNeeded`, `neverConnect` |
| **domains** | Write | StringArray[] | Domains, Only applicable when Action is evaluate connection. | |
| **probeRequiredUrl** | Write | String | Probe Required URL. Only applicable when Action is evaluate connection and DomainAction is connectIfNeeded. | |
| **interfaceTypeMatch** | Write | String | Network interface to trigger VPN. Possible values are: notConfigured, ethernet, wiFi, cellular. | `notConfigured`, `ethernet`, `wiFi`, `cellular` |
| **dnsServerAddressMatch** | Write | StringArray[] | DNS Search Server Address. | |

### MSFT_MicrosoftGraphVpnServer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **address** | Write | String | Address (IP address, FQDN or URL) | |
| **description** | Write | String | Description. | |
| **isDefaultServer** | Write | Boolean | Default server. | |

### MSFT_MicrosoftvpnProxyServer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **automaticConfigurationScriptUrl** | Write | String | Proxy's automatic configuration script url. | |
| **address** | Write | String | Address. | |
| **port** | Write | UInt32 | Port. Valid values 0 to 65535. | |

### MSFT_targetedMobileApps

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **name** | Write | String | The application name. | |
| **publisher** | Write | String | The publisher of the application. | |
| **appStoreUrl** | Write | String | The Store URL of the application. | |
| **appId** | Write | String | The application or bundle identifier of the application. | |

### MSFT_CustomData

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **key** | Write | String | Key for the custom data entry. | |
| **value** | Write | String | Value for the custom data entry. | |

### MSFT_customKeyValueData

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **name** | Write | String | Name for the custom data entry. | |
| **value** | Write | String | Value for the custom data entry. | |


## Description

This resource configures an Intune VPN Configuration Policy for iOS Device.

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
                    address = 'vpn.newAddress.com' #updated VPN address
                }
            );
            targetedMobileApps     = @();
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
        IntuneVPNConfigurationPolicyIOS "IntuneVPNConfigurationPolicyIOS-Example"
        {
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
            DisplayName            = "IntuneVPNConfigurationPolicyIOS-Example";
            Ensure                 = "Absent";
        }
    }
}
```

