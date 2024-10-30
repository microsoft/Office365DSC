# SCPolicyConfig

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Accepted value is 'Yes'. | `Yes` |
| **AdvancedClassificationEnabled** | Write | Boolean | TBD | |
| **AuditFileActivity** | Write | Boolean | TBD | |
| **BandwidthLimitEnabled** | Write | Boolean | TBD | |
| **BusinessJustificationList** | Write | MSFT_PolicyConfigBusinessJustificationList[] | TBD | |
| **CloudAppMode** | Write | String | TBD | |
| **CloudAppRestrictionList** | Write | StringArray[] | TBD | |
| **CustomBusinessJustificationNotification** | Write | UInt32 | TBD | |
| **DailyBandwidthLimitInMB** | Write | UInt32 | TBD | |
| **DLPAppGroups** | Write | MSFT_PolicyConfigDLPAppGroups[] | TBD | |
| **DLPNetworkShareGroups** | Write | MSFT_PolicyConfigDLPNetworkShareGroups[] | TBD | |
| **DLPPrinterGroups** | Write | MSFT_PolicyConfigDLPPrinterGroups[] | TBD | |
| **DLPRemovableMediaGroups** | Write | MSFT_PolicyConfigDLPRemovableMediaGroups[] | TBD | |
| **IncludePredefinedUnallowedBluetoothApps** | Write | Boolean | TBD | |
| **MacDefaultPathExclusionsEnabled** | Write | Boolean | TBD | |
| **MacPathExclusion** | Write | StringArray[] | TBD | |
| **NetworkPathEnforcementEnabled** | Write | Boolean | TBD | |
| **NetworkPathExclusion** | Write | String | TBD | |
| **PathExclusion** | Write | StringArray[] | TBD | |
| **serverDlpEnabled** | Write | Boolean | TBD | |
| **EvidenceStoreSettings** | Write | MSFT_PolicyConfigEvidenceStoreSettings | TBD | |
| **SiteGroups** | Write | MSFT_PolicyConfigDLPSiteGroups[] | TBD | |
| **UnallowedApp** | Write | MSFT_PolicyConfigApp[] | TBD | |
| **UnallowedCloudSyncApp** | Write | MSFT_PolicyConfigApp[] | TBD | |
| **UnallowedBluetoothApp** | Write | MSFT_PolicyConfigApp[] | TBD | |
| **UnallowedBrowser** | Write | MSFT_PolicyConfigApp[] | TBD | |
| **QuarantineParameters** | Write | MSFT_PolicyConfigQuarantineParameters | TBD | |
| **VPNSettings** | Write | StringArray[] | TBD | |
| **EnableLabelCoauth** | Write | Boolean | TBD | |
| **EnableSpoAipMigration** | Write | Boolean | TBD | |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_PolicyConfigApp

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Value** | Write | String | Name of the application. | |
| **Executable** | Write | String | Name of the executable file. | |

### MSFT_PolicyConfigStorageAccount

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | TBD | |
| **BlobUri** | Write | String | TBD | |

### MSFT_PolicyConfigSiteGroupAddress

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **MatchType** | Write | String | TBD | |
| **Url** | Write | String | TBD | |
| **AddressLower** | Write | String | TBD | |
| **AddressUpper** | Write | String | TBD | |

### MSFT_PolicyConfigDLPSiteGroups

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | TBD | |
| **Name** | Write | String | TBD | |
| **addresses** | Write | MSFT_PolicyConfigSiteGroupAddress[] | TBD | |

### MSFT_PolicyConfigRemovableMedia

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **deviceId** | Write | String | TBD | |
| **removableMediaVID** | Write | String | TBD | |
| **name** | Write | String | TBD | |
| **alias** | Write | String | TBD | |
| **removableMediaPID** | Write | String | TBD | |
| **instancePathId** | Write | String | TBD | |
| **serialNumberId** | Write | String | TBD | |
| **hardwareId** | Write | String | TBD | |

### MSFT_PolicyConfigDLPRemovableMediaGroups

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **groupName** | Write | String | TBD | |
| **removableMedia** | Write | MSFT_PolicyConfigRemovableMedia[] | TBD | |

### MSFT_PolicyConfigIPRange

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **fromAddress** | Write | String | TBD | |
| **toAddress** | Write | String | TBD | |

### MSFT_PolicyConfigPrinter

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **universalPrinter** | Write | Boolean | TBD | |
| **usbPrinter** | Write | Boolean | TBD | |
| **usbPrinterId** | Write | String | TBD | |
| **name** | Write | String | TBD | |
| **alias** | Write | String | TBD | |
| **usbPrinterVID** | Write | String | TBD | |
| **ipRange** | Write | MSFT_PolicyConfigIPRange | TBD | |
| **corporatePrinter** | Write | Boolean | TBD | |
| **printToLocal** | Write | Boolean | TBD | |
| **printToFile** | Write | Boolean | TBD | |

### MSFT_PolicyConfigDLPNetworkShareGroups

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **groupName** | Write | String | TBD | |
| **groupId** | Write | String | TBD | |
| **networkPaths** | Write | StringArray[] | TBD | |

### MSFT_PolicyConfigDLPApp

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ExecutableName** | Write | String | TBD | |
| **Name** | Write | String | TBD | |
| **Quarantine** | Write | Boolean | TBD | |

### MSFT_PolicyConfigDLPAppGroups

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | TBD | |
| **Name** | Write | String | TBD | |
| **Description** | Write | String | TBD | |
| **Apps** | Write | MSFT_PolicyConfigDLPApp[] | TBD | |

### MSFT_PolicyConfigEvidenceStoreSettings

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **FileEvidenceIsEnabled** | Write | Boolean | TBD | |
| **NumberOfDaysToRetain** | Write | UInt32 | TBD | |
| **StorageAccounts** | Write | MSFT_PolicyConfigStorageAccount[] | TBD | |
| **Store** | Write | String | TBD | |

### MSFT_PolicyConfigBusinessJustificationList

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | TBD | |
| **justificationText** | Write | String | TBD | |
| **Enable** | Write | Boolean | TBD | |

### MSFT_PolicyConfigDLPPrinterGroups

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **groupName** | Write | String | TBD | |
| **groupId** | Write | String | TBD | |
| **printers** | Write | MSFT_PolicyConfigPrinter[] | TBD | |

### MSFT_PolicyConfigQuarantineParameters

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EnableQuarantineForCloudSyncApps** | Write | Boolean | TBD | |
| **QuarantinePath** | Write | String | TBD | |
| **MacQuarantinePath** | Write | String | TBD | |
| **ShouldReplaceFile** | Write | Boolean | TBD | |
| **FileReplacementText** | Write | String | TBD | |


## Description

Configures the Data Loss Prevention settings in Purview.

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
        SCPolicyConfig "SCPolicyConfig"
        {
            AdvancedClassificationEnabled           = $True;
            ApplicationId                           = $ApplicationId;
            AuditFileActivity                       = $False;
            BandwidthLimitEnabled                   = $False;
            BusinessJustificationList               = @(
                MSFT_PolicyConfigBusinessJustificationList
                {
                    Id                = 'businessJustification1'
                    Enable            = $True
                    justificationText = 'default:Were'
                }
                MSFT_PolicyConfigBusinessJustificationList
                {
                    Id                = 'businessJustification2'
                    Enable            = $True
                    justificationText = 'default:Not'
                }
                MSFT_PolicyConfigBusinessJustificationList
                {
                    Id                = 'businessJustification3'
                    Enable            = $True
                    justificationText = 'default:Going'
                }
                MSFT_PolicyConfigBusinessJustificationList
                {
                    Id                = 'businessJustification4'
                    Enable            = $True
                    justificationText = 'default:To'
                }
                MSFT_PolicyConfigBusinessJustificationList
                {
                    Id                = 'businessJustification5'
                    Enable            = $True
                    justificationText = 'default:Take It'
                }
            );
            CertificateThumbprint                   = $CertificateThumbprint;
            CloudAppMode                            = "Block";
            CloudAppRestrictionList                 = @("contoso.net","contoso.com");
            CustomBusinessJustificationNotification = 3;
            DailyBandwidthLimitInMB                 = 0;
            DLPAppGroups                            = @(
                MSFT_PolicyConfigDLPAppGroups
                {
                    Name        = 'Maracas'
                    Id          = '5c124091-bb75-4d20-9c09-b00d584c6270'
                    Description = 'Lacucaracha'
                    Apps = @(
                        MSFT_PolicyConfigDLPApp
                        {
                            ExecutableName    = 'toc.exe'
                            Name              = 'toctoctoc'
                            Quarantine        = $False
                        }
                    )
                }
            );
            DLPNetworkShareGroups                   = @(
                MSFT_PolicyConfigDLPNetworkShareGroups
                {
                    groupName    = 'Network Share Group'
                    networkPaths = @('\\share2','\\share')
                }
            );
            DLPPrinterGroups                        = @(
                MSFT_PolicyConfigDLPPrinterGroups
                {
                    groupName    = 'MyGroup'
                    groupId      = '928f8844-80af-4740-b563-232b33b29f5d'
                    printers = @(
                        MSFT_PolicyConfigPrinter
                        {
                            universalPrinter = $False
                            usbPrinter       = $True
                            usbPrinterId     = ''
                            name             = 'asdf'
                            alias            = 'aasdf'
                            usbPrinterVID    = ''
                            ipRange          = MSFT_PolicyConfigIPRange
                                {
                                    fromAddress = ''
                                    toAddress   = ''
                                }
                            corporatePrinter = $False
                            printToLocal     = $False
                            printToFile      = $False
                        }
                    )
                }
            );
            DLPRemovableMediaGroups                 = @(
                MSFT_PolicyConfigDLPRemovableMediaGroups
                {
                    groupName = 'My Removable USB device group'
                    removablemedia    = @(
                        MSFT_PolicyConfigRemovableMedia
                        {
                            deviceId          = 'Nik'
                            removableMediaVID = 'bob'
                            name              = 'MaCles'
                            alias             = 'My Device'
                            removableMediaPID = 'asdfsd'
                            instancePathId    = 'instance path'
                            serialNumberId    = 'asdf'
                            hardwareId        = 'hardware'
                        }
                    )
                }
            );
            EnableLabelCoauth                       = $False;
            EnableSpoAipMigration                   = $False;
            EvidenceStoreSettings                   = MSFT_PolicyConfigEvidenceStoreSettings
                {
                    FileEvidenceIsEnabled = $True
                    NumberOfDaysToRetain  = 7
                    StorageAccounts       = @(
                        MSFT_PolicyConfigStorageAccount
                        {
                            Name    = 'My storage'
                            BlobUri = 'https://contoso.com'
                        }
                        MSFT_PolicyConfigStorageAccount
                        {
                            Name    = 'My 2nd storage'
                            BlobUri = 'https://coucou.com'
                        }
                    )
                    Store                 = 'CustomerManaged'
                };
            IncludePredefinedUnallowedBluetoothApps = $True;
            IsSingleInstance                        = "Yes";
            MacDefaultPathExclusionsEnabled         = $True;
            MacPathExclusion                        = @("/pear","/apple","/orange");
            NetworkPathEnforcementEnabled           = $True;
            NetworkPathExclusion                    = "\\MyFirstPath:\\MySecondPath:\\MythirdPAth";
            PathExclusion                           = @("\\includemenot","\\excludemeWindows","\\excludeme3");
            QuarantineParameters                    = MSFT_PolicyConfigQuarantineParameters
                {
                    EnableQuarantineForCloudSyncApps = $False
                    QuarantinePath                   = '%homedrive%%homepath%\Microsoft DLP\Quarantine'
                    MacQuarantinePath                = '/System/Applications/Microsoft DLP/QuarantineMA'
                    ShouldReplaceFile                = $True
                    FileReplacementText              = 'Gargamel'
                }
            serverDlpEnabled                        = $True;
            SiteGroups                              = @(
                MSFT_PolicyConfigDLPSiteGroups
                {
                    Id        = 'cfa0d856-4dc9-4497-b0aa-93584e919a83'
                    Name      = 'Whatever'
                    Addresses = @(
                        MSFT_PolicyConfigSiteGroupAddress
                        {
                            MatchType    = 'UrlMatch'
                            Url          = 'Karakette.com'
                            AddressLower = ''
                            AddressUpper = ''
                        }
                    )
                }
            );
            TenantId                                = $TenantId;
            UnallowedApp                            = @(
                MSFT_PolicyConfigApp
                {
                    Value        = 'Caramel'
                    Executable   = 'cara.exe'
                }
                MSFT_PolicyConfigApp
                {
                    Value        = 'Fudge'
                    Executable   = 'chocolate.exe'
                }
            );
            UnallowedBluetoothApp                   = @(
                MSFT_PolicyConfigApp
                {
                    Value        = 'bluetooth'
                    Executable   = 'micase.exe'
                }
                MSFT_PolicyConfigApp
                {
                    Value        = 'marmelade'
                    Executable   = 'julia.exe'
                }
            );
            UnallowedBrowser                        = @(
                MSFT_PolicyConfigApp
                {
                    Value        = 'UC Browser'
                    Executable   = 'ucbrowser.exe'
                }
                MSFT_PolicyConfigApp
                {
                    Value        = 'CapitainOS'
                    Executable   = 'captn.exe'
                }
            );
            UnallowedCloudSyncApp                   = @(
                MSFT_PolicyConfigApp
                {
                    Value        = 'ikochou'
                    Executable   = 'gillex.msi'
                }
                MSFT_PolicyConfigApp
                {
                    Value        = 'johny'
                    Executable   = 'boo.msi'
                }
            );
            VPNSettings                             = @("MyVPNAddress","MySecondVPNAddress");
        }
    }
}
```

