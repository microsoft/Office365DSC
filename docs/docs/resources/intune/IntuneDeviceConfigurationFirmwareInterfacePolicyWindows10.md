# IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Bluetooth** | Write | String | Defines whether a user is allowed to enable Bluetooth. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **BootFromBuiltInNetworkAdapters** | Write | String | Defines whether a user is allowed to boot from built-in network adapters. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **BootFromExternalMedia** | Write | String | Defines whether a user is allowed to boot from external media. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **Cameras** | Write | String | Defines whether built-in cameras are enabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **ChangeUefiSettingsPermission** | Write | String | Defines the permission level granted to users to change UEFI settings. Possible values are: notConfiguredOnly, none. | `notConfiguredOnly`, `none` |
| **FrontCamera** | Write | String | Defines whether a user is allowed to enable Front Camera. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **InfraredCamera** | Write | String | Defines whether a user is allowed to enable Infrared camera. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **Microphone** | Write | String | Defines whether a user is allowed to enable Microphone. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **MicrophonesAndSpeakers** | Write | String | Defines whether built-in microphones or speakers are enabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **NearFieldCommunication** | Write | String | Defines whether a user is allowed to enable Near Field Communication. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **Radios** | Write | String | Defines whether built-in radios e.g. WIFI, NFC, Bluetooth, are enabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **RearCamera** | Write | String | Defines whether a user is allowed to enable rear camera. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **SdCard** | Write | String | Defines whether a user is allowed to enable SD Card Port. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **SimultaneousMultiThreading** | Write | String | Defines whether a user is allowed to enable Simultaneous MultiThreading. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **UsbTypeAPort** | Write | String | Defines whether a user is allowed to enable USB Type A Port. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **VirtualizationOfCpuAndIO** | Write | String | Defines whether CPU and IO virtualization is enabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **WakeOnLAN** | Write | String | Defines whether a user is allowed to enable Wake on LAN. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **WakeOnPower** | Write | String | Defines whether a user is allowed to enable Wake On Power. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **WiFi** | Write | String | Defines whether a user is allowed to enable WiFi. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **WindowsPlatformBinaryTable** | Write | String | Defines whether a user is allowed to enable Windows Platform Binary Table. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **WirelessWideAreaNetwork** | Write | String | Defines whether a user is allowed to enable Wireless Wide Area Network. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
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


## Description

Intune Device Configuration Firmware Interface Policy for Windows10

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
        IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10 'Example'
        {
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            Bluetooth                      = "notConfigured";
            BootFromBuiltInNetworkAdapters = "notConfigured";
            BootFromExternalMedia          = "notConfigured";
            Cameras                        = "enabled";
            ChangeUefiSettingsPermission   = "notConfiguredOnly";
            DisplayName                    = "firmware";
            Ensure                         = "Present";
            FrontCamera                    = "enabled";
            InfraredCamera                 = "enabled";
            Microphone                     = "notConfigured";
            MicrophonesAndSpeakers         = "enabled";
            NearFieldCommunication         = "notConfigured";
            Radios                         = "enabled";
            RearCamera                     = "enabled";
            SdCard                         = "notConfigured";
            SimultaneousMultiThreading     = "enabled";
            SupportsScopeTags              = $True;
            UsbTypeAPort                   = "notConfigured";
            VirtualizationOfCpuAndIO       = "enabled";
            WakeOnLAN                      = "notConfigured";
            WakeOnPower                    = "notConfigured";
            WiFi                           = "notConfigured";
            WindowsPlatformBinaryTable     = "enabled";
            WirelessWideAreaNetwork        = "notConfigured";
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
        IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10 'Example'
        {
            Assignments                    = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            Bluetooth                      = "notConfigured";
            BootFromBuiltInNetworkAdapters = "notConfigured";
            BootFromExternalMedia          = "notConfigured";
            Cameras                        = "enabled"; # Updated Property
            ChangeUefiSettingsPermission   = "notConfiguredOnly";
            DisplayName                    = "firmware";
            Ensure                         = "Present";
            FrontCamera                    = "enabled";
            InfraredCamera                 = "enabled";
            Microphone                     = "notConfigured";
            MicrophonesAndSpeakers         = "enabled";
            NearFieldCommunication         = "notConfigured";
            Radios                         = "enabled";
            RearCamera                     = "enabled";
            SdCard                         = "notConfigured";
            SimultaneousMultiThreading     = "enabled";
            SupportsScopeTags              = $True;
            UsbTypeAPort                   = "notConfigured";
            VirtualizationOfCpuAndIO       = "enabled";
            WakeOnLAN                      = "notConfigured";
            WakeOnPower                    = "notConfigured";
            WiFi                           = "notConfigured";
            WindowsPlatformBinaryTable     = "enabled";
            WirelessWideAreaNetwork        = "notConfigured";
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
        IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10 'Example'
        {
            DisplayName                    = "firmware";
            Ensure                         = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

