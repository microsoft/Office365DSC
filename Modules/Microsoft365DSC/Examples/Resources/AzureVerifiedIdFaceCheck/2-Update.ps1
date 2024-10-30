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
