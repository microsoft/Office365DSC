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
        AADAccessReviewDefinition "AADAccessReviewDefinition-Example"
        {
            DescriptionForAdmins    = "description for admins";
            DescriptionForReviewers = "description for reviewers";
            DisplayName             = "Test Access Review Definition";
            Ensure                  = "Absent";
            Id                      = "613854e6-c458-4a2c-83fc-e0f4b8b17d60";
            ApplicationId           = $ApplicationId
            TenantId                = $TenantId
            CertificateThumbprint   = $CertificateThumbprint
        }
    }
}
