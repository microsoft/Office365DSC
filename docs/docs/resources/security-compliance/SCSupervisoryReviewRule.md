# SCSupervisoryReviewRule

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | The Name parameter specifies the unique name for the supervisory review policy. The name can't exceed 64 characters. If the value contains spaces, enclose the value in quotation marks. | |
| **Policy** | Key | String | The Policy parameter specifies the supervisory review policy that's assigned to the rule. You can use any value that uniquely identifies the policy. | |
| **Condition** | Write | String | The Condition parameter specifies the conditions and exceptions for the rule. | |
| **SamplingRate** | Write | UInt32 | The SamplingRate parameter specifies the percentage of communications for review. If you want reviewers to review all detected items, use the value 100. | |
| **Ensure** | Write | String | Specify if this rule should exist or not. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Exchange Global Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **CertificatePassword** | Write | PSCredential | Username can be made up to anything but password will be used for CertificatePassword | |
| **CertificatePath** | Write | String | Path to certificate used in service principal usually a PFX file. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource configures a Supervision Review Rule in Security and Compliance.

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

    - None

- **Update**

    - None

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

    Node localhost
    {
        SCSupervisoryReviewRule 'SupervisoryReviewRule'
        {
            Name                  = 'DemoRule'
            Condition             = '(NOT(Reviewee:US Compliance))'
            SamplingRate          = 100
            Policy                = 'TestPolicy'
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

