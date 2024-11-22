function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [ValidateRange(15,180)]
        [System.UInt16]
        $AgentAlertTime,

        [Parameter()]
        [System.Boolean]
        $AllowOptOut,

        [Parameter()]
        [System.String[]]
        $DistributionLists,

        [Parameter()]
        [System.Boolean]
        $UseDefaultMusicOnHold,

        [Parameter()]
        [System.String]
        $WelcomeMusicAudioFileId,

        [Parameter()]
        [System.String]
        $MusicOnHoldAudioFileId,

        [Parameter()]
        [ValidateSet("DisconnectWithBusy","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $OverflowAction,

        [Parameter()]
        [System.String]
        $OverflowActionTarget,

        [Parameter()]
        [ValidateRange(0,200)]
        [System.UInt16]
        $OverflowThreshold,

        [Parameter()]
        [ValidateSet("Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $TimeoutAction,

        [Parameter()]
        [ValidateSet("Queue","Forward","Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $NoAgentAction,


        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $TimeoutActionTarget,

        [Parameter()]
        [System.String]
        $NoAgentActionTarget,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [ValidateRange(0,2700)]
        [System.UInt16]
        $TimeoutThreshold,

        [Parameter()]
        [ValidateSet("Attendant","Serial","RoundRobin","LongestIdle")]
        [System.String]
        $RoutingMethod,

        [Parameter()]
        [System.Boolean]
        $PresenceBasedRouting,

        [Parameter()]
        [System.Boolean]
        $ConferenceMode,

        [Parameter()]
        [System.String[]]
        $Users,

        [Parameter()]
        [System.String]
        $LanguageId,

        [Parameter()]
        [System.String[]]
        $OboResourceAccountIds,

        [Parameter()]
        [System.String]
        $WelcomeMusicFileName,

        [Parameter()]
        [System.String]
        $WelcomeTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $ChannelId,

        [Parameter()]
        [System.String]
        $ChannelUserObjectId,

        [Parameter()]
        [System.String[]]
        $AuthorizedUsers,

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

    Write-Verbose -Message "Getting configuration of Teams Call Queue {$Name}"

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
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
        if (-not $Script:ExportMode)
        {
            Write-Host -Message "Getting Office 365 queue $Name"
            $queue = Get-CsCallQueue -NameFilter $Name `
                -ErrorAction SilentlyContinue | Where-Object -FilterScript {$_.Name -eq $Name}
        }
        else
        {
            Write-Host -Message "Retrieving queue $Name from the exported instances"
            $queue = $Script:exportedInstances | Where-Object -FilterScript {$_.Name -eq $Name}
        }


        if ($null -eq $queue)
        {
            return $nullReturn
        }
        else
        {
            return @{
                Name                                                 = $queue.Name
                AgentAlertTime                                       = $queue.AgentAlertTime
                AllowOptOut                                          = $queue.AllowOptOut
                DistributionLists                                    = [String[]]$queue.DistributionLists
                UseDefaultMusicOnHold                                = $queue.UseDefaultMusicOnHold
                WelcomeMusicAudioFileId                              = $queue.WelcomeMusicAudioFileId
                MusicOnHoldAudioFileId                               = $queue.MusicOnHoldAudioFileId
                MusicOnHoldFileName                                  = $queue.MusicOnHoldFileName
                NoAgentAction                                        = $queue.NoAgentAction
                NoAgentActionTarget                                  = $queue.NoAgentActionTarget
                NoAgentSharedVoicemailTextToSpeechPrompt             = $queue.NoAgentSharedVoicemailTextToSpeechPrompt
                NoAgentSharedVoicemailAudioFilePrompt                = $queue.NoAgentSharedVoicemailAudioFilePrompt
                NoAgentSharedVoicemailAudioFilePromptFileName        = $queue.NoAgentSharedVoicemailAudioFilePromptFileName
                EnableNoAgentSharedVoicemailTranscription            = $queue.EnableNoAgentSharedVoicemailTranscription
                EnableNoAgentSharedVoicemailSystemPromptSuppression  = $queue.EnableNoAgentSharedVoicemailSystemPromptSuppression
                OverflowAction                                       = $queue.OverflowAction
                OverflowActionTarget                                 = $queue.OverflowActionTarget.Id
                OverflowThreshold                                    = $queue.OverflowThreshold
                TimeoutAction                                        = $queue.TimeoutAction
                TimeoutActionTarget                                  = $queue.TimeoutActionTarget.Id
                TimeoutThreshold                                     = $queue.TimeoutThreshold
                RoutingMethod                                        = $queue.RoutingMethod
                PresenceBasedRouting                                 = $queue.PresenceBasedRouting
                ConferenceMode                                       = $queue.ConferenceMode
                Users                                                = [String[]]$queue.Users
                LanguageId                                           = $queue.LanguageId
                WelcomeMusicFileName                                 = $queue.WelcomeMusicFileName
                WelcomeTextToSpeechPrompt                            = $queue.WelcomeTextToSpeechPrompt
                OboResourceAccountIds                                = [String[]]$queue.OboResourceAccountIds
                OverflowDisconnectTextToSpeechPrompt                 = $queue.OverflowDisconnectTextToSpeechPrompt
                OverflowDisconnectAudioFilePrompt                    = $queue.OverflowDisconnectAudioFilePrompt
                OverflowRedirectPersonAudioFilePromptFileName        = $queue.OverflowRedirectPersonAudioFilePromptFileName
                OverflowRedirectPersonTextToSpeechPrompt             = $queue.OverflowRedirectPersonTextToSpeechPrompt
                OverflowRedirectPersonAudioFilePrompt                = $queue.OverflowRedirectPersonAudioFilePrompt
                OverflowRedirectVoicemailAudioFilePromptFileName     = $queue.OverflowRedirectVoicemailAudioFilePromptFileName
                OverflowRedirectVoiceAppTextToSpeechPrompt           = $queue.OverflowRedirectVoiceAppTextToSpeechPrompt
                OverflowRedirectVoiceAppAudioFilePrompt              = $queue.OverflowRedirectVoiceAppAudioFilePrompt
                OverflowRedirectPhoneNumberTextToSpeechPrompt        = $queue.OverflowRedirectPhoneNumberTextToSpeechPrompt
                OverflowRedirectPhoneNumberAudioFilePrompt           = $queue.OverflowRedirectPhoneNumberAudioFilePrompt
                OverflowRedirectPhoneNumberAudioFilePromptFileName   = $queue.OverflowRedirectPhoneNumberAudioFilePromptFileName
                OverflowRedirectVoicemailTextToSpeechPrompt          = $queue.OverflowRedirectVoicemailTextToSpeechPrompt
                OverflowRedirectVoicemailAudioFilePrompt             = $queue.OverflowRedirectVoicemailAudioFilePrompt
                OverflowRedirectVoiceAppAudioFilePromptFileName      = $queue.OverflowRedirectVoiceAppAudioFilePromptFileName
                OverflowSharedVoicemailTextToSpeechPrompt            = $queue.OverflowSharedVoicemailTextToSpeechPrompt
                OverflowSharedVoicemailAudioFilePrompt               = $queue.OverflowSharedVoicemailAudioFilePrompt
                EnableOverflowSharedVoicemailTranscription           = $queue.EnableOverflowSharedVoicemailTranscription
                EnableOverflowSharedVoicemailSystemPromptSuppression = $queue.EnableOverflowSharedVoicemailSystemPromptSuppression
                TimeoutDisconnectTextToSpeechPrompt                  = $queue.TimeoutDisconnectTextToSpeechPrompt
                TimeoutDisconnectAudioFilePrompt                     = $queue.TimeoutDisconnectAudioFilePrompt
                TimeoutDisconnectAudioFilePromptFileName             = $queue.TimeoutDisconnectAudioFilePromptFileName
                TimeoutRedirectPersonTextToSpeechPrompt              = $queue.TimeoutRedirectPersonTextToSpeechPrompt
                TimeoutRedirectPersonAudioFilePrompt                 = $queue.TimeoutRedirectPersonAudioFilePrompt
                TimeoutRedirectPersonAudioFilePromptFileName         = $queue.TimeoutRedirectPersonAudioFilePromptFileName
                TimeoutRedirectVoiceAppTextToSpeechPrompt            = $queue.TimeoutRedirectVoiceAppTextToSpeechPrompt
                TimeoutRedirectVoiceAppAudioFilePrompt               = $queue.TimeoutRedirectVoiceAppAudioFilePrompt
                TimeoutRedirectVoiceAppAudioFilePromptFileName       = $queue.TimeoutRedirectVoiceAppAudioFilePromptFileName
                TimeoutRedirectPhoneNumberTextToSpeechPrompt         = $queue.TimeoutRedirectPhoneNumberTextToSpeechPrompt
                TimeoutRedirectPhoneNumberAudioFilePrompt            = $queue.TimeoutRedirectPhoneNumberAudioFilePrompt
                TimeoutRedirectPhoneNumberAudioFilePromptFileName    = $queue.TimeoutRedirectPhoneNumberAudioFilePromptFileName
                TimeoutRedirectVoicemailTextToSpeechPrompt           = $queue.TimeoutRedirectVoicemailTextToSpeechPrompt
                TimeoutRedirectVoicemailAudioFilePrompt              = $queue.TimeoutRedirectVoicemailAudioFilePrompt
                TimeoutRedirectVoicemailAudioFilePromptFileName      = $queue.TimeoutRedirectVoicemailAudioFilePromptFileName
                TimeoutSharedVoicemailTextToSpeechPrompt             = $queue.TimeoutSharedVoicemailTextToSpeechPrompt
                TimeoutSharedVoicemailAudioFilePrompt                = $queue.TimeoutSharedVoicemailAudioFilePrompt
                TimeoutSharedVoicemailAudioFilePromptFileName        = $queue.TimeoutSharedVoicemailAudioFilePromptFileName
                EnableTimeoutSharedVoicemailTranscription            = $queue.EnableTimeoutSharedVoicemailTranscription
                EnableTimeoutSharedVoicemailSystemPromptSuppression  = $queue.EnableTimeoutSharedVoicemailSystemPromptSuppression
                ChannelId                                            = $queue.ChannelId
                ChannelUserObjectId                                  = $queue.ChannelUserObjectId
                AuthorizedUsers                                      = [String[]]$queue.AuthorizedUsers
                Ensure                                               = 'Present'
                Credential                                           = $Credential
                ApplicationId                                        = $ApplicationId
                TenantId                                             = $TenantId
                CertificateThumbprint                                = $CertificateThumbprint
                ManagedIdentity                                      = $ManagedIdentity.IsPresent
                AccessTokens                                         = $AccessTokens
            }
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
        $Name,

        [Parameter()]
        [ValidateSet("Queue","Forward","Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $NoAgentAction,


        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $NoAgentActionTarget,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [ValidateRange(15,180)]
        [System.UInt16]
        $AgentAlertTime,

        [Parameter()]
        [System.Boolean]
        $AllowOptOut,

        [Parameter()]
        [System.String[]]
        $DistributionLists,

        [Parameter()]
        [System.Boolean]
        $UseDefaultMusicOnHold,

        [Parameter()]
        [System.String]
        $WelcomeMusicAudioFileId,

        [Parameter()]
        [System.String]
        $MusicOnHoldAudioFileId,

        [Parameter()]
        [ValidateSet("DisconnectWithBusy","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $OverflowAction,

        [Parameter()]
        [System.String]
        $OverflowActionTarget,

        [Parameter()]
        [ValidateRange(0,200)]
        [System.UInt16]
        $OverflowThreshold,

        [Parameter()]
        [ValidateSet("Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $TimeoutAction,

        [Parameter()]
        [System.String]
        $TimeoutActionTarget,

        [Parameter()]
        [ValidateRange(0,2700)]
        [System.UInt16]
        $TimeoutThreshold,

        [Parameter()]
        [ValidateSet("Attendant","Serial","RoundRobin","LongestIdle")]
        [System.String]
        $RoutingMethod,

        [Parameter()]
        [System.Boolean]
        $PresenceBasedRouting,

        [Parameter()]
        [System.Boolean]
        $ConferenceMode,

        [Parameter()]
        [System.String[]]
        $Users,

        [Parameter()]
        [System.String]
        $LanguageId,

        [Parameter()]
        [System.String[]]
        $OboResourceAccountIds,

        [Parameter()]
        [System.String[]]
        $WelcomeMusicFileName,

        [Parameter()]
        [System.String[]]
        $WelcomeTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $ChannelId,

        [Parameter()]
        [System.String]
        $ChannelUserObjectId,

        [Parameter()]
        [System.String[]]
        $AuthorizedUsers,

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

    Write-Verbose -Message "Setting configuration of Teams Call Queue {$Name}"

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
        -InboundParameters $PSBoundParameters

    $currentValues = Get-TargetResource @PSBoundParameters

    $opsParameters = $PSBoundParameters
    $opsParameters.Remove('Credential') | Out-Null
    $opsParameters.Remove('ApplicationId') | Out-Null
    $opsParameters.Remove('TenantId') | Out-Null
    $opsParameters.Remove('CertificateThumbprint') | Out-Null
    $opsParameters.Remove('Ensure') | Out-Null
    $opsParameters.Remove('ManagedIdentity') | Out-Null
    $opsParameters.Remove('AccessTokens') | Out-Null

    if ($currentValues.Ensure -eq 'Absent' -and 'Present' -eq $Ensure )
    {
        Write-Verbose -Message "Creating a new Teams Call Queue {$Name}"
        New-CsCallQueue @opsParameters
    }
    elseif (($currentValues.Ensure -eq 'Present' -and 'Present' -eq $Ensure))
    {
        Write-Verbose -Message "Updating Teams Call Queue {$Name}"
        $queue = Get-CsCallQueue -NameFilter $Name
        $opsParameters.Add('Identity', $queue.Id)
        Set-CsCallQueue @opsParameters
    }
    elseif (($Ensure -eq 'Absent' -and $currentValues.Ensure -eq 'Present'))
    {
        Write-Verbose -Message "Removing Teams Call Queue {$Name}"
        $queue = Get-CsCallQueue -NameFilter $Name
        Remove-CsCallQueue -Identity $queue.Id
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

        [Parameter()]
        [ValidateRange(15,180)]
        [System.UInt16]
        $AgentAlertTime,

        [Parameter()]
        [System.Boolean]
        $AllowOptOut,

        [Parameter()]
        [System.String[]]
        $DistributionLists,

        [Parameter()]
        [ValidateSet("Queue","Forward","Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $NoAgentAction,

        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailSystemPromptSuppression,

        [Parameter()]
        [System.Boolean]
        $EnableNoAgentSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $NoAgentActionTarget,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailAudioFilePromptFileName,

        [Parameter()]
        [System.String]
        $NoAgentSharedVoiceNoAgentSharedVoicemailAudioFilePromptFileNamemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $MusicOnHoldFileName,

        [Parameter()]
        [System.Boolean]
        $UseDefaultMusicOnHold,

        [Parameter()]
        [System.String]
        $WelcomeMusicAudioFileId,

        [Parameter()]
        [System.String]
        $MusicOnHoldAudioFileId,

        [Parameter()]
        [ValidateSet("DisconnectWithBusy","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $OverflowAction,

        [Parameter()]
        [System.String]
        $OverflowActionTarget,

        [Parameter()]
        [ValidateRange(0,200)]
        [System.UInt16]
        $OverflowThreshold,

        [Parameter()]
        [ValidateSet("Disconnect","Forward","Voicemail","SharedVoicemail")]
        [System.String]
        $TimeoutAction,

        [Parameter()]
        [System.String]
        $TimeoutActionTarget,

        [Parameter()]
        [ValidateRange(0,2700)]
        [System.UInt16]
        $TimeoutThreshold,

        [Parameter()]
        [ValidateSet("Attendant","Serial","RoundRobin","LongestIdle")]
        [System.String]
        $RoutingMethod,

        [Parameter()]
        [System.Boolean]
        $PresenceBasedRouting,

        [Parameter()]
        [System.Boolean]
        $ConferenceMode,

        [Parameter()]
        [System.String[]]
        $Users,

        [Parameter()]
        [System.String]
        $LanguageId,

        [Parameter()]
        [System.String[]]
        $OboResourceAccountIds,

        [Parameter()]
        [System.String[]]
        $WelcomeMusicFileName,

        [Parameter()]
        [System.String[]]
        $WelcomeTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $OverflowSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableOverflowSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutDisconnectAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPersonAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoiceAppAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectPhoneNumberAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutRedirectVoicemailAudioFilePrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailTextToSpeechPrompt,

        [Parameter()]
        [System.String]
        $TimeoutSharedVoicemailAudioFilePrompt,

        [Parameter()]
        [System.Boolean]
        $EnableTimeoutSharedVoicemailTranscription,

        [Parameter()]
        [System.String]
        $ChannelId,

        [Parameter()]
        [System.String]
        $ChannelUserObjectId,

        [Parameter()]
        [System.String[]]
        $AuthorizedUsers,

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

    Write-Verbose -Message "Testing configuration of Teams Call Queue {$Name}"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    $TestResult = Test-M365DSCParameterState `
        -CurrentValues $CurrentValues `
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
    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
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

    try
    {
        $i = 1
        $Script:ExportMode = $true
        $Script:MaxSize = 1000
        [array] $Script:exportedInstances = Get-CsCallQueue -ErrorAction Stop -First $Script:MaxSize
        if ($Script:exportedInstances.Count -eq $Script:MaxSize){
            Write-Verbose -Message "WARNING: CsCallQueue isn't exporting all of them, you reach the max size."
        }

        $dscContent = [System.Text.StringBuilder]::New()
        Write-Host "`r`n" -NoNewline
        foreach ($instance in $exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($exportedInstances.Count)] $($instance.Name)" -NoNewline

            $params = @{
                Name                  = $instance.Name
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
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            $dscContent.Append($currentDSCBlock) | Out-Null
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
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
