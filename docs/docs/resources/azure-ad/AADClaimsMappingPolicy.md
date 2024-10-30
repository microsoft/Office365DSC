# AADClaimsMappingPolicy

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Definition** | Write | MSFT_AADClaimsMappingPolicyDefinition[] | A string collection containing a JSON string that defines the rules and settings for a policy. The syntax for the definition differs for each derived policy type. Required. | |
| **IsOrganizationDefault** | Write | Boolean | If set to true, activates this policy. There can be many policies for the same policy type, but only one can be activated as the organization default. Optional, default value is false. | |
| **Description** | Write | String | Description for this policy. Required. | |
| **DisplayName** | Key | String | Display name for this policy. Required. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Value** | Write | String | The value of the input parameters of the claims transformation in the claims mapping policy. | |
| **Id** | Write | String | The object identifier of the input parameters of the claims transformation in the claims mapping policy. | |
| **DataType** | Write | String | The data type of the input parameters of the claims transformation in the claims mapping policy. | |

### MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ClaimTypeReferenceId** | Write | String | The claim type reference ID of the output claims of the claims transformation in the claims mapping policy. | |
| **TransformationClaimType** | Write | String | The transformation type of the output claims of the claims transformation in the claims mapping policy. | |

### MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | The object identifier of the claims transformation in the claims mapping policy. | |
| **TransformationMethod** | Write | String | The transformation method of the claims transformation in the claims mapping policy. | |
| **InputParameters** | Write | MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter[] | The list of input parameters of the claims transformation in the claims mapping policy. | |
| **OutputClaims** | Write | MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims[] | The list of output claims of the claims transformation in the claims mapping policy. | |

### MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Source** | Write | String | The source name of the claims schema in the claims mapping policy. | |
| **Id** | Write | String | The object identifier of the claims schema in the claims mapping policy. | |
| **SamlClaimType** | Write | String | The SAML claims type of the claims schema in the claims mapping policy. | |

### MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Version** | Write | UInt32 | Set value of 1. Required. | |
| **IncludeBasicClaimSet** | Write | Boolean | If set to true, all claims in the basic claim set are emitted in tokens affected by the policy. If set to false, claims in the basic claim set are not in the tokens, unless they are individually added in the ClaimsSchema property of the same policy. | |
| **ClaimsSchema** | Write | MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema[] | Defines which claims are present in the tokens affected by the policy, in addition to the basic claim set and the core claim set. | |
| **ClaimsTransformation** | Write | MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation[] | Defines common transformations that can be applied to source data, to generate the output data for claims specified in the ClaimsSchema. | |

### MSFT_AADClaimsMappingPolicyDefinition

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ClaimsMappingPolicy** | Write | MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy | Rules and settings of the policy. | |


## Description

Azure AD Claims Mapping Policy

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Policy.Read.All

- **Update**

    - Policy.ReadWrite.ApplicationConfiguration

#### Application permissions

- **Read**

    - Policy.Read.All

- **Update**

    - Policy.ReadWrite.ApplicationConfiguration

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
        AADClaimsMappingPolicy "AADClaimsMappingPolicy-Test1234"
        {
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            Definition            = @(
                MSFT_AADClaimsMappingPolicyDefinition{
                    ClaimsMappingPolicy = MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy{
                        ClaimsSchema = @(
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                Source = 'user'
                                Id = 'userprincipalname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname'
                                Source = 'user'
                                Id = 'givenname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
                                Source = 'user'
                                Id = 'displayname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname'
                                Source = 'user'
                                Id = 'surname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'username'
                                Source = 'user'
                                Id = 'userprincipalname'
                            }
                        )
                        ClaimsTransformation = @(
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation{
                                OutputClaims = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims{
                                        ClaimTypeReferenceId = 'TOS'
                                        TransformationClaimType = 'createdClaim'
                                    }
                                )
                                Id = 'CreateTermsOfService'
                                InputParameters = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter{
                                        DataType = 'string'
                                        Id = 'value'
                                        Value = 'sandbox'
                                    }
                                )
                                TransformationMethod = 'CreateStringClaim'
                            }
                        )
                        IncludeBasicClaimSet = $True
                        Version = 1
                    }

                }
            );
            DisplayName           = "Test1234";
            Ensure                = "Present";
            Id                    = "fd0dc3f3-cfdf-4d56-bb03-e18161a5ac93";
            IsOrganizationDefault = $False;
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
        AADClaimsMappingPolicy "AADClaimsMappingPolicy-Test1234"
        {
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            Definition            = @(
                MSFT_AADClaimsMappingPolicyDefinition{
                    ClaimsMappingPolicy = MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy{
                        ClaimsSchema = @(
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                Source = 'user'
                                Id = 'userprincipalname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname'
                                Source = 'user'
                                Id = 'givenname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
                                Source = 'user'
                                Id = 'displayname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname'
                                Source = 'user'
                                Id = 'surname'
                            }
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema{
                                SamlClaimType = 'username'
                                Source = 'user'
                                Id = 'userprincipalname'
                            }
                        )
                        ClaimsTransformation = @(
                            MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation{
                                OutputClaims = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims{
                                        ClaimTypeReferenceId = 'TOS'
                                        TransformationClaimType = 'createdClaim'
                                    }
                                )
                                Id = 'CreateTermsOfService'
                                InputParameters = @(
                                    MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter{
                                        DataType = 'string'
                                        Id = 'value'
                                        Value = 'sandbox'
                                    }
                                )
                                TransformationMethod = 'CreateStringClaim'
                            }
                        )
                        IncludeBasicClaimSet = $True
                        Version = 1
                    }

                }
            );
            DisplayName           = "Test1234";
            Ensure                = "Present";
            Id                    = "fd0dc3f3-cfdf-4d56-bb03-e18161a5ac93";
            IsOrganizationDefault = $False;
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
        AADClaimsMappingPolicy "AADClaimsMappingPolicy-Test1234"
        {
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            DisplayName           = "Test1234";
            Ensure                = "Absent";
            Id                    = "fd0dc3f3-cfdf-4d56-bb03-e18161a5ac93";
        }
    }
}
```

