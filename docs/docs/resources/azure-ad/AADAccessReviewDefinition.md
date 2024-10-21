# AADAccessReviewDefinition

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
| **DisplayName** | Required | String | Name of the access review series. Supports $select and $orderby. Required on create. | |
| **DescriptionForAdmins** | Write | String | Description provided by review creators to provide more context of the review to admins. Supports $select. | |
| **DescriptionForReviewers** | Write | String | Description provided  by review creators to provide more context of the review to reviewers. Reviewers see this description in the email sent to them requesting their review. Email notifications support up to 256 characters. Supports $select. | |
| **ScopeValue** | Write | MSFT_MicrosoftGraphaccessReviewScope | Defines the entities whose access is reviewed. For supported scopes, see accessReviewScope. Required on create. Supports $select and $filter (contains only). For examples of options for configuring scope, see Configure the scope of your access review definition using the Microsoft Graph API. | |
| **SettingsValue** | Write | MSFT_MicrosoftGraphaccessReviewScheduleSettings | The settings for an access review series, see type definition below. Supports $select. Required on create. | |
| **StageSettings** | Write | MSFT_MicrosoftGraphaccessReviewStageSettings[] | Required only for a multi-stage access review to define the stages and their settings. You can break down each review instance into up to three sequential stages, where each stage can have a different set of reviewers, fallback reviewers, and settings. Stages are created sequentially based on the dependsOn property. Optional.  When this property is defined, its settings are used instead of the corresponding settings in the accessReviewScheduleDefinition object and its settings, reviewers, and fallbackReviewers properties. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_MicrosoftGraphAccessReviewScope

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Query** | Write | String | The query representing what will be reviewed in an access review. | |
| **QueryRoot** | Write | String | In the scenario where reviewers need to be specified dynamically, this property is used to indicate the relative source of the query. This property is only required if a relative query is specified. For example, ./manager. | |
| **QueryType** | Write | String | Indicates the type of query. Types include MicrosoftGraph and ARM. | |
| **PrincipalScopes** | Write | MSFT_MicrosoftGraphAccessReviewScope[] | Defines the scopes of the principals for which access to resources are reviewed in the access review. | |
| **ResourceScopes** | Write | MSFT_MicrosoftGraphAccessReviewScope[] | Defines the scopes of the resources for which access is reviewed. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.accessReviewQueryScope`, `#microsoft.graph.accessReviewReviewerScope`, `#microsoft.graph.principalResourceMembershipsScope` |

### MSFT_MicrosoftGraphAccessReviewScheduleSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ApplyActions** | Write | MSFT_MicrosoftGraphAccessReviewApplyAction[] | Optional field. Describes the  actions to take once a review is complete. There are two types that are currently supported: removeAccessApplyAction (default) and disableAndDeleteUserApplyAction. Field only needs to be specified in the case of disableAndDeleteUserApplyAction. | |
| **AutoApplyDecisionsEnabled** | Write | Boolean | Indicates whether decisions are automatically applied. When set to false, an admin must apply the decisions manually once the reviewer completes the access review. When set to true, decisions are applied automatically after the access review instance duration ends, whether or not the reviewers have responded. Default value is false.  CAUTION: If both autoApplyDecisionsEnabled and defaultDecisionEnabled are true, all access for the principals to the resource risks being revoked if the reviewers fail to respond. | |
| **DecisionHistoriesForReviewersEnabled** | Write | Boolean | Indicates whether decisions on previous access review stages are available for reviewers on an accessReviewInstance with multiple subsequent stages. If not provided, the default is disabled (false). | |
| **DefaultDecision** | Write | String | Decision chosen if defaultDecisionEnabled is enabled. Can be one of Approve, Deny, or Recommendation. | |
| **DefaultDecisionEnabled** | Write | Boolean | Indicates whether the default decision is enabled or disabled when reviewers do not respond. Default value is false.  CAUTION: If both autoApplyDecisionsEnabled and defaultDecisionEnabled are true, all access for the principals to the resource risks being revoked if the reviewers fail to respond. | |
| **InstanceDurationInDays** | Write | UInt32 | Duration of each recurrence of review (accessReviewInstance) in number of days. NOTE: If the stageSettings of the accessReviewScheduleDefinition object is defined, its durationInDays setting will be used instead of the value of this property. | |
| **JustificationRequiredOnApproval** | Write | Boolean | Indicates whether reviewers are required to provide justification with their decision. Default value is false. | |
| **MailNotificationsEnabled** | Write | Boolean | Indicates whether emails are enabled or disabled. Default value is false. | |
| **RecommendationInsightSettings** | Write | MSFT_MicrosoftGraphAccessReviewRecommendationInsightSetting[] | Optional. Describes the types of insights that aid reviewers to make access review decisions. NOTE: If the stageSettings of the accessReviewScheduleDefinition object is defined, its recommendationInsightSettings setting will be used instead of the value of this property. | |
| **RecommendationLookBackDuration** | Write | String | Optional field. Indicates the period of inactivity (with respect to the start date of the review instance) that recommendations will be configured from. The recommendation will be to deny if the user is inactive during the look-back duration. For reviews of groups and Microsoft Entra roles, any duration is accepted. For reviews of applications, 30 days is the maximum duration. If not specified, the duration is 30 days. NOTE: If the stageSettings of the accessReviewScheduleDefinition object is defined, its recommendationLookBackDuration setting will be used instead of the value of this property. | |
| **RecommendationsEnabled** | Write | Boolean | Indicates whether decision recommendations are enabled or disabled. NOTE: If the stageSettings of the accessReviewScheduleDefinition object is defined, its recommendationsEnabled setting will be used instead of the value of this property. | |
| **Recurrence** | Write | MSFT_MicrosoftGraphPatternedRecurrence | Detailed settings for recurrence using the standard Outlook recurrence object. Note: Only dayOfMonth, interval, and type (weekly, absoluteMonthly) properties are supported. Use the property startDate on recurrenceRange to determine the day the review starts. | |
| **ReminderNotificationsEnabled** | Write | Boolean | Indicates whether reminders are enabled or disabled. Default value is false. | |

### MSFT_MicrosoftGraphAccessReviewApplyAction

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.disableAndDeleteUserApplyAction`, `#microsoft.graph.removeAccessApplyAction` |

### MSFT_MicrosoftGraphAccessReviewRecommendationInsightSetting

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **RecommendationLookBackDuration** | Write | String | Optional. Indicates the time period of inactivity (with respect to the start date of the review instance) that recommendations will be configured from. The recommendation will be to deny if the user is inactive during the look-back duration. For reviews of groups and Microsoft Entra roles, any duration is accepted. For reviews of applications, 30 days is the maximum duration. If not specified, the duration is 30 days. | |
| **SignInScope** | Write | String | Indicates whether inactivity is calculated based on the user's inactivity in the tenant or in the application. The possible values are tenant, application, unknownFutureValue. application is only relevant when the access review is a review of an assignment to an application. | `tenant`, `application`, `unknownFutureValue` |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.groupPeerOutlierRecommendationInsightSettings`, `#microsoft.graph.userLastSignInRecommendationInsightSetting` |

### MSFT_MicrosoftGraphPatternedRecurrence

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Pattern** | Write | MSFT_MicrosoftGraphRecurrencePattern | The frequency of an event. Do not specify for a one-time access review.  For access reviews: Do not specify this property for a one-time access review.   Only interval, dayOfMonth, and type (weekly, absoluteMonthly) properties of recurrencePattern are supported. | |
| **Range** | Write | MSFT_MicrosoftGraphRecurrenceRange | The duration of an event. | |

### MSFT_MicrosoftGraphRecurrencePattern

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DayOfMonth** | Write | UInt32 | The day of the month on which the event occurs. Required if type is absoluteMonthly or absoluteYearly. | |
| **DaysOfWeek** | Write | StringArray[] | A collection of the days of the week on which the event occurs. The possible values are: sunday, monday, tuesday, wednesday, thursday, friday, saturday. If type is relativeMonthly or relativeYearly, and daysOfWeek specifies more than one day, the event falls on the first day that satisfies the pattern.  Required if type is weekly, relativeMonthly, or relativeYearly. | |
| **FirstDayOfWeek** | Write | String | The first day of the week. The possible values are: sunday, monday, tuesday, wednesday, thursday, friday, saturday. Default is sunday. Required if type is weekly. | |
| **Index** | Write | String | Specifies on which instance of the allowed days specified in daysOfWeek the event occurs, counted from the first instance in the month. The possible values are: first, second, third, fourth, last. Default is first. Optional and used if type is relativeMonthly or relativeYearly. | `first`, `second`, `third`, `fourth`, `last` |
| **Interval** | Write | UInt32 | The number of units between occurrences, where units can be in days, weeks, months, or years, depending on the type. Required. | |
| **Month** | Write | UInt32 | The month in which the event occurs.  This is a number from 1 to 12. | |
| **Type** | Write | String | The recurrence pattern type: daily, weekly, absoluteMonthly, relativeMonthly, absoluteYearly, relativeYearly. Required. For more information, see values of type property. | `daily`, `weekly`, `absoluteMonthly`, `relativeMonthly`, `absoluteYearly`, `relativeYearly` |

### MSFT_MicrosoftGraphRecurrenceRange

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EndDate** | Write | String | The date to stop applying the recurrence pattern. Depending on the recurrence pattern of the event, the last occurrence of the meeting may not be this date. Required if type is endDate. | |
| **NumberOfOccurrences** | Write | UInt32 | The number of times to repeat the event. Required and must be positive if type is numbered. | |
| **RecurrenceTimeZone** | Write | String | Time zone for the startDate and endDate properties. Optional. If not specified, the time zone of the event is used. | |
| **StartDate** | Write | String | The date to start applying the recurrence pattern. The first occurrence of the meeting may be this date or later, depending on the recurrence pattern of the event. Must be the same value as the start property of the recurring event. Required. | |
| **Type** | Write | String | The recurrence range. Possible values are: endDate, noEnd, numbered. Required. | `endDate`, `noEnd`, `numbered` |

### MSFT_MicrosoftGraphAccessReviewStageSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DecisionsThatWillMoveToNextStage** | Write | StringArray[] | Indicate which decisions will go to the next stage. Can be a subset of Approve, Deny, Recommendation, or NotReviewed. If not provided, all decisions will go to the next stage. Optional. | |
| **DependsOnValue** | Write | StringArray[] | Defines the sequential or parallel order of the stages and depends on the stageId. Only sequential stages are currently supported. For example, if stageId is 2, then dependsOn must be 1. If stageId is 1, don't specify dependsOn. Required if stageId isn't 1. | |
| **DurationInDays** | Write | UInt32 | The duration of the stage. Required.  NOTE: The cumulative value of this property across all stages  1. Will override the instanceDurationInDays setting on the accessReviewScheduleDefinition object. 2. Can't exceed the length of one recurrence. That is, if the review recurs weekly, the cumulative durationInDays can't exceed 7. | |
| **RecommendationInsightSettings** | Write | MSFT_MicrosoftGraphAccessReviewRecommendationInsightSetting[] | Recommendation Insights Settings | |
| **RecommendationLookBackDuration** | Write | String | Optional field. Indicates the time period of inactivity (with respect to the start date of the review instance) from which that recommendations will be configured. The recommendation is to deny if the user is inactive during the look back duration. For reviews of groups and Microsoft Entra roles, any duration is accepted. For reviews of applications, 30 days is the maximum duration. If not specified, the duration is 30 days. NOTE: The value of this property overrides the corresponding setting on the accessReviewScheduleDefinition object. | |
| **RecommendationsEnabled** | Write | Boolean | Indicates whether showing recommendations to reviewers is enabled. Required. NOTE: The value of this property overrides the corresponding setting on the accessReviewScheduleDefinition object. | |
| **StageId** | Write | String | Unique identifier of the accessReviewStageSettings. The stageId is used in dependsOn property to indicate the stage relationship. Required. | |


## Description

Azure AD Access Review Definition

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - AccessReview.Read.All

- **Update**

    - None

#### Application permissions

- **Read**

    - AccessReview.Read.All

- **Update**

    - None

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
    }
}
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            Ensure                  = "Absent";
            Id                      = "613854e6-c458-4a2c-83fc-e0f4b8b17d60";
            ApplicationId           = $ApplicationId
            TenantId                = $TenantId
            CertificateThumbprint   = $CertificateThumbprint
        }
    }
}
```

