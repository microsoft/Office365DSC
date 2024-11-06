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
        EXOTenantAllowBlockListSpoofItems "EXOTenantAllowBlockListSpoofItems-b66ffa0c-ad85-df9d-0a16-ad3cb9956f71"
        {
            Action                = "Allow";
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Absent";
            SendingInfrastructure = "121.0.0.7";
            SpoofedUser           = "contoso.com";
            SpoofType             = "Internal";
            TenantId              = $TenantId;
        }
    }
}
