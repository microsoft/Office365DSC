# IntuneAppConfigurationDevicePolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ConnectedAppsEnabled** | Write | Boolean | Setting to specify whether to allow ConnectedApps experience for this Android app. | |
| **PackageId** | Write | String | Android Enterprise app configuration package id. | |
| **PayloadJson** | Write | String | Android Enterprise app configuration JSON payload. | |
| **PermissionActions** | Write | MSFT_MicrosoftGraphandroidPermissionAction[] | List of Android app permissions and corresponding permission actions. | |
| **ProfileApplicability** | Write | String | Android Enterprise profile applicability (AndroidWorkProfile, DeviceOwner, or default (applies to both)). Possible values are: default, androidWorkProfile, androidDeviceOwner. | `default`, `androidWorkProfile`, `androidDeviceOwner` |
| **EncodedSettingXml** | Write | String | Mdm iOS app configuration Base64 binary. Must not be an empty string if specified. | |
| **Settings** | Write | MSFT_MicrosoftGraphappConfigurationSettingItem[] | iOS app configuration setting items. Must not be an empty collection if specified. | |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Required | String | Admin provided name of the device configuration. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this App configuration entity. | |
| **TargetedMobileApps** | Write | StringArray[] | The associated app. | |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
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

### MSFT_MicrosoftGraphAndroidPermissionAction

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Action** | Write | String | Type of Android permission action. Possible values are: prompt, autoGrant, autoDeny. | `prompt`, `autoGrant`, `autoDeny` |
| **Permission** | Write | String | Android permission string, defined in the official Android documentation.  Example 'android.permission.READ_CONTACTS'. | |

### MSFT_MicrosoftGraphAppConfigurationSettingItem

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AppConfigKey** | Write | String | app configuration key. | |
| **AppConfigKeyType** | Write | String | app configuration key type. Possible values are: stringType, integerType, realType, booleanType, tokenType. | `stringType`, `integerType`, `realType`, `booleanType`, `tokenType` |
| **AppConfigKeyValue** | Write | String | app configuration key value. | |


## Description

Intune App Configuration Device Policy. 

Please note: A policy can only contain settings of its platform type and the platform type cannot be changed after creation.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

## Examples

### Example 1

This example creates a new App Configuration Device Policy.

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
        IntuneAppConfigurationDevicePolicy "IntuneAppConfigurationDevicePolicy-Example"
        {
            Assignments           = @();
            Description           = "";
            DisplayName           = "Example";
            Ensure                = "Present";
            Id                    = "0000000-0000-0000-0000-000000000000";
            ConnectedAppsEnabled  = $true;
            PackageId             = "app:com.microsoft.office.outlook"
            PayloadJson           = "Base64 encoded settings"
            PermissionActions     = @()
            ProfileApplicability  = "default"
            RoleScopeTagIds       = @("0");
            TargetedMobileApps    = @("<Mobile App Id>");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example updates an App Configuration Device Policy.

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
        IntuneAppConfigurationDevicePolicy "IntuneAppConfigurationDevicePolicy-Example"
        {
            Assignments           = @();
            Description           = "";
            DisplayName           = "Example";
            Ensure                = "Present";
            Id                    = "0000000-0000-0000-0000-000000000000";
            ConnectedAppsEnabled  = $true;
            PackageId             = "app:com.microsoft.office.outlook"
            PayloadJson           = "Base64 encoded settings"
            PermissionActions     = @(
                MSFT_MicrosoftGraphAndroidPermissionAction{
                    Action = "prompt"
                    Permission = "android.permission.READ_CALENDAR"
                }
            ) # Updated property
            ProfileApplicability  = "default"
            RoleScopeTagIds       = @("0");
            TargetedMobileApps    = @("<Mobile App Id>");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example deletes a new App Configuration Device Policy.

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
        IntuneAppConfigurationDevicePolicy "IntuneAppConfigurationDevicePolicy-Example"
        {
            Description = "";
            DisplayName = "Example";
            Ensure      = "Present";
            Id          = "0000000-0000-0000-0000-000000000000";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

