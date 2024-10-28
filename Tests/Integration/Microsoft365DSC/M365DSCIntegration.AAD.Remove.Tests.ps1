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
