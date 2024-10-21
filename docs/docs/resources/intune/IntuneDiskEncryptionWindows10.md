# IntuneDiskEncryptionWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **RequireDeviceEncryption** | Write | String | Require Device Encryption (0: Disabled, 1: Enabled) | `0`, `1` |
| **EncryptionMethodWithXts_Name** | Write | String | Choose drive encryption method and cipher strength (Windows 10 [Version 1511] and later) (0: Disabled, 1: Enabled) | `0`, `1` |
| **EncryptionMethodWithXtsOsDropDown_Name** | Write | String | Select the encryption method for operating system drives: (3: AES-CBC 128-bit, 4: AES-CBC 256-bit, 6: XTS-AES 128-bit (default), 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **EncryptionMethodWithXtsFdvDropDown_Name** | Write | String | Select the encryption method for fixed data drives: (3: AES-CBC 128-bit, 4: AES-CBC 256-bit, 6: XTS-AES 128-bit (default), 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **EncryptionMethodWithXtsRdvDropDown_Name** | Write | String | Select the encryption method for removable data drives: (3: AES-CBC 128-bit  (default), 4: AES-CBC 256-bit, 6: XTS-AES 128-bit, 7: XTS-AES 256-bit) | `3`, `4`, `6`, `7` |
| **IdentificationField_Name** | Write | String | Provide the unique identifiers for your organization (0: Disabled, 1: Enabled) | `0`, `1` |
| **IdentificationField** | Write | String | BitLocker identification field: (Device) | |
| **SecIdentificationField** | Write | String | Allowed BitLocker identification field: (Device) | |
| **AllowWarningForOtherDiskEncryption** | Write | String | Allow Warning For Other Disk Encryption (0: Disabled, 1: Enabled) | `0`, `1` |
| **AllowStandardUserEncryption** | Write | String | Allow Standard User Encryption (0: This is the default, when the policy is not set. If current logged on user is a standard user, 'RequireDeviceEncryption' policy will not try to enable encryption on any drive., 1: 'RequireDeviceEncryption' policy will try to enable encryption on all fixed drives even if a current logged in user is standard user.) | `0`, `1` |
| **ConfigureRecoveryPasswordRotation** | Write | String | Configure Recovery Password Rotation (0: Refresh off (default), 1: Refresh on for Azure AD-joined devices, 2: Refresh on for both Azure AD-joined and hybrid-joined devices) | `0`, `1`, `2` |
| **OSEncryptionType_Name** | Write | String | Enforce drive encryption type on operating system drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **ConfigureAdvancedStartup_Name** | Write | String | Require additional authentication at startup (0: Disabled, 1: Enabled) | `0`, `1` |
| **ConfigureTPMStartupKeyUsageDropDown_Name** | Write | String | Configure TPM startup key: (2: Allow startup key with TPM, 1: Require startup key with TPM, 0: Do not allow startup key with TPM) | `2`, `1`, `0` |
| **ConfigureTPMPINKeyUsageDropDown_Name** | Write | String | Configure TPM startup key and PIN: (2: Allow startup key and PIN with TPM, 1: Require startup key and PIN with TPM, 0: Do not allow startup key and PIN with TPM) | `2`, `1`, `0` |
| **ConfigureTPMUsageDropDown_Name** | Write | String | Configure TPM startup: (2: Allow TPM, 1: Require TPM, 0: Do not allow TPM) | `2`, `1`, `0` |
| **ConfigureNonTPMStartupKeyUsage_Name** | Write | String | Allow BitLocker without a compatible TPM (requires a password or a startup key on a USB flash drive) (0: False, 1: True) | `0`, `1` |
| **ConfigurePINUsageDropDown_Name** | Write | String | Configure TPM startup PIN: (2: Allow startup PIN with TPM, 1: Require startup PIN with TPM, 0: Do not allow startup PIN with TPM) | `2`, `1`, `0` |
| **MinimumPINLength_Name** | Write | String | Configure minimum PIN length for startup (0: Disabled, 1: Enabled) | `0`, `1` |
| **MinPINLength** | Write | SInt32 | Minimum characters: | |
| **EnhancedPIN_Name** | Write | String | Allow enhanced PINs for startup (0: Disabled, 1: Enabled) | `0`, `1` |
| **DisallowStandardUsersCanChangePIN_Name** | Write | String | Disallow standard users from changing the PIN or password (0: Disabled, 1: Enabled) | `0`, `1` |
| **EnablePreBootPinExceptionOnDECapableDevice_Name** | Write | String | Allow devices compliant with InstantGo or HSTI to opt out of pre-boot PIN. (0: Disabled, 1: Enabled) | `0`, `1` |
| **EnablePrebootInputProtectorsOnSlates_Name** | Write | String | Enable use of BitLocker authentication requiring preboot keyboard input on slates (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSRecoveryUsage_Name** | Write | String | Choose how BitLocker-protected operating system drives can be recovered (0: Disabled, 1: Enabled) | `0`, `1` |
| **OSRequireActiveDirectoryBackup_Name** | Write | String | Do not enable BitLocker until recovery information is stored to AD DS for operating system drives (0: False, 1: True) | `0`, `1` |
| **OSActiveDirectoryBackup_Name** | Write | String | Save BitLocker recovery information to AD DS for operating system drives (0: False, 1: True) | `0`, `1` |
| **OSRecoveryPasswordUsageDropDown_Name** | Write | String | Configure user storage of BitLocker recovery information: (2: Allow 48-digit recovery password, 1: Require 48-digit recovery password, 0: Do not allow 48-digit recovery password) | `2`, `1`, `0` |
| **OSHideRecoveryPage_Name** | Write | String | Omit recovery options from the BitLocker setup wizard (0: False, 1: True) | `0`, `1` |
| **OSAllowDRA_Name** | Write | String | Allow data recovery agent (0: False, 1: True) | `0`, `1` |
| **OSRecoveryKeyUsageDropDown_Name** | Write | String | Configure OS recovery key usage: (2: Allow 256-bit recovery key, 1: Require 256-bit recovery key, 0: Do not allow 256-bit recovery key) | `2`, `1`, `0` |
| **OSActiveDirectoryBackupDropDown_Name** | Write | String | Configure storage of BitLocker recovery information to AD DS: (1: Store recovery passwords and key packages, 2: Store recovery passwords only) | `1`, `2` |
| **PrebootRecoveryInfo_Name** | Write | String | Configure pre-boot recovery message and URL (0: Disabled, 1: Enabled) | `0`, `1` |
| **PrebootRecoveryInfoDropDown_Name** | Write | String | Select an option for the pre-boot recovery message: (0: , 1: Use default recovery message and URL, 2: Use custom recovery message, 3: Use custom recovery URL) | `0`, `1`, `2`, `3` |
| **RecoveryUrl_Input** | Write | String | Custom recovery URL option: | |
| **RecoveryMessage_Input** | Write | String | Custom recovery message option: | |
| **FDVEncryptionType_Name** | Write | String | Enforce drive encryption type on fixed data drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **FDVEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **FDVRecoveryUsage_Name** | Write | String | Choose how BitLocker-protected fixed drives can be recovered (0: Disabled, 1: Enabled) | `0`, `1` |
| **FDVActiveDirectoryBackup_Name** | Write | String | Save BitLocker recovery information to AD DS for fixed data drives (0: False, 1: True) | `0`, `1` |
| **FDVHideRecoveryPage_Name** | Write | String | Omit recovery options from the BitLocker setup wizard (0: False, 1: True) | `0`, `1` |
| **FDVRecoveryPasswordUsageDropDown_Name** | Write | String | Configure user storage of BitLocker recovery information: (2: Allow 48-digit recovery password, 1: Require 48-digit recovery password, 0: Do not allow 48-digit recovery password) | `2`, `1`, `0` |
| **FDVRequireActiveDirectoryBackup_Name** | Write | String | Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives (0: False, 1: True) | `0`, `1` |
| **FDVAllowDRA_Name** | Write | String | Allow data recovery agent (0: False, 1: True) | `0`, `1` |
| **FDVActiveDirectoryBackupDropDown_Name** | Write | String | Configure storage of BitLocker recovery information to AD DS: (1: Backup recovery passwords and key packages, 2: Backup recovery passwords only) | `1`, `2` |
| **FDVRecoveryKeyUsageDropDown_Name** | Write | String | Select the fixed drive recovery key usage: (2: Allow 256-bit recovery key, 1: Require 256-bit recovery key, 0: Do not allow 256-bit recovery key) | `2`, `1`, `0` |
| **FDVDenyWriteAccess_Name** | Write | String | Deny write access to fixed drives not protected by BitLocker (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVConfigureBDE** | Write | String | Control use of BitLocker on removable drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVAllowBDE_Name** | Write | String | Allow users to apply BitLocker protection on removable data drives (Device) (0: False, 1: True) | `0`, `1` |
| **RDVEncryptionType_Name** | Write | String | Enforce drive encryption type on removable data drives (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVEncryptionTypeDropDown_Name** | Write | String | Select the encryption type: (Device) (0: Allow user to choose (default), 1: Full encryption, 2: Used Space Only encryption) | `0`, `1`, `2` |
| **RDVDisableBDE_Name** | Write | String | Allow users to suspend and decrypt BitLocker protection on removable data drives (Device) (0: False, 1: True) | `0`, `1` |
| **RDVDenyWriteAccess_Name** | Write | String | Deny write access to removable drives not protected by BitLocker (0: Disabled, 1: Enabled) | `0`, `1` |
| **RDVCrossOrg** | Write | String | Do not allow write access to devices configured in another organization (0: False, 1: True) | `0`, `1` |
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

Intune Disk Encryption for Windows10

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

    Node localhost
    {
        IntuneDiskEncryptionWindows10 'myDiskEncryption'
        {
            DisplayName        = 'Disk Encryption'
            Assignments        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                })
            Description        = ''
            IdentificationField_Name = '1'
            IdentificationField = 'IdentificationField'
            SecIdentificationField = 'SecIdentificationField'
            Ensure             = 'Present'
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

    Node localhost
    {
        IntuneDiskEncryptionWindows10 'myDiskEncryption'
        {
            DisplayName        = 'Disk Encryption'
            Assignments        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                })
            Description        = ''
            IdentificationField_Name = '1'
            IdentificationField = 'IdentificationField'
            SecIdentificationField = 'UpdatedSecIdentificationField' # Updated property
            Ensure             = 'Present'
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

    Node localhost
    {
        IntuneDiskEncryptionWindows10 'myDiskEncryption'
        {
            DisplayName        = 'Disk Encryption'
            Description        = ''
            Ensure             = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

