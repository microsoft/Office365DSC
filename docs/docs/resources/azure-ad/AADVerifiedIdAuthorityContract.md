# AADVerifiedIdAuthorityContract

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **id** | Write | String | Id of the Verified ID Authority Contract. | |
| **linkedDomainUrl** | Key | String | URL of the linked domain of the authority. | |
| **authorityId** | Write | String | Id of the Verified ID Authority. | |
| **name** | Key | String | Name of the Verified ID Authority Contract. | |
| **displays** | Write | MSFT_AADVerifiedIdAuthorityContractDisplayModel[] | Display settings of the Authority Contract. | |
| **rules** | Write | MSFT_AADVerifiedIdAuthorityContractRulesModel | Rules settings of the Authority Contract. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **uri** | Write | String | URI of the logo. If this is a URL, it must be reachable over the public internet anonymously. | |
| **description** | Write | String | Description of the logo. | |

### MSFT_AADVerifiedIdAuthorityContractDisplayCard

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **title** | Write | String | Title of the credential. | |
| **issuedBy** | Write | String | The name of the issuer of the credential. | |
| **backgroundColor** | Write | String | Background color of the credential in hex, for example, #FFAABB. | |
| **textColor** | Write | String | Text color of the credential in hex, for example, #FFAABB. | |
| **description** | Write | String | Supplemental text displayed alongside each credential. | |
| **logo** | Write | MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo | The logo to use for the credential. | |

### MSFT_AADVerifiedIdAuthorityContractDisplayConsent

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **title** | Write | String | Title of the consent. | |
| **instructions** | Write | String | Supplemental text to use when displaying consent. | |

### MSFT_AADVerifiedIdAuthorityContractDisplayClaims

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **label** | Write | String | The label of the claim in display. | |
| **claim** | Write | String | The name of the claim to which the label applies. | |
| **type** | Write | String | The type of the claim. | |
| **description** | Write | String | The description of the claim. | |

### MSFT_AADVerifiedIdAuthorityContractDisplayModel

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **locale** | Write | String | The locale of this display. | |
| **card** | Write | MSFT_AADVerifiedIdAuthorityContractDisplayCard | The display properties of the verifiable credential. | |
| **consent** | Write | MSFT_AADVerifiedIdAuthorityContractDisplayConsent | Supplemental data when the verifiable credential is issued. | |
| **claims** | Write | MSFT_AADVerifiedIdAuthorityContractDisplayClaims[] | Labels for the claims included in the verifiable credential. | |

### MSFT_AADVerifiedIdAuthorityContractClaimMapping

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **inputClaim** | Write | String | The name of the claim to use from the input. | |
| **outputClaim** | Write | String | The name of the claim in the verifiable credential. | |
| **indexed** | Write | Boolean | Indicating whether the value of this claim is used for searching. | |
| **required** | Write | Boolean | Indicating whether this mapping is required or not. | |
| **type** | Write | String | Type of claim. | |

### MSFT_AADVerifiedIdAuthorityContractAttestationValues

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **mapping** | Write | MSFT_AADVerifiedIdAuthorityContractClaimMapping[] | Rules to map input claims into output claims in the verifiable credential. | |
| **required** | Write | Boolean | Indicating whether this attestation is required or not. | |
| **trustedIssuers** | Write | StringArray[] | A list of DIDs allowed to issue the verifiable credential for this contract. | |
| **credentialType** | Write | String | Required credential type of the input. | |
| **configuration** | Write | String | Location of the identity provider's configuration document. | |
| **clientId** | Write | String | Client ID to use when obtaining the ID token. | |
| **redirectUri** | Write | String | Redirect URI to use when obtaining the ID token. MUST BE vcclient://openid/ | |
| **scopeValue** | Write | String | Space delimited list of scopes to use when obtaining the ID token. | |

### MSFT_AADVerifiedIdAuthorityContractAttestations

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **idTokenHints** | Write | MSFT_AADVerifiedIdAuthorityContractAttestationValues[] | Id token hints attestations. | |
| **idTokens** | Write | MSFT_AADVerifiedIdAuthorityContractAttestationValues[] | Id token attestations. | |
| **presentations** | Write | MSFT_AADVerifiedIdAuthorityContractAttestationValues[] | Presentations attestations. | |
| **selfIssued** | Write | MSFT_AADVerifiedIdAuthorityContractAttestationValues[] | Self Issued attestations. | |
| **accessTokens** | Write | MSFT_AADVerifiedIdAuthorityContractAttestationValues[] | Access Token attestations. | |

### MSFT_AADVerifiedIdAuthorityContractCustomStatusEndpoint

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **url** | Write | String | The URL of the custom status endpoint. | |
| **type** | Write | String | The type of the endpoint. | |

### MSFT_AADVerifiedIdAuthorityContractVcType

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **type** | Write | StringArray[] | The type of the vc. | |

### MSFT_AADVerifiedIdAuthorityContractRulesModel

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **attestations** | Write | MSFT_AADVerifiedIdAuthorityContractAttestations | Describing supported inputs for the rules. | |
| **validityInterval** | Write | UInt32 | This value shows the lifespan of the credential. | |
| **vc** | Write | MSFT_AADVerifiedIdAuthorityContractVcType | Types for this contract. | |
| **customStatusEndpoint** | Write | MSFT_AADVerifiedIdAuthorityContractCustomStatusEndpoint | Status endpoint to include in the verifiable credential for this contract. | |

## Description

Azure AD Verified Identity Authority Contract
Use the VerifiableCredential.Contract.ReadWrite permission to read and write the authority contract.
Documentation Link: https://learn.microsoft.com/en-us/entra/verified-id/admin-api#contracts

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
        AADVerifiedIdAuthorityContract 'AADVerifiedIdAuthorityContract-Sample Custom Verified Credentials'
        {
            displays             = @(
                MSFT_AADVerifiedIdAuthorityContractDisplayModel{
                    consent = MSFT_AADVerifiedIdAuthorityContractDisplayConsent{
                        instructions = 'Sign in with your account to get your card.'
                        title = 'Do you want to get your Verified Credential?'
                    }
                    card = MSFT_AADVerifiedIdAuthorityContractDisplayCard{
                        description = 'Use your verified credential to prove to anyone that you know all about verifiable credentials.'
                        issuedBy = 'Microsoft'
                        backgroundColor = '#000000'
                        textColor = '#ffffff'
                        logo = MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo{
                            uri = 'https://didcustomerplayground.z13.web.core.windows.net/VerifiedCredentialExpert_icon.png'
                            description = 'Verified Credential Expert Logo'
                        }
                        title = 'Verified Credential Expert'
                    }
                    locale = 'en-US'
                    claims = @(
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'First name'
                            claim = 'vc.credentialSubject.firstName'
                            type = 'String'
                        }
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'Last name'
                            claim = 'vc.credentialSubject.lastName'
                            type = 'String'
                        }
                    )

                }
            );
            Ensure               = "Present";
            linkedDomainUrl      = "https://$OrganizationName/";
            name                 = "Sample Custom Verified Credentials";
            rules                = MSFT_AADVerifiedIdAuthorityContractRulesModel{
                validityInterval = 2592000
                vc = MSFT_AADVerifiedIdAuthorityContractVcType{
                    type = @('VerifiedCredentialExpert')
                }
                            attestations = MSFT_AADVerifiedIdAuthorityContractAttestations{
                    idTokenHints = @(
                        MSFT_AADVerifiedIdAuthorityContractAttestationValues{
                            mapping = @(
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.given_name'
                                    indexed = $False
                                    outputClaim = 'firstName'
                                    required = $True
                                }
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.family_name'
                                    indexed = $True
                                    outputClaim = 'lastName'
                                    required = $True
                                }
                            )
                            required = $False
                        }
                    )

                }
            
            };
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
        AADVerifiedIdAuthorityContract 'AADVerifiedIdAuthorityContract-Sample Custom Verified Credentials'
        {
            displays             = @(
                MSFT_AADVerifiedIdAuthorityContractDisplayModel{
                    consent = MSFT_AADVerifiedIdAuthorityContractDisplayConsent{
                        instructions = 'Sign in with your account to get your card.'
                        title = 'Do you want to get your sample Verified Credential?' #drift
                    }
                    card = MSFT_AADVerifiedIdAuthorityContractDisplayCard{
                        description = 'Use your verified credential to prove to anyone that you know all about verifiable credentials.'
                        issuedBy = 'Microsoft'
                        backgroundColor = '#000000'
                        textColor = '#ffffff'
                        logo = MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo{
                            uri = 'https://didcustomerplayground.z13.web.core.windows.net/VerifiedCredentialExpert_icon.png'
                            description = 'Verified Credential Expert Logo'
                        }
                        title = 'Verified Credential Expert'
                    }
                    locale = 'en-US'
                    claims = @(
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'First name'
                            claim = 'vc.credentialSubject.firstName'
                            type = 'String'
                        }
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'Last name'
                            claim = 'vc.credentialSubject.lastName'
                            type = 'String'
                        }
                    )

                }
            );
            Ensure               = "Present";
            linkedDomainUrl      = "https://$OrganizationName/";
            name                 = "Sample Custom Verified Credentials";
            rules                = MSFT_AADVerifiedIdAuthorityContractRulesModel{
                validityInterval = 2592000
                vc = MSFT_AADVerifiedIdAuthorityContractVcType{
                    type = @('VerifiedCredentialExpert')
                }
                            attestations = MSFT_AADVerifiedIdAuthorityContractAttestations{
                    idTokenHints = @(
                        MSFT_AADVerifiedIdAuthorityContractAttestationValues{
                            mapping = @(
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.given_name'
                                    indexed = $False
                                    outputClaim = 'firstName'
                                    required = $True
                                }
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.family_name'
                                    indexed = $True
                                    outputClaim = 'lastName'
                                    required = $True
                                }
                            )
                            required = $False
                        }
                    )

                }
            
            };
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
        AADVerifiedIdAuthorityContract 'AADVerifiedIdAuthorityContract-Sample Custom Verified Credentials'
        {
            displays             = @(
                MSFT_AADVerifiedIdAuthorityContractDisplayModel{
                    consent = MSFT_AADVerifiedIdAuthorityContractDisplayConsent{
                        instructions = 'Sign in with your account to get your card.'
                        title = 'Do you want to get your Verified Credential?'
                    }
                    card = MSFT_AADVerifiedIdAuthorityContractDisplayCard{
                        description = 'Use your verified credential to prove to anyone that you know all about verifiable credentials.'
                        issuedBy = 'Microsoft'
                        backgroundColor = '#000000'
                        textColor = '#ffffff'
                        logo = MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo{
                            uri = 'https://didcustomerplayground.z13.web.core.windows.net/VerifiedCredentialExpert_icon.png'
                            description = 'Verified Credential Expert Logo'
                        }
                        title = 'Verified Credential Expert'
                    }
                    locale = 'en-US'
                    claims = @(
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'First name'
                            claim = 'vc.credentialSubject.firstName'
                            type = 'String'
                        }
                        MSFT_AADVerifiedIdAuthorityContractDisplayClaims{
                            label = 'Last name'
                            claim = 'vc.credentialSubject.lastName'
                            type = 'String'
                        }
                    )

                }
            );
            Ensure               = "Absent";
            linkedDomainUrl      = "https://$OrganizationName/";
            name                 = "Sample Custom Verified Credentials";
            rules                = MSFT_AADVerifiedIdAuthorityContractRulesModel{
                validityInterval = 2592000
                vc = MSFT_AADVerifiedIdAuthorityContractVcType{
                    type = @('VerifiedCredentialExpert')
                }
                            attestations = MSFT_AADVerifiedIdAuthorityContractAttestations{
                    idTokenHints = @(
                        MSFT_AADVerifiedIdAuthorityContractAttestationValues{
                            mapping = @(
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.given_name'
                                    indexed = $False
                                    outputClaim = 'firstName'
                                    required = $True
                                }
                                MSFT_AADVerifiedIdAuthorityContractClaimMapping{
                                    inputClaim = '$.family_name'
                                    indexed = $True
                                    outputClaim = 'lastName'
                                    required = $True
                                }
                            )
                            required = $False
                        }
                    )

                }
            
            };
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

