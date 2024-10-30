# Generated with Microsoft365DSC version 1.24.1016.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC

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
