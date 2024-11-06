function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ComplianceRecordingApplications,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $DisableComplianceRecordingAudioNotificationForCalls,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.Boolean]
        $WarnUserOnRemoval,

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

    New-M365DSCConnection -Workload 'MicrosoftTeams' `
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
        $instance = Get-CsTeamsComplianceRecordingPolicy -Identity $Identity -ErrorAction SilentlyContinue
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $ComplexComplianceRecordingApplications = @()
        if ($instance.ComplianceRecordingApplications.Count -gt 0)
        {
            foreach ($CurrentComplianceRecordingApplications in $instance.ComplianceRecordingApplications)
            {
                $MyComplianceRecordingApplications = @{}
                $ComplianceRecordingPairedApplications = @()
                if ($CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications.Count -gt 0)
                {
                    foreach ($CurrentComplianceRecordingPairedApplications in $CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications)
                    {
                        $ComplianceRecordingPairedApplications += $CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications.Id
                    }
                }
                $MyComplianceRecordingApplications.Add('ComplianceRecordingPairedApplications', $ComplianceRecordingPairedApplications)
                $MyComplianceRecordingApplications.Add('Id', $CurrentComplianceRecordingApplications.Id)
                $MyComplianceRecordingApplications.Add('RequiredBeforeMeetingJoin', $CurrentComplianceRecordingApplications.RequiredBeforeMeetingJoin)
                $MyComplianceRecordingApplications.Add('RequiredBeforeCallEstablishment', $CurrentComplianceRecordingApplications.RequiredBeforeCallEstablishment)
                $MyComplianceRecordingApplications.Add('RequiredDuringMeeting', $CurrentComplianceRecordingApplications.RequiredDuringMeeting)
                $MyComplianceRecordingApplications.Add('RequiredDuringCall', $CurrentComplianceRecordingApplications.RequiredDuringCall)
                $MyComplianceRecordingApplications.Add('ConcurrentInvitationCount', $CurrentComplianceRecordingApplications.ConcurrentInvitationCount)

                if ($MyComplianceRecordingApplications.values.Where({ $null -ne $_ }).count -gt 0)
                {
                    $ComplexComplianceRecordingApplications += $MyComplianceRecordingApplications
                }
            }
        }

        Write-Verbose -Message "Found an instance with Identity {$Identity}"
        $results = @{
            Identity                                            = $instance.Identity
            ComplianceRecordingApplications                     = $ComplexComplianceRecordingApplications
            Description                                         = $instance.Description
            DisableComplianceRecordingAudioNotificationForCalls = $instance.DisableComplianceRecordingAudioNotificationForCalls
            Enabled                                             = $instance.Enabled
            WarnUserOnRemoval                                   = $instance.WarnUserOnRemoval
            Ensure                                              = 'Present'
            Credential                                          = $Credential
            ApplicationId                                       = $ApplicationId
            TenantId                                            = $TenantId
            CertificateThumbprint                               = $CertificateThumbprint
            ManagedIdentity                                     = $ManagedIdentity.IsPresent
            AccessTokens                                        = $AccessTokens
        }
        return [System.Collections.Hashtable] $results
    }
    catch
    {
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
        $Identity,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ComplianceRecordingApplications,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $DisableComplianceRecordingAudioNotificationForCalls,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.Boolean]
        $WarnUserOnRemoval,

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

    New-M365DSCConnection -Workload 'MicrosoftTeams' `
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

    $currentInstance = Get-TargetResource @PSBoundParameters

    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null
    $PSBoundParameters.Remove('ManagedIdentity') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $CreateParameters = ([Hashtable]$PSBoundParameters).Clone()

        $CreateParameters.Remove('Verbose') | Out-Null

        $keys = $CreateParameters.Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $keyName = $key.substring(0, 1).ToLower() + $key.substring(1, $key.length - 1)
                $keyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
                $CreateParameters.Remove($key) | Out-Null
                $CreateParameters.Add($keyName, $keyValue)
            }
        }
        Write-Verbose -Message "Creating {$Identity} with Parameters:`r`n$(Convert-M365DscHashtableToString -Hashtable $CreateParameters)"
        New-CsTeamsComplianceRecordingPolicy @CreateParameters | Out-Null

        if ($ComplianceRecordingApplications.Count -gt 0)
        {
            foreach ($CurrentComplianceRecordingApplications in $ComplianceRecordingApplications)
            {
                $Instance = $CurrentComplianceRecordingApplications.Id
                $RequiredBeforeMeetingJoin = $CurrentComplianceRecordingApplications.RequiredBeforeMeetingJoin
                $RequiredBeforeCallEstablishment = $CurrentComplianceRecordingApplications.RequiredBeforeCallEstablishment
                $RequiredDuringMeeting = $CurrentComplianceRecordingApplications.RequiredDuringMeeting
                $RequiredDuringCall = $CurrentComplianceRecordingApplications.RequiredDuringCall
                $ConcurrentInvitationCount = $CurrentComplianceRecordingApplications.ConcurrentInvitationCount

                $CsTeamsComplianceRecordingApplication = Get-CsTeamsComplianceRecordingApplication -Identity $CsTeamsComplianceRecordingApplicationIdentity -ErrorAction SilentlyContinue
                if ($null -eq $CsTeamsComplianceRecordingApplication)
                {
                    New-CsTeamsComplianceRecordingApplication `
                        -RequiredBeforeMeetingJoin $RequiredBeforeMeetingJoin `
                        -RequiredBeforeCallEstablishment $RequiredBeforeCallEstablishment `
                        -RequiredDuringMeeting $RequiredDuringMeeting `
                        -RequiredDuringCall $RequiredDuringCall `
                        -ConcurrentInvitationCount $ConcurrentInvitationCount `
                        -Parent $Identity -Id $Instance
                }
                else
                {
                    Set-CsTeamsComplianceRecordingApplication `
                        -Identity $CsTeamsComplianceRecordingApplicationIdentity `
                        -RequiredBeforeMeetingJoin $RequiredBeforeMeetingJoin `
                        -RequiredBeforeCallEstablishment $RequiredBeforeCallEstablishment `
                        -RequiredDuringMeeting $RequiredDuringMeeting `
                        -RequiredDuringCall $RequiredDuringCall `
                        -ConcurrentInvitationCount $ConcurrentInvitationCount
                }

                if ($CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications.Count -gt 0)
                {
                    Set-CsTeamsComplianceRecordingApplication `
                        -Identity "$Identity + '/' + $Instance" `
                        -ComplianceRecordingPairedApplications @(New-CsTeamsComplianceRecordingPairedApplication `
                            -Id $CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications)
                }
            }
            $NewCsTeamsComplianceRecordingApplication = Get-CsTeamsComplianceRecordingApplication | Where-Object { $_.Identity -match $Identity }
            Set-CsTeamsComplianceRecordingPolicy -Identity $Identity -ComplianceRecordingApplications $NewCsTeamsComplianceRecordingApplication
        }

    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating {$Identity}"

        $UpdateParameters = ([Hashtable]$PSBoundParameters).Clone()
        $UpdateParameters.Remove('Verbose') | Out-Null

        $keys = $UpdateParameters.Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $keyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
                $UpdateParameters.Remove($key) | Out-Null
                $UpdateParameters.Add($keyName, $keyValue)
            }
        }

        Set-CsTeamsComplianceRecordingPolicy @UpdateParameters | Out-Null
        if ($ComplianceRecordingApplications.Count -gt 0)
        {
            foreach ($CurrentComplianceRecordingApplications in $ComplianceRecordingApplications)
            {
                $Instance = $CurrentComplianceRecordingApplications.Id
                $RequiredBeforeMeetingJoin = $CurrentComplianceRecordingApplications.RequiredBeforeMeetingJoin
                $RequiredBeforeCallEstablishment = $CurrentComplianceRecordingApplications.RequiredBeforeCallEstablishment
                $RequiredDuringMeeting = $CurrentComplianceRecordingApplications.RequiredDuringMeeting
                $RequiredDuringCall = $CurrentComplianceRecordingApplications.RequiredDuringCall
                $ConcurrentInvitationCount = $CurrentComplianceRecordingApplications.ConcurrentInvitationCount

                $CsTeamsComplianceRecordingApplicationIdentity = $Identity + '/' + $Instance

                $CsTeamsComplianceRecordingApplication = Get-CsTeamsComplianceRecordingApplication -Identity $CsTeamsComplianceRecordingApplicationIdentity -ErrorAction SilentlyContinue
                if ($null -eq $CsTeamsComplianceRecordingApplication)
                {
                    New-CsTeamsComplianceRecordingApplication `
                        -RequiredBeforeMeetingJoin $RequiredBeforeMeetingJoin `
                        -RequiredBeforeCallEstablishment $RequiredBeforeCallEstablishment `
                        -RequiredDuringMeeting $RequiredDuringMeeting `
                        -RequiredDuringCall $RequiredDuringCall `
                        -ConcurrentInvitationCount $ConcurrentInvitationCount `
                        -Parent $Identity -Id $Instance
                }
                else
                {
                    Set-CsTeamsComplianceRecordingApplication `
                        -Identity $CsTeamsComplianceRecordingApplicationIdentity `
                        -RequiredBeforeMeetingJoin $RequiredBeforeMeetingJoin `
                        -RequiredBeforeCallEstablishment $RequiredBeforeCallEstablishment `
                        -RequiredDuringMeeting $RequiredDuringMeeting `
                        -RequiredDuringCall $RequiredDuringCall `
                        -ConcurrentInvitationCount $ConcurrentInvitationCount
                }

                if ($CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications.Count -gt 0)
                {
                    [string]$CsTeamsComplianceRecordingApplicationIdentity = $Identity + '/' + $Instance
                    [string]$ComplianceRecordingPairedApplications = $CurrentComplianceRecordingApplications.ComplianceRecordingPairedApplications
                    Set-CsTeamsComplianceRecordingApplication -Identity $CsTeamsComplianceRecordingApplicationIdentity -ComplianceRecordingPairedApplications @(New-CsTeamsComplianceRecordingPairedApplication -Id $ComplianceRecordingPairedApplications)
                }
            }
            $NewCsTeamsComplianceRecordingApplication = Get-CsTeamsComplianceRecordingApplication | Where-Object { $_.Identity -match $Identity }
            Set-CsTeamsComplianceRecordingPolicy -Identity $Identity -ComplianceRecordingApplications $NewCsTeamsComplianceRecordingApplication
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing {$Identity}"
        Remove-CsTeamsComplianceRecordingPolicy -Identity $currentInstance.Identity
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
        $Identity,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ComplianceRecordingApplications,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $DisableComplianceRecordingAudioNotificationForCalls,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.Boolean]
        $WarnUserOnRemoval,

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

    Write-Verbose -Message "Testing configuration of {$Identity}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()
    $ValuesToCheck.Remove('Identity') | Out-Null

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($source.getType().Name -like '*CimInstance*')
        {
            $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $source

            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    #Convert any DateTime to String
    foreach ($key in $ValuesToCheck.Keys)
    {
        if (($null -ne $CurrentValues[$key]) `
                -and ($CurrentValues[$key].GetType().Name -eq 'DateTime'))
        {
            $CurrentValues[$key] = $CurrentValues[$key].toString()
        }
    }

    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
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
        [array]$getValue = Get-CsTeamsComplianceRecordingPolicy -ErrorAction Stop

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Identity
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Identity              = $config.Identity
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($null -ne $Results.ComplianceRecordingApplications)
            {
                $complexMapping = @(
                    @{
                        Name            = 'ComplianceRecordingApplications'
                        CimInstanceName = 'TeamsComplianceRecordingApplication'
                        IsRequired      = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ComplianceRecordingApplications `
                    -CIMInstanceName 'TeamsComplianceRecordingApplication' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ComplianceRecordingApplications = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ComplianceRecordingApplications') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.ComplianceRecordingApplications)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ComplianceRecordingApplications' -IsCIMArray:$True
                $currentDSCBlock = $currentDSCBlock.Replace('ComplianceRecordingApplications         = @("', 'ComplianceRecordingApplications         = @(')
                $currentDSCBlock = $currentDSCBlock.Replace("            `",`"`r`n", '')

            }
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
