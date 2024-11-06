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
        AzureDiagnosticSettingsCustomSecurityAttribute "AzureDiagnosticSettingsCustomSecurityAttribute-MyAttribute"
        {
            ApplicationId               = $ApplicationId;
            Categories                  = @(
                MSFT_AzureDiagnosticSettingsCustomSecurityAttributeCategory{
                    category = 'CustomSecurityAttributeAuditLogs'
                    enabled = $False # Drift
                }
            );
            CertificateThumbprint       = $CertificateThumbprint;
            Ensure                      = "Present";
            EventHubAuthorizationRuleId = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.EventHub/namespaces/myhub/authorizationrules/RootManageSharedAccessKey";
            EventHubName                = "";
            Name                        = "MyAttribute";
            StorageAccountId            = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.Storage/storageAccounts/demostore";
            TenantId                    = $TenantId;
            WorkspaceId                 = "/subscriptions/f854132c-570e-4c98-a4c9-3cd902de77dd/resourceGroups/TBD/providers/Microsoft.OperationalInsights/workspaces/MySentinelWorkspace";
        }
    }
}
