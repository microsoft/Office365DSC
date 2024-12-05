# SCUnifiedAuditLogRetentionPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | The description for the audit log retention policy | |
| **Name** | Key | String | Unique name for the audit log retention policy | |
| **Operations** | Write | StringArray[] | Specifies the audit log operations that are retained by the policy | |
| **Priority** | Write | UInt32 | Priority value for the policy that determines the order of policy processing. | |
| **RecordTypes** | Write | StringArray[] | Specifies the audit logs of a specific record type that are retained by the policy. | |
| **RetentionDuration** | Write | String | How long audit log records are kept | `SevenDays`, `OneMonth`, `ThreeMonths`, `SixMonths`, `NineMonths`, `TwelveMonths`, `ThreeYears`, `FiveYears`, `SevenYears`, `TenYears` |
| **UserIds** | Write | StringArray[] | Specifies the audit logs that are retained by the policy based on the ID of the user who performed the action | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |


## Description

The resource configured the Unified Audit Log Retention Policy in the Security and Compliance.

## Permissions

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
        SCUnifiedAuditLogRetentionPolicy 'Example'
        {
            Credential            = $Credentials
            Ensure                = 'Present'
            Name                  = 'Test Policy'
            Priority              = 1
            RetentionDuration     = 'SevenDays'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

