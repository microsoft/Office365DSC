# IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AccountManagerPolicy** | Write | MSFT_MicrosoftGraphsharedPCAccountManagerPolicy | Specifies how accounts are managed on a shared PC. Only applies when disableAccountManager is false. | |
| **AllowedAccounts** | Write | StringArray[] | Indicates which type of accounts are allowed to use on a shared PC. Possible values are: notConfigured, guest, domain. | `notConfigured`, `guest`, `domain` |
| **AllowLocalStorage** | Write | Boolean | Specifies whether local storage is allowed on a shared PC. | |
| **DisableAccountManager** | Write | Boolean | Disables the account manager for shared PC mode. | |
| **DisableEduPolicies** | Write | Boolean | Specifies whether the default shared PC education environment policies should be disabled. For Windows 10 RS2 and later, this policy will be applied without setting Enabled to true. | |
| **DisablePowerPolicies** | Write | Boolean | Specifies whether the default shared PC power policies should be disabled. | |
| **DisableSignInOnResume** | Write | Boolean | Disables the requirement to sign in whenever the device wakes up from sleep mode. | |
| **Enabled** | Write | Boolean | Enables shared PC mode and applies the shared pc policies. | |
| **FastFirstSignIn** | Write | String | Specifies whether to auto connect new non-admin Azure AD accounts to pre-configured candidate local accounts. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **IdleTimeBeforeSleepInSeconds** | Write | UInt32 | Specifies the time in seconds that a device must sit idle before the PC goes to sleep. Setting this value to 0 prevents the sleep timeout from occurring. | |
| **KioskAppDisplayName** | Write | String | Specifies the display text for the account shown on the sign-in screen which launches the app specified by SetKioskAppUserModelId. Only applies when KioskAppUserModelId is set. | |
| **KioskAppUserModelId** | Write | String | Specifies the application user model ID of the app to use with assigned access. | |
| **LocalStorage** | Write | String | Specifies whether local storage is allowed on a shared PC. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **MaintenanceStartTime** | Write | String | Specifies the daily start time of maintenance hour. | |
| **SetAccountManager** | Write | String | Disables the account manager for shared PC mode. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **SetEduPolicies** | Write | String | Specifies whether the default shared PC education environment policies should be enabled/disabled/not configured. For Windows 10 RS2 and later, this policy will be applied without setting Enabled to true. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **SetPowerPolicies** | Write | String | Specifies whether the default shared PC power policies should be enabled/disabled. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **SignInOnResume** | Write | String | Specifies the requirement to sign in whenever the device wakes up from sleep mode. Possible values are: notConfigured, enabled, disabled. | `notConfigured`, `enabled`, `disabled` |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
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

### MSFT_MicrosoftGraphSharedPCAccountManagerPolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AccountDeletionPolicy** | Write | String | Configures when accounts are deleted. Possible values are: immediate, diskSpaceThreshold, diskSpaceThresholdOrInactiveThreshold. | `immediate`, `diskSpaceThreshold`, `diskSpaceThresholdOrInactiveThreshold` |
| **CacheAccountsAboveDiskFreePercentage** | Write | UInt32 | Sets the percentage of available disk space a PC should have before it stops deleting cached shared PC accounts. Only applies when AccountDeletionPolicy is DiskSpaceThreshold or DiskSpaceThresholdOrInactiveThreshold. Valid values 0 to 100 | |
| **InactiveThresholdDays** | Write | UInt32 | Specifies when the accounts will start being deleted when they have not been logged on during the specified period, given as number of days. Only applies when AccountDeletionPolicy is DiskSpaceThreshold or DiskSpaceThresholdOrInactiveThreshold. | |
| **RemoveAccountsBelowDiskFreePercentage** | Write | UInt32 | Sets the percentage of disk space remaining on a PC before cached accounts will be deleted to free disk space. Accounts that have been inactive the longest will be deleted first. Only applies when AccountDeletionPolicy is DiskSpaceThresholdOrInactiveThreshold. Valid values 0 to 100 | |


## Description

Intune Device Configuration Shared Multi Device Policy for Windows10

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
        IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10 'Example'
        {
            AccountManagerPolicy         = MSFT_MicrosoftGraphsharedPCAccountManagerPolicy{
                CacheAccountsAboveDiskFreePercentage = 50
                AccountDeletionPolicy = 'diskSpaceThreshold'
                RemoveAccountsBelowDiskFreePercentage = 20
            };
            AllowedAccounts              = @("guest","domain");
            AllowLocalStorage            = $True;
            Assignments                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisableAccountManager        = $False;
            DisableEduPolicies           = $False;
            DisablePowerPolicies         = $False;
            DisableSignInOnResume        = $False;
            DisplayName                  = "Shared Multi device";
            Enabled                      = $True;
            Ensure                       = "Present";
            FastFirstSignIn              = "notConfigured";
            IdleTimeBeforeSleepInSeconds = 60;
            LocalStorage                 = "enabled";
            MaintenanceStartTime         = "00:03:00";
            SetAccountManager            = "enabled";
            SetEduPolicies               = "enabled";
            SetPowerPolicies             = "enabled";
            SignInOnResume               = "enabled";
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
        IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10 'Example'
        {
            AccountManagerPolicy         = MSFT_MicrosoftGraphsharedPCAccountManagerPolicy{
                CacheAccountsAboveDiskFreePercentage = 60 # Updated Property
                AccountDeletionPolicy = 'diskSpaceThreshold'
                RemoveAccountsBelowDiskFreePercentage = 20
            };
            AllowedAccounts              = @("guest","domain");
            AllowLocalStorage            = $True;
            Assignments                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisableAccountManager        = $False;
            DisableEduPolicies           = $False;
            DisablePowerPolicies         = $False;
            DisableSignInOnResume        = $False;
            DisplayName                  = "Shared Multi device";
            Enabled                      = $True;
            Ensure                       = "Present";
            FastFirstSignIn              = "notConfigured";
            IdleTimeBeforeSleepInSeconds = 60;
            LocalStorage                 = "enabled";
            MaintenanceStartTime         = "00:03:00";
            SetAccountManager            = "enabled";
            SetEduPolicies               = "enabled";
            SetPowerPolicies             = "enabled";
            SignInOnResume               = "enabled";
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
        IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10 'Example'
        {
            DisplayName                  = "Shared Multi device";
            Ensure                       = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

