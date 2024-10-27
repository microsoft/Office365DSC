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
        AADOrganizationCertificateBasedAuthConfiguration "AADOrganizationCertificateBasedAuthConfiguration-58b6e58e-10d1-4b8c-845d-d6aefaaecba2"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            Ensure                 = "Absent";
            OrganizationId         = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
        }
    }
}
