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
        IntuneMobileThreatDefenseConnector "IntuneMobileThreatDefenseConnector-Microsoft Defender for Endpoint"
        {
            AllowPartnerToCollectIosApplicationMetadata         = $False;
            AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
            AndroidDeviceBlockedOnMissingPartnerData            = $False;
            AndroidEnabled                                      = $False;
            AndroidMobileApplicationManagementEnabled           = $False;
            DisplayName                                         = "Microsoft Defender for Endpoint";
            Id                                                  = "fc780465-2017-40d4-a0c5-307022471b92";
            IosDeviceBlockedOnMissingPartnerData                = $False;
            IosEnabled                                          = $False;
            IosMobileApplicationManagementEnabled               = $False;
            LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
            MicrosoftDefenderForEndpointAttachEnabled           = $False;
            PartnerState                                        = "notSetUp";
            PartnerUnresponsivenessThresholdInDays              = 7;
            PartnerUnsupportedOSVersionBlocked                  = $False;
            WindowsDeviceBlockedOnMissingPartnerData            = $False;
            WindowsEnabled                                      = $False;
            Ensure                                              = "Present";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
