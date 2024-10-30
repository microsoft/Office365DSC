# TeamsMeetingPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Key | String | Identity of the Teams Meeting Policy. | |
| **Description** | Write | String | Description of the Teams Meeting Policy. | |
| **AllowAnnotations** | Write | Boolean | Determines whether a user can use the Annotation feature | |
| **AllowAnonymousUsersToDialOut** | Write | Boolean | CURRENTLY DISABLED: Determines whether anonymous users can use the Call Me At feature for meeting audio. | |
| **AllowAnonymousUsersToJoinMeeting** | Write | Boolean | Determines whether anonymous users can join the meetings that impacted users organize. | |
| **AllowAnonymousUsersToStartMeeting** | Write | Boolean | Determines whether anonymous users can initiate a meeting. | |
| **AllowBreakoutRooms** | Write | Boolean | Determines whether or not meetings created by users with this policy are able to utilize the Breakout Rooms feature. | |
| **AllowCartCaptionsScheduling** | Write | String | Determines whether a user can add a URL for captions from a Communications Access Real-Time Translation (CART) captioner for providing real-time captions in meetings. | `EnabledUserOverride`, `DisabledUserOverride`, `Disabled` |
| **AllowChannelMeetingScheduling** | Write | Boolean | Determines whether a user can schedule channel meetings. Note this only restricts from scheduling and not from joining a meeting scheduled by another user. | |
| **AllowCloudRecording** | Write | Boolean | Determines whether cloud recording is allowed in a user's meetings. | |
| **AllowDocumentCollaboration** | Write | String | This setting will allow admins to choose which users will be able to use the Document Collaboration feature. | `Enabled`, `Disabled` |
| **AllowedStreamingMediaInput** | Write | String | Enables the use of RTMP-In in Teams meetings. | |
| **AllowEngagementReport** | Write | String | Determines whether or not a meeting Organizer can track join and leave times for all users within their meetings as well as download a roster. | `Enabled`, `Disabled`, `ForceEnabled` |
| **AllowExternalNonTrustedMeetingChat** | Write | Boolean | This field controls whether a user is allowed to chat in external meetings with users from non trusted organizations. | |
| **AllowExternalParticipantGiveRequestControl** | Write | Boolean | Determines whether external participants can request or give control of screen sharing during meetings scheduled by this user. | |
| **AllowIPAudio** | Write | Boolean | Determines whether audio is enabled in a user's meetings or calls. | |
| **AllowIPVideo** | Write | Boolean | Determines whether video is enabled in a user's meetings or calls. | |
| **AllowMeetingCoach** | Write | Boolean | This setting will allow admins to allow users the option of turning on Meeting Coach during meetings, which provides users with private personalized feedback on their communication and inclusivity. | |
| **AllowMeetingReactions** | Write | Boolean | Determines whether or not meetings created by users with this policy are able to utilize the Meeting Reactions feature. | |
| **AllowMeetingRegistration** | Write | Boolean | Controls if a user can create a webinar meeting. The default value is True. | |
| **AllowMeetNow** | Write | Boolean | Determines whether a user can start ad-hoc meetings. | |
| **AllowNDIStreaming** | Write | Boolean | Determines whether a user is able to use NDI (Network Device Interface) in meetings - both for output and input streams. | |
| **AllowNetworkConfigurationSettingsLookup** | Write | Boolean | Determines whether network configuration setting lookups can be made by users who are not Enterprise Voice enabled. It is used to enable Network Roaming policies. | |
| **AllowOrganizersToOverrideLobbySettings** | Write | Boolean | Determines whether organizers can override lobby settings for both VOIP and PSTN. | |
| **AllowOutlookAddIn** | Write | Boolean | Determines whether a user can schedule Teams Meetings in Outlook desktop client. | |
| **AllowParticipantGiveRequestControl** | Write | Boolean | Determines whether participants can request or give control of screen sharing during meetings scheduled by this user. | |
| **AllowPowerPointSharing** | Write | Boolean | Determines whether Powerpoint sharing is allowed in a user's meetings. | |
| **AllowPrivateMeetingScheduling** | Write | Boolean | Determines whether a user can schedule private meetings. Note this only restricts from scheduling and not from joining a meeting scheduled by another user. | |
| **AllowPrivateMeetNow** | Write | Boolean | Determines whether a user can start private ad-hoc meetings. | |
| **AllowPSTNUsersToBypassLobby** | Write | Boolean | Determines whether PSTN users should be automatically admitted to the meetings. | |
| **AllowRecordingStorageOutsideRegion** | Write | Boolean | Determines whether cloud recording can be stored out of region for go-local tenants where recording is not yet enabled. | |
| **AllowSharedNotes** | Write | Boolean | Determines whether users are allowed to take shared notes. | |
| **AllowTranscription** | Write | Boolean | Determines whether real-time and/or post-meeting captions and transcriptions are allowed in a user's meetings. | |
| **AllowUserToJoinExternalMeeting** | Write | String | Determines what types of external meetings users can join. Enabled is able join all external meetings. | `Enabled`, `FederatedOnly`, `Disabled` |
| **AllowWatermarkForCameraVideo** | Write | Boolean | This setting allows scheduling meetings with watermarking for video enabled. | |
| **AllowWatermarkForScreenSharing** | Write | Boolean | This setting allows scheduling meetings with watermarking for screen sharing enabled. | |
| **AllowWhiteboard** | Write | Boolean | Determines whether whiteboard is allowed in a user's meetings. | |
| **AttendeeIdentityMasking** | Write | String | This setting will allow admins to enable or disable Masked Attendee mode in Meetings. Masked Attendee meetings will hide attendees' identifying information (e.g., name, contact information, profile photo). | `Enabled`, `Disabled`, `DisabledUserOverride` |
| **AutoAdmittedUsers** | Write | String | Determines what types of participants will automatically be added to meetings organized by this user. Set this to EveryoneInCompany if you would like meetings to place every external user in the lobby but allow all users in the company to join the meeting immediately. Set this to Everyone if you'd like to admit anonymous users by default. Set this to EveryoneInSameAndFederatedCompany if you would like meetings to allow federated users to join like your company's users, but place all other external users in a lobby. Set this to InvitedUsers if you would like meetings to allow only the invited users. | `EveryoneInCompany`, `Everyone`, `EveryoneInSameAndFederatedCompany`, `OrganizerOnly`, `InvitedUsers`, `EveryoneInCompanyExcludingGuests` |
| **AutomaticallyStartCopilot** | Write | String | This setting gives admins the ability to auto-start Copilot. | `Enabled`, `Disabled` |
| **AutoRecording** | Write | String | This setting will enable Tenant Admins to turn on/off auto recording feature. | `Enabled`, `Disabled` |
| **BlockedAnonymousJoinClientTypes** | Write | String | A user can join a Teams meeting anonymously using a Teams client or using a custom application built using Azure Communication Services. When anonymous meeting join is enabled, both types of clients may be used by default. This optional parameter can be used to block one of the client types that can be used. The allowed values are ACS (to block the use of Azure Communication Services clients) or Teams (to block the use of Teams clients). Both can also be specified, separated by a comma, but this is equivalent to disabling anonymous join completely. | |
| **ChannelRecordingDownload** | Write | String | Determines how channel meeting recordings are saved, permissioned, and who can download them. | `Allow`, `Block` |
| **ConnectToMeetingControls** | Write | String | Allows external connections of thirdparty apps to Microsoft Teams. | `Enabled`, `Disabled` |
| **ContentSharingInExternalMeetings** | Write | String | This policy allows admins to determine whether the user can share content in meetings organized by external organizations. The user should have a Teams Premium license to be protected under this policy. | `EnabledForAnyone`, `EnabledForTrustedOrgs`, `Disabled` |
| **Copilot** | Write | String | This setting allows the admin to choose whether Copilot will be enabled with a persisted transcript or a non-persisted transcript. | `Enabled`, `EnabledWithTranscript` |
| **CopyRestriction** | Write | Boolean | This parameter enables a setting that controls a meeting option which allows users to disable right-click or Ctrl+C to copy, Copy link, Forward message, and Share to Outlook for meeting chat messages. | |
| **DesignatedPresenterRoleMode** | Write | String | Determines if users can change the default value of the Who can present? setting in Meeting options in the Teams client. This policy setting affects all meetings, including Meet Now meetings. | `OrganizerOnlyUserOverride`, `EveryoneInCompanyUserOverride`, `EveryoneUserOverride` |
| **DetectSensitiveContentDuringScreenSharing** | Write | Boolean | Allows the admin to enable sensitive content detection during screen share. | |
| **EnrollUserOverride** | Write | String | Determines whether or not users will be able to enroll/capture their Biometric data: Face & Voice. | `Disabled`, `Enabled` |
| **ExplicitRecordingConsent** | Write | String | This setting will enable Tenant Admins to turn on/off Explicit Recording Consent feature. | `Disabled`, `Enabled` |
| **ExternalMeetingJoin** | Write | String | Determines whether the user is allowed to join external meetings. | `EnabledForAnyone`, `EnabledForTrustedOrgs`, `Disabled` |
| **InfoShownInReportMode** | Write | String | This policy controls what kind of information get shown for the user's attendance in attendance report/dashboard. | |
| **IPAudioMode** | Write | String | Determines whether audio can be turned on in meetings and group calls. | `EnabledOutgoingIncoming`, `Disabled` |
| **IPVideoMode** | Write | String | Determines whether video can be turned on in meetings and group calls. Can only be enabled if IPAudioMode is enabled | `EnabledOutgoingIncoming`, `Disabled` |
| **LiveCaptionsEnabledType** | Write | String | Determines whether a user should have the option to view live captions or not in a meeting. | `Disabled`, `DisabledUserOverride` |
| **LiveInterpretationEnabledType** | Write | String | Determines how meeting organizers can configure a meeting for language interpretation, select attendees of the meeting to become interpreters that other attendees can select and listen to the real-time translation they provide. | |
| **LiveStreamingMode** | Write | String | Determines whether you provide support for your users to stream their Teams meetings to large audiences through Real-Time Messaging Protocol (RTMP). | `Disabled`, `Enabled` |
| **MediaBitRateKb** | Write | UInt32 | Determines the media bit rate for audio/video/app sharing transmissions in meetings. | |
| **MeetingChatEnabledType** | Write | String | Determines whether or not Chat will be enabled, enabled except anonymous or disabled for meetings. | `Disabled`, `Enabled`, `EnabledExceptAnonymous` |
| **MeetingInviteLanguages** | Write | String | Controls how the join information in meeting invitations is displayed by enforcing a common language or enabling up to two languages to be displayed. Note: All Teams supported languages can be specified using language codes. | |
| **NewMeetingRecordingExpirationDays** | Write | SInt32 | Specifies the number of days before meeting recordings will expire and move to the recycle bin. Value can be from 1 to 99,999 days. NOTE: You may opt to set Meeting Recordings to never expire by entering the value -1. | |
| **ParticipantNameChange** | Write | String | This setting will enable Tenant Admins to turn on/off participant renaming feature. | `Disabled`, `Enabled` |
| **PreferredMeetingProviderForIslandsMode** | Write | String | Determines which Outlook Add-in the user will get as preferred Meeting provider(TeamsAndSfb or Teams). | `TeamsAndSfb`, `Teams` |
| **QnAEngagementMode** | Write | String | This setting enables Microsoft 365 Tenant Admins to Enable or Disable the Questions and Answers experience (Q+A). | `Disabled`, `Enabled` |
| **RoomAttributeUserOverride** | Write | String | Determines whether or not biometric data will be used to distinguish and or attribute in the transcript. | `Off`, `Distinguish`, `Attribute` |
| **RoomPeopleNameUserOverride** | Write | String | Determines if people recognition option is enabled for Teams Rooms. Enabling requires the RoomAttributeUserOverride to be Attribute for allowing individual voice and face profiles to be used for recognition in meetings. | `Off`, `On` |
| **ScreenSharingMode** | Write | String | Determines the mode in which a user can share a screen in calls or meetings. | `SingleApplication`, `EntireScreen`, `Disabled` |
| **SpeakerAttributionMode** | Write | String | Determines if users are identified in transcriptions and if they can change the value of the Automatically identify me in meeting captions and transcripts setting. | `Disabled`, `DisabledUserOverride`, `EnabledUserOverride`, `Enabled` |
| **StreamingAttendeeMode** | Write | String | Controls if Teams uses overflow capability once a meeting reaches its capacity (1,000 users with full functionality). | `Disabled`, `Enabled` |
| **TeamsCameraFarEndPTZMode** | Write | String | Determines whether or not meetings created by users with this policy are able to utilize the Camera Far-End PTZ Mode. | `Disabled`, `AutoAcceptInTenant`, `AutoAcceptAll` |
| **VideoFiltersMode** | Write | String | Determines the background effects that a user can configure in the Teams client.  | `NoFilters`, `BlurOnly`, `BlurAndDefaultBackgrounds`, `AllFilters` |
| **VoiceIsolation** | Write | String | Determines whether you provide support for your users to enable voice isolation in Teams meeting calls. | `Disabled`, `Enabled` |
| **WhoCanRegister** | Write | String | Specifies who can attend and register for webinars. | `Everyone`, `EveryoneInCompany` |
| **ForceStreamingAttendeeMode** | Write | String | DEPRECATED | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Teams Global Admin. | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures the Teams Meeting Policies.

More information: https://docs.microsoft.com/en-us/microsoftteams/meeting-policies-overview

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

This example adds a new Teams Meeting Policy.

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
        TeamsMeetingPolicy 'ConfigureMeetingPolicy'
        {
            Identity                                   = "Demo Policy"
            AllowAnonymousUsersToStartMeeting          = $False
            AllowChannelMeetingScheduling              = $True
            AllowCloudRecording                        = $True
            AllowExternalParticipantGiveRequestControl = $False
            AllowIPVideo                               = $True
            AllowMeetNow                               = $True
            AllowOutlookAddIn                          = $True
            AllowParticipantGiveRequestControl         = $True
            AllowPowerPointSharing                     = $True
            AllowPrivateMeetingScheduling              = $True
            AllowSharedNotes                           = $True
            AllowTranscription                         = $False
            AllowWhiteboard                            = $True
            AutoAdmittedUsers                          = "Everyone"
            Description                                = "My Demo Meeting Policy"
            MediaBitRateKb                             = 50000
            ScreenSharingMode                          = "EntireScreen"
            Ensure                                     = "Present"
            Credential                                 = $Credscredential
        }
    }
}
```

