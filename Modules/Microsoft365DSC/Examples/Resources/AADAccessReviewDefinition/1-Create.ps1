<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
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

        AADAccessReviewDefinition "AADAccessReviewDefinition-Example"
        {
            DescriptionForAdmins    = "description for admins";
            DescriptionForReviewers = "description for reviewers";
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
    }
}
