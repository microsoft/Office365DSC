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
