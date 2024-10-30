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
        AADFilteringProfile "AADFilteringProfile-My Profile"
        {
            ApplicationId         = $ApplicationId;
            CertificateThumbprint = $CertificateThumbprint;
            Description           = "Description of profile";
            Ensure                = "Present";
            Name                  = "My PRofile";
            Policies              = @(
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 100
                    LoggingState = 'enabled'
                    PolicyName = 'MyPolicyChoseBine'
                    State = 'enabled'
                }
                MSFT_AADFilteringProfilePolicyLink{
                    Priority = 200
                    LoggingState = 'enabled'
                    PolicyName = 'MyTopPolicy'
                    State = 'enabled'
                }
            );
            Priority              = 130; #Drift
            State                 = "enabled";
            TenantId              = $TenantId;
        }
    }
}
