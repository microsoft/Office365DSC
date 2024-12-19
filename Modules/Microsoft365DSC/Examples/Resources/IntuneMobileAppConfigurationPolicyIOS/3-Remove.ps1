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
            Ensure                = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
