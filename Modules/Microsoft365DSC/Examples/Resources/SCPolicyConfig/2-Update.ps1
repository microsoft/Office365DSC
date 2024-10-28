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
