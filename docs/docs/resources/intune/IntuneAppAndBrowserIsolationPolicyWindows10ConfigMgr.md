# IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **AllowWindowsDefenderApplicationGuard** | Write | String | Turn on Microsoft Defender Application Guard (0: Disable Microsoft Defender Application Guard, 1: Enable Microsoft Defender Application Guard for Microsoft Edge ONLY, 2: Enable Microsoft Defender Application Guard for isolated Windows environments ONLY, 3: Enable Microsoft Defender Application Guard for Microsoft Edge AND isolated Windows environments) | `0`, `1`, `2`, `3` |
| **ClipboardSettings** | Write | String | Clipboard behavior settings (0: Completely turns Off the clipboard functionality for the Application Guard., 1: Turns On clipboard operation from an isolated session to the host., 2: Turns On clipboard operation from the host to an isolated session., 3: Turns On clipboard operation in both the directions.) | `0`, `1`, `2`, `3` |
| **SaveFilesToHost** | Write | String | Allow files to download and save to the host operating system (0: The user cannot download files from Edge in the container to the host file system. When the policy is not configured, it is the same as disabled (0)., 1: Turns on the functionality to allow users to download files from Edge in the container to the host file system.) | `0`, `1` |
| **InstallWindowsDefenderApplicationGuard** | Write | String | Install Windows defender application guard (install: Install). Required if AllowWindowsDefenderApplicationGuard is not set to 0. | `install` |
| **ClipboardFileType** | Write | String | Clipboard content options (1: Allow text copying., 2: Allow image copying., 3: Allow text and image copying.) | `1`, `2`, `3` |
| **AllowPersistence** | Write | String | Allow data persistence (0: Application Guard discards user-downloaded files and other items (such as, cookies, Favorites, and so on) during machine restart or user log-off., 1: Application Guard saves user-downloaded files and other items (such as, cookies, Favorites, and so on) for use in future Application Guard sessions.) | `0`, `1` |
| **AllowVirtualGPU** | Write | String | Allow hardware-accelerated rendering (0: Cannot access the vGPU and uses the CPU to support rendering graphics. When the policy is not configured, it is the same as disabled (0)., 1: Turns on the functionality to access the vGPU offloading graphics rendering from the CPU. This can create a faster experience when working with graphics intense websites or watching video within the container.) | `0`, `1` |
| **PrintingSettings** | Write | SInt32Array[] | Print Settings (0: Disables all print functionality., 1: Enables only XPS printing., 2: Enables only PDF printing., 4: Enables only local printing., 8: Enables only network printing.) | `0`, `1`, `2`, `4`, `8` |
| **AllowCameraMicrophoneRedirection** | Write | String | Allow camera and microphone access (0: Microsoft Defender Application Guard cannot access the device's camera and microphone. When the policy is not configured, it is the same as disabled (0)., 1: Turns on the functionality to allow Microsoft Defender Application Guard to access the device's camera and microphone.) | `0`, `1` |
| **AuditApplicationGuard** | Write | String | Audit Application Guard (0: Audit event logs aren't collected for Application Guard., 1: Application Guard inherits its auditing policies from system and starts to audit security events for Application Guard container.) | `0`, `1` |
| **CertificateThumbprints** | Write | StringArray[] | Certificate Thumbprints | |
| **EnterpriseIPRange** | Write | StringArray[] | Enterprise IP Range | |
| **EnterpriseCloudResources** | Write | StringArray[] | Enterprise Cloud Resources | |
| **EnterpriseNetworkDomainNames** | Write | StringArray[] | Enterprise Network Domain Names | |
| **EnterpriseProxyServers** | Write | StringArray[] | Enterprise Proxy Servers | |
| **EnterpriseInternalProxyServers** | Write | StringArray[] | Enterprise Internal Proxy Servers | |
| **NeutralResources** | Write | StringArray[] | Neutral Resources | |
| **EnterpriseProxyServersAreAuthoritative** | Write | String | Enterprise Proxy Servers Are Authoritative (1: Enable, 0: Disable) | `1`, `0` |
| **EnterpriseIPRangesAreAuthoritative** | Write | String | Enterprise IP Ranges Are Authoritative (1: Enable, 0: Disable) | `1`, `0` |
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

Intune App And Browser Isolation Policy for Windows10 Config Mgr

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example creates a new Device Remediation.

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
        IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr 'ConfigureAppAndBrowserIsolationPolicyWindows10ConfigMgr'
        {
            Assignments              = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            AllowCameraMicrophoneRedirection       = "1";
            AllowPersistence                       = "0";
            AllowVirtualGPU                        = "0";
            AllowWindowsDefenderApplicationGuard   = "1";
            ClipboardFileType                      = "1";
            ClipboardSettings                      = "0";
            Description                            = 'Description'
            DisplayName                            = "App and Browser Isolation";
            Ensure                                 = "Present";
            Id                                     = '00000000-0000-0000-0000-000000000000'
            InstallWindowsDefenderApplicationGuard = "install";
            SaveFilesToHost                        = "0";
            RoleScopeTagIds                        = @("0");
            ApplicationId                          = $ApplicationId;
            TenantId                               = $TenantId;
            CertificateThumbprint                  = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example updates a new Device Remediation.

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
        IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr 'ConfigureAppAndBrowserIsolationPolicyWindows10ConfigMgr'
        {
            Assignments              = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            AllowCameraMicrophoneRedirection       = "0"; # Updated property
            AllowPersistence                       = "0";
            AllowVirtualGPU                        = "0";
            AllowWindowsDefenderApplicationGuard   = "1";
            ClipboardFileType                      = "1";
            ClipboardSettings                      = "0";
            Description                            = 'Description'
            DisplayName                            = "App and Browser Isolation";
            Ensure                                 = "Present";
            Id                                     = '00000000-0000-0000-0000-000000000000'
            InstallWindowsDefenderApplicationGuard = "install";
            SaveFilesToHost                        = "0";
            RoleScopeTagIds                        = @("0");
            ApplicationId                          = $ApplicationId;
            TenantId                               = $TenantId;
            CertificateThumbprint                  = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example removes a Device Remediation.

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
        IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr 'ConfigureAppAndBrowserIsolationPolicyWindows10ConfigMgr'
        {
            Id          = '00000000-0000-0000-0000-000000000000'
            DisplayName = 'App and Browser Isolation'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

