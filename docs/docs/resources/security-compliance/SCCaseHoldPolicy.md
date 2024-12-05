# SCCaseHoldPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | The Name parameter specifies the unique name of the case hold policy. | |
| **Case** | Key | String | The Case parameter specifies the eDiscovery case that you want to associate with the case hold policy. | |
| **Comment** | Write | String | The Comment parameter specifies an optional comment. | |
| **Enabled** | Write | Boolean | The Enabled parameter specifies whether the policy is enabled or disabled. | |
| **ExchangeLocation** | Write | StringArray[] | The ExchangeLocation parameter specifies the mailboxes to include in the policy. | |
| **PublicFolderLocation** | Write | StringArray[] | The PublicFolderLocation parameter specifies that you want to include all public folders in the case hold policy. You use the value All for this parameter. | |
| **SharePointLocation** | Write | StringArray[] | The SharePointLocation parameter specifies the SharePoint Online and OneDrive for Business sites to include. You identify a site by its URL value. | |
| **Ensure** | Write | String | Specify if this policy should exist or not. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Exchange Global Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **CertificatePassword** | Write | PSCredential | Username can be made up to anything but password will be used for CertificatePassword | |
| **CertificatePath** | Write | String | Path to certificate used in service principal usually a PFX file. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource configures a eDiscovery Case Policy
in Security and Compliance Center.

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

    node localhost
    {
        SCCaseHoldPolicy 'CaseHoldPolicy'
        {
            Case                  = 'Test Case'
            ExchangeLocation      = 'DemoGroup@contoso.onmicrosoft.com'
            Name                  = 'Demo Hold'
            PublicFolderLocation  = 'All'
            Comment               = 'This is a demo'
            Enabled               = $True
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

