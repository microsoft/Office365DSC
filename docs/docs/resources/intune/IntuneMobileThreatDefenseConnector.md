# IntuneMobileThreatDefenseConnector

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
| **DisplayName** | Write | String | The DisplayName of the Mobile Threat Defense Connector partner. NOTE: Hard coded for convenience, not returned by the Graph API. | |
| **AllowPartnerToCollectIosApplicationMetadata** | Write | Boolean | When TRUE, indicates the Mobile Threat Defense partner may collect metadata about installed applications from Intune for IOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about installed applications from Intune for IOS devices. Default value is FALSE. | |
| **AllowPartnerToCollectIosPersonalApplicationMetadata** | Write | Boolean | When TRUE, indicates the Mobile Threat Defense partner may collect metadata about personally installed applications from Intune for IOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about personally installed applications from Intune for IOS devices. Default value is FALSE. | |
| **AndroidDeviceBlockedOnMissingPartnerData** | Write | Boolean | For Android, set whether Intune must receive data from the Mobile Threat Defense partner prior to marking a device compliant. | |
| **AndroidEnabled** | Write | Boolean | For Android, set whether data from the Mobile Threat Defense partner should be used during compliance evaluations. | |
| **AndroidMobileApplicationManagementEnabled** | Write | Boolean | When TRUE, indicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for Android devices. When FALSE, indicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for Android devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE. | |
| **IosDeviceBlockedOnMissingPartnerData** | Write | Boolean | For IOS, set whether Intune must receive data from the Mobile Threat Defense partner prior to marking a device compliant. | |
| **IosEnabled** | Write | Boolean | For IOS, get or set whether data from the Mobile Threat Defense partner should be used during compliance evaluations. | |
| **IosMobileApplicationManagementEnabled** | Write | Boolean | When TRUE, indicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for IOS devices. When FALSE, indicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for IOS devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE. | |
| **LastHeartbeatDateTime** | Write | DateTime | DateTime of last Heartbeat received from the Mobile Threat Defense partner. | |
| **MicrosoftDefenderForEndpointAttachEnabled** | Write | Boolean | When TRUE, indicates that configuration profile management via Microsoft Defender for Endpoint is enabled. When FALSE, inidicates that configuration profile management via Microsoft Defender for Endpoint is disabled. Default value is FALSE. | |
| **PartnerState** | Write | String | Partner state of this tenant. | |
| **PartnerUnresponsivenessThresholdInDays** | Write | UInt32 | Get or Set days the per tenant tolerance to unresponsiveness for this partner integration. | |
| **PartnerUnsupportedOSVersionBlocked** | Write | Boolean | Get or set whether to block devices on the enabled platforms that do not meet the minimum version requirements of the Mobile Threat Defense partner. | |
| **WindowsDeviceBlockedOnMissingPartnerData** | Write | Boolean | When TRUE, indicates that Intune must receive data from the Mobile Threat Defense partner prior to marking a device compliant for Windows. When FALSE, indicates that Intune may make a device compliant without receiving data from the Mobile Threat Defense partner for Windows. Default value is FALSE. | |
| **WindowsEnabled** | Write | Boolean | When TRUE, indicates that data from the Mobile Threat Defense partner can be used during compliance evaluations for Windows. When FALSE, it indicates that data from the Mobile Threat Defense partner should not be used during compliance evaluations for Windows. Default value is FALSE. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

This resource configures a connection to Mobile Threat Defense partner.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - DeviceManagementServiceConfig.Read.All

- **Update**

    - DeviceManagementServiceConfig.ReadWrite.All

#### Application permissions

- **Read**

    - DeviceManagementServiceConfig.Read.All

- **Update**

    - DeviceManagementServiceConfig.ReadWrite.All

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
        IntuneMobileThreatDefenseConnector "IntuneMobileThreatDefenseConnector-Microsoft Defender for Endpoint"
        {
            AllowPartnerToCollectIosApplicationMetadata         = $False;
            AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
            AndroidDeviceBlockedOnMissingPartnerData            = $False;
            AndroidEnabled                                      = $False;
            AndroidMobileApplicationManagementEnabled           = $False;
            DisplayName                                         = "Microsoft Defender for Endpoint";
            Id                                                  = "fc780465-2017-40d4-a0c5-307022471b92";
            IosDeviceBlockedOnMissingPartnerData                = $False;
            IosEnabled                                          = $False;
            IosMobileApplicationManagementEnabled               = $False;
            LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
            MicrosoftDefenderForEndpointAttachEnabled           = $False;
            PartnerState                                        = "notSetUp";
            PartnerUnresponsivenessThresholdInDays              = 7;
            PartnerUnsupportedOSVersionBlocked                  = $False;
            WindowsDeviceBlockedOnMissingPartnerData            = $False;
            WindowsEnabled                                      = $False;
            Ensure                                              = "Present";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
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
        IntuneMobileThreatDefenseConnector "IntuneMobileThreatDefenseConnector-Microsoft Defender for Endpoint"
        {
            AllowPartnerToCollectIosApplicationMetadata         = $False;
            AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
            AndroidDeviceBlockedOnMissingPartnerData            = $False;
            AndroidEnabled                                      = $True; #drift
            AndroidMobileApplicationManagementEnabled           = $False;
            DisplayName                                         = "Microsoft Defender for Endpoint";
            Id                                                  = "fc780465-2017-40d4-a0c5-307022471b92";
            IosDeviceBlockedOnMissingPartnerData                = $False;
            IosEnabled                                          = $False;
            IosMobileApplicationManagementEnabled               = $False;
            LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
            MicrosoftDefenderForEndpointAttachEnabled           = $False;
            PartnerState                                        = "notSetUp";
            PartnerUnresponsivenessThresholdInDays              = 7;
            PartnerUnsupportedOSVersionBlocked                  = $False;
            WindowsDeviceBlockedOnMissingPartnerData            = $False;
            WindowsEnabled                                      = $False;
            Ensure                                              = "Present";
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
        IntuneMobileThreatDefenseConnector "IntuneMobileThreatDefenseConnector-Microsoft Defender for Endpoint"
        {
            AllowPartnerToCollectIosApplicationMetadata         = $False;
            AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
            AndroidDeviceBlockedOnMissingPartnerData            = $False;
            AndroidEnabled                                      = $False;
            AndroidMobileApplicationManagementEnabled           = $False;
            DisplayName                                         = "Microsoft Defender for Endpoint";
            Id                                                  = "fc780465-2017-40d4-a0c5-307022471b92";
            IosDeviceBlockedOnMissingPartnerData                = $False;
            IosEnabled                                          = $False;
            IosMobileApplicationManagementEnabled               = $False;
            LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
            MicrosoftDefenderForEndpointAttachEnabled           = $False;
            PartnerState                                        = "notSetUp";
            PartnerUnresponsivenessThresholdInDays              = 7;
            PartnerUnsupportedOSVersionBlocked                  = $False;
            WindowsDeviceBlockedOnMissingPartnerData            = $False;
            WindowsEnabled                                      = $False;
            Ensure                                              = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

