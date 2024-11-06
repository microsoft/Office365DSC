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
                    Ensure       = "Absent"
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
                    AllowCamera                              = $True;
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
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAddressBookPolicy 'ConfigureAddressBookPolicy'
                {
                    Name                 = "All Fabrikam ABP"
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAddressList 'HRUsersAddressList'
                {
                    Name                       = "HR Users"
                    Ensure                     = "Absent"
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
                    DmarcQuarantineAction                 = "Quarantine"
                    DmarcRejectAction                     = "Reject"
                    Ensure                                = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAntiPhishRule 'ConfigureAntiPhishRule'
                {
                    Identity                  = "Test Rule"
                    AntiPhishPolicy           = "Our Rule"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOApplicationAccessPolicy 'ConfigureApplicationAccessPolicy'
                {
                    Identity             = "Integration Policy"
                    AppID                = '3dbc2ae1-7198-45ed-9f9f-d86ba3ec35b5'
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOATPProtectionPolicyRule 'EXOATPProtectionPolicyRule-Strict Preset Security Policy'
                {
                    Comments                = "Built-in Strict Preset Security Policy";
                    Enabled                 = $False;
                    Identity                = "Strict Preset Security Policy";
                    Name                    = "Strict Preset Security Policy";
                    Priority                = 0;
                    SafeAttachmentPolicy    = "Strict Preset Security Policy1725468967835";
                    SafeLinksPolicy         = "Strict Preset Security Policy1725468969412";
                    Ensure                  = "Absent"
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
                EXOAuthenticationPolicyAssignment 'ConfigureAuthenticationPolicyAssignment'
                {
                    UserName                 = "AdeleV@$TenantId"
                    AuthenticationPolicyName = "Test Policy"
                    Ensure                   = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAvailabilityAddressSpace 'ConfigureAvailabilityAddressSpace'
                {
                    Identity              = 'Contoso.com'
                    Ensure                = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOAvailabilityConfig 'ConfigureAvailabilityConfig'
                {
                    OrgWideAccount       = "alexW@$TenantId" # Updated Property
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOClientAccessRule 'ConfigureClientAccessRule'
                {
                    Action                               = "AllowAccess"
                    Identity                             = "Always Allow Remote PowerShell"
                    Ensure                               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODataEncryptionPolicy 'ConfigureDataEncryptionPolicy'
                {
                    Identity    = 'US Mailboxes'
                    Ensure      = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODistributionGroup 'DemoDG'
                {
                    DisplayName                        = "My Demo DG";
                    Ensure                             = "Absent";
                    Identity                           = "DemoDG";
                    Name                               = "DemoDG";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXODkimSigningConfig 'ConfigureDKIMSigning'
                {
                    Identity               = $TenantId
                    Ensure                 = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOEmailAddressPolicy 'ConfigureEmailAddressPolicy'
                {
                    Name                              = "Integration Policy"
                    Ensure                            = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOGlobalAddressList 'ConfigureGlobalAddressList'
                {
                    Name                         = "Contoso Human Resources in Washington"
                    Ensure                       = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedContentFilterPolicy 'ConfigureHostedContentFilterPolicy'
                {
                    Identity                             = "Integration CFP"
                    Ensure                               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedContentFilterRule 'ConfigureHostedContentFilterRule'
                {
                    Identity                  = "Integration CFR"
                    HostedContentFilterPolicy = "Integration CFP"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedOutboundSpamFilterPolicy 'HostedOutboundSpamFilterPolicy'
                {
                    Identity                                  = "Integration SFP"
                    Ensure                                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOHostedOutboundSpamFilterRule 'ConfigureHostedOutboundSpamFilterRule'
                {
                    Identity                       = "Contoso Executives"
                    Enabled                        = $False # Updated Property
                    HostedOutboundSpamFilterPolicy = "Integration SFP"
                    Ensure                         = "Absent"
                    Credential                     = $Credscredential
                }
                EXOInboundConnector 'ConfigureInboundConnector'
                {
                    Identity                     = "Integration Inbound Connector"
                    Ensure                       = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOIntraOrganizationConnector 'ConfigureIntraOrganizationConnector'
                {
                    Identity             = "MainCloudConnector"
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOJournalRule 'CreateJournalRule'
                {
                    JournalEmailAddress  = "AdeleV@$TenantId"
                    Name                 = "Send to Adele"
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMailContact 'TestMailContact'
                {
                    Alias                       = 'TestMailContact'
                    DisplayName                 = 'My Test Contact'
                    Ensure                      = 'Absent'
                    ExternalEmailAddress        = 'SMTP:test@tailspintoys.com'
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
                EXOMalwareFilterPolicy 'ConfigureMalwareFilterPolicy'
                {
                    Identity                               = "IntegrationMFP"
                    Ensure                                 = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOMalwareFilterRule 'ConfigureMalwareFilterRule'
                {
                    Identity                  = "Contoso Recipients"
                    MalwareFilterPolicy       = "IntegrationMFP"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementRole 'ConfigureManagementRole'
                {
                    Name                 = "MyDisplayName"
                    Description          = "Updated Description" # Updated Property
                    Parent               = "contoso.onmicrosoft.com\MyProfileInformation"
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementRoleAssignment 'AssignManagementRole'
                {
                    Ensure               = "Absent";
                    Name                 = "MyManagementRoleAssignment";
                    Role                 = "UserApplication";
                    User                 = "AlexW@$TenantId"; # Updated Property
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOManagementScope 'EXOManagementScope-Test New DGs'
                {
                    ApplicationId              = $ApplicationId
                    TenantId                   = $TenantId
                    CertificateThumbprint      = $CertificateThumbprint
                    Ensure                     = "Absent";
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
                    Ensure                      = "Absent"
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
                    Ensure                        = "Absent";
                    Identity                      = "testIMAP";
                    MailboxPermission             = "Admin";
                    MaxConcurrentIncrementalSyncs = "10";
                    MaxConcurrentMigrations       = "20";
                    Port                          = 993;
                    RemoteServer                  = "gmail.com";
                    Security                      = "None";
                }
                EXOMobileDeviceMailboxPolicy 'ConfigureMobileDeviceMailboxPolicy'
                {
                    Name                                     = "Default"
                    Ensure                                   = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOfflineAddressBook 'ConfigureOfflineAddressBook'
                {
                    Name                 = "Integration Address Book"
                    AddressLists         = @('\Offline Global Address List')
                    ConfiguredAttributes = @('OfficeLocation, ANR', 'ProxyAddresses, ANR', 'PhoneticGivenName, ANR', 'GivenName, ANR', 'PhoneticSurname, ANR', 'Surname, ANR', 'Account, ANR', 'PhoneticDisplayName, ANR', 'UserInformationDisplayName, ANR', 'ExternalMemberCount, Value', 'TotalMemberCount, Value', 'ModerationEnabled, Value', 'DelivContLength, Value', 'MailTipTranslations, Value', 'ObjectGuid, Value', 'IsOrganizational, Value', 'HabSeniorityIndex, Value', 'DisplayTypeEx, Value', 'SimpleDisplayNameAnsi, Value', 'HomeMdbA, Value', 'Certificate, Value', 'UserSMimeCertificate, Value', 'UserCertificate, Value', 'Comment, Value', 'PagerTelephoneNumber, Value', 'AssistantTelephoneNumber, Value', 'MobileTelephoneNumber, Value', 'PrimaryFaxNumber, Value', 'Home2TelephoneNumberMv, Value', 'Business2TelephoneNumberMv, Value', 'HomeTelephoneNumber, Value', 'TargetAddress, Value', 'PhoneticDepartmentName, Value', 'DepartmentName, Value', 'Assistant, Value', 'PhoneticCompanyName, Value', 'CompanyName, Value', 'Title, Value', 'Country, Value', 'PostalCode, Value', 'StateOrProvince, Value', 'Locality, Value', 'StreetAddress, Value', 'Initials, Value', 'BusinessTelephoneNumber, Value', 'SendRichInfo, Value', 'ObjectType, Value', 'DisplayType, Value', 'RejectMessagesFromDLMembers, Indicator', 'AcceptMessagesOnlyFromDLMembers, Indicator', 'RejectMessagesFrom, Indicator', 'AcceptMessagesOnlyFrom, Indicator', 'UmSpokenName, Indicator', 'ThumbnailPhoto, Indicator')
                    DiffRetentionPeriod  = "30"
                    IsDefault            = $true
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOMEConfiguration 'ConfigureOMEConfiguration'
                {
                    Identity                 = "Contoso Marketing"
                    Ensure                   = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOnPremisesOrganization 'ConfigureOnPremisesOrganization'
                {
                    Identity          = 'Contoso'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOrganizationRelationship 'ConfigureOrganizationRelationship'
                {
                    Name                  = "Contoso"
                    Enabled               = $True
                    Ensure                = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOutboundConnector 'ConfigureOutboundConnector'
                {
                    Identity                      = "Contoso Outbound Connector"
                    Ensure                        = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOOwaMailboxPolicy 'ConfigureOwaMailboxPolicy'
                {
                    Name                  = "OwaMailboxPolicy-Integration"
                    Ensure                = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOPartnerApplication 'ConfigurePartnerApplication'
                {
                    Name                                = "HRApp"
                    ApplicationIdentifier               = "00000006-0000-0dd1-ac00-000000000000"
                    Ensure                              = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOPhishSimOverrideRule 'EXOPhishSimOverrideRule-_Exe:PhishSimOverr:d779965e-ab14-4dd8-b3f5-0876a99f988b'
                {
                    Ensure                                   = "Absent";
                    Identity                                 = "_Exe:PhishSimOverr:d779965e-ab14-4dd8-b3f5-0876a99f988b";
                    ApplicationId                            = $ApplicationId
                    TenantId                                 = $TenantId
                    CertificateThumbprint                    = $CertificateThumbprint
                }
                EXOPlace 'TestPlace'
                {
                    AudioDeviceName        = "MyAudioDevice";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayDeviceName      = "DisplayDeviceName";
                    Ensure                 = 'Absent'
                    Identity               = "Hood@$TenantId";
                }
                EXOPolicyTipConfig 'ConfigurePolicyTipConfig'
                {
                    Name                 = "en\NotifyOnly"
                    Value                = "This message contains content that is restricted by Contoso company policy. Updated" # Updated Property
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOQuarantinePolicy 'ConfigureQuarantinePolicy'
                {
                    Identity                          = "$TenantId\IntegrationPolicy";
                    Ensure                            = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORecipientPermission 'AddSendAs'
                {
        
                    Identity     = 'AdeleV@$Domain'
                    Trustee      = "admin@$TenantId"
                    Ensure       = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORemoteDomain '583b0b70-b45d-401f-98a6-0e7fa8434946'
                {
                    Identity                             = "Integration"
                    Ensure                               = "Absent"
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
                    RetentionPolicyTagLinks     = @("6 Month Delete","Personal 5 year move to archive","1 Month Delete","1 Week Delete","Personal never move to archive","Personal 1 year move to archive","Default 2 year move to archive","Deleted Items","Junk Email","Recoverable Items 14 days move to archive","Never Delete");
                    Ensure                      = "Absent";
                    ApplicationId               = $ApplicationId;
                    TenantId                    = $TenantId;
                    CertificateThumbprint       = $CertificateThumbprint;
                }
                EXORoleAssignmentPolicy 'ConfigureRoleAssignmentPolicy'
                {
                    Name                 = "Integration Policy"
                    IsDefault            = $False # Updated Property
                    Roles                = @("My Marketplace Apps","MyVoiceMail","MyDistributionGroups","MyRetentionPolicies","MyContactInformation","MyBaseOptions","MyTextMessaging","MyDistributionGroupMembership","MyProfileInformation","My Custom Apps","My ReadWriteMailbox Apps")
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXORoleGroup 'ConfigureRoleGroup'
                {
                    Name                      = "Contoso Role Group"
                    Members                   = @("Exchange Administrator")
                    Roles                     = @("Address Lists")
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeAttachmentPolicy 'ConfigureSafeAttachmentPolicy'
                {
                    Identity             = "Marketing Block Attachments"
                    Enable               = $False # Updated Property
                    Ensure               = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeAttachmentRule 'ConfigureSafeAttachmentRule'
                {
                    Identity                  = "Research Department Attachment Rule"
                    Enabled                   = $False # Updated Property
                    ExceptIfSentToMemberOf    = "Research Department Managers"
                    SafeAttachmentPolicy      = "Marketing Block Attachments"
                    SentToMemberOf            = "Research Department"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeLinksPolicy 'ConfigureSafeLinksPolicy'
                {
                    Identity                      = 'Marketing Block URL'
                    Ensure                        = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSafeLinksRule 'ConfigureSafeLinksRule'
                {
                    Identity                  = "Research Department URL Rule"
                    Comments                  = "Applies to Research Department, except managers"
                    Enabled                   = $False # Updated Property
                    SafeLinksPolicy           = "Marketing Block URL"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSecOpsOverrideRule 'EXOSecOpsOverrideRule-_Exe:SecOpsOverrid:ca3c51ac-925c-49f4-af42-43e26b874245'
                {
                    Ensure               = "Absent";
                    Identity             = "_Exe:SecOpsOverrid:ca3c51ac-925c-49f4-af42-43e26b874245";
                }
                EXOServicePrincipal 'ServicePrincipal'
                {
                    AppId                = "c6871074-3ded-4935-a5dc-b8f8d91d7d06";
                    AppName              = "ISV Portal";
                    DisplayName          = "Arpita";
                    Ensure               = "Absent";
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
                    Ensure             = "Absent"
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
                    Ensure     = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                EXOSweepRule 'MyRule'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Enabled               = $True;
                    Ensure                = "Absent";
                    Mailbox               = "Test2";
                    Name                  = "From Michelle";
                    TenantId              = $TenantId;
                }
                EXOTenantAllowBlockListSpoofItems 'EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71'
                {
                    Action                = "Allow";
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Ensure                = "Absent";
                    SendingInfrastructure = "121.0.0.7";
                    SpoofedUser           = "contoso.com";
                    SpoofType             = "Internal";
                    TenantId              = $TenantId;
                }
                EXOTransportRule 'ConfigureTransportRule'
                {
                    Name                                          = "Ethical Wall - Sales and Brokerage Departments"
                    Enabled                                       = $True
                    Ensure                                        = "Absent"
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
