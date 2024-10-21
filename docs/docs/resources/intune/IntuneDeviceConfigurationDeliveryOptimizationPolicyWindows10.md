# IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BackgroundDownloadFromHttpDelayInSeconds** | Write | UInt64 | Specifies number of seconds to delay an HTTP source in a background download that is allowed to use peer-to-peer. Valid values 0 to 4294967295 | |
| **BandwidthMode** | Write | MSFT_MicrosoftGraphdeliveryOptimizationBandwidth | Specifies foreground and background bandwidth usage using percentages, absolutes, or hours. | |
| **CacheServerBackgroundDownloadFallbackToHttpDelayInSeconds** | Write | UInt32 | Specifies number of seconds to delay a fall back from cache servers to an HTTP source for a background download. Valid values 0 to 2592000. | |
| **CacheServerForegroundDownloadFallbackToHttpDelayInSeconds** | Write | UInt32 | Specifies number of seconds to delay a fall back from cache servers to an HTTP source for a foreground download. Valid values 0 to 2592000. | |
| **CacheServerHostNames** | Write | StringArray[] | Specifies cache servers host names. | |
| **DeliveryOptimizationMode** | Write | String | Specifies the download method that delivery optimization can use to manage network bandwidth consumption for large content distribution scenarios. Possible values are: userDefined, httpOnly, httpWithPeeringNat, httpWithPeeringPrivateGroup, httpWithInternetPeering, simpleDownload, bypassMode. | `userDefined`, `httpOnly`, `httpWithPeeringNat`, `httpWithPeeringPrivateGroup`, `httpWithInternetPeering`, `simpleDownload`, `bypassMode` |
| **ForegroundDownloadFromHttpDelayInSeconds** | Write | UInt64 | Specifies number of seconds to delay an HTTP source in a foreground download that is allowed to use peer-to-peer (0-86400). Valid values 0 to 86400 Specifying 0 sets Delivery Optimization to manage this setting using the cloud service. Valid values 0 to 86400 | |
| **GroupIdSource** | Write | MSFT_MicrosoftGraphdeliveryOptimizationGroupIdSource | Specifies to restrict peer selection to a specfic source. The options set in this policy only apply to Delivery Optimization mode Group (2) download mode. If Group (2) isn't set as Download mode, this policy will be ignored. For option 3 - DHCP Option ID, the client will query DHCP Option ID 234 and use the returned GUID value as the Group ID. | |
| **MaximumCacheAgeInDays** | Write | UInt32 | Specifies the maximum time in days that each file is held in the Delivery Optimization cache after downloading successfully (0-3650). Valid values 0 to 3650 | |
| **MaximumCacheSize** | Write | MSFT_MicrosoftGraphdeliveryOptimizationMaxCacheSize | Specifies the maximum cache size that Delivery Optimization either as a percentage or in GB. | |
| **MinimumBatteryPercentageAllowedToUpload** | Write | UInt32 | Specifies the minimum battery percentage to allow the device to upload data (0-100). Valid values 0 to 100 The default value is 0. The value 0 (zero) means 'not limited' and the cloud service default value will be used. Valid values 0 to 100 | |
| **MinimumDiskSizeAllowedToPeerInGigabytes** | Write | UInt32 | Specifies the minimum disk size in GB to use Peer Caching (1-100000). Valid values 1 to 100000 Recommended values: 64 GB to 256 GB. Valid values 1 to 100000 | |
| **MinimumFileSizeToCacheInMegabytes** | Write | UInt32 | Specifies the minimum content file size in MB enabled to use Peer Caching (1-100000). Valid values 1 to 100000 Recommended values: 1 MB to 100,000 MB. Valid values 1 to 100000 | |
| **MinimumRamAllowedToPeerInGigabytes** | Write | UInt32 | Specifies the minimum RAM size in GB to use Peer Caching (1-100000). Valid values 1 to 100000 | |
| **ModifyCacheLocation** | Write | String | Specifies the drive that Delivery Optimization should use for its cache. | |
| **RestrictPeerSelectionBy** | Write | String | Specifies to restrict peer selection via selected option. | `notConfigured`, `subnetMask` |
| **VpnPeerCaching** | Write | String | Specifies whether the device is allowed to participate in Peer Caching while connected via VPN to the domain network. | `notConfigured`, `enabled`, `disabled` |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **SupportsScopeTags** | Write | Boolean | Indicates whether or not the underlying Device Configuration supports the assignment of scope tags. Assigning to the ScopeTags property is not allowed when this value is false and entities will not be visible to scoped users. This occurs for Legacy policies created in Silverlight and can be resolved by deleting and recreating the policy in the Azure Portal. This property is read-only. | |
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

### MSFT_MicrosoftGraphDeliveryOptimizationBandwidth

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **MaximumDownloadBandwidthInKilobytesPerSecond** | Write | UInt64 | Specifies the maximum download bandwidth in KiloBytes/second that the device can use across all concurrent download activities using Delivery Optimization. Valid values 0 to 4294967295 | |
| **MaximumUploadBandwidthInKilobytesPerSecond** | Write | UInt64 | Specifies the maximum upload bandwidth in KiloBytes/second that a device will use across all concurrent upload activity using Delivery Optimization (0-4000000). Valid values 0 to 4000000 The default value is 0, which permits unlimited possible bandwidth (optimized for minimal usage of upload bandwidth). Valid values 0 to 4000000 | |
| **BandwidthBackgroundPercentageHours** | Write | MSFT_MicrosoftGraphDeliveryOptimizationBandwidthBusinessHoursLimit | Background download percentage hours. | |
| **BandwidthForegroundPercentageHours** | Write | MSFT_MicrosoftGraphDeliveryOptimizationBandwidthBusinessHoursLimit | Foreground download percentage hours. | |
| **MaximumBackgroundBandwidthPercentage** | Write | UInt32 | Specifies the maximum background download bandwidth that Delivery Optimization uses across all concurrent download activities as a percentage of available download bandwidth (0-100). Valid values 0 to 100 | |
| **MaximumForegroundBandwidthPercentage** | Write | UInt32 | Specifies the maximum foreground download bandwidth that Delivery Optimization uses across all concurrent download activities as a percentage of available download bandwidth (0-100). Valid values 0 to 100 The default value 0 (zero) means that Delivery Optimization dynamically adjusts to use the available bandwidth for foreground downloads. Valid values 0 to 100 | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deliveryOptimizationBandwidthAbsolute`, `#microsoft.graph.deliveryOptimizationBandwidthHoursWithPercentage`, `#microsoft.graph.deliveryOptimizationBandwidthPercentage` |

### MSFT_MicrosoftGraphDeliveryOptimizationBandwidthBusinessHoursLimit

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BandwidthBeginBusinessHours** | Write | UInt32 | Specifies the beginning of business hours using a 24-hour clock (0-23). Valid values 0 to 23 | |
| **BandwidthEndBusinessHours** | Write | UInt32 | Specifies the end of business hours using a 24-hour clock (0-23). Valid values 0 to 23 | |
| **BandwidthPercentageDuringBusinessHours** | Write | UInt32 | Specifies the percentage of bandwidth to limit during business hours (0-100). Valid values 0 to 100 | |
| **BandwidthPercentageOutsideBusinessHours** | Write | UInt32 | Specifies the percentage of bandwidth to limit outsidse business hours (0-100). Valid values 0 to 100 | |

### MSFT_MicrosoftGraphDeliveryOptimizationGroupIdSource

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **GroupIdCustom** | Write | String | Specifies an arbitrary group ID that the device belongs to | |
| **GroupIdSourceOption** | Write | String | Set this policy to restrict peer selection to a specific source. Possible values are: notConfigured, adSite, authenticatedDomainSid, dhcpUserOption, dnsSuffix. | `notConfigured`, `adSite`, `authenticatedDomainSid`, `dhcpUserOption`, `dnsSuffix` |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deliveryOptimizationGroupIdCustom`, `#microsoft.graph.deliveryOptimizationGroupIdSourceOptions` |

### MSFT_MicrosoftGraphDeliveryOptimizationMaxCacheSize

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **MaximumCacheSizeInGigabytes** | Write | UInt64 | Specifies the maximum size in GB of Delivery Optimization cache. Valid values 0 to 4294967295 | |
| **MaximumCacheSizePercentage** | Write | UInt32 | Specifies the maximum cache size that Delivery Optimization can utilize, as a percentage of disk size (1-100). Valid values 1 to 100 | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deliveryOptimizationMaxCacheSizeAbsolute`, `#microsoft.graph.deliveryOptimizationMaxCacheSizePercentage` |


## Description

Intune Device Configuration Delivery Optimization Policy for Windows10

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
        IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10 'Example'
        {
            Assignments                                               = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BackgroundDownloadFromHttpDelayInSeconds                  = 4;
            BandwidthMode                                             = MSFT_MicrosoftGraphdeliveryOptimizationBandwidth{
                MaximumDownloadBandwidthInKilobytesPerSecond = 22
                MaximumUploadBandwidthInKilobytesPerSecond = 33
                odataType = '#microsoft.graph.deliveryOptimizationBandwidthAbsolute'
            };
            CacheServerBackgroundDownloadFallbackToHttpDelayInSeconds = 3;
            CacheServerForegroundDownloadFallbackToHttpDelayInSeconds = 3;
            CacheServerHostNames                                      = @("domain.com");
            DeliveryOptimizationMode                                  = "httpWithPeeringPrivateGroup";
            DisplayName                                               = "delivery optimisation";
            Ensure                                                    = "Present";
            ForegroundDownloadFromHttpDelayInSeconds                  = 234;
            GroupIdSource                                             = MSFT_MicrosoftGraphdeliveryOptimizationGroupIdSource{
                GroupIdSourceOption = 'adSite'
                odataType = '#microsoft.graph.deliveryOptimizationGroupIdSourceOptions'
            };
            MaximumCacheAgeInDays                                     = 3;
            MaximumCacheSize                                          = MSFT_MicrosoftGraphdeliveryOptimizationMaxCacheSize{
                MaximumCacheSizeInGigabytes = 4
                odataType = '#microsoft.graph.deliveryOptimizationMaxCacheSizeAbsolute'
            };
            MinimumBatteryPercentageAllowedToUpload                   = 4;
            MinimumDiskSizeAllowedToPeerInGigabytes                   = 3;
            MinimumFileSizeToCacheInMegabytes                         = 3;
            MinimumRamAllowedToPeerInGigabytes                        = 3;
            ModifyCacheLocation                                       = "%systemdrive%";
            RestrictPeerSelectionBy                                   = "subnetMask";
            SupportsScopeTags                                         = $True;
            VpnPeerCaching                                            = "enabled";
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
        IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10 'Example'
        {
            Assignments                                               = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BackgroundDownloadFromHttpDelayInSeconds                  = 4;
            BandwidthMode                                             = MSFT_MicrosoftGraphdeliveryOptimizationBandwidth{
                MaximumDownloadBandwidthInKilobytesPerSecond = 22
                MaximumUploadBandwidthInKilobytesPerSecond = 33
                odataType = '#microsoft.graph.deliveryOptimizationBandwidthAbsolute'
            };
            CacheServerBackgroundDownloadFallbackToHttpDelayInSeconds = 5; # Updated Property
            CacheServerForegroundDownloadFallbackToHttpDelayInSeconds = 3;
            CacheServerHostNames                                      = @("domain.com");
            DeliveryOptimizationMode                                  = "httpWithPeeringPrivateGroup";
            DisplayName                                               = "delivery optimisation";
            Ensure                                                    = "Present";
            ForegroundDownloadFromHttpDelayInSeconds                  = 234;
            GroupIdSource                                             = MSFT_MicrosoftGraphdeliveryOptimizationGroupIdSource{
                GroupIdSourceOption = 'adSite'
                odataType = '#microsoft.graph.deliveryOptimizationGroupIdSourceOptions'
            };
            MaximumCacheAgeInDays                                     = 3;
            MaximumCacheSize                                          = MSFT_MicrosoftGraphdeliveryOptimizationMaxCacheSize{
                MaximumCacheSizeInGigabytes = 4
                odataType = '#microsoft.graph.deliveryOptimizationMaxCacheSizeAbsolute'
            };
            MinimumBatteryPercentageAllowedToUpload                   = 4;
            MinimumDiskSizeAllowedToPeerInGigabytes                   = 3;
            MinimumFileSizeToCacheInMegabytes                         = 3;
            MinimumRamAllowedToPeerInGigabytes                        = 3;
            ModifyCacheLocation                                       = "%systemdrive%";
            RestrictPeerSelectionBy                                   = "subnetMask";
            SupportsScopeTags                                         = $True;
            VpnPeerCaching                                            = "enabled";
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
        IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10 'Example'
        {
            DisplayName                                               = "delivery optimisation";
            Ensure                                                    = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

