# M365DSCRuleEvaluation

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ResourceTypeName** | Key | String | Name of the resource to monitor | |
| **RuleDefinition** | Required | String | Specify the rules to monitor the resource for. | |
| **AfterRuleCountQuery** | Write | String | Query to check how many instances exist, using PowerShell format | |
| **Credential** | Write | PSCredential | Credentials of the Azure Active Directory Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory application to authenticate with. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

# AAD Tenant Details

## Description

This resource monitors Microsoft365DSC resources based on provided rules.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Organization.Read.All

- **Update**

    - Organization.Read.All, Organization.ReadWrite.All

#### Application permissions

- **Read**

    - Organization.Read.All

- **Update**

    - Organization.Read.All, Organization.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $CredsCredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        M365DSCRuleEvaluation 'AllowAnonymousUsersToJoinMeetingAllPolicies'
        {
            ResourceTypeName = 'TeamsMeetingPolicy'
            RuleDefinition   = "`$_.AllowAnonymousUsersToJoinMeeting -eq `$true"
            Credential       = $CredsCredential
        }
    }
}
```

