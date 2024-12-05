# TeamsChannelsPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | Identity of the Teams Channel Policy. | |
| **Description** | Write | String | Description of the Teams Channel Policy. | |
| **AllowChannelSharingToExternalUser** | Write | Boolean | Determines whether a user is allowed to share a shared channel with an external user. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **AllowOrgWideTeamCreation** | Write | Boolean | Determines whether a user is allowed to create an org-wide team. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **EnablePrivateTeamDiscovery** | Write | Boolean | Determines whether a user is allowed to discover private teams in suggestions and search results. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **AllowPrivateChannelCreation** | Write | Boolean | Determines whether a user is allowed to create a private channel. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **AllowSharedChannelCreation** | Write | Boolean | Determines whether a user is allowed to create a shared channel. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **AllowUserToParticipateInExternalSharedChannel** | Write | Boolean | Determines whether a user is allowed to participate in a shared channel that has been shared by an external user. Set this to TRUE to allow. Set this FALSE to prohibit. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Teams Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures a Teams Channel Policy.

More information: https://docs.microsoft.com/en-us/microsoftteams/teams-policies

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

    - Organization.Read.All

- **Update**

    - Organization.Read.All

## Examples

### Example 1

This example adds a new Teams Channels Policy.

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
        TeamsChannelsPolicy 'ConfigureChannelsPolicy'
        {
            Identity                                      = 'New Channels Policy'
            Description                                   = 'This is an example'
            AllowChannelSharingToExternalUser             = $True
            AllowOrgWideTeamCreation                      = $True
            EnablePrivateTeamDiscovery                    = $True
            AllowPrivateChannelCreation                   = $True
            AllowSharedChannelCreation                    = $True
            AllowUserToParticipateInExternalSharedChannel = $True
            Ensure                                        = 'Present'
            ApplicationId                                 = $ApplicationId
            TenantId                                      = $TenantId
            CertificateThumbprint                         = $CertificateThumbprint
        }
    }
}
```

