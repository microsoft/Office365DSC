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
        AzureBillingAccountsRoleAssignment "AzureBillingAccountsRoleAssignment"
        {
            ApplicationId         = $ApplicationId;
            BillingAccount        = "MyTestAccount";
            CertificateThumbprint = $CertificateThumbprint;
            Ensure                = "Absent";
            PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
            PrincipalType         = "User";
            PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
            RoleDefinition        = "Billing account owner";
            TenantId              = $TenantId;
        }
    }
}
