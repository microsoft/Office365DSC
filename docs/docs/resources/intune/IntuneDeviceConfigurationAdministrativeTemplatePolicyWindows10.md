# IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | User provided description for the resource object. | |
| **DisplayName** | Key | String | User provided name for the resource object. | |
| **PolicyConfigurationIngestionType** | Write | String | Type of definitions configured for this policy. Possible values are: unknown, custom, builtIn, mixed, unknownFutureValue. | `unknown`, `custom`, `builtIn`, `mixed`, `unknownFutureValue` |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DefinitionValues** | Write | MSFT_IntuneGroupPolicyDefinitionValue[] | The list of enabled or disabled group policy definition values for the configuration. | |
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

### MSFT_IntuneGroupPolicyDefinitionValueDefinition

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **CategoryPath** | Write | String | The localized full category path for the policy. | |
| **ClassType** | Write | String | Identifies the type of groups the policy can be applied to. Possible values are: user, machine. | `user`, `machine` |
| **DisplayName** | Write | String | The localized policy name. | |
| **ExplainText** | Write | String | The localized explanation or help text associated with the policy. The default value is empty. | |
| **GroupPolicyCategoryId** | Write | String | The category id of the parent category | |
| **HasRelatedDefinitions** | Write | Boolean | Signifies whether or not there are related definitions to this definition | |
| **MinDeviceCspVersion** | Write | String | Minimum required CSP version for device configuration in this definition | |
| **MinUserCspVersion** | Write | String | Minimum required CSP version for user configuration in this definition | |
| **PolicyType** | Write | String | Specifies the type of group policy. Possible values are: admxBacked, admxIngested. | `admxBacked`, `admxIngested` |
| **SupportedOn** | Write | String | Localized string used to specify what operating system or application version is affected by the policy. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |

### MSFT_IntuneGroupPolicyDefinitionValue

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ConfigurationType** | Write | String | Specifies how the value should be configured. This can be either as a Policy or as a Preference. Possible values are: policy, preference. | `policy`, `preference` |
| **Enabled** | Write | Boolean | Enables or disables the associated group policy definition. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Definition** | Write | MSFT_IntuneGroupPolicyDefinitionValueDefinition | The associated group policy definition with the value. Read-Only. | |
| **PresentationValues** | Write | MSFT_IntuneGroupPolicyDefinitionValuePresentationValue[] | The associated group policy presentation values with the definition value. | |

### MSFT_IntuneGroupPolicyDefinitionValuePresentationValue

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **BooleanValue** | Write | Boolean | A value for the associated presentation. | |
| **DecimalValue** | Write | UInt64 | A value for the associated presentation. | |
| **StringValue** | Write | String | A value for the associated presentation. | |
| **KeyValuePairValues** | Write | MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair[] | A list of pairs for the associated presentation. | |
| **StringValues** | Write | StringArray[] | A list of pairs for the associated presentation. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **PresentationDefinitionId** | Write | String | The unique identifier for presentation definition. Read-only. | |
| **PresentationDefinitionLabel** | Write | String | The label of the presentation definition. Read-only. | |
| **odataType** | Write | String | A value for the associated presentation. | `#microsoft.graph.groupPolicyPresentationValueBoolean`, `#microsoft.graph.groupPolicyPresentationValueDecimal`, `#microsoft.graph.groupPolicyPresentationValueList`, `#microsoft.graph.groupPolicyPresentationValueLongDecimal`, `#microsoft.graph.groupPolicyPresentationValueMultiText`, `#microsoft.graph.groupPolicyPresentationValueText` |

### MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Value** | Write | String | Value for this key-value pair. | |
| **Name** | Write | String | Name for this key-value pair. | |


## Description

Intune Device Configuration Administrative Template Policy for Windows10

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
        IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10 'Example'
        {
            Assignments                      = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            )
            DefinitionValues                 = @(
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType = 'policy'
                    Id                = 'f41bbbec-0807-4ae3-8a61-5580a2f310f0'
                    Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '50b2626d-f092-4e71-8983-12a5c741ebe0'
                        DisplayName  = 'Do not display the lock screen'
                        CategoryPath = '\Control Panel\Personalization'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Windows Server 2012, Windows 8 or Windows RT'
                        ClassType    = 'machine'
                    }
                    Enabled           = $False
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType  = 'policy'
                    PresentationValues = @(
                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '98210829-af9b-4020-8d96-3e4108557a95'
                            presentationDefinitionLabel = 'Types of extensions/apps that are allowed to be installed'
                            KeyValuePairValues          = @(
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                {
                                    Name = 'hosted_app'
                                }

                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                {
                                    Name = 'user_script'
                                }
                            )
                            Id                          = '7312a452-e087-4290-9b9f-3f14a304c18d'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueList'
                        }
                    )
                    Id                 = 'f3047f6a-550e-4b5e-b3da-48fc951b72fc'
                    Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '37ab8b81-47d7-46d8-8b99-81d9cecdcce9'
                        DisplayName  = 'Configure allowed app/extension types'
                        CategoryPath = '\Google\Google Chrome\Extensions'
                        PolicyType   = 'admxIngested'
                        SupportedOn  = 'Microsoft Windows 7 or later'
                        ClassType    = 'machine'
                    }
                    Enabled            = $True
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType  = 'policy'
                    PresentationValues = @(
                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = 'a8a0ae11-58d9-41d5-b258-1c16d9f1e328'
                            presentationDefinitionLabel = 'Password Length'
                            DecimalValue                = 15
                            Id                          = '14c48993-35af-4b77-a4f8-12de917b1bb9'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                        }

                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '98998e7f-cc2a-4d96-8c47-35dd4b2ce56b'
                            presentationDefinitionLabel = 'Password Age (Days)'
                            DecimalValue                = 30
                            Id                          = '4d654df9-6826-470f-af4e-d37491663c76'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                        }

                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '6900e752-4bc3-463b-9fc8-36d78c77bc3e'
                            presentationDefinitionLabel = 'Password Complexity'
                            StringValue                 = '4'
                            Id                          = '17e2ff15-8573-4e7e-a6f9-64baebcb5312'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueText'
                        }
                    )
                    Id                 = '426c9e99-0084-443a-ae07-b8f40c11910f'
                    Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = 'c4df131a-d415-44fc-9254-a717ff7dbee3'
                        DisplayName  = 'Password Settings'
                        CategoryPath = '\LAPS'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Microsoft Windows Vista or Windows Server 2003 family'
                        ClassType    = 'machine'
                    }
                    Enabled            = $True
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType = 'policy'
                    Id                = 'a3577119-b240-4093-842c-d8e959dfe317'
                    Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '986073b6-e149-495f-a131-aa0e3c697225'
                        DisplayName  = 'Ability to change properties of an all user remote access connection'
                        CategoryPath = '\Network\Network Connections'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Windows 2000 Service Pack 1'
                        ClassType    = 'user'
                    }
                    Enabled           = $True
                }
            )
            Description                      = ''
            DisplayName                      = 'admin template'
            Ensure                           = 'Present'
            PolicyConfigurationIngestionType = 'unknown'
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
        IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10 'Example'
        {
            Assignments                      = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments
                {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            )
            DefinitionValues                 = @(
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType = 'policy'
                    Id                = 'f41bbbec-0807-4ae3-8a61-5580a2f310f0'
                    Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '50b2626d-f092-4e71-8983-12a5c741ebe0'
                        DisplayName  = 'Do not display the lock screen'
                        CategoryPath = '\Control Panel\Personalization'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Windows Server 2012, Windows 8 or Windows RT'
                        ClassType    = 'machine'
                    }
                    Enabled           = $False
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType  = 'policy'
                    PresentationValues = @(
                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '98210829-af9b-4020-8d96-3e4108557a95'
                            presentationDefinitionLabel = 'Types of extensions/apps that are allowed to be installed'
                            KeyValuePairValues          = @(
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                {
                                    Name = 'hosted_app'
                                }

                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                {
                                    Name = 'user_script'
                                }
                            )
                            Id                          = '7312a452-e087-4290-9b9f-3f14a304c18d'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueList'
                        }
                    )
                    Id                 = 'f3047f6a-550e-4b5e-b3da-48fc951b72fc'
                    Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '37ab8b81-47d7-46d8-8b99-81d9cecdcce9'
                        DisplayName  = 'Configure allowed app/extension types'
                        CategoryPath = '\Google\Google Chrome\Extensions'
                        PolicyType   = 'admxIngested'
                        SupportedOn  = 'Microsoft Windows 7 or later'
                        ClassType    = 'machine'
                    }
                    Enabled            = $True
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType  = 'policy'
                    PresentationValues = @(
                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = 'a8a0ae11-58d9-41d5-b258-1c16d9f1e328'
                            presentationDefinitionLabel = 'Password Length'
                            DecimalValue                = 15
                            Id                          = '14c48993-35af-4b77-a4f8-12de917b1bb9'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                        }

                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '98998e7f-cc2a-4d96-8c47-35dd4b2ce56b'
                            presentationDefinitionLabel = 'Password Age (Days)'
                            DecimalValue                = 30
                            Id                          = '4d654df9-6826-470f-af4e-d37491663c76'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                        }

                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                        {
                            presentationDefinitionId    = '6900e752-4bc3-463b-9fc8-36d78c77bc3e'
                            presentationDefinitionLabel = 'Password Complexity'
                            StringValue                 = '4'
                            Id                          = '17e2ff15-8573-4e7e-a6f9-64baebcb5312'
                            odataType                   = '#microsoft.graph.groupPolicyPresentationValueText'
                        }
                    )
                    Id                 = '426c9e99-0084-443a-ae07-b8f40c11910f'
                    Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = 'c4df131a-d415-44fc-9254-a717ff7dbee3'
                        DisplayName  = 'Password Settings'
                        CategoryPath = '\LAPS'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Microsoft Windows Vista or Windows Server 2003 family'
                        ClassType    = 'machine'
                    }
                    Enabled            = $True
                }
                MSFT_IntuneGroupPolicyDefinitionValue
                {
                    ConfigurationType = 'policy'
                    Id                = 'a3577119-b240-4093-842c-d8e959dfe317'
                    Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                    {
                        Id           = '986073b6-e149-495f-a131-aa0e3c697225'
                        DisplayName  = 'Ability to change properties of an all user remote access connection'
                        CategoryPath = '\Network\Network Connections'
                        PolicyType   = 'admxBacked'
                        SupportedOn  = 'At least Windows 2000 Service Pack 1'
                        ClassType    = 'user'
                    }
                    Enabled           = $True
                }
            )
            Description                      = ''
            DisplayName                      = 'admin template'
            Ensure                           = 'Present'
            PolicyConfigurationIngestionType = 'builtIn' # Updated Property
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
        IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10 'Example'
        {
            DisplayName                      = 'admin template'
            Ensure                           = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

