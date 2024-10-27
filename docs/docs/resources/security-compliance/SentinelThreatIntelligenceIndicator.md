# SentinelThreatIntelligenceIndicator

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The display name of the indicator | |
| **SubscriptionId** | Write | String | The name of the resource group. The name is case insensitive. | |
| **ResourceGroupName** | Write | String | The name of the resource group. The name is case insensitive. | |
| **WorkspaceName** | Write | String | The name of the workspace. | |
| **Id** | Write | String | The unique id of the indicator. | |
| **Description** | Write | String | The name of the workspace. | |
| **PatternType** | Write | String | Pattern type of a threat intelligence entity | |
| **Pattern** | Write | String | Pattern of a threat intelligence entity | |
| **Revoked** | Write | String | Is threat intelligence entity revoked | |
| **ValidFrom** | Write | String | Valid from | |
| **ValidUntil** | Write | String | Valid until | |
| **Source** | Write | String | Source type. | |
| **Labels** | Write | StringArray[] | Labels of threat intelligence entity | |
| **ThreatIntelligenceTags** | Write | StringArray[] | List of tags | |
| **ThreatTypes** | Write | StringArray[] | Threat types | |
| **KillChainPhases** | Write | StringArray[] | Kill chain phases | |
| **Confidence** | Write | UInt32 | Confidence of threat intelligence entity | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures threat intelligence indicators in Azure Sentinel.

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
        SentinelThreatIntelligenceIndicator "SentinelThreatIntelligenceIndicator-ipv6-addr Indicator"
        {
            ApplicationId          = $ApplicationId;
            CertificateThumbprint  = $CertificateThumbprint;
            DisplayName            = "MyIndicator";
            Ensure                 = "Present";
            Labels                 = @("Tag1", "Tag2");
            Pattern                = "[ipv6-addr:value = '2607:fa49:d340:f600:c8d5:6961:247f:a238']";
            PatternType            = "ipv6-addr";
            ResourceGroupName      = "MyResourceGroup";
            Source                 = "Microsoft Sentinel";
            SubscriptionId         = "12345-12345-12345-12345-12345";
            TenantId               = $TenantId;
            ThreatIntelligenceTags = @();
            ValidFrom              = "2024-10-21T19:03:57.24Z";
            ValidUntil             = "2024-10-21T19:03:57.24Z";
            WorkspaceName          = "SentinelWorkspace";
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
        SentinelThreatIntelligenceIndicator "SentinelThreatIntelligenceIndicator-ipv6-addr Indicator"
        {
            ApplicationId          = $ApplicationId;
            CertificateThumbprint  = $CertificateThumbprint;
            DisplayName            = "MyIndicator";
            Ensure                 = "Present";
            Labels                 = @("Tag1", "Tag2", "Tag3"); #Drift
            Pattern                = "[ipv6-addr:value = '2607:fa49:d340:f600:c8d5:6961:247f:a238']";
            PatternType            = "ipv6-addr";
            ResourceGroupName      = "MyResourceGroup";
            Source                 = "Microsoft Sentinel";
            SubscriptionId         = "12345-12345-12345-12345-12345";
            TenantId               = $TenantId;
            ThreatIntelligenceTags = @();
            ValidFrom              = "2024-10-21T19:03:57.24Z";
            ValidUntil             = "2024-10-21T19:03:57.24Z";
            WorkspaceName          = "SentinelWorkspace";
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
        SentinelThreatIntelligenceIndicator "SentinelThreatIntelligenceIndicator-ipv6-addr Indicator"
        {
            ApplicationId          = $ApplicationId;
            CertificateThumbprint  = $CertificateThumbprint;
            DisplayName            = "MyIndicator";
            Ensure                 = "Absent";
            Labels                 = @("Tag1", "Tag2");
            Pattern                = "[ipv6-addr:value = '2607:fa49:d340:f600:c8d5:6961:247f:a238']";
            PatternType            = "ipv6-addr";
            ResourceGroupName      = "MyResourceGroup";
            Source                 = "Microsoft Sentinel";
            SubscriptionId         = "12345-12345-12345-12345-12345";
            TenantId               = $TenantId;
            ThreatIntelligenceTags = @();
            ValidFrom              = "2024-10-21T19:03:57.24Z";
            ValidUntil             = "2024-10-21T19:03:57.24Z";
            WorkspaceName          = "SentinelWorkspace";
        }
    }
}
```

