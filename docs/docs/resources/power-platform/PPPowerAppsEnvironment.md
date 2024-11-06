# PPPowerAppsEnvironment

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name for the PowerApps environment | |
| **Location** | Required | String | Location of the PowerApps environment. | `canada`, `unitedstates`, `europe`, `asia`, `australia`, `india`, `japan`, `unitedkingdom`, `unitedstatesfirstrelease`, `southamerica`, `france`, `usgov`, `unitedarabemirates`, `germany`, `switzerland`, `norway`, `korea`, `southafrica` |
| **EnvironmentSKU** | Required | String | Environment type. | `Production`, `Standard`, `Trial`, `Sandbox`, `SubscriptionBasedTrial`, `Teams`, `Developer` |
| **ProvisionDatabase** | Write | Boolean | The switch to provision a Dataverse database when creating the environment. If set, LanguageName and CurrencyName are mandatory to pass as arguments. | |
| **LanguageName** | Write | String | The default languages for the database, use Get-AdminPowerAppCdsDatabaseLanguages to get the support values. | `1033`, `1025`, `1069`, `1026`, `1027`, `3076`, `2052`, `1028`, `1050`, `1029`, `1030`, `1043`, `1061`, `1035`, `1036`, `1110`, `1031`, `1032`, `1037`, `1081`, `1038`, `1040`, `1041`, `1087`, `1042`, `1062`, `1063`, `1044`, `1045`, `1046`, `2070`, `1048`, `1049`, `2074`, `1051`, `1060`, `3082`, `1053`, `1054`, `1055`, `1058`, `1066`, `3098`, `1086`, `1057` |
| **CurrencyName** | Write | String | The default currency for the database, use Get-AdminPowerAppCdsDatabaseCurrencies to get the supported values. | `KZT`, `ZAR`, `ETB`, `AED`, `BHD`, `DZD`, `EGP`, `IQD`, `JOD`, `KWD`, `LBP`, `LYD`, `MAD`, `OMR`, `QAR`, `SAR`, `SYP`, `TND`, `YER`, `CLP`, `INR`, `AZN`, `RUB`, `BYN`, `BGN`, `NGN`, `BDT`, `CNY`, `EUR`, `BAM`, `USD`, `CZK`, `GBP`, `DKK`, `CHF`, `MVR`, `BTN`, `XCD`, `AUD`, `BZD`, `CAD`, `HKD`, `IDR`, `JMD`, `MYR`, `NZD`, `PHP`, `SGD`, `TTD`, `XDR`, `ARS`, `BOB`, `COP`, `CRC`, `CUP`, `DOP`, `GTQ`, `HNL`, `MXN`, `NIO`, `PAB`, `PEN`, `PYG`, `UYU`, `VES`, `IRR`, `XOF`, `CDF`, `XAF`, `HTG`, `ILS`, `HUF`, `AMD`, `ISK`, `JPY`, `GEL`, `KHR`, `KRW`, `KGS`, `LAK`, `MKD`, `MNT`, `BND`, `MMK`, `NOK`, `NPR`, `PKR`, `PLN`, `AFN`, `BRL`, `MDL`, `RON`, `RWF`, `SEK`, `LKR`, `SOS`, `ALL`, `RSD`, `KES`, `TJS`, `THB`, `ERN`, `TMT`, `BWP`, `TRY`, `UAH`, `UZS`, `VND`, `MOP`, `TWD` |
| **Ensure** | Write | String | Only accepted value is 'Present'. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Power Platform Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |


## Description

This resources configures the PowerApps Environment.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - None

- **Update**

    - None

#### Application permissions

- **Read**

    - None

- **Update**

    - None

## Examples

### Example 1

This example creates a new PowerApps environment in production.

```powershell
Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credscredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        PPPowerAppsEnvironment 'PowerAppsDemoEnvironment'
        {
            DisplayName        = "My Demo Environment"
            EnvironmentSKU     = "Production"
            Location           = "canada"
            Ensure             = "Present"
            Credential         = $Credscredential
        }
    }
}
```

