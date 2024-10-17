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
        IntuneSecurityBaselineMicrosoft365AppsForEnterprise 'mySecurityBaselineMicrosoft365AppsForEnterprisePolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                L_ProtectionFromZoneElevation = '1'
                L_grooveexe98 = '1'
                L_excelexe99 = '1'
                L_mspubexe100 = '1'
                L_powerpntexe101 = '1'
                L_pptviewexe102 = '1'
                L_visioexe103 = '1'
                L_winprojexe104 = '1'
                L_winwordexe105 = '1'
                L_outlookexe106 = '1'
                L_spdesignexe107 = '1'
                L_exprwdexe108 = '1'
                L_msaccessexe109 = '1'
                L_onenoteexe110 = '1'
                L_mse7exe111 = '1'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty = '3'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
