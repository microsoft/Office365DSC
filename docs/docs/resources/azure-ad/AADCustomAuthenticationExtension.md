# AADCustomAuthenticationExtension

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display Name of the custom security attribute. Must be unique within an attribute set. Can be up to 32 characters long and include Unicode characters. Can't contain spaces or special characters. Can't be changed later. Case sensitive. | |
| **Id** | Write | String | Unique identifier of the Attribute Definition. | |
| **CustomAuthenticationExtensionType** | Write | String | Defines the custom authentication extension type. | |
| **Description** | Write | String | Description of the custom security attribute. Can be up to 128 characters long and include Unicode characters. Can't contain spaces or special characters. Can be changed later.  | |
| **AuthenticationConfigurationType** | Write | String | Defines the authentication configuration type | |
| **AuthenticationConfigurationResourceId** | Write | String | Defines the authentication configuration resource id | |
| **ClientConfigurationTimeoutMilliseconds** | Write | UInt32 | Defines the client configuration timeout in milliseconds | |
| **ClientConfigurationMaximumRetries** | Write | UInt32 | Defines the client configuration max retries | |
| **EndpointConfiguration** | Write | MSFT_AADCustomAuthenticationExtensionEndPointConfiguration | Defines the endpoint configuration | |
| **ClaimsForTokenConfiguration** | Write | MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration[] | Defines the list of claims for token configurations | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADCustomAuthenticationExtensionEndPointConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EndpointType** | Write | String | Defines the type of the endpoint configuration | |
| **LogicAppWorkflowName** | Write | String | Defines the workflow name for the logic app | |
| **ResourceGroupName** | Write | String | Defines the resource group name for the logic app | |
| **SubscriptionId** | Write | String | Defines the subscription id for the logic app | |
| **TargetUrl** | Write | String | Defines the target url for the http endpoint | |

### MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ClaimIdInApiResponse** | Write | String | Defines the claim id in api response. | |


## Description

Custom authentication extensions define interactions with external systems during a user authentication session.

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

    - CustomSecAttributeDefinition.Read.All

- **Update**

    - CustomSecAttributeDefinition.ReadWrite.All

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
        AADCustomAuthenticationExtension "AADCustomAuthenticationExtension1"
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
        AADCustomAuthenticationExtension "AADCustomAuthenticationExtension1"
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
        AADCustomAuthenticationExtension "AADCustomAuthenticationExtension1"
        {
            DisplayName               = "DSCTestExtension"
            Ensure                    = "Absent"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

