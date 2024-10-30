# AzureDiagnosticSettings

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Diagnostic setting name. | |
| **Categories** | Write | MSFT_AzureDiagnosticSettingsCategory[] | List of log categories. | |
| **StorageAccountId** | Write | String | Storage account id. | |
| **ServiceBusRuleId** | Write | String | Service bus id. | |
| **EventHubAuthorizationRuleId** | Write | String | Event hub id. | |
| **EventHubName** | Write | String | Event hub name. | |
| **WorkspaceId** | Write | String | Workspace id. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AzureDiagnosticSettingsCategory

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Category** | Write | String | Name of the category. | |
| **enabled** | Write | Boolean | Is the log category enabled or not. | |

## Description

Configures Diagnostics settings in Azure.

Users will need to grant permissions to the associated scope by running the following command in Azure Cloud Shell:
```Powershell
New-AzRoleAssignment -ObjectId "<Service Principal Object ID>" -Scope "/providers/Microsoft.aadiam" -RoleDefinitionName 'Contributor' -ObjectType 'ServicePrincipal'
```

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
                    enabled = $True
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
        AzureDiagnosticSettings "AzureDiagnosticSettings-TestDiag"
        {
            ApplicationId               = $ApplicationId;
            CertificateThumbprint       = $CertificateThumbprint;
            Ensure                      = "Absent";
            Name                        = "TestDiag";
            TenantId                    = $TenantId;
        }
    }
}
```

