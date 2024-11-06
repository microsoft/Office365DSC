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
                AADAccessReviewDefinition 'AADAccessReviewDefinition-Example'
                {
                    DescriptionForAdmins    = "description for admins";
                    DescriptionForReviewers = "description for reviewers";
                    DisplayName             = "Test Access Review Definition";
                    Ensure                  = "Absent";
                    Id                      = "613854e6-c458-4a2c-83fc-e0f4b8b17d60";
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                }
                AADAdministrativeUnit 'TestUnit'
                {
                    DisplayName                   = 'Test-Unit'
                    Ensure                        = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADApplication 'AADApp1'
                {
                    DisplayName               = "AppDisplayName"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAuthenticationContextClassReference 'AADAuthenticationContextClassReference-Test'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description          = "Context test Updated"; # Updated Property
                    DisplayName          = "My Context";
                    Ensure               = "Absent";
                    Id                   = "c3";
                    IsAvailable          = $True;
                }
                AADAuthenticationMethodPolicyAuthenticator 'AADAuthenticationMethodPolicyAuthenticator-MicrosoftAuthenticator'
                {
                    Ensure                = "Absent";
                    Id                    = "MicrosoftAuthenticator";
                    IncludeTargets        = @(
                        MSFT_AADAuthenticationMethodPolicyAuthenticatorIncludeTarget{
                            Id = 'fakegroup6'
                            TargetType = 'group'
                        }
                    );
                    IsSoftwareOathEnabled = $True; # Updated Property
                    State                 = "enabled";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAuthenticationMethodPolicyExternal 'AADAuthenticationMethodPolicyExternal-Cisco Duo'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayName           = "Cisco Duo";
                    Ensure                = "Absent";
                }
                AADAuthenticationMethodPolicyFido2 'AADAuthenticationMethodPolicyFido2-Fido2'
                {
                    Ensure                           = "Absent";
                    Id                               = "Fido2";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAuthenticationMethodPolicyHardware 'AADAuthenticationMethodPolicyHardware-HardwareOath'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Absent";
                    Id                    = "HardwareOath";
                }
                AADAuthenticationMethodPolicySms 'AADAuthenticationMethodPolicySms-Sms'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Absent";
                    Id                    = "Sms";
                }
                AADAuthenticationMethodPolicySoftware 'AADAuthenticationMethodPolicySoftware-SoftwareOath'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Absent";
                    Id                    = "SoftwareOath";
                }
                AADAuthenticationMethodPolicyTemporary 'AADAuthenticationMethodPolicyTemporary-TemporaryAccessPass'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                   = "Absent";
                    Id                       = "TemporaryAccessPass";
                }
                AADAuthenticationMethodPolicyVoice 'AADAuthenticationMethodPolicyVoice-Voice'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Absent";
                    Id                    = "Voice";
                }
                AADAuthenticationMethodPolicyX509 'AADAuthenticationMethodPolicyX509-X509Certificate'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                          = "Absent";
                    Id                              = "X509Certificate";
                }
                AADAuthenticationStrengthPolicy 'AADAuthenticationStrengthPolicy-Example'
                {
                    DisplayName          = "Example";
                    Ensure               = "Absent";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADClaimsMappingPolicy 'AADClaimsMappingPolicy-Test1234'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayName           = "Test1234";
                    Ensure                = "Absent";
                    Id                    = "fd0dc3f3-cfdf-4d56-bb03-e18161a5ac93";
                }
                AADConditionalAccessPolicy 'ConditionalAccessPolicy'
                {
                    DisplayName                          = 'Example CAP'
                    Ensure                               = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADConnectorGroupApplicationProxy 'AADConnectorGroupApplicationProxy-testgroup'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Absent";
                    Name                  = "testgroup-new";
                    Id                    = "4984dcf7-d9e9-4663-90b4-5db09f92a669";
                }
                AADCrossTenantAccessPolicyConfigurationPartner 'AADCrossTenantAccessPolicyConfigurationPartner'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                   = "Absent";
                    PartnerTenantId          = "12345-12345-12345-12345-12345";
                }
                AADCustomAuthenticationExtension 'AADCustomAuthenticationExtension1'
                {
                    DisplayName               = "DSCTestExtension"
                    Ensure                    = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADCustomSecurityAttributeDefinition 'AADCustomSecurityAttributeDefinition-ShoeSize'
                {
                    ApplicationId           = $ApplicationId;
                    AttributeSet            = "TestAttributeSet";
                    CertificateThumbprint   = $CertificateThumbprint;
                    Ensure                  = "Absent";
                    IsCollection            = $False;
                    IsSearchable            = $True;
                    Name                    = "ShoeSize";
                    Status                  = "Available";
                    TenantId                = $TenantId;
                    Type                    = "String";
                    UsePreDefinedValuesOnly = $False;
                    Description             = "What size of shoe is the person wearing?"
                }
                AADDomain 'AADDomain-Contoso'
                {
                    ApplicationId                    = $ApplicationId;
                    CertificateThumbprint            = $CertificateThumbprint;
                    Ensure                           = "Absent";
                    Id                               = "contoso.com";
                    TenantId                         = $TenantId;
                }
                AADEntitlementManagementAccessPackage 'myAccessPackage'
                {
                    DisplayName                     = 'Integration Package'
                    Ensure                          = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementAccessPackageAssignmentPolicy 'myAssignmentPolicyWithAccessReviewsSettings'
                {
                    DisplayName                = "External tenant";
                    Ensure                     = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementAccessPackageCatalog 'myAccessPackageCatalog'
                {
                    DisplayName         = 'My Catalog'
                    Ensure              = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementAccessPackageCatalogResource 'myAccessPackageCatalogResource'
                {
                    DisplayName         = 'DSCGroup'
                    Ensure              = 'Absent'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementConnectedOrganization 'MyConnectedOrganization'
                {
                    DisplayName           = "Test Tenant - DSC";
                    Ensure                = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementRoleAssignment 'AADEntitlementManagementRoleAssignment-Remove'
                {
                    AppScopeId      = "/";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure          = "Absent";
                    Principal       = "AdeleV@$TenantId";
                    RoleDefinition  = "Catalog creator";
                }
                AADFeatureRolloutPolicy 'AADFeatureRolloutPolicy-CertificateBasedAuthentication rollout policy'
                {
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                    DisplayName             = "CertificateBasedAuthentication rollout policy";
                    Ensure                  = "Absent";
                }
                AADFederationConfiguration 'MyFederation'
                {
                    IssuerUri                       = 'https://contoso.com/issuerUri'
                    DisplayName                     = 'contoso display name'
                    MetadataExchangeUri             ='https://contoso.com/metadataExchangeUri'
                    PassiveSignInUri                = 'https://contoso.com/signin'
                    PreferredAuthenticationProtocol = 'wsFed'
                    Domains                         = @('contoso.com')
                    SigningCertificate              = 'MIIDADCCAeigAwIBAgIQEX41y8r6'
                    Ensure                          = 'Absent'
                    ApplicationId                   = $ApplicationId
                    TenantId                        = $TenantId
                    CertificateThumbprint           = $CertificateThumbprint
                }
                AADFilteringPolicy 'AADFilteringPolicy-MyPolicy'
                {
                    Action                = "block";
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Description           = "This is a demo policy";
                    Ensure                = "Absent";
                    Name                  = "MyPolicy";
                    TenantId              = $TenantId;
                }
                AADFilteringPolicyRule 'AADFilteringPolicyRule-FQDN'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Destinations          = @(
                        MSFT_AADFilteringPolicyRuleDestination{
                            value = 'Microsoft365DSC.com'
                        }
                    );
                    Ensure                = "Absent";
                    Name                  = "MyFQDN";
                    Policy                = "AMyPolicy";
                    RuleType              = "fqdn";
                    TenantId              = $TenantId;
                }
                AADFilteringPolicyRule 'AADFilteringPolicyRule-Web'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Destinations          = @(
                        MSFT_AADFilteringPolicyRuleDestination{
                            name = 'ChildAbuseImages'
                        }
                    );
                    Ensure                = "Absent";
                    Name                  = "MyWebContentRule";
                    Policy                = "MyPolicy";
                    RuleType              = "webCategory";
                    TenantId              = $TenantId;
                }
                AADFilteringProfile 'AADFilteringProfile-My Profile'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Description           = "Description of profile";
                    Ensure                = "Absent";
                    Name                  = "My PRofile";
                    Policies              = @(
                        MSFT_AADFilteringProfilePolicyLink{
                            Priority = 100
                            LoggingState = 'enabled'
                            PolicyName = 'MyPolicyChoseBine'
                            State = 'enabled'
                        }
                        MSFT_AADFilteringProfilePolicyLink{
                            Priority = 200
                            LoggingState = 'enabled'
                            PolicyName = 'MyTopPolicy'
                            State = 'enabled'
                        }
                    );
                    Priority              = 120;
                    State                 = "enabled";
                    TenantId              = $TenantId;
                }
                AADGroup 'MyGroups'
                {
                    MailNickname    = "M365DSC"
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    DisplayName     = "DSCGroup"
                    Ensure          = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADGroupLifecyclePolicy 'GroupLifecyclePolicy'
                {
                    IsSingleInstance            = "Yes"
                    AlternateNotificationEmails = @("john.smith@$TenantId")
                    GroupLifetimeInDays         = 99
                    ManagedGroupTypes           = "Selected"
                    Ensure                      = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADGroupsNamingPolicy 'GroupsNamingPolicy'
                {
                    IsSingleInstance              = "Yes"
                    Ensure                        = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADGroupsSettings 'GeneralGroupsSettings'
                {
                    IsSingleInstance              = "Yes"
                    Ensure                        = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADHomeRealmDiscoveryPolicy 'AADHomeRealmDiscoveryPolicy-displayName-value'
                {
                    Definition            = @(
                        MSFT_AADHomeRealDiscoveryPolicyDefinition {
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $False
                            AlternateIdLogin = MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin {
                                Enabled = $True
                            }
                        }
                    );
                    DisplayName           = "displayName-value";
                    Ensure                = "Absent";
                    IsOrganizationDefault = $False;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
                {
                    DisplayName           = "NewTestConnector";
                    Id                    = "RestApi_NewTestConnector";
                    Username              = "anexas";
                    Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
                    TargetUrl             = "https://graph.microsoft.com";
                    Ensure                = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADIdentityB2XUserFlow 'AADIdentityB2XUserFlow-B2X_1_TestFlow'
                {
                    ApplicationId             = $ApplicationId
                    TenantId                  = $TenantId
                    CertificateThumbprint     = $CertificateThumbprint
                    Id                        = "B2X_1_TestFlow";
                }
                AADIdentityGovernanceLifecycleWorkflow 'AADIdentityGovernanceLifecycleWorkflow-Onboard pre-hire employee updated version'
                {
                    Category             = "joiner";
                    Description          = "Updated description the onboard of prehire employee";
                    DisplayName          = "Onboard pre-hire employee updated version";
                    Ensure               = "Absent";
                    ExecutionConditions  = MSFT_IdentityGovernanceWorkflowExecutionConditions {
                        ScopeValue = MSFT_IdentityGovernanceScope {
                            Rule = '(not (country eq ''America''))'
                            ODataType = '#microsoft.graph.identityGovernance.ruleBasedSubjectSet'
                        }
                        TriggerValue = MSFT_IdentityGovernanceTrigger {
                            OffsetInDays = 4
                            TimeBasedAttribute = 'employeeHireDate'
                            ODataType = '#microsoft.graph.identityGovernance.timeBasedAttributeTrigger'
                        }
                        ODataType = '#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions'
                    };
                    IsEnabled            = $True;
                    IsSchedulingEnabled  = $False;
                    Tasks                = @(
                        MSFT_AADIdentityGovernanceTask {
                            DisplayName       = 'Add user to groups'
                            Description       = 'Add user to selected groups updated'
                            Category          = 'joiner,leaver,mover'
                            IsEnabled         = $True
                            ExecutionSequence = 1
                            ContinueOnError   = $True
                            TaskDefinitionId   = '22085229-5809-45e8-97fd-270d28d66910'
                            Arguments         = @(
                                MSFT_AADIdentityGovernanceTaskArguments {
                                    Name  = 'groupID'
                                    Value = '7ad01e00-8c3a-42a6-baaf-39f2390b2565'
                                }
                            )
                        }
                    );
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension 'AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension-My Custom'
                {
                    ApplicationId         = $ApplicationId;
                    CallbackConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    };
                    CertificateThumbprint = $CertificateThumbprint;
                    ClientConfiguration   = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    };
                    Description           = "My Description";
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    };
                    Ensure                = "Absent";
                    TenantId              = $TenantId;
                }
                AADIdentityGovernanceProgram 'AADIdentityGovernanceProgram-Example'
                {
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                    DisplayName             = "Example";
                    Ensure                  = "Absent";
                }
                AADNamedLocationPolicy 'CompanyNetwork'
                {
                    DisplayName = "Company Network"
                    Ensure      = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADOrganizationCertificateBasedAuthConfiguration 'AADOrganizationCertificateBasedAuthConfiguration-58b6e58e-10d1-4b8c-845d-d6aefaaecba2'
                {
                    ApplicationId             = $ApplicationId
                    TenantId                  = $TenantId
                    CertificateThumbprint     = $CertificateThumbprint
                    Ensure                 = "Absent";
                    OrganizationId         = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
                }
                AADRemoteNetwork 'AADRemoteNetwork-Test Remote Network'
                {
                    Ensure                = "Absent";
                    ForwardingProfiles    = @("Microsoft 365 traffic forwarding profile");
                    Id                    = "c60c41bb-e512-48e3-8134-c312439a5343";
                    Name                  = "Test Remote Network";
                    Region                = "australiaSouthEast";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DeviceLinks           = @(
                        MSFT_AADRemoteNetworkDeviceLink {
                            Name                    = 'Test Link'
                            IPAddress               = '1.1.1.1'
                            BandwidthCapacityInMbps = 'mbps500'
                            DeviceVendor            = 'ciscoCatalyst'
                            BgpConfiguration        = MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration {
                                Asn                 = 82
                                LocalIPAddress      = '1.1.1.87'
                                PeerIPAddress       = '1.1.1.2'
                            }
                            RedundancyConfiguration = MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration {
                                RedundancyTier      = 'zoneRedundancy'
                                ZoneLocalIPAddress  = '1.1.1.8'
                            }
                            TunnelConfiguration     = MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration {
                                PreSharedKey               = 'blah'
                                ZoneRedundancyPreSharedKey = 'blah'
                                SaLifeTimeSeconds          = 300
                                IPSecEncryption            = 'gcmAes192'
                                IPSecIntegrity             = 'gcmAes192'
                                IKEEncryption              = 'aes192'
                                IKEIntegrity               = 'gcmAes128'
                                DHGroup                    = 'ecp256'
                                PFSGroup                   = 'pfsmm'
                                ODataType                  = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Custom'
                            }
                        }
                    );
                }
                AADRoleDefinition 'AADRoleDefinition1'
                {
                    IsEnabled                     = $true
                    RolePermissions               = "microsoft.directory/applicationPolicies/allProperties/read"
                    DisplayName                   = "DSCRole1"
                    Ensure                        = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADRoleEligibilityScheduleRequest 'MyRequest'
                {
                    Action               = "AdminAssign";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DirectoryScopeId     = "/";
                    Ensure               = "Absent";
                    IsValidationOnly     = $True; # Updated Property
                    Principal            = "AdeleV@$TenantId";
                    RoleDefinition       = "Teams Communications Administrator";
                    ScheduleInfo         = MSFT_AADRoleEligibilityScheduleRequestSchedule {
                        startDateTime             = '2023-09-01T02:40:44Z'
                        expiration                = MSFT_AADRoleEligibilityScheduleRequestScheduleExpiration
                            {
                                endDateTime = '2025-10-31T02:40:09Z'
                                type        = 'afterDateTime'
                            }
                    };
                }
                AADServicePrincipal 'AADServicePrincipal'
                {
                    AppId                         = "AppDisplayName"
                    DisplayName                   = "AppDisplayName"
                    Ensure                        = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADSocialIdentityProvider 'AADSocialIdentityProvider-Google'
                {
                    ClientId             = "Google-OAUTH";
                    ClientSecret         = "FakeSecret-Updated"; # Updated Property
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayName          = "My Google Provider";
                    Ensure               = "Absent";
                    IdentityProviderType = "Google";
                }
                AADTokenLifetimePolicy 'CreateTokenLifetimePolicy'
                {
                    DisplayName           = "PolicyDisplayName"
                    Ensure                = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADUser 'ConfigureJohnSMith'
                {
                    UserPrincipalName  = "John.Smith@$TenantId"
                    DisplayName        = "John J. Smith"
                    Ensure             = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADUserFlowAttribute 'SaiTest'
                {
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Ensure             = "Absent"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
                {
                    DidMethod            = "web";
                    Ensure               = "Absent";
                    KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                        SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                        ResourceName = 'xtakeyvault'
                        ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                        ResourceGroup = 'TBD'
                    };
                    LinkedDomainUrl      = "https://nik-charlebois.com/";
                    Name                 = "Contoso";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADVerifiedIdAuthorityContract 'AADVerifiedIdAuthorityContract-Sample Custom Verified Credentials'
                {
                    displays             = @(
                        MSFT_AADVerifiedIdAuthorityContractDisplayModel{
                            consent = MSFT_AADVerifiedIdAuthorityContractDisplayConsent{
                                instructions = 'Sign in with your account to get your card.'
                                title = 'Do you want to get your Verified Credential?'
                            }
                            card = MSFT_AADVerifiedIdAuthorityContractDisplayCard{
                                description = 'Use your verified credential to prove to anyone that you know all about verifiable credentials.'
                                issuedBy = 'Microsoft'
                                backgroundColor = '#000000'
                                textColor = '#ffffff'
                                logo = MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo{
                                    uri = 'https://didcustomerplayground.z13.web.core.windows.net/VerifiedCredentialExpert_icon.png'
                                    description = 'Verified Credential Expert Logo'
                                }
                                title = 'Verified Credential Expert'
                            }
                            locale = 'en-US'
                            claims = @(
                                MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                                    label = 'First name'
                                    claim = 'vc.credentialSubject.firstName'
                                    type = 'String'
                                }
                                MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                                    label = 'Last name'
                                    claim = 'vc.credentialSubject.lastName'
                                    type = 'String'
                                }
                            )
        
                        }
                    );
                    Ensure               = "Absent";
                    linkedDomainUrl      = "https://$OrganizationName/";
                    name                 = "Sample Custom Verified Credentials";
                    rules                = MSFT_AADVerifiedIdAuthorityContractRulesModel{
                        validityInterval = 2592000
                        vc = MSFT_AADVerifiedIdAuthorityContractVcType{
                            type = @('VerifiedCredentialExpert')
                        }
                                    attestations = MSFT_AADVerifiedIdAuthorityContractAttestations{
                            idTokenHints = @(
                                MSFT_AADVerifiedIdAuthorityContractAttestationValues{
                                    mapping = @(
                                        MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                            inputClaim = '$.given_name'
                                            indexed = $False
                                            outputClaim = 'firstName'
                                            required = $True
                                        }
                                        MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                            inputClaim = '$.family_name'
                                            indexed = $True
                                            outputClaim = 'lastName'
                                            required = $True
                                        }
                                    )
                                    required = $False
                                }
                            )
        
                        }
                    
                    };
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
