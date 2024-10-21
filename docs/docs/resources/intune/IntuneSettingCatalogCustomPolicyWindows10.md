# IntuneSettingCatalogCustomPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **Name** | Key | String | Policy name | |
| **Platforms** | Write | String | Platforms for this policy. Possible values are: none, android, iOS, macOS, windows10X, windows10, linux, unknownFutureValue. | `none`, `android`, `iOS`, `macOS`, `windows10X`, `windows10`, `linux`, `unknownFutureValue` |
| **Technologies** | Write | String | Technologies for this policy. Possible values are: none, mdm, windows10XManagement, configManager, appleRemoteManagement, microsoftSense, exchangeOnline, edgeMAM, linuxMdm, enrollment, endpointPrivilegeManagement, unknownFutureValue. | `none`, `mdm`, `windows10XManagement`, `configManager`, `appleRemoteManagement`, `microsoftSense`, `exchangeOnline`, `linuxMdm`, `enrollment`, `endpointPrivilegeManagement`, `unknownFutureValue` |
| **TemplateReference** | Write | MSFT_MicrosoftGraphdeviceManagementConfigurationPolicyTemplateReference | Template reference information | |
| **Settings** | Write | MSFT_MicrosoftGraphdeviceManagementConfigurationSetting[] | Policy settings | |
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

### MSFT_MicrosoftGraphDeviceManagementConfigurationPolicyTemplateReference

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **TemplateDisplayName** | Write | String | Template Display Name of the referenced template. This property is read-only. | |
| **TemplateDisplayVersion** | Write | String | Template Display Version of the referenced Template. This property is read-only. | |
| **TemplateFamily** | Write | String | Template Family of the referenced Template. This property is read-only. Possible values are: none, endpointSecurityAntivirus, endpointSecurityDiskEncryption, endpointSecurityFirewall, endpointSecurityEndpointDetectionAndResponse, endpointSecurityAttackSurfaceReduction, endpointSecurityAccountProtection, endpointSecurityApplicationControl, endpointSecurityEndpointPrivilegeManagement, enrollmentConfiguration, appQuietTime, baseline, unknownFutureValue, deviceConfigurationScripts. | `none`, `endpointSecurityAntivirus`, `endpointSecurityDiskEncryption`, `endpointSecurityFirewall`, `endpointSecurityEndpointDetectionAndResponse`, `endpointSecurityAttackSurfaceReduction`, `endpointSecurityAccountProtection`, `endpointSecurityApplicationControl`, `endpointSecurityEndpointPrivilegeManagement`, `enrollmentConfiguration`, `appQuietTime`, `baseline`, `unknownFutureValue`, `deviceConfigurationScripts` |
| **TemplateId** | Write | String | Template id | |

### MSFT_MicrosoftGraphDeviceManagementConfigurationSetting

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SettingInstance** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance | Setting Instance | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |

### MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SettingDefinitionId** | Write | String | Setting Definition Id | |
| **SettingInstanceTemplateReference** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstanceTemplateReference | Setting Instance Template Reference | |
| **ChoiceSettingCollectionValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue[] | Choice setting collection value | |
| **ChoiceSettingValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue | Choice setting value | |
| **GroupSettingCollectionValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationGroupSettingValue[] | A collection of GroupSetting values | |
| **GroupSettingValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationGroupSettingValue | GroupSetting value | |
| **SimpleSettingCollectionValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue[] | Simple setting collection instance value | |
| **SimpleSettingValue** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue | Simple setting instance value | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance`, `#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance`, `#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance`, `#microsoft.graph.deviceManagementConfigurationGroupSettingInstance`, `#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionInstance`, `#microsoft.graph.deviceManagementConfigurationSettingGroupInstance`, `#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance`, `#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance` |

### MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstanceTemplateReference

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SettingInstanceTemplateId** | Write | String | Setting instance template id | |

### MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Children** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance[] | Child settings. | |
| **Value** | Write | String | Choice setting value: an OptionDefinition ItemId. | |
| **SettingValueTemplateReference** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingValueTemplateReference | Setting value template reference | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deviceManagementConfigurationChoiceSettingValue`, `#microsoft.graph.deviceManagementConfigurationGroupSettingValue`, `#microsoft.graph.deviceManagementConfigurationSimpleSettingValue` |

### MSFT_MicrosoftGraphDeviceManagementConfigurationSettingValueTemplateReference

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **settingValueTemplateId** | Write | String | Setting value template id | |
| **useTemplateDefault** | Write | Boolean | Indicates whether to update policy setting value to match template setting default value | |

### MSFT_MicrosoftGraphDeviceManagementConfigurationGroupSettingValue

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Children** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance[] | Collection of child setting instances contained within this GroupSetting | |
| **SettingValueTemplateReference** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingValueTemplateReference | Setting value template reference | |
| **Value** | Write | String | Choice setting value: an OptionDefinition ItemId. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deviceManagementConfigurationChoiceSettingValue`, `#microsoft.graph.deviceManagementConfigurationGroupSettingValue`, `#microsoft.graph.deviceManagementConfigurationSimpleSettingValue` |

### MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IntValue** | Write | UInt32 | Value of the integer setting. | |
| **StringValue** | Write | String | Value of the string setting. | |
| **ValueState** | Write | String | Gets or sets a value indicating the encryption state of the Value property. Possible values are: invalid, notEncrypted, encryptedValueToken. | `invalid`, `notEncrypted`, `encryptedValueToken` |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.deviceManagementConfigurationIntegerSettingValue`, `#microsoft.graph.deviceManagementConfigurationStringSettingValue`, `#microsoft.graph.deviceManagementConfigurationSecretSettingValue` |
| **SettingValueTemplateReference** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingValueTemplateReference | Setting value template reference | |
| **Children** | Write | MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance[] | Child settings. | |


## Description

Intune Setting Catalog Custom Policy for Windows10

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
        IntuneSettingCatalogCustomPolicyWindows10 'Example'
        {
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            Description           = "";
            Ensure                = "Present";
            Name                  = "Setting Catalog Raw - DSC";
            Platforms             = "windows10";
            Settings              = @(
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_defaultassociationsconfiguration'
                        simpleSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue{
                            odataType = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                            StringValue = ''
                        }
                        odataType = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowarchivescanning_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowarchivescanning'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowcloudprotection_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowcloudprotection'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
            );
            Technologies          = "mdm";
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
        IntuneSettingCatalogCustomPolicyWindows10 'Example'
        {
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            Description           = "Updated Description"; # Updated Property
            Ensure                = "Present";
            Name                  = "Setting Catalog Raw - DSC";
            Platforms             = "windows10";
            Settings              = @(
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_defaultassociationsconfiguration'
                        simpleSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue{
                            odataType = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                            StringValue = ''
                        }
                        odataType = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowarchivescanning_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowarchivescanning'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
                MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                    SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                        choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                            Value = 'device_vendor_msft_policy_config_defender_allowcloudprotection_1'
                        }
                        SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowcloudprotection'
                        odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                    }
                }
            );
            Technologies          = "mdm";
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
        IntuneSettingCatalogCustomPolicyWindows10 'Example'
        {
            Ensure                = "Absent";
            Name                  = "Setting Catalog Raw - DSC";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

