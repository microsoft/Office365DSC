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
        IntuneAccountProtectionPolicyWindows10 'myAccountProtectionPolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 10
                EnablePinRecovery = 'true'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10
            {
                History = 20
                EnablePinRecovery = 'true'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
