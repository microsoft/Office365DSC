# IntuneDeviceEnrollmentPlatformRestriction

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | Identity of the device enrollment platform restriction. | |
| **DisplayName** | Key | String | Display name of the device enrollment platform restriction. | |
| **Description** | Write | String | Description of the device enrollment platform restriction. | |
| **AndroidForWorkRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Android for work restrictions based on platform, platform operating system version, and device ownership. | |
| **AndroidRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Android restrictions based on platform, platform operating system version, and device ownership. | |
| **IosRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Ios restrictions based on platform, platform operating system version, and device ownership. | |
| **MacOSRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Mac restrictions based on platform, platform operating system version, and device ownership. | |
| **MacRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Mac restrictions based on platform, platform operating system version, and device ownership. | |
| **WindowsHomeSkuRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Windows Home Sku restrictions based on platform, platform operating system version, and device ownership. | |
| **WindowsMobileRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Windows mobile restrictions based on platform, platform operating system version, and device ownership. | |
| **WindowsRestriction** | Write | MSFT_DeviceEnrollmentPlatformRestriction | Windows restrictions based on platform, platform operating system version, and device ownership. | |
| **DeviceEnrollmentConfigurationType** | Write | String | Support for Enrollment Configuration Type | `platformRestrictions`, `singlePlatformRestriction` |
| **Priority** | Write | UInt32 | Priority is used when a user exists in multiple groups that are assigned enrollment configuration. Users are subject only to the configuration with the lowest priority value. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Assignments of the policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
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

### MSFT_DeviceEnrollmentPlatformRestriction

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **PlatformBlocked** | Write | Boolean | Block the platform from enrolling. | |
| **PersonalDeviceEnrollmentBlocked** | Write | Boolean | Block personally owned devices from enrolling. | |
| **OsMinimumVersion** | Write | String | Min OS version supported. | |
| **OsMaximumVersion** | Write | String | Max OS version supported. | |
| **BlockedManufacturers** | Write | StringArray[] | Collection of blocked Manufacturers. | |
| **BlockedSkus** | Write | StringArray[] | Collection of blocked Skus. | |


## Description

This resource configures the Intune device platform enrollment restrictions.

**Be aware**: To deploy a Android platform restriction policy, two individual configurations must exist:

* The first one contains the key for `AndroidRestriction`
* The second one contains the key for `AndroidForWorkRestriction`

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementServiceConfig.Read.All

- **Update**

    - Group.Read.All, DeviceManagementServiceConfig.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementServiceConfig.Read.All

- **Update**

    - Group.Read.All, DeviceManagementServiceConfig.ReadWrite.All

## Examples

### Example 1

This example creates a new Device Enrollment Platform Restriction.

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
        IntuneDeviceEnrollmentPlatformRestriction 'DeviceEnrollmentPlatformRestriction'
        {
            AndroidForWorkRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            AndroidRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            Assignments                       = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                });
            Description                       = "This is the default Device Type Restriction applied with the lowest priority to all users regardless of group membership.";
            DeviceEnrollmentConfigurationType = "platformRestrictions";
            DisplayName                       = "All users and all devices";
            Ensure                            = "Present";
            Identity                          = "3868d43e-873e-4416-8fd1-fc3d67c7c15c_DefaultPlatformRestrictions";
            IosRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            MacOSRestriction                  = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            MacRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsHomeSkuRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsMobileRestriction          = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $True
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Enrollment Platform Restriction.

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
        IntuneDeviceEnrollmentPlatformRestriction 'DeviceEnrollmentPlatformRestriction'
        {
            AndroidForWorkRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            AndroidRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            Assignments                       = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                });
            Description                       = "This is the default Device Type Restriction applied with the lowest priority to all users regardless of group membership.";
            DeviceEnrollmentConfigurationType = "platformRestrictions";
            DisplayName                       = "All users and all devices";
            Identity                          = "3868d43e-873e-4416-8fd1-fc3d67c7c15c_DefaultPlatformRestrictions";
            Ensure                            = "Present";
            IosRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $True # Updated Property
                personalDeviceEnrollmentBlocked = $False
            };
            MacOSRestriction                  = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            MacRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsHomeSkuRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsMobileRestriction          = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $True
                personalDeviceEnrollmentBlocked = $False
            };
            WindowsRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                platformBlocked = $False
                personalDeviceEnrollmentBlocked = $False
            };
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Enrollment Platform Restriction.

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
        IntuneDeviceEnrollmentPlatformRestriction 'DeviceEnrollmentPlatformRestriction'
        {
            DisplayName                       = "Removed Policy";
            Ensure                            = "Absent";
            Assignments                       = @();
            Description                       = "This is a single platform restriction policy.";
            DeviceEnrollmentConfigurationType = "singlePlatformRestriction";
            Identity                          = "d59e4c28-b6b2-48ad-a6f0-a2132300b99d_SinglePlatformRestriction";
            IosRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                PlatformBlocked                 = $True
                PersonalDeviceEnrollmentBlocked = $False
            };
            Priority                          = 1;
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

