# AzureVerifiedIdFaceCheck

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **SubscriptionId** | Key | String | Id of the Azure subscription. | |
| **ResourceGroupName** | Key | String | Name of the associated resource group. | |
| **VerifiedIdAuthorityId** | Key | String | Id of the verified ID authority. | |
| **FaceCheckEnabled** | Write | Boolean | Represents whether or not FaceCheck is enabled for the authrotiy. | |
| **VerifiedIdAuthorityLocation** | Write | String | Location of the Verified ID Authority. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures Azure Verified Id FaceCheck.

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
        AzureVerifiedIdFaceCheck "AzureVerifiedIdFaceCheck"
        {
            ApplicationId               = $ApplicationId;
            CertificateThumbprint       = $CertificateThumbprint;
            Ensure                      = "Present";
            FaceCheckEnabled            = $True;
            ResourceGroupName           = "website";
            SubscriptionId              = "2dbaf4c4-78f8-4ac9-8188-536d921cf690";
            TenantId                    = $TenantId;
            VerifiedIdAuthorityId       = "30961e04-9c35-42db-b80f-c1b6515eb4b2";
            VerifiedIdAuthorityLocation = "westus2";
        }
    }
}
```

