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

    Configuration Master
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
        $Domain = $TenantId
        Node Localhost
        {
                EXOAcceptedDomain 'O365DSCDomain'
                {
                    Identity     = $TenantId
                    DomainType   = "Authoritative"
                    OutboundOnly = $true # Updated Property
                    Ensure       = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOActiveSyncDeviceAccessRule 'ConfigureActiveSyncDeviceAccessRule'
                {
                    Identity             = "ContosoPhone(DeviceOS)"
                    Characteristic       = "DeviceModel" # Updated Property
                    QueryString          = "iOS 6.1 10B145"
                    AccessLevel          = "Allow"
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOActiveSyncMailboxPolicy 'TestActiveSyncMailboxPolicy'
                {
                    AllowApplePushNotifications              = $True;
                    AllowBluetooth                           = "Allow";
                    AllowBrowser                             = $True;
                    AllowCamera                              = $False; #drift
                    AllowConsumerEmail                       = $True;
                    AllowDesktopSync                         = $True;
                    AllowExternalDeviceManagement            = $False;
                    AllowHTMLEmail                           = $True;
                    AllowInternetSharing                     = $True;
                    AllowIrDA                                = $True;
                    AllowMobileOTAUpdate                     = $True;
                    AllowNonProvisionableDevices             = $True;
                    AllowPOPIMAPEmail                        = $True;
                    AllowRemoteDesktop                       = $True;
                    AllowSimpleDevicePassword                = $True;
                    AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
                    AllowSMIMESoftCerts                      = $True;
                    AllowStorageCard                         = $True;
                    AllowTextMessaging                       = $True;
                    AllowUnsignedApplications                = $True;
                    AllowUnsignedInstallationPackages        = $True;
                    AllowWiFi                                = $True;
                    AlphanumericDevicePasswordRequired       = $False;
                    ApprovedApplicationList                  = @();
                    AttachmentsEnabled                       = $True;
                    DeviceEncryptionEnabled                  = $False;
                    DevicePasswordEnabled                    = $False;
                    DevicePasswordExpiration                 = "Unlimited";
                    DevicePasswordHistory                    = 0;
                    DevicePolicyRefreshInterval              = "Unlimited";
                    Identity                                 = "Test";
                    IrmEnabled                               = $True;
                    IsDefault                                = $True;
                    IsDefaultPolicy                          = $True;
                    MaxAttachmentSize                        = "Unlimited";
                    MaxCalendarAgeFilter                     = "All";
                    MaxDevicePasswordFailedAttempts          = "Unlimited";
                    MaxEmailAgeFilter                        = "All";
                    MaxEmailBodyTruncationSize               = "Unlimited";
                    MaxEmailHTMLBodyTruncationSize           = "Unlimited";
                    MaxInactivityTimeDeviceLock              = "Unlimited";
                    MinDevicePasswordComplexCharacters       = 1;
                    MinDevicePasswordLength                  = 1;
                    Name                                     = "Test";
                    PasswordRecoveryEnabled                  = $False;
                    RequireDeviceEncryption                  = $False;
                    RequireEncryptedSMIMEMessages            = $False;
                    RequireEncryptionSMIMEAlgorithm          = "TripleDES";
                    RequireManualSyncWhenRoaming             = $False;
                    RequireSignedSMIMEAlgorithm              = "SHA1";
                    RequireSignedSMIMEMessages               = $False;
                    RequireStorageCardEncryption             = $False;
                    UnapprovedInROMApplicationList           = @();
                    UNCAccessEnabled                         = $True;
                    WSSAccessEnabled                         = $True;
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAddressBookPolicy 'ConfigureAddressBookPolicy'
                {
                    Name                 = "All Fabrikam ABP"
                    AddressLists         = "\All Users"
                    RoomList             = "\All Rooms"
                    OfflineAddressBook   = "\Default Offline Address Book"
                    GlobalAddressList    = "\Default Global Address List"
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAddressList 'HRUsersAddressList'
                {
                    Name                       = "HR Users"
                    ConditionalCompany         = "Contoso"
                    ConditionalDepartment      = "HR2" # Updated Property
                    ConditionalStateOrProvince = "US"
                    IncludedRecipients         = "AllRecipients"
                    Ensure                     = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAntiPhishPolicy 'ConfigureAntiphishPolicy'
                {
                    Identity                              = "Our Rule"
                    MakeDefault                           = $null
                    PhishThresholdLevel                   = 2 # Updated Property
                    EnableTargetedDomainsProtection       = $null
                    Enabled                               = $null
                    TargetedDomainsToProtect              = $null
                    EnableSimilarUsersSafetyTips          = $null
                    ExcludedDomains                       = $null
                    TargetedDomainActionRecipients        = $null
                    EnableMailboxIntelligence             = $null
                    EnableSimilarDomainsSafetyTips        = $null
                    AdminDisplayName                      = ""
                    AuthenticationFailAction              = "MoveToJmf"
                    TargetedUserProtectionAction          = "NoAction"
                    TargetedUsersToProtect                = $null
                    EnableTargetedUserProtection          = $null
                    ExcludedSenders                       = $null
                    EnableOrganizationDomainsProtection   = $null
                    EnableUnusualCharactersSafetyTips     = $null
                    TargetedUserActionRecipients          = $null
                    Ensure                                = "Present"
                    DmarcQuarantineAction                 = "Quarantine"
                    DmarcRejectAction                     = "Reject"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAntiPhishRule 'ConfigureAntiPhishRule'
                {
                    Identity                  = "Test Rule"
                    Comments                  = "This is an updated comment." # Updated Property
                    AntiPhishPolicy           = "Our Rule"
                    Enabled                   = $True
                    SentToMemberOf            = @("executives@$TenantId")
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOApplicationAccessPolicy 'ConfigureApplicationAccessPolicy'
                {
                    Identity             = "Integration Policy"
                    AccessRight          = "DenyAccess"
                    AppID                = '3dbc2ae1-7198-45ed-9f9f-d86ba3ec35b5'
                    PolicyScopeGroupId   = "IntegrationMailEnabled@$TenantId"
                    Description          = "Engineering Group Policy Updated" # Updated Property
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOArcConfig 'EXOArcConfig-Test'
                {
                    ArcTrustedSealers                        = "contoso.com";
                    IsSingleInstance                         = "Yes";
                    TenantId                                 = $TenantId;
                    CertificateThumbprint                    = $CertificateThumbprint;
                    ApplicationId                            = $ApplicationId;
                }
                EXOATPBuiltInProtectionRule 'EXOATPBuiltInProtectionRule'
                {
                    ApplicationId             = $ApplicationId;
                    CertificateThumbprint     = $CertificateThumbprint;
                    ExceptIfRecipientDomainIs = @("contoso.com","fabrikam.com");
                    Identity                  = "ATP Built-In Protection Rule";
                    TenantId                  = $TenantId;
                }
                EXOAtpPolicyForO365 'ConfigureAntiPhishPolicy'
                {
                    IsSingleInstance        = "Yes"
                    EnableATPForSPOTeamsODB = $true
                    Ensure                  = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOATPProtectionPolicyRule 'EXOATPProtectionPolicyRule-Strict Preset Security Policy'
                {
                    Comments                = "Built-in Strict Preset Security Policy with comments"; # Changed value
                    Enabled                 = $True; # Changed value
                    Identity                = "Strict Preset Security Policy";
                    Name                    = "Strict Preset Security Policy";
                    Priority                = 0;
                    SafeAttachmentPolicy    = "Strict Preset Security Policy1725468967835";
                    SafeLinksPolicy         = "Strict Preset Security Policy1725468969412";
                    Ensure                  = "Present"
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                }
                EXOAuthenticationPolicy 'ConfigureAuthenticationPolicy'
                {
                    Identity                            = "Block Basic Auth"
                    AllowBasicAuthActiveSync            = $False
                    AllowBasicAuthAutodiscover          = $False
                    AllowBasicAuthImap                  = $False
                    AllowBasicAuthMapi                  = $True # Updated Property
                    AllowBasicAuthOfflineAddressBook    = $False
                    AllowBasicAuthOutlookService        = $False
                    AllowBasicAuthPop                   = $False
                    AllowBasicAuthPowerShell            = $False
                    AllowBasicAuthReportingWebServices  = $False
                    AllowBasicAuthRpc                   = $False
                    AllowBasicAuthSmtp                  = $False
                    AllowBasicAuthWebServices           = $False
                    Ensure                              = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAvailabilityAddressSpace 'ConfigureAvailabilityAddressSpace'
                {
                    Identity              = 'Contoso.com'
                    AccessMethod          = 'OrgWideFBToken'
                    ForestName            = 'example.contoso.com'
                    TargetServiceEpr      = 'https://contoso.com/autodiscover/autodiscover.xml'
                    TargetTenantId        = 'contoso.onmicrosoft.com' # Updated Property
                    Ensure                = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAvailabilityConfig 'ConfigureAvailabilityConfig'
                {
                    OrgWideAccount       = "alexW@$TenantId" # Updated Property
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOCalendarProcessing 'CalendarProcessing'
                {
                    AddAdditionalResponse                = $False;
                    AddNewRequestsTentatively            = $True;
                    AddOrganizerToSubject                = $False; # Updated Property
                    AllBookInPolicy                      = $True;
                    AllowConflicts                       = $False;
                    AllowRecurringMeetings               = $True;
                    AllRequestInPolicy                   = $False;
                    AllRequestOutOfPolicy                = $False;
                    AutomateProcessing                   = "AutoUpdate";
                    BookingType                          = "Standard";
                    BookingWindowInDays                  = 180;
                    BookInPolicy                         = @();
                    ConflictPercentageAllowed            = 0;
                    DeleteAttachments                    = $True;
                    DeleteComments                       = $True;
                    DeleteNonCalendarItems               = $True;
                    DeleteSubject                        = $True;
                    EnableAutoRelease                    = $False;
                    EnableResponseDetails                = $True;
                    EnforceCapacity                      = $False;
                    EnforceSchedulingHorizon             = $True;
                    Ensure                               = "Present";
                    ForwardRequestsToDelegates           = $True;
                    Identity                             = "admin@$TenantId";
                    MaximumConflictInstances             = 0;
                    MaximumDurationInMinutes             = 1440;
                    MinimumDurationInMinutes             = 0;
                    OrganizerInfo                        = $True;
                    PostReservationMaxClaimTimeInMinutes = 10;
                    ProcessExternalMeetingMessages       = $False;
                    RemoveCanceledMeetings               = $False;
                    RemoveForwardedMeetingNotifications  = $False;
                    RemoveOldMeetingMessages             = $False;
                    RemovePrivateProperty                = $True;
                    RequestInPolicy                      = @("AlexW@$TenantId");
                    ResourceDelegates                    = @();
                    ScheduleOnlyDuringWorkHours          = $False;
                    TentativePendingApproval             = $True;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOCASMailboxPlan 'ConfigureCASMailboxPlan'
                {
                    ActiveSyncEnabled = $True
                    OwaMailboxPolicy  = "OwaMailboxPolicy-Default"
                    PopEnabled        = $False # Updated Property
                    Identity          = 'ExchangeOnlineEnterprise'
                    ImapEnabled       = $True
                    Ensure            = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOCASMailboxSettings 'AdeleVCasMailboxSettings'
                {
                    ActiveSyncAllowedDeviceIDs              = @()
                    ActiveSyncBlockedDeviceIDs              = @()
                    ActiveSyncDebugLogging                  = $False
                    ActiveSyncEnabled                       = $True
                    ActiveSyncMailboxPolicy                 = 'Default'
                    ActiveSyncSuppressReadReceipt           = $False
                    EwsEnabled                              = $True
                    Identity                                = "admin@$TenantId"
                    ImapEnabled                             = $True # Updated Property
                    ImapForceICalForCalendarRetrievalOption = $False
                    ImapMessagesRetrievalMimeFormat         = 'BestBodyFormat'
                    ImapSuppressReadReceipt                 = $False
                    ImapUseProtocolDefaults                 = $True
                    MacOutlookEnabled                       = $True
                    MAPIEnabled                             = $True
                    OutlookMobileEnabled                    = $True
                    OWAEnabled                              = $True
                    OWAforDevicesEnabled                    = $True
                    OwaMailboxPolicy                        = 'OwaMailboxPolicy-Integration'
                    PopEnabled                              = $False
                    PopForceICalForCalendarRetrievalOption  = $True
                    PopMessagesRetrievalMimeFormat          = 'BestBodyFormat'
                    PopSuppressReadReceipt                  = $False
                    PopUseProtocolDefaults                  = $True
                    PublicFolderClientAccess                = $False
                    ShowGalAsDefaultView                    = $True
                    UniversalOutlookEnabled                 = $True
                    Ensure                                  = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOClientAccessRule 'ConfigureClientAccessRule'
                {
                    Action                               = "AllowAccess"
                    UserRecipientFilter                  = $null
                    ExceptAnyOfAuthenticationTypes       = @()
                    ExceptUsernameMatchesAnyOfPatterns   = @()
                    AnyOfAuthenticationTypes             = @()
                    UsernameMatchesAnyOfPatterns         = @()
                    Identity                             = "Always Allow Remote PowerShell"
                    Priority                             = 1
                    AnyOfProtocols                       = @("RemotePowerShell")
                    Enabled                              = $False # Updated Property
                    ExceptAnyOfProtocols                 = @()
                    ExceptAnyOfClientIPAddressesOrRanges = @()
                    AnyOfClientIPAddressesOrRanges       = @()
                    Ensure                               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODataClassification 'ConfigureDataClassification'
                {
                    Description          = "Detects formatted and unformatted Canadian social insurance number.";
                    Ensure               = "Present";
                    Identity             = "a2f29c85-ecb8-4514-a610-364790c0773e";
                    IsDefault            = $True;
                    Locale               = "en-US";
                    Name                 = "Canada Social Insurance Number";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODistributionGroup 'DemoDG'
                {
                    Alias                              = "demodg";
                    BccBlocked                         = $True; # Updated Property
                    BypassNestedModerationEnabled      = $False;
                    DisplayName                        = "My Demo DG";
                    Ensure                             = "Present";
                    HiddenGroupMembershipEnabled       = $True;
                    ManagedBy                          = @("adeleV@$TenantId");
                    MemberDepartRestriction            = "Open";
                    MemberJoinRestriction              = "Closed";
                    ModeratedBy                        = @("alexW@$TenantId");
                    ModerationEnabled                  = $False;
                    Identity                           = "DemoDG";
                    Name                               = "DemoDG";
                    PrimarySmtpAddress                 = "demodg@$TenantId";
                    RequireSenderAuthenticationEnabled = $True;
                    SendModerationNotifications        = "Always";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODkimSigningConfig 'ConfigureDKIMSigning'
                {
                    KeySize                = 1024
                    Identity               = $TenantId
                    HeaderCanonicalization = "Relaxed"
                    Enabled                = $False # Updated Property
                    BodyCanonicalization   = "Relaxed"
                    AdminDisplayName       = ""
                    Ensure                 = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODnssecForVerifiedDomain 'EXODnssecForVerifiedDomain-nik-charlebois.com'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DnssecFeatureStatus   = "Enabled";
                    DomainName            = "nik-charlebois.com";
                }
                EXOEmailAddressPolicy 'ConfigureEmailAddressPolicy'
                {
                    Name                              = "Integration Policy"
                    EnabledEmailAddressTemplates      = @("SMTP:@$TenantId")
                    EnabledPrimarySMTPAddressTemplate = "@$TenantId"
                    ManagedByFilter                   = "Department -eq 'Sales'" # Updated Property
                    Priority                          = 1
                    Ensure                            = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOEmailTenantSettings 'EXOEmailTenantSettings-Test'
                {
                    IsSingleInstance                         = "Yes"
                    EnablePriorityAccountProtection          = $True;
                    Identity                                 = $TenantId;
                    IsValid                                  = $True;
                    ObjectState                              = "Unchanged"
                    Name                                     = "Default"
                    TenantId                                 = $TenantId
                    CertificateThumbprint                    = $CertificateThumbprint
                    ApplicationId                            = $ApplicationId
                }
                EXOFocusedInbox 'EXOFocusedInbox-Test'
                {
                    Ensure                       = "Present";
                    FocusedInboxOn               = $False; # Updated Property
                    FocusedInboxOnLastUpdateTime = "1/1/0001 12:00:00 AM";
                    Identity                     = "admin@$TenantId";
                    ApplicationId                = $ApplicationId;
                    TenantId                     = $TenantId;
                    CertificateThumbprint        = $CertificateThumbprint;
                }
                EXOGlobalAddressList 'ConfigureGlobalAddressList'
                {
                    Name                         = "Contoso Human Resources in Washington"
                    ConditionalCompany           = "Contoso"
                    ConditionalDepartment        = "Finances" # Updated Property
                    ConditionalStateOrProvince   = "Washington"
                    Ensure                       = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOGroupSettings 'TestGroup'
                {
                    DisplayName                            = "All Company";
                    AccessType                             = "Public";
                    AlwaysSubscribeMembersToCalendarEvents = $False;
                    AuditLogAgeLimit                       = "90.00:00:00";
                    AutoSubscribeNewMembers                = $False;
                    CalendarMemberReadOnly                 = $False;
                    ConnectorsEnabled                      = $False; # Updated Property
                    HiddenFromAddressListsEnabled          = $True;
                    HiddenFromExchangeClientsEnabled       = $True;
                    InformationBarrierMode                 = "Open";
                    Language                               = "en-US";
                    MaxReceiveSize                         = "36 MB (37,748,736 bytes)";
                    MaxSendSize                            = "35 MB (36,700,160 bytes)";
                    ModerationEnabled                      = $False;
                    Notes                                  = "My Notes";
                    PrimarySmtpAddress                     = "TestGroup@$TenantId";
                    RequireSenderAuthenticationEnabled     = $True;
                    SubscriptionEnabled                    = $False;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedConnectionFilterPolicy 'ConfigureHostedConnectionFilterPolicy'
                {
                    Identity         = "Default"
                    AdminDisplayName = ""
                    EnableSafeList   = $True # Updated Property
                    IPAllowList      = @()
                    IPBlockList      = @()
                    MakeDefault      = $True
                    Ensure           = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedContentFilterPolicy 'ConfigureHostedContentFilterPolicy'
                {
                    Identity                             = "Integration CFP"
                    AddXHeaderValue                      = ""
                    AdminDisplayName                     = ""
                    BulkSpamAction                       = "MoveToJmf"
                    BulkThreshold                        = 7
                    DownloadLink                         = $True # Updated Property
                    EnableLanguageBlockList              = $False
                    EnableRegionBlockList                = $False
                    HighConfidencePhishAction            = "Quarantine"
                    HighConfidenceSpamAction             = "MoveToJmf"
                    IncreaseScoreWithBizOrInfoUrls       = "Off"
                    IncreaseScoreWithImageLinks          = "Off"
                    IncreaseScoreWithNumericIps          = "Off"
                    IncreaseScoreWithRedirectToOtherPort = "Off"
                    InlineSafetyTipsEnabled              = $True
                    LanguageBlockList                    = @()
                    MakeDefault                          = $False
                    MarkAsSpamBulkMail                   = "On"
                    MarkAsSpamEmbedTagsInHtml            = "Off"
                    MarkAsSpamEmptyMessages              = "Off"
                    MarkAsSpamFormTagsInHtml             = "Off"
                    MarkAsSpamFramesInHtml               = "Off"
                    MarkAsSpamFromAddressAuthFail        = "Off"
                    MarkAsSpamJavaScriptInHtml           = "Off"
                    MarkAsSpamNdrBackscatter             = "Off"
                    MarkAsSpamObjectTagsInHtml           = "Off"
                    MarkAsSpamSensitiveWordList          = "Off"
                    MarkAsSpamSpfRecordHardFail          = "Off"
                    MarkAsSpamWebBugsInHtml              = "Off"
                    ModifySubjectValue                   = ""
                    PhishSpamAction                      = "MoveToJmf"
                    PhishZapEnabled                      = $True
                    QuarantineRetentionPeriod            = 15
                    RedirectToRecipients                 = @()
                    RegionBlockList                      = @()
                    SpamAction                           = "MoveToJmf"
                    SpamZapEnabled                       = $True
                    TestModeAction                       = "None"
                    TestModeBccToRecipients              = @()
                    Ensure                               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedContentFilterRule 'ConfigureHostedContentFilterRule'
                {
                    Identity                  = "Integration CFR"
                    Comments                  = "Applies to all users, except when member of HR group"
                    Enabled                   = $False # Updated Property
                    ExceptIfSentToMemberOf    = "LegalTeam@$TenantId"
                    RecipientDomainIs         = @('contoso.com')
                    HostedContentFilterPolicy = "Integration CFP"
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedOutboundSpamFilterPolicy 'HostedOutboundSpamFilterPolicy'
                {
                    Identity                                  = "Integration SFP"
                    ActionWhenThresholdReached                = "BlockUserForToday"
                    AdminDisplayName                          = ""
                    AutoForwardingMode                        = "Automatic"
                    BccSuspiciousOutboundAdditionalRecipients = @()
                    BccSuspiciousOutboundMail                 = $False
                    NotifyOutboundSpam                        = $False
                    NotifyOutboundSpamRecipients              = @()
                    #RecipientLimitExternalPerHour             = 0
                    #RecipientLimitInternalPerHour             = 1 # Updated Property
                    #RecipientLimitPerDay                      = 0
                    Ensure                                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedOutboundSpamFilterRule 'ConfigureHostedOutboundSpamFilterRule'
                {
                    Identity                       = "Contoso Executives"
                    Comments                       = "Does not apply to Executives"
                    Enabled                        = $False # Updated Property
                    ExceptIfFrom                   = "AdeleV@$TenantId"
                    FromMemberOf                   = "Executives@$TenantId"
                    HostedOutboundSpamFilterPolicy = "Integration SFP"
                    Ensure                         = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOInboundConnector 'ConfigureInboundConnector'
                {
                    Identity                     = "Integration Inbound Connector"
                    CloudServicesMailEnabled     = $False
                    Comment                      = "Inbound connector for Integration"
                    ConnectorSource              = "Default"
                    ConnectorType                = "Partner"
                    Enabled                      = $False # Updated Property
                    RequireTls                   = $True
                    SenderDomains                = "*.contoso.com"
                    TlsSenderCertificateName     = "contoso.com"
                    Ensure                       = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOIntraOrganizationConnector 'ConfigureIntraOrganizationConnector'
                {
                    Identity             = "MainCloudConnector"
                    DiscoveryEndpoint    = "https://ExternalDiscovery.Contoso.com/"
                    TargetAddressDomains = "Cloud1.contoso.com","Cloud2.contoso.com"
                    Enabled              = $False # Updated Property
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOIRMConfiguration 'ConfigureIRMConfiguration'
                {
                    IsSingleInstance                           = 'Yes'
                    AutomaticServiceUpdateEnabled              = $True
                    AzureRMSLicensingEnabled                   = $True
                    DecryptAttachmentForEncryptOnly            = $True
                    EDiscoverySuperUserEnabled                 = $True
                    EnablePdfEncryption                        = $True
                    InternalLicensingEnabled                   = $True
                    JournalReportDecryptionEnabled             = $True
                    RejectIfRecipientHasNoRights               = $True
                    SearchEnabled                              = $True
                    SimplifiedClientAccessDoNotForwardDisabled = $True
                    SimplifiedClientAccessEnabled              = $True
                    SimplifiedClientAccessEncryptOnlyDisabled  = $True
                    TransportDecryptionSetting                 = 'Mandatory'
                    Ensure                                     = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOJournalRule 'CreateJournalRule'
                {
                    Enabled              = $False # Updated Property
                    JournalEmailAddress  = "AdeleV@$TenantId"
                    Name                 = "Send to Adele"
                    RuleScope            = "Global"
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailboxAuditBypassAssociation 'EXOMailboxAuditBypassAssociation-Test'
                {
                    AuditBypassEnabled   = $True;  #Updated Property
                    Identity             = "TestMailbox109";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                EXOMailboxAutoReplyConfiguration 'EXOMailboxAutoReplyConfiguration'
                {
                    AutoDeclineFutureRequestsWhenOOF = $False;
                    AutoReplyState                   = "Disabled";
                    CreateOOFEvent                   = $False;
                    DeclineAllEventsForScheduledOOF  = $False;
                    DeclineEventsForScheduledOOF     = $False;
                    DeclineMeetingMessage            = "";
                    EndTime                          = "1/23/2024 3:00:00 PM";
                    Ensure                           = "Present";
                    ExternalAudience                 = "All";
                    ExternalMessage                  = (New-Guid).ToString(); # Updated Property
                    Identity                         = "AdeleV@$TenantId";
                    InternalMessage                  = "";
                    OOFEventSubject                  = "";
                    StartTime                        = "1/22/2024 3:00:00 PM";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailboxCalendarConfiguration 'EXOMailboxCalendarConfiguration-Test'
                {
                    AgendaMailIntroductionEnabled            = $True;
                    AutoDeclineWhenBusy                      = $False;
                    ConversationalSchedulingEnabled          = $True;
                    CreateEventsFromEmailAsPrivate           = $True;
                    DefaultMinutesToReduceLongEventsBy       = 10;
                    DefaultMinutesToReduceShortEventsBy      = 6; # Updated Property
                    DefaultOnlineMeetingProvider             = "TeamsForBusiness";
                    DefaultReminderTime                      = "00:15:00";
                    DeleteMeetingRequestOnRespond            = $True;
                    DiningEventsFromEmailEnabled             = $True;
                    Ensure                                   = "Present";
                    EntertainmentEventsFromEmailEnabled      = $True;
                    EventsFromEmailEnabled                   = $True;
                    FirstWeekOfYear                          = "FirstDay";
                    FlightEventsFromEmailEnabled             = $True;
                    HotelEventsFromEmailEnabled              = $True;
                    Identity                                 = "admin@$TenantId";
                    InvoiceEventsFromEmailEnabled            = $True;
                    LocationDetailsInFreeBusy                = "Desk";
                    PackageDeliveryEventsFromEmailEnabled    = $False;
                    PreserveDeclinedMeetings                 = $False;
                    RemindersEnabled                         = $True;
                    ReminderSoundEnabled                     = $True;
                    RentalCarEventsFromEmailEnabled          = $True;
                    ServiceAppointmentEventsFromEmailEnabled = $True;
                    ShortenEventScopeDefault                 = "None";
                    ShowWeekNumbers                          = $False;
                    TimeIncrement                            = "ThirtyMinutes";
                    UseBrightCalendarColorThemeInOwa         = $False;
                    WeatherEnabled                           = "FirstRun";
                    WeatherLocationBookmark                  = 0;
                    WeatherLocations                         = @();
                    WeatherUnit                              = "Default";
                    WeekStartDay                             = "Sunday";
                    WorkDays                                 = "Monday, Tuesday";
                    WorkingHoursEndTime                      = "17:00:00";
                    WorkingHoursStartTime                    = "08:00:00";
                    WorkingHoursTimeZone                     = "Pacific Standard Time";
                    WorkspaceUserEnabled                     = $False;
                    ApplicationId                            = $ApplicationId
                    TenantId                                 = $TenantId
                    CertificateThumbprint                    = $CertificateThumbprint
                }
                EXOMailboxCalendarFolder 'JohnCalendarFolder'
                {
                    DetailLevel          = "AvailabilityOnly";
                    Ensure               = "Present";
                    Identity             = "AlexW@$TenantId" + ":\Calendar";
                    PublishDateRangeFrom = "ThreeMonths";
                    PublishDateRangeTo   = "ThreeMonths";
                    PublishEnabled       = $True; # Updated Property
                    SearchableUrlEnabled = $False;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailboxFolderPermission 'EXOMailboxFolderPermission-admin:\Calendar'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Present";
                    Identity              = "admin:\Calendar";
                    UserPermissions       = @(MSFT_EXOMailboxFolderUserPermission {
                        User                   = 'Default'
                        AccessRights           = 'AvailabilityOnly'
                    }
        MSFT_EXOMailboxFolderUserPermission {
                        User                   = 'Anonymous'
                        AccessRights           = 'AvailabilityOnly'
                    }
        MSFT_EXOMailboxFolderUserPermission {
                        User                   = 'AlexW'
                        AccessRights           = 'Editor'
        		SharingPermissionFlags = 'Delegate'
                    }
                    );
                }
                EXOMailboxPermission 'TestPermission'
                {
                    AccessRights         = @("FullAccess","ReadPermission");
                    Deny                 = $True; # Updated Property
                    Ensure               = "Present";
                    Identity             = "AlexW@$TenantId";
                    InheritanceType      = "All";
                    User                 = "NT AUTHORITY\SELF";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailboxPlan 'ConfigureMailboxPlan'
                {
                    Ensure                   = "Present";
                    Identity                 = "ExchangeOnlineEssentials";
                    IssueWarningQuota        = "15 GB (16,106,127,360 bytes)";
                    MaxReceiveSize           = "25 MB (26,214,400 bytes)";
                    MaxSendSize              = "25 MB (26,214,400 bytes)";
                    ProhibitSendQuota        = "15 GB (16,106,127,360 bytes)";
                    ProhibitSendReceiveQuota = "15 GB (16,106,127,360 bytes)"; # Updated Property
                    RetainDeletedItemsFor    = "14.00:00:00";
                    RoleAssignmentPolicy     = "Default Role Assignment Policy";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailboxSettings 'OttawaTeamMailboxSettings'
                {
                    DisplayName = 'Conf Room Adams'
                    TimeZone    = 'Eastern Standard Time'
                    Locale      = 'en-US' # Updated Property
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailContact 'TestMailContact'
                {
                    Alias                       = 'TestMailContact'
                    DisplayName                 = 'My Test Contact'
                    Ensure                      = 'Present'
                    ExternalEmailAddress        = 'SMTP:test@tailspintoys.com'
                    MacAttachmentFormat         = 'BinHex'
                    MessageBodyFormat           = 'TextAndHtml'
                    MessageFormat               = 'Mime'
                    ModeratedBy                 = @()
                    ModerationEnabled           = $false
                    Name                        = 'My Test Contact'
                    OrganizationalUnit          = $TenantId
                    SendModerationNotifications = 'Always'
                    UsePreferMessageFormat      = $false # Updated Property
                    CustomAttribute1            = 'Custom Value 1'
                    ExtensionCustomAttribute5   = 'Extension Custom Value 1', 'Extension Custom Value 2'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailTips 'OrgWideMailTips'
                {
                    IsSingleInstance                      = 'Yes'
                    MailTipsAllTipsEnabled                = $True
                    MailTipsGroupMetricsEnabled           = $False # Updated Property
                    #MailTipsLargeAudienceThreshold        = 100
                    MailTipsMailboxSourcedTipsEnabled     = $True
                    MailTipsExternalRecipientsTipsEnabled = $True
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMalwareFilterPolicy 'ConfigureMalwareFilterPolicy'
                {
                    Identity                               = "IntegrationMFP"
                    CustomNotifications                    = $False
                    EnableExternalSenderAdminNotifications = $False
                    EnableFileFilter                       = $False
                    EnableInternalSenderAdminNotifications = $False
                    FileTypeAction                         = "Quarantine"
                    FileTypes                              = @("ace", "ani", "app", "cab", "docm", "exe", "iso", "jar", "jnlp", "reg", "scr", "vbe", "vbs")
                    QuarantineTag                          = "AdminOnlyAccessPolicy"
                    ZapEnabled                             = $False # Updated Property
                    Ensure                                 = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMalwareFilterRule 'ConfigureMalwareFilterRule'
                {
                    Identity                  = "Contoso Recipients"
                    MalwareFilterPolicy       = "IntegrationMFP"
                    Comments                  = "Apply the filter to all Contoso users"
                    Enabled                   = $False # Updated Property
                    RecipientDomainIs         = "contoso.com"
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementRole 'ConfigureManagementRole'
                {
                    Name                 = "MyDisplayName"
                    Description          = "Updated Description" # Updated Property
                    Parent               = "$TenantId\MyProfileInformation"
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementRoleAssignment 'AssignManagementRole'
                {
                    Ensure               = "Present";
                    Name                 = "MyManagementRoleAssignment";
                    Role                 = "UserApplication";
                    User                 = "AlexW@$TenantId"; # Updated Property
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementRoleEntry 'UpdateRoleEntry'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Identity   = "Information Rights Management\Get-BookingMailbox"
                    Parameters = @("ANR","RecipientTypeDetails", "ResultSize")
                }
                EXOManagementScope 'EXOManagementScope-Test New DGs'
                {
                    ApplicationId              = $ApplicationId
                    TenantId                   = $TenantId
                    CertificateThumbprint      = $CertificateThumbprint
                    Ensure                     = "Present";
                    Exclusive                  = $False;
                    Identity                   = "Test New DGs";
                    Name                       = "Test New DGs";
                    RecipientRestrictionFilter = "Name -like 'NewTest*'";
                }
                EXOMessageClassification 'ConfigureMessageClassification'
                {
                    Identity                    = "Contoso Message Classification"
                    Name                        = "Contoso Message Classification"
                    DisplayName                 = "Contoso Message Classification"
                    DisplayPrecedence           = "Highest"
                    PermissionMenuVisible       = $True
                    RecipientDescription        = "Shown to receipients"
                    SenderDescription           = "Shown to senders"
                    RetainClassificationEnabled = $False # Updated Property
                    Ensure                      = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMigrationEndpoint 'EXOMigrationEndpoint-testIMAP'
                {
                    AcceptUntrustedCertificates   = $True;
                    Authentication                = "Basic";
                    ApplicationId                 = $ApplicationId
                    TenantId                      = $TenantId
                    CertificateThumbprint         = $CertificateThumbprint
                    EndpointType                  = "IMAP";
                    Ensure                        = "Present";
                    Identity                      = "testIMAP";
                    MailboxPermission             = "Admin";
                    MaxConcurrentIncrementalSyncs = "10";
                    MaxConcurrentMigrations       = "20";
                    Port                          = 993;
                    RemoteServer                  = "gmail.com";
                    # value for security updated from Tls to None
                    Security                      = "None";
                }
                EXOMobileDeviceMailboxPolicy 'ConfigureMobileDeviceMailboxPolicy'
                {
                    Name                                     = "Default"
                    AllowApplePushNotifications              = $True
                    AllowBluetooth                           = "Allow"
                    AllowBrowser                             = $False # Updated Property
                    AllowCamera                              = $True
                    AllowConsumerEmail                       = $True
                    AllowDesktopSync                         = $True
                    AllowExternalDeviceManagement            = $False
                    AllowGooglePushNotifications             = $True
                    AllowHTMLEmail                           = $True
                    AllowInternetSharing                     = $True
                    AllowIrDA                                = $True
                    AllowMicrosoftPushNotifications          = $True
                    AllowMobileOTAUpdate                     = $True
                    AllowNonProvisionableDevices             = $True
                    AllowPOPIMAPEmail                        = $True
                    AllowRemoteDesktop                       = $True
                    AllowSimplePassword                      = $True
                    AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation"
                    AllowSMIMESoftCerts                      = $True
                    AllowStorageCard                         = $True
                    AllowTextMessaging                       = $True
                    AllowUnsignedApplications                = $True
                    AllowUnsignedInstallationPackages        = $True
                    AllowWiFi                                = $True
                    AlphanumericPasswordRequired             = $False
                    ApprovedApplicationList                  = @()
                    AttachmentsEnabled                       = $True
                    DeviceEncryptionEnabled                  = $False
                    DevicePolicyRefreshInterval              = "Unlimited"
                    IrmEnabled                               = $True
                    IsDefault                                = $True
                    MaxAttachmentSize                        = "Unlimited"
                    MaxCalendarAgeFilter                     = "All"
                    MaxEmailAgeFilter                        = "All"
                    MaxEmailBodyTruncationSize               = "Unlimited"
                    MaxEmailHTMLBodyTruncationSize           = "Unlimited"
                    MaxInactivityTimeLock                    = "Unlimited"
                    MaxPasswordFailedAttempts                = "Unlimited"
                    MinPasswordComplexCharacters             = 1
                    PasswordEnabled                          = $False
                    PasswordExpiration                       = "Unlimited"
                    PasswordHistory                          = 0
                    PasswordRecoveryEnabled                  = $False
                    RequireDeviceEncryption                  = $False
                    RequireEncryptedSMIMEMessages            = $False
                    RequireEncryptionSMIMEAlgorithm          = "TripleDES"
                    RequireManualSyncWhenRoaming             = $False
                    RequireSignedSMIMEAlgorithm              = "SHA1"
                    RequireSignedSMIMEMessages               = $False
                    RequireStorageCardEncryption             = $False
                    UnapprovedInROMApplicationList           = @()
                    UNCAccessEnabled                         = $True
                    WSSAccessEnabled                         = $True
                    Ensure                                   = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOfflineAddressBook 'ConfigureOfflineAddressBook'
                {
                    Name                 = "Integration Address Book"
                    AddressLists         = @('\All Users')
                    DiffRetentionPeriod  = "60" # Updated Property
                    IsDefault            = $true
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOMEConfiguration 'ConfigureOMEConfiguration'
                {
                    Identity                 = "Contoso Marketing"
                    BackgroundColor          = "0x00FFFF00"
                    DisclaimerText           = "Encryption security disclaimer."
                    EmailText                = "Encrypted message enclosed."
                    ExternalMailExpiryInDays = 1 # Updated Property
                    IntroductionText         = "You have received an encypted message"
                    OTPEnabled               = $True
                    PortalText               = "This portal is encrypted."
                    SocialIdSignIn           = $True
                    Ensure                   = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOnPremisesOrganization 'ConfigureOnPremisesOrganization'
                {
                    Identity          = 'Integration'
                    Comment           = 'Mail for Contoso - Updated' #Updated Property
                    HybridDomains     = 'o365dsc.onmicrosoft.com'
                    InboundConnector  = 'Integration Inbound Connector'
                    OrganizationGuid  = 'e7a80bcf-696e-40ca-8775-a7f85fbb3ebc'
                    OrganizationName  = 'O365DSC'
                    OutboundConnector = 'Contoso Outbound Connector'
                    Ensure            = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOrganizationConfig 'EXOOrganizationConfig'
                {
                    IsSingleInstance                                          = "Yes"
                    ElcProcessingDisabled                                     = $False
                    DefaultPublicFolderProhibitPostQuota                      = "13 KB (13,312 bytes)"
                    VisibleMeetingUpdateProperties                            = "Location,AllProperties:15"
                    BookingsEnabled                                           = $True
                    ExchangeNotificationRecipients                            = @()
                    EwsEnabled                                                = $null
                    LinkPreviewEnabled                                        = $True
                    FocusedInboxOn                                            = $null
                    AsyncSendEnabled                                          = $True
                    EwsAllowEntourage                                         = $null
                    RemotePublicFolderMailboxes                               = @()
                    AuditDisabled                                             = $False
                    EwsAllowMacOutlook                                        = $null
                    ConnectorsEnabledForTeams                                 = $True
                    DefaultPublicFolderIssueWarningQuota                      = "13 KB (13,312 bytes)"
                    MailTipsMailboxSourcedTipsEnabled                         = $True
                    EndUserDLUpgradeFlowsDisabled                             = $False
                    DistributionGroupDefaultOU                                = $null
                    OutlookPayEnabled                                         = $True
                    EwsAllowOutlook                                           = $null
                    DefaultAuthenticationPolicy                               = $null
                    DistributionGroupNameBlockedWordsList                     = @()
                    ConnectorsEnabled                                         = $True
                    DefaultPublicFolderAgeLimit                               = $null
                    OutlookMobileGCCRestrictionsEnabled                       = $False
                    ActivityBasedAuthenticationTimeoutEnabled                 = $True
                    ConnectorsEnabledForYammer                                = $True
                    HierarchicalAddressBookRoot                               = $null
                    DefaultPublicFolderMaxItemSize                            = "13 KB (13,312 bytes)"
                    MailTipsLargeAudienceThreshold                            = 25
                    ConnectorsActionableMessagesEnabled                       = $True
                    ExchangeNotificationEnabled                               = $True
                    ActivityBasedAuthenticationTimeoutWithSingleSignOnEnabled = $True
                    DirectReportsGroupAutoCreationEnabled                     = $False
                    OAuth2ClientProfileEnabled                                = $True
                    AppsForOfficeEnabled                                      = $True
                    PublicFoldersEnabled                                      = "Local"
                    WebPushNotificationsDisabled                              = $False
                    MailTipsGroupMetricsEnabled                               = $True
                    DefaultPublicFolderMovedItemRetention                     = "07.00:00:00"
                    DistributionGroupNamingPolicy                             = ""
                    DefaultPublicFolderDeletedItemRetention                   = "30.00:00:00"
                    MailTipsAllTipsEnabled                                    = $True
                    LeanPopoutEnabled                                         = $False
                    PublicComputersDetectionEnabled                           = $False
                    ByteEncoderTypeFor7BitCharsets                            = 0
                    ConnectorsEnabledForOutlook                               = $True
                    WebSuggestedRepliesDisabled                               = $False
                    PublicFolderShowClientControl                             = $False
                    ActivityBasedAuthenticationTimeoutInterval                = "06:00:00"
                    BookingsSocialSharingRestricted                           = $False
                    DefaultGroupAccessType                                    = "Private"
                    IPListBlocked                                             = @()
                    SmtpActionableMessagesEnabled                             = $True
                    SiteMailboxCreationURL                                    = $null
                    BookingsPaymentsEnabled                                   = $False
                    MailTipsExternalRecipientsTipsEnabled                     = $False
                    AutoExpandingArchive                                      = $null
                    ConnectorsEnabledForSharepoint                            = $True
                    ReadTrackingEnabled                                       = $False
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOrganizationRelationship 'ConfigureOrganizationRelationship'
                {
                    Name                  = "Contoso"
                    ArchiveAccessEnabled  = $False # Updated Property
                    DeliveryReportEnabled = $True
                    DomainNames           = "mail.contoso.com"
                    Enabled               = $True
                    FreeBusyAccessEnabled = $True
                    FreeBusyAccessLevel   = "AvailabilityOnly"
                    MailboxMoveEnabled    = $True
                    MailTipsAccessEnabled = $True
                    MailTipsAccessLevel   = "None"
                    PhotosEnabled         = $True
                    TargetApplicationUri  = "mail.contoso.com"
                    TargetAutodiscoverEpr = "https://mail.contoso.com/autodiscover/autodiscover.svc/wssecurity"
                    Ensure                = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOutboundConnector 'ConfigureOutboundConnector'
                {
                    Identity                      = "Contoso Outbound Connector"
                    AllAcceptedDomains            = $False
                    CloudServicesMailEnabled      = $False
                    Comment                       = "Outbound connector to Contoso"
                    ConnectorSource               = "Default"
                    ConnectorType                 = "Partner"
                    Enabled                       = $False # Updated Property
                    IsTransportRuleScoped         = $False
                    RecipientDomains              = "contoso.com"
                    RouteAllMessagesViaOnPremises = $False
                    TlsDomain                     = "*.contoso.com"
                    TlsSettings                   = "DomainValidation"
                    UseMxRecord                   = $True
                    Ensure                        = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOwaMailboxPolicy 'ConfigureOwaMailboxPolicy'
                {
                    Name                                                 = "OwaMailboxPolicy-Integration"
                    ActionForUnknownFileAndMIMETypes                     = "ForceSave"
                    ActiveSyncIntegrationEnabled                         = $True
                    AdditionalStorageProvidersAvailable                  = $True
                    AllAddressListsEnabled                               = $True
                    AllowCopyContactsToDeviceAddressBook                 = $True
                    AllowedFileTypes                                     = @(".rpmsg",".xlsx",".xlsm",".xlsb",".tiff",".pptx",".pptm",".ppsx",".ppsm",".docx",".docm",".zip",".xls",".wmv",".wma",".wav",".vsd",".txt",".tif",".rtf",".pub",".ppt",".png",".pdf",".one",".mp3",".jpg",".gif",".doc",".bmp",".avi")
                    AllowedMimeTypes                                     = @("image/jpeg","image/png","image/gif","image/bmp")
                    BlockedFileTypes                                     = @(".settingcontent-ms",".printerexport",".appcontent-ms",".appref-ms",".vsmacros",".website",".msh2xml",".msh1xml",".diagcab",".webpnp",".ps2xml",".ps1xml",".mshxml",".gadget",".theme",".psdm1",".mhtml",".cdxml",".xbap",".vhdx",".pyzw",".pssc",".psd1",".psc2",".psc1",".msh2",".msh1",".jnlp",".aspx",".appx",".xnk",".xml",".xll",".wsh",".wsf",".wsc",".wsb",".vsw",".vst",".vss",".vhd",".vbs",".vbp",".vbe",".url",".udl",".tmp",".shs",".shb",".sct",".scr",".scf",".reg",".pyz",".pyw",".pyo",".pyc",".pst",".ps2",".ps1",".prg",".prf",".plg",".pif",".pcd",".ops",".msu",".mst",".msp",".msi",".msh",".msc",".mht",".mdz",".mdw",".mdt",".mde",".mdb",".mda",".mcf",".maw",".mav",".mau",".mat",".mas",".mar",".maq",".mam",".mag",".maf",".mad",".lnk",".ksh",".jse",".jar",".its",".isp",".ins",".inf",".htc",".hta",".hpj",".hlp",".grp",".fxp",".exe",".der",".csh",".crt",".cpl",".com",".cnt",".cmd",".chm",".cer",".bat",".bas",".asx",".asp",".app",".apk",".adp",".ade",".ws",".vb",".py",".pl",".js")
                    BlockedMimeTypes                                     = @("application/x-javascript","application/javascript","application/msaccess","x-internet-signup","text/javascript","application/xml","application/prg","application/hta","text/scriplet","text/xml")
                    ClassicAttachmentsEnabled                            = $True
                    ConditionalAccessPolicy                              = "Off"
                    DefaultTheme                                         = ""
                    DirectFileAccessOnPrivateComputersEnabled            = $True
                    DirectFileAccessOnPublicComputersEnabled             = $False # Updated Property
                    DisplayPhotosEnabled                                 = $True
                    ExplicitLogonEnabled                                 = $True
                    ExternalImageProxyEnabled                            = $True
                    ForceSaveAttachmentFilteringEnabled                  = $False
                    ForceSaveFileTypes                                   = @(".vsmacros",".ps2xml",".ps1xml",".mshxml",".gadget",".psc2",".psc1",".aspx",".wsh",".wsf",".wsc",".vsw",".vst",".vss",".vbs",".vbe",".url",".tmp",".swf",".spl",".shs",".shb",".sct",".scr",".scf",".reg",".pst",".ps2",".ps1",".prg",".prf",".plg",".pif",".pcd",".ops",".mst",".msp",".msi",".msh",".msc",".mdz",".mdw",".mdt",".mde",".mdb",".mda",".maw",".mav",".mau",".mat",".mas",".mar",".maq",".mam",".mag",".maf",".mad",".lnk",".ksh",".jse",".its",".isp",".ins",".inf",".hta",".hlp",".fxp",".exe",".dir",".dcr",".csh",".crt",".cpl",".com",".cmd",".chm",".cer",".bat",".bas",".asx",".asp",".app",".adp",".ade",".ws",".vb",".js")
                    ForceSaveMimeTypes                                   = @("Application/x-shockwave-flash","Application/octet-stream","Application/futuresplash","Application/x-director")
                    ForceWacViewingFirstOnPrivateComputers               = $False
                    ForceWacViewingFirstOnPublicComputers                = $False
                    FreCardsEnabled                                      = $True
                    GlobalAddressListEnabled                             = $True
                    GroupCreationEnabled                                 = $True
                    InstantMessagingEnabled                              = $True
                    InstantMessagingType                                 = "Ocs"
                    InterestingCalendarsEnabled                          = $True
                    IRMEnabled                                           = $True
                    IsDefault                                            = $True
                    JournalEnabled                                       = $True
                    LocalEventsEnabled                                   = $False
                    LogonAndErrorLanguage                                = 0
                    NotesEnabled                                         = $True
                    NpsSurveysEnabled                                    = $True
                    OnSendAddinsEnabled                                  = $False
                    OrganizationEnabled                                  = $True
                    OutboundCharset                                      = "AutoDetect"
                    OutlookBetaToggleEnabled                             = $True
                    OWALightEnabled                                      = $True
                    PersonalAccountCalendarsEnabled                      = $True
                    PhoneticSupportEnabled                               = $False
                    PlacesEnabled                                        = $True
                    PremiumClientEnabled                                 = $True
                    PrintWithoutDownloadEnabled                          = $True
                    PublicFoldersEnabled                                 = $True
                    RecoverDeletedItemsEnabled                           = $True
                    ReferenceAttachmentsEnabled                          = $True
                    RemindersAndNotificationsEnabled                     = $True
                    ReportJunkEmailEnabled                               = $True
                    RulesEnabled                                         = $True
                    SatisfactionEnabled                                  = $True
                    SaveAttachmentsToCloudEnabled                        = $True
                    SearchFoldersEnabled                                 = $True
                    SetPhotoEnabled                                      = $True
                    SetPhotoURL                                          = ""
                    SignaturesEnabled                                    = $True
                    SkipCreateUnifiedGroupCustomSharepointClassification = $True
                    TeamSnapCalendarsEnabled                             = $True
                    TextMessagingEnabled                                 = $True
                    ThemeSelectionEnabled                                = $True
                    UMIntegrationEnabled                                 = $True
                    UseGB18030                                           = $False
                    UseISO885915                                         = $False
                    UserVoiceEnabled                                     = $True
                    WacEditingEnabled                                    = $True
                    WacExternalServicesEnabled                           = $True
                    WacOMEXEnabled                                       = $False
                    WacViewingOnPrivateComputersEnabled                  = $True
                    WacViewingOnPublicComputersEnabled                   = $True
                    WeatherEnabled                                       = $True
                    WebPartsFrameOptionsType                             = "SameOrigin"
                    Ensure                                               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOPartnerApplication 'ConfigurePartnerApplication'
                {
                    Name                                = "HRApp"
                    ApplicationIdentifier               = "00000006-0000-0dd1-ac00-000000000000"
                    AcceptSecurityIdentifierInformation = $False # Updated Property
                    Enabled                             = $True
                    Ensure                              = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOPerimeterConfiguration 'ConfigurePerimeterConfiguration'
                {
                    IsSingleInstance   = 'Yes'
                    #GatewayIPAddresses = '123.0.0.1'
                    Ensure             = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOPhishSimOverrideRule 'EXOPhishSimOverrideRule-_Exe:PhishSimOverr:d779965e-ab14-4dd8-b3f5-0876a99f988b'
                {
                    Comment                                  = "New Comment note";
                    Ensure                                   = "Present";
                    Identity                                 = "_Exe:PhishSimOverr:d779965e-ab14-4dd8-b3f5-0876a99f988b";
                    ApplicationId                            = $ApplicationId
                    TenantId                                 = $TenantId
                    CertificateThumbprint                    = $CertificateThumbprint
                }
                EXOPlace 'TestPlace'
                {
                    AudioDeviceName        = "MyAudioDevice";
                    Capacity               = 16; # Updated Property
                    City                   = "";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayDeviceName      = "DisplayDeviceName";
                    Ensure                 = 'Present'
                    Identity               = "Hood@$TenantId";
                    IsWheelChairAccessible = $True;
                    MTREnabled             = $False;
                    ParentType             = "None";
                    Phone                  = "555-555-5555";
                    Tags                   = @("Tag1", "Tag2");
                    VideoDeviceName        = "VideoDevice";
                }
                EXOPolicyTipConfig 'ConfigurePolicyTipConfig'
                {
                    Name                 = "en\NotifyOnly"
                    Value                = "This message contains content that is restricted by Contoso company policy. Updated" # Updated Property
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOQuarantinePolicy 'ConfigureQuarantinePolicy'
                {
                    EndUserQuarantinePermissionsValue = 87;
                    ESNEnabled                        = $True; # Updated Property
                    Identity                          = "$TenantId\IntegrationPolicy";
                    Ensure                            = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORemoteDomain '583b0b70-b45d-401f-98a6-0e7fa8434946'
                {
                    Identity                             = "Integration"
                    AllowedOOFType                       = "External"
                    AutoForwardEnabled                   = $True
                    AutoReplyEnabled                     = $False # Updated Property
                    ByteEncoderTypeFor7BitCharsets       = "Undefined"
                    CharacterSet                         = "iso-8859-1"
                    ContentType                          = "MimeHtmlText"
                    DeliveryReportEnabled                = $True
                    DisplaySenderName                    = $True
                    DomainName                           = "contoso.com"
                    IsInternal                           = $False
                    LineWrapSize                         = "Unlimited"
                    MeetingForwardNotificationEnabled    = $False
                    Name                                 = "Integration"
                    NonMimeCharacterSet                  = "iso-8859-1"
                    PreferredInternetCodePageForShiftJis = "Undefined"
                    TargetDeliveryDomain                 = $False
                    TrustedMailInboundEnabled            = $False
                    TrustedMailOutboundEnabled           = $False
                    UseSimpleDisplayName                 = $False
                    Ensure                               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOReportSubmissionPolicy 'ConfigureReportSubmissionPolicy'
                {
                    IsSingleInstance                       = 'Yes'
                    DisableQuarantineReportingOption       = $False
                    EnableCustomNotificationSender         = $False
                    EnableOrganizationBranding             = $False
                    EnableReportToMicrosoft                = $True
                    EnableThirdPartyAddress                = $False
                    EnableUserEmailNotification            = $False
                    PostSubmitMessageEnabled               = $True
                    PreSubmitMessageEnabled                = $True
                    ReportJunkToCustomizedAddress          = $False
                    ReportNotJunkToCustomizedAddress       = $False
                    ReportPhishToCustomizedAddress         = $False
                    Ensure                                 = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOReportSubmissionRule 'ConfigureReportSubmissionRule'
                {
                    IsSingleInstance    = 'Yes'
                    Identity            = "DefaultReportSubmissionRule"
                    Comments            = "This is my default rule"
                    SentTo              = "submission@contoso.com"
                    Ensure              = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOResourceConfiguration 'ConfigureResourceConfiguration'
                {
                    IsSingleInstance       = 'Yes'
                    ResourcePropertySchema = @('Room/TV', 'Equipment/Laptop')
                    Ensure                 = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORetentionPolicy 'EXORetentionPolicy-Test'
                {
                    Name                        = "Test Retention Policy";
                    Identity                    = "Test Retention Policy";
                    IsDefault                   = $False;
                    IsDefaultArbitrationMailbox = $False;
                    RetentionPolicyTagLinks     = @("Personal 5 year move to archive","1 Month Delete","1 Week Delete","Personal never move to archive","Personal 1 year move to archive","Default 2 year move to archive","Deleted Items","Junk Email","Recoverable Items 14 days move to archive","Never Delete"); # drifted property
                    Ensure                      = "Present";
                    ApplicationId               = $ApplicationId;
                    TenantId                    = $TenantId;
                    CertificateThumbprint       = $CertificateThumbprint;
                }
                EXORoleAssignmentPolicy 'ConfigureRoleAssignmentPolicy'
                {
                    Name                 = "Integration Policy"
                    Description          = "Updated Description"  # Updated Property
                    IsDefault            = $True
                    Roles                = @("My Marketplace Apps","MyVoiceMail","MyDistributionGroups","MyRetentionPolicies","MyContactInformation","MyBaseOptions","MyTextMessaging","MyDistributionGroupMembership","MyProfileInformation","My Custom Apps","My ReadWriteMailbox Apps")
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORoleGroup 'ConfigureRoleGroup'
                {
                    Name                      = "Contoso Role Group"
                    Description               = "Address Lists Role for Exchange Administrators. Updated" # Updated Property
                    Members                   = @("Exchange Administrator")
                    Roles                     = @("Address Lists")
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeAttachmentPolicy 'ConfigureSafeAttachmentPolicy'
                {
                    Identity             = "Marketing Block Attachments"
                    Enable               = $False # Updated Property
                    Redirect             = $True
                    RedirectAddress      = "admin@$TenantId"
                    Ensure               = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeAttachmentRule 'ConfigureSafeAttachmentRule'
                {
                    Identity                  = "Research Department Attachment Rule"
                    Comments                  = "Applies to Research Department, except managers"
                    Enabled                   = $False # Updated Property
                    ExceptIfSentToMemberOf    = "Executives@$TenantId"
                    SafeAttachmentPolicy      = "Marketing Block Attachments"
                    SentToMemberOf            = "LegalTeam@$TenantId"
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeLinksPolicy 'ConfigureSafeLinksPolicy'
                {
                    Identity                      = 'Marketing Block URL'
                    AdminDisplayName              = 'Marketing Block URL'
                    CustomNotificationText        = 'Blocked URLs for Marketing'
                    DeliverMessageAfterScan       = $True
                    EnableOrganizationBranding    = $False # Updated Property
                    EnableSafeLinksForTeams       = $True
                    ScanUrls                      = $True
                    Ensure                        = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeLinksRule 'ConfigureSafeLinksRule'
                {
                    Identity                  = "Research Department URL Rule"
                    Comments                  = "Applies to Research Department, except managers"
                    Enabled                   = $False # Updated Property
                    ExceptIfSentToMemberOf    = "Executives@$TenantId"
                    SafeLinksPolicy           = "Marketing Block URL"
                    SentToMemberOf            = "LegalTeam@$TenantId"
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSecOpsOverrideRule 'EXOSecOpsOverrideRule-_Exe:SecOpsOverrid:ca3c51ac-925c-49f4-af42-43e26b874245'
                {
                    Comment                                  = "TestComment";
                    Ensure                                   = "Present";
                    Identity                                 = "_Exe:SecOpsOverrid:ca3c51ac-925c-49f4-af42-43e26b874245";
                    Policy                                   = "40528418-717d-4368-a1ae-7912918f8a1f";
                    ApplicationId                            = $ApplicationId
                    TenantId                                 = $TenantId
                    CertificateThumbprint                    = $CertificateThumbprint
                }
                EXOServicePrincipal 'ServicePrincipal'
                {
                    AppId                = "c6871074-3ded-4935-a5dc-b8f8d91d7d06";
                    AppName              = "ISV Portal";
                    DisplayName          = "Kartikeya";
                    Ensure               = "Present";
                    Identity             = "00f6b0e4-1d00-427b-9a5b-ce6c43c43fc7";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                EXOSharedMailbox 'SharedMailbox'
                {
                    DisplayName        = "Integration"
                    PrimarySMTPAddress = "Integration@$TenantId"
                    EmailAddresses     = @("IntegrationSM@$TenantId", "IntegrationSM2@$TenantId")
                    Alias              = "IntegrationSM"
                    Ensure             = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSharingPolicy 'ConfigureSharingPolicy'
                {
                    Name       = "Integration Sharing Policy"
                    Default    = $False # Updated Property
                    Domains    = @("Anonymous:CalendarSharingFreeBusyReviewer", "*:CalendarSharingFreeBusySimple")
                    Enabled    = $True
                    Ensure     = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSweepRule 'MyRule'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    DestinationFolder     = "Test2:\Deleted Items";
                    Enabled               = $True;
                    Ensure                = "Present";
                    KeepLatest            = 13; # Drift
                    Mailbox               = "Test2";
                    Name                  = "From Michelle";
                    Provider              = "Exchange16";
                    SenderName            = "michelle@fabrikam.com";
                    SourceFolder          = "Test2:\Inbox";
                    TenantId              = $TenantId;
                }
                EXOTenantAllowBlockListItems 'Example'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    TenantId              = $TenantId;
                    Action                = "Block";
                    Ensure                = "Present";
                    ExpirationDate        = "10/11/2024 9:00:00 PM";
                    ListSubType           = "Tenant";
                    ListType              = "Sender";
                    Notes                 = "Test block with updated notes";
                    SubmissionID          = "Non-Submission";
                    Value                 = "example.com";
                }
                EXOTenantAllowBlockListSpoofItems 'EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71'
                {
                    Action                = "Block"; #Drift
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Ensure                = "Present";
                    SendingInfrastructure = "121.0.0.7";
                    SpoofedUser           = "contoso.com";
                    SpoofType             = "Internal";
                    TenantId              = $TenantId;
                }
                EXOTransportConfig 'EXOTransportConfig '
                {
                    IsSingleInstance                        = "Yes";
                    AddressBookPolicyRoutingEnabled         = $True;
                    ClearCategories                         = $True;
                    ConvertDisclaimerWrapperToEml           = $False;
                    DSNConversionMode                       = "PreserveDSNBody";
                    ExternalDelayDsnEnabled                 = $True;
                    ExternalDsnLanguageDetectionEnabled     = $True;
                    ExternalDsnSendHtml                     = $True;
                    ExternalPostmasterAddress               = "postmaster@contoso.com";
                    HeaderPromotionModeSetting              = "NoCreate";
                    InternalDelayDsnEnabled                 = $True;
                    InternalDsnLanguageDetectionEnabled     = $True;
                    InternalDsnSendHtml                     = $True;
                    JournalingReportNdrTo                   = "<>";
                    JournalMessageExpirationDays            = 0;
                    MaxRecipientEnvelopeLimit               = "Unlimited";
                    ReplyAllStormBlockDurationHours         = 6;
                    ReplyAllStormDetectionMinimumRecipients = 2500;
                    ReplyAllStormDetectionMinimumReplies    = 10;
                    ReplyAllStormProtectionEnabled          = $True;
                    Rfc2231EncodingEnabled                  = $False;
                    SmtpClientAuthenticationDisabled        = $True;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOTransportRule 'ConfigureTransportRule'
                {
                    Name                                          = "Ethical Wall - Sales and Executives Departments"
                    BetweenMemberOf1                              = "SalesTeam@$TenantId"
                    BetweenMemberOf2                              = "Executives@$TenantId"
                    ExceptIfFrom                                  = "AdeleV@$TenantId"
                    ExceptIfSubjectContainsWords                  = "Press Release","Corporate Communication"
                    RejectMessageReasonText                       = "Messages sent between the Sales and Brokerage departments are strictly prohibited."
                    Enabled                                       = $False # Updated Property
                    Ensure                                        = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
        }
    }

    $ConfigurationData = @{
        AllNodes = @(
            @{
                NodeName                    = "Localhost"
                PSDSCAllowPlaintextPassword = $true
            }
        )
    }

    # Compile and deploy configuration
    try
    {
        Master -ConfigurationData $ConfigurationData -ApplicationId $ApplicationId -TenantId $TenantId -CertificateThumbprint $CertificateThumbprint
        Start-DscConfiguration Master -Wait -Force -Verbose -ErrorAction Stop
    }
    catch
    {
        throw $_
    }
