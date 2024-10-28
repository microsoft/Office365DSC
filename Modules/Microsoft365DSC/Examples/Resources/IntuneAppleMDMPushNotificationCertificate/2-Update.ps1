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
        IntuneAppleMDMPushNotificationCertificate "IntuneAppleMDMPushNotificationCertificate-66f4ec83-754f-4a59-a73d-e3182cc636a5"
        {
            AppleIdentifier         = "Patched cert"; #drift
	        Certificate 	= "PatchedFakeCertMIIFdjCCBF6gAwIBAgIIMVIk4qQ3QnQwDQYJKoZIhvcNAQELBQAwgYwxQDA+BgNVBAMMN0FwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIDIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0yNDEwMjUxODE0NThaFw0yNTEwMjUxODE0NTdaMIGPMUwwSgYKCZImiZPyLGQBAQw8Y29tLmFwcGxlLm1nbXQuRXh0ZXJuYWwuMDA1NWU3ZTktNDkyYi00ZDQ2LTk2N2EtMjhmYzVkNDllZGI2MTIwMAYDVQQDDClBUFNQOjAwNTVlN2U5LTQ5MmItNGQ0Ni05NjdhLTI4ZmM1ZDQ5ZWRiNjELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrEk6ojXS2lXZCW0P6Wtkv36ko7E1pDlu90IbKN+tesevGhghARFrGNJaRnCjjh7m430KMx2HmwuH08VHpevne2ANdSBOgbVD/8tbkfLN4GeO7Z+E0O5WvEKJ0h0IloV4PjhfZm367n7WDBGmAEXp/aUU91TDIGvAlwUB6M/s7WDypfKenpU7VI7BBNHOn/LwaeNyyTsr8/bn+D7CRDPb6UBYPc5wyQoEjgEjByprUB4qkICfjjvDqg0S+x/gkk4U6QDhjFcUb439EpUyUhbYFH/Opjq5uJ22xueTX3FLQII6ZFoPcC/NJLpwdEDGOOHEHb62ahrwTxzYNGoOG5v/NAgMBAAGjggHVMIIB0TAJBgNVHRMEAjAAMB8GA1UdIwQYMBaAFPe+fCFgkds9G3vYOjKBad+ebH+bMIIBHAYDVR0gBIIBEzCCAQ8wggELBgkqhkiG92NkBQEwgf0wgcMGCCsGAQUFBwICMIG2DIGzUmVsaWFuY2Ugb24gdGhpcyBjZXJ0aWZpY2F0ZSBieSBhbnkgcGFydHkgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIHRoZSB0aGVuIGFwcGxpY2FibGUgc3RhbmRhcmQgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgdXNlLCBjZXJ0aWZpY2F0ZSBwb2xpY3kgYW5kIGNlcnRpZmljYXRpb24gcHJhY3RpY2Ugc3RhdGVtZW50cy4wNQYIKwYBBQUHAgEWKWh0dHA6Ly93d3cuYXBwbGUuY29tL2NlcnRpZmljYXRlYXV0aG9yaXR5MBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuYXBwbGUuY29tL2FhaTJjYS5jcmwwHQYDVR0OBBYEFE1pV3J04vJkpwqxzg040WR6U/7IMAsGA1UdDwQEAwIHgDAQBgoqhkiG92NkBgMCBAIFADANBgkqhkiG9w0BAQsFAAOCAQEAPVKFj5stCpsUT+lcC36hzR2wh8/fys/QFNFuFn57x4oe9kBvvyAXqLBhPm/J3lC+0oU/AJf3EYXwTGNxo2gCiPhJcomX3WXnbYrZHU/TH8umhtVgGqd6Xlke9iFwypidHC9dHWmwud4V42oAMZ9FHItSwh5o6rQMoZop7uKD72vxSuunEWFymF9S22DJ0oums1Ya8JmUpNfMzkyGVMMZs1OCYpzQxYpuwC+sMAVfGucp1IRLutccRGYeSV4LTN4CwfWreCPnPGjkBEmGqmusn5t/THirGjRBykUARWFpthx1wmJqHFqeAv4nhbcR/+Fu4gQQQaayX0dauBcU0T57=="; #drift

            Ensure                  = "Present";
            ApplicationId           = $ConfigurationData.NonNodeData.ApplicationId;
            TenantId                = $OrganizationName;
        }
    }
}
