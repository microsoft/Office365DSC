# IntuneDeviceCompliancePolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the Windows 10 device compliance policy. | |
| **Description** | Write | String | Description of the Windows 10 device compliance policy. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **PasswordRequired** | Write | Boolean | PasswordRequired of the Windows 10 device compliance policy. | |
| **PasswordBlockSimple** | Write | Boolean | PasswordBlockSimple of the Windows 10 device compliance policy. | |
| **PasswordRequiredToUnlockFromIdle** | Write | Boolean | PasswordRequiredToUnlockFromIdle of the Windows 10 device compliance policy. | |
| **PasswordMinutesOfInactivityBeforeLock** | Write | UInt32 | PasswordMinutesOfInactivityBeforeLock of the Windows 10 device compliance policy. | |
| **PasswordExpirationDays** | Write | UInt32 | PasswordExpirationDays of the Windows 10 device compliance policy. | |
| **PasswordMinimumLength** | Write | UInt32 | PasswordMinimumLength of the Windows 10 device compliance policy. | |
| **PasswordMinimumCharacterSetCount** | Write | UInt32 | PasswordMinimumCharacterSetCount of the Windows 10 device compliance policy. | |
| **PasswordRequiredType** | Write | String | PasswordRequiredType of the Windows 10 device compliance policy. | `DeviceDefault`, `Alphanumeric`, `Numeric` |
| **PasswordPreviousPasswordBlockCount** | Write | UInt32 | PasswordPreviousPasswordBlockCount of the Windows 10 device compliance policy. | |
| **RequireHealthyDeviceReport** | Write | Boolean | RequireHealthyDeviceReport of the Windows 10 device compliance policy. | |
| **OsMinimumVersion** | Write | String | OsMinimumVersion of the Windows 10 device compliance policy. | |
| **OsMaximumVersion** | Write | String | OsMaximumVersion of the Windows 10 device compliance policy. | |
| **MobileOsMinimumVersion** | Write | String | MobileOsMinimumVersion of the Windows 10 device compliance policy. | |
| **MobileOsMaximumVersion** | Write | String | MobileOsMaximumVersion of the Windows 10 device compliance policy. | |
| **EarlyLaunchAntiMalwareDriverEnabled** | Write | Boolean | EarlyLaunchAntiMalwareDriverEnabled of the Windows 10 device compliance policy. | |
| **BitLockerEnabled** | Write | Boolean | BitLockerEnabled of the Windows 10 device compliance policy. | |
| **SecureBootEnabled** | Write | Boolean | SecureBootEnabled of the Windows 10 device compliance policy. | |
| **CodeIntegrityEnabled** | Write | Boolean | CodeIntegrityEnabled of the Windows 10 device compliance policy. | |
| **StorageRequireEncryption** | Write | Boolean | StorageRequireEncryption of the Windows 10 device compliance policy. | |
| **ActiveFirewallRequired** | Write | Boolean | ActiveFirewallRequired of the Windows 10 device compliance policy. | |
| **DefenderEnabled** | Write | Boolean | DefenderEnabled of the Windows 10 device compliance policy. | |
| **DefenderVersion** | Write | String | DefenderVersion of the Windows 10 device compliance policy. | |
| **SignatureOutOfDate** | Write | Boolean | SignatureOutOfDate of the Windows 10 device compliance policy. | |
| **RTPEnabled** | Write | Boolean | RTPEnabled of the Windows 10 device compliance policy. | |
| **AntivirusRequired** | Write | Boolean | AntivirusRequired of the Windows 10 device compliance policy. | |
| **AntiSpywareRequired** | Write | Boolean | AntiSpywareRequired of the Windows 10 device compliance policy. | |
| **DeviceThreatProtectionEnabled** | Write | Boolean | DeviceThreatProtectionEnabled of the Windows 10 device compliance policy. | |
| **DeviceThreatProtectionRequiredSecurityLevel** | Write | String | DeviceThreatProtectionRequiredSecurityLevel of the Windows 10 device compliance policy. | `Unavailable`, `Secured`, `Low`, `Medium`, `High`, `NotSet` |
| **ConfigurationManagerComplianceRequired** | Write | Boolean | ConfigurationManagerComplianceRequired of the Windows 10 device compliance policy. | |
| **TpmRequired** | Write | Boolean | TpmRequired of the Windows 10 device compliance policy. | |
| **DeviceCompliancePolicyScript** | Write | String | DeviceCompliancePolicyScript of the Windows 10 device compliance policy. | |
| **ValidOperatingSystemBuildRanges** | Write | MSFT_MicrosoftGraphOperatingSystemVersionRange[] | ValidOperatingSystemBuildRanges of the Windows 10 device compliance policy. | |
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

### MSFT_MicrosoftGraphOperatingSystemVersionRange

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | The description of this range (e.g. Valid 1702 builds) | |
| **LowestVersion** | Write | String | The lowest inclusive version that this range contains. | |
| **HighestVersion** | Write | String | The highest inclusive version that this range contains. | |


## Description

This resource configures the settings of Windows 10 compliance policies
in your cloud-based organization.

## Parameters

### Device Health
#### Windows Health Attestation Service evaluation rules
* **Require BitLocker:**
  Windows BitLocker Drive Encryption encrypts all data stored on the Windows operating system volume. BitLocker uses the Trusted Platform Module (TPM) to help protect the Windows operating system and user data. It also helps confirm that a computer isn't tampered with, even if its left unattended, lost, or stolen. If the computer is equipped with a compatible TPM, BitLocker uses the TPM to lock the encryption keys that protect the data. As a result, the keys can't be accessed until the TPM verifies the state of the computer.
  * Not configured _(default)_ - This setting isn't evaluated for compliance or non-compliance.
  * Require - The device can protect data that's stored on the drive from unauthorized access when the system is off, or hibernates.

  Device HealthAttestation CSP - BitLockerStatus

* **Require Secure Boot to be enabled on the device:**
  * Not configured _(default)_ - This setting isn't evaluated for compliance or non-compliance.
  * Require - The system is forced to boot to a factory trusted state. The core components that are used to boot the machine must have correct cryptographic signatures that are trusted by the organization that manufactured the device. The UEFI firmware verifies the signature before it lets the machine start. If any files are tampered with, which breaks their signature, the system doesn't boot.

### Device Properties
#### Operating System Version
To discover build versions for all Windows 10 Feature Updates and Cumulative Updates (to be used in some of the fields below), see Windows 10 release information. Be sure to include the 10.0. prefix before the build numbers, as the following examples illustrate.

* **Minimum OS version:**
  Enter the minimum allowed version in the major.minor.build.revision number format. To get the correct value, open a command prompt, and type ver. The ver command returns the version in the following format:

  Microsoft Windows [Version 10.0.17134.1]

  When a device has an earlier version than the OS version you enter, it's reported as noncompliant. A link with information on how to upgrade is shown. The end user can choose to upgrade their device. After they upgrade, they can access company resources.

* **Maximum OS version:**
  Enter the maximum allowed version, in the major.minor.build.revision number format. To get the correct value, open a command prompt, and type ver. The ver command returns the version in the following format:

  Microsoft Windows [Version 10.0.17134.1]

  When a device is using an OS version later than the version entered, access to organization resources is blocked. The end user is asked to contact their IT administrator. The device can't access organization resources until the rule is changed to allow the OS version.

* **Minimum OS required for mobile devices:**
  Enter the minimum allowed version, in the major.minor.build number format.

  When a device has an earlier version that the OS version you enter, it's reported as noncompliant. A link with information on how to upgrade is shown. The end user can choose to upgrade their device. After they upgrade, they can access company resources.

* **Maximum OS required for mobile devices:**
  Enter the maximum allowed version, in the major.minor.build number.

  When a device is using an OS version later than the version entered, access to organization resources is blocked. The end user is asked to contact their IT administrator. The device can't access organization resources until the rule is changed to allow the OS version.

* **Valid operating system builds:**
  Specify a list of minimum and maximum operating system builds. Valid operating system builds provides additional flexibility when compared against minimum and maximum OS versions. Consider a scenario where minimum OS version is set to 10.0.18362.xxx (Windows 10 1903) and maximum OS version is set to 10.0.18363.xxx (Windows 10 1909). This configuration can allow a Windows 10 1903 device that doesn't have recent cumulative updates installed to be identified as compliant. Minimum and maximum OS versions might be suitable if you have standardized on a single Windows 10 release, but might not address your requirements if you need to use multiple builds, each with specific patch levels. In such a case, consider leveraging valid operating system builds instead, which allows multiple builds to be specified as per the following example.

  Example:
  The following table is an example of a range for the acceptable operating systems versions for different Windows 10 releases. In this example, three different Feature Updates have been allowed (1809, 1909 and 2004). Specifically, only those versions of Windows and which have applied cumulative updates from June to September 2020 will be considered to be compliant. This is sample data only. The table includes a first column that includes any text you want to describe the entry, followed by the minimum and maximum OS version for that entry. The second and third columns must adhere to valid OS build versions in the major.minor.build.revision number format. After you define one or more entries, you can Export the list as a comma-separated values (CSV) file.

  | Description                 | Minimum OS version | Maximum OS version |
  |-----------------------------|--------------------|--------------------|
  | Win 10 2004 (Jun-Sept 2020) | 10.0.19041.329     | 10.0.19041.508     |
  | Win 10 1909 (Jun-Sept 2020) | 10.0.18363.900     | 10.0.18363.1110    |
  | Win 10 1809 (Jun-Sept 2020) | 10.0.17763.1282    | 10.0.17763.1490    |

### Configuration Manager Compliance
Applies only to co-managed devices running Windows 10 and later. Intune-only devices return a not available status.

* **Require device compliance from Configuration Manager:**
  * Not configured _(default)_ - Intune doesn't check for any of the Configuration Manager settings for compliance.
  * Require - Require all settings (configuration items) in Configuration Manager to be compliant.

### System Security
#### Password
* **Require a password to unlock mobile devices:**
  * Not configured _(default)_ - This setting isn't evaluated for compliance or non-compliance.
  * Require - Users must enter a password before they can access their device.

* **Simple passwords:**
  * Not configured _(default)_ - Users can create simple passwords, such as 1234 or 1111.
  * Block - Users can't create simple passwords, such as 1234 or 1111.

* **Password type:**
  Choose the type of password or PIN required. Your options:
  * Device _(default)_  - Require a password, numeric PIN, or alphanumeric PIN
  * Numeric - Require a password or numeric PIN
  * Alphanumeric - Require a password, or alphanumeric PIN.
  When set to Alphanumeric, the following settings are available:

  * Password complexity:
    Your options:
    * Require digits and lowercase letters _(default)_
    * Require digits, lowercase letters, and uppercase letters
    * Require digits, lowercase letters, uppercase letters, and special characters

* **Minimum password length:**
    Enter the minimum number of digits or characters that the password must have.

* **Maximum minutes of inactivity before password is required:**
    Enter the idle time before the user must reenter their password.

* **Password expiration (days):**
    Enter the number of days before the password expires, and they must create a new one, from 1-730.

* **Number of previous passwords to prevent reuse:**
    Enter the number of previously used passwords that can't be used.

* **Require password when device returns from idle state (Mobile and Holographic):**
    * Not configured _(default)_
    * Require - Require device users to enter the password every time the device returns from an idle state.

  **Important**
  When the password requirement is changed on a Windows desktop, users are impacted the next time they sign in, as that's when the device goes from idle to active. Users with passwords that meet the requirement are still prompted to change their passwords.

### Encryption

* **Encryption of data storage on a device:**
  This setting applies to all drives on a device.
  * Not configured _(default)_
  * Require - Use Require to encrypt data storage on your devices.

  **Note**
  The Encryption of data storage on a device setting generically checks for the presence of encryption on the device, more specifically at the OS drive level. Currently, Intune supports only the encryption check with BitLocker. For a more robust encryption setting, consider using Require BitLocker, which leverages Windows Device Health Attestation to validate Bitlocker status at the TPM level.

### Device Security

* **Firewall:**
  * Not configured _(default)_ - Intune doesn't control the Microsoft Defender Firewall, nor change existing settings.
  * Require - Turn on the Microsoft Defender Firewall, and prevent users from turning it off.

  **Note**
  If the device immediately syncs after a reboot, or immediately syncs waking from sleep, then this setting may report as an Error. This scenario might not affect the overall device compliance status. To re-evaluate the compliance status, manually sync the device.

* **Trusted Platform Module (TPM):**
  * Not configured _(default)_ - Intune doesn't check the device for a TPM chip version.
  * Require - Intune checks the TPM chip version for compliance. The device is compliant if the TPM chip version is greater than 0 (zero). The device isn't compliant if there isn't a TPM version on the device.

* **Antivirus:**
  * Not configured _(default)_ - Intune doesn't check for any antivirus solutions installed on the device.
  * Require - Check compliance using antivirus solutions that are registered with Windows Security Center, such as Symantec and Microsoft Defender.

* **Antispyware:**
  * Not configured _(default)_ - Intune doesn't check for any antispyware solutions installed on the device.
  * Require - Check compliance using antispyware solutions that are registered with Windows Security Center, such as Symantec and Microsoft Defender.

### Defender
The following compliance settings are supported with Windows 10 Desktop.

* **Microsoft Defender Antimalware:**
  * Not configured _(default)_ - Intune doesn't control the service, nor change existing settings.
  * Require - Turn on the Microsoft Defender anti-malware service, and prevent users from turning it off.

* **Microsoft Defender Antimalware minimum version:**
  Enter the minimum allowed version of Microsoft Defender anti-malware service. For example, enter 4.11.0.0. When left blank, any version of the Microsoft Defender anti-malware service can be used.

  By _(default)_, no version is configured.

* **Microsoft Defender Antimalware security intelligence up-to-date:**
  Controls the Windows Security virus and threat protection updates on the devices.
  * Not configured _(default)_ - Intune doesn't enforce any requirements.
  * Require - Force the Microsoft Defender security intelligence be up-to-date.

* **Real-time protection:**
  * Not configured (_(default)_) - Intune doesn't control this feature, nor change existing settings.
  * Require - Turn on real-time protection, which scans for malware, spyware, and other unwanted software.

### Microsoft Defender for Endpoint
#### Microsoft Defender for Endpoint rules
For additional information on Microsoft Defender for Endpoint integration in conditional access scenarios, see Configure Conditional Access in Microsoft Defender for Endpoint.

* **Require the device to be at or under the machine risk score:**
  Use this setting to take the risk assessment from your defense threat services as a condition for compliance. Choose the maximum allowed threat level:
  * Not configured (_(default)_)
  * Clear -This option is the most secure, as the device can't have any threats. If the device is detected as having any level of threats, it's evaluated as non-compliant.
  * Low - The device is evaluated as compliant if only low-level threats are present. Anything higher puts the device in a non-compliant status.
  * Medium - The device is evaluated as compliant if existing threats on the device are low or medium level. If the device is detected to have high-level threats, it's determined to be non-compliant.
  * High - This option is the least secure, and allows all threat levels. It may be useful if you're using this solution only for reporting purposes.

### Windows Holographic for Business
Windows Holographic for Business uses the Windows 10 and later platform. Windows Holographic for Business supports the following setting:

**System Security > Encryption > Encryption of data storage on device.**
To verify device encryption on the Microsoft HoloLens, see Verify device encryption.

### Surface Hub
Surface Hub uses the Windows 10 and later platform. Surface Hubs are supported for both compliance and Conditional Access. To enable these features on Surface Hubs, we recommend you enable Windows 10 automatic enrollment in Intune (requires Azure Active Directory (Azure AD)), and target the Surface Hub devices as device groups. Surface Hubs are required to be Azure AD joined for compliance and Conditional Access to work.

For guidance, see set up enrollment for Windows devices.

Special consideration for Surface Hubs running Windows 10 Team OS:
Surface Hubs that run Windows 10 Team OS do not support the Microsoft Defender for Endpoint and Password compliance policies at this time. Therefore, for Surface Hubs that run Windows 10 Team OS set the following two settings to their _(default)_ of _Not configured_:
* In the category Password, set Require a password to unlock mobile devices to the _(default)_ of Not configured.
* In the category Microsoft Defender for Endpoint, set Require the device to be at or under the machine risk score to the _(default)_ of Not configured.

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

This example creates a new Device Comliance Policy for Windows.

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
        IntuneDeviceCompliancePolicyWindows10 'ConfigureDeviceCompliancePolicyWindows10'
        {
            DisplayName                                 = 'Windows 10 DSC Policy'
            Description                                 = 'Test policy'
            PasswordRequired                            = $False
            PasswordBlockSimple                         = $False
            PasswordRequiredToUnlockFromIdle            = $True
            PasswordMinutesOfInactivityBeforeLock       = 15
            PasswordExpirationDays                      = 365
            PasswordMinimumLength                       = 6
            PasswordPreviousPasswordBlockCount          = 13
            PasswordMinimumCharacterSetCount            = 1
            PasswordRequiredType                        = 'Devicedefault'
            RequireHealthyDeviceReport                  = $True
            OsMinimumVersion                            = 10
            OsMaximumVersion                            = 10.19
            MobileOsMinimumVersion                      = 10
            MobileOsMaximumVersion                      = 10.19
            EarlyLaunchAntiMalwareDriverEnabled         = $False
            BitLockerEnabled                            = $False
            SecureBootEnabled                           = $True
            CodeIntegrityEnabled                        = $True
            StorageRequireEncryption                    = $True
            ActiveFirewallRequired                      = $True
            DefenderEnabled                             = $True
            DefenderVersion                             = ''
            SignatureOutOfDate                          = $True
            RtpEnabled                                  = $True
            AntivirusRequired                           = $True
            AntiSpywareRequired                         = $True
            DeviceThreatProtectionEnabled               = $True
            DeviceThreatProtectionRequiredSecurityLevel = 'Medium'
            ConfigurationManagerComplianceRequired      = $False
            TPMRequired                                 = $False
            deviceCompliancePolicyScript                = $null
            ValidOperatingSystemBuildRanges             = @()
            Ensure                                      = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example creates a new Device Comliance Policy for Windows.

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
        IntuneDeviceCompliancePolicyWindows10 'ConfigureDeviceCompliancePolicyWindows10'
        {
            DisplayName                                 = 'Windows 10 DSC Policy'
            Description                                 = 'Test policy'
            PasswordRequired                            = $False
            PasswordBlockSimple                         = $False
            PasswordRequiredToUnlockFromIdle            = $True
            PasswordMinutesOfInactivityBeforeLock       = 15
            PasswordExpirationDays                      = 365
            PasswordMinimumLength                       = 8 # Updated Property
            PasswordPreviousPasswordBlockCount          = 13
            PasswordMinimumCharacterSetCount            = 1
            PasswordRequiredType                        = 'Devicedefault'
            RequireHealthyDeviceReport                  = $True
            OsMinimumVersion                            = 10
            OsMaximumVersion                            = 10.19
            MobileOsMinimumVersion                      = 10
            MobileOsMaximumVersion                      = 10.19
            EarlyLaunchAntiMalwareDriverEnabled         = $False
            BitLockerEnabled                            = $False
            SecureBootEnabled                           = $True
            CodeIntegrityEnabled                        = $True
            StorageRequireEncryption                    = $True
            ActiveFirewallRequired                      = $True
            DefenderEnabled                             = $True
            DefenderVersion                             = ''
            SignatureOutOfDate                          = $True
            RtpEnabled                                  = $True
            AntivirusRequired                           = $True
            AntiSpywareRequired                         = $True
            DeviceThreatProtectionEnabled               = $True
            DeviceThreatProtectionRequiredSecurityLevel = 'Medium'
            ConfigurationManagerComplianceRequired      = $False
            TPMRequired                                 = $False
            deviceCompliancePolicyScript                = $null
            ValidOperatingSystemBuildRanges             = @()
            Ensure                                      = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example creates a new Device Comliance Policy for Windows.

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
        IntuneDeviceCompliancePolicyWindows10 'ConfigureDeviceCompliancePolicyWindows10'
        {
            DisplayName                                 = 'Windows 10 DSC Policy'
            Ensure                                      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

