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
        IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy "My Account Protection LAPS Policy"
        {
            DisplayName              = "Account Protection LAPS Policy";
            Description              = "My revised description";
            Ensure                   = "Present";
            Assignments              = @(
                MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                }
            );
            BackupDirectory          = "1";
            PasswordAgeDays_AAD      = 10;
            AdministratorAccountName = "Administrator";
            PasswordAgeDays          = 20;
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
