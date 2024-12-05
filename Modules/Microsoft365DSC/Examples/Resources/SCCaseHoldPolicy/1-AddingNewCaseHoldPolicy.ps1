<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param
    (
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
        SCCaseHoldPolicy 'CaseHoldPolicy'
        {
            Case                  = 'Test Case'
            ExchangeLocation      = 'DemoGroup@contoso.onmicrosoft.com'
            Name                  = 'Demo Hold'
            PublicFolderLocation  = 'All'
            Comment               = 'This is a demo'
            Enabled               = $True
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
