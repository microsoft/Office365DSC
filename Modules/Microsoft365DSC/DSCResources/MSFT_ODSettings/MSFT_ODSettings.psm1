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
        [System.UInt32]
        $OneDriveStorageQuota,

        [Parameter()]
        [System.UInt32]
        $OrphanedPersonalSitesRetentionPeriod,

        [Parameter()]
        [System.Boolean]
        $OneDriveForGuestsEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyOwnersWhenInvitationsAccepted,

        [Parameter()]
        [System.Boolean]
        $NotificationsInOneDriveForBusinessEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBMembersCanShare,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBAccessRequests,

        [Parameter()]
        [System.Boolean]
        $BlockMacSync,

        [Parameter()]
        [System.Boolean]
        $DisableReportProblemDialog,

        [Parameter()]
        [System.Boolean]
        $TenantRestrictionEnabled,

        [Parameter()]
        [System.String[]]
        $DomainGuids,

        [Parameter()]
        [System.String[]]
        $ExcludedFileExtensions,

        [Parameter()]
        [System.String]
        [ValidateSet('OptOut', 'HardOptIn', 'SoftOptIn')]
        $GrooveBlockOption,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

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
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message 'Getting configuration of OneDrive Settings'

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'

    try
    {
        Write-Verbose -Message 'Getting OneDrive quota size for tenant'
        $tenant = Get-PnPTenant -ErrorAction Stop

        if ($null -eq $tenant)
        {
            Write-Verbose -Message 'Failed to get Tenant information'
            return $nullReturn
        }

        Write-Verbose -Message "Getting OneDrive quota size for tenant $($tenant.OneDriveStorageQuota)"
        Write-Verbose -Message 'Getting tenant client sync setting'
        $tenantRestrictions = Get-PnPTenantSyncClientRestriction -ErrorAction Stop

        if ($null -eq $tenantRestrictions)
        {
            Write-Verbose -Message 'Failed to get Tenant client sync settings!'
            return $nullReturn
        }

        $GrooveOption = $null

        if (($tenantRestrictions.OptOutOfGrooveBlock -eq $true) -and ($tenantRestrictions.OptOutOfGrooveSoftBlock -eq $false))
        {
            $GrooveOption = 'SoftOptIn'
        }

        if (($tenantRestrictions.OptOutOfGrooveBlock -eq $false) -and ($tenantRestrictions.OptOutOfGrooveSoftBlock -eq $true))
        {
            $GrooveOption = 'HardOptIn'
        }

        if (($tenantRestrictions.OptOutOfGrooveBlock -eq $true) -and ($tenantRestrictions.OptOutOfGrooveSoftBlock -eq $true))
        {
            $GrooveOption = 'OptOut'
        }

        $FixedExcludedFileExtensions = $tenantRestrictions.ExcludedFileExtensions
        if ($FixedExcludedFileExtensions.Count -eq 0 -or
            ($FixedExcludedFileExtensions.Count -eq 1 -and $FixedExcludedFileExtensions[0] -eq ''))
        {
            $FixedExcludedFileExtensions = @()
        }

        $FixedAllowedDomainList = $tenantRestrictions.AllowedDomainList
        if ($FixedAllowedDomainList.Count -eq 0 -or
            ($FixedAllowedDomainList.Count -eq 1 -and $FixedAllowedDomainList[0] -eq ''))
        {
            $FixedAllowedDomainList = @()
        }

        $ODBMembersCanShareValue = $tenant.ODBMembersCanShare
        if ([System.String]::IsNullOrEmpty($ODBMembersCanShareValue))
        {
            $ODBMembersCanShareValue = 'Unspecified'
        }
        return @{
            IsSingleInstance                          = 'Yes'
            BlockMacSync                              = $tenantRestrictions.BlockMacSync
            DisableReportProblemDialog                = $tenantRestrictions.DisableReportProblemDialog
            TenantRestrictionEnabled                  = $tenantRestrictions.TenantRestrictionEnabled
            DomainGuids                               = $FixedAllowedDomainList
            ExcludedFileExtensions                    = $FixedExcludedFileExtensions
            GrooveBlockOption                         = $GrooveOption
            OneDriveStorageQuota                      = $tenant.OneDriveStorageQuota
            OrphanedPersonalSitesRetentionPeriod      = $tenant.OrphanedPersonalSitesRetentionPeriod
            OneDriveForGuestsEnabled                  = $tenant.OneDriveForGuestsEnabled
            ODBAccessRequests                         = $tenant.ODBAccessRequests
            ODBMembersCanShare                        = $ODBMembersCanShareValue
            #DEPRECATED
            #NotifyOwnersWhenInvitationsAccepted       = $tenant.NotifyOwnersWhenInvitationsAccepted
            NotificationsInOneDriveForBusinessEnabled = $tenant.NotificationsInOneDriveForBusinessEnabled
            Ensure                                    = 'Present'
            ApplicationId                             = $ApplicationId
            TenantId                                  = $TenantId
            CertificatePassword                       = $CertificatePassword
            CertificatePath                           = $CertificatePath
            CertificateThumbprint                     = $CertificateThumbprint
            Credential                                = $Credential
            Managedidentity                           = $ManagedIdentity.IsPresent
            AccessTokens                              = $AccessTokens
        }
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullReturn
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
        [System.UInt32]
        $OneDriveStorageQuota,

        [Parameter()]
        [System.UInt32]
        $OrphanedPersonalSitesRetentionPeriod,

        [Parameter()]
        [System.Boolean]
        $OneDriveForGuestsEnabled,

        # DEPRECATED
        [Parameter()]
        [System.Boolean]
        $NotifyOwnersWhenInvitationsAccepted,

        [Parameter()]
        [System.Boolean]
        $NotificationsInOneDriveForBusinessEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBMembersCanShare,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBAccessRequests,

        [Parameter()]
        [System.Boolean]
        $BlockMacSync,

        [Parameter()]
        [System.Boolean]
        $DisableReportProblemDialog,

        [Parameter()]
        [System.Boolean]
        $TenantRestrictionEnabled,

        [Parameter()]
        [System.String[]]
        $DomainGuids,

        [Parameter()]
        [System.String[]]
        $ExcludedFileExtensions,

        [Parameter()]
        [System.String]
        [ValidateSet('OptOut', 'HardOptIn', 'SoftOptIn')]
        $GrooveBlockOption,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

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
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message 'Setting configuration of OneDrive Settings'

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
        -InboundParameters $PSBoundParameters

    ## Configure OneDrive settings
    ## Parameters below are remove for the Set-SPOTenant cmdlet
    ## they are used in the Set-SPOTenantSyncClientRestriction cmdlet
    $CurrentParameters = $PSBoundParameters
    $CurrentParameters.Remove('Credential') | Out-Null
    $Options = @{}

    if ($CurrentParameters.ContainsKey('Ensure'))
    {
        $CurrentParameters.Remove('Ensure') | Out-Null
    }
    if ($CurrentParameters.ContainsKey('BlockMacSync'))
    {
        $Options.Add('BlockMacSync', $CurrentParameters.BlockMacSync)
        $CurrentParameters.Remove('BlockMacSync') | Out-Null
    }
    # set the TenantRestrictionEnabled and DomainGuids values to avoid invalid configurations
    if ($TenantRestrictionEnabled -eq $true)
    {
        if (!($CurrentParameters.ContainsKey('DomainGuids') -and ($CurrentParameters.DomainGuids.count -gt 0) -and ($CurrentParameters.DomainGuids[0] -ne '') ))
        {
            Write-Verbose -Message 'Invalid configuration specified: TenantRestrictionEnabled is True but No DomainGuids Specified, this option will not be enabled'
            $TenantRestrictionEnabled = $false
            $DomainGuids = @()

        }
        $CurrentParameters.Remove('TenantRestrictionEnabled') | Out-Null
    }
    else
    {
        if ($CurrentParameters.ContainsKey('TenantRestrictionEnabled'))
        {
            if ($CurrentParameters.ContainsKey('DomainGuids') -and ($CurrentParameters.DomainGuids.count -gt 0) -and ($CurrentParameters.DomainGuids[0] -ne '') )
            {
                Write-Verbose -Message 'DomainGuids have been Specified but TenantRestrictionEnabled is set to False, DomainGuids value will be ignored'
                $TenantRestrictionEnabled = $false
                $DomainGuids = @()

            }
            else
            {
                $TenantRestrictionEnabled = $false
                $DomainGuids = @()
            }
            $CurrentParameters.Remove('TenantRestrictionEnabled') | Out-Null
        }
        else
        {
            if ($CurrentParameters.ContainsKey('DomainGuids') -and ($CurrentParameters.DomainGuids.count -gt 0) -and ($CurrentParameters.DomainGuids[0] -ne '') )
            {
                Write-Verbose -Message 'TenantRestrictionEnabled value not specified but a valid DomainGuids value is present - TenantRestrictionEnabled will be set to true'
                $TenantRestrictionEnabled = $true
                $DomainGuids = $CurrentParameters.DomainGuids
            }
            else
            {
                Write-Verbose -Message 'TenantRestrictionEnabled value not specified - No valid DomainGuids value is present - TenantRestrictionEnabled will be set to False'
                $TenantRestrictionEnabled = $false
                $DomainGuids = @()
            }
        }
    }

    if ($CurrentParameters.ContainsKey('DomainGuids'))
    {
        $CurrentParameters.Remove('DomainGuids') | Out-Null
    }

    $Options.Add('DomainGuids', [System.Guid[]]$DomainGuids)
    $Options.Add('Enable', $TenantRestrictionEnabled)

    if ($CurrentParameters.ContainsKey('DisableReportProblemDialog'))
    {
        $Options.Add('DisableReportProblemDialog', $CurrentParameters.DisableReportProblemDialog)
        $CurrentParameters.Remove('DisableReportProblemDialog') | Out-Null
    }
    if ($CurrentParameters.ContainsKey('ExcludedFileExtensions'))
    {
        $Options.Add('ExcludedFileExtensions', $CurrentParameters.ExcludedFileExtensions)
        $CurrentParameters.Remove('ExcludedFileExtensions') | Out-Null
    }
    if ($CurrentParameters.ContainsKey('GrooveBlockOption'))
    {
        $Options.Add('GrooveBlockOption', $CurrentParameters.GrooveBlockOption)
        $CurrentParameters.Remove('GrooveBlockOption') | Out-Null
    }
    if ($CurrentParameters.ContainsKey('IsSingleInstance'))
    {
        $CurrentParameters.Remove('IsSingleInstance') | Out-Null
    }

    $CurrentParameters.Remove('ApplicationId') | Out-Null
    $CurrentParameters.Remove('TenantId') | Out-Null
    $CurrentParameters.Remove('CertificatePath') | Out-Null
    $CurrentParameters.Remove('CertificatePassword') | Out-Null
    $CurrentParameters.Remove('CertificateThumbprint') | Out-Null
    $CurrentParameters.Remove('ManagedIdentity') | Out-Null
    $CurrentParameters.Remove('AccessTokens') | Out-Null

    Write-Verbose -Message 'Configuring OneDrive settings.'
    Set-PnPTenant @CurrentParameters

    ## Configure Sync Client restrictions
    ## Set-SPOTenantSyncClientRestriction has different parameter sets and they cannot be combined see article:
    ## https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/set-spotenantsyncclientrestriction?view=sharepoint-ps
    Write-Verbose -Message 'Setting other configuration parameters'
    Write-Verbose -Message ($Options | Out-String)

    Set-PnPTenantSyncClientRestriction @Options
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
        [System.UInt32]
        $OneDriveStorageQuota,

        [Parameter()]
        [System.UInt32]
        $OrphanedPersonalSitesRetentionPeriod,

        [Parameter()]
        [System.Boolean]
        $OneDriveForGuestsEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyOwnersWhenInvitationsAccepted,

        [Parameter()]
        [System.Boolean]
        $NotificationsInOneDriveForBusinessEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBMembersCanShare,

        [Parameter()]
        [System.String]
        [ValidateSet('On', 'Off', 'Unspecified')]
        $ODBAccessRequests,

        [Parameter()]
        [System.Boolean]
        $BlockMacSync,

        [Parameter()]
        [System.Boolean]
        $DisableReportProblemDialog,

        [Parameter()]
        [System.Boolean]
        $TenantRestrictionEnabled,

        [Parameter()]
        [System.String[]]
        $DomainGuids,

        [Parameter()]
        [System.String[]]
        $ExcludedFileExtensions,

        [Parameter()]
        [System.String]
        [ValidateSet('OptOut', 'HardOptIn', 'SoftOptIn')]
        $GrooveBlockOption,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

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
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message 'Testing configuration of OneDrive Settings'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @('BlockMacSync', `
            'ExcludedFileExtensions', `
            'DisableReportProblemDialog', `
            'GrooveBlockOption', `
            'TenantRestrictionEnabled', `
            'DomainGuids', `
            'OneDriveStorageQuota', `
            'OrphanedPersonalSitesRetentionPeriod', `
            'OneDriveForGuestsEnabled', `
            'ODBAccessRequests', `
            'ODBMembersCanShare', `
            'NotificationsInOneDriveForBusinessEnabled',
        'Ensure')

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
            -InboundParameters $PSBoundParameters

        #Ensure the proper dependencies are installed in the current environment.
        Confirm-M365DSCDependencies

        #region Telemetry
        $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
        $CommandName = $MyInvocation.MyCommand
        $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
            -CommandName $CommandName `
            -Parameters $PSBoundParameters
        Add-M365DSCTelemetryEvent -Data $data
        #endregion

        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }

        $Params = @{
            IsSingleInstance      = 'Yes'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificatePassword   = $CertificatePassword
            CertificatePath       = $CertificatePath
            CertificateThumbprint = $CertificateThumbprint
            Managedidentity       = $ManagedIdentity.IsPresent
            Credential            = $Credential
            AccessTokens          = $AccessTokens
        }

        $Results = Get-TargetResource @Params

        if ([System.String]::IsNullOrEmpty($Results.GrooveBlockOption))
        {
            $Results.Remove('GrooveBlockOption') | Out-Null
        }

        $dscContent = ''
        $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
            -Results $Results
        $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
            -ConnectionMode $ConnectionMode `
            -ModulePath $PSScriptRoot `
            -Results $Results `
            -Credential $Credential
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

Export-ModuleMember -Function *-TargetResource
