# IntuneDeviceCompliancePolicyAndroidDeviceOwner

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the Android Device Owner device compliance policy. | |
| **Description** | Write | String | Description of the Android Device Owner device compliance policy. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Assignments of the Intune Policy. | |
| **DeviceThreatProtectionEnabled** | Write | Boolean | DeviceThreatProtectionEnabled of the Android Device Owner device compliance policy. | |
| **DeviceThreatProtectionRequiredSecurityLevel** | Write | String | DeviceThreatProtectionRequiredSecurityLevel of the Android Device Owner device compliance policy. | |
| **AdvancedThreatProtectionRequiredSecurityLevel** | Write | String | AdvancedThreatProtectionRequiredSecurityLevel of the Android Device Owner device compliance policy. | |
| **SecurityRequireSafetyNetAttestationBasicIntegrity** | Write | Boolean | SecurityRequireSafetyNetAttestationBasicIntegrity of the Android Device Owner device compliance policy. | |
| **SecurityRequireSafetyNetAttestationCertifiedDevice** | Write | Boolean | SecurityRequireSafetyNetAttestationCertifiedDevice of the Android Device Owner device compliance policy. | |
| **osMinimumVersion** | Write | String | osMinimumVersion of the Android Device Owner device compliance policy. | |
| **osMaximumVersion** | Write | String | osMaximumVersion of the Android Device Owner device compliance policy. | |
| **passwordRequired** | Write | Boolean | PasswordRequired of the Android Device Owner device compliance policy. | |
| **passwordMinimumLength** | Write | UInt32 | PasswordMinimumLength of the Android Device Owner device compliance policy. | |
| **PasswordRequiredType** | Write | String | PasswordRequiredType of the Android Device Owner device compliance policy. | `deviceDefault`, `alphabetic`, `alphanumeric`, `alphanumericWithSymbols`, `lowSecurityBiometric`, `numeric`, `numericComplex`, `any` |
| **PasswordMinutesOfInactivityBeforeLock** | Write | UInt32 | PasswordMinutesOfInactivityBeforeLock of the Android Device Owner device compliance policy. | |
| **PasswordExpirationDays** | Write | UInt32 | PasswordExpirationDays of the Android Device Owner device compliance policy. | |
| **PasswordPreviousPasswordCountToBlock** | Write | UInt32 | PasswordPreviousPasswordCountToBlock of the Android Device Owner device compliance policy. | |
| **StorageRequireEncryption** | Write | Boolean | StorageRequireEncryption of the Android Device Owner device compliance policy. | |
| **SecurityRequireIntuneAppIntegrity** | Write | Boolean | SecurityRequireIntuneAppIntegrity of the Android Device Owner device compliance policy. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. Inherited from deviceConfiguration | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
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

This resource configures the settings of Android Work Profile device compliance policies
in your cloud-based organization.

## Parameters

### Microsoft Defender for Endpoint - _for Personally-Owned Work Profile_

* **Require the device to be at or under the machine risk score**
  Select the maximum allowed machine risk score for devices evaluated by Microsoft Defender for Endpoint. Devices which exceed this score get marked as noncompliant.
    * Not configured (_default_)
    * Clear
    * Low
    * Medium
    * High

### Device Health - _for Personally-Owned Work Profile_
* **Rooted devices**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Block - Mark rooted (jailbroken) devices as not compliant.

* **Require the device to be at or under the Device Threat Level**
Select the maximum allowed device threat level evaluated by your mobile threat defense service. Devices that exceed this threat level are marked noncompliant. To use this setting, choose the allowed threat level:
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Secured - This option is the most secure, and means that the device can't have any threats. If the device is detected with any level of threats, it's evaluated as noncompliant.
    * Low - The device is evaluated as compliant if only low-level threats are present. Anything higher puts the device in a noncompliant status.
    * Medium - The device is evaluated as compliant if the threats that are present on the device are low or medium level. If the device is detected to have high-level threats, it's determined to be noncompliant.
    * High - This option is the least secure, as it allows all threat levels. It may be useful if you're using this solution only for reporting purposes.

### Google Play Protect - _for Personally-Owned Work Profile_

* **Google Play Services is configured**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Require - Require that the Google Play services app is installed and enabled. Google Play services allows security updates, and is a base-level dependency for many security features on certified-Google devices.

* **Up-to-date security provider**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Require - Require that an up-to-date security provider can protect a device from known vulnerabilities.

* **SafetyNet device attestation**
  Enter the level of SafetyNet attestation that must be met. Your options:
    * Not configured (_default_) - Setting isn't evaluated for compliance or non-compliance.
    * Check basic integrity
    * Check basic integrity & certified devices

Note:
* On Android Enterprise devices, Threat scan on apps is a device configuration policy. Using a configuration policy, administrators can enable the setting on a device. See Android Enterprise device restriction settings.

### Device Properties - _for Personally-Owned Work Profile_

* **Operating System Version - *for Personally-Owned Work Profile***
    * Minimum OS version
      When a device doesn't meet the minimum OS version requirement, it's reported as non-compliant. A link with information on how to upgrade is shown. The end user can upgrade their device, and then access organization resources.

  _By default, no version is configured._

* **Maximum OS version**
  When a device is using an OS version later than the version in the rule, access to organization resources is blocked. The user is asked to contact their IT administrator. Until a rule is changed to allow the OS version, this device can't access organization resources.

  _By default, no version is configured._

### System security - for _Personally-Owned Work Profile_

* **Require a password to unlock mobile devices**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Require - Users must enter a password before they can access their device.

  _This setting applies at the device level. If you only need to require a password at the Personally-Owned Work Profile level, then use a configuration policy. See Android Enterprise device configuration settings._

* **Required password type**
  Choose if a password should include only numeric characters, or a mix of numerals and other characters. Your options:
    * Device Default
    * Low security biometric
    * At least numeric (_default_): Enter the minimum password length a user must enter, between 4 and 16 characters.
    * Numeric complex: Enter the minimum password length a user must enter, between 4 and 16 characters.
    * At least alphabetic: Enter the minimum password length a user must enter, between 4 and 16 characters.
    * At least alphanumeric: Enter the minimum password length a user must enter, between 4 and 16 characters.
    * At least alphanumeric with symbols: Enter the minimum password length a user must enter, between 4 and 16 characters.

  Depending on the password type you select, the following settings are available:
    * Maximum minutes of inactivity before password is required
    Enter the idle time before the user must reenter their password. Options include the default of Not configured, and from 1 Minute to 8 hours.
    * Number of days until password expires
    Enter the number of days, between 1-365, until the device password must be changed. For example, to change the password after 60 days, enter 60. When the password expires, users are prompted to create a new password.
    * Minimum password length
    Enter the minimum length the password must have, between 4 and 16 characters.
    * Number of previous passwords to prevent reuse
    Enter the number of recent passwords that can't be reused. Use this setting to restrict the user from creating previously used passwords.

### Encryption - _for Personally-Owned Work Profile_
* **Encryption of data storage on device**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Require - Encrypt data storage on your devices.

  You don't have to configure this setting because Android Enterprise devices enforce encryption.

### Device Security - _for Personally-Owned Work Profile_

* **Block apps from unknown sources**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Block - Block devices with Security > Unknown Sources enabled sources (supported on Android 4.0 through Android 7.x. Not supported by Android 8.0 and later).

  _To side-load apps, unknown sources must be allowed. If you're not side-loading Android apps, then set this feature to Block to enable this compliance policy._

* **Company portal app runtime integrity**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Require - Choose Require to confirm the Company Portal app meets all the following requirements:
        * Has the default runtime environment installed
        * Is properly signed
        * Isn't in debug-mode
        * Is installed from a known source

* **Block USB debugging on device**
    * Not configured (_default_) - This setting isn't evaluated for compliance or non-compliance.
    * Block - Prevent devices from using the USB debugging feature.

_You don't have to configure this setting because USB debugging is already disabled on Android Enterprise devices._

* **Minimum security patch level**
Select the oldest security patch level a device can have. Devices that aren't at least at this patch level are noncompliant. The date must be entered in the YYYY-MM-DD format.

_By default, no date is configured._

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

This example creates a new Device Compliance Policy for Android Device Owner devices

```powershell
Configuration Example
{
    param
    (
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
        IntuneDeviceCompliancePolicyAndroidDeviceOwner 'ConfigureAndroidDeviceCompliancePolicyOwner'
        {
            DisplayName                                        = 'DeviceOwner'
            Description                                        = ''
            DeviceThreatProtectionEnabled                      = $False
            DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
            AdvancedThreatProtectionRequiredSecurityLevel      = 'unavailable'
            SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
            SecurityRequireSafetyNetAttestationCertifiedDevice = $False
            OsMinimumVersion                                   = '10'
            OsMaximumVersion                                   = '11'
            PasswordRequired                                   = $True
            PasswordMinimumLength                              = 6
            PasswordRequiredType                               = 'numericComplex'
            PasswordMinutesOfInactivityBeforeLock              = 5
            PasswordExpirationDays                             = 90
            PasswordPreviousPasswordCountToBlock               = 13
            StorageRequireEncryption                           = $True
            Ensure                                             = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Compliance Policy for Android Device Owner devices

```powershell
Configuration Example
{
    param
    (
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
        IntuneDeviceCompliancePolicyAndroidDeviceOwner 'ConfigureAndroidDeviceCompliancePolicyOwner'
        {
            DisplayName                                        = 'DeviceOwner'
            Description                                        = ''
            DeviceThreatProtectionEnabled                      = $False
            DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
            AdvancedThreatProtectionRequiredSecurityLevel      = 'unavailable'
            SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
            SecurityRequireSafetyNetAttestationCertifiedDevice = $False
            OsMinimumVersion                                   = '10'
            OsMaximumVersion                                   = '11'
            PasswordRequired                                   = $True
            PasswordMinimumLength                              = 8 # Updated Property
            PasswordRequiredType                               = 'numericComplex'
            PasswordMinutesOfInactivityBeforeLock              = 5
            PasswordExpirationDays                             = 90
            PasswordPreviousPasswordCountToBlock               = 13
            StorageRequireEncryption                           = $True
            Ensure                                             = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Compliance Policy for Android Device Owner devices

```powershell
Configuration Example
{
    param
    (
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
        IntuneDeviceCompliancePolicyAndroidDeviceOwner 'ConfigureAndroidDeviceCompliancePolicyOwner'
        {
            DisplayName                                        = 'DeviceOwner'
            Description                                        = ''
            DeviceThreatProtectionEnabled                      = $False
            DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
            AdvancedThreatProtectionRequiredSecurityLevel      = 'unavailable'
            SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
            SecurityRequireSafetyNetAttestationCertifiedDevice = $False
            OsMinimumVersion                                   = '10'
            OsMaximumVersion                                   = '11'
            PasswordRequired                                   = $True
            PasswordMinimumLength                              = 8 # Updated Property
            PasswordRequiredType                               = 'numericComplex'
            PasswordMinutesOfInactivityBeforeLock              = 5
            PasswordExpirationDays                             = 90
            PasswordPreviousPasswordCountToBlock               = 13
            StorageRequireEncryption                           = $True
            Ensure                                             = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

