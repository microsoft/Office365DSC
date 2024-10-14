# PPDLPPolicyConnectorConfigurations

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **PolicyName** | Key | String | The policy name identifier. | |
| **PPTenantId** | Key | String | The tenant identifier. | |
| **ConnectorActionConfigurations** | Write | MSFT_PPDLPPolicyConnectorConfigurationsAction[] | Set of cnnector actions associated with the policy. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_PPDLPPolicyConnectorConfigurationsActionRules

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **actionId** | Write | String | Id of the action. | |
| **behavior** | Write | String | Associated behavior. | |

### MSFT_PPDLPPolicyConnectorConfigurationsAction

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **connectorId** | Write | String | Unique id of the connector. | |
| **defaultConnectorActionRuleBehavior** | Write | String | Default action behavior for to connector. | |
| **actionRules** | Write | MSFT_PPDLPPolicyConnectorConfigurationsActionRules[] | List of associated actions. | |


## Description

Configures connectors Data Loss Prevention policies in Power Platforms.

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
        PPDLPPolicyConnectorConfigurations "PPDLPPolicyConnectorConfigurations-9fdd99b8-6c9f-4e9c-aafe-1a4c1e4fe451"
        {
            ApplicationId                 = $ApplicationId;
            CertificateThumbprint         = $CertificateThumbprint;
            ConnectorActionConfigurations = @(
                MSFT_PPDLPPolicyConnectorConfigurationsAction{
                    actionRules = @(
                        MSFT_PPDLPPolicyConnectorConfigurationsActionRules{
                            actionId = 'CreateInvitation'
                            behavior = 'Allow'
                        }
                    )
                    connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                    defaultConnectorActionRuleBehavior = 'Allow'
                }
            );
            Ensure                        = "Present";
            PolicyName                    = "DSCPolicy";
            PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
            TenantId                      = $TenantId;
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
        PPDLPPolicyConnectorConfigurations "PPDLPPolicyConnectorConfigurations-9fdd99b8-6c9f-4e9c-aafe-1a4c1e4fe451"
        {
            ApplicationId                 = $ApplicationId;
            CertificateThumbprint         = $CertificateThumbprint;
            ConnectorActionConfigurations = @(
                MSFT_PPDLPPolicyConnectorConfigurationsAction{
                    actionRules = @(
                        MSFT_PPDLPPolicyConnectorConfigurationsActionRules{
                            actionId = 'CreateInvitation'
                            behavior = 'Block' #drift
                        }
                    )
                    connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                    defaultConnectorActionRuleBehavior = 'Allow'
                }
            );
            Ensure                        = "Present";
            PolicyName                    = "DSCPolicy";
            PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
            TenantId                      = $TenantId;
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
        PPDLPPolicyConnectorConfigurations "PPDLPPolicyConnectorConfigurations-9fdd99b8-6c9f-4e9c-aafe-1a4c1e4fe451"
        {
            ApplicationId                 = $ApplicationId;
            CertificateThumbprint         = $CertificateThumbprint;
            Ensure                        = "Absent";
            PolicyName                    = "DSCPolicy";
            PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
            TenantId                      = $TenantId;
        }
    }
}
```

