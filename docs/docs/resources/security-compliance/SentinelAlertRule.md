# SentinelAlertRule

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name of the indicator | |
| **SubscriptionId** | Write | String | The name of the resource group. The name is case insensitive. | |
| **ResourceGroupName** | Write | String | The name of the resource group. The name is case insensitive. | |
| **WorkspaceName** | Write | String | The name of the workspace. | |
| **Id** | Write | String | The unique id of the indicator. | |
| **Description** | Write | String | The name of the workspace. | |
| **ProductFilter** | Write | String | The alerts' productName on which the cases will be generated | |
| **Enabled** | Write | Boolean | Determines whether this alert rule is enabled or disabled. | |
| **Severity** | Write | String | The severity for alerts created by this alert rule. | |
| **Tactics** | Write | StringArray[] | The tactics of the alert rule | |
| **Techniques** | Write | StringArray[] | The techniques of the alert rule | |
| **SubTechniques** | Write | StringArray[] | The sub-techniques of the alert rule | |
| **Query** | Write | String | The query that creates alerts for this rule. | |
| **QueryFrequency** | Write | String | The frequency (in ISO 8601 duration format) for this alert rule to run. | |
| **QueryPeriod** | Write | String | The period (in ISO 8601 duration format) that this alert rule looks at. | |
| **TriggerOperator** | Write | String | The operation against the threshold that triggers alert rule. | |
| **TriggerThreshold** | Write | UInt32 | The threshold triggers this alert rule. | |
| **SuppressionDuration** | Write | String | The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered. | |
| **SuppressionEnabled** | Write | String | Determines whether the suppression for this alert rule is enabled or disabled. | |
| **AlertRuleTemplateName** | Write | String | The Name of the alert rule template used to create this rule. | |
| **DisplayNamesExcludeFilter** | Write | StringArray[] | The alerts' displayNames on which the cases will not be generated. | |
| **DisplayNamesFilter** | Write | StringArray[] | The alerts' displayNames on which the cases will be generated. | |
| **SeveritiesFilter** | Write | StringArray[] | The alerts' severities on which the cases will be generated | |
| **EventGroupingSettings** | Write | MSFT_SentinelAlertRuleEventGroupingSettings | The event grouping settings. | |
| **CustomDetails** | Write | MSFT_SentinelAlertRuleCustomDetails[] | Dictionary of string key-value pairs of columns to be attached to the alert | |
| **EntityMappings** | Write | MSFT_SentinelAlertRuleEntityMapping[] | Array of the entity mappings of the alert rule | |
| **AlertDetailsOverride** | Write | MSFT_SentinelAlertRuleAlertDetailsOverride | The alert details override settings | |
| **IncidentConfiguration** | Write | MSFT_SentinelAlertRuleIncidentConfiguration | The settings of the incidents that created from alerts triggered by this analytics rule | |
| **Kind** | Write | String | The kind of the alert rule | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_SentinelAlertRuleEventGroupingSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **aggregationKind** | Write | String | The event grouping aggregation kinds | |

### MSFT_SentinelAlertRuleCustomDetails

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DetailKey** | Write | String | Key of the custom detail. | |
| **DetailValue** | Write | String | Associated value with the custom detail. | |

### MSFT_SentinelAlertRuleEntityMapping

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **entityType** | Write | String | Type of entity. | |
| **fieldMappings** | Write | MSFT_SentinelAlertRuleEntityMappingFieldMapping[] | List of field mappings. | |

### MSFT_SentinelAlertRuleEntityMappingFieldMapping

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **columnName** | Write | String | Name of the column | |
| **identifier** | Write | String | Identifier of the associated field. | |

### MSFT_SentinelAlertRuleAlertDetailsOverride

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **alertDescriptionFormat** | Write | String | The format containing columns name(s) to override the alert description | |
| **alertDisplayNameFormat** | Write | String | The format containing columns name(s) to override the alert name | |
| **alertSeverityColumnName** | Write | String | The column name to take the alert severity from | |
| **alertTacticsColumnName** | Write | String | The column name to take the alert tactics from | |
| **alertDynamicProperties** | Write | MSFT_SentinelAlertRuleAlertDetailsOverrideAlertDynamicProperty[] | List of additional dynamic properties to override | |

### MSFT_SentinelAlertRuleAlertDetailsOverrideAlertDynamicProperty

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **alertProperty** | Write | String | Dynamic property key. | |
| **alertPropertyValue** | Write | String | Dynamic property value. | |

### MSFT_SentinelAlertRuleIncidentConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **createIncident** | Write | Boolean | Create incidents from alerts triggered by this analytics rule | |
| **groupingConfiguration** | Write | MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfiguration | Set how the alerts that are triggered by this analytics rule, are grouped into incidents | |

### MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **enabled** | Write | Boolean | Grouping enabled | |
| **groupByAlertDetails** | Write | MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfigurationAlertDetail[] | A list of alert details to group by (when matchingMethod is Selected) | |
| **groupByCustomDetails** | Write | StringArray[] | A list of custom details keys to group by (when matchingMethod is Selected). Only keys defined in the current alert rule may be used. | |
| **groupByEntities** | Write | StringArray[] | A list of entity types to group by (when matchingMethod is Selected). Only entities defined in the current alert rule may be used. | |
| **lookbackDuration** | Write | String | Limit the group to alerts created within the lookback duration (in ISO 8601 duration format) | |
| **matchingMethod** | Write | String | Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty. | |
| **reopenClosedIncident** | Write | Boolean | Re-open closed matching incidents | |

### MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfigurationAlertDetail

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Write | String | Display name of the alert detail. | |
| **Severity** | Write | String | Severity level associated with the alert detail. | |


## Description

Configures alert rules in Azure Sentinel.

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

    - None

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
        SentinelAlertRule "SentinelAlertRule-MyNRTRule"
        {
            AlertDetailsOverride  = MSFT_SentinelAlertRuleAlertDetailsOverride{
                alertDescriptionFormat = 'This is an example of the alert content'
                alertDisplayNameFormat = 'Alert from {{{TimeGenerated}} '
            };
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            CustomDetails         = @(
                MSFT_SentinelAlertRuleCustomDetails{
                    DetailKey = 'Color'
                    DetailValue = 'TenantId'
                }
            );
            Description           = "Test";
            DisplayName           = "MyNRTRule";
            Enabled               = $True;
            Ensure                = "Present";
            EntityMappings        = @(
                MSFT_SentinelAlertRuleEntityMapping{
                    fieldMappings = @(
                        MSFT_SentinelAlertRuleEntityMappingFieldMapping{
                            identifier = 'AppId'
                            columnName = 'Id'
                        }
                    )
                    entityType = 'CloudApplication'
                }
            );
            IncidentConfiguration = MSFT_SentinelAlertRuleIncidentConfiguration{
                groupingConfiguration = MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfiguration{
                    lookbackDuration = 'PT5H'
                    matchingMethod = 'Selected'
                    groupByCustomDetails = @('Color')
                    groupByEntities = @('CloudApplication')
                    reopenClosedIncident = $True
                    enabled = $True
                }
                            createIncident = $True
            };
            Query                 = "ThreatIntelIndicators";
            ResourceGroupName     = "ResourceGroupName";
            Severity              = "Medium";
            SubscriptionId        = "xxxx";
            SuppressionDuration   = "PT5H";
            Tactics               = @();
            Techniques            = @();
            TenantId              = $TenantId;
            WorkspaceName         = "SentinelWorkspace";
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
        SentinelAlertRule "SentinelAlertRule-MyNRTRule"
        {
            AlertDetailsOverride  = MSFT_SentinelAlertRuleAlertDetailsOverride{
                alertDescriptionFormat = 'This is an example of the alert content'
                alertDisplayNameFormat = 'Alert from {{{TimeGenerated}} '
            };
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            CustomDetails         = @(
                MSFT_SentinelAlertRuleCustomDetails{
                    DetailKey = 'Color'
                    DetailValue = 'TenantId'
                }
            );
            Description           = "Test";
            DisplayName           = "MyNRTRule";
            Enabled               = $True;
            Ensure                = "Present";
            EntityMappings        = @(
                MSFT_SentinelAlertRuleEntityMapping{
                    fieldMappings = @(
                        MSFT_SentinelAlertRuleEntityMappingFieldMapping{
                            identifier = 'AppId'
                            columnName = 'Id'
                        }
                    )
                    entityType = 'CloudApplication'
                }
            );
            IncidentConfiguration = MSFT_SentinelAlertRuleIncidentConfiguration{
                groupingConfiguration = MSFT_SentinelAlertRuleIncidentConfigurationGroupingConfiguration{
                    lookbackDuration = 'PT5H'
                    matchingMethod = 'Selected'
                    groupByCustomDetails = @('Color')
                    groupByEntities = @('CloudApplication')
                    reopenClosedIncident = $True
                    enabled = $True
                }
                            createIncident = $True
            };
            Query                 = "ThreatIntelIndicators";
            ResourceGroupName     = "ResourceGroupName";
            Severity              = "High"; #Drift
            SubscriptionId        = "xxxx";
            SuppressionDuration   = "PT5H";
            Tactics               = @();
            Techniques            = @();
            TenantId              = $TenantId;
            WorkspaceName         = "SentinelWorkspace";
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
        SentinelAlertRule "SentinelAlertRule-MyNRTRule"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Test";
            DisplayName           = "MyNRTRule";
            Ensure                = "Absent";
            ResourceGroupName     = "ResourceGroupName";
            Severity              = "Medium";
            SubscriptionId        = "xxxx";
            TenantId              = $TenantId;
            WorkspaceName         = "SentinelWorkspace";
        }
    }
}
```

