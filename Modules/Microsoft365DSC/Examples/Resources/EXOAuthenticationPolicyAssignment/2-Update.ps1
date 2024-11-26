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
        EXOAuthenticationPolicy 'ConfigureAuthenticationPolicy'
        {
            Identity                            = "My Assigned Policy"
            AllowBasicAuthActiveSync            = $False
            AllowBasicAuthAutodiscover          = $False
            AllowBasicAuthImap                  = $False
            AllowBasicAuthMapi                  = $False
            AllowBasicAuthOfflineAddressBook    = $False
            AllowBasicAuthOutlookService        = $False
            AllowBasicAuthPop                   = $False
            AllowBasicAuthPowerShell            = $False
            AllowBasicAuthReportingWebServices  = $False
            AllowBasicAuthRpc                   = $False
            AllowBasicAuthSmtp                  = $False
            AllowBasicAuthWebServices           = $False
            Ensure                              = "Present"
            ApplicationId                       = $ApplicationId
            TenantId                            = $TenantId
            CertificateThumbprint               = $CertificateThumbprint
        }
        EXOAuthenticationPolicyAssignment 'ConfigureAuthenticationPolicyAssignment'
        {
            UserName                 = "AdeleV@$TenantId"
            AuthenticationPolicyName = "My Assigned Policy"
            Ensure                   = "Present"
            ApplicationId            = $ApplicationId
            TenantId                 = $TenantId
            CertificateThumbprint    = $CertificateThumbprint
        }
    }
}