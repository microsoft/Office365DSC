# IntuneDeviceRemediation

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Description of the device health script | |
| **DetectionScriptContent** | Write | String | The entire content of the detection powershell script | |
| **DetectionScriptParameters** | Write | MSFT_MicrosoftGraphdeviceHealthScriptParameter[] | List of ComplexType DetectionScriptParameters objects. | |
| **DeviceHealthScriptType** | Write | String | DeviceHealthScriptType for the script policy. Possible values are: deviceHealthScript, managedInstallerScript. | `deviceHealthScript`, `managedInstallerScript` |
| **DisplayName** | Required | String | Name of the device health script | |
| **EnforceSignatureCheck** | Write | Boolean | Indicates whether the script signature needs be checked | |
| **IsGlobalScript** | Write | Boolean | Indicates whether the script is a global script provided by Microsoft | |
| **Publisher** | Write | String | Name of the device health script publisher | |
| **RemediationScriptContent** | Write | String | The entire content of the remediation powershell script | |
| **RemediationScriptParameters** | Write | MSFT_MicrosoftGraphdeviceHealthScriptParameter[] | List of ComplexType RemediationScriptParameters objects. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tag IDs for the device health script | |
| **RunAs32Bit** | Write | Boolean | Indicate whether PowerShell script(s) should run as 32-bit | |
| **RunAsAccount** | Write | String | Indicates the type of execution context. Possible values are: system, user. | `system`, `user` |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
| **Assignments** | Write | MSFT_IntuneDeviceRemediationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
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

### MSFT_IntuneDeviceRemediationRunSchedule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the schedule. | `#microsoft.graph.deviceHealthScriptRunOnceSchedule`, `#microsoft.graph.deviceHealthScriptHourlySchedule`, `#microsoft.graph.deviceHealthScriptDailySchedule` |
| **Date** | Write | String | The date when to run the schedule. Only applicable when the odataType is a run once schedule. Format: 2024-01-01 | |
| **Interval** | Write | UInt32 | The interval of the schedule. Must be 1 in case of a run once schedule. | |
| **Time** | Write | String | The time when to run the schedule. Only applicable when the dataType is not an hourly schedule. Format: 01:00:00 | |
| **UseUtc** | Write | Boolean | If to use UTC as the time source. Only applicable when the dataType is not an hourly schedule. | |

### MSFT_IntuneDeviceRemediationPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **RunRemediationScript** | Write | Boolean | If the remediation script should be run. | |
| **RunSchedule** | Write | MSFT_IntuneDeviceRemediationRunSchedule | The run schedule of the remediation. | |
| **Assignment** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments | Represents the assignment of the schedule. | |

### MSFT_MicrosoftGraphDeviceHealthScriptParameter

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ApplyDefaultValueWhenNotAssigned** | Write | Boolean | Whether Apply DefaultValue When Not Assigned | |
| **Description** | Write | String | The description of the param | |
| **IsRequired** | Write | Boolean | Whether the param is required | |
| **Name** | Write | String | The name of the param | |
| **DefaultValue** | Write | Boolean | The default value of boolean param | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deviceHealthScriptBooleanParameter`, `#microsoft.graph.deviceHealthScriptIntegerParameter`, `#microsoft.graph.deviceHealthScriptStringParameter` |


## Description

Intune Device Remediation

**Important:** Global scripts only allow the update of the following properties:

* Assignments
* RoleScopeTagIds
* RunAs32Bit
* RunAsAccount


## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example creates a new Device Remediation.

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
        IntuneDeviceRemediation 'ConfigureDeviceRemediation'
        {
            Assignments              = @(
                MSFT_IntuneDeviceRemediationPolicyAssignments{
                    RunSchedule = MSFT_IntuneDeviceRemediationRunSchedule{
                        Date = '2024-01-01'
                        Time = '01:00:00'
                        Interval = 1
                        DataType = '#microsoft.graph.deviceHealthScriptRunOnceSchedule'
                        UseUtc = $False
                    }
                    RunRemediationScript = $False
                    Assignment = MSFT_DeviceManagementConfigurationPolicyAssignments{
                        deviceAndAppManagementAssignmentFilterType = 'none'
                        dataType = '#microsoft.graph.groupAssignmentTarget'
                        groupId = '11111111-1111-1111-1111-111111111111'
                    }
                }
            );
            Description              = 'Description'
            DetectionScriptContent   = "Base64 encoded script content";
            DeviceHealthScriptType   = "deviceHealthScript";
            DisplayName              = "Device remediation";
            EnforceSignatureCheck    = $False;
            Ensure                   = "Present";
            Id                       = '00000000-0000-0000-0000-000000000000'
            Publisher                = "Some Publisher";
            RemediationScriptContent = "Base64 encoded script content";
            RoleScopeTagIds          = @("0");
            RunAs32Bit               = $True;
            RunAsAccount             = "system";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example updates a new Device Remediation.

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
        IntuneDeviceRemediation 'ConfigureDeviceRemediation'
        {
            Assignments              = @(
                MSFT_IntuneDeviceRemediationPolicyAssignments{
                    RunSchedule = MSFT_IntuneDeviceRemediationRunSchedule{
                        Date = '2024-01-01'
                        Time = '01:00:00'
                        Interval = 1
                        DataType = '#microsoft.graph.deviceHealthScriptRunOnceSchedule'
                        UseUtc = $False
                    }
                    RunRemediationScript = $False
                    Assignment = MSFT_DeviceManagementConfigurationPolicyAssignments{
                        deviceAndAppManagementAssignmentFilterType = 'none'
                        dataType = '#microsoft.graph.groupAssignmentTarget'
                        groupId = '11111111-1111-1111-1111-111111111111'
                    }
                }
            );
            Description              = 'Description'
            DetectionScriptContent   = "Base64 encoded script content 2"; # Updated property
            DeviceHealthScriptType   = "deviceHealthScript";
            DisplayName              = "Device remediation";
            EnforceSignatureCheck    = $False;
            Ensure                   = "Present";
            Id                       = '00000000-0000-0000-0000-000000000000'
            Publisher                = "Some Publisher";
            RemediationScriptContent = "Base64 encoded script content 2"; # Updated property
            RoleScopeTagIds          = @("0");
            RunAs32Bit               = $True;
            RunAsAccount             = "system";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example removes a Device Remediation.

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
        IntuneDeviceRemediation 'ConfigureDeviceRemediation'
        {
            Id          = '00000000-0000-0000-0000-000000000000'
            DisplayName = 'Device remediation'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

