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
        IntuneAppleMDMPushCertificate "IntuneAppCategory-Data Management"
        {
            Id                   = "a1fc9fe2-728d-4867-9a72-a61e18f8c606";
            DisplayName          = "Custom Data Management";
            Ensure               = "Absent";
        }
    }
}
