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
        [System.Int64]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.Int64]
        $AntiVirusStatus,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "Rating9Plus", "Rating12Plus", "Rating17Plus", "")]
        [System.String]
        $AppsRating,

        [Parameter()]
        [ValidateSet("AutomaticCheckForUpdates", "AutomaticDownloadUpdates", "AutomaticUpdatesRequired", "AutomaticUpdatesRequired", "NeverCheckUpdates", "")]
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
        [ValidateSet("Required", "")]
        [System.String]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.Int32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.TimeSpan]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.Int64]
        $PasswordComplexity,

        [Parameter()]
        [System.Int32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.Int32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.Int32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.Int32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.Int32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.TimeSpan]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [ValidateSet("au", "ca", "de", "fr", "gb", "ie", "jp", "nz", "us", "")]
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
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.Array]
        $TargetGroups,

        [Parameter()]
        [ValidateSet("AlwaysNotify", "AlwaysNotify", "NotifyAppChanges", "NotifyAppChangesDoNotDimdesktop", "")]
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

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount
    )

    Write-Verbose -Message "Getting configuration of the Device Conditional Acccess Rule for $Name"
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-O365DSCTelemetryEvent -Data $data
    #endregion

    Test-MSCloudLogin -O365Credential $GlobalAdminAccount `
        -Platform SecurityComplianceCenter

    $Rules = Get-DeviceConditionalAccessRule -Policy $Policy -ErrorAction 'SilentlyContinue'
    $Rule = $Rules | Where-Object { $_.Name -eq $Name }

    if ($null -eq $Rule)
    {
        Write-Verbose -Message "The Device Conditional Access Rule Policy $($Name) does not exist."
        $result = $PSBoundParameters
        $result.Ensure = 'Absent'
        return $result
    }
    else
    {
        Write-Verbose "Found an existing Device Conditional Access Rule $($Name)"

        $result = @{
            Name                          = $Rule.Name
            Policy                        = $Policy
            AccountName                   = $Rule.AccountName
            AccountUserName               = $Rule.AccountUserName
            AllowAppStore                 = $Rule.AllowAppStore
            AllowAssistantWhileLocked     = $Rule.AllowAssistantWhileLocked
            AllowConvenienceLogon         = $Rule.AllowConvenienceLogon
            AllowDiagnosticSubmission     = $Rule.AllowDiagnosticSubmission
            AllowiCloudBackup             = $Rule.AllowiCloudBackup
            AllowiCloudDocSync            = $Rule.AllowiCloudDocSync
            AllowiCloudPhotoSync          = $Rule.AllowiCloudPhotoSync
            AllowJailbroken               = $Rule.AllowJailbroken
            AllowPassbookWhileLocked      = $Rule.AllowPassbookWhileLocked
            AllowScreenshot               = $Rule.AllowScreenshot
            AllowSimplePassword           = $Rule.AllowSimplePassword
            AllowVideoConferencing        = $Rule.AllowVideoConferencing
            AllowVoiceAssistant           = $Rule.AllowVoiceAssistant
            AllowVoiceDialing             = $Rule.AllowVoiceDialing
            AntiVirusSignatureStatus      = $Rule.AntiVirusSignatureStatus
            AntiVirusStatus               = $Rule.AntiVirusStatus
            AppsRating                    = $Rule.AppsRating
            AutoUpdateStatus              = $Rule.AutoUpdateStatus
            BluetoothEnabled              = $Rule.BluetoothEnabled
            CameraEnabled                 = $Rule.CameraEnabled
            DomainController              = $Rule.DomainController
            EmailAddress                  = $Rule.EmailAddress
            EnableRemovableStorage        = $Rule.EnableRemovableStorage
            ExchangeActiveSyncHost        = $Rule.ExchangeActiveSyncHost
            FirewallStatus                = $Rule.FirewallStatus
            ForceAppStorePassword         = $Rule.ForceAppStorePassword
            ForceEncryptedBackup          = $Rule.ForceEncryptedBackup
            MaxPasswordAttemptsBeforeWipe = $Rule.MaxPasswordAttemptsBeforeWipe
            MaxPasswordGracePeriod        = $Rule.MaxPasswordGracePeriod
            MoviesRating                  = $Rule.MoviesRating
            PasswordComplexity            = $Rule.PasswordComplexity
            PasswordExpirationDays        = $Rule.PasswordExpirationDays
            PasswordHistoryCount          = $Rule.PasswordHistoryCount
            PasswordMinComplexChars       = $Rule.PasswordMinComplexChars
            PasswordMinimumLength         = $Rule.PasswordMinimumLength
            PasswordQuality               = $Rule.PasswordQuality
            PasswordRequired              = $Rule.PasswordRequired
            PasswordTimeout               = $Rule.PasswordTimeout
            PhoneMemoryEncrypted          = $Rule.PhoneMemoryEncrypted
            RegionRatings                 = $Rule.RegionRatings
            RequireEmailProfile           = $Rule.RequireEmailProfile
            SmartScreenEnabled            = $Rule.SmartScreenEnabled
            SystemSecurityTLS             = $Rule.SystemSecurityTLS
            TVShowsRating                 = $Rule.TVShowsRating
            UserAccountControlStatus      = $Rule.UserAccountControlStatus
            WLANEnabled                   = $Rule.WLANEnabled
            WorkFoldersSyncUrl            = $Rule.WorkFoldersSyncUrl
            GlobalAdminAccount            = $GlobalAdminAccount
            Ensure                        = 'Present'
        }

        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-O365DscHashtableToString -Hashtable $result)"
        return $result
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
        [System.Int64]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.Int64]
        $AntiVirusStatus,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "Rating9Plus", "Rating12Plus", "Rating17Plus", "")]
        [System.String]
        $AppsRating,

        [Parameter()]
        [ValidateSet("AutomaticCheckForUpdates", "AutomaticDownloadUpdates", "AutomaticUpdatesRequired", "AutomaticUpdatesRequired", "NeverCheckUpdates", "")]
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
        [ValidateSet("Required", "")]
        [System.String]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.Int32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.TimeSpan]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.Int64]
        $PasswordComplexity,

        [Parameter()]
        [System.Int32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.Int32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.Int32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.Int32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.Int32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.TimeSpan]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [ValidateSet("au", "ca", "de", "fr", "gb", "ie", "jp", "nz", "us", "")]
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
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.Array]
        $TargetGroups,

        [Parameter()]
        [ValidateSet("AlwaysNotify", "AlwaysNotify", "NotifyAppChanges", "NotifyAppChangesDoNotDimdesktop", "")]
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

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount
    )

    Write-Verbose -Message "Setting the configuration of the Device Conditional Access Rule for $Name"
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-O365DSCTelemetryEvent -Data $data
    #endregion

    Test-MSCloudLogin -O365Credential $GlobalAdminAccount `
        -Platform SecurityComplianceCenter

    $CurrentRule = Get-TargetResource @PSBoundParameters

    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentRule.Ensure))
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove("GlobalAdminAccount")
        $CreationParams.Remove("Ensure")

        Write-Verbose "Creating new Device Conditional Access Rule $Name calling the New-DeviceConditionalAccessRule cmdlet."
        New-DeviceConditionalAccessRule @CreationParams
    }
    # If a Device Conditional Access Rule exists and it should. Update it.
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentRule.Ensure))
    {
        $UpdateParams = @{
            Identity          = $Name
            Comment           = $Comment
            Disabled          = $Disabled
            ContentMatchQuery = $ContentMatchQuery
        }
        Write-Verbose "Updating the Device Conditional Access Rule $Name by calling the Set-DeviceConditionalAccessRule cmdlet."
        Set-DeviceConditionalAccessRule @UpdateParams
    }
    # If Device Conditional Access Rules exists but it shouldn't. Remove it.
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentTag.Ensure))
    {
        Remove-DeviceConditionalAccessRule -Identity $Name -Confirm:$false
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
        [System.Int64]
        $AntiVirusSignatureStatus,

        [Parameter()]
        [System.Int64]
        $AntiVirusStatus,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "Rating9Plus", "Rating12Plus", "Rating17Plus", "")]
        [System.String]
        $AppsRating,

        [Parameter()]
        [ValidateSet("AutomaticCheckForUpdates", "AutomaticDownloadUpdates", "AutomaticUpdatesRequired", "AutomaticUpdatesRequired", "NeverCheckUpdates", "")]
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
        [ValidateSet("Required", "")]
        [System.String]
        $FirewallStatus,

        [Parameter()]
        [System.Boolean]
        $ForceAppStorePassword,

        [Parameter()]
        [System.Boolean]
        $ForceEncryptedBackup,

        [Parameter()]
        [System.Int32]
        $MaxPasswordAttemptsBeforeWipe,

        [Parameter()]
        [System.TimeSpan]
        $MaxPasswordGracePeriod,

        [Parameter()]
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $MoviesRating,

        [Parameter()]
        [System.Int64]
        $PasswordComplexity,

        [Parameter()]
        [System.Int32]
        $PasswordExpirationDays,

        [Parameter()]
        [System.Int32]
        $PasswordHistoryCount,

        [Parameter()]
        [System.Int32]
        $PasswordMinComplexChars,

        [Parameter()]
        [System.Int32]
        $PasswordMinimumLength,

        [Parameter()]
        [System.Int32]
        $PasswordQuality,

        [Parameter()]
        [System.Boolean]
        $PasswordRequired,

        [Parameter()]
        [System.TimeSpan]
        $PasswordTimeout,

        [Parameter()]
        [System.Boolean]
        $PhoneMemoryEncrypted,

        [Parameter()]
        [ValidateSet("au", "ca", "de", "fr", "gb", "ie", "jp", "nz", "us", "")]
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
        [ValidateSet("AllowAll", "DontAllow", "")]
        [System.String]
        $TVShowsRating,

        [Parameter()]
        [System.Array]
        $TargetGroups,

        [Parameter()]
        [ValidateSet("AlwaysNotify", "AlwaysNotify", "NotifyAppChanges", "NotifyAppChangesDoNotDimdesktop", "")]
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

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount
    )

    Write-Verbose -Message "Testing configuration of the Device Conditional Access Rule for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    Write-Verbose -Message "Target Values: $(Convert-O365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('GlobalAdminAccount') | Out-Null

    $TestResult = Test-Office365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck $ValuesToCheck.Keys

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount
    )

    $InformationPreference = "Continue"
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-O365DSCTelemetryEvent -Data $data
    #endregion
    Test-MSCloudLogin -O365Credential $GlobalAdminAccount `
        -Platform SecurityComplianceCenter
    [array]$Rules = Get-DeviceConditionalAccessRule

    $dscContent = ""
    $i = 1
    foreach ($Rule in $Rules)
    {
        Write-Information "    - [$i/$($Rules.Count)] $($Rule.Name)"
        try
        {
            $policy = Get-DeviceConditionalAccessPolicy -Identity $Rule.Policy -ErrorAction Stop

            $params = @{
                Name               = $Rule.Name
                Policy             = $policy.Name
                GlobalAdminAccount = $GlobalAdminAccount
            }
            $result = Get-TargetResource @params
            $result.GlobalAdminAccount = Resolve-Credentials -UserName "globaladmin"
            $dscContent += "        DeviceConditionalAccessRule " + (New-GUID).ToString() + "`r`n"
            $dscContent += "        {`r`n"
            $currentDSCBlock = Get-DSCBlock -Params $result -ModulePath $PSScriptRoot
            $partialContent = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "GlobalAdminAccount"
            $partialContent += "        }`r`n"
            $dscContent += $partialContent
        }
        catch
        {
            Write-Information "You are not authorized to access the Device Conditional Access Policy {$($Rule.Policy)}"
        }
        $i++
    }
    return $dscContent
}

Export-ModuleMember -Function *-TargetResource
