# IntuneDeviceControlPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **PolicyRule** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule[] | The list of policy rules to apply. | |
| **DeviceInstall_Allow_Deny_Layered** | Write | String | Apply layered order of evaluation for Allow and Prevent device installation policies across all device match criteria (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_IDs_Allow** | Write | String | Allow installation of devices that match any of these device IDs (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_IDs_Allow_List** | Write | StringArray[] | Allowed device IDs | |
| **DeviceInstall_Instance_IDs_Allow** | Write | String | Allow installation of devices that match any of these device instance IDs (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_Instance_IDs_Allow_List** | Write | StringArray[] | Allowed Instance IDs | |
| **DeviceInstall_Classes_Allow** | Write | String | Allow installation of devices using drivers that match these device setup classes (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_Classes_Allow_List** | Write | StringArray[] | Allowed classes | |
| **DeviceInstall_Unspecified_Deny** | Write | String | Prevent installation of devices not described by other policy settings (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_IDs_Deny** | Write | String | Prevent installation of devices that match any of these device IDs (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_IDs_Deny_List** | Write | StringArray[] | Prevented device IDs | |
| **DeviceInstall_IDs_Deny_Retroactive** | Write | String | Also apply to matching devices that are already installed. (0: False, 1: True) | `0`, `1` |
| **DeviceInstall_Instance_IDs_Deny** | Write | String | Prevent installation of devices that match any of these device instance IDs (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_Instance_IDs_Deny_Retroactive** | Write | String | Also apply to matching devices that are already installed. (Device) (0: False, 1: True) | `0`, `1` |
| **DeviceInstall_Instance_IDs_Deny_List** | Write | StringArray[] | Prevented Instance IDs | |
| **DeviceInstall_Classes_Deny** | Write | String | Prevent installation of devices using drivers that match these device setup classes (0: Disabled, 1: Enabled) | `0`, `1` |
| **DeviceInstall_Classes_Deny_List** | Write | StringArray[] | Prevented Classes | |
| **DeviceInstall_Classes_Deny_Retroactive** | Write | String | Also apply to matching devices that are already installed. (0: False, 1: True) | `0`, `1` |
| **DeviceInstall_Removable_Deny** | Write | String | Prevent installation of removable devices (0: Disabled, 1: Enabled) | `0`, `1` |
| **WPDDevices_DenyRead_Access_2** | Write | String | WPD Devices: Deny read access (0: Disabled, 1: Enabled) | `0`, `1` |
| **WPDDevices_DenyRead_Access_1** | Write | String | WPD Devices: Deny read access (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **WPDDevices_DenyWrite_Access_2** | Write | String | WPD Devices: Deny write access (0: Disabled, 1: Enabled) | `0`, `1` |
| **WPDDevices_DenyWrite_Access_1** | Write | String | WPD Devices: Deny write access (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **AllowFullScanRemovableDriveScanning** | Write | String | Allow Full Scan Removable Drive Scanning (0: Not allowed. Turns off scanning on removable drives., 1: Allowed. Scans removable drives.) | `0`, `1` |
| **AllowDirectMemoryAccess** | Write | String | Allow Direct Memory Access (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **DeviceEnumerationPolicy** | Write | String | Device Enumeration Policy (0: Block all (Most restrictive), 1: Only after log in/screen unlock, 2: Allow all (Least restrictive)) | `0`, `1`, `2` |
| **RemovableDiskDenyWriteAccess** | Write | String | Removable Disk Deny Write Access (0: Disabled., 1: Enabled.) | `0`, `1` |
| **AllowUSBConnection** | Write | String | Allow USB Connection (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **AllowBluetooth** | Write | String | Allow Bluetooth (0: Disallow Bluetooth. If this is set to 0, the radio in the Bluetooth control panel will be grayed out and the user will not be able to turn Bluetooth on., 1: Reserved. If this is set to 1, the radio in the Bluetooth control panel will be functional and the user will be able to turn Bluetooth on., 2: Allow Bluetooth. If this is set to 2, the radio in the Bluetooth control panel will be functional and the user will be able to turn Bluetooth on.) | `0`, `1`, `2` |
| **AllowAdvertising** | Write | String | Allow Advertising (0: Not allowed. When set to 0, the device will not send out advertisements. To verify, use any Bluetooth LE app and enable it to do advertising. Then, verify that the advertisement is not received by the peripheral., 1: Allowed. When set to 1, the device will send out advertisements. To verify, use any Bluetooth LE app and enable it to do advertising. Then, verify that the advertisement is received by the peripheral.) | `0`, `1` |
| **AllowDiscoverableMode** | Write | String | Allow Discoverable Mode (0: Not allowed. When set to 0, other devices will not be able to detect the device. To verify, open the Bluetooth control panel on the device. Then, go to another Bluetooth-enabled device, open the Bluetooth control panel, and verify that you cannot see the name of the device., 1: Allowed. When set to 1, other devices will be able to detect the device. To verify, open the Bluetooth control panel on the device. Then, go to another Bluetooth-enabled device, open the Bluetooth control panel and verify that you can discover it.) | `0`, `1` |
| **AllowPrepairing** | Write | String | Allow Prepairing (0: Not allowed., 1: Allowed.) | `0`, `1` |
| **AllowPromptedProximalConnections** | Write | String | Allow Prompted Proximal Connections (0: Disallow. Block users on these managed devices from using Swift Pair and other proximity based scenarios, 1: Allow. Allow users on these managed devices to use Swift Pair and other proximity based scenarios) | `0`, `1` |
| **ServicesAllowedList** | Write | StringArray[] | Services Allowed List | |
| **AllowStorageCard** | Write | String | Allow Storage Card (0: SD card use is not allowed and USB drives are disabled. This setting does not prevent programmatic access to the storage card., 1: Allow a storage card.) | `0`, `1` |
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

### MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Entry** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry[] | Entry | |
| **Name** | Write | String | Name | |
| **ExcludedIdList_GroupId** | Write | StringArray[] | Excluded ID | |
| **IncludedIdList_GroupId** | Write | StringArray[] | Included ID | |

### MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Type** | Write | String | Type (allow: Allow, deny: Deny, auditallowed: AuditAllowed, auditdenied: AuditDenied) | `allow`, `deny`, `auditallowed`, `auditdenied` |
| **Options** | Write | String | Options (0: None, 1: ShowNotification, 2: SendEvent, 3: SendNotificationAndEvent, 4: Disable) | `0`, `1`, `2`, `3`, `4` |
| **Sid** | Write | String | Sid | |
| **AccessMask** | Write | SInt32Array[] | Access mask (1: WDD_READ_ACCESS, 2: WDD_WRITE_ACCESS, 4: WDD_EXECUTE_ACCESS, 8: WDD_FS_READ_ACCESS, 16: WDD_FS_WRITE_ACCESS, 32: WDD_FS_EXECUTE_ACCESS, 64: WDD_PRINT_ACCESS) | `1`, `2`, `4`, `8`, `16`, `32`, `64` |
| **ComputerSid** | Write | String | Computer Sid | |


## Description

Intune Device Control Policy for Windows10

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

This example creates a new Device Control Policy.

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
        IntuneDeviceControlPolicyWindows10 'ConfigureDeviceControlPolicy'
        {
            AllowStorageCard      = "1";
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            Description           = 'Description'
            DisplayName           = "Device Control";
            DeviceInstall_IDs_Allow      = "1";
            DeviceInstall_IDs_Allow_List = @("1234");
            PolicyRule                   = @(
                MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule{
                    Name = 'asdf'
                    Entry = @(
                        MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry{
                            AccessMask = @(
                                '1'
                                '2'
                            )
                            Sid = '1234'
                            ComputerSid = '1234'
                            Type = 'allow'
                            Options = '4'
                        }
                    )
                }
            );
            Ensure                = "Present";
            Id                    = '00000000-0000-0000-0000-000000000000'
            RoleScopeTagIds       = @("0");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example updates a Device Control Policy.

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
        IntuneDeviceControlPolicyWindows10 'ConfigureDeviceControlPolicy'
        {
            AllowStorageCard      = "1";
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            Description           = 'Description'
            DisplayName           = "Device Control";
            DeviceInstall_IDs_Allow      = "1";
            DeviceInstall_IDs_Allow_List = @("1234");
            PolicyRule                   = @(
                MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule{
                    Name = 'asdf'
                    Entry = @(
                        MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry{
                            AccessMask = @(
                                '1'
                                '2'
                            )
                            Sid = '1234'
                            ComputerSid = '1234'
                            Type = 'deny' # Updated property
                            Options = '4'
                        }
                    )
                }
            );
            Ensure                = "Present";
            Id                    = '00000000-0000-0000-0000-000000000000'
            RoleScopeTagIds       = @("0");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example removes a Device Control Policy.

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
        IntuneDeviceControlPolicyWindows10 'ConfigureDeviceControlPolicy'
        {
            Id          = '00000000-0000-0000-0000-000000000000'
            DisplayName = 'Device Control'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

