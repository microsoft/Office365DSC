function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $TargetGroups,

        [Parameter()]
        [System.String]
        $AccountName,

        [Parameter()]
        [System.String]
        $AccountUserName,

        [Parameter()]
        [System.Boolean]
        $AllowAppStore,

        [Parameter()]
        [System.Boolean]
        $AllowAssistantWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowConvenienceLogon,

        [Parameter()]
        [System.Boolean]
        $AllowDiagnosticSubmission,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudBackup,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudDocSync,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudPhotoSync,

        [Parameter()]
        [System.Boolean]
        $AllowJailbroken,

        [Parameter()]
        [System.Boolean]
        $AllowPassbookWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowScreenshot,

        [Parameter()]
        [System.Boolean]
        $AllowSimplePassword,

        [Parameter()]
        [System.Boolean]
        $AllowVideoConferencing,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceAssistant,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceDialing,

        [Parameter()]
        [System.UInt32]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.UInt32]
        $AntiVirusStatus,

        [Parameter()]
        [System.String]
        $AppsRating,

        [Parameter()]
        [System.String]
        $AutoUpdateStatus,

        [Parameter()]
        [System.Boolean]
        $BluetoothEnabled,

        [Parameter()]
        [System.Boolean]
        $CameraEnabled,

        [Parameter()]
        [System.String]
        $EmailAddress,

        [Parameter()]
        [System.Boolean]
        $EnableRemovableStorage,

        [Parameter()]
        [System.String]
        $ExchangeActiveSyncHost,

        [Parameter()]
        [System.Boolean]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.UInt32]
        $PasswordComplexity,

        [Parameter()]
        [System.UInt32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.UInt32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.UInt32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.UInt32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.UInt32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.String]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [System.String]
        $RegionRatings,

        [Parameter()]
        [System.Boolean]
        $RequireEmailProfile,

        [Parameter()]
        [System.Boolean]
        $SmartScreenEnabled,

        [Parameter()]
        [System.Boolean]
        $SystemSecurityTLS,

        [Parameter()]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.String]
        $UserAccountControlStatus,

        [Parameter()]
        [System.Boolean]
        $WLANEnabled,

        [Parameter()]
        [System.String]
        $WorkFoldersSyncUrl,

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
        if (-not $Script:exportedInstance)
        {
            New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
                -InboundParameters $PSBoundParameters | Out-Null

            New-M365DSCConnection -Workload 'MicrosoftGraph' `
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
            $nullResult.Ensure = 'Absent'

            $policyObj = Get-DeviceConditionalAccessPolicy | Where-Object -FilterScript { $_.Name -eq $Policy }
            if ($null -ne $policyObj)
            {
                Write-Verbose -Message "Found policy object {$Policy}"
                $instance = Get-DeviceConditionalAccessRule | Where-Object -FilterScript { $_.Policy -eq $policyObj.ExchangeObjectId }
            }
            if ($null -eq $instance)
            {
                return $nullResult
            }
        }
        else
        {
            $instance = $Script:exportedInstance
        }

        $groupNames = @()
        foreach ($group in $instance.TargetGroups)
        {
            $groupValue = ''
            $entry = Get-MgGroup -GroupId $group.Guid -ErrorAction SilentlyContinue
            if ($null -eq $entry)
            {
                $entry = Get-MgUser -UserId $group.Guid -ErrorAction SilentlyContinue
                $groupValue = $entry.UserPrincipalName
            }
            else
            {
                $groupValue = $entry.DisplayName
            }

            if ($null -eq $entry)
            {
                Write-Error -Message "Could not find group or user identified with id {$group}"
            }
            else
            {
                $groupNames += $groupValue
            }
        }

        $results = @{
            Name                          = $instance.Name
            Policy                        = $policyObj.Name
            TargetGroups                  = $groupNames
            AccountName                   = $instance.AccountName
            AccountUserName               = $instance.AccountUserName
            AllowAppStore                 = $instance.AllowAppStore
            AllowAssistantWhileLocked     = $instance.AllowAssistantWhileLocked
            AllowConvenienceLogon         = $instance.AllowConvenienceLogon
            AllowDiagnosticSubmission     = $instance.AllowDiagnosticSubmission
            AllowiCloudBackup             = $instance.AllowiCloudBackup
            AllowiCloudDocSync            = $instance.AllowiCloudDocSync
            AllowiCloudPhotoSync          = $instance.AllowiCloudPhotoSync
            AllowJailbroken               = $instance.AllowJailbroken
            AllowPassbookWhileLocked      = $instance.AllowPassbookWhileLocked
            AllowScreenshot               = $instance.AllowScreenshot
            AllowSimplePassword           = $instance.AllowSimplePassword
            AllowVideoConferencing        = $instance.AllowVideoConferencing
            AllowVoiceAssistant           = $instance.AllowVoiceAssistant
            AllowVoiceDialing             = $instance.AllowVoiceDialing
            AntiVirusSignatureStatus      = $instance.AntiVirusSignatureStatus
            AntiVirusStatus               = $instance.AntiVirusStatus
            AppsRating                    = $instance.AppsRating
            AutoUpdateStatus              = $instance.AutoUpdateStatus
            BluetoothEnabled              = $instance.BluetoothEnabled
            CameraEnabled                 = $instance.CameraEnabled
            EmailAddress                  = $instance.EmailAddress
            EnableRemovableStorage        = $instance.EnableRemovableStorage
            ExchangeActiveSyncHost        = $instance.ExchangeActiveSyncHost
            FirewallStatus                = $instance.FirewallStatus
            ForceAppStorePassword         = $instance.ForceAppStorePassword
            ForceEncryptedBackup          = $instance.ForceEncryptedBackup
            MaxPasswordAttemptsBeforeWipe = $instance.MaxPasswordAttemptsBeforeWipe
            MaxPasswordGracePeriod        = $instance.MaxPasswordGracePeriod
            MoviesRating                  = $instance.MoviesRating
            PasswordComplexity            = $instance.PasswordComplexity
            PasswordExpirationDays        = $instance.PasswordExpirationDays
            PasswordHistoryCount          = $instance.PasswordHistoryCount
            PasswordMinComplexChars       = $instance.PasswordMinComplexChars
            PasswordMinimumLength         = $instance.PasswordMinimumLength
            PasswordQuality               = $instance.PasswordQuality
            PasswordRequired              = $instance.PasswordRequired
            PasswordTimeout               = $instance.PasswordTimeout
            PhoneMemoryEncrypted          = $instance.PhoneMemoryEncrypted
            RegionRatings                 = $instance.RegionRatings
            RequireEmailProfile           = $instance.RequireEmailProfile
            SmartScreenEnabled            = $instance.SmartScreenEnabled
            SystemSecurityTLS             = $instance.SystemSecurityTLS
            TVShowsRating                 = $instance.TVShowsRating
            UserAccountControlStatus      = $instance.UserAccountControlStatus
            WLANEnabled                   = $instance.WLANEnabled
            WorkFoldersSyncUrl            = $instance.WorkFoldersSyncUrl
            Ensure                        = 'Present'
            Credential                    = $Credential
            ApplicationId                 = $ApplicationId
            TenantId                      = $TenantId
            CertificateThumbprint         = $CertificateThumbprint
            ManagedIdentity               = $ManagedIdentity.IsPresent
            AccessTokens                  = $AccessTokens
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
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $TargetGroups,

        [Parameter()]
        [System.String]
        $AccountName,

        [Parameter()]
        [System.String]
        $AccountUserName,

        [Parameter()]
        [System.Boolean]
        $AllowAppStore,

        [Parameter()]
        [System.Boolean]
        $AllowAssistantWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowConvenienceLogon,

        [Parameter()]
        [System.Boolean]
        $AllowDiagnosticSubmission,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudBackup,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudDocSync,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudPhotoSync,

        [Parameter()]
        [System.Boolean]
        $AllowJailbroken,

        [Parameter()]
        [System.Boolean]
        $AllowPassbookWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowScreenshot,

        [Parameter()]
        [System.Boolean]
        $AllowSimplePassword,

        [Parameter()]
        [System.Boolean]
        $AllowVideoConferencing,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceAssistant,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceDialing,

        [Parameter()]
        [System.UInt32]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.UInt32]
        $AntiVirusStatus,

        [Parameter()]
        [System.String]
        $AppsRating,

        [Parameter()]
        [System.String]
        $AutoUpdateStatus,

        [Parameter()]
        [System.Boolean]
        $BluetoothEnabled,

        [Parameter()]
        [System.Boolean]
        $CameraEnabled,

        [Parameter()]
        [System.String]
        $EmailAddress,

        [Parameter()]
        [System.Boolean]
        $EnableRemovableStorage,

        [Parameter()]
        [System.String]
        $ExchangeActiveSyncHost,

        [Parameter()]
        [System.Boolean]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.UInt32]
        $PasswordComplexity,

        [Parameter()]
        [System.UInt32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.UInt32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.UInt32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.UInt32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.UInt32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.String]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [System.String]
        $RegionRatings,

        [Parameter()]
        [System.Boolean]
        $RequireEmailProfile,

        [Parameter()]
        [System.Boolean]
        $SmartScreenEnabled,

        [Parameter()]
        [System.Boolean]
        $SystemSecurityTLS,

        [Parameter()]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.String]
        $UserAccountControlStatus,

        [Parameter()]
        [System.Boolean]
        $WLANEnabled,

        [Parameter()]
        [System.String]
        $WorkFoldersSyncUrl,

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

    $currentInstance = Get-TargetResource @PSBoundParameters
    $setParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters
    $setParameters.Remove('Name') | Out-Null

    if ($Ensure -eq 'Present' -and $null -ne $TargetGroups)
    {
        $targetGroupsValue = @()
        foreach ($group in $TargetGroups)
        {
            $groupValue = ''
            $entry = Get-MgGroup -Filter "DisplayName eq '$group'" -ErrorAction SilentlyContinue
            if ($null -eq $entry)
            {
                $entry = Get-MgUser -UserId $group -ErrorAction SilentlyContinue
                $groupValue = $entry.Id
            }
            else
            {
                $groupValue = $entry.Id
            }

            if ($null -eq $entry)
            {
                Write-Error -Message "Could not find group or user identified with id {$group}"
            }
            else
            {
                $targetGroupsValue += $groupValue
            }
        }
        $setParameters.TargetGroups = $targetGroupsValue
    }

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating new device conditional access rule {$Name}"
        New-DeviceConditionalAccessRule @setParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        $setParameters.Remove('Policy') | Out-Null
        $setParameters.Add('Identity', $currentInstance.Name)
        Write-Verbose -Message "Updating device conditional access rule {$Name}"
        Set-DeviceConditionalAccessRule @setParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing device conditional access rule {$Name}"
        Remove-DeviceConditionalAccessRule -Identity $currentInstance.Name -Confirm:$false
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $TargetGroups,

        [Parameter()]
        [System.String]
        $AccountName,

        [Parameter()]
        [System.String]
        $AccountUserName,

        [Parameter()]
        [System.Boolean]
        $AllowAppStore,

        [Parameter()]
        [System.Boolean]
        $AllowAssistantWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowConvenienceLogon,

        [Parameter()]
        [System.Boolean]
        $AllowDiagnosticSubmission,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudBackup,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudDocSync,

        [Parameter()]
        [System.Boolean]
        $AllowiCloudPhotoSync,

        [Parameter()]
        [System.Boolean]
        $AllowJailbroken,

        [Parameter()]
        [System.Boolean]
        $AllowPassbookWhileLocked,

        [Parameter()]
        [System.Boolean]
        $AllowScreenshot,

        [Parameter()]
        [System.Boolean]
        $AllowSimplePassword,

        [Parameter()]
        [System.Boolean]
        $AllowVideoConferencing,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceAssistant,

        [Parameter()]
        [System.Boolean]
        $AllowVoiceDialing,

        [Parameter()]
        [System.UInt32]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.UInt32]
        $AntiVirusStatus,

        [Parameter()]
        [System.String]
        $AppsRating,

        [Parameter()]
        [System.String]
        $AutoUpdateStatus,

        [Parameter()]
        [System.Boolean]
        $BluetoothEnabled,

        [Parameter()]
        [System.Boolean]
        $CameraEnabled,

        [Parameter()]
        [System.String]
        $EmailAddress,

        [Parameter()]
        [System.Boolean]
        $EnableRemovableStorage,

        [Parameter()]
        [System.String]
        $ExchangeActiveSyncHost,

        [Parameter()]
        [System.Boolean]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.UInt32]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.UInt32]
        $PasswordComplexity,

        [Parameter()]
        [System.UInt32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.UInt32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.UInt32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.UInt32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.UInt32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.String]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [System.String]
        $RegionRatings,

        [Parameter()]
        [System.Boolean]
        $RequireEmailProfile,

        [Parameter()]
        [System.Boolean]
        $SmartScreenEnabled,

        [Parameter()]
        [System.Boolean]
        $SystemSecurityTLS,

        [Parameter()]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.String]
        $UserAccountControlStatus,

        [Parameter()]
        [System.Boolean]
        $WLANEnabled,

        [Parameter()]
        [System.String]
        $WorkFoldersSyncUrl,

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
    $ValuesToCheck.Remove('Name') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

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
        [array] $Script:exportedInstances = Get-DeviceConditionalAccessRule -ErrorAction Stop

        $i = 1
        $dscContent = ''
        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Name
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Name                  = $config.Name
                Policy                = $config.Name.Split('{')[0]
                TargetGroups          = $config.TargetGroups
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Script:exportedInstance = $config
            $Results = Get-TargetResource @Params
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
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
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
