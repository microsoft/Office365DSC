# AADNetworkAccessForwardingPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Name of the forwarding policy | |
| **PolicyRules** | Write | MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule[] | List of rules associated to this forwarding policy. | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Policy Rule Name. Required | |
| **ActionValue** | Write | String | Action value. | |
| **RuleType** | Write | String | Type of Rule | |
| **Ports** | Write | UInt32Array[] | List of Ports. | |
| **Protocol** | Write | String | Protocol Value | |
| **Destinations** | Write | StringArray[] | List of destinations. | |


## Description

Use this resource to monitor the forwarding policy rules associated with the forwarding policies.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - NetworkAccessPolicy.Read.All

- **Update**

    - NetworkAccessPolicy.ReadWrite.All

#### Application permissions

- **Read**

    - NetworkAccessPolicy.Read.All

- **Update**

    - NetworkAccessPolicy.ReadWrite.All

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
        AADNetworkAccessForwardingPolicy "AADNetworkAccessForwardingPolicy-Custom Bypass"
        {
            Name                  = "Custom Bypass";
            PolicyRules           = @(
                MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                    Name           = 'Custom policy internet rule'
                    ActionValue    = 'bypass'
                    RuleType       = 'fqdn'
                    Protocol       = 'tcp'
                    Ports          = @(80, 443)
                    Destinations   = @('www.microsoft.com')
                }

                MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                    Name           = 'Custom policy internet rule'
                    ActionValue    = 'bypass'
                    RuleType       = 'ipAddress'
                    Protocol       = 'tcp'
                    Ports          = @(80, 443)
                    Destinations   = @('192.168.1.1')
                }

                MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {
                    Name           = 'Custom policy internet rule'
                    ActionValue    = 'bypass'
                    RuleType       = 'ipSubnet'
                    Protocol       = 'tcp'
                    Ports          = @(80, 443)
                    Destinations   = @('192.164.0.0/24')
                }
            );
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

