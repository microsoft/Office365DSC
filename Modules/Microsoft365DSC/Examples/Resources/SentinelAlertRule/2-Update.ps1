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
