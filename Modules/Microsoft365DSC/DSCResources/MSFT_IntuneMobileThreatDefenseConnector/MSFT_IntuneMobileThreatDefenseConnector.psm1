# https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-mobilethreatdefenseconnector?view=graph-rest-1.0
# https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.devicemanagement.administration/new-mgdevicemanagementmobilethreatdefenseconnector?view=graph-powershell-1.0

function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune parameters

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosPersonalApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AndroidDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $AndroidEnabled,

        [Parameter()]
        [System.Boolean]
        $AndroidMobileApplicationManagementEnabled,

        [Parameter()]
        [System.Boolean]
        $IosDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $IosEnabled,

        [Parameter()]
        [System.Boolean]
        $IosMobileApplicationManagementEnabled,

        [Parameter()]
        [System.DateTime]
        $LastHeartbeatDateTime,

        [Parameter()]
        [System.Boolean]
        $MicrosoftDefenderForEndpointAttachEnabled,

        [Parameter()]
        [System.String]
        $PartnerState,

        [Parameter()]
        [System.Int32]
        $PartnerUnresponsivenessThresholdInDays,

        [Parameter()]
        [System.Boolean]
        $PartnerUnsupportedOSVersionBlocked,

        [Parameter()]
        [System.Boolean]
        $WindowsDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $WindowsEnabled,

        #endregion Intune parameters

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

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
    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Id -eq $Id}
        }
        else
        {
            $instance = Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MobileThreatDefenseConnectorId $Id -ErrorAction Stop
        }

        if ($null -eq $instance)
        {
            Write-Verbose -Message "Could not find MobileThreatDefenseConnector by Id: {$Id}."
            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                # There is no API which searches MobileThreatDefenseConnector by its DisplayName so the below code is commented out.
                # $instance = Get-MgBetaDeviceManagementMobileThreatDefenseConnector `
                #       -Filter "DisplayName eq '$DisplayName'" `

                # The DisplayName property is not supported by the any API of this resource, hence hard-coded in below function for convenience.
                $connectorId = (Get-MobileThreatDefenseConnectorIdOrDisplayName -DisplayName $DisplayName).Id
                $instance = Get-MgBetaDeviceManagementMobileThreatDefenseConnector `
                    -MobileThreatDefenseConnectorId $connectorId
                    -ErrorAction SilentlyContinue
            }

            if ($null -eq $instance)
            {
                Write-Verbose -Message "Could not find MobileThreatDefenseConnector by DisplayName: {$DisplayName}."
                return $nullResult
            }
        }

        if([string]::IsNullOrEmpty($DisplayName))
        {
            $DisplayName = (Get-MobileThreatDefenseConnectorIdOrDisplayName -Id $instance.Id).DisplayName
        }

        $results = @{
            Id                                             = $instance.Id
            DisplayName                                    = $DisplayName
            ResponseHeadersVariable                        = $instance.ResponseHeadersVariable
            AllowPartnerToCollectIosApplicationMetadata    = $instance.AllowPartnerToCollectIosApplicationMetadata
            AllowPartnerToCollectIosPersonalApplicationMetadata = $instance.AllowPartnerToCollectIosPersonalApplicationMetadata
            AndroidDeviceBlockedOnMissingPartnerData       = $instance.AndroidDeviceBlockedOnMissingPartnerData
            AndroidEnabled                                 = $instance.AndroidEnabled
            AndroidMobileApplicationManagementEnabled      = $instance.AndroidMobileApplicationManagementEnabled
            IosDeviceBlockedOnMissingPartnerData           = $instance.IosDeviceBlockedOnMissingPartnerData
            IosEnabled                                     = $instance.IosEnabled
            IosMobileApplicationManagementEnabled          = $instance.IosMobileApplicationManagementEnabled
            LastHeartbeatDateTime                          = $instance.LastHeartbeatDateTime
            MicrosoftDefenderForEndpointAttachEnabled      = $instance.MicrosoftDefenderForEndpointAttachEnabled
            PartnerState                                   = $instance.PartnerState.ToString()
            PartnerUnresponsivenessThresholdInDays         = $instance.PartnerUnresponsivenessThresholdInDays
            PartnerUnsupportedOSVersionBlocked             = $instance.PartnerUnsupportedOSVersionBlocked
            WindowsDeviceBlockedOnMissingPartnerData       = $instance.WindowsDeviceBlockedOnMissingPartnerData
            WindowsEnabled                                 = $instance.WindowsEnabled

            Ensure                                         = 'Present'
            Credential                                     = $Credential
            ApplicationId                                  = $ApplicationId
            TenantId                                       = $TenantId
            CertificateThumbprint                          = $CertificateThumbprint
            ApplicationSecret                              = $ApplicationSecret
            ManagedIdentity                                = $ManagedIdentity.IsPresent
            AccessTokens                                   = $AccessTokens
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
        #region Intune parameters

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosPersonalApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AndroidDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $AndroidEnabled,

        [Parameter()]
        [System.Boolean]
        $AndroidMobileApplicationManagementEnabled,

        [Parameter()]
        [System.Boolean]
        $IosDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $IosEnabled,

        [Parameter()]
        [System.Boolean]
        $IosMobileApplicationManagementEnabled,

        [Parameter()]
        [System.DateTime]
        $LastHeartbeatDateTime,

        [Parameter()]
        [System.Boolean]
        $MicrosoftDefenderForEndpointAttachEnabled,

        [Parameter()]
        [System.String]
        $PartnerState,

        [Parameter()]
        [System.Int32]
        $PartnerUnresponsivenessThresholdInDays,

        [Parameter()]
        [System.Boolean]
        $PartnerUnsupportedOSVersionBlocked,

        [Parameter()]
        [System.Boolean]
        $WindowsDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $WindowsEnabled,

        #endregion Intune parameters

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
    $SetParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    # Remove the DisplayName parameter as the Graph API does not support it
    $SetParameters.Remove('DisplayName') | Out-Null
    $SetParameters.Remove('Id') | Out-Null
    $SetParameters.Remove('LastHeartbeatDateTime') | Out-Null

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        New-MgBetaDeviceManagementMobileThreatDefenseConnector @SetParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Update-MgBetaDeviceManagementMobileThreatDefenseConnector -MobileThreatDefenseConnectorId $currentInstance.Id @SetParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Remove-MgBetaDeviceManagementMobileThreatDefenseConnector -MobileThreatDefenseConnectorId $currentInstance.Id -Confirm:$false
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region Intune parameters

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AllowPartnerToCollectIosPersonalApplicationMetadata,

        [Parameter()]
        [System.Boolean]
        $AndroidDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $AndroidEnabled,

        [Parameter()]
        [System.Boolean]
        $AndroidMobileApplicationManagementEnabled,

        [Parameter()]
        [System.Boolean]
        $IosDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $IosEnabled,

        [Parameter()]
        [System.Boolean]
        $IosMobileApplicationManagementEnabled,

        [Parameter()]
        [System.DateTime]
        $LastHeartbeatDateTime,

        [Parameter()]
        [System.Boolean]
        $MicrosoftDefenderForEndpointAttachEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('unavailable', 'available', 'enabled', 'unresponsive', 'notSetUp', 'error')]
        $PartnerState,

        [Parameter()]
        [System.Int32]
        $PartnerUnresponsivenessThresholdInDays,

        [Parameter()]
        [System.Boolean]
        $PartnerUnsupportedOSVersionBlocked,

        [Parameter()]
        [System.Boolean]
        $WindowsDeviceBlockedOnMissingPartnerData,

        [Parameter()]
        [System.Boolean]
        $WindowsEnabled,

        #endregion Intune parameters

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
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
        [array] $Script:exportedInstances = Get-MgBetaDeviceManagementMobileThreatDefenseConnector -ErrorAction Stop

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
            $displayedKey = $config.Id
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                                             = $config.Id
                DisplayName                                    = $config.DisplayName
                AllowPartnerToCollectIosApplicationMetadata    = $config.AllowPartnerToCollectIosApplicationMetadata
                AllowPartnerToCollectIosPersonalApplicationMetadata = $config.AllowPartnerToCollectIosPersonalApplicationMetadata
                AndroidDeviceBlockedOnMissingPartnerData       = $config.AndroidDeviceBlockedOnMissingPartnerData
                AndroidEnabled                                 = $config.AndroidEnabled
                AndroidMobileApplicationManagementEnabled      = $config.AndroidMobileApplicationManagementEnabled
                IosDeviceBlockedOnMissingPartnerData           = $config.IosDeviceBlockedOnMissingPartnerData
                IosEnabled                                     = $config.IosEnabled
                IosMobileApplicationManagementEnabled          = $config.IosMobileApplicationManagementEnabled
                LastHeartbeatDateTime                          = $config.LastHeartbeatDateTime
                MicrosoftDefenderForEndpointAttachEnabled      = $config.MicrosoftDefenderForEndpointAttachEnabled
                PartnerState                                   = $config.PartnerState.ToString()
                PartnerUnresponsivenessThresholdInDays         = $config.PartnerUnresponsivenessThresholdInDays
                PartnerUnsupportedOSVersionBlocked             = $config.PartnerUnsupportedOSVersionBlocked
                WindowsDeviceBlockedOnMissingPartnerData       = $config.WindowsDeviceBlockedOnMissingPartnerData
                WindowsEnabled                                 = $config.WindowsEnabled

                Ensure                                         = 'Present'
                Credential                                     = $Credential
                ApplicationId                                  = $ApplicationId
                TenantId                                       = $TenantId
                CertificateThumbprint                          = $CertificateThumbprint
                ApplicationSecret                              = $ApplicationSecret
                ManagedIdentity                                = $ManagedIdentity.IsPresent
                AccessTokens                                   = $AccessTokens
            }

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

#region Helper functions

function Get-MobileThreatDefenseConnectorIdOrDisplayName {
    param (
        [Parameter(Mandatory = $false)]
        [string]$Id,

        [Parameter(Mandatory = $false)]
        [string]$DisplayName
    )

    # Hashtable mapping IDs to Display Names
    $IdToDisplayNameMap = @{
        "fc780465-2017-40d4-a0c5-307022471b92" = "Microsoft Defender for Endpoint"
        "860d3ab4-8fd1-45f5-89cd-ecf51e4f92e5" = "BETTER Mobile Security"
        "d3ddeae8-441f-4681-b80f-aef644f7195a" = "Check Point Harmony Mobile"
        "8d0ed095-8191-4bd3-8a41-953b22d51ff7" = "Pradeo"
        "1f58d6d2-02cc-4c80-b008-1bfe7396a10a" = "Jamf Trust"
        "4873197-ffec-4dfc-9816-db65f34c7cb9"  = "Trellix Mobile Security"
        "a447eca6-a986-4d3f-9838-5862bf50776c" = "CylancePROTECT Mobile"
        "4928f0f6-2660-4f69-b4c5-5170ec921f7b" = "Trend Micro"
        "bb13fe25-ce1f-45aa-b278-cabbc6b9072e" = "SentinelOne"
        "e6f777f8-e4c2-4a5b-be01-50b5c124bc7f" = "Windows Security Center"
        "29ee2d98-e795-475f-a0f8-0802dc3384a9" = "CrowdStrike Falcon for Mobile"
        "870b252b-0ef0-4707-8847-50fc571472b3" = "Sophos"
        "2c7790de-8b02-4814-85cf-e0c59380dee8" = "Lookout for Work"
        "28fd67fd-b179-4629-a8b0-dad420b697c7" = "Symantec Endpoint Protection"
        "08a8455c-48dd-45ff-ad82-7211355354f3" = "Zimperium"
    }

    # If Id is provided, look up the DisplayName
    if($null -ne $Id)
    {
        $displayName = $IdToDisplayNameMap[$Id]
    }

    # If DisplayName is provided, look up the Id
    # Create a reverse lookup hashtable for DisplayName to Id
    $DisplayNameToIdMap = @{}
    foreach ($key in $IdToDisplayNameMap.Keys) {
        $DisplayNameToIdMap[$IdToDisplayNameMap[$key]] = $key
    }
    if (-not [string]::IsNullOrEmpty($DisplayName)) {
        $Id = $DisplayNameToIdMap[$DisplayName]
        if (-not $Id) {
            Write-Host "Internal func: DisplayName '$DisplayName' not found."
            return
        }
    }

    # Create the results tuple
    return @{
        Id = $Id
        DisplayName = $displayName
    }
}

Export-ModuleMember -Function *-TargetResource
