# AADRoleManagementPolicyRule

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **id** | Key | String | The unique identifier for an entity. Read-only. | |
| **roleDisplayName** | Key | String | Role display name. | |
| **ruleType** | Write | String | Rule Type. | |
| **policyId** | Write | String | Policy Id. | |
| **expirationRule** | Write | MSFT_AADRoleManagementPolicyExpirationRule | Expiration Rule. | |
| **notificationRule** | Write | MSFT_AADRoleManagementPolicyNotificationRule | Notification Rule. | |
| **enablementRule** | Write | MSFT_AADRoleManagementPolicyEnablementRule | Enablement Rule. | |
| **approvalRule** | Write | MSFT_AADRoleManagementPolicyApprovalRule | Approval Rule. | |
| **authenticationContextRule** | Write | MSFT_AADRoleManagementPolicyAuthenticationContextRule | Authentication Context Rule. | |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADRoleManagementPolicyExpirationRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **isExpirationRequired** | Write | Boolean | Specifies if expiration is required. | |
| **maximumDuration** | Write | String | The maximum duration for the expiration. | |

### MSFT_AADRoleManagementPolicyNotificationRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **notificationType** | Write | String | Notification type for the rule. | |
| **recipientType** | Write | String | Type of the recipient for the notification. | |
| **notificationLevel** | Write | String | Level of the notification. | |
| **isDefaultRecipientsEnabled** | Write | Boolean | Indicates if default recipients are enabled. | |
| **notificationRecipients** | Write | StringArray[] | List of notification recipients. | |

### MSFT_AADRoleManagementPolicyEnablementRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **enabledRules** | Write | StringArray[] | List of enabled rules. | |

### MSFT_AADRoleManagementPolicySubjectSet

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | The type of the subject set. | |

### MSFT_AADRoleManagementPolicyApprovalStage

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **approvalStageTimeOutInDays** | Write | UInt32 | The number of days that a request can be pending a response before it is automatically denied. | |
| **escalationTimeInMinutes** | Write | UInt32 | The time a request can be pending a response from a primary approver before it can be escalated to the escalation approvers. | |
| **isApproverJustificationRequired** | Write | Boolean | Indicates whether the approver must provide justification for their reponse. | |
| **isEscalationEnabled** | Write | Boolean | Indicates whether escalation if enabled. | |
| **escalationApprovers** | Write | MSFT_AADRoleManagementPolicySubjectSet[] | The escalation approvers for this stage when the primary approvers don't respond. | |
| **primaryApprovers** | Write | MSFT_AADRoleManagementPolicySubjectSet[] | The primary approvers of this stage. | |

### MSFT_AADRoleManagementPolicyApprovalSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **approvalMode** | Write | String | One of SingleStage, Serial, Parallel, NoApproval (default). NoApproval is used when isApprovalRequired is false. | |
| **approvalStages** | Write | MSFT_AADRoleManagementPolicyApprovalStage[] | If approval is required, the one or two elements of this collection define each of the stages of approval. An empty array if no approval is required. | |
| **isApprovalRequired** | Write | Boolean | Indicates whether approval is required for requests in this policy. | |
| **isApprovalRequiredForExtension** | Write | Boolean | Indicates whether approval is required for a user to extend their assignment. | |
| **isRequestorJustificationRequired** | Write | Boolean | Indicates whether the requestor is required to supply a justification in their request. | |

### MSFT_AADRoleManagementPolicyApprovalRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **setting** | Write | MSFT_AADRoleManagementPolicyApprovalSettings | Settings for approval requirements. | |

### MSFT_AADRoleManagementPolicyAuthenticationContextRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **isEnabled** | Write | Boolean | Indicates if the authentication context rule is enabled. | |
| **claimValue** | Write | String | Claim value associated with the rule. | |


## Description

Azure AD Role Management Policy Rule

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - RoleManagementPolicy.Read.Directory, RoleManagement.Read.Directory, RoleManagement.Read.All

- **Update**

    - RoleManagementPolicy.ReadWrite.Directory, RoleManagement.ReadWrite.Directory

#### Application permissions

- **Read**

    - RoleManagementPolicy.Read.Directory, RoleManagement.Read.Directory, RoleManagement.Read.All

- **Update**

    - RoleManagementPolicy.ReadWrite.Directory, RoleManagement.ReadWrite.Directory

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

        AADRoleManagementPolicyRule "AADRoleManagementPolicyRule-Expiration_Admin_Eligibility"
        {
            expirationRule       = MSFT_AADRoleManagementPolicyExpirationRule{
                isExpirationRequired = $False
                maximumDuration = 'P180D'
            };
            id                   = "Expiration_Admin_Eligibility";
            roleDisplayName      = "Global Administrator";
            ruleType             = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

