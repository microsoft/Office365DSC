# AADNetworkAccessForwardingProfile

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Profile Name. Required. | |
| **Id** | Write | String | Id of the profile. Unique Identifier | |
| **State** | Write | String | status of the profile | |
| **Policies** | Write | MSFT_MicrosoftGraphNetworkaccessPolicyLink[] | Traffic forwarding policies associated with this profile. | |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_MicrosoftGraphNetworkaccessPolicyLink

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Policy Name. Required | |
| **PolicyLinkId** | Write | String | Policy Link Id | |
| **state** | Write | String | status | |


## Description

This resource configure the Azure AD Network Access Forwarding Profile


## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

#### Application permissions

- **Read**

    - NetworkAccess.Read.All

- **Update**

    - NetworkAccess.ReadWrite.All

## Examples

### Example 1


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

    Import-DscResource -ModuleName 'Microsoft365DSC'

    Node localhost
    {
        AADNetworkAccessForwardingProfile "AADNetworkAccessForwardingProfile-Internet traffic forwarding profile"
        {

            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            Name                 = "Internet traffic forwarding profile";
            Policies             = @(MSFT_MicrosoftGraphNetworkaccessPolicyLink {
                State = 'disabled'
                PolicyLinkId  = 'f8a43f3f-3f44-4738-8025-088bb095a711'
                Name = 'Custom Bypass'
            }
MSFT_MicrosoftGraphNetworkaccessPolicyLink {
                State = 'enabled'
                PolicyLinkId  = 'b45d1db0-9965-487b-afb1-f4d25174e9db'
                Name = 'Default Bypass'
            }
MSFT_MicrosoftGraphNetworkaccessPolicyLink {
                State = 'enabled'
                PolicyLinkId  = 'dfd9cd59-90ca-44fc-b997-7cc71f08e438'
                Name = 'Default Acquire'
            }
            );
            State   = "disabled";
        }
    }
}
```

