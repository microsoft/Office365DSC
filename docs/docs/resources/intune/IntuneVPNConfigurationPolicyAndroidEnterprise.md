# IntuneVPNConfigurationPolicyAndroidEnterprise

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Description of the Intune policy. | |
| **authenticationMethod** | Write | String | Authentication method. Inherited from vpnConfiguration. Possible values are: certificate, usernameAndPassword, sharedSecret, derivedCredential, azureAD. | `certificate`, `usernameAndPassword`, `sharedSecret`, `derivedCredential`, `azureAD` |
| **connectionName** | Write | String | Connection name displayed to the user. | |
| **role** | Write | String | Role when connection type is set to Pulse Secure. Inherited from vpnConfiguration. | |
| **realm** | Write | String | Realm when connection type is set to Pulse Secure. Inherited from vpnConfiguration. | |
| **servers** | Write | MSFT_MicrosoftGraphvpnServer[] | VPN Server on the network. Make sure end users can access this network location. | |
| **connectionType** | Write | String | Connection type. Possible values are: ciscoAnyConnect, pulseSecure, f5EdgeClient, dellSonicWallMobileConnect, checkPointCapsuleVpn, citrix, microsoftTunnel, netMotionMobility, microsoftProtect. | `ciscoAnyConnect`, `pulseSecure`, `f5EdgeClient`, `dellSonicWallMobileConnect`, `checkPointCapsuleVpn`, `citrix`, `microsoftTunnel`, `netMotionMobility`, `microsoftProtect` |
| **proxyServer** | Write | MSFT_MicrosoftvpnProxyServer[] | Proxy Server. | |
| **targetedPackageIds** | Write | StringArray[] | Targeted App package IDs. | |
| **targetedMobileApps** | Write | MSFT_targetedMobileApps[] | Targeted mobile apps. This collection can contain a maximum of 500 elements. | |
| **alwaysOn** | Write | Boolean | Whether or not to enable always-on VPN connection. | |
| **alwaysOnLockdown** | Write | Boolean | If always-on VPN connection is enabled, whether or not to lock network traffic when that VPN is disconnected. | |
| **microsoftTunnelSiteId** | Write | String | Microsoft Tunnel site ID. | |
| **proxyExclusionList** | Write | StringArray[] | List of hosts to exclude using the proxy on connections for. These hosts can use wildcards such as *.example.com. | |
| **customData** | Write | MSFT_customData[] | Custom data to define key/value pairs specific to a VPN provider. This collection can contain a maximum of 25 elements. | |
| **customKeyValueData** | Write | MSFT_customKeyValueData[] | Custom data to define key/value pairs specific to a VPN provider. This collection can contain a maximum of 25 elements. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
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

This resource configures an Intune VPN Configuration Policy for Android Enterprise Devices.

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
        IntuneVPNConfigurationPolicyAndroidEnterprise "IntuneVPNConfigurationPolicyAndroidEnterprise-Example"
        {
            ApplicationId                      = $ApplicationId;
            TenantId                           = $TenantId;
            CertificateThumbprint              = $CertificateThumbprint;
            Assignments                        = @();
            authenticationMethod               = "usernameAndPassword";
            connectionName                     = "IntuneVPNConfigurationPolicyAndroidEnterprise ConnectionName";
            connectionType                     = "ciscoAnyConnect";
            Description                        = "IntuneVPNConfigurationPolicyAndroidEnterprise Description";
            DisplayName                        = "IntuneVPNConfigurationPolicyAndroidEnterprise DisplayName";
            Ensure                             = "Present";
            Id                                 = "12345678-1234-abcd-1234-12345678ABCD";
            servers                            = @(
                MSFT_MicrosoftGraphvpnServer{
                    isDefaultServer            = $True
                    description                = 'server'
                    address                    = 'vpn.test.com'
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
        IntuneVPNConfigurationPolicyAndroidEnterprise "IntuneVPNConfigurationPolicyAndroidEnterprise-Example"
        {
            ApplicationId                       = $ApplicationId;
            TenantId                            = $TenantId;
            CertificateThumbprint               = $CertificateThumbprint;
            Assignments                         = @();
            authenticationMethod                = "usernameAndPassword";
            connectionName                      = "IntuneVPNConfigurationPolicyAndroidEnterprise ConnectionName";
            connectionType                      = "ciscoAnyConnect";
            Description                         = "IntuneVPNConfigurationPolicyAndroidEnterprise Description";
            DisplayName                         = "IntuneVPNConfigurationPolicyAndroidEnterprise DisplayName";
            Ensure                              = "Present";
            Id                                  = "12345678-1234-abcd-1234-12345678ABCD";
            servers                             = @(
                MSFT_MicrosoftGraphvpnServer{
                    isDefaultServer             = $True
                    description                 = 'server'
                    address                     = 'vpn.newAddress.com' #updated VPN address
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
        IntuneVPNConfigurationPolicyAndroidEnterprise "IntuneVPNConfigurationPolicyAndroidEnterprise-Example"
        {
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
            DisplayName           = "IntuneVPNConfigurationPolicyAndroidEnterprise DisplayName";
            Ensure                = "Absent";
        }
    }
}
```

