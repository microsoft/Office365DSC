# IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **AllowWindows11Upgrade** | Write | Boolean | When TRUE, allows eligible Windows 10 devices to upgrade to Windows 11. When FALSE, implies the device stays on the existing operating system. Returned by default. Query parameters are not supported. | |
| **AutomaticUpdateMode** | Write | String | The Automatic Update Mode. Possible values are: UserDefined, NotifyDownload, AutoInstallAtMaintenanceTime, AutoInstallAndRebootAtMaintenanceTime, AutoInstallAndRebootAtScheduledTime, AutoInstallAndRebootWithoutEndUserControl, WindowsDefault. UserDefined is the default value, no intent. Returned by default. Query parameters are not supported. Possible values are: userDefined, notifyDownload, autoInstallAtMaintenanceTime, autoInstallAndRebootAtMaintenanceTime, autoInstallAndRebootAtScheduledTime, autoInstallAndRebootWithoutEndUserControl, windowsDefault. | `userDefined`, `notifyDownload`, `autoInstallAtMaintenanceTime`, `autoInstallAndRebootAtMaintenanceTime`, `autoInstallAndRebootAtScheduledTime`, `autoInstallAndRebootWithoutEndUserControl`, `windowsDefault` |
| **AutoRestartNotificationDismissal** | Write | String | Specify the method by which the auto-restart required notification is dismissed. Possible values are: NotConfigured, Automatic, User. Returned by default. Query parameters are not supported. Possible values are: notConfigured, automatic, user, unknownFutureValue. | `notConfigured`, `automatic`, `user`, `unknownFutureValue` |
| **BusinessReadyUpdatesOnly** | Write | String | Determines which branch devices will receive their updates from. Possible values are: UserDefined, All, BusinessReadyOnly, WindowsInsiderBuildFast, WindowsInsiderBuildSlow, WindowsInsiderBuildRelease. Returned by default. Query parameters are not supported. Possible values are: userDefined, all, businessReadyOnly, windowsInsiderBuildFast, windowsInsiderBuildSlow, windowsInsiderBuildRelease. | `userDefined`, `all`, `businessReadyOnly`, `windowsInsiderBuildFast`, `windowsInsiderBuildSlow`, `windowsInsiderBuildRelease` |
| **DeadlineForFeatureUpdatesInDays** | Write | UInt32 | Number of days before feature updates are installed automatically with valid range from 0 to 30 days. Returned by default. Query parameters are not supported. | |
| **DeadlineForQualityUpdatesInDays** | Write | UInt32 | Number of days before quality updates are installed automatically with valid range from 0 to 30 days. Returned by default. Query parameters are not supported. | |
| **DeadlineGracePeriodInDays** | Write | UInt32 | Number of days after deadline until restarts occur automatically with valid range from 0 to 7 days. Returned by default. Query parameters are not supported. | |
| **DeliveryOptimizationMode** | Write | String | The Delivery Optimization Mode. Possible values are: UserDefined, HttpOnly, HttpWithPeeringNat, HttpWithPeeringPrivateGroup, HttpWithInternetPeering, SimpleDownload, BypassMode. UserDefined allows the user to set. Returned by default. Query parameters are not supported. Possible values are: userDefined, httpOnly, httpWithPeeringNat, httpWithPeeringPrivateGroup, httpWithInternetPeering, simpleDownload, bypassMode. | `userDefined`, `httpOnly`, `httpWithPeeringNat`, `httpWithPeeringPrivateGroup`, `httpWithInternetPeering`, `simpleDownload`, `bypassMode` |
| **DriversExcluded** | Write | Boolean | When TRUE, excludes Windows update Drivers. When FALSE, does not exclude Windows update Drivers. Returned by default. Query parameters are not supported. | |
| **EngagedRestartDeadlineInDays** | Write | UInt32 | Deadline in days before automatically scheduling and executing a pending restart outside of active hours, with valid range from 2 to 30 days. Returned by default. Query parameters are not supported. | |
| **EngagedRestartSnoozeScheduleInDays** | Write | UInt32 | Number of days a user can snooze Engaged Restart reminder notifications with valid range from 1 to 3 days. Returned by default. Query parameters are not supported. | |
| **EngagedRestartTransitionScheduleInDays** | Write | UInt32 | Number of days before transitioning from Auto Restarts scheduled outside of active hours to Engaged Restart, which requires the user to schedule, with valid range from 0 to 30 days. Returned by default. Query parameters are not supported. | |
| **FeatureUpdatesDeferralPeriodInDays** | Write | UInt32 | Defer Feature Updates by these many days with valid range from 0 to 30 days. Returned by default. Query parameters are not supported. | |
| **FeatureUpdatesPaused** | Write | Boolean | When TRUE, assigned devices are paused from receiving feature updates for up to 35 days from the time you pause the ring. When FALSE, does not pause Feature Updates. Returned by default. Query parameters are not supported.s | |
| **FeatureUpdatesPauseExpiryDateTime** | Write | String | The Feature Updates Pause Expiry datetime. This value is 35 days from the time admin paused or extended the pause for the ring. Returned by default. Query parameters are not supported. | |
| **FeatureUpdatesPauseStartDate** | Write | String | The Feature Updates Pause start date. This value is the time when the admin paused or extended the pause for the ring. Returned by default. Query parameters are not supported. This property is read-only. | |
| **FeatureUpdatesRollbackStartDateTime** | Write | String | The Feature Updates Rollback Start datetime.This value is the time when the admin rolled back the Feature update for the ring.Returned by default.Query parameters are not supported. | |
| **FeatureUpdatesRollbackWindowInDays** | Write | UInt32 | The number of days after a Feature Update for which a rollback is valid with valid range from 2 to 60 days. Returned by default. Query parameters are not supported. | |
| **InstallationSchedule** | Write | MSFT_MicrosoftGraphwindowsUpdateInstallScheduleType | The Installation Schedule. Possible values are: ActiveHoursStart, ActiveHoursEnd, ScheduledInstallDay, ScheduledInstallTime. Returned by default. Query parameters are not supported. | |
| **MicrosoftUpdateServiceAllowed** | Write | Boolean | When TRUE, allows Microsoft Update Service. When FALSE, does not allow Microsoft Update Service. Returned by default. Query parameters are not supported. | |
| **PostponeRebootUntilAfterDeadline** | Write | Boolean | When TRUE the device should wait until deadline for rebooting outside of active hours. When FALSE the device should not wait until deadline for rebooting outside of active hours. Returned by default. Query parameters are not supported. | |
| **PrereleaseFeatures** | Write | String | The Pre-Release Features. Possible values are: UserDefined, SettingsOnly, SettingsAndExperimentations, NotAllowed. UserDefined is the default value, no intent. Returned by default. Query parameters are not supported. Possible values are: userDefined, settingsOnly, settingsAndExperimentations, notAllowed. | `userDefined`, `settingsOnly`, `settingsAndExperimentations`, `notAllowed` |
| **QualityUpdatesDeferralPeriodInDays** | Write | UInt32 | Defer Quality Updates by these many days with valid range from 0 to 30 days. Returned by default. Query parameters are not supported. | |
| **QualityUpdatesPaused** | Write | Boolean | When TRUE, assigned devices are paused from receiving quality updates for up to 35 days from the time you pause the ring. When FALSE, does not pause Quality Updates. Returned by default. Query parameters are not supported. | |
| **QualityUpdatesPauseExpiryDateTime** | Write | String | The Quality Updates Pause Expiry datetime. This value is 35 days from the time admin paused or extended the pause for the ring. Returned by default. Query parameters are not supported. | |
| **QualityUpdatesPauseStartDate** | Write | String | The Quality Updates Pause start date. This value is the time when the admin paused or extended the pause for the ring. Returned by default. Query parameters are not supported. This property is read-only. | |
| **QualityUpdatesRollbackStartDateTime** | Write | String | The Quality Updates Rollback Start datetime. This value is the time when the admin rolled back the Quality update for the ring. Returned by default. Query parameters are not supported. | |
| **ScheduleImminentRestartWarningInMinutes** | Write | UInt32 | Specify the period for auto-restart imminent warning notifications. Supported values: 15, 30 or 60 (minutes). Returned by default. Query parameters are not supported. | |
| **ScheduleRestartWarningInHours** | Write | UInt32 | Specify the period for auto-restart warning reminder notifications. Supported values: 2, 4, 8, 12 or 24 (hours). Returned by default. Query parameters are not supported. | |
| **SkipChecksBeforeRestart** | Write | Boolean | When TRUE, skips all checks before restart: Battery level = 40%, User presence, Display Needed, Presentation mode, Full screen mode, phone call state, game mode etc. When FALSE, does not skip all checks before restart. Returned by default. Query parameters are not supported. | |
| **UpdateNotificationLevel** | Write | String | Specifies what Windows Update notifications users see. Possible values are: NotConfigured, DefaultNotifications, RestartWarningsOnly, DisableAllNotifications. Returned by default. Query parameters are not supported. Possible values are: notConfigured, defaultNotifications, restartWarningsOnly, disableAllNotifications, unknownFutureValue. | `notConfigured`, `defaultNotifications`, `restartWarningsOnly`, `disableAllNotifications`, `unknownFutureValue` |
| **UpdateWeeks** | Write | String | Schedule the update installation on the weeks of the month. Possible values are: UserDefined, FirstWeek, SecondWeek, ThirdWeek, FourthWeek, EveryWeek. Returned by default. Query parameters are not supported. Possible values are: userDefined, firstWeek, secondWeek, thirdWeek, fourthWeek, everyWeek, unknownFutureValue. | `userDefined`, `firstWeek`, `secondWeek`, `thirdWeek`, `fourthWeek`, `everyWeek`, `unknownFutureValue` |
| **UserPauseAccess** | Write | String | Specifies whether to enable end user's access to pause software updates. Possible values are: NotConfigured, Enabled, Disabled. Returned by default. Query parameters are not supported. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **UserWindowsUpdateScanAccess** | Write | String | Specifies whether to disable user's access to scan Windows Update. Possible values are: NotConfigured, Enabled, Disabled. Returned by default. Query parameters are not supported. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
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

### MSFT_MicrosoftGraphWindowsUpdateInstallScheduleType

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ActiveHoursEnd** | Write | String | Active Hours End | |
| **ActiveHoursStart** | Write | String | Active Hours Start | |
| **ScheduledInstallDay** | Write | String | Scheduled Install Day in week. Possible values are: userDefined, everyday, sunday, monday, tuesday, wednesday, thursday, friday, saturday, noScheduledScan. | `userDefined`, `everyday`, `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `noScheduledScan` |
| **ScheduledInstallTime** | Write | String | Scheduled Install Time during day | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.windowsUpdateActiveHoursInstall`, `#microsoft.graph.windowsUpdateScheduledInstall` |


## Description

Intune Windows Update For Business Ring Update Profile for Windows 10

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
        IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10 'Example'
        {
            DisplayName                         = 'WUfB Ring'
            AllowWindows11Upgrade               = $False
            Assignments                         = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            )
            AutomaticUpdateMode                 = 'autoInstallAtMaintenanceTime'
            AutoRestartNotificationDismissal    = 'notConfigured'
            BusinessReadyUpdatesOnly            = 'userDefined'
            DeadlineForFeatureUpdatesInDays     = 1
            DeadlineForQualityUpdatesInDays     = 2
            DeadlineGracePeriodInDays           = 3
            DeliveryOptimizationMode            = 'userDefined'
            Description                         = ''
            DriversExcluded                     = $False
            FeatureUpdatesDeferralPeriodInDays  = 0
            FeatureUpdatesPaused                = $False
            FeatureUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
            FeatureUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
            FeatureUpdatesRollbackWindowInDays  = 10
            InstallationSchedule = MSFT_MicrosoftGraphwindowsUpdateInstallScheduleType {
                ActiveHoursStart = '08:00:00'
                ActiveHoursEnd   = '17:00:00'
                odataType        = '#microsoft.graph.windowsUpdateActiveHoursInstall'
            }
            MicrosoftUpdateServiceAllowed       = $True
            PostponeRebootUntilAfterDeadline    = $False
            PrereleaseFeatures                  = 'userDefined'
            QualityUpdatesDeferralPeriodInDays  = 0
            QualityUpdatesPaused                = $False
            QualityUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
            QualityUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
            SkipChecksBeforeRestart             = $False
            UpdateNotificationLevel             = 'defaultNotifications'
            UserPauseAccess                     = 'enabled'
            UserWindowsUpdateScanAccess         = 'enabled'
            Ensure                              = 'Present'
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
        IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10 'Example'
        {
            DisplayName                         = 'WUfB Ring'
            AllowWindows11Upgrade               = $True # Updated Property
            Assignments                         = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            )
            AutomaticUpdateMode                 = 'autoInstallAtMaintenanceTime'
            AutoRestartNotificationDismissal    = 'notConfigured'
            BusinessReadyUpdatesOnly            = 'userDefined'
            DeadlineForFeatureUpdatesInDays     = 1
            DeadlineForQualityUpdatesInDays     = 2
            DeadlineGracePeriodInDays           = 3
            DeliveryOptimizationMode            = 'userDefined'
            Description                         = ''
            DriversExcluded                     = $False
            FeatureUpdatesDeferralPeriodInDays  = 0
            FeatureUpdatesPaused                = $False
            FeatureUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
            FeatureUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
            FeatureUpdatesRollbackWindowInDays  = 10
            InstallationSchedule = MSFT_MicrosoftGraphwindowsUpdateInstallScheduleType {
                ActiveHoursStart = '08:00:00'
                ActiveHoursEnd   = '17:00:00'
                odataType        = '#microsoft.graph.windowsUpdateActiveHoursInstall'
            }
            MicrosoftUpdateServiceAllowed       = $True
            PostponeRebootUntilAfterDeadline    = $False
            PrereleaseFeatures                  = 'userDefined'
            QualityUpdatesDeferralPeriodInDays  = 0
            QualityUpdatesPaused                = $False
            QualityUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
            QualityUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
            SkipChecksBeforeRestart             = $False
            UpdateNotificationLevel             = 'defaultNotifications'
            UserPauseAccess                     = 'enabled'
            UserWindowsUpdateScanAccess         = 'enabled'
            Ensure                              = 'Present'
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
        IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10 'Example'
        {
            DisplayName                         = 'WUfB Ring'
            Ensure                              = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

