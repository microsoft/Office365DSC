# IntuneAccountProtectionPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DeviceSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10 | The policy settings for the device scope. | |
| **UserSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10 | The policy settings for the user scope | |
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

### MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **LsaCfgFlags** | Write | String | Credential Guard (0: (Disabled) Turns off Credential Guard remotely if configured previously without UEFI Lock., 1: (Enabled with UEFI lock) Turns on Credential Guard with UEFI lock., 2: (Enabled without lock) Turns on Credential Guard without UEFI lock.) | `0`, `1`, `2` |
| **FacialFeaturesUseEnhancedAntiSpoofing** | Write | String | Facial Features Use Enhanced Anti Spoofing (false: Disabled, true: Enabled) | `false`, `true` |
| **EnablePinRecovery** | Write | String | Enable Pin Recovery (false: Disabled, true: Enabled) | `false`, `true` |
| **Expiration** | Write | SInt32 | Expiration | |
| **History** | Write | SInt32 | PIN History | |
| **LowercaseLetters** | Write | String | Lowercase Letters (0: Allows the use of lowercase letters in PIN., 1: Requires the use of at least one lowercase letters in PIN., 2: Does not allow the use of lowercase letters in PIN.) | `0`, `1`, `2` |
| **MaximumPINLength** | Write | SInt32 | Maximum PIN Length | |
| **MinimumPINLength** | Write | SInt32 | Minimum PIN Length | |
| **SpecialCharacters** | Write | String | Special Characters (0: Allows the use of special characters in PIN., 1: Requires the use of at least one special characters in PIN., 2: Does not allow the use of special characters in PIN.) | `0`, `1`, `2` |
| **UppercaseLetters** | Write | String | Uppercase Letters (0: Allows the use of uppercase letters in PIN., 1: Requires the use of at least one uppercase letters in PIN., 2: Does not allow the use of uppercase letters in PIN.) | `0`, `1`, `2` |
| **RequireSecurityDevice** | Write | String | Require Security Device (false: Disabled, true: Enabled) | `false`, `true` |
| **UseCertificateForOnPremAuth** | Write | String | Use Certificate For On Prem Auth (false: Disabled, true: Enabled) | `false`, `true` |
| **UsePassportForWork** | Write | String | Use Windows Hello For Business (Device) (false: Disabled, true: Enabled) | `false`, `true` |

### MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EnablePinRecovery** | Write | String | Enable Pin Recovery (User) (false: Disabled, true: Enabled) | `false`, `true` |
| **Expiration** | Write | SInt32 | Expiration (User) | |
| **History** | Write | SInt32 | PIN History (User) | |
| **LowercaseLetters** | Write | String | Lowercase Letters (User) (0: Allows the use of lowercase letters in PIN., 1: Requires the use of at least one lowercase letters in PIN., 2: Does not allow the use of lowercase letters in PIN.) | `0`, `1`, `2` |
| **MaximumPINLength** | Write | SInt32 | Maximum PIN Length (User) | |
| **MinimumPINLength** | Write | SInt32 | Minimum PIN Length (User) | |
| **SpecialCharacters** | Write | String | Special Characters (User) (0: Allows the use of special characters in PIN., 1: Requires the use of at least one special characters in PIN., 2: Does not allow the use of special characters in PIN.) | `0`, `1`, `2` |
| **UppercaseLetters** | Write | String | Uppercase Letters (User) (0: Allows the use of uppercase letters in PIN., 1: Requires the use of at least one uppercase letters in PIN., 2: Does not allow the use of uppercase letters in PIN.) | `0`, `1`, `2` |
| **RequireSecurityDevice** | Write | String | Require Security Device (User) (false: Disabled, true: Enabled) | `false`, `true` |
| **UsePassportForWork** | Write | String | Use Windows Hello For Business (User) (false: Disabled, true: Enabled) | `false`, `true` |


## Description

Intune Account Protection Policy for Windows10

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
        IntuneAccountProtectionPolicyWindows10 'myAccountProtectionPolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 10
                EnablePinRecovery = 'true'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 20
                EnablePinRecovery = 'true'
            }
            Ensure                = 'Present'
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
        IntuneAccountProtectionPolicyWindows10 'myAccountProtectionPolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 10
                EnablePinRecovery = 'true'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 30 # Updated property
                EnablePinRecovery = 'true'
            }
            Ensure                = 'Present'
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
        IntuneAccountProtectionPolicyWindows10 'myAccountProtectionPolicy'
        {
            DisplayName           = 'test'
            Ensure                = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

