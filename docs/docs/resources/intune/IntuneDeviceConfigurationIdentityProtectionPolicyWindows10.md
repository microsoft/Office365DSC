# IntuneDeviceConfigurationIdentityProtectionPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EnhancedAntiSpoofingForFacialFeaturesEnabled** | Write | Boolean | Boolean value used to enable enhanced anti-spoofing for facial feature recognition on Windows Hello face authentication. | |
| **PinExpirationInDays** | Write | UInt32 | Integer value specifies the period (in days) that a PIN can be used before the system requires the user to change it. Valid values are 0 to 730 inclusive. Valid values 0 to 730 | |
| **PinLowercaseCharactersUsage** | Write | String | This value configures the use of lowercase characters in the Windows Hello for Business PIN. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **PinMaximumLength** | Write | UInt32 | Integer value that sets the maximum number of characters allowed for the work PIN. Valid values are 4 to 127 inclusive and greater than or equal to the value set for the minimum PIN. Valid values 4 to 127 | |
| **PinMinimumLength** | Write | UInt32 | Integer value that sets the minimum number of characters required for the Windows Hello for Business PIN. Valid values are 4 to 127 inclusive and less than or equal to the value set for the maximum PIN. Valid values 4 to 127 | |
| **PinPreviousBlockCount** | Write | UInt32 | Controls the ability to prevent users from using past PINs. This must be set between 0 and 50, inclusive, and the current PIN of the user is included in that count. If set to 0, previous PINs are not stored. PIN history is not preserved through a PIN reset. Valid values 0 to 50 | |
| **PinRecoveryEnabled** | Write | Boolean | Boolean value that enables a user to change their PIN by using the Windows Hello for Business PIN recovery service. | |
| **PinSpecialCharactersUsage** | Write | String | Controls the ability to use special characters in the Windows Hello for Business PIN. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **PinUppercaseCharactersUsage** | Write | String | This value configures the use of uppercase characters in the Windows Hello for Business PIN. Possible values are: blocked, required, allowed, notConfigured. | `blocked`, `required`, `allowed`, `notConfigured` |
| **SecurityDeviceRequired** | Write | Boolean | Controls whether to require a Trusted Platform Module (TPM) for provisioning Windows Hello for Business. A TPM provides an additional security benefit in that data stored on it cannot be used on other devices. If set to False, all devices can provision Windows Hello for Business even if there is not a usable TPM. | |
| **UnlockWithBiometricsEnabled** | Write | Boolean | Controls the use of biometric gestures, such as face and fingerprint, as an alternative to the Windows Hello for Business PIN.  If set to False, biometric gestures are not allowed. Users must still configure a PIN as a backup in case of failures. | |
| **UseCertificatesForOnPremisesAuthEnabled** | Write | Boolean | Boolean value that enables Windows Hello for Business to use certificates to authenticate on-premise resources. | |
| **UseSecurityKeyForSignin** | Write | Boolean | Boolean value used to enable the Windows Hello security key as a logon credential. | |
| **WindowsHelloForBusinessBlocked** | Write | Boolean | Boolean value that blocks Windows Hello for Business as a method for signing into Windows. | |
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

Intune Device Configuration Identity Protection Policy for Windows10

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
        IntuneDeviceConfigurationIdentityProtectionPolicyWindows10 'Example'
        {
            Assignments                                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            DisplayName                                  = "identity protection";
            EnhancedAntiSpoofingForFacialFeaturesEnabled = $True;
            Ensure                                       = "Present";
            PinExpirationInDays                          = 5;
            PinLowercaseCharactersUsage                  = "allowed";
            PinMaximumLength                             = 4;
            PinMinimumLength                             = 4;
            PinPreviousBlockCount                        = 3;
            PinRecoveryEnabled                           = $True;
            PinSpecialCharactersUsage                    = "allowed";
            PinUppercaseCharactersUsage                  = "allowed";
            SecurityDeviceRequired                       = $True;
            SupportsScopeTags                            = $True;
            UnlockWithBiometricsEnabled                  = $True;
            UseCertificatesForOnPremisesAuthEnabled      = $True;
            UseSecurityKeyForSignin                      = $True;
            WindowsHelloForBusinessBlocked               = $False;
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
        IntuneDeviceConfigurationIdentityProtectionPolicyWindows10 'Example'
        {
            Assignments                                  = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            DisplayName                                  = "identity protection";
            EnhancedAntiSpoofingForFacialFeaturesEnabled = $True;
            Ensure                                       = "Present";
            PinExpirationInDays                          = 5;
            PinLowercaseCharactersUsage                  = "allowed";
            PinMaximumLength                             = 4;
            PinMinimumLength                             = 4;
            PinPreviousBlockCount                        = 4; # Updated Property
            PinRecoveryEnabled                           = $True;
            PinSpecialCharactersUsage                    = "allowed";
            PinUppercaseCharactersUsage                  = "allowed";
            SecurityDeviceRequired                       = $True;
            SupportsScopeTags                            = $True;
            UnlockWithBiometricsEnabled                  = $True;
            UseCertificatesForOnPremisesAuthEnabled      = $True;
            UseSecurityKeyForSignin                      = $True;
            WindowsHelloForBusinessBlocked               = $False;
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
        IntuneDeviceConfigurationIdentityProtectionPolicyWindows10 'Example'
        {
            DisplayName                                  = "identity protection";
            Ensure                                       = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

