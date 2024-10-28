# AADIdentityProtectionPolicySettings

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Only valid value is 'Yes'. | `Yes` |
| **IsUserRiskClearedOnPasswordReset** | Write | Boolean | If true, user risk is cleared on password reset. | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Use this resource to monitor the identity protection policy settings in AAD. 

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Policy.Read.IdentityProtection

- **Update**

    - Policy.ReadWrite.IdentityProtection

#### Application permissions

- **Read**

    - Policy.Read.IdentityProtection

- **Update**

    - Policy.ReadWrite.IdentityProtection

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
        AADIdentityProtectionPolicySettings "AADIdentityProtectionPolicySettings"
        {
            IsUserRiskClearedOnPasswordReset = $false; #drift
            IsSingleInstance              = "Yes";
            ApplicationId                 = $ApplicationId
            TenantId                      = $TenantId
            CertificateThumbprint         = $CertificateThumbprint
        }

    }
}
```

