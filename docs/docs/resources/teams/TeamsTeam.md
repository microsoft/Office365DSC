# TeamsTeam

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display Name of the Team | |
| **Description** | Write | String | Description of Team. | |
| **GroupID** | Write | String | Team group ID, only used to target a Team when duplicated display names occurs. | |
| **MailNickName** | Write | String | MailNickName of O365 Group associated with Team | |
| **Owner** | Write | StringArray[] | Owners of the Team | |
| **Visibility** | Write | String | Visibility of the Team | `Public`, `Private`, `HiddenMembership` |
| **AllowAddRemoveApps** | Write | Boolean | Allow add or remove apps from the Team. | |
| **AllowGiphy** | Write | Boolean | Allow giphy in Team. | |
| **GiphyContentRating** | Write | String | Giphy content rating of the Team. | `Strict`, `Moderate` |
| **AllowStickersAndMemes** | Write | Boolean | Allow stickers and mimes in the Team. | |
| **AllowCustomMemes** | Write | Boolean | Allow custom memes in Team. | |
| **AllowUserEditMessages** | Write | Boolean | Allow members to edit messages within Team. | |
| **AllowUserDeleteMessages** | Write | Boolean | Allow members to delete messages within Team. | |
| **AllowOwnerDeleteMessages** | Write | Boolean | Allow owners to delete messages within Team. | |
| **AllowDeleteChannels** | Write | Boolean | Allow members to delete channels within Team. | |
| **AllowCreateUpdateRemoveConnectors** | Write | Boolean | Allow members to manage connectors within Team. | |
| **AllowCreateUpdateRemoveTabs** | Write | Boolean | Allow members to manage tabs within Team. | |
| **AllowTeamMentions** | Write | Boolean | Allow mentions in Team. | |
| **AllowChannelMentions** | Write | Boolean | Allow channel mention in Team. | |
| **AllowGuestCreateUpdateChannels** | Write | Boolean | Allow guests to create and update channels in Team. | |
| **AllowGuestDeleteChannels** | Write | Boolean | Allow guests to delete channel in Team. | |
| **AllowCreateUpdateChannels** | Write | Boolean | Allow members to create and update channels within Team. | |
| **ShowInTeamsSearchAndSuggestions** | Write | Boolean | determines whether or not private teams should be searchable from Teams clients for users who do not belong to that team.  Set to $false to make those teams not discoverable from Teams clients. | |
| **Ensure** | Write | String | Present ensures the Team exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Teams Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

## Description

This resource configures or creates a new Team.

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

    - Organization.Read.All, User.Read.All, Group.ReadWrite.All, AppCatalog.ReadWrite.All, TeamSettings.ReadWrite.All, Channel.Delete.All, ChannelSettings.ReadWrite.All, ChannelMember.ReadWrite.All

- **Update**

    - Organization.Read.All, User.Read.All, Group.ReadWrite.All, AppCatalog.ReadWrite.All, TeamSettings.ReadWrite.All, Channel.Delete.All, ChannelSettings.ReadWrite.All, ChannelMember.ReadWrite.All

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
        TeamsTeam 'ConfigureTeam'
        {
            DisplayName                       = 'Sample3'
            Description                       = 'Sample'
            Visibility                        = 'Private'
            MailNickName                      = 'DSCTeam2'
            AllowUserEditMessages             = $false
            AllowUserDeleteMessages           = $false
            AllowOwnerDeleteMessages          = $false
            AllowTeamMentions                 = $false
            AllowChannelMentions              = $false
            allowCreateUpdateChannels         = $false
            AllowDeleteChannels               = $false
            AllowAddRemoveApps                = $false
            AllowCreateUpdateRemoveTabs       = $false
            AllowCreateUpdateRemoveConnectors = $false
            AllowGiphy                        = $True
            GiphyContentRating                = 'strict'
            AllowStickersAndMemes             = $True
            AllowCustomMemes                  = $True
            AllowGuestCreateUpdateChannels    = $true
            AllowGuestDeleteChannels          = $true
            Ensure                            = 'Present'
            ApplicationId                     = $ApplicationId
            TenantId                          = $TenantId
            CertificateThumbprint             = $CertificateThumbprint
        }
    }
}
```

