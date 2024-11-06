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
        IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile "IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile-MyTestEnrollmentProfile"
        {
            AccountId                 = "8d2ac1fd-0ac9-4047-af2f-f1e6323c9a34e";
            ApplicationId             = $ApplicationId;
            CertificateThumbprint     = $CertificateThumbprint;
            ConfigureWifi             = $True;
            Description               = "This is my enrollment profile";
            DisplayName               = "MyTestEnrollmentProfile";
            EnrolledDeviceCount       = 0;
            EnrollmentMode            = "corporateOwnedDedicatedDevice";
            EnrollmentTokenType       = "default";
            EnrollmentTokenUsageCount = 0;
            Ensure                    = "Present";
            IsTeamsDeviceProfile      = $False;
            RoleScopeTagIds           = @("0");
            TenantId                  = $TenantId;
            TokenCreationDateTime     = "10/26/2024 1:02:29 AM";
            TokenExpirationDateTime   = "10/31/2024 3:59:59 AM";
            WifiHidden                = $False;
            WifiSecurityType          = "none";
        }
    }
}
