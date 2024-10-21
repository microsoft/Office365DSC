# IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AdvancedThreatProtectionAutoPopulateOnboardingBlob** | Write | Boolean | Auto populate onboarding blob programmatically from Advanced Threat protection service | |
| **AdvancedThreatProtectionOffboardingBlob** | Write | String | Windows Defender AdvancedThreatProtection Offboarding Blob. | |
| **AdvancedThreatProtectionOffboardingFilename** | Write | String | Name of the file from which AdvancedThreatProtectionOffboardingBlob was obtained. | |
| **AdvancedThreatProtectionOnboardingBlob** | Write | String | Windows Defender AdvancedThreatProtection Onboarding Blob. | |
| **AdvancedThreatProtectionOnboardingFilename** | Write | String | Name of the file from which AdvancedThreatProtectionOnboardingBlob was obtained. | |
| **AllowSampleSharing** | Write | Boolean | Windows Defender AdvancedThreatProtection 'Allow Sample Sharing' Rule | |
| **EnableExpeditedTelemetryReporting** | Write | Boolean | Expedite Windows Defender Advanced Threat Protection telemetry reporting frequency. | |
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


## Description

Intune Device Configuration Defender For Endpoint Onboarding Policy for Windows10

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
        IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 'Example'
        {
            AdvancedThreatProtectionAutoPopulateOnboardingBlob = $False;
            AdvancedThreatProtectionOnboardingBlob             = "<EncryptedMessage xmlns=`"http://schemas.datacontract.org/2004/07/Microsoft.Management.Services.Common.Cryptography`" xmlns:i=`"http://www.w3.org/2001/XMLSchema-instance`"><EncryptedContent>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</EncryptedContent><RecipientCertThumbprints xmlns:a=`"http://schemas.microsoft.com/2003/10/Serialization/Arrays`"><a:string>D97F84CD027F883C2A6A7B4F1B8A194EF3042369</a:string></RecipientCertThumbprints></EncryptedMessage>";
            AdvancedThreatProtectionOnboardingFilename         = "WindowsDefenderATP.onboarding";
            AllowSampleSharing                                 = $True;
            Assignments                                        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName                                        = "MDE onboarding Legacy";
            EnableExpeditedTelemetryReporting                  = $True;
            Ensure                                             = "Present";
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
        IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 'Example'
        {
            AdvancedThreatProtectionAutoPopulateOnboardingBlob = $True; # Updated Property
            AdvancedThreatProtectionOnboardingFilename         = "WindowsDefenderATP.onboarding";
            AllowSampleSharing                                 = $True;
            Assignments                                        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName                                        = "MDE onboarding Legacy";
            EnableExpeditedTelemetryReporting                  = $True;
            Ensure                                             = "Present";
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
        IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 'Example'
        {
            DisplayName                                        = "MDE onboarding Legacy";
            Ensure                                             = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

