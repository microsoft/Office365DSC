<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

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
