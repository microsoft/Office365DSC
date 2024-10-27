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
        AADIdentityAPIConnector 'AADIdentityAPIConnector-TestConnector'
        {
            DisplayName           = "NewTestConnector";
            Id                    = "RestApi_NewTestConnector";
            Username              = "anexas";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString "anexas" -AsPlainText -Force));
            TargetUrl             = "https://graph.microsoft.com";
            Ensure                = "Present"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
