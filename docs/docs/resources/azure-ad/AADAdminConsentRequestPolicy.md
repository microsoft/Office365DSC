# AADAdminConsentRequestPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Only valid value is 'Yes'. | `Yes` |
| **IsEnabled** | Write | Boolean | Determines if the policy is enabled or not. | |
| **NotifyReviewers** | Write | Boolean | Specifies whether reviewers will receive notifications. | |
| **RemindersEnabled** | Write | Boolean | Specifies whether reviewers will receive reminder emails. | |
| **RequestDurationInDays** | Write | UInt32 | Specifies the duration the request is active before it automatically expires if no decision is applied. | |
| **Reviewers** | Write | MSFT_AADAdminConsentRequestPolicyReviewer[] | The list of reviewers for the admin consent. | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADAdminConsentRequestPolicyReviewer

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ReviewerType** | Write | String | Type of reviewwer. Can be User, Group or Role | |
| **ReviewerId** | Write | String | Identifier for the reviewer instance. | |
| **QueryRoot** | Write | String | Associated query. | |


## Description

Configures the Admin Consent Request Policy in Entra Id.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - None

- **Update**

    - None

#### Application permissions

- **Read**

    - Policy.Read.All

- **Update**

    - Policy.ReadWrite.ConsentRequest

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
        AADAdminConsentRequestPolicy "AADAdminConsentRequestPolicy"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            IsEnabled             = $True;
            IsSingleInstance      = "Yes";
            NotifyReviewers       = $False;
            RemindersEnabled      = $True;
            RequestDurationInDays = 30;
            Reviewers             =                 @(
                MSFT_AADAdminConsentRequestPolicyReviewer {
                     ReviewerType = 'User'
                     ReviewerId   = "AlexW@$TenantId"
                }
                MSFT_AADAdminConsentRequestPolicyReviewer {
                     ReviewerType = 'Group'
                     ReviewerId   = 'Communications'
                }
                MSFT_AADAdminConsentRequestPolicyReviewer {
                     ReviewerType = 'Role'
                     ReviewerId   = 'Attack Payload Author'
                }
                MSFT_AADAdminConsentRequestPolicyReviewer {
                     ReviewerType = 'Role'
                     ReviewerId   = 'Attack Simulation Administrator'
                }
                );
            TenantId              = $TenantId;
        }
    }
}
```

