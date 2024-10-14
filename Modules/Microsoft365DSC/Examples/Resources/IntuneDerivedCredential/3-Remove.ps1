<# This example is used to test new resources and showcase the usage of new resources being worked on. It is not meant to use as a production baseline. #>
Configuration Example {
    param(
        [Parameter()]
        [System.String] $ApplicationId,

        [Parameter()]
        [System.String] $TenantId,

        [Parameter()]
        [System.String] $CertificateThumbprint
    )

    Import-DscResource -ModuleName Microsoft365DSC

    node localhost {
        IntuneDerivedCredential "IntuneDerivedCredential-K5"
        {
            DisplayName          = "K5";
            HelpUrl              = "http://www.ff.com/";
            Id                   = "a409d85f-2a49-440d-884a-80fb52a557ab";
            Issuer               = "purebred";
            NotificationType     = "email";
            Ensure               = "Absent";
        }
    }
}
