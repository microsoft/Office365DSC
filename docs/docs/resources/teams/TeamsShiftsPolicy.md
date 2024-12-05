# TeamsShiftsPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | Specifies the policy instance name | |
| **AccessGracePeriodMinutes** | Write | UInt64 | Determines the grace period time in minutes between when the first shift starts or last shift ends and when access is blocked | |
| **AccessType** | Write | String | Determines the Teams access type granted to the user. Today, only unrestricted access to Teams app is supported. | `UnrestrictedAccess_TeamsApp` |
| **EnableScheduleOwnerPermissions** | Write | Boolean | Determines whether a user can manage a Shifts schedule as a team member. | |
| **EnableShiftPresence** | Write | Boolean | Determines whether a user is given shift-based presence (On shift, Off shift, or Busy). This must be set in order to have any off shift warning message-specific settings. | |
| **ShiftNoticeFrequency** | Write | String | Determines the frequency of warning dialog displayed when user opens Teams. | `Always`, `ShowOnceOnChange`, `Never` |
| **ShiftNoticeMessageCustom** | Write | String | Specifies a custom message. Must set ShiftNoticeMessageType to 'CustomMessage' to enforce this | |
| **ShiftNoticeMessageType** | Write | String | Specifies the warning message is shown in the blocking dialog when a user access Teams off shift hours. Select one of 7 Microsoft provided messages, a default message or a custom message. | `DefaultMessage`, `Message1`, `Message2`, `Message3`, `Message4`, `Message5`, `Message6`, `Message7`, `CustomMessage` |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource allows you to create a new TeamsShiftPolicy instance and set it's properties.

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
        TeamsShiftsPolicy 'Example'
        {
            Identity                       = 'Global'
            AccessGracePeriodMinutes       = 15
            AccessType                     = 'UnrestrictedAccess_TeamsApp'
            EnableScheduleOwnerPermissions = $False
            EnableShiftPresence            = $False
            Ensure                         = 'Present'
            ShiftNoticeFrequency           = 'Never'
            ShiftNoticeMessageCustom       = ''
            ShiftNoticeMessageType         = 'DefaultMessage'
            ApplicationId                  = $ApplicationId
            TenantId                       = $TenantId
            CertificateThumbprint          = $CertificateThumbprint
        }
    }
}
```

