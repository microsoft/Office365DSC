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
        IntuneSecurityBaselineDefenderForEndpoint 'mySecurityBaselineDefenderForEndpoint'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                AllowRealtimeMonitoring = '0' #drift
                BlockWin32APICallsFromOfficeMacros = 'warn'
                CloudBlockLevel = '2'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint
            {
                DisableSafetyFilterOverrideForAppRepUnknown = '1'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
