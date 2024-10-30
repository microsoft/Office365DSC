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
                    DescriptionForReviewers = "description for reviewers updated"; # drifted properties
                    DisplayName             = "Test Access Review Definition";
                    Ensure                  = "Present";
                    Id                      = "613854e6-c458-4a2c-83fc-e0f4b8b17d60";
                    ScopeValue              = MSFT_MicrosoftGraphaccessReviewScope{
                        PrincipalScopes = @(
                            MSFT_MicrosoftGraphAccessReviewScope{
                                Query = '/v1.0/users?$filter=userType eq ''Guest'''
                                odataType = '#microsoft.graph.accessReviewQueryScope'
                                QueryType = 'MicrosoftGraph'
                            }
                        )
                        ResourceScopes = @(
                            MSFT_MicrosoftGraphAccessReviewScope{
                                Query = '/v1.0/groups/a8ab05ba-6680-4f93-88ae-71099eedfda1/transitiveMembers/microsoft.graph.user/?$count=true&$filter=(userType eq ''Guest'')'
                                odataType = '#microsoft.graph.accessReviewQueryScope'
                                QueryType = 'MicrosoftGraph'
                            }
                            MSFT_MicrosoftGraphAccessReviewScope{
                                Query = '/beta/teams/a8ab05ba-6680-4f93-88ae-71099eedfda1/channels?$filter=membershipType eq ''shared'''
                                odataType = '#microsoft.graph.accessReviewQueryScope'
                                QueryType = 'MicrosoftGraph'
                            }
                        )
                        odataType = '#microsoft.graph.principalResourceMembershipsScope'
                    };
                    SettingsValue           = MSFT_MicrosoftGraphaccessReviewScheduleSettings{
                        ApplyActions = @(
                            MSFT_MicrosoftGraphAccessReviewApplyAction{
                                odataType = '#microsoft.graph.removeAccessApplyAction'
                            }
                        )
                        InstanceDurationInDays = 4
                        RecommendationsEnabled = $False
                        DecisionHistoriesForReviewersEnabled = $False
                        DefaultDecisionEnabled = $False
                        JustificationRequiredOnApproval = $True
                        RecommendationInsightSettings = @(
                            MSFT_MicrosoftGraphAccessReviewRecommendationInsightSetting{
                                SignInScope = 'tenant'
                                RecommendationLookBackDuration = 'P15D'
                                odataType = '#microsoft.graph.userLastSignInRecommendationInsightSetting'
                            }
                        )
                        AutoApplyDecisionsEnabled = $False
                        ReminderNotificationsEnabled = $True
                        Recurrence = MSFT_MicrosoftGraphPatternedRecurrence{
                            Range = MSFT_MicrosoftGraphRecurrenceRange{
                                NumberOfOccurrences = 0
                                Type = 'noEnd'
                                StartDate = '10/18/2024 12:00:00 AM'
                                EndDate = '12/31/9999 12:00:00 AM'
                            }
                            Pattern = MSFT_MicrosoftGraphRecurrencePattern{
                                DaysOfWeek = @()
                                Type = 'weekly'
                                Interval = 1
                                Month = 0
                                Index = 'first'
                                FirstDayOfWeek = 'sunday'
                                DayOfMonth = 0
                            }
        
                        }
                        DefaultDecision = 'None'
                        RecommendationLookBackDuration = '15.00:00:00'
                        MailNotificationsEnabled = $False
                    };
                    StageSettings           = @(
                        MSFT_MicrosoftGraphaccessReviewStageSettings{
                            StageId = '1'
                            RecommendationsEnabled = $True
                            DependsOnValue = @()
                            DecisionsThatWillMoveToNextStage = @('Approve')
                            DurationInDays = 3
                        }
                        MSFT_MicrosoftGraphaccessReviewStageSettings{
                            StageId = '2'
                            RecommendationsEnabled = $True
                            DependsOnValue = @('1')
                            DecisionsThatWillMoveToNextStage = @('Approve')
                            DurationInDays = 3
                        }
                    );
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAccessReviewPolicy 'AADAccessReviewPolicy'
                {
                    IsGroupOwnerManagementEnabled = $False;
                    IsSingleInstance              = "Yes";
                    ApplicationId                 = $ApplicationId
                    TenantId                      = $TenantId
                    CertificateThumbprint         = $CertificateThumbprint
                }
                AADAdminConsentRequestPolicy 'AADAdminConsentRequestPolicy'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    IsEnabled             = $True;
                    IsSingleInstance      = "Yes";
                    NotifyReviewers       = $False;
                    RemindersEnabled      = $True;
                    RequestDurationInDays = 30;
                    Reviewers             =                 @(
                        MSFT_AADAdminConsentRequestPolicyReviewer {
                             ReviewerType = 'User'
                             ReviewerId   = "AlexW@$TenantId"
                        }
                        MSFT_AADAdminConsentRequestPolicyReviewer {
                             ReviewerType = 'Group'
                             ReviewerId   = 'Communications'
                        }
                        MSFT_AADAdminConsentRequestPolicyReviewer {
                             ReviewerType = 'Role'
                             ReviewerId   = 'Attack Payload Author'
                        }
                        MSFT_AADAdminConsentRequestPolicyReviewer {
                             ReviewerType = 'Role'
                             ReviewerId   = 'Attack Simulation Administrator'
                        }
                        );
                    TenantId              = $TenantId;
                }
                AADAdministrativeUnit 'TestUnit'
                {
                    DisplayName                   = 'Test-Unit'
                    Description                   = 'Test Description Updated' # Updated Property
                    Visibility                    = 'Public'
                    MembershipRule                = "(user.country -eq `"US`")" # Updated Property
                    MembershipRuleProcessingState = 'On'
                    MembershipType                = 'Dynamic'
                    IsMemberManagementRestricted  = $False
                    ScopedRoleMembers             = @(
                        MSFT_MicrosoftGraphScopedRoleMembership
                        {
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = MSFT_MicrosoftGraphMember
                            {
                                Identity = "AdeleV@$TenantId" # Updated Property
                                Type     = "User"
                            }
                        }
                    )
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADApplication 'AADApp1'
                {
                    DisplayName               = "AppDisplayName"
                    AvailableToOtherTenants   = $true # Updated Property
                    Description               = "Application Description"
                    GroupMembershipClaims     = "None"
                    Homepage                  = "https://$TenantId"
                    IdentifierUris            = "https://$TenantId"
                    KnownClientApplications   = ""
                    LogoutURL                 = "https://$TenantId/logout"
                    PublicClient              = $false
                    ReplyURLs                 = "https://$TenantId"
                    Permissions               = @(
                        MSFT_AADApplicationPermission
                        {
                            Name                = 'User.Read'
                            Type                = 'Delegated'
                            SourceAPI           = 'Microsoft Graph'
                            AdminConsentGranted = $false
                        }
                        MSFT_AADApplicationPermission
                        {
                            Name                = 'User.ReadWrite.All'
                            Type                = 'Delegated'
                            SourceAPI           = 'Microsoft Graph'
                            AdminConsentGranted = $True
                        }
                        MSFT_AADApplicationPermission
                        {
                            Name                = 'User.Read.All'
                            Type                = 'AppOnly'
                            SourceAPI           = 'Microsoft Graph'
                            AdminConsentGranted = $True
                        }
                    )
                    Ensure                    = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAttributeSet 'AADAttributeSetTest'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description          = "Attribute set with 420 attributes";
                    Ensure               = "Present";
                    Id                   = "TestAttributeSet";
                    MaxAttributesPerSet  = 300; # Updated Property
                }
                AADAuthenticationContextClassReference 'AADAuthenticationContextClassReference-Test'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description          = "Context test Updated"; # Updated Property
                    DisplayName          = "My Context";
                    Ensure               = "Present";
                    Id                   = "c3";
                    IsAvailable          = $False; # Updated Property
                }
                AADAuthenticationFlowPolicy 'AADAuthenticationFlowPolicy'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description              = "Authentication flows policy allows modification of settings related to authentication flows in AAD tenant, such as self-service sign up configuration.";
                    DisplayName              = "Authentication flows policy";
                    Id                       = "authenticationFlowsPolicy";
                    IsSingleInstance         = "Yes";
                    SelfServiceSignUpEnabled = $True;
                }
                AADAuthenticationMethodPolicy 'AADAuthenticationMethodPolicy-Authentication Methods Policy'
                {
                    DisplayName             = "Authentication Methods Policy";
                    Ensure                  = "Present";
                    Id                      = "authenticationMethodsPolicy";
                    PolicyMigrationState    = "migrationInProgress";
                    PolicyVersion           = "1.5";
                    RegistrationEnforcement = MSFT_MicrosoftGraphregistrationEnforcement{
                        AuthenticationMethodsRegistrationCampaign = MSFT_MicrosoftGraphAuthenticationMethodsRegistrationCampaign{
                            SnoozeDurationInDays = (Get-Random -Minimum 1 -Maximum 14)
                            IncludeTargets = @(
                                MSFT_MicrosoftGraphAuthenticationMethodsRegistrationCampaignIncludeTarget{
                                    TargetedAuthenticationMethod = 'microsoftAuthenticator'
                                    TargetType = 'group'
                                    Id = 'all_users'
                                }
                            )
                            State = 'default'
                        }
                    };
                    ReportSuspiciousActivitySettings = MSFT_MicrosoftGraphreportSuspiciousActivitySettings{
                        VoiceReportingCode = 0
                        IncludeTarget = MSFT_AADAuthenticationMethodPolicyIncludeTarget{
                            Id = 'all_users'
                            TargetType = 'group'
                        }
                        State = 'default'
                    };
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAuthenticationMethodPolicyAuthenticator 'AADAuthenticationMethodPolicyAuthenticator-MicrosoftAuthenticator'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Present";
                    ExcludeTargets        = @(
                        MSFT_AADAuthenticationMethodPolicyAuthenticatorExcludeTarget{
                            Id = 'Executives' # Updated Property
                            TargetType = 'group'
                        }
                    );
                    FeatureSettings       = MSFT_MicrosoftGraphmicrosoftAuthenticatorFeatureSettings{
                        DisplayLocationInformationRequiredState = MSFT_MicrosoftGraphAuthenticationMethodFeatureConfiguration{
                            IncludeTarget = MSFT_AADAuthenticationMethodPolicyAuthenticatorFeatureTarget{
                                Id = 'all_users'
                                TargetType = 'group'
                            }
                            State = 'default'
                        }
                        CompanionAppAllowedState = MSFT_MicrosoftGraphAuthenticationMethodFeatureConfiguration{
                            IncludeTarget = MSFT_AADAuthenticationMethodPolicyAuthenticatorFeatureTarget{
                                Id = 'all_users'
                                TargetType = 'group'
                            }
                            State = 'default'
                        }
                        DisplayAppInformationRequiredState = MSFT_MicrosoftGraphAuthenticationMethodFeatureConfiguration{
                            IncludeTarget = MSFT_AADAuthenticationMethodPolicyAuthenticatorFeatureTarget{
                                Id = 'all_users'
                                TargetType = 'group'
                            }
                            State = 'default'
                        }
                    };
                    Id                    = "MicrosoftAuthenticator";
                    IncludeTargets        = @(
                        MSFT_AADAuthenticationMethodPolicyAuthenticatorIncludeTarget{
                            Id = 'Finance Team'
                            TargetType = 'group'
                        }
                        MSFT_AADAuthenticationMethodPolicyAuthenticatorIncludeTarget{
                            Id = 'Northwind Traders'
                            TargetType = 'group'
                        }
                    );
                    IsSoftwareOathEnabled = $False;
                    State                 = "enabled";
                }
                AADAuthenticationMethodPolicyEmail 'AADAuthenticationMethodPolicyEmail-Email'
                {
                    AllowExternalIdToUseEmailOtp = "enabled";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                       = "Present";
                    ExcludeTargets               = @(
                        MSFT_AADAuthenticationMethodPolicyEmailExcludeTarget{
                            Id = 'Paralegals'
                            TargetType = 'group'
                        }
                    );
                    Id                           = "Email";
                    IncludeTargets               = @(
                        MSFT_AADAuthenticationMethodPolicyEmailIncludeTarget{
                            Id = 'Finance Team'
                            TargetType = 'group'
                        }
                        MSFT_AADAuthenticationMethodPolicyEmailIncludeTarget{
                            Id = 'Legal Team'
                            TargetType = 'group'
                        }
                    );
                    State                        = "enabled"; # Updated Property
                }
                AADAuthenticationMethodPolicyExternal 'AADAuthenticationMethodPolicyExternal-Cisco Duo'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    AppId                 = "e35c54ff-bd24-4c52-921a-4b90a35808eb";
                    DisplayName           = "Cisco Duo";
                    Ensure                = "Present";
                    ExcludeTargets        = @(
                        MSFT_AADAuthenticationMethodPolicyExternalExcludeTarget{
                            Id = 'Design'
                            TargetType = 'group'
                        }
                    );
                    IncludeTargets        = @(
                        MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget{
                            Id = 'Contoso'
                            TargetType = 'group'
                        }
                    );
                    OpenIdConnectSetting  = MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting{
                        discoveryUrl = 'https://graph.microsoft.com/'
                        clientId = '7698a352-4939-486e-9974-4ea5aff93f74'
                    };
                    State                 = "disabled";
                }
                AADAuthenticationMethodPolicyFido2 'AADAuthenticationMethodPolicyFido2-Fido2'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                           = "Present";
                    ExcludeTargets                   = @(
                        MSFT_AADAuthenticationMethodPolicyFido2ExcludeTarget{
                            Id = 'Paralegals'
                            TargetType = 'group'
                        }
                        MSFT_AADAuthenticationMethodPolicyFido2ExcludeTarget{
                            Id = 'Executives'
                            TargetType = 'group'
                        }
                    );
                    Id                               = "Fido2";
                    IncludeTargets                   = @(
                        MSFT_AADAuthenticationMethodPolicyFido2IncludeTarget{
                            Id = 'all_users'
                            TargetType = 'group'
                        }
                    );
                    IsAttestationEnforced            = $False;
                    IsSelfServiceRegistrationAllowed = $True;
                    KeyRestrictions                  = MSFT_MicrosoftGraphfido2KeyRestrictions{
                        IsEnforced = $False
                        EnforcementType = 'block'
                        AaGuids = @()
                    };
                    State                            = "enabled"; # Updated Property
                }
                AADAuthenticationMethodPolicyHardware 'AADAuthenticationMethodPolicyHardware-HardwareOath'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure               = "Present";
                    ExcludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicyHardwareExcludeTarget{
                            Id = 'Executives'
                            TargetType = 'group'
                        }
                        MSFT_AADAuthenticationMethodPolicyHardwareExcludeTarget{
                            Id = 'Paralegals'
                            TargetType = 'group'
                        }
                    );
                    Id                   = "HardwareOath";
                    IncludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicyHardwareIncludeTarget{
                            Id = 'Legal Team'
                            TargetType = 'group'
                        }
                    );
                    State                = "enabled"; # Updated Property
                }
                AADAuthenticationMethodPolicySms 'AADAuthenticationMethodPolicySms-Sms'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure               = "Present";
                    ExcludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicySmsExcludeTarget{
                            Id = 'All Employees'
                            TargetType = 'group'
                        }
                    );
                    Id                   = "Sms";
                    IncludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicySmsIncludeTarget{
                            Id = 'all_users'
                            TargetType = 'group'
                        }
                    );
                    State                = "enabled"; # Updated Property
                }
                AADAuthenticationMethodPolicySoftware 'AADAuthenticationMethodPolicySoftware-SoftwareOath'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure               = "Present";
                    ExcludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicySoftwareExcludeTarget{
                            Id = 'Executives'
                            TargetType = 'group'
                        }
                        MSFT_AADAuthenticationMethodPolicySoftwareExcludeTarget{
                            Id = 'Paralegals'
                            TargetType = 'group'
                        }
                    );
                    Id                   = "SoftwareOath";
                    IncludeTargets       = @(
                        MSFT_AADAuthenticationMethodPolicySoftwareIncludeTarget{
                            Id = 'Legal Team'
                            TargetType = 'group'
                        }
                    );
                    State                = "enabled"; # Updated Property
                }
                AADAuthenticationMethodPolicyTemporary 'AADAuthenticationMethodPolicyTemporary-TemporaryAccessPass'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DefaultLength            = 9; # Updated Property
                    DefaultLifetimeInMinutes = 60;
                    Ensure                   = "Present";
                    ExcludeTargets           = @(
                        MSFT_AADAuthenticationMethodPolicyTemporaryExcludeTarget{
                            Id = 'All Company'
                            TargetType = 'group'
                        }
                    );
                    Id                       = "TemporaryAccessPass";
                    IncludeTargets           = @(
                        MSFT_AADAuthenticationMethodPolicyTemporaryIncludeTarget{
                            Id = 'Executives'
                            TargetType = 'group'
                        }
                    );
                    IsUsableOnce             = $False;
                    MaximumLifetimeInMinutes = 480;
                    MinimumLifetimeInMinutes = 60;
                    State                    = "enabled";
                }
                AADAuthenticationMethodPolicyX509 'AADAuthenticationMethodPolicyX509-X509Certificate'
                {
                    AuthenticationModeConfiguration = MSFT_MicrosoftGraphx509CertificateAuthenticationModeConfiguration{
                        X509CertificateAuthenticationDefaultMode = 'x509CertificateSingleFactor'
                        Rules = @()
                    };
                    CertificateUserBindings         = @(
                        MSFT_MicrosoftGraphx509CertificateUserBinding{
                            Priority = 1
                            UserProperty = 'userPrincipalName'
                            X509CertificateField = 'PrincipalName'
                        }
                        MSFT_MicrosoftGraphx509CertificateUserBinding{
                            Priority = 2
                            UserProperty = 'userPrincipalName'
                            X509CertificateField = 'RFC822Name'
                        }
                        MSFT_MicrosoftGraphx509CertificateUserBinding{
                            Priority = 3
                            UserProperty = 'certificateUserIds'
                            X509CertificateField = 'SubjectKeyIdentifier'
                        }
                    );
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                          = "Present";
                    ExcludeTargets                  = @(
                        MSFT_AADAuthenticationMethodPolicyX509ExcludeTarget{
                            Id = 'DSCGroup'
                            TargetType = 'group'
                        }
                    );
                    Id                              = "X509Certificate";
                    IncludeTargets                  = @(
                        MSFT_AADAuthenticationMethodPolicyX509IncludeTarget{
                            Id = 'Finance Team'
                            TargetType = 'group'
                        }
                    );
                    State                           = "enabled";
                }
                AADAuthenticationRequirement 'AADAuthenticationRequirement-TestMailbox109@xtasdftestorg.onmicrosoft.com'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    PerUserMfaState       = "disabled";
                    UserPrincipalName     = "TestMailbox109@$OrganizationName";
                }
                AADAuthenticationStrengthPolicy 'AADAuthenticationStrengthPolicy-Example'
                {
                    AllowedCombinations  = @("windowsHelloForBusiness","fido2","deviceBasedPush"); # Updated Property
                    Description          = "This is an example";
                    DisplayName          = "Example";
                    Ensure               = "Present";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADAuthorizationPolicy 'AADAuthPol'
                {
                    IsSingleInstance                                  = 'Yes'
                    DisplayName                                       = 'Authorization Policy'
                    Description                                       = 'Used to manage authorization related settings across the company.'
                    AllowEmailVerifiedUsersToJoinOrganization         = $true
                    AllowInvitesFrom                                  = 'everyone'
                    AllowedToSignUpEmailBasedSubscriptions            = $true
                    AllowedToUseSspr                                  = $true
                    BlockMsolPowerShell                               = $false
                    DefaultUserRoleAllowedToCreateApps                = $true
                    DefaultUserRoleAllowedToCreateSecurityGroups      = $true
                    DefaultUserRoleAllowedToReadOtherUsers            = $true
                    GuestUserRole                                     = 'Guest'
                    PermissionGrantPolicyIdsAssignedToDefaultUserRole = @()
                    Ensure                                            = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADClaimsMappingPolicy 'AADClaimsMappingPolicy-Test1234'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Definition            = @(
                        MSFT_AADClaimsMappingPolicyDefinition{
                            ClaimsMappingPolicy = MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy{
                                ClaimsSchema = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    }
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname'
                                        Source = 'user'
                                        Id = 'givenname'
                                    }
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
                                        Source = 'user'
                                        Id = 'displayname'
                                    }
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname'
                                        Source = 'user'
                                        Id = 'surname'
                                    }
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                        SamlClaimType = 'username'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    }
                                )
                                ClaimsTransformation = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation{
                                        OutputClaims = @(
                                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims{
                                                ClaimTypeReferenceId = 'TOS'
                                                TransformationClaimType = 'createdClaim'
                                            }
                                        )
                                        Id = 'CreateTermsOfService'
                                        InputParameters = @(
                                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter{
                                                DataType = 'string'
                                                Id = 'value'
                                                Value = 'sandbox'
                                            }
                                        )
                                        TransformationMethod = 'CreateStringClaim'
                                    }
                                )
                                IncludeBasicClaimSet = $True
                                Version = 1
                            }
        
                        }
                    );
                    DisplayName           = "Test1234";
                    Ensure                = "Present";
                    Id                    = "fd0dc3f3-cfdf-4d56-bb03-e18161a5ac93";
                    IsOrganizationDefault = $False;
                }
                AADConditionalAccessPolicy 'ConditionalAccessPolicy'
                {
                    BuiltInControls                          = @("mfa");
                    ClientAppTypes                           = @("all");
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DeviceFilterMode                         = "exclude";
                    DeviceFilterRule                         = "device.trustType -eq `"AzureAD`" -or device.trustType -eq `"ServerAD`" -or device.trustType -eq `"Workplace`"";
                    DisplayName                              = "Example CAP";
                    Ensure                                   = "Present";
                    ExcludeUsers                             = @("admin@$Domain");
                    GrantControlOperator                     = "OR";
                    IncludeApplications                      = @("All");
                    IncludeRoles                             = @("Attack Payload Author");
                    SignInFrequencyInterval                  = "timeBased";
                    SignInFrequencyIsEnabled                 = $True;
                    SignInFrequencyType                      = "hours";
                    SignInFrequencyValue                     = 2; # Updated Porperty
                    State                                    = "disabled";
                }
                AADConnectorGroupApplicationProxy 'AADConnectorGroupApplicationProxy-testgroup'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                = "Present";
                    Id                    = "4984dcf7-d9e9-4663-90b4-5db09f92a669";
                    Name                  = "testgroup-new";
                    Region                = "nam";
                }
                AADCrossTenantAccessPolicy 'AADCrossTenantAccessPolicy'
                {
                    AllowedCloudEndpoints = @("microsoftonline.us");
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DisplayName           = "MyXTAPPolicy";
                    Ensure                = "Present";
                    IsSingleInstance      = "Yes";
                }
                AADCrossTenantAccessPolicyConfigurationDefault 'AADCrossTenantAccessPolicyConfigurationDefault'
                {
                    B2BCollaborationInbound  = MSFT_AADCrossTenantAccessPolicyB2BSetting {
                        Applications = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllApplications'
                                    TargetType = 'application'
                                }
                            )
                        }
                        UsersAndGroups = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllUsers'
                                    TargetType = 'user'
                                }
                            )
                        }
                    }
                    B2BCollaborationOutbound = MSFT_AADCrossTenantAccessPolicyB2BSetting {
                        Applications = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllApplications'
                                    TargetType = 'application'
                                }
                            )
                        }
                        UsersAndGroups = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllUsers'
                                    TargetType = 'user'
                                }
                            )
                        }
                    }
                    B2BDirectConnectInbound  = MSFT_AADCrossTenantAccessPolicyB2BSetting {
                        Applications = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'blocked'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllApplications'
                                    TargetType = 'application'
                                }
                            )
                        }
                        UsersAndGroups = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'blocked'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllUsers'
                                    TargetType = 'user'
                                }
                            )
                        }
                    }
                    B2BDirectConnectOutbound = MSFT_AADCrossTenantAccessPolicyB2BSetting {
                        Applications = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'blocked'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllApplications'
                                    TargetType = 'application'
                                }
                            )
                        }
                        UsersAndGroups = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'blocked'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllUsers'
                                    TargetType = 'user'
                                }
                            )
                        }
                    }
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                   = "Present";
                    InboundTrust             = MSFT_AADCrossTenantAccessPolicyInboundTrust {
                        IsCompliantDeviceAccepted           = $False
                        IsHybridAzureADJoinedDeviceAccepted = $False
                        IsMfaAccepted                       = $False
                    }
                    IsSingleInstance                        = "Yes";
                }
                AADCrossTenantAccessPolicyConfigurationPartner 'AADCrossTenantAccessPolicyConfigurationPartner'
                {
                    PartnerTenantId              = "e7a80bcf-696e-40ca-8775-a7f85fbb3ebc"; # O365DSC.onmicrosoft.com
                    AutomaticUserConsentSettings = MSFT_AADCrossTenantAccessPolicyAutomaticUserConsentSettings {
                        InboundAllowed           = $False # Updated Property
                        OutboundAllowed          = $True
                    };
                    B2BCollaborationOutbound     = MSFT_AADCrossTenantAccessPolicyB2BSetting {
                        Applications = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = 'AllApplications'
                                    TargetType = 'application'
                                }
                            )
                        }
                        UsersAndGroups = MSFT_AADCrossTenantAccessPolicyTargetConfiguration{
                            AccessType = 'allowed'
                            Targets    = @(
                                MSFT_AADCrossTenantAccessPolicyTarget{
                                    Target     = '68bafe64-f86b-4c4e-b33b-9d3eaa11544b' # Office 365
                                    TargetType = 'user'
                                }
                            )
                        }
                    };
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                       = "Present";
                }
                AADCustomAuthenticationExtension 'AADCustomAuthenticationExtension1'
                {
                    AuthenticationConfigurationResourceId  = "api://microsoft365dsc.com/11105949-846e-42a1-a873-f12db8345013"
                    AuthenticationConfigurationType        = "#microsoft.graph.azureAdTokenAuthentication"
                    ClaimsForTokenConfiguration            = @(
                        MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration{
                            ClaimIdInApiResponse = 'MyClaim'
                        }
                        MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration{
                            ClaimIdInApiResponse = 'My2ndClaim'
                        }
                    )
                    ClientConfigurationMaximumRetries      = 1
                    ClientConfigurationTimeoutMilliseconds = 2000
                    CustomAuthenticationExtensionType      = "#microsoft.graph.onTokenIssuanceStartCustomExtension"
                    Description                            = "DSC Testing 1"
                    DisplayName                            = "DSCTestExtension"
                    EndPointConfiguration                  = MSFT_AADCustomAuthenticationExtensionEndPointConfiguration{
                        EndpointType = '#microsoft.graph.httpRequestEndpoint'
                        TargetUrl = 'https://Microsoft365DSC.com'
                    }
                    Ensure                                 = "Present";
                    Id                                     = "11105949-846e-42a1-a873-f12db8345013"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADCustomSecurityAttributeDefinition 'AADCustomSecurityAttributeDefinition-ShoeSize'
                {
                    ApplicationId           = $ApplicationId;
                    AttributeSet            = "TestAttributeSet";
                    CertificateThumbprint   = $CertificateThumbprint;
                    Ensure                  = "Present";
                    IsCollection            = $False;
                    IsSearchable            = $True;
                    Name                    = "ShoeSize";
                    Status                  = "Available";
                    TenantId                = $TenantId;
                    Type                    = "String";
                    UsePreDefinedValuesOnly = $False;
                    Description             = "What size of shoe is the person wearing? Drifted" # Drift
                }
                AADDeviceRegistrationPolicy 'MyDeviceRegistrationPolicy'
                {
                    ApplicationId                           = $ApplicationId;
                    AzureADAllowedToJoin                    = "Selected";
                    AzureADAllowedToJoinGroups              = @();
                    AzureADAllowedToJoinUsers               = @("AlexW@M365x73318397.OnMicrosoft.com");
                    AzureAdJoinLocalAdminsRegisteringGroups = @();
                    AzureAdJoinLocalAdminsRegisteringMode   = "Selected";
                    AzureAdJoinLocalAdminsRegisteringUsers  = @("AllanD@M365x73318397.OnMicrosoft.com");
                    CertificateThumbprint                   = $CertificateThumbprint;
                    IsSingleInstance                        = "Yes";
                    LocalAdminPasswordIsEnabled             = $False;
                    LocalAdminsEnableGlobalAdmins           = $True;
                    MultiFactorAuthConfiguration            = $False;
                    TenantId                                = $TenantId;
                    UserDeviceQuota                         = 50;
                }
                AADDomain 'AADDomain-Contoso'
                {
                    ApplicationId                    = $ApplicationId;
                    AuthenticationType               = "Managed";
                    CertificateThumbprint            = $CertificateThumbprint;
                    Ensure                           = "Present";
                    Id                               = "contoso.com";
                    IsAdminManaged                   = $True;
                    IsDefault                        = $True;
                    IsRoot                           = $True;
                    IsVerified                       = $False; #Drift
                    PasswordNotificationWindowInDays = 14;
                    PasswordValidityPeriodInDays     = 2147483647;
                    TenantId                         = $TenantId;
                }
                AADEnrichedAuditLogs 'AADEnrichedAuditLogs'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Exchange              = "disabled";
                    IsSingleInstance      = "Yes";
                    SharePoint            = "enabled";
                    Teams                 = "disabled";
                    TenantId              = $TenantId;
                }
                AADEntitlementManagementAccessPackage 'myAccessPackage'
                {
                    AccessPackagesIncompatibleWith = @();
                    CatalogId                      = "General";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description                    = "Integration Tests";
                    DisplayName                    = "Integration Package";
                    Ensure                         = "Present";
                    IsHidden                       = $True; # Updated Property
                    IsRoleScopesVisible            = $True;
                }
                AADEntitlementManagementAccessPackageAssignmentPolicy 'myAssignments'
                {
                    AccessPackageId         = "Integration Package";
                    AccessReviewSettings    = MSFT_MicrosoftGraphassignmentreviewsettings{
                        IsEnabled = $True
                        StartDateTime = '12/17/2022 23:59:59'
                        IsAccessRecommendationEnabled = $True
                        AccessReviewTimeoutBehavior = 'keepAccess'
                        IsApprovalJustificationRequired = $True
                        ReviewerType = 'Self'
                        RecurrenceType = 'quarterly'
                        Reviewers = @()
                        DurationInDays = 25
                    };
                    CanExtend               = $False;
                    Description             = "";
                    DisplayName             = "External tenant";
                    DurationInDays          = 180; # Updated Property
                    RequestApprovalSettings = MSFT_MicrosoftGraphapprovalsettings{
                        ApprovalMode = 'NoApproval'
                        IsRequestorJustificationRequired = $False
                        IsApprovalRequired = $False
                        IsApprovalRequiredForExtension = $False
                    };
                    Ensure                     = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementAccessPackageCatalog 'myAccessPackageCatalog'
                {
                    DisplayName         = 'My Catalog'
                    CatalogStatus       = 'Published'
                    CatalogType         = 'UserManaged'
                    Description         = 'Built-in catalog.'
                    IsExternallyVisible = $False # Updated Property
                    Managedidentity     = $False
                    Ensure              = 'Present'
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementAccessPackageCatalogResource 'myAccessPackageCatalogResource'
                {
                    ApplicationId         = $ApplicationId;
                    CatalogId             = "My Catalog";
                    CertificateThumbprint = $CertificateThumbprint;
                    DisplayName           = "DSCGroup";
                    OriginSystem          = "AADGroup";
                    OriginId              = '849b3661-61a8-44a8-92e7-fcc91d296235'
                    Ensure                = "Present";
                    IsPendingOnboarding   = $False;
                    TenantId              = $TenantId;
                }
                AADEntitlementManagementConnectedOrganization 'MyConnectedOrganization'
                {
                    Description           = "This is the tenant partner - Updated"; # Updated Property
                    DisplayName           = "Test Tenant - DSC";
                    ExternalSponsors      = @("AdeleV@$TenantId");
                    IdentitySources       = @(
                        MSFT_AADEntitlementManagementConnectedOrganizationIdentitySource{
                            ExternalTenantId = "e7a80bcf-696e-40ca-8775-a7f85fbb3ebc"
                            DisplayName = 'o365dsc'
                            odataType = '#microsoft.graph.azureActiveDirectoryTenant'
                        }
                    );
                    InternalSponsors      = @("AdeleV@$TenantId");
                    State                 = "configured";
                    Ensure                = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADEntitlementManagementSettings 'AADEntitlementManagementSettings'
                {
                    ApplicationId                            = $ApplicationId;
                    CertificateThumbprint                    = $CertificateThumbprint;
                    DaysUntilExternalUserDeletedAfterBlocked = 30;
                    ExternalUserLifecycleAction              = "blockSignInAndDelete";
                    IsSingleInstance                         = "Yes";
                    TenantId                                 = $TenantId;
                }
                AADExternalIdentityPolicy 'AADExternalIdentityPolicy'
                {
                    AllowDeletedIdentitiesDataRemoval = $False;
                    AllowExternalIdentitiesToLeave    = $True;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    IsSingleInstance                  = "Yes";
                }
                AADFeatureRolloutPolicy 'AADFeatureRolloutPolicy-CertificateBasedAuthentication rollout policy'
                {
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                    Description             = "CertificateBasedAuthentication rollout policy";
                    DisplayName             = "CertificateBasedAuthentication rollout policy";
                    Ensure                  = "Present";
                    IsAppliedToOrganization = $False;
                    IsEnabled               = $False;
                }
                AADFilteringPolicy 'AADFilteringPolicy-MyPolicy'
                {
                    Action                = "allow"; #drift
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Description           = "This is a demo policy";
                    Ensure                = "Present";
                    Name                  = "MyPolicy";
                    TenantId              = $TenantId;
                }
                AADFilteringPolicyRule 'AADFilteringPolicyRule-FQDN'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Destinations          = @(
                        MSFT_AADFilteringPolicyRuleDestination{
                            value = 'contoso.com' #Drift
                        }
                    );
                    Ensure                = "Present";
                    Name                  = "MyFQDN";
                    Policy                = "AMyPolicy";
                    RuleType              = "fqdn";
                    TenantId              = $TenantId;
                }
                AADFilteringProfile 'AADFilteringProfile-My Profile'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    Description           = "Description of profile";
                    Ensure                = "Present";
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
                    Priority              = 130; #Drift
                    State                 = "enabled";
                    TenantId              = $TenantId;
                }
                AADGroup 'MyGroups'
                {
                    DisplayName      = "DSCGroup"
                    Description      = "Microsoft DSC Group Updated" # Updated Property
                    SecurityEnabled  = $True
                    MailEnabled      = $True
                    GroupTypes       = @("Unified")
                    MailNickname     = "M365DSC"
                    Members          = @("AdeleV@$TenantId")
                    GroupAsMembers   = @("Group1")
                    Visibility       = "Private"
                    Owners           = @("admin@$TenantId", "AdeleV@$TenantId")
                    AssignedLicenses = @(
                        MSFT_AADGroupLicense {
                            SkuId          = 'AAD_PREMIUM_P2'
                        }
                    )
                    Ensure           = "Present"
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
                    Ensure                      = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADGroupsNamingPolicy 'GroupsNamingPolicy'
                {
                    IsSingleInstance              = "Yes"
                    CustomBlockedWordsList        = @("CEO", "President")
                    PrefixSuffixNamingRequirement = "[Title]Test[Company][GroupName][Office]Redmond"
                    Ensure                        = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADGroupsSettings 'GeneralGroupsSettings'
                {
                    IsSingleInstance              = "Yes"
                    AllowGuestsToAccessGroups     = $True
                    AllowGuestsToBeGroupOwner     = $True
                    AllowToAddGuests              = $True
                    EnableGroupCreation           = $True
                    GroupCreationAllowedGroupName = "All Company"
                    GuestUsageGuidelinesUrl       = "https://contoso.com/guestusage"
                    UsageGuidelinesUrl            = "https://contoso.com/usage"
                    Ensure                        = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADHomeRealmDiscoveryPolicy 'AADHomeRealmDiscoveryPolicy-displayName-value'
                {
                    Definition            = @(
                        MSFT_AADHomeRealDiscoveryPolicyDefinition {
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $True # updating here
                            AlternateIdLogin = MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin {
                                Enabled = $True
                            }
                        }
                    );
                    DisplayName           = "displayName-value";
                    Ensure                = "Present";
                    IsOrganizationDefault = $False;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
                {
                    DisplayName           = "NewTestConnector";
                    Id                    = "RestApi_NewTestConnector";
                    Username              = "anexas 1"; #drift
                    Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
                    TargetUrl             = "https://graph.microsoft.com";
                    Ensure                = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADIdentityB2XUserFlow 'AADIdentityB2XUserFlow-B2X_1_TestFlow'
                {
                    ApplicationId             = $ApplicationId
                    TenantId                  = $TenantId
                    CertificateThumbprint     = $CertificateThumbprint
                    ApiConnectorConfiguration = MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration
                    {
                        postAttributeCollectionConnectorName = 'RestApi_f6e8e73d-6b17-433e-948f-f578f12bd57c'
                        postFederationSignupConnectorName = 'RestApi_beeb7152-673c-48b3-b143-9975949a93ca'
                    };
                    Credential                = $Credscredential;
                    Ensure                    = "Present";
                    Id                        = "B2X_1_TestFlow";
                    IdentityProviders         = @("MSASignup-OAUTH","EmailOtpSignup-OAUTH");
                    UserAttributeAssignments  = @(
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                        {
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'Email Address'
                            Id = 'emailReadonly'
        
                        }
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                        {
                            UserInputType = 'dropdownSingleSelect'
                            IsOptional = $True
                            DisplayName = 'Random'
                            Id = 'city'
                            UserAttributeValues = @(
                                MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                                {
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                                MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                                {
                                    IsDefault = $True
                                    Name = 'X'
                                    Value = '1'
                                }
                            )
                        }
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignment{
                            UserInputType = 'textBox'
                            IsOptional = $False
                            DisplayName = 'Piyush1'
                            Id = 'extension_91d51274096941f786b07b9d723d93f4_Piyush1'
        
                        }
                    );
                }
                AADIdentityGovernanceLifecycleWorkflow 'AADIdentityGovernanceLifecycleWorkflow-Onboard pre-hire employee updated version'
                {
                    Category             = "joiner";
                    #updated description
                    Description          = "Updated description the onboard of prehire employee";
                    DisplayName          = "Onboard pre-hire employee updated version";
                    Ensure               = "Present";
                    ExecutionConditions  = MSFT_IdentityGovernanceWorkflowExecutionConditions {
                        ScopeValue = MSFT_IdentityGovernanceScope {
                            #updated rule
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
                            #updated description
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
                    CertificateThumbprint = $CertificateThumbprint;
                    CallbackConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    };
                    ClientConfiguration   = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    };
                    Description           = "My Drifted Description"; # Drift
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    };
                    Ensure                = "Present";
                    TenantId              = $TenantId;
                }
                AADIdentityGovernanceProgram 'AADIdentityGovernanceProgram-Example'
                {
                    ApplicationId           = $ApplicationId
                    TenantId                = $TenantId
                    CertificateThumbprint   = $CertificateThumbprint
                    Description             = "Example Program Description Updated";
                    DisplayName             = "Example";
                    Ensure                  = "Present";
                }
                AADIdentityProtectionPolicySettings 'AADIdentityProtectionPolicySettings'
                {
                    IsUserRiskClearedOnPasswordReset = $false; #drift
                    IsSingleInstance              = "Yes";
                    ApplicationId                 = $ApplicationId
                    TenantId                      = $TenantId
                    CertificateThumbprint         = $CertificateThumbprint
                }
                AADLifecycleWorkflowSettings 'AADLifecycleWorkflowSettings'
                {
                    ApplicationId                   = $ApplicationId;
                    CertificateThumbprint           = $CertificateThumbprint;
                    IsSingleInstance                = "Yes";
                    SenderDomain                    = "microsoft.com";
                    TenantId                        = $TenantId;
                    UseCompanyBranding              = $True;
                    WorkflowScheduleIntervalInHours = 10;
                }
                AADNamedLocationPolicy 'CompanyNetwork'
                {
                    DisplayName = "Company Network"
                    IpRanges    = @("2.1.1.1/32") # Updated Property
                    IsTrusted   = $False
                    OdataType   = "#microsoft.graph.ipNamedLocation"
                    Ensure      = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADNetworkAccessForwardingPolicy 'AADNetworkAccessForwardingPolicy-Custom Bypass'
                {
                    Name                  = "Custom Bypass";
                    PolicyRules           = @(
                        MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                            Name           = 'Custom policy internet rule'
                            ActionValue    = 'bypass'
                            RuleType       = 'fqdn'
                            Protocol       = 'tcp'
                            Ports          = @(80, 443)
                            Destinations   = @('www.microsoft.com')
                        }
        
                        MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                            Name           = 'Custom policy internet rule'
                            ActionValue    = 'bypass'
                            RuleType       = 'ipAddress'
                            Protocol       = 'tcp'
                            Ports          = @(80, 443)
                            Destinations   = @('192.168.1.1')
                        }
        
                        MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                            Name           = 'Custom policy internet rule'
                            ActionValue    = 'bypass'
                            RuleType       = 'ipSubnet'
                            Protocol       = 'tcp'
                            Ports          = @(80, 443)
                            Destinations   = @('192.164.0.0/24')
                        }
                    );
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADNetworkAccessSettingConditionalAccess 'AADNetworkAccessSettingConditionalAccess'
                {
                    ApplicationId         = $ApplicationId;
                    CertificateThumbprint = $CertificateThumbprint;
                    IsSingleInstance      = "Yes";
                    SignalingStatus       = "disabled";
                    TenantId              = $TenantId;
                }
                AADNetworkAccessSettingCrossTenantAccess 'AADNetworkAccessSettingCrossTenantAccess'
                {
                    ApplicationId              = $ApplicationId;
                    CertificateThumbprint      = $CertificateThumbprint;
                    IsSingleInstance           = "Yes";
                    NetworkPacketTaggingStatus = "enabled";
                    TenantId                   = $TenantId;
                }
                AADRemoteNetwork 'AADRemoteNetwork-Test Remote Network'
                {
                    Ensure                = "Present";
                    ForwardingProfiles    = @(); #creating drift here
                    Id                    = "c60c41bb-e512-48e3-8134-c312439a5343";
                    Name                  = "Test Remote Network";
                    Region                = "australiaSouthEast";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DeviceLinks           = @(
                        MSFT_AADRemoteNetworkDeviceLink {
                            Name                    = 'Test Link Random' # creating drift here
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
                    DisplayName                   = "DSCRole1"
                    Description                   = "DSC created role definition"
                    ResourceScopes                = "/"
                    IsEnabled                     = $false # Updated Property
                    RolePermissions               = "microsoft.directory/applicationPolicies/allProperties/read","microsoft.directory/applicationPolicies/allProperties/update","microsoft.directory/applicationPolicies/basic/update"
                    Version                       = "1.0"
                    Ensure                        = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADRoleEligibilityScheduleRequest 'MyRequest'
                {
                    Action               = "AdminUpdate";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    DirectoryScopeId     = "/";
                    Ensure               = "Present";
                    IsValidationOnly     = $False;
                    Principal            = "AdeleV@$TenantId";
                    RoleDefinition       = "Teams Communications Administrator";
                    ScheduleInfo         = MSFT_AADRoleEligibilityScheduleRequestSchedule {
                        startDateTime             = '2023-09-01T02:45:44Z' # Updated Property
                        expiration                = MSFT_AADRoleEligibilityScheduleRequestScheduleExpiration
                            {
                                endDateTime = '2025-10-31T02:40:09Z'
                                type        = 'afterDateTime'
                            }
                    };
                }
                AADRoleManagementPolicyRule 'AADRoleManagementPolicyRule-Expiration_Admin_Eligibility'
                {
                    expirationRule       = MSFT_AADRoleManagementPolicyExpirationRule{
                        isExpirationRequired = $False
                        maximumDuration = 'P180D'
                    };
                    id                   = "Expiration_Admin_Eligibility";
                    roleDisplayName      = "Global Administrator";
                    ruleType             = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule";
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADRoleSetting '28b253d8-cde5-471f-a331-fe7320023cdd'
                {
                    ActivateApprover                                          = @();
                    ActivationMaxDuration                                     = "PT8H";
                    ActivationReqJustification                                = $False; # Updated Property
                    ActivationReqMFA                                          = $False;
                    ActivationReqTicket                                       = $False;
                    ActiveAlertNotificationAdditionalRecipient                = @();
                    ActiveAlertNotificationDefaultRecipient                   = $True;
                    ActiveAlertNotificationOnlyCritical                       = $False;
                    ActiveApproveNotificationAdditionalRecipient              = @();
                    ActiveApproveNotificationDefaultRecipient                 = $True;
                    ActiveApproveNotificationOnlyCritical                     = $False;
                    ActiveAssigneeNotificationAdditionalRecipient             = @();
                    ActiveAssigneeNotificationDefaultRecipient                = $True;
                    ActiveAssigneeNotificationOnlyCritical                    = $False;
                    ApprovaltoActivate                                        = $False;
                    AssignmentReqJustification                                = $True;
                    AssignmentReqMFA                                          = $False;
                    Displayname                                               = "Application Administrator";
                    ElegibilityAssignmentReqJustification                     = $False;
                    ElegibilityAssignmentReqMFA                               = $False;
                    EligibleAlertNotificationAdditionalRecipient              = @();
                    EligibleAlertNotificationDefaultRecipient                 = $True;
                    EligibleAlertNotificationOnlyCritical                     = $False;
                    EligibleApproveNotificationAdditionalRecipient            = @();
                    EligibleApproveNotificationDefaultRecipient               = $True;
                    EligibleApproveNotificationOnlyCritical                   = $False;
                    EligibleAssigneeNotificationAdditionalRecipient           = @();
                    EligibleAssigneeNotificationDefaultRecipient              = $True;
                    EligibleAssigneeNotificationOnlyCritical                  = $False;
                    EligibleAssignmentAlertNotificationAdditionalRecipient    = @();
                    EligibleAssignmentAlertNotificationDefaultRecipient       = $True;
                    EligibleAssignmentAlertNotificationOnlyCritical           = $False;
                    EligibleAssignmentAssigneeNotificationAdditionalRecipient = @();
                    EligibleAssignmentAssigneeNotificationDefaultRecipient    = $True;
                    EligibleAssignmentAssigneeNotificationOnlyCritical        = $False;
                    ExpireActiveAssignment                                    = "P180D";
                    ExpireEligibleAssignment                                  = "P365D";
                    PermanentActiveAssignmentisExpirationRequired             = $False;
                    PermanentEligibleAssignmentisExpirationRequired           = $False;
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Ensure                                                    = 'Present'
                }
                AADSecurityDefaults 'Defaults'
                {
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    Description          = "Security defaults is a set of basic identity security mechanisms recommended by Microsoft. When enabled, these recommendations will be automatically enforced in your organization. Administrators and users will be better protected from common identity related attacks.";
                    DisplayName          = "Security Defaults";
                    IsEnabled            = $False;
                    IsSingleInstance     = "Yes";
                }
                AADServicePrincipal 'AADServicePrincipal'
                {
                    AppId                         = 'AppDisplayName'
                    DisplayName                   = "AppDisplayName"
                    AlternativeNames              = "AlternativeName1","AlternativeName3" # Updated Property
                    AccountEnabled                = $true
                    AppRoleAssignmentRequired     = $false
                    Homepage                      = "https://$TenantId"
                    LogoutUrl                     = "https://$TenantId/logout"
                    ReplyURLs                     = "https://$TenantId"
                    ServicePrincipalType          = "Application"
                    Tags                          = "{WindowsAzureActiveDirectoryIntegratedApp}"
                    Ensure                        = "Present"
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
                    Ensure               = "Present";
                    IdentityProviderType = "Google";
                }
                AADTenantDetails 'ConfigureTenantDetails'
                {
                    IsSingleInstance                     = 'Yes'
                    TechnicalNotificationMails           = "example@contoso.com"
                    MarketingNotificationEmails          = "example@contoso.com"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADTokenLifetimePolicy 'SetTokenLifetimePolicy'
                {
                    DisplayName           = "PolicyDisplayName"
                    Definition            = @("{`"TokenLifetimePolicy`":{`"Version`":1,`"AccessTokenLifetime`":`"02:00:00`"}}");
                    IsOrganizationDefault = $true # Updated
                    Ensure                = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADUser 'ConfigureJohnSMith'
                {
                    UserPrincipalName  = "John.Smith@$TenantId"
                    FirstName          = "John"
                    LastName           = "Smith"
                    DisplayName        = "John J. Smith"
                    City               = "Ottawa" # Updated
                    Country            = "Canada"
                    Office             = "Ottawa - Queen"
                    UsageLocation      = "US"
                    Ensure             = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADUserFlowAttribute 'SaiTest'
                {
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Description        = "sai test description"
                    DataType           = "string"
                    Ensure             = "Present"
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                AADVerifiedIdAuthority 'AADVerifiedIdAuthority-Contoso'
                {
                    DidMethod            = "web";
                    Ensure               = "Present";
                    KeyVaultMetadata     = MSFT_AADVerifiedIdAuthorityKeyVaultMetadata{
                        SubscriptionId = '2ff65b89-ab22-4489-b84d-e60d1dc30a62'
                        ResourceName = 'xtakeyvault'
                        ResourceUrl = 'https://xtakeyvault.vault.azure.net/'
                        ResourceGroup = 'TBD'
                    };
                    LinkedDomainUrl      = "https://nik-charlebois.com/";
                    Name                 = "Contoso 2"; # drift
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
                                title = 'Do you want to get your sample Verified Credential?' #drift
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
                    Ensure               = "Present";
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
