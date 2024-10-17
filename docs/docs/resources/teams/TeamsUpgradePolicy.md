# TeamsUpgradePolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | Identity of the Teams Upgrade Policy. | |
| **Users** | Write | StringArray[] | List of users that will be granted the Upgrade Policy to. Use value * to apply the policy globally. | |
| **MigrateMeetingsToTeams** | Write | Boolean | Specifies whether to move existing Skype for Business meetings organized by the user to Teams. This parameter can only be true if the mode of the specified policy instance is either TeamsOnly or SfBWithTeamsCollabAndMeetings, and if the policy instance is being granted to a specific user. It not possible to trigger meeting migration when granting TeamsUpgradePolicy to the entire tenant. | |
| **Credential** | Write | PSCredential | Credentials of the Teams Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures the Teams Upgrade policies.

More information: https://docs.microsoft.com/en-us/microsoftteams/meetings-first#prepare-for-teams-meetings-in-meetings-first

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

This example demonstrates how to assign users to a Teams Upgrade Policy.

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
        TeamsUpgradePolicy 'ConfigureIslandsPolicy'
        {
            Identity               = 'Islands'
            Users                  = @("John.Smith@contoso.com", "Nik.Charlebois@contoso.com")
            MigrateMeetingsToTeams = $true
            Credential             = $Credscredential
        }
    }
}
```

