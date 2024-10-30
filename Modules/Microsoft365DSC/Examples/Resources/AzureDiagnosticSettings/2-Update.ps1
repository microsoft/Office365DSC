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
        AzureDiagnosticSettings "AzureDiagnosticSettings-TestDiag"
        {
            ApplicationId               = $ApplicationId;
            Categories                  = @(
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'AuditLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'SignInLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'NonInteractiveUserSignInLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'ServicePrincipalSignInLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'ManagedIdentitySignInLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'ProvisioningLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'ADFSSignInLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'RiskyUsers'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'UserRiskEvents'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'NetworkAccessTrafficLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'RiskyServicePrincipals'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'ServicePrincipalRiskEvents'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'EnrichedOffice365AuditLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'MicrosoftGraphActivityLogs'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'RemoteNetworkHealthLogs'
                    enabled = $False #Drift
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'NetworkAccessAlerts'
                    enabled = $True
                }
                MSFT_AzureDiagnosticSettingsCategory{
                    category = 'B2CRequestLogs'
                    enabled = $False
                }
            );
            CertificateThumbprint       = $CertificateThumbprint;
            Ensure                      = "Present";
            EventHubAuthorizationRuleId = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.EventHub/namespaces/myhub/authorizationrules/RootManageSharedAccessKey";
            EventHubName                = "";
            Name                        = "TestDiag";
            StorageAccountId            = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.Storage/storageAccounts/demostore";
            TenantId                    = $TenantId;
            WorkspaceId                 = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.OperationalInsights/workspaces/MySentinelWorkspace";
        }
    }
}
