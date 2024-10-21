# IntuneWifiConfigurationPolicyAndroidForWork

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | Id of the Intune policy. | |
| **DisplayName** | Key | String | Display name of the Intune policy. | |
| **Description** | Write | String | Description of the Intune policy. | |
| **ConnectAutomatically** | Write | Boolean | Connect automatically | |
| **ConnectWhenNetworkNameIsHidden** | Write | Boolean | Connect when network name is hidden | |
| **NetworkName** | Write | String | Network name | |
| **Ssid** | Write | String | SSID | |
| **WiFiSecurityType** | Write | String | Wi-Fi security | `open`, `wpaEnterprise`, `wpa2Enterprise` |
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

This resource configures an Intune Wifi Configuration Policy Android For Work Device.

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
        IntuneWifiConfigurationPolicyAndroidForWork 'Example'
        {
            DisplayName                    = 'AndroindForWork'
            Description                    = 'DSC'
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                    deviceAndAppManagementAssignmentFilterType = 'include'
                    deviceAndAppManagementAssignmentFilterId   = '17cb2318-cd4f-4a66-b742-6b79d4966ac7'
                    groupId                                    = 'b9b732df-9f18-4c5f-99d1-682e151ec62b'
                    collectionId                               = '2a8ea71f-039a-4ec8-8e41-5fba3ef9efba'
                }
            )
            ConnectAutomatically           = $true
            ConnectWhenNetworkNameIsHidden = $true
            NetworkName                    = 'CorpNet'
            Ssid                           = 'WiFi'
            WiFiSecurityType               = 'wpa2Enterprise'
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
        IntuneWifiConfigurationPolicyAndroidForWork 'Example'
        {
            DisplayName                    = 'AndroindForWork'
            Description                    = 'DSC'
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                    deviceAndAppManagementAssignmentFilterType = 'include'
                    deviceAndAppManagementAssignmentFilterId   = '17cb2318-cd4f-4a66-b742-6b79d4966ac7'
                    groupId                                    = 'b9b732df-9f18-4c5f-99d1-682e151ec62b'
                    collectionId                               = '2a8ea71f-039a-4ec8-8e41-5fba3ef9efba'
                }
            )
            ConnectAutomatically           = $true # Updated Property
            ConnectWhenNetworkNameIsHidden = $true
            NetworkName                    = 'CorpNet'
            Ssid                           = 'WiFi'
            WiFiSecurityType               = 'wpa2Enterprise'
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
        IntuneWifiConfigurationPolicyAndroidForWork 'Example'
        {
            DisplayName                    = 'AndroindForWork'
            Ensure                         = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

