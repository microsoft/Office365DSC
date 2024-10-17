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
            Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d"
            Description           = "Microsoft 365 Apps for Windows 10 and laterr"
            DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
            Ensure                = "Present";
            InformationUrl        = "";
            IsFeatured            = $False;
            Notes                 = ""
            PrivacyInformationUrl = ""
            RoleScopeTagIds       = @()
            Assignments          = @(
                MSFT_DeviceManagementMobileAppAssignment{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '42c02b60-f28c-4eef-b3e1-973184cc4a6c'
                    intent = 'required'
                }
            );
            Categories           = @(
                MSFT_DeviceManagementMobileAppCategory {
                    Id  = '8e683524-4ec1-4813-bb3e-6256b2f293d8'
                    DisplayName = 'Productivity'
                });
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
