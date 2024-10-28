function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AdvancedClassificationEnabled,

        [Parameter()]
        [System.Boolean]
        $AuditFileActivity,

        [Parameter()]
        [System.Boolean]
        $BandwidthLimitEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BusinessJustificationList,

        [Parameter()]
        [System.String]
        $CloudAppMode,

        [Parameter()]
        [System.String[]]
        $CloudAppRestrictionList,

        [Parameter()]
        [System.UInt32]
        $CustomBusinessJustificationNotification,

        [Parameter()]
        [System.UInt32]
        $DailyBandwidthLimitInMB,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPAppGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPNetworkShareGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPPrinterGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPRemovableMediaGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EvidenceStoreSettings,

        [Parameter()]
        [System.Boolean]
        $IncludePredefinedUnallowedBluetoothApps,

        [Parameter()]
        [System.Boolean]
        $MacDefaultPathExclusionsEnabled,

        [Parameter()]
        [System.String[]]
        $MacPathExclusion,

        [Parameter()]
        [System.Boolean]
        $NetworkPathEnforcementEnabled,

        [Parameter()]
        [System.String]
        $NetworkPathExclusion,

        [Parameter()]
        [System.String[]]
        $PathExclusion,

        [Parameter()]
        [System.Boolean]
        $serverDlpEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $SiteGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedCloudSyncApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBluetoothApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBrowser,

        [Parameter()]
        [System.String[]]
        $VPNSettings,

        [Parameter()]
        [System.Boolean]
        $EnableLabelCoauth,

        [Parameter()]
        [System.Boolean]
        $EnableSpoAipMigration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $QuarantineParameters,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters | Out-Null

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullResult = $PSBoundParameters
    try
    {
        $instance = Get-PolicyConfig -ErrorAction Stop
        $EndpointDlpGlobalSettingsValue = ConvertFrom-Json $instance.EndpointDlpGlobalSettings
        $DlpPrinterGroupsObject = ConvertFrom-Json $instance.DlpPrinterGroups
        $DlpAppGroupsObject = ConvertFrom-Json $instance.DlpAppGroups
        $SiteGroupsObject = ConvertFrom-Json $instance.SiteGroups
        $DLPRemovableMediaGroupsObject = ConvertFrom-Json $instance.DLPRemovableMediaGroups
        $DlpNetworkShareGroupsObject = ConvertFrom-Json $instance.DlpNetworkShareGroups

        # AdvancedClassificationEnabled
        $AdvancedClassificationEnabledValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'AdvancedClassificationEnabled'}).Value

        # BandwidthLimitEnabled
        $BandwidthLimitEnabledValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'BandwidthLimitEnabledValue'}).Value

        # DailyBandwidthLimitInMB
        $DailyBandwidthLimitInMBValue = [UInt32]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'DailyBandwidthLimitInMB'}).Value

        # PathExclusion
        $PathExclusionValue = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'PathExclusion'}).Value

        # MacPathExclusion
        $MacPathExclusionValue = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'MacPathExclusion'}).Value

        # MacDefaultPathExclusionsEnabled
        $MacDefaultPathExclusionsEnabledValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'MacDefaultPathExclusionsEnabled'}).Value

        #EvidenceStoreSettings
        $entry = $EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'EvidenceStoreSettings'}
        if ($null -ne $entry)
        {
            $entry = ConvertFrom-Json $entry.Value
            $EvidenceStoreSettingsValue = @{
                FileEvidenceIsEnabled = $entry.FileEvidenceIsEnabled
                NumberOfDaysToRetain  = [Uint32]$entry.NumberOfDaysToRetain
                StorageAccounts       = [Array]$entry.StorageAccounts
                Store                 = $entry.Store
            }
        }

        # NetworkPathEnforcementEnabled
        $NetworkPathEnforcementEnabledValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'NetworkPathEnforcementEnabled'}).Value

        # NetworkPathExclusion
        $NetworkPathExclusionValue = ($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'NetworkPathExclusion'}).Value

        # DlpAppGroups
        $DlpAppGroupsValue = @()
        foreach ($group in $DlpAppGroupsObject)
        {
            $entry = @{
                Name        = $group.Name
                Id          = $group.Id
                Description = $group.Description
                Apps        = @()
            }

            foreach ($appEntry in $group.Apps)
            {
                $app = @{
                    ExecutableName = $appEntry.ExecutableName
                    Name           = $appEntry.Name
                    Quarantine     = [Boolean]$appEntry.Quarantine
                }
                $entry.Apps += $app
            }
            $DlpAppGroupsValue += $entry
        }

        # UnallowedApp
        $entries = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'UnallowedApp'})
        $UnallowedAppValue = @()
        foreach ($entry in $entries)
        {
            $current = @{
                Value      = $entry.Value
                Executable = $entry.Executable
            }
            $UnallowedAppValue += $current
        }

        # UnallowedCloudSyncApp
        $entries = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'UnallowedCloudSyncApp'})
        $UnallowedCloudSyncAppValue = @()
        foreach ($entry in $entries)
        {
            $current = @{
                Value      = $entry.Value
                Executable = $entry.Executable
            }
            $UnallowedCloudSyncAppValue += $current
        }

        # IncludePredefinedUnallowedBluetoothApps
        $IncludePredefinedUnallowedBluetoothAppsValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'IncludePredefinedUnallowedBluetoothApps'}).Value

        # UnallowedBluetoothApp
        $entries = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'UnallowedBluetoothApp'})
        $UnallowedBluetoothAppValue = @()
        foreach ($entry in $entries)
        {
            $current = @{
                Value      = $entry.Value
                Executable = $entry.Executable
            }
            $UnallowedBluetoothAppValue += $current
        }

        # UnallowedBrowser
        $entries = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'UnallowedBrowser'})
        $UnallowedBrowserValue = @()
        foreach ($entry in $entries)
        {
            $current = @{
                Value      = $entry.Value
                Executable = $entry.Executable
            }
            $UnallowedBrowserValue += $current
        }

        # CloudAppMode
        $CloudAppModeValue = ($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'CloudAppMode'}).Value

        # CloudAppRestrictionList
        $CloudAppRestrictionListValue = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'CloudAppRestrictionList'}).Value

        # SiteGroups
        $SiteGroupsValue = @()
        foreach ($siteGroup in $SiteGroupsObject)
        {
            $entry = @{
                Id = $siteGroup.Id
                Name = $siteGroup.Name
            }

            $addresses = @()
            foreach ($address in $siteGroup.Addresses)
            {
                $addresses += @{
                    MatchType    = $address.MatchType
                    Url          = $address.Url
                    AddressLower = $address.AddressLower
                    AddressUpper = $address.AddressUpper
                }
            }
            $entry.Add('Addresses', $addresses)
            $SiteGroupsValue += $entry
        }

        # CustomBusinessJustificationNotification
        $CustomBusinessJustificationNotificationValue = [Uint32]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'CustomBusinessJustificationNotification'}).Value

        if (-not [System.String]::IsNullOrEmpty($EndpointDlpGlobalSettingsValue.Setting))
        {
            $entities = $EndpointDlpGlobalSettingsValue | Where-Object -FilterScript {$_.Setting -eq 'BusinessJustificationList'}

            # BusinessJustificationList
            if ($null -ne $entities)
            {
                $entities = ConvertFrom-Json ($entities.value)
                $BusinessJustificationListValue = @()
                foreach ($entity in $entities)
                {
                    $current = @{
                        Id                = $entity.Id
                        Enable            = [Boolean]$entity.Enable
                        justificationText = $entity.justificationText
                    }
                    $BusinessJustificationListValue += $current
                }
            }

            # serverDlpEnabled
            $serverDlpEnabledValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'serverDlpEnabled'}).Value

            # AuditFileActivity
            $AuditFileActivityValue = [Boolean]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'AuditFileActivity'}).Value

            # VPNSettings
            $entity = $EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'VPNSettings'}
            if ($null -ne $entity)
            {
                $entity = ConvertFrom-Json ($entity.value)
                $VPNSettingsValue = [Array]$entity.serverAddress
            }
        }

        # DlpPrinterGroups
        $DlpPrinterGroupsValue = @()
        foreach ($group in $DlpPrinterGroupsObject.groups)
        {
            $entry = @{
                groupName = $group.groupName
                groupId   = $group.groupId
            }

            $printers = @()
            foreach ($printer in $group.printers)
            {
                $current = @{
                    universalPrinter = [Boolean]$printer.universalPrinter
                    usbPrinter       = [Boolean]$printer.usbPrinter
                    usbPrinterId     = $printer.usbPrinterPID
                    name             = $printer.name
                    alias            = $printer.alias
                    usbPrinterVID    = $printer.usbPrinterVID
                    ipRange          = @{
                        fromAddress = $printer.ipRange.from
                        toAddress   = $printer.ipRange.to
                    }
                    corporatePrinter = [Boolean]$printer.CorporatePrinter
                    printToLocal     = [Boolean]$printer.printToLocal
                    printToFile      = [Boolean]$printer.printToFile
                }

                $printers += $current
            }
            $entry.Add('printers', $printers)
            $DlpPrinterGroupsValue += $entry
        }

        # DLPRemovableMediaGroups
        $DLPRemovableMediaGroupsValue = @()
        foreach ($group in $DLPRemovableMediaGroupsObject.groups)
        {
            $entry = @{
                groupName = $group.groupName
            }

            $medias = @()
            foreach ($media in $group.removableMedia)
            {
                $current = @{
                    deviceId = $media.deviceId
                    removableMediaVID = $media.removableMediaVID
                    name              = $media.name
                    alias             = $media.alias
                    removableMediaPID = $media.removableMediaPID
                    instancePathId    = $media.instancePathId
                    serialNumberId    = $media.serialNumberId
                    hardwareId        = $media.hardwareId
                }
                $medias += $current
            }
            $entry.Add('removableMedia', $medias)

            $DLPRemovableMediaGroupsValue += $entry
        }

        # DlpNetworkShareGroups
        $DlpNetworkShareGroupsValue = @()
        foreach ($group in $DlpNetworkShareGroupsObject.groups)
        {
            $entry = @{
                groupName    = $group.groupName
                groupId      = $group.groupId
                networkPaths = [Array]$group.networkPaths
            }
            $DlpNetworkShareGroupsValue += $entry
        }

        $QuarantineParametersValue = @()
        if ($null -ne ($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'QuarantineParameters'}))
        {
            $quarantineInfo = [Array]($EndpointDlpGlobalSettingsValue | Where-Object {$_.Setting -eq 'QuarantineParameters'}).Value
            $quarantineInfo = ConvertFrom-Json $quarantineInfo[0]
            $QuarantineParametersValue = @{
                EnableQuarantineForCloudSyncApps = $quarantineInfo.EnableQuarantineForCloudSyncApps
                QuarantinePath                   = $quarantineInfo.QuarantinePath
                MacQuarantinePath                = $quarantineInfo.MacQuarantinePath
                ShouldReplaceFile                = $quarantineInfo.ShouldReplaceFile
                FileReplacementText              = $quarantineInfo.FileReplacementText
            }
        }

        $results = @{
            IsSingleInstance                        = 'Yes'
            AdvancedClassificationEnabled           = $AdvancedClassificationEnabledValue
            BandwidthLimitEnabled                   = $BandwidthLimitEnabledValue
            DailyBandwidthLimitInMB                 = $DailyBandwidthLimitInMBValue
            PathExclusion                           = $PathExclusionValue
            MacPathExclusion                        = $MacPathExclusionValue
            MacDefaultPathExclusionsEnabled         = $MacDefaultPathExclusionsEnabledValue
            EvidenceStoreSettings                   = $EvidenceStoreSettingsValue
            NetworkPathEnforcementEnabled           = $NetworkPathEnforcementEnabledValue
            NetworkPathExclusion                    = $NetworkPathExclusionValue
            DLPAppGroups                            = $DlpAppGroupsValue
            UnallowedApp                            = $UnallowedAppValue
            UnallowedCloudSyncApp                   = $UnallowedCloudSyncAppValue
            IncludePredefinedUnallowedBluetoothApps = $IncludePredefinedUnallowedBluetoothAppsValue
            UnallowedBluetoothApp                   = $UnallowedBluetoothAppValue
            UnallowedBrowser                        = $UnallowedBrowserValue
            CloudAppMode                            = $CloudAppModeValue
            CloudAppRestrictionList                 = $CloudAppRestrictionListValue
            SiteGroups                              = $SiteGroupsValue
            CustomBusinessJustificationNotification = $CustomBusinessJustificationNotificationValue
            BusinessJustificationList               = $BusinessJustificationListValue
            serverDlpEnabled                        = $serverDlpEnabledValue
            AuditFileActivity                       = $AuditFileActivityValue
            DLPPrinterGroups                        = $DlpPrinterGroupsValue
            DLPRemovableMediaGroups                 = $DLPRemovableMediaGroupsValue
            DLPNetworkShareGroups                   = $DlpNetworkShareGroupsValue
            VPNSettings                             = $VPNSettingsValue
            EnableLabelCoauth                       = $instance.EnableLabelCoauth
            EnableSpoAipMigration                   = $instance.EnableSpoAipMigration
            QuarantineParameters                    = $QuarantineParametersValue
            Credential                              = $Credential
            ApplicationId                           = $ApplicationId
            TenantId                                = $TenantId
            CertificateThumbprint                   = $CertificateThumbprint
            ManagedIdentity                         = $ManagedIdentity.IsPresent
            AccessTokens                            = $AccessTokens
        }
        return [System.Collections.Hashtable] $results
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AdvancedClassificationEnabled,

        [Parameter()]
        [System.Boolean]
        $AuditFileActivity,

        [Parameter()]
        [System.Boolean]
        $BandwidthLimitEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BusinessJustificationList,

        [Parameter()]
        [System.String]
        $CloudAppMode,

        [Parameter()]
        [System.String[]]
        $CloudAppRestrictionList,

        [Parameter()]
        [System.UInt32]
        $CustomBusinessJustificationNotification,

        [Parameter()]
        [System.UInt32]
        $DailyBandwidthLimitInMB,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPAppGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPNetworkShareGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPPrinterGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPRemovableMediaGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EvidenceStoreSettings,

        [Parameter()]
        [System.Boolean]
        $IncludePredefinedUnallowedBluetoothApps,

        [Parameter()]
        [System.Boolean]
        $MacDefaultPathExclusionsEnabled,

        [Parameter()]
        [System.String[]]
        $MacPathExclusion,

        [Parameter()]
        [System.Boolean]
        $NetworkPathEnforcementEnabled,

        [Parameter()]
        [System.String]
        $NetworkPathExclusion,

        [Parameter()]
        [System.String[]]
        $PathExclusion,

        [Parameter()]
        [System.Boolean]
        $serverDlpEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $SiteGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedCloudSyncApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBluetoothApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBrowser,

        [Parameter()]
        [System.String[]]
        $VPNSettings,

        [Parameter()]
        [System.Boolean]
        $EnableLabelCoauth,

        [Parameter()]
        [System.Boolean]
        $EnableSpoAipMigration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $QuarantineParameters,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters | Out-Null

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $SiteGroupsValue = @()
    foreach ($site in $SiteGroups)
    {
        $entry = @{
            Name        = $site.Name
            Description = $site.Description
        }

        $addressesValue = @()
        foreach ($address in $site.Addresses)
        {
            $addressesValue += @{
                MatchType    = $address.MatchType
                Url          = $address.Url
                AddressLower = $address.AddressLower
                AddressUpper = $address.AddressUpper
            }
        }

        $entry.Add('Addresses', (ConvertTo-Json $addressesValue -Compress -Depth 10))
        $SiteGroupsValue += $entry
    }

    $EndpointDlpGlobalSettingsValue = @()
    if ($null -ne $AdvancedClassificationEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'AdvancedClassificationEnabled'
            Value   = "$($AdvancedClassificationEnabled.ToString().ToLower())"
        }
    }

    if ($null -ne $BandwidthLimitEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'BandwidthLimitEnabled'
            Value   = "$($BandwidthLimitEnabled.ToString().ToLower())"
        }
    }

    if ($null -ne $DailyBandwidthLimitInMB -and $BandwidthLimitEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'DailyBandwidthLimitInMB'
            Value   = "$($DailyBandwidthLimitInMB.ToString().ToLower())"
        }
    }

    if ($null -ne $EvidenceStoreSettings)
    {
        $entry += @{
            Setting = 'EvidenceStoreSettings'
            Value   = @{
                FileEvidenceIsEnabled = $EvidenceStoreSettings.FileEvidenceIsEnabled
                Store                 = $EvidenceStoreSettings.Store
                NumberOfDaysToRetain  = $EvidenceStoreSettings.NumberOfDaysToRetain
            }
        }

        $StorageAccountsValue = @()
        foreach ($storageAccount in $EvidenceStoreSettings.StorageAccounts)
        {
            $StorageAccountsValue += @{
                Name    = $storageAccount.Name
                BlobUri = $storageAccount.BlobUri
            }
        }
        $entry.Value.Add('StorageAccounts', $StorageAccountsValue)
        $entry.Value = ConvertTo-Json $entry.Value -Depth 10 -Compress

        $EndpointDlpGlobalSettingsValue += $entry
    }

    if ($null -ne $MacDefaultPathExclusionsEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'MacDefaultPathExclusionsEnabled'
            Value   = "$($MacDefaultPathExclusionsEnabled.ToString().ToLower())"
        }
    }

    foreach ($path in $PathExclusion)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'PathExclusion'
            Value   = "$($path.ToString())"
        }
    }

    foreach ($path in $MacPathExclusion)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'MacPathExclusion'
            Value   = "$($path.ToString())"
        }
    }

    foreach ($app in $UnallowedApp)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting    = 'UnallowedApp'
            Value      = "$($app.Value.ToString())"
            Executable = "$($app.Executable.ToString())"
        }
    }

    foreach ($app in $UnallowedCloudSyncApp)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting    = 'UnallowedCloudSyncApp'
            Value      = "$($app.Value.ToString())"
            Executable = "$($app.Executable.ToString())"
        }
    }

    if ($null -ne $NetworkPathEnforcementEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'NetworkPathEnforcementEnabled'
            Value   = "$($NetworkPathEnforcementEnabled.ToString().ToLower())"
        }
    }

    if ($null -ne $NetworkPathExclusion)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'NetworkPathExclusion'
            Value   = "$($NetworkPathExclusion.ToString())"
        }
    }

    if ($null -ne $QuarantineParameters)
    {
        $entry = @{
            Setting = 'QuarantineParameters'
            Value   = @{
                EnableQuarantineForCloudSyncApps = $QuarantineParameters.EnableQuarantineForCloudSyncApps
                QuarantinePath                   = $QuarantineParameters.QuarantinePath
                MacQuarantinePath                = $QuarantineParameters.MacQuarantinePath
                ShouldReplaceFile                = $QuarantineParameters.ShouldReplaceFile
                FileReplacementText              = $QuarantineParameters.FileReplacementText
            }
        }
        $entry.Value = (ConvertTo-Json $entry.Value -Depth 10 -Compress)
        $EndpointDlpGlobalSettingsValue += $entry
    }

    if ($null -ne $IncludePredefinedUnallowedBluetoothApps)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'IncludePredefinedUnallowedBluetoothApps'
            Value   = "$($IncludePredefinedUnallowedBluetoothApps.ToString())"
        }
    }

    foreach ($app in  $UnallowedBluetoothApp)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting    = 'UnallowedBluetoothApp'
            Value      = "$($app.Value.ToString())"
            Executable = "$($app.Executable.ToString())"
        }
    }

    foreach ($app in  $UnallowedBrowser)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting    = 'UnallowedBrowser'
            Value      = "$($app.Value.ToString())"
            Executable = "$($app.Executable.ToString())"
        }
    }

    foreach ($domain in  $CloudAppRestrictionList)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting    = 'CloudAppRestrictionList'
            Value      = "$($domain.ToString())"
        }
    }

    if ($null -ne $CloudAppMode)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'CloudAppMode'
            Value   = "$($CloudAppMode.ToString())"
        }
    }

    if ($null -ne $CustomBusinessJustificationNotification)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'CustomBusinessJustificationNotification'
            Value   = "$($CustomBusinessJustificationNotification.ToString())"
        }
    }

    if ($null -ne $BusinessJustificationList)
    {
        $valueEntry = @()
        foreach ($justification in $BusinessJustificationList)
        {
            $valueEntry += @{
                Id                = $justification.Id
                Enable            = $justification.Enable
                justificationText = @($justification.justificationText)
            }
        }

        $entry = @{
            Setting = 'BusinessJustificationList'
            Value   = (ConvertTo-Json $valueEntry -Depth 10 -Compress)
        }
        $EndpointDlpGlobalSettingsValue += $entry
    }

    if ($null -ne $VPNSettings)
    {
        $entry = @{
            Setting = 'VPNSettings'
            Value = @{
                serverAddress = @()
            }
        }
        foreach ($vpnAddress in $VPNSettings)
        {
            $entry.Value.serverAddress += $vpnAddress
        }
        $EndpointDlpGlobalSettingsValue += $entry
    }

    if ($null -ne $serverDlpEnabled)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'serverDlpEnabled'
            Value   = "$($serverDlpEnabled.ToString().ToLower())"
        }
    }

    if ($null -ne $AuditFileActivity)
    {
        $EndpointDlpGlobalSettingsValue += @{
            Setting = 'AuditFileActivity'
            Value   = "$($AuditFileActivity.ToString().ToLower())"
        }
    }

    $DLPAppGroupsValue = @()
    foreach ($group in $DLPAppGroups)
    {
        $entry = @{
            Name        = "$($group.Name.ToString())"
            Description = "$($group.Description.ToString())"
        }

        $appsValues = @()
        foreach ($app in $group.Apps)
        {
            $appsValues += @{
                Name           = $app.Name
                ExecutableName = $app.ExecutableName
                Quarantine     = $app.Quarantine
            }
        }
        $entry.Add('Apps', (ConvertTo-Json $appsValues -Depth 10 -Compress))
        $DLPAppGroupsValue += $entry
    }

    $DlpPrinterGroupsValue = @{
        groups = @()
    }
    $groupCount = 0
    foreach ($group in $DLPPrinterGroups)
    {
        $entry = @{
            groupName = "$($group.groupName.ToString())"
            printers  = @()
        }

        foreach ($printer in $group.printers)
        {
            $entry.printers += @{
                alias            = $printer.alias
                name             = $printer.name
                usbPrinterPID    = $printer.usbPrinterId
                usbPrinterVID    = $printer.usbPrinterVID
                universalPrinter = "$($printer.universalPrinter.Tostring().ToLower())"
                corporatePrinter = "$($printer.corporatePrinter.Tostring().ToLower())"
                printToFile      = "$($printer.printToFile.Tostring().ToLower())"
                printToLocal     = "$($printer.printToLocal.Tostring().ToLower())"
                ipRange          = @(
                    @{
                        from = $printer.ipRange.fromAddress
                        to   = $printer.ipRange.toAddress
                    }
                )
            }
        }
        $DlpPrinterGroupsValue.groups += $entry
        $groupCount++
    }
    if ($groupCount -eq 0)
    {
        $DlpPrinterGroupsValue = $null
    }

    $DLPRemovableMediaGroupsValue = @{
        groups = @()
    }
    $groupCount = 0
    foreach ($group in $DLPRemovableMediaGroups)
    {
        $entry = @{
            groupName = $group.groupName
            removableMedia = @(
            )
        }

        foreach ($media in $group.removableMedia)
        {
            $entry.removableMedia += @{
                alias             = $media.alias
                name              = $media.name
                removableMediaPID = $media.removableMediaPID
                removableMediaVID = $media.removableMediaVID
                serialNumberId    = $media.serialNumberId
                deviceId          = $media.deviceId
                instancePathId    = $media.instancePathId
                hardwareId        = $media.hardwareId
            }
        }
        $DLPRemovableMediaGroupsValue.groups += $entry
        $groupCount++
    }
    if ($groupCount -eq 0)
    {
        $DLPRemovableMediaGroupsValue = $null
    }

    $params = @{
        SiteGroups                = $SiteGroupsValue
        EnableLabelCoauth         = $EnableLabelCoauth
        DlpAppGroups              = $DLPAppGroupsValue
        DlpPrinterGroups          = ConvertTo-Json $DlpPrinterGroupsValue -Depth 10 -Compress
        DLPRemovableMediaGroups   = ConvertTo-Json $DLPRemovableMediaGroupsValue -Depth 10 -Compress
        EnableSpoAipMigration     = $EnableSpoAipMigration
        EndpointDlpGlobalSettings = $EndpointDlpGlobalSettingsValue
    }
    Write-Verbose -Message "Updating policy config with values:`r`n$(Convert-M365DscHashtableToString -Hashtable $params)"
    Set-PolicyConfig @params
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AdvancedClassificationEnabled,

        [Parameter()]
        [System.Boolean]
        $AuditFileActivity,

        [Parameter()]
        [System.Boolean]
        $BandwidthLimitEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BusinessJustificationList,

        [Parameter()]
        [System.String]
        $CloudAppMode,

        [Parameter()]
        [System.String[]]
        $CloudAppRestrictionList,

        [Parameter()]
        [System.UInt32]
        $CustomBusinessJustificationNotification,

        [Parameter()]
        [System.UInt32]
        $DailyBandwidthLimitInMB,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPAppGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPNetworkShareGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPPrinterGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DLPRemovableMediaGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EvidenceStoreSettings,

        [Parameter()]
        [System.Boolean]
        $IncludePredefinedUnallowedBluetoothApps,

        [Parameter()]
        [System.Boolean]
        $MacDefaultPathExclusionsEnabled,

        [Parameter()]
        [System.String[]]
        $MacPathExclusion,

        [Parameter()]
        [System.Boolean]
        $NetworkPathEnforcementEnabled,

        [Parameter()]
        [System.String]
        $NetworkPathExclusion,

        [Parameter()]
        [System.String[]]
        $PathExclusion,

        [Parameter()]
        [System.Boolean]
        $serverDlpEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $SiteGroups,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedCloudSyncApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBluetoothApp,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UnallowedBrowser,

        [Parameter()]
        [System.String[]]
        $VPNSettings,

        [Parameter()]
        [System.Boolean]
        $EnableLabelCoauth,

        [Parameter()]
        [System.Boolean]
        $EnableSpoAipMigration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $QuarantineParameters,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    #Compare Cim instances
    $testResult = $true
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($null -ne $source -and $source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck $ValuesToCheck.Keys

    Write-Verbose -Message "Test-TargetResource returned $testResult"

    return $testResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        $Script:ExportMode = $true
        $params = @{
            IsSingleInstance      = 'Yes'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }
        $Results = Get-TargetResource @Params

        if ($null -ne $Results.BusinessJustificationList)
        {
            $Results.BusinessJustificationList = ConvertTo-BusinessJustificationListString -ObjectHash $Results.BusinessJustificationList
        }

        if ($null -ne $Results.DLPAppGroups)
        {
            $Results.DLPAppGroups = ConvertTo-DLPAppGroupsString -ObjectHash $Results.DLPAppGroups
        }

        if ($null -ne $Results.DLPNetworkShareGroups)
        {
            $Results.DLPNetworkShareGroups = ConvertTo-DLPNetworkShareGroupsString -ObjectHash $Results.DLPNetworkShareGroups
        }

        if ($null -ne $Results.DLPPrinterGroups -and $Results.DLPPrinterGroups.Length -gt 0)
        {
            $Results.DLPPrinterGroups = ConvertTo-DLPPrinterGroupsString -ObjectHash $Results.DLPPrinterGroups
        }

        if ($null -ne $Results.DLPRemovableMediaGroups)
        {
            $Results.DLPRemovableMediaGroups = ConvertTo-DLPRemovableMediaGroupsString -ObjectHash $Results.DLPRemovableMediaGroups
        }

        if ($null -ne $Results.EvidenceStoreSettings)
        {
            $Results.EvidenceStoreSettings = ConvertTo-EvidenceStoreSettingsString -ObjectHash $Results.EvidenceStoreSettings
        }

        if ($null -ne $Results.SiteGroups)
        {
            $Results.SiteGroups = ConvertTo-SiteGroupsString -ObjectHash $Results.SiteGroups
        }

        if ($null -ne $Results.UnallowedApp -and -not [System.String]::IsNullOrEmpty($Results.UnallowedApp))
        {
            $Results.UnallowedApp = ConvertTo-AppsString -ObjectHash $Results.UnallowedApp
        }

        if ($null -ne $Results.UnallowedCloudSyncApp -and -not [System.String]::IsNullOrEmpty($Results.UnallowedCloudSyncApp))
        {
            $Results.UnallowedCloudSyncApp = ConvertTo-AppsString -ObjectHash $Results.UnallowedCloudSyncApp
        }

        if ($null -ne $Results.UnallowedBluetoothApp -and -not [System.String]::IsNullOrEmpty($Results.UnallowedBluetoothApp))
        {
            $Results.UnallowedBluetoothApp = ConvertTo-AppsString -ObjectHash $Results.UnallowedBluetoothApp
        }

        if ($null -ne $Results.UnallowedBrowser -and -not [System.String]::IsNullOrEmpty($Results.UnallowedBrowser))
        {
            $Results.UnallowedBrowser = ConvertTo-AppsString -ObjectHash $Results.UnallowedBrowser
        }

        if ($null -ne $Results.QuarantineParameters -and -not [System.String]::IsNullOrEmpty($Results.QuarantineParameters))
        {
            $Results.QuarantineParameters = ConvertTo-QuarantineParametersString -ObjectHash $Results.QuarantineParameters
        }

        $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
            -Results $Results

        $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
            -ConnectionMode $ConnectionMode `
            -ModulePath $PSScriptRoot `
            -Results $Results `
            -Credential $Credential

        if ($null -ne $Results.QuarantineParameters)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'QuarantineParameters' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.BusinessJustificationList)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'BusinessJustificationList' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.DLPAppGroups)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'DLPAppGroups' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.DLPNetworkShareGroups)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'DLPNetworkShareGroups' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.DLPPrinterGroups)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'DLPPrinterGroups' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.DLPRemovableMediaGroups)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'DLPRemovableMediaGroups' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.SiteGroups)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'SiteGroups' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.UnallowedApp)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'UnallowedApp' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.UnallowedCloudSyncApp)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'UnallowedCloudSyncApp' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.UnallowedBluetoothApp)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'UnallowedBluetoothApp' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.UnallowedBrowser)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'UnallowedBrowser' `
                                                                -IsCIMArray:$true
        }

        if ($null -ne $Results.EvidenceStoreSettings)
        {
            $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                                                                -ParameterName 'EvidenceStoreSettings' `
                                                                -IsCIMArray:$false
        }

        $dscContent += $currentDSCBlock
        Save-M365DSCPartialExport -Content $currentDSCBlock `
            -FileName $Global:PartialExportFileName
        Write-Host $Global:M365DSCEmojiGreenCheckMark

        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

function ConvertTo-QuarantineParametersString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )

    $content = [System.Text.StringBuilder]::new()
    [void]$content.AppendLine("                MSFT_PolicyConfigQuarantineParameters")
    [void]$content.AppendLine("                {")
    [void]$content.AppendLine("                    EnableQuarantineForCloudSyncApps = `$$($ObjectHash.EnableQuarantineForCloudSyncApps)")
    [void]$content.AppendLine("                    QuarantinePath                   = '$($ObjectHash.QuarantinePath.ToString())'")
    [void]$content.AppendLine("                    MacQuarantinePath                = '$($ObjectHash.MacQuarantinePath)'")
    [void]$content.AppendLine("                    ShouldReplaceFile                = `$$($ObjectHash.ShouldReplaceFile.ToString())")
    [void]$content.AppendLine("                    FileReplacementText              = '$($ObjectHash.FileReplacementText)'")
    [void]$content.AppendLine("                }")
    return $content.ToString()
}

function ConvertTo-BusinessJustificationListString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )

    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigBusinessJustificationList")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    Id                = '$($instance.Id)'")
        [void]$content.AppendLine("                    Enable            = `$$($instance.Enable)")
        [void]$content.AppendLine("                    justificationText = '$($instance.justificationText)'")
        [void]$content.AppendLine("                }")
    }
    [void]$content.Append('                )')
    $result = $content.ToString()
    return $result
}

function ConvertTo-DLPAppGroupsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigDLPAppGroups")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    Name        = '$($instance.Name)'")
        [void]$content.AppendLine("                    Id          = '$($instance.Id)'")
        [void]$content.AppendLine("                    Description = '$($instance.Description)'")
        [void]$content.AppendLine("                    Apps = @(")
        foreach ($app in $instance.Apps)
        {
            [void]$content.AppendLine("                        MSFT_PolicyConfigDLPApp")
            [void]$content.AppendLine("                        {")
            [void]$content.AppendLine("                            ExecutableName    = '$($app.ExecutableName)'")
            [void]$content.AppendLine("                            Name              = '$($app.Name)'")
            [void]$content.AppendLine("                            Quarantine        = `$$($app.Quarantine)")
            [void]$content.AppendLine("                        }")
        }
        [void]$content.AppendLine("                )}")
    }
    [void]$content.Append('                )')
    $result = $content.ToString()
    return $result
}

function ConvertTo-DLPNetworkShareGroupsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigDLPNetworkShareGroups")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    groupName    = '$($instance.groupName)'")
        [void]$content.AppendLine("                    groupId      = '$($instance.groupId)'")
        [void]$content.Append("                    networkPaths = @(")
        $countPath = 1
        foreach ($path in $instance.networkPaths)
        {
            [void]$content.Append("'$path'")
            if ($countPath -lt $instance.networkPaths.Length)
            {
                [void]$content.Append(',')
            }
            $countPath++
        }
        [void]$content.AppendLine(')')
        [void]$content.AppendLine("                }")
    }
    [void]$content.Append('                )')
    $result = $content.ToString()
    return $result
}

function ConvertTo-EvidenceStoreSettingsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Hashtable]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()
    [void]$content.AppendLine("                MSFT_PolicyConfigEvidenceStoreSettings")
    [void]$content.AppendLine("                {")
    [void]$content.AppendLine("                    FileEvidenceIsEnabled = `$$($ObjectHash.FileEvidenceIsEnabled)")
    [void]$content.AppendLine("                    NumberOfDaysToRetain  = $($ObjectHash.NumberOfDaysToRetain)")
    [void]$content.AppendLine("                    StorageAccounts       = @(")
    foreach ($storageAccount in $ObjectHash.StorageAccounts)
    {
        [void]$content.AppendLine("                        MSFT_PolicyConfigStorageAccount")
        [void]$content.AppendLine("                        {")
        [void]$content.AppendLine("                            Name    = '$($storageAccount.Name)'")
        [void]$content.AppendLine("                            BlobUri = '$($storageAccount.BlobUri)'")
        [void]$content.AppendLine("                        }")
    }
    [void]$content.AppendLine("                    )")
    [void]$content.AppendLine("                    Store                 = '$($ObjectHash.Store)'")
    [void]$content.AppendLine("                }")
    return $content.ToString()
}

function ConvertTo-DLPPrinterGroupsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigDLPPrinterGroups")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    groupName    = '$($instance.groupName)'")
        [void]$content.AppendLine("                    groupId      = '$($instance.groupId)'")
        [void]$content.AppendLine("                    printers = @(")
        foreach ($printer in $instance.printers)
        {
            [void]$content.AppendLine("                        MSFT_PolicyConfigPrinter")
            [void]$content.AppendLine("                        {")
            [void]$content.AppendLine("                            universalPrinter = `$$($printer.universalPrinter)")
            [void]$content.AppendLine("                            usbPrinter       = `$$($printer.usbPrinter)")
            [void]$content.AppendLine("                            usbPrinterId     = '$($printer.usbPrinterId)'")
            [void]$content.AppendLine("                            name             = '$($printer.name)'")
            [void]$content.AppendLine("                            alias            = '$($printer.alias)'")
            [void]$content.AppendLine("                            usbPrinterVID    = '$($printer.usbPrinterVID)'")
            [void]$content.AppendLine("                            ipRange          = MSFT_PolicyConfigIPRange")
            [void]$content.AppendLine("                                {")
            [void]$content.AppendLine("                                    fromAddress = '$($printer.ipRange.fromAddress)'")
            [void]$content.AppendLine("                                    toAddress   = '$($printer.ipRange.toAddress)'")
            [void]$content.AppendLine("                                }")
            [void]$content.AppendLine("                            corporatePrinter = `$$($printer.corporatePrinter)")
            [void]$content.AppendLine("                            printToLocal     = `$$($printer.printToLocal)")
            [void]$content.AppendLine("                            printToFile      = `$$($printer.printToFile)")
            [void]$content.AppendLine("                        }")
        }
        [void]$content.AppendLine("                    )")
        [void]$content.AppendLine("                }")
    }
    [void]$content.Append(')')
    $result = $content.ToString()
    return $result
}

function ConvertTo-DLPRemovableMediaGroupsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigDLPRemovableMediaGroups")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    groupName = '$($instance.groupName)'")
        [void]$content.AppendLine("                    removableMedias   = @(")
        foreach ($media in $instance.removableMedia)
        {
            [void]$content.AppendLine("                        MSFT_PolicyConfigRemovableMedia")
            [void]$content.AppendLine("                        {")
            [void]$content.AppendLine("                            deviceId          = '$($media.deviceId)'")
            [void]$content.AppendLine("                            removableMediaVID = '$($media.removableMediaVID)'")
            [void]$content.AppendLine("                            name              = '$($media.name)'")
            [void]$content.AppendLine("                            alias             = '$($media.alias)'")
            [void]$content.AppendLine("                            removableMediaPID = '$($media.removableMediaPID)'")
            [void]$content.AppendLine("                            instancePathId    = '$($media.instancePathId)'")
            [void]$content.AppendLine("                            serialNumberId    = '$($media.serialNumberId)'")
            [void]$content.AppendLine("                            hardwareId        = '$($media.hardwareId)'")
            [void]$content.AppendLine("                        }")
        }
        [void]$content.AppendLine("                    )")
        [void]$content.AppendLine(                "}")
    }
    [void]$content.Append('                )')
    $result = $content.ToString()
    return $result
}
function ConvertTo-SiteGroupsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigDLPSiteGroups")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    Id        = '$($instance.Id)'")
        [void]$content.AppendLine("                    Name      = '$($instance.Name)'")
        [void]$content.AppendLine("                    Addresses = @(")
        foreach ($address in $instance.addresses)
        {
            [void]$content.AppendLine("                        MSFT_PolicyConfigSiteGroupAddress")
            [void]$content.AppendLine("                        {")
            [void]$content.AppendLine("                            MatchType    = '$($address.MatchType)'")
            [void]$content.AppendLine("                            Url          = '$($address.Url)'")
            [void]$content.AppendLine("                            AddressLower = '$($address.AddressLower)'")
            [void]$content.AppendLine("                            AddressUpper = '$($address.AddressUpper)'")
            [void]$content.AppendLine("                        }")
        }
        [void]$content.AppendLine("                    )")
        [void]$content.AppendLine("                }")
    }
    [void]$content.Append('                )')
    $result = $content.ToString()
    return $result
}

function ConvertTo-AppsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $ObjectHash
    )
    $content = [System.Text.StringBuilder]::new()

    [void]$content.Append('@(')
    foreach ($instance in $ObjectHash)
    {
        [void]$content.AppendLine("                MSFT_PolicyConfigApp")
        [void]$content.AppendLine("                {")
        [void]$content.AppendLine("                    Value        = '$($instance.Value)'")
        [void]$content.AppendLine("                    Executable   = '$($instance.Executable)'")
        [void]$content.AppendLine("                }")
    }
    [void]$content.Append(')')
    $result = $content.ToString()
    return $result
}

Export-ModuleMember -Function *-TargetResource
