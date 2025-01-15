function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation', 'CustomAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'Informational')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious', 'MaliciousUrlClick', 'MailFlow')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3, 2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60, 2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.Int32]
        $VolumeThreshold,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
        if (-not $Script:exportedInstance)
        {
            Write-Verbose -Message "Getting configuration of SCProtectionAlert for $Name"

            $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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

            $AlertObject = Get-ProtectionAlert -Identity $Name -ErrorAction SilentlyContinue

            if ($null -eq $AlertObject)
            {
                Write-Verbose -Message "SCProtectionAlert $Name does not exist."
                return $nullReturn
            }
        }
        else
        {
            $AlertObject = $Script:exportedInstance
        }

        Write-Verbose "Found existing SCProtectionAlert $($Name)"
        $result = @{
            Ensure                                                      = 'Present'
            AlertBy                                                     = $AlertObject.AlertBy
            AlertFor                                                    = $AlertObject.AlertFor
            AggregationType                                             = $AlertObject.AggregationType
            Category                                                    = $AlertObject.Category
            Comment                                                     = $AlertObject.Comment
            Credential                                                  = $Credential
            ApplicationId                                               = $ApplicationId
            TenantId                                                    = $TenantId
            CertificateThumbprint                                       = $CertificateThumbprint
            CertificatePath                                             = $CertificatePath
            CertificatePassword                                         = $CertificatePassword
            Disabled                                                    = $AlertObject.Disabled
            Filter                                                      = $AlertObject.Filter
            Name                                                        = $AlertObject.Name
            NotificationCulture                                         = $AlertObject.NotificationCulture
            NotificationEnabled                                         = $AlertObject.NotificationEnabled
            NotifyUserOnFilterMatch                                     = $AlertObject.NotifyUserOnFilterMatch
            NotifyUserSuppressionExpiryDate                             = $AlertObject.NotifyUserSuppressionExpiryDate
            NotifyUserThrottleThreshold                                 = $AlertObject.NotifyUserThrottleThreshold
            NotifyUserThrottleWindow                                    = $AlertObject.NotifyUserThrottleWindow
            NotifyUser                                                  = $AlertObject.NotifyUser
            Operation                                                   = $AlertObject.Operation
            PrivacyManagementScopedSensitiveInformationTypes            = $AlertObject.PrivacyManagementScopedSensitiveInformationTypes
            PrivacyManagementScopedSensitiveInformationTypesForCounting = $AlertObject.PrivacyManagementScopedSensitiveInformationTypesForCounting
            PrivacyManagementScopedSensitiveInformationTypesThreshold   = $AlertObject.PrivacyManagementScopedSensitiveInformationTypesThreshold
            Severity                                                    = $AlertObject.Severity
            ThreatType                                                  = $AlertObject.ThreatType
            Threshold                                                   = $AlertObject.Threshold
            TimeWindow                                                  = $AlertObject.TimeWindow
            VolumeThreshold                                             = $AlertObject.VolumeThreshold
            AccessTokens                                                = $AccessTokens
        }
        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
        return $result
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
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation', 'CustomAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'Informational')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious', 'MaliciousUrlClick', 'MailFlow')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3, 2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60, 2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.Int32]
        $VolumeThreshold,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )


    Write-Verbose -Message "Setting configuration of SCProtectionAlert for $Name"

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

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters

    $CurrentAlert = Get-TargetResource @PSBoundParameters

    $CreationParams = $PSBoundParameters
    $CreationParams.Remove('Ensure') | Out-Null

    # Remove authentication parameters
    $CreationParams.Remove('Credential') | Out-Null
    $CreationParams.Remove('ApplicationId') | Out-Null
    $CreationParams.Remove('TenantId') | Out-Null
    $CreationParams.Remove('CertificatePath') | Out-Null
    $CreationParams.Remove('CertificatePassword') | Out-Null
    $CreationParams.Remove('CertificateThumbprint') | Out-Null
    $CreationParams.Remove('ManagedIdentity') | Out-Null
    $CreationParams.Remove('ApplicationSecret') | Out-Null
    $CreationParams.Remove('AccessTokens') | Out-Null

    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentAlert.Ensure))
    {
        New-ProtectionAlert @CreationParams
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentAlert.Ensure))
    {
        $CreationParams.Remove('Name') | Out-Null
        $CreationParams.Remove('ThreatType') | Out-Null

        $Alert = Get-ProtectionAlert -Identity $Name
        $CreationParams.Add('Identity', $Alert.Name)

        Write-Verbose "Updating ProtectionAlert with values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        Set-ProtectionAlert @CreationParams
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentAlert.Ensure))
    {
        # If the Alert exists and it shouldn't, simply remove it;
        $Alert = Get-ProtectionAlert -Identity $Name
        Write-Verbose "Removing Protection alert $Name"
        Remove-ProtectionAlert -Identity $Alert.Identity -ForceDeletion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        [System.String[]]
        $AlertBy,

        [Parameter()]
        [System.String[]]
        $AlertFor,

        [Parameter()]
        [ValidateSet('None', 'SimpleAggregation', 'AnomalousAggregation', 'CustomAggregation')]
        [System.String]
        $AggregationType,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String]
        $Filter,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $NotificationCulture,

        [Parameter()]
        [System.Boolean]
        $NotificationEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyUserOnFilterMatch,

        [Parameter()]
        [System.DateTime]
        $NotifyUserSuppressionExpiryDate,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleThreshold,

        [Parameter()]
        [System.Int32]
        $NotifyUserThrottleWindow,

        [Parameter()]
        [System.String[]]
        $NotifyUser = @(),

        [Parameter()]
        [System.String[]]
        $Operation = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypes = @(),

        [Parameter()]
        [System.String[]]
        $PrivacyManagementScopedSensitiveInformationTypesForCounting = @(),

        [Parameter()]
        [System.UInt64]
        $PrivacyManagementScopedSensitiveInformationTypesThreshold,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'Informational')]
        [System.String]
        $Severity = 'Low',

        [Parameter()]
        [ValidateSet('Activity', 'Malware', 'Phish', 'Malicious', 'MaliciousUrlClick', 'MailFlow')]
        [System.String]
        $ThreatType,

        [Parameter()]
        [ValidateRange(3, 2147483647)]
        [System.Int32]
        $Threshold,

        [Parameter()]
        [ValidateRange(60, 2147483647)]
        [System.Int32]
        $TimeWindow,

        [Parameter()]
        [System.Int32]
        $VolumeThreshold,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message "Testing configuration of SCProtectionAlert for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters `
        -SkipModuleReload $true
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

    try
    {
        [array]$Alerts = Get-ProtectionAlert -ErrorAction Stop | Where-Object -FilterScript { -not $_.IsSystemRule }

        $totalAlerts = $Alerts.Length
        if ($null -eq $totalAlerts)
        {
            $totalAlerts = 1
        }
        $i = 1
        if ($totalAlerts.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $dscContent = ''
        foreach ($alert in $Alerts)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($totalAlerts)] $($alert.Name)" -NoNewline
            $Script:exportedInstance = $alert
            $Results = Get-TargetResource @PSBoundParameters -Name $Alert.Name
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
            $i++
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
