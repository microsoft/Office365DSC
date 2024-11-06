# AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the custom extension. | |
| **Id** | Write | String | Unique Id of the extension. | |
| **Description** | Write | String | Description of the extension. | |
| **ClientConfiguration** | Write | MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration | Client configuration for the extension | |
| **EndpointConfiguration** | Write | MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration | Endpoint configuration for the extension | |
| **CallbackConfiguration** | Write | MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration | Callback configuration for the extension | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **timeoutInMilliseconds** | Write | UInt32 | The max duration in milliseconds that Microsoft Entra ID waits for a response from the external app before it shuts down the connection. The valid range is between 200 and 2000 milliseconds. Default duration is 1000. | |
| **maximumRetries** | Write | UInt32 | The max number of retries that Microsoft Entra ID makes to the external API. Values of 0 or 1 are supported. If null, the default for the service applies. | |

### MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **logicAppWorkflowName** | Write | String | The name of the logic app. | |
| **resourceGroupName** | Write | String | The Azure resource group name for the logic app. | |
| **subscriptionId** | Write | String | Identifier of the Azure subscription for the logic app. | |
| **url** | Write | String | Url of the logic app. | |

### MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **timeoutDuration** | Write | String | Callback time out in ISO 8601 time duration. Accepted time durations are between five minutes to three hours. For example, PT5M for five minutes and PT3H for three hours. Inherited from customExtensionCallbackConfiguration. | |
| **authorizedApps** | Write | StringArray[] | List of apps names that are allowed to resume a task processing result. | |


## Description

Configures custom extensions for Lifecycle workflows in Entra id.

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

    - LifecycleWorkflows.Read.All

- **Update**

    - LifecycleWorkflows.ReadWrite.All

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
        AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension "AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension-My Custom"
        {
            ApplicationId         = $ApplicationId;
            CallbackConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration{
                TimeoutDuration = 'PT34M'
                AuthorizedApps = @('M365DSC')
            };
            CertificateThumbprint = $CertificateThumbprint;
            ClientConfiguration   = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration{
                MaximumRetries = 1
                TimeoutInMilliseconds = 1000
            };
            Description           = "My Description";
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
        AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension "AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension-My Custom"
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
        AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension "AADIdentityGovernanceLifecycleWorkflowCustomTaskExtension-My Custom"
        {
            ApplicationId         = $ApplicationId;
            CallbackConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration{
                TimeoutDuration = 'PT34M'
                AuthorizedApps = @('M365DSC')
            };
            CertificateThumbprint = $CertificateThumbprint;
            ClientConfiguration   = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration{
                MaximumRetries = 1
                TimeoutInMilliseconds = 1000
            };
            Description           = "My Description";
            DisplayName           = "My Custom Extension";
            EndpointConfiguration = MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration{
                SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                logicAppWorkflowName = 'MyTestApp'
                resourceGroupName =    'TestRG'
                url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
            };
            Ensure                = "Absent";
            TenantId              = $TenantId;
        }
    }
}
```

