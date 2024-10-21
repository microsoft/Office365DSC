# IntuneDeviceEnrollmentStatusPageWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name of the device enrollment configuration | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Description** | Write | String | The description of the device enrollment configuration | |
| **AllowDeviceResetOnInstallFailure** | Write | Boolean | Allow or block device reset on installation failure | |
| **AllowDeviceUseOnInstallFailure** | Write | Boolean | Allow the user to continue using the device on installation failure | |
| **AllowLogCollectionOnInstallFailure** | Write | Boolean | Allow or block log collection on installation failure | |
| **AllowNonBlockingAppInstallation** | Write | Boolean | Install all required apps as non blocking apps during white glove | |
| **BlockDeviceSetupRetryByUser** | Write | Boolean | Allow the user to retry the setup on installation failure | |
| **CustomErrorMessage** | Write | String | Set custom error message to show upon installation failure | |
| **DisableUserStatusTrackingAfterFirstUser** | Write | Boolean | Only show installation progress for first user post enrollment | |
| **InstallProgressTimeoutInMinutes** | Write | UInt32 | Set installation progress timeout in minutes | |
| **InstallQualityUpdates** | Write | Boolean | Allows quality updates installation during OOBE | |
| **SelectedMobileAppIds** | Write | StringArray[] | Ids of selected applications to track the installation status. When this parameter is used, SelectedMobileAppNames is ignored | |
| **SelectedMobileAppNames** | Write | StringArray[] | Names of selected applications to track the installation status. This parameter is ignored when SelectedMobileAppIds is also specified | |
| **ShowInstallationProgress** | Write | Boolean | Show or hide installation progress to user | |
| **TrackInstallProgressForAutopilotOnly** | Write | Boolean | Only show installation progress for Autopilot enrollment scenarios | |
| **Priority** | Write | UInt32 | Priority is used when a user exists in multiple groups that are assigned enrollment configuration. Users are subject only to the configuration with the lowest priority value. | |
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

Intune Device Enrollment Status Page Configuration for Windows10

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All, DeviceManagementServiceConfig.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, DeviceManagementApps.Read.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All, DeviceManagementServiceConfig.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementServiceConfig.ReadWrite.All, DeviceManagementApps.Read.All

## Examples

### Example 1

This example creates a new Device Enrollment Status Page.

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
        IntuneDeviceEnrollmentStatusPageWindows10 '6b43c039-c1d0-4a9f-aab9-48c5531acbd6'
        {
            AllowDeviceResetOnInstallFailure        = $True;
            AllowDeviceUseOnInstallFailure          = $True;
            AllowLogCollectionOnInstallFailure      = $True;
            AllowNonBlockingAppInstallation         = $False;
            Assignments                             = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            BlockDeviceSetupRetryByUser             = $False;
            CustomErrorMessage                      = "Setup could not be completed. Please try again or contact your support person for help.";
            Description                             = "This is the default enrollment status screen configuration applied with the lowest priority to all users and all devices regardless of group membership.";
            DisableUserStatusTrackingAfterFirstUser = $True;
            DisplayName                             = "All users and all devices";
            Ensure                                  = "Present";
            InstallProgressTimeoutInMinutes         = 60;
            InstallQualityUpdates                   = $False;
            Priority                                = 0;
            SelectedMobileAppIds                    = @();
            ShowInstallationProgress                = $True;
            TrackInstallProgressForAutopilotOnly    = $True;
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Enrollment Status Page.

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
        IntuneDeviceEnrollmentStatusPageWindows10 '6b43c039-c1d0-4a9f-aab9-48c5531acbd6'
        {
            AllowDeviceResetOnInstallFailure        = $True;
            AllowDeviceUseOnInstallFailure          = $False; # Updated Property
            AllowLogCollectionOnInstallFailure      = $True;
            AllowNonBlockingAppInstallation         = $False;
            Assignments                             = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            BlockDeviceSetupRetryByUser             = $False;
            CustomErrorMessage                      = "Setup could not be completed. Please try again or contact your support person for help.";
            Description                             = "This is the default enrollment status screen configuration applied with the lowest priority to all users and all devices regardless of group membership.";
            DisableUserStatusTrackingAfterFirstUser = $True;
            DisplayName                             = "All users and all devices";
            Ensure                                  = "Present";
            InstallProgressTimeoutInMinutes         = 60;
            InstallQualityUpdates                   = $False;
            Priority                                = 0;
            SelectedMobileAppIds                    = @();
            ShowInstallationProgress                = $True;
            TrackInstallProgressForAutopilotOnly    = $True;
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Enrollment Status Page.

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
        IntuneDeviceEnrollmentStatusPageWindows10 '6b43c039-c1d0-4a9f-aab9-48c5531acbd6'
        {
            DisplayName                             = "All users and all devices";
            Ensure                                  = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

