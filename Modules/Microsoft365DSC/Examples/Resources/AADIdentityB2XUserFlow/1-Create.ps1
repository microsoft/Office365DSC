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
        AADIdentityB2XUserFlow "AADIdentityB2XUserFlow-B2X_1_TestFlow"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            ApiConnectorConfiguration = MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration
            {
                postAttributeCollectionConnectorId = 'RestApi_f6e8e73d-6b17-433e-948f-f578f12bd57c'
                postFederationSignupConnectorId = 'RestApi_beeb7152-673c-48b3-b143-9975949a93ca'
            };
            Credential                = $Credscredential;
            Ensure                    = "Present";
            Id                        = "B2X_1_TestFlow";
            IdentityProviders         = @("MSASignup-OAUTH","EmailOtpSignup-OAUTH");
            UserAttributeAssignments  = @(
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'textBox'
                    IsOptional = $True
                    DisplayName = 'Email Address'
                    Id = 'emailReadonly'

                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'dropdownSingleSelect'
                    IsOptional = $True
                    DisplayName = 'Random'
                    Id = 'city'
                    UserAttributeValues = @(
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'S'
                            Value = '2'
                        }
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'X'
                            Value = '1'
                        }
                    )
                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment{
                    UserInputType = 'textBox'
                    IsOptional = $False
                    DisplayName = 'Piyush1'
                    Id = 'extension_91d51274096941f786b07b9d723d93f4_Piyush1'

                }
            );
        }
    }
}
