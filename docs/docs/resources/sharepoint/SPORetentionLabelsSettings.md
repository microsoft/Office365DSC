# SPORetentionLabelsSettings

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes' | `Yes` |
| **AllowFilesWithKeepLabelToBeDeletedODB** | Write | Boolean | Set whether files with Keep Label can be deleted in OneDrive for Business. | |
| **AllowFilesWithKeepLabelToBeDeletedSPO** | Write | Boolean | Set whether files with Keep Label can be deleted in SharePoint Online. | |
| **AdvancedRecordVersioningDisabled** | Write | Boolean | Set to enable or disable the advanced record versioning. | |
| **MetadataEditBlockingEnabled** | Write | Boolean | Set metadata edit blocking enabled setting. | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures the retention label settings. This setting is accessible via the Purview Record Management settings screen.

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

### Microsoft SharePoint

To authenticate with the SharePoint API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - None

- **Update**

    - None

#### Application permissions

- **Read**

    - 

- **Update**

    - 

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
        SPORetentionLabelsSettings "SPORetentionLabelsSettings"
        {
            AdvancedRecordVersioningDisabled      = $True;
            AllowFilesWithKeepLabelToBeDeletedODB = $false;
            AllowFilesWithKeepLabelToBeDeletedSPO = $false;
            ApplicationId                         = $ApplicationId;
            CertificateThumbprint                 = $CertificateThumbprint;
            IsSingleInstance                      = "Yes";
            MetadataEditBlockingEnabled           = $true;
            TenantId                              = $TenantId;
        }
    }
}
```

