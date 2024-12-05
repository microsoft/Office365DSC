# EXOTeamsProtectionPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Only valid value is 'Yes'. | `Yes` |
| **AdminDisplayName** | Write | String | The AdminDisplayName parameter specifies a description for the policy. | |
| **HighConfidencePhishQuarantineTag** | Write | String | The HighConfidencePhishQuarantineTag parameter specifies the quarantine policy that's used for messages that are quarantined as high confidence phishing by ZAP for Teams. | `AdminOnlyAccessPolicy`, `DefaultFullAccessPolicy`, `DefaultFullAccessWithNotificationPolicy` |
| **MalwareQuarantineTag** | Write | String | The MalwareQuarantineTag parameter specifies the quarantine policy that's used for messages that are quarantined as malware by ZAP for Teams. | `AdminOnlyAccessPolicy`, `DefaultFullAccessPolicy`, `DefaultFullAccessWithNotificationPolicy` |
| **ZapEnabled** | Write | Boolean | The ZapEnabled parameter specifies whether to enable zero-hour auto purge (ZAP) for malware and high confidence phishing messages in Teams messages. | |
| **Credential** | Write | PSCredential | Credentials of the Exchange Global Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **CertificatePassword** | Write | PSCredential | Username can be made up to anything but password will be used for CertificatePassword | |
| **CertificatePath** | Write | String | Path to certificate used in service principal usually a PFX file. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

Create or modify a TeamsProtectionPolicy in your cloud-based organization.

## Permissions

### Exchange

To authenticate with Microsoft Exchange, this resource required the following permissions:

#### Roles

- Compliance Management, Delegated Setup, Hygiene Management, Organization Management, View-Only Organization Management

#### Role Groups

- Organization Management

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param
    (
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
        EXOTeamsProtectionPolicy 'EXOTeamsProtectionPolicy'
        {
            IsSingleInstance                 = 'Yes'
            AdminDisplayName                 = 'Contoso Administrator'
            HighConfidencePhishQuarantineTag = 'DefaultFullAccessPolicy'
            MalwareQuarantineTag             = 'AdminOnlyAccessPolicy'
            ZapEnabled                       = $true
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            CertificateThumbprint            = $CertificateThumbprint
        }
    }
}
```

