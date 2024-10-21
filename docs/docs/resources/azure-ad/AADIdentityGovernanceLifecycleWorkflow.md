# AADIdentityGovernanceLifecycleWorkflow

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Specifies the Display Name of the Workflow | |
| **Description** | Write | String | Description of the Workflow | |
| **Category** | Write | String | Category of the Workflow | |
| **IsEnabled** | Write | Boolean | Indicates if the Workflow is enabled | |
| **IsSchedulingEnabled** | Write | Boolean | Indicates if scheduling is enabled for the Workflow | |
| **Tasks** | Write | MSFT_AADIdentityGovernanceTask[] | Tasks associated with this workflow | |
| **ExecutionConditions** | Write | MSFT_IdentityGovernanceWorkflowExecutionConditions | ExecutionConditions for this workflow | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_IdentityGovernanceScope

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **OdataType** | Write | String | The @odata.type for the Scope. | |
| **Rule** | Write | String | The rule associated with the Scope. | |

### MSFT_IdentityGovernanceTrigger

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **OdataType** | Write | String | The @odata.type for the Trigger. | |
| **TimeBasedAttribute** | Write | String | The time-based attribute for the Trigger. | |
| **OffsetInDays** | Write | SInt32 | The offset in days for the Trigger. | |

### MSFT_IdentityGovernanceWorkflowExecutionConditions

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **OdataType** | Write | String | The @odata.type for the Workflow Execution Conditions. | |
| **ScopeValue** | Write | MSFT_IdentityGovernanceScope | The scope for the Workflow Execution Conditions. | |
| **TriggerValue** | Write | MSFT_IdentityGovernanceTrigger | The trigger for the Workflow Execution Conditions. | |

### MSFT_AADIdentityGovernanceTaskArguments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | The name of the key | |
| **Value** | Write | String | The value associated with the key | |

### MSFT_AADIdentityGovernanceTask

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Write | String | Specifies the display name of the Workflow Task | |
| **Description** | Write | String | Description of the Workflow Task | |
| **Category** | Write | String | Category of the Workflow Task | |
| **IsEnabled** | Write | Boolean | Indicates if the Workflow Task is enabled or not | |
| **ExecutionSequence** | Write | SInt32 | The sequence in which the task is executed | |
| **ContinueOnError** | Write | Boolean | Specifies whether the task should continue on error | |
| **TaskDefinitionId** | Write | String | ID of the task definition associated with this Workflow Task | |
| **Arguments** | Write | MSFT_AADIdentityGovernanceTaskArguments[] | Arguments for the Workflow Task | |


## Description

Use this resource to manage Lifecycle workflows.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - LifecycleWorkflows.Read.All

- **Update**

    - LifecycleWorkflows.ReadWrite.All

#### Application permissions

- **Read**

    - LifecycleWorkflows.Read.All

- **Update**

    - LifecycleWorkflows.ReadWrite.All

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
        AADIdentityGovernanceLifecycleWorkflow "AADIdentityGovernanceLifecycleWorkflow-Onboard pre-hire employee updated version"
        {
            Category             = "joiner";
            Description          = "Description the onboard of prehire employee";
            DisplayName          = "Onboard pre-hire employee updated version";
            Ensure               = "Present";
            ExecutionConditions  = MSFT_IdentityGovernanceWorkflowExecutionConditions {
                ScopeValue = MSFT_IdentityGovernanceScope {
                    Rule = '(not (country eq ''Brazil''))'
                    ODataType = '#microsoft.graph.identityGovernance.ruleBasedSubjectSet'
                }
                TriggerValue = MSFT_IdentityGovernanceTrigger {
                    OffsetInDays = 4
                    TimeBasedAttribute = 'employeeHireDate'
                    ODataType = '#microsoft.graph.identityGovernance.timeBasedAttributeTrigger'
                }
                ODataType = '#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions'
            };
            IsEnabled            = $True;
            IsSchedulingEnabled  = $False;
            Tasks                = @(
                MSFT_AADIdentityGovernanceTask {
                    DisplayName       = 'Add user to groups'
                    Description       = 'Add user to selected groups'
                    Category          = 'joiner,leaver,mover'
                    IsEnabled         = $True
                    ExecutionSequence = 1
                    ContinueOnError   = $True
                    TaskDefinitionId   = '22085229-5809-45e8-97fd-270d28d66910'
                    Arguments         = @(
                        MSFT_AADIdentityGovernanceTaskArguments {
                            Name  = 'groupID'
                            Value = '7ad01e00-8c3a-42a6-baaf-39f2390b2565'
                        }
                    )
                }
            );
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        AADIdentityGovernanceLifecycleWorkflow "AADIdentityGovernanceLifecycleWorkflow-Onboard pre-hire employee updated version"
        {
            Category             = "joiner";
            #updated description
            Description          = "Updated description the onboard of prehire employee";
            DisplayName          = "Onboard pre-hire employee updated version";
            Ensure               = "Present";
            ExecutionConditions  = MSFT_IdentityGovernanceWorkflowExecutionConditions {
                ScopeValue = MSFT_IdentityGovernanceScope {
                    #updated rule
                    Rule = '(not (country eq ''America''))'
                    ODataType = '#microsoft.graph.identityGovernance.ruleBasedSubjectSet'
                }
                TriggerValue = MSFT_IdentityGovernanceTrigger {
                    OffsetInDays = 4
                    TimeBasedAttribute = 'employeeHireDate'
                    ODataType = '#microsoft.graph.identityGovernance.timeBasedAttributeTrigger'
                }
                ODataType = '#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions'
            };
            IsEnabled            = $True;
            IsSchedulingEnabled  = $False;
            Tasks                = @(
                MSFT_AADIdentityGovernanceTask {
                    DisplayName       = 'Add user to groups'
                    #updated description
                    Description       = 'Add user to selected groups updated'
                    Category          = 'joiner,leaver,mover'
                    IsEnabled         = $True
                    ExecutionSequence = 1
                    ContinueOnError   = $True
                    TaskDefinitionId   = '22085229-5809-45e8-97fd-270d28d66910'
                    Arguments         = @(
                        MSFT_AADIdentityGovernanceTaskArguments {
                            Name  = 'groupID'
                            Value = '7ad01e00-8c3a-42a6-baaf-39f2390b2565'
                        }
                    )
                }
            );
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        AADIdentityGovernanceLifecycleWorkflow "AADIdentityGovernanceLifecycleWorkflow-Onboard pre-hire employee updated version"
        {
            Category             = "joiner";
            Description          = "Updated description the onboard of prehire employee";
            DisplayName          = "Onboard pre-hire employee updated version";
            Ensure               = "Absent";
            ExecutionConditions  = MSFT_IdentityGovernanceWorkflowExecutionConditions {
                ScopeValue = MSFT_IdentityGovernanceScope {
                    Rule = '(not (country eq ''America''))'
                    ODataType = '#microsoft.graph.identityGovernance.ruleBasedSubjectSet'
                }
                TriggerValue = MSFT_IdentityGovernanceTrigger {
                    OffsetInDays = 4
                    TimeBasedAttribute = 'employeeHireDate'
                    ODataType = '#microsoft.graph.identityGovernance.timeBasedAttributeTrigger'
                }
                ODataType = '#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions'
            };
            IsEnabled            = $True;
            IsSchedulingEnabled  = $False;
            Tasks                = @(
                MSFT_AADIdentityGovernanceTask {
                    DisplayName       = 'Add user to groups'
                    Description       = 'Add user to selected groups updated'
                    Category          = 'joiner,leaver,mover'
                    IsEnabled         = $True
                    ExecutionSequence = 1
                    ContinueOnError   = $True
                    TaskDefinitionId   = '22085229-5809-45e8-97fd-270d28d66910'
                    Arguments         = @(
                        MSFT_AADIdentityGovernanceTaskArguments {
                            Name  = 'groupID'
                            Value = '7ad01e00-8c3a-42a6-baaf-39f2390b2565'
                        }
                    )
                }
            );
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

