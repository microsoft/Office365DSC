# IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy | |
| **DisplayName** | Key | String | Disaply name of the Intune policy | |
| **Description** | Write | String | Description of the Intune policy | |
| **ConnectAutomatically** | Write | Boolean | If the network is in range, automatically connect. | |
| **ConnectWhenNetworkNameIsHidden** | Write | Boolean | Don't show this Wi-Fi network on an end-user's device in the list of available networks. The SSID will not be broadcasted. | |
| **NetworkName** | Write | String | Network name. | |
| **PreSharedKey** | Write | String | Pre shared key. | |
| **PreSharedKeyIsSet** | Write | Boolean | Pre shared key is set. | |
| **ProxyAutomaticConfigurationUrl** | Write | String | URL of the automatic proxy. | |
| **ProxyExclusionList** | Write | String | Exclusion list of the proxy. | |
| **ProxyManualAddress** | Write | String | Address of the proxy. | |
| **ProxyManualPort** | Write | UInt32 | Port of the proxy. | |
| **ProxySettings** | Write | String | Proxy setting type. | `none`, `manual`, `automatic` |
| **Ssid** | Write | String | Service Set Identifier. The name of the Wi-Fi connection. | |
| **WiFiSecurityType** | Write | String | Type of Wi-Fi profile. | `open`, `wep`, `wpaPersonal`, `wpaEnterprise` |
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


## Description

This resource configures an Intune Wifi Configuration Policy Android Enterprise Device Owner Device.

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
    param
    (
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
        IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner 'myWifiConfigAndroidDeviceOwnerPolicy'
        {
            DisplayName                    = 'Wifi - androidForWork'
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            )
            ConnectAutomatically           = $False
            ConnectWhenNetworkNameIsHidden = $False
            NetworkName                    = 'myNetwork'
            PreSharedKeyIsSet              = $True
            ProxySettings                  = 'none'
            Ssid                           = 'MySSID - 3'
            Ensure                         = 'Present'
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
    param
    (
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
        IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner 'myWifiConfigAndroidDeviceOwnerPolicy'
        {
            DisplayName                    = 'Wifi - androidForWork'
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            )
            ConnectAutomatically           = $True # Updated Property
            ConnectWhenNetworkNameIsHidden = $False
            NetworkName                    = 'myNetwork'
            PreSharedKeyIsSet              = $True
            ProxySettings                  = 'none'
            Ssid                           = 'MySSID - 3'
            Ensure                         = 'Present'
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
    param
    (
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
        IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner 'myWifiConfigAndroidDeviceOwnerPolicy'
        {
            DisplayName                    = 'Wifi - androidForWork'
            Ensure                         = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

