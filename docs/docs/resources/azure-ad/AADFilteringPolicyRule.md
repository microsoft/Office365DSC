# AADFilteringPolicyRule

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Name of the rule. | |
| **Policy** | Key | String | Name of the associated policy. | |
| **Id** | Write | String | Unique Id for the rule. | |
| **RuleType** | Write | String | Type of rule. | |
| **Destinations** | Write | MSFT_AADFilteringPolicyRuleDestination[] | List of associated destinations with the rule. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADFilteringPolicyRuleDestination

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **name** | Write | String | Name of the destination. | |
| **value** | Write | String | FQDN value for the destination. | |


## Description

Configures filtering rules in Entra Id.

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

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

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
        AADFilteringPolicyRule "AADFilteringPolicyRule-FQDN"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    value = 'Microsoft365DSC.com'
                }
            );
            Ensure                = "Present";
            Name                  = "MyFQDN";
            Policy                = "AMyPolicy";
            RuleType              = "fqdn";
            TenantId              = $TenantId;
        }
        AADFilteringPolicyRule "AADFilteringPolicyRule-Web"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    name = 'ChildAbuseImages'
                }
            );
            Ensure                = "Present";
            Name                  = "MyWebContentRule";
            Policy                = "MyPolicy";
            RuleType              = "webCategory";
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
        AADFilteringPolicyRule "AADFilteringPolicyRule-FQDN"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    value = 'contoso.com' #Drift
                }
            );
            Ensure                = "Present";
            Name                  = "MyFQDN";
            Policy                = "AMyPolicy";
            RuleType              = "fqdn";
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
        AADFilteringPolicyRule "AADFilteringPolicyRule-FQDN"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    value = 'Microsoft365DSC.com'
                }
            );
            Ensure                = "Absent";
            Name                  = "MyFQDN";
            Policy                = "AMyPolicy";
            RuleType              = "fqdn";
            TenantId              = $TenantId;
        }
        AADFilteringPolicyRule "AADFilteringPolicyRule-Web"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Destinations          = @(
                MSFT_AADFilteringPolicyRuleDestination{
                    name = 'ChildAbuseImages'
                }
            );
            Ensure                = "Absent";
            Name                  = "MyWebContentRule";
            Policy                = "MyPolicy";
            RuleType              = "webCategory";
            TenantId              = $TenantId;
        }
    }
}
```

