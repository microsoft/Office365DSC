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
        IntuneMobileAppsWindowsOfficeSuiteApp "IntuneMobileAppsWindowsOfficeSuiteApp-Microsoft 365 Apps for Windows 10 and later"
        {
            Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d8";
            DisplayName           = "Microsoft 365 Apps for Windows 10 and later";
            Ensure                = "Absent";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
