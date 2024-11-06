# ODSettings

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Should be set to yes | `Yes` |
| **OneDriveStorageQuota** | Write | UInt32 | The resource quota to apply to the OneDrive sites | |
| **OrphanedPersonalSitesRetentionPeriod** | Write | UInt32 | Number of days after a user's account is deleted that their OneDrive for Business content will be deleted. | |
| **OneDriveForGuestsEnabled** | Write | Boolean | Enable guest acess for OneDrive | |
| **NotifyOwnersWhenInvitationsAccepted** | Write | Boolean | DEPRECATED | |
| **NotificationsInOneDriveForBusinessEnabled** | Write | Boolean | Turn notifications on/off OneDrive | |
| **ODBMembersCanShare** | Write | String | Lets administrators set policy on re-sharing behavior in OneDrive for Business | `On`, `Off`, `Unspecified` |
| **ODBAccessRequests** | Write | String | Lets administrators set policy on access requests and requests to share in OneDrive for Business | `On`, `Off`, `Unspecified` |
| **BlockMacSync** | Write | Boolean | Block sync client on Mac | |
| **DisableReportProblemDialog** | Write | Boolean | Disable dialog box | |
| **TenantRestrictionEnabled** | Write | Boolean | Enable/disable Safe domain List - if disabled overrides DomainGuids value | |
| **DomainGuids** | Write | StringArray[] | Safe domain list | |
| **ExcludedFileExtensions** | Write | StringArray[] | Exclude files from being synced to OneDrive | |
| **GrooveBlockOption** | Write | String | Groove block options | `OptOut`, `HardOptIn`, `SoftOptIn` |
| **Ensure** | Write | String | Present ensures the user exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the account to authenticate with. | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **CertificatePassword** | Write | PSCredential | Username can be made up to anything but password will be used for certificatePassword | |
| **CertificatePath** | Write | String | Path to certificate used in service principal usually a PFX file. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource allows admins to manage blocked file types,
blocked domains and MAC Sync.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Domain.Read.All

- **Update**

    - Domain.Read.All

#### Application permissions

- **Read**

    - Domain.Read.All

- **Update**

    - Domain.Read.All

### Microsoft SharePoint

To authenticate with the SharePoint API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Sites.FullControl.All

- **Update**

    - Sites.FullControl.All

#### Application permissions

- **Read**

    - Sites.FullControl.All

- **Update**

    - Sites.FullControl.All

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
        $Credscredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        ODSettings 'OneDriveSettings'
        {
            IsSingleInstance                          = "Yes"
            OneDriveStorageQuota                      = "1024"
            ExcludedFileExtensions                    = @("pst")
            DomainGuids                               = "786548dd-877b-4760-a749-6b1efbc1190a"
            GrooveBlockOption                         = "OptOut"
            DisableReportProblemDialog                = $true
            BlockMacSync                              = $true
            OrphanedPersonalSitesRetentionPeriod      = "45"
            OneDriveForGuestsEnabled                  = $false
            ODBAccessRequests                         = "On"
            ODBMembersCanShare                        = "On"
            NotifyOwnersWhenInvitationsAccepted       = $false
            NotificationsInOneDriveForBusinessEnabled = $false
            Ensure                                    = "Present"
            Credential                                = $Credscredential
        }
    }
}
```

