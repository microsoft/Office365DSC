function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $GroupDisplayName,

        [Parameter()]
        [System.String]
        $GroupId,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ApplicationAccessPolicy','CallingLineIdentity','OnlineAudioConferencingRoutingPolicy','OnlineVoicemailPolicy','OnlineVoiceRoutingPolicy','TeamsAudioConferencingPolicy','TeamsCallHoldPolicy','TeamsCallParkPolicy','TeamsChannelsPolicy','TeamsComplianceRecordingPolicy','TeamsCortanaPolicy','TeamsEmergencyCallingPolicy','TeamsEnhancedEncryptionPolicy','TeamsFeedbackPolicy','TeamsFilesPolicy','TeamsIPPhonePolicy','TeamsMediaLoggingPolicy','TeamsMeetingBroadcastPolicy','TeamsMeetingPolicy','TeamsMessagingPolicy','TeamsMobilityPolicy','TeamsRoomVideoTeleConferencingPolicy','TeamsShiftsPolicy','TeamsUpdateManagementPolicy','TeamsVdiPolicy','TeamsVideoInteropServicePolicy','TenantDialPlan','ExternalAccessPolicy','TeamsAppSetupPolicy','TeamsCallingPolicy','TeamsEventsPolicy','TeamsMeetingBrandingPolicy','TeamsMeetingTemplatePermissionPolicy','TeamsVerticalPackagePolicy')]
        [System.String]
        $PolicyType,

        [Parameter()]
        [System.String]
        $PolicyName,

        [Parameter()]
        [System.String]
        $Priority,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' -InboundParameters $PSBoundParameters

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
        Write-Verbose -Message "Getting Group with Id {$GroupId}"
        if ($GroupId -match '\b[A-Fa-f0-9]{8}(?:-[A-Fa-f0-9]{4}){3}-[A-Fa-f0-9]{12}\b' -and $GroupId -ne '00000000-0000-0000-0000-000000000000'){
            $Group = Find-CsGroup -SearchQuery $GroupId -ExactMatchOnly $true -ErrorAction SilentlyContinue
        }
        else {
            $Group = $null
        }
        if ($null -eq $Group)
        {
            Write-Verbose -Message "Could not find Group with Id {$GroupId}, searching with DisplayName {$GroupDisplayName}"
            $Group = Find-CsGroup -SearchQuery $GroupDisplayName -ExactMatchOnly $true -ErrorAction SilentlyContinue

            if ($null -eq $Group)
            {
                Write-Verbose -Message "Could not find Group with DisplayName {$GroupDisplayName}"
                return $nullReturn
            }

            if ($Group -and $Group.Count -gt 1)
            {
                Write-Verbose -Message "Found $($Group.Count) groups with DisplayName {$GroupDisplayName}"
                $Group = $Group | Where-Object -FilterScript { $_.DisplayName -eq $GroupDisplayName }
                if ($Group -and $Group.Count -gt 1)
                {
                    Write-Verbose -Message "Still found $($Group.Count) groups with DisplayName {$GroupDisplayName}"
                    return $nullReturn
                }
            }
        }

        Write-Verbose -Message "Getting GroupPolicyAssignment with PolicyType {$PolicyType} for Group {$($Group.DisplayName)}"
        $GroupPolicyAssignment = Get-CsGroupPolicyAssignment -GroupId $Group.Id -PolicyType $PolicyType -ErrorAction SilentlyContinue
        if ($null -eq $GroupPolicyAssignment)
        {
            Write-Verbose -Message "GroupPolicyAssignment not found for Group {$GroupDisplayName}"
            $nullReturn.GroupId = $Group.Id
            return $nullReturn
        }

        $Message = "Found GroupPolicyAssignment with PolicyType {$($GroupPolicyAssignment.PolicyType)}, " + `
            "PolicyName {$($GroupPolicyAssignment.PolicyName)} and Priority {$($GroupPolicyAssignment.Priority)} for Group {$($Group.Displayname)}"
        Write-Verbose -Message $Message
        return @{
            GroupId               = $Group.Id
            GroupDisplayName      = $Group.Displayname
            PolicyType            = $GroupPolicyAssignment.PolicyType
            PolicyName            = $GroupPolicyAssignment.PolicyName
            Priority              = $GroupPolicyAssignment.Priority
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
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
        [System.String]
        $GroupDisplayName,

        [Parameter()]
        [System.String]
        $GroupId,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ApplicationAccessPolicy','CallingLineIdentity','OnlineAudioConferencingRoutingPolicy','OnlineVoicemailPolicy','OnlineVoiceRoutingPolicy','TeamsAudioConferencingPolicy','TeamsCallHoldPolicy','TeamsCallParkPolicy','TeamsChannelsPolicy','TeamsComplianceRecordingPolicy','TeamsCortanaPolicy','TeamsEmergencyCallingPolicy','TeamsEnhancedEncryptionPolicy','TeamsFeedbackPolicy','TeamsFilesPolicy','TeamsIPPhonePolicy','TeamsMediaLoggingPolicy','TeamsMeetingBroadcastPolicy','TeamsMeetingPolicy','TeamsMessagingPolicy','TeamsMobilityPolicy','TeamsRoomVideoTeleConferencingPolicy','TeamsShiftsPolicy','TeamsUpdateManagementPolicy','TeamsVdiPolicy','TeamsVideoInteropServicePolicy','TenantDialPlan','ExternalAccessPolicy','TeamsAppSetupPolicy','TeamsCallingPolicy','TeamsEventsPolicy','TeamsMeetingBrandingPolicy','TeamsMeetingTemplatePermissionPolicy','TeamsVerticalPackagePolicy')]
        [System.String]
        $PolicyType,

        [Parameter()]
        [System.String]
        $PolicyName,

        [Parameter()]
        [System.String]
        $Priority,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' -InboundParameters $PSBoundParameters
    $CurrentValues = Get-TargetResource @PSBoundParameters

    try
    {
        if ($Ensure -eq 'Present' -and $CurrentValues.Ensure -eq 'Absent')
        {
            Write-Verbose -Message "Adding GroupPolicyAssignment for $GroupDisplayName"
            $parameters = @{
                GroupId    = $CurrentValues.GroupId
                PolicyType = $PolicyType
                PolicyName = $PolicyName
            }

            if (-not [System.String]::IsNullOrEmpty($Priority))
            {
                $parameters.Add('Rank', $Priority)
            }
            New-CsGroupPolicyAssignment @parameters `
                -ErrorAction Stop
        }
        elseif ($Ensure -eq 'Present' -and $CurrentValues.Ensure -eq 'Present')
        {
            #Set-CsGroupPolicyAssignment not implemented jet / use remove-add as described in docs
            Write-Verbose -Message "Remove GroupPolicyAssignment for $GroupDisplayName"
            Remove-CsGroupPolicyAssignment -GroupId $CurrentValues.GroupId -PolicyType $CurrentValues.PolicyType
            Write-Verbose -Message "Adding GroupPolicyAssignment for $GroupDisplayName"
            New-CsGroupPolicyAssignment -GroupId $CurrentValues.GroupId `
                -PolicyType $PolicyType `
                -PolicyName $PolicyName `
                -Rank $Priority `
                -ErrorAction Stop
        }
        elseif ($Ensure -eq 'Absent' -and $CurrentValues.Ensure -eq 'Present')
        {
            Write-Verbose -Message "Remove GroupPolicyAssignment for $GroupDisplayName"
            Remove-CsGroupPolicyAssignment -GroupId $CurrentValues.GroupId -PolicyType $CurrentValues.PolicyType
        }
    }
    catch
    {
        Write-Verbose -Message "Error: $($_.Exception.Message)"
        New-M365DSCLogEntry -Message "Error while setting GroupPolicyAssignment for $GroupDisplayName" `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential
        throw $_
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
        $GroupDisplayName,

        [Parameter()]
        [System.String]
        $GroupId,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ApplicationAccessPolicy','CallingLineIdentity','OnlineAudioConferencingRoutingPolicy','OnlineVoicemailPolicy','OnlineVoiceRoutingPolicy','TeamsAudioConferencingPolicy','TeamsCallHoldPolicy','TeamsCallParkPolicy','TeamsChannelsPolicy','TeamsComplianceRecordingPolicy','TeamsCortanaPolicy','TeamsEmergencyCallingPolicy','TeamsEnhancedEncryptionPolicy','TeamsFeedbackPolicy','TeamsFilesPolicy','TeamsIPPhonePolicy','TeamsMediaLoggingPolicy','TeamsMeetingBroadcastPolicy','TeamsMeetingPolicy','TeamsMessagingPolicy','TeamsMobilityPolicy','TeamsRoomVideoTeleConferencingPolicy','TeamsShiftsPolicy','TeamsUpdateManagementPolicy','TeamsVdiPolicy','TeamsVideoInteropServicePolicy','TenantDialPlan','ExternalAccessPolicy','TeamsAppSetupPolicy','TeamsCallingPolicy','TeamsEventsPolicy','TeamsMeetingBrandingPolicy','TeamsMeetingTemplatePermissionPolicy','TeamsVerticalPackagePolicy')]
        [System.String]
        $PolicyType,

        [Parameter()]
        [System.String]
        $PolicyName,

        [Parameter()]
        [System.String]
        $Priority,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()
    $ValuesToCheck.Remove('GroupId') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $InformationPreference = 'Continue'
    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' -InboundParameters $PSBoundParameters

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
        [array]$instances = Get-CsGroupPolicyAssignment
        if ($instances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $dscContent = [System.Text.StringBuilder]::new()
        $j = 1
        foreach ($item in $instances)
        {
            [array]$Group = Find-CsGroup -SearchQuery $item.GroupId -ExactMatchOnly $true
            if ($null -eq $Group -or $null -eq $Group.DisplayName)
            {
                $Message = "Group with Id {$($item.GroupId)} could not be found, skipping assignment"
                Write-Host $Message
                New-M365DSCLogEntry -Message "Error during Export: $Message" `
                    -Source $($MyInvocation.MyCommand.Source) `
                    -TenantId $TenantId `
                    -Credential $Credential

                continue
            }

            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$j/$($instances.Length)] GroupPolicyAssignment {$($Group.DisplayName)-$($item.PolicyType)}" -NoNewline
            $results = @{
                GroupDisplayName      = $Group.DisplayName
                GroupId               = $item.GroupId
                PolicyType            = $item.PolicyType
                PolicyName            = $item.PolicyName
                Priority              = $item.Priority
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }
            #$results = Get-TargetResource @getParams
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            $dscContent.Append($currentDSCBlock) | Out-Null
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            Write-Host $Global:M365DSCEmojiGreenCheckMark

            $j++
        }
        return $dscContent.ToString()
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
