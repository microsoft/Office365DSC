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

        AADRoleManagementPolicyRule "AADRoleManagementPolicyRule-Expiration_Admin_Eligibility"
        {
            expirationRule       = MSFT_AADRoleManagementPolicyExpirationRule{
                isExpirationRequired = $False
                maximumDuration = 'P180D'
            };
            id                   = "Expiration_Admin_Eligibility";
            roleDisplayName      = "Global Administrator";
            ruleType             = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
