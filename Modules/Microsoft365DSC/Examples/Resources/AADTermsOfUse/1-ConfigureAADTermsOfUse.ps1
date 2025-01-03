<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $credsGlobalAdmin
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        AADTermsOfUse 'AADTermsOfUse'
        {
            DisplayName                       = "ToU general 2";
            Files                             = @(
				MSFT_MicrosoftGraphagreementfilelocalization{
					Id = '041b18d7-a318-4d88-abb1-000000000000'
					FileName = 'patch-file.pdf'
					CreatedDateTime = '06/15/2022 17:50:57'
					Language = 'en-GB'
					Versions = @(
						MSFT_MicrosoftGraphagreementfileversion{
							Id = '041b18d7-a318-4d88-abb1-000000000000'
							FileData = MSFT_MicrosoftGraphagreementfiledata{
								data = 'SGVsbG8gd29ybGQ=//truncated-binary'
							}
						}
					)
					DisplayName = 'File uploaded via resource'
				}
			);
            Id                                = "9213cf0b-afbf-4397-b7cb-000000000000";
            IsPerDeviceAcceptanceRequired     = $False;
            IsViewingBeforeAcceptanceRequired = $True;
            Ensure                            = "Present"
            Credential                        = $credsGlobalAdmin
        }
    }
}
