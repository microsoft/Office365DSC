# IntuneDeviceCompliancePolicyMacOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the MacOS device compliance policy. | |
| **Description** | Write | String | Description of the MacOS device compliance policy. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Assignments of the Intune Policy. | |
| **PasswordRequired** | Write | Boolean | PasswordRequired of the MacOS device compliance policy. | |
| **PasswordBlockSimple** | Write | Boolean | PasswordBlockSimple of the MacOS device compliance policy. | |
| **PasswordExpirationDays** | Write | UInt32 | PasswordExpirationDays of the MacOS device compliance policy. | |
| **PasswordMinimumLength** | Write | UInt32 | PasswordMinimumLength of the MacOS device compliance policy. | |
| **PasswordMinutesOfInactivityBeforeLock** | Write | UInt32 | PasswordMinutesOfInactivityBeforeLock of the MacOS device compliance policy. | |
| **PasswordPreviousPasswordBlockCount** | Write | UInt32 | PasswordPreviousPasswordBlockCount of the MacOS device compliance policy. | |
| **PasswordMinimumCharacterSetCount** | Write | UInt32 | PasswordMinimumCharacterSetCount of the MacOS device compliance policy. | |
| **PasswordRequiredType** | Write | String | PasswordRequiredType of the MacOS device compliance policy. | `DeviceDefault`, `Alphanumeric`, `Numeric` |
| **OsMinimumVersion** | Write | String | OsMinimumVersion of the MacOS device compliance policy. | |
| **OsMaximumVersion** | Write | String | OsMaximumVersion of the MacOS device compliance policy. | |
| **OsMinimumBuildVersion** | Write | String | Minimum MacOS build version. | |
| **OsMaximumBuildVersion** | Write | String | Maximum MacOS build version. | |
| **SystemIntegrityProtectionEnabled** | Write | Boolean | SystemIntegrityProtectionEnabled of the MacOS device compliance policy. | |
| **DeviceThreatProtectionEnabled** | Write | Boolean | DeviceThreatProtectionEnabled of the MacOS device compliance policy. | |
| **DeviceThreatProtectionRequiredSecurityLevel** | Write | String | DeviceThreatProtectionRequiredSecurityLevel of the MacOS device compliance policy. | `Unavailable`, `Secured`, `Low`, `Medium`, `High`, `NotSet` |
| **AdvancedThreatProtectionRequiredSecurityLevel** | Write | String | AdvancedThreatProtectionRequiredSecurityLevel of the MacOS device compliance policy. | `Unavailable`, `Secured`, `Low`, `Medium`, `High`, `NotSet` |
| **StorageRequireEncryption** | Write | Boolean | StorageRequireEncryption of the MacOS device compliance policy. | |
| **GatekeeperAllowedAppSource** | Write | String | System and Privacy setting that determines which download locations apps can be run from on a macOS device. | `notConfigured`, `macAppStore`, `macAppStoreAndIdentifiedDevelopers`, `anywhere` |
| **FirewallEnabled** | Write | Boolean | FirewallEnabled of the MacOS device compliance policy. | |
| **FirewallBlockAllIncoming** | Write | Boolean | FirewallBlockAllIncoming of the MacOS device compliance policy. | |
| **FirewallEnableStealthMode** | Write | Boolean | FirewallEnableStealthMode of the MacOS device compliance policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
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

This resource configures the settings of MacOS compliance policies
in your cloud-based organization.

## Parameters

### Device Health
* **Require a system integrity protection**
  *  Not configured _(default)_ - This setting isn't evaluated for compliance or non-compliance.
  *  Require - Require macOS devices to have System Integrity Protection enabled.

### Device Properties
* **Minimum OS required**
  When a device doesn't meet the minimum OS version requirement, it's reported as non-compliant. A link with information on how to upgrade is shown. The device user can choose to upgrade their device. After that, they can access organization resources.

* **Maximum OS version allowed**
  When a device uses an OS version later than the version in the rule, access to organization resources is blocked. The device user is asked to contact their IT administrator. The device can't access organization resources until a rule changes to allow the OS version.

* **Minimum OS build version**
  When Apple publishes security updates, the build number is typically updated, not the OS version. Use this feature to enter a minimum allowed build number on the device.

* **Maximum OS build version**
  When Apple publishes security updates, the build number is typically updated, not the OS version. Use this feature to enter a maximum allowed build number on the device.

## System security settings
### Password
* **Require a password to unlock mobile devices**
  * Not configured _(default)_
  * Require Users must enter a password before they can access their device.

* **Simple passwords**
  * Not configured _(default)_ - Users can create passwords simple like 1234 or 1111.
  * Block - Users can't create simple passwords, such as 1234 or 1111.

* **Minimum password length**
  * Enter the minimum number of digits or characters that the password must have.

* **Password type**
  * Choose if a password should have only Numeric characters, or if there should be a mix of numbers and other characters (Alphanumeric).

* **Number of non-alphanumeric characters in password**
  * Enter the minimum number of special characters, such as &, #, %, !, and so on, that must be in the password.

  Setting a higher number requires the user to create a password that is more complex.

* **Maximum minutes of inactivity before password is required**
  * Enter the idle time before the user must reenter their password.

* **Password expiration (days)**
  * Select the number of days before the password expires, and they must create a new one.

* **Number of previous passwords to prevent reuse**
  * Enter the number of previously used passwords that can't be used.

### Encryption
* **Encryption of data storage on device**
  * Not configured (_default_)
  * Require - Use _Require_ to encrypt data storage on your devices.

### Device Security
Firewall protects devices from unauthorized network access. You can use Firewall to control connections on a per-application basis.

* **Firewall**
  * Not configured _(default)_ - This setting leaves the firewall turned off, and network traffic is allowed (not blocked).
  * Enable - Use Enable to help protect devices from unauthorized access. Enabling this feature allows you to handle incoming internet connections, and use stealth mode.

* **Incoming connections**
  * Not configured _(default)_ - Allows incoming connections and sharing services.
  * Block - Block all incoming network connections except the connections required for basic internet services, such as DHCP, Bonjour, and IPSec. This setting also blocks all sharing services, including screen sharing, remote access, iTunes music sharing, and more.

* **Stealth Mode**
  * Not configured _(default)_ - This setting leaves stealth mode turned off.
  * Enable - Turn on stealth mode to prevent devices from responding to probing requests, which can be made my malicious users. When enabled, the device continues to answer incoming requests for authorized apps.

### Gatekeeper
For more information, see Gatekeeper on macOS.

* **Allow apps downloaded from these locations**
  Allows supported applications to be installed on your devices from different locations. Your location options:
  * Not configured _(default)_ - The gatekeeper option has no impact on compliance or non-compliance.
  * Mac App Store - Only install apps for the Mac app store. Apps can't be installed from third parties nor identified developers. If a user selects Gatekeeper to install apps outside the Mac App Store, then the device is considered not compliant.
  * Mac App Store and identified developers - Install apps for the Mac app store and from identified developers. macOS checks the identity of developers, and does some other checks to verify app integrity. If a user selects Gatekeeper to install apps outside these options, then the device is considered not compliant.
  * Anywhere - Apps can be installed from anywhere, and by any developer. This option is the least secure.

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

This example creates a new Device Comliance Policy for MacOS.

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
        IntuneDeviceCompliancePolicyMacOS 'ConfigureDeviceCompliancePolicyMacOS'
        {
            DisplayName                                 = 'MacOS DSC Policy'
            Description                                 = 'Test policy'
            PasswordRequired                            = $False
            PasswordBlockSimple                         = $False
            PasswordExpirationDays                      = 365
            PasswordMinimumLength                       = 6
            PasswordMinutesOfInactivityBeforeLock       = 5
            PasswordPreviousPasswordBlockCount          = 13
            PasswordMinimumCharacterSetCount            = 1
            PasswordRequiredType                        = 'DeviceDefault'
            OsMinimumVersion                            = 10
            OsMaximumVersion                            = 13
            SystemIntegrityProtectionEnabled            = $False
            DeviceThreatProtectionEnabled               = $False
            DeviceThreatProtectionRequiredSecurityLevel = 'Unavailable'
            StorageRequireEncryption                    = $False
            FirewallEnabled                             = $False
            FirewallBlockAllIncoming                    = $False
            FirewallEnableStealthMode                   = $False
            Ensure                                      = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Comliance Policy for MacOS.

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
        IntuneDeviceCompliancePolicyMacOS 'ConfigureDeviceCompliancePolicyMacOS'
        {
            DisplayName                                 = 'MacOS DSC Policy'
            Description                                 = 'Test policy'
            PasswordRequired                            = $False
            PasswordBlockSimple                         = $False
            PasswordExpirationDays                      = 365
            PasswordMinimumLength                       = 8 # Updated Property
            PasswordMinutesOfInactivityBeforeLock       = 5
            PasswordPreviousPasswordBlockCount          = 13
            PasswordMinimumCharacterSetCount            = 1
            PasswordRequiredType                        = 'DeviceDefault'
            OsMinimumVersion                            = 10
            OsMaximumVersion                            = 13
            SystemIntegrityProtectionEnabled            = $False
            DeviceThreatProtectionEnabled               = $False
            DeviceThreatProtectionRequiredSecurityLevel = 'Unavailable'
            StorageRequireEncryption                    = $False
            FirewallEnabled                             = $False
            FirewallBlockAllIncoming                    = $False
            FirewallEnableStealthMode                   = $False
            Ensure                                      = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Comliance Policy for MacOS.

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
        IntuneDeviceCompliancePolicyMacOS 'ConfigureDeviceCompliancePolicyMacOS'
        {
            DisplayName                                 = 'MacOS DSC Policy'
            Ensure                                      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

