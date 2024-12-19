<#
This example creates a new Intune Mobile App Configuration Policy for iOs devices
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
    Import-DscResource -ModuleName 'Microsoft365DSC'

    Node localhost
    {
        IntuneMobileAppConfigurationPolicyIOS "ConfigureIntuneMobileAppConfigurationPolicyIOS"
        {
            Description           = "IntuneMobileAppConfigurationPolicyIOS Description";
            DisplayName           = "IntuneMobileAppConfigurationPolicyIOS DisplayName"; 
            Ensure                = "Present";
            settings              = @(
                MSFT_appConfigurationSettingItem{
                    appConfigKey = 'ConfigKey1' 
                    appConfigKeyType = 'stringType'
                    appConfigKeyValue = 'KeyValue1 updated' #updated property
                }
                MSFT_appConfigurationSettingItem{
                    appConfigKey = 'ConfigKey2'
                    appConfigKeyType = 'stringType'
                    appConfigKeyValue = 'keyValue2'
                }
            );
            targetedMobileApps    = @("06131066-8adf-42a9-86aa-e4b59e27da5d");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
