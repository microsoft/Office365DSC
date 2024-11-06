# IntuneAppleMDMPushNotificationCertificate

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AppleIdentifier** | Key | String | The name of the Apple Identifier. | |
| **Certificate** | Write | String | The Apple Push notification certificate. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DataSharingConsetGranted** | Write | Boolean | The boolean indicating DataSharing Conset agreement granted or not between Intune and Apple. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures a resource for Apple MDM Push notification certificate used for device enrollment.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - DeviceManagementManagedDevices.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - DeviceManagementManagedDevices.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - DeviceManagementManagedDevices.ReadWrite.All, DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            AppleIdentifier          = "Apple ID";
	        Certificate 	         = "FakeCertMIIFdjCCBF6gAwIBAgIIMVIk4qQ3QnQwDQYJKoZIhvcNAQELBQAwgYwxQDA+BgNVBAMMN0FwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIDIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0yNDEwMjUxODE0NThaFw0yNTEwMjUxODE0NTdaMIGPMUwwSgYKCZImiZPyLGQBAQw8Y29tLmFwcGxlLm1nbXQuRXh0ZXJuYWwuMDA1NWU3ZTktNDkyYi00ZDQ2LTk2N2EtMjhmYzVkNDllZGI2MTIwMAYDVQQDDClBUFNQOjAwNTVlN2U5LTQ5MmItNGQ0Ni05NjdhLTI4ZmM1ZDQ5ZWRiNjELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrEk6ojXS2lXZCW0P6Wtkv36ko7E1pDlu90IbKN+tesevGhghARFrGNJaRnCjjh7m430KMx2HmwuH08VHpevne2ANdSBOgbVD/8tbkfLN4GeO7Z+E0O5WvEKJ0h0IloV4PjhfZm367n7WDBGmAEXp/aUU91TDIGvAlwUB6M/s7WDypfKenpU7VI7BBNHOn/LwaeNyyTsr8/bn+D7CRDPb6UBYPc5wyQoEjgEjByprUB4qkICfjjvDqg0S+x/gkk4U6QDhjFcUb439EpUyUhbYFH/Opjq5uJ22xueTX3FLQII6ZFoPcC/NJLpwdEDGOOHEHb62ahrwTxzYNGoOG5v/NAgMBAAGjggHVMIIB0TAJBgNVHRMEAjAAMB8GA1UdIwQYMBaAFPe+fCFgkds9G3vYOjKBad+ebH+bMIIBHAYDVR0gBIIBEzCCAQ8wggELBgkqhkiG92NkBQEwgf0wgcMGCCsGAQUFBwICMIG2DIGzUmVsaWFuY2Ugb24gdGhpcyBjZXJ0aWZpY2F0ZSBieSBhbnkgcGFydHkgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIHRoZSB0aGVuIGFwcGxpY2FibGUgc3RhbmRhcmQgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgdXNlLCBjZXJ0aWZpY2F0ZSBwb2xpY3kgYW5kIGNlcnRpZmljYXRpb24gcHJhY3RpY2Ugc3RhdGVtZW50cy4wNQYIKwYBBQUHAgEWKWh0dHA6Ly93d3cuYXBwbGUuY29tL2NlcnRpZmljYXRlYXV0aG9yaXR5MBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuYXBwbGUuY29tL2FhaTJjYS5jcmwwHQYDVR0OBBYEFE1pV3J04vJkpwqxzg040WR6U/7IMAsGA1UdDwQEAwIHgDAQBgoqhkiG92NkBgMCBAIFADANBgkqhkiG9w0BAQsFAAOCAQEAPVKFj5stCpsUT+lcC36hzR2wh8/fys/QFNFuFn57x4oe9kBvvyAXqLBhPm/J3lC+0oU/AJf3EYXwTGNxo2gCiPhJcomX3WXnbYrZHU/TH8umhtVgGqd6Xlke9iFwypidHC9dHWmwud4V42oAMZ9FHItSwh5o6rQMoZop7uKD72vxSuunEWFymF9S22DJ0oums1Ya8JmUpNfMzkyGVMMZs1OCYpzQxYpuwC+sMAVfGucp1IRLutccRGYeSV4LTN4CwfWreCPnPGjkBEmGqmusn5t/THirGjRBykUARWFpthx1wmJqHFqeAv4nhbcR/+Fu4gQQQaayX0dauBcU0T57==";
            DataSharingConsetGranted = $True;

            Ensure                   = "Present";
            ApplicationId            = $ApplicationId;
            TenantId                 = $TenantId;
            CertificateThumbprint    = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            AppleIdentifier       = "Patched cert"; #drift
	        Certificate 	      = "PatchedFakeCertMIIFdjCCBF6gAwIBAgIIMVIk4qQ3QnQwDQYJKoZIhvcNAQELBQAwgYwxQDA+BgNVBAMMN0FwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIDIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0yNDEwMjUxODE0NThaFw0yNTEwMjUxODE0NTdaMIGPMUwwSgYKCZImiZPyLGQBAQw8Y29tLmFwcGxlLm1nbXQuRXh0ZXJuYWwuMDA1NWU3ZTktNDkyYi00ZDQ2LTk2N2EtMjhmYzVkNDllZGI2MTIwMAYDVQQDDClBUFNQOjAwNTVlN2U5LTQ5MmItNGQ0Ni05NjdhLTI4ZmM1ZDQ5ZWRiNjELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrEk6ojXS2lXZCW0P6Wtkv36ko7E1pDlu90IbKN+tesevGhghARFrGNJaRnCjjh7m430KMx2HmwuH08VHpevne2ANdSBOgbVD/8tbkfLN4GeO7Z+E0O5WvEKJ0h0IloV4PjhfZm367n7WDBGmAEXp/aUU91TDIGvAlwUB6M/s7WDypfKenpU7VI7BBNHOn/LwaeNyyTsr8/bn+D7CRDPb6UBYPc5wyQoEjgEjByprUB4qkICfjjvDqg0S+x/gkk4U6QDhjFcUb439EpUyUhbYFH/Opjq5uJ22xueTX3FLQII6ZFoPcC/NJLpwdEDGOOHEHb62ahrwTxzYNGoOG5v/NAgMBAAGjggHVMIIB0TAJBgNVHRMEAjAAMB8GA1UdIwQYMBaAFPe+fCFgkds9G3vYOjKBad+ebH+bMIIBHAYDVR0gBIIBEzCCAQ8wggELBgkqhkiG92NkBQEwgf0wgcMGCCsGAQUFBwICMIG2DIGzUmVsaWFuY2Ugb24gdGhpcyBjZXJ0aWZpY2F0ZSBieSBhbnkgcGFydHkgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIHRoZSB0aGVuIGFwcGxpY2FibGUgc3RhbmRhcmQgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgdXNlLCBjZXJ0aWZpY2F0ZSBwb2xpY3kgYW5kIGNlcnRpZmljYXRpb24gcHJhY3RpY2Ugc3RhdGVtZW50cy4wNQYIKwYBBQUHAgEWKWh0dHA6Ly93d3cuYXBwbGUuY29tL2NlcnRpZmljYXRlYXV0aG9yaXR5MBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuYXBwbGUuY29tL2FhaTJjYS5jcmwwHQYDVR0OBBYEFE1pV3J04vJkpwqxzg040WR6U/7IMAsGA1UdDwQEAwIHgDAQBgoqhkiG92NkBgMCBAIFADANBgkqhkiG9w0BAQsFAAOCAQEAPVKFj5stCpsUT+lcC36hzR2wh8/fys/QFNFuFn57x4oe9kBvvyAXqLBhPm/J3lC+0oU/AJf3EYXwTGNxo2gCiPhJcomX3WXnbYrZHU/TH8umhtVgGqd6Xlke9iFwypidHC9dHWmwud4V42oAMZ9FHItSwh5o6rQMoZop7uKD72vxSuunEWFymF9S22DJ0oums1Ya8JmUpNfMzkyGVMMZs1OCYpzQxYpuwC+sMAVfGucp1IRLutccRGYeSV4LTN4CwfWreCPnPGjkBEmGqmusn5t/THirGjRBykUARWFpthx1wmJqHFqeAv4nhbcR/+Fu4gQQQaayX0dauBcU0T57=="; #drift

            Ensure                = "Present";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            AppleIdentifier       = "AppleID";
	        Certificate 	      = "";

            Ensure                = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

