# IntuneDeviceConfigurationWindowsTeamPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AzureOperationalInsightsBlockTelemetry** | Write | Boolean | Indicates whether or not to Block Azure Operational Insights. | |
| **AzureOperationalInsightsWorkspaceId** | Write | String | The Azure Operational Insights workspace id. | |
| **AzureOperationalInsightsWorkspaceKey** | Write | String | The Azure Operational Insights Workspace key. | |
| **ConnectAppBlockAutoLaunch** | Write | Boolean | Specifies whether to automatically launch the Connect app whenever a projection is initiated. | |
| **MaintenanceWindowBlocked** | Write | Boolean | Indicates whether or not to Block setting a maintenance window for device updates. | |
| **MaintenanceWindowDurationInHours** | Write | UInt32 | Maintenance window duration for device updates. Valid values 0 to 5 | |
| **MaintenanceWindowStartTime** | Write | String | Maintenance window start time for device updates. | |
| **MiracastBlocked** | Write | Boolean | Indicates whether or not to Block wireless projection. | |
| **MiracastChannel** | Write | String | The channel. Possible values are: userDefined, one, two, three, four, five, six, seven, eight, nine, ten, eleven, thirtySix, forty, fortyFour, fortyEight, oneHundredFortyNine, oneHundredFiftyThree, oneHundredFiftySeven, oneHundredSixtyOne, oneHundredSixtyFive. | `userDefined`, `one`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `eleven`, `thirtySix`, `forty`, `fortyFour`, `fortyEight`, `oneHundredFortyNine`, `oneHundredFiftyThree`, `oneHundredFiftySeven`, `oneHundredSixtyOne`, `oneHundredSixtyFive` |
| **MiracastRequirePin** | Write | Boolean | Indicates whether or not to require a pin for wireless projection. | |
| **SettingsBlockMyMeetingsAndFiles** | Write | Boolean | Specifies whether to disable the 'My meetings and files' feature in the Start menu, which shows the signed-in user's meetings and files from Office 365. | |
| **SettingsBlockSessionResume** | Write | Boolean | Specifies whether to allow the ability to resume a session when the session times out. | |
| **SettingsBlockSigninSuggestions** | Write | Boolean | Specifies whether to disable auto-populating of the sign-in dialog with invitees from scheduled meetings. | |
| **SettingsDefaultVolume** | Write | UInt32 | Specifies the default volume value for a new session. Permitted values are 0-100. The default is 45. Valid values 0 to 100 | |
| **SettingsScreenTimeoutInMinutes** | Write | UInt32 | Specifies the number of minutes until the Hub screen turns off. | |
| **SettingsSessionTimeoutInMinutes** | Write | UInt32 | Specifies the number of minutes until the session times out. | |
| **SettingsSleepTimeoutInMinutes** | Write | UInt32 | Specifies the number of minutes until the Hub enters sleep mode. | |
| **WelcomeScreenBackgroundImageUrl** | Write | String | The welcome screen background image URL. The URL must use the HTTPS protocol and return a PNG image. | |
| **WelcomeScreenBlockAutomaticWakeUp** | Write | Boolean | Indicates whether or not to Block the welcome screen from waking up automatically when someone enters the room. | |
| **WelcomeScreenMeetingInformation** | Write | String | The welcome screen meeting information shown. Possible values are: userDefined, showOrganizerAndTimeOnly, showOrganizerAndTimeAndSubject. | `userDefined`, `showOrganizerAndTimeOnly`, `showOrganizerAndTimeAndSubject` |
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

Intune Device Configuration Windows Team Policy for Windows10

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
        IntuneDeviceConfigurationWindowsTeamPolicyWindows10 'Example'
        {
            Assignments                            = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            AzureOperationalInsightsBlockTelemetry = $True;
            ConnectAppBlockAutoLaunch              = $True;
            DisplayName                            = "Device restrictions (Windows 10 Team)";
            Ensure                                 = "Present";
            MaintenanceWindowBlocked               = $False;
            MaintenanceWindowDurationInHours       = 1;
            MaintenanceWindowStartTime             = "00:00:00";
            MiracastBlocked                        = $True;
            MiracastChannel                        = "oneHundredFortyNine";
            MiracastRequirePin                     = $True;
            SettingsBlockMyMeetingsAndFiles        = $True;
            SettingsBlockSessionResume             = $True;
            SettingsBlockSigninSuggestions         = $True;
            SupportsScopeTags                      = $True;
            WelcomeScreenBlockAutomaticWakeUp      = $True;
            WelcomeScreenMeetingInformation        = "showOrganizerAndTimeOnly";
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
        IntuneDeviceConfigurationWindowsTeamPolicyWindows10 'Example'
        {
            Assignments                            = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            AzureOperationalInsightsBlockTelemetry = $False; # Updated Property
            ConnectAppBlockAutoLaunch              = $True;
            DisplayName                            = "Device restrictions (Windows 10 Team)";
            Ensure                                 = "Present";
            MaintenanceWindowBlocked               = $False;
            MaintenanceWindowDurationInHours       = 1;
            MaintenanceWindowStartTime             = "00:00:00";
            MiracastBlocked                        = $True;
            MiracastChannel                        = "oneHundredFortyNine";
            MiracastRequirePin                     = $True;
            SettingsBlockMyMeetingsAndFiles        = $True;
            SettingsBlockSessionResume             = $True;
            SettingsBlockSigninSuggestions         = $True;
            SupportsScopeTags                      = $True;
            WelcomeScreenBlockAutomaticWakeUp      = $True;
            WelcomeScreenMeetingInformation        = "showOrganizerAndTimeOnly";
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
        IntuneDeviceConfigurationWindowsTeamPolicyWindows10 'Example'
        {
            DisplayName                            = "Device restrictions (Windows 10 Team)";
            Ensure                                 = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

