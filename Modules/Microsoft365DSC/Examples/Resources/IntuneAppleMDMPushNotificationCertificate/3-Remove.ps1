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
        IntuneAppleMDMPushNotificationCertificate "IntuneAppleMDMPushNotificationCertificate-66f4ec83-754f-4a59-a73d-e3182cc636a5"
        {
            AppleIdentifier         = ""
	        Certificate 	        = "";

            Ensure                  = "Absent";
            ApplicationId           = $ConfigurationData.NonNodeData.ApplicationId;
            TenantId                = $OrganizationName;
        }
    }
}
