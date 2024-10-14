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
        IntuneMobileAppsMacOSLobApp "IntuneMobileAppsMacOSLobApp-TeamsForBusinessInstaller"
        {
            Id                    = "8d027f94-0682-431e-97c1-827d1879fa79";
            Description           = "TeamsForBusinessInstaller";
            Developer             = "Contoso";
            DisplayName           = "TeamsForBusinessInstaller";
            Ensure                = "Present";
            InformationUrl        = "";
            IsFeatured            = $False;
            MinimumSupportedOperatingSystem = MSFT_DeviceManagementMinimumOperatingSystem{
                v11_0 = $true
            }
            Notes                 = "";
            Owner                 = "";
            PrivacyInformationUrl = "";
            Publisher             = "Contoso";
            Assignments          = @(
                    MSFT_DeviceManagementMobileAppAssignment {
                        groupDisplayName = 'All devices'
                        deviceAndAppManagementAssignmentFilterType = 'none'
                        dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        intent = 'required'
                    }
                    MSFT_DeviceManagementMobileAppAssignment{
                        deviceAndAppManagementAssignmentFilterType = 'none'
                        dataType = '#microsoft.graph.groupAssignmentTarget'
                        groupId = '57b5e81c-85bb-4644-a4fd-33b03e451c89'
                        intent = 'required'
                    }
                );
            Categories           = @(
                MSFT_DeviceManagementMobileAppCategory {
                    Id  = '1bff2652-03ec-4a48-941c-152e93736515'
                    DisplayName = 'Kajal 3'
                });
        }
    }
}
