# EXOMailboxAuditBypassAssociation

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | The Identity parameter specifies the user account or computer account where you want to view the value of the AuditBypassEnabled property. | |
| **AuditBypassEnabled** | Write | Boolean | The AuditBypassEnabled parameter specifies whether audit bypass is enabled for the user or computer. | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

Use the Set-MailboxAuditBypassAssociation cmdlet to configure mailbox audit logging bypass for user or computer accounts such as service accounts for applications that access mailboxes frequently.

## Permissions

### Exchange

To authenticate with Microsoft Exchange, this resource required the following permissions:

#### Roles

- Compliance Admin, View-Only Configuration, Journaling

#### Role Groups

- Organization Management, Compliance Management, Records Management

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
        EXOMailboxAuditBypassAssociation "EXOMailboxAuditBypassAssociation-Test"
        {
            AuditBypassEnabled   = $True;  #Updated Property
            Identity             = "TestMailbox109";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

