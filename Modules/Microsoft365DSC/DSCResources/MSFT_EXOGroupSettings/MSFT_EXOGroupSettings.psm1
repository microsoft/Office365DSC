function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [ValidateSet('Public', 'Private')]
        [System.String]
        $AccessType,

        [Parameter()]
        [System.Boolean]
        $AlwaysSubscribeMembersToCalendarEvents,

        [Parameter()]
        [System.String]
        $AuditLogAgeLimit,

        [Parameter()]
        [System.Boolean]
        $AutoSubscribeNewMembers,

        [Parameter()]
        [System.Boolean]
        $CalendarMemberReadOnly,

        [Parameter()]
        [System.String]
        $Classification,

        [Parameter()]
        [System.Boolean]
        $ConnectorsEnabled,

        [Parameter()]
        [System.String]
        $CustomAttribute1,

        [Parameter()]
        [System.String]
        $CustomAttribute2,

        [Parameter()]
        [System.String]
        $CustomAttribute3,

        [Parameter()]
        [System.String]
        $CustomAttribute4,

        [Parameter()]
        [System.String]
        $CustomAttribute5,

        [Parameter()]
        [System.String]
        $CustomAttribute6,

        [Parameter()]
        [System.String]
        $CustomAttribute7,

        [Parameter()]
        [System.String]
        $CustomAttribute8,

        [Parameter()]
        [System.String]
        $CustomAttribute9,

        [Parameter()]
        [System.String]
        $CustomAttribute10,

        [Parameter()]
        [System.String]
        $CustomAttribute11,

        [Parameter()]
        [System.String]
        $CustomAttribute12,

        [Parameter()]
        [System.String]
        $CustomAttribute13,

        [Parameter()]
        [System.String]
        $CustomAttribute14,

        [Parameter()]
        [System.String]
        $CustomAttribute15,

        [Parameter()]
        [System.String]
        $DataEncryptionPolicy,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute1,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute2,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute3,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute4,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [System.Boolean]
        $HiddenFromExchangeClientsEnabled,

        [Parameter()]
        [ValidateSet('Explicit', 'Implicit', 'Open', 'OwnerModerated')]
        [System.String]
        $InformationBarrierMode,

        [Parameter()]
        [System.Boolean]
        $IsMemberAllowedToEditContent,

        [Parameter()]
        [System.String]
        $Language,

        [Parameter()]
        [System.String]
        $MailboxRegion,

        [Parameter()]
        [System.String]
        $MailTip,

        [Parameter()]
        [System.String]
        $MailTipTranslations,

        [Parameter()]
        [System.String]
        $MaxReceiveSize,

        [Parameter()]
        [System.String]
        $MaxSendSize,

        [Parameter()]
        [System.String[]]
        $ModeratedBy,

        [Parameter()]
        [System.Boolean]
        $ModerationEnabled,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.String[]]
        $RejectMessagesFromSendersOrMembers,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.String]
        $SensitivityLabelId,

        [Parameter()]
        [System.Boolean]
        $SubscriptionEnabled,

        [Parameter()]
        [System.Boolean]
        $UnifiedGroupWelcomeMessageEnabled,

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
            Write-Verbose -Message "Getting configuration of Office 365 Group Settings for $DisplayName"

            $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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

            $nullReturn = @{
                DisplayName = $DisplayName
            }

            Write-Verbose -Message "Retrieving group by id {$Id}"
            [Array]$group = Get-UnifiedGroup -Identity $Id -IncludeAllProperties -ErrorAction Stop

            if ($group.Length -eq 0)
            {
                Write-Verbose -Message "Couldn't retrieve group by ID. Trying by DisplayName {$DisplayName}"
                [Array]$group = Get-UnifiedGroup -Identity $DisplayName -IncludeAllProperties -ErrorAction Stop
            }

            if ($group.Length -gt 1)
            {
                Write-Warning -Message "Multiple instances of a group named {$DisplayName} was discovered which could result in inconsistencies retrieving its values."
            }
            $group = $group[0]
            if ($null -eq $group)
            {
                Write-Verbose -Message "The specified group {$DisplayName} doesn't already exist."
                return $nullReturn
            }
        }
        else
        {
            $group = $Script:exportedInstance
        }
    }
    catch
    {
        return $nullReturn
    }

    $result = @{
        DisplayName                            = $DisplayName
        Id                                     = $group.Id
        AcceptMessagesOnlyFromSendersOrMembers = $group.AcceptMessagesOnlyFromSendersOrMembers
        AccessType                             = $group.AccessType
        AlwaysSubscribeMembersToCalendarEvents = $group.AlwaysSubscribeMembersToCalendarEvents
        AuditLogAgeLimit                       = $group.AuditLogAgeLimit
        AutoSubscribeNewMembers                = $group.AutoSubscribeNewMembers
        CalendarMemberReadOnly                 = $group.CalendarMemberReadOnly
        Classification                         = $group.Classification
        ConnectorsEnabled                      = $group.ConnectorsEnabled
        CustomAttribute1                       = $group.CustomAttribute1
        CustomAttribute2                       = $group.CustomAttribute2
        CustomAttribute3                       = $group.CustomAttribute3
        CustomAttribute4                       = $group.CustomAttribute4
        CustomAttribute5                       = $group.CustomAttribute5
        CustomAttribute6                       = $group.CustomAttribute6
        CustomAttribute7                       = $group.CustomAttribute7
        CustomAttribute8                       = $group.CustomAttribute8
        CustomAttribute9                       = $group.CustomAttribute9
        CustomAttribute10                      = $group.CustomAttribute10
        CustomAttribute11                      = $group.CustomAttribute11
        CustomAttribute12                      = $group.CustomAttribute12
        CustomAttribute13                      = $group.CustomAttribute13
        CustomAttribute14                      = $group.CustomAttribute14
        CustomAttribute15                      = $group.CustomAttribute15
        DataEncryptionPolicy                   = $group.DataEncryptionPolicy
        EmailAddresses                         = $group.EmailAddresses
        ExtensionCustomAttribute1              = $group.ExtensionCustomAttribute1
        ExtensionCustomAttribute2              = $group.ExtensionCustomAttribute2
        ExtensionCustomAttribute3              = $group.ExtensionCustomAttribute3
        ExtensionCustomAttribute4              = $group.ExtensionCustomAttribute4
        ExtensionCustomAttribute5              = $group.ExtensionCustomAttribute5
        GrantSendOnBehalfTo                    = $group.GrantSendOnBehalfTo
        HiddenFromAddressListsEnabled          = $group.HiddenFromAddressListsEnabled
        HiddenFromExchangeClientsEnabled       = $group.HiddenFromExchangeClientsEnabled
        InformationBarrierMode                 = $group.InformationBarrierMode
        IsMemberAllowedToEditContent           = $group.IsMemberAllowedToEditContent
        Language                               = $group.Language.Name
        MailboxRegion                          = $group.MailboxRegion
        MailTip                                = $group.MailTip
        MailTipTranslations                    = $group.MailTipTranslations
        MaxReceiveSize                         = $group.MaxReceiveSize
        MaxSendSize                            = $group.MaxSendSize
        ModeratedBy                            = $group.ModeratedBy
        ModerationEnabled                      = $group.ModerationEnabled
        Notes                                  = $group.Notes
        PrimarySmtpAddress                     = $group.PrimarySmtpAddress
        RejectMessagesFromSendersOrMembers     = $group.RejectMessagesFromSendersOrMembers
        RequireSenderAuthenticationEnabled     = $group.RequireSenderAuthenticationEnabled
        SensitivityLabelId                     = $group.SensitivityLabelId
        SubscriptionEnabled                    = $group.SubscriptionEnabled
        UnifiedGroupWelcomeMessageEnabled      = $group.UnifiedGroupWelcomeMessageEnabled
        Credential                             = $Credential
        ApplicationId                          = $ApplicationId
        TenantId                               = $TenantId
        CertificateThumbprint                  = $CertificateThumbprint
        CertificatePath                        = $CertificatePath
        CertificatePassword                    = $CertificatePassword
        ManagedIdentity                        = $ManagedIdentity
        AccessTokens                           = $AccessTokens
    }

    Write-Verbose -Message "Found an existing instance of group '$($DisplayName)'"
    return $result
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [ValidateSet('Public', 'Private')]
        [System.String]
        $AccessType,

        [Parameter()]
        [System.Boolean]
        $AlwaysSubscribeMembersToCalendarEvents,

        [Parameter()]
        [System.String]
        $AuditLogAgeLimit,

        [Parameter()]
        [System.Boolean]
        $AutoSubscribeNewMembers,

        [Parameter()]
        [System.Boolean]
        $CalendarMemberReadOnly,

        [Parameter()]
        [System.String]
        $Classification,

        [Parameter()]
        [System.Boolean]
        $ConnectorsEnabled,

        [Parameter()]
        [System.String]
        $CustomAttribute1,

        [Parameter()]
        [System.String]
        $CustomAttribute2,

        [Parameter()]
        [System.String]
        $CustomAttribute3,

        [Parameter()]
        [System.String]
        $CustomAttribute4,

        [Parameter()]
        [System.String]
        $CustomAttribute5,

        [Parameter()]
        [System.String]
        $CustomAttribute6,

        [Parameter()]
        [System.String]
        $CustomAttribute7,

        [Parameter()]
        [System.String]
        $CustomAttribute8,

        [Parameter()]
        [System.String]
        $CustomAttribute9,

        [Parameter()]
        [System.String]
        $CustomAttribute10,

        [Parameter()]
        [System.String]
        $CustomAttribute11,

        [Parameter()]
        [System.String]
        $CustomAttribute12,

        [Parameter()]
        [System.String]
        $CustomAttribute13,

        [Parameter()]
        [System.String]
        $CustomAttribute14,

        [Parameter()]
        [System.String]
        $CustomAttribute15,

        [Parameter()]
        [System.String]
        $DataEncryptionPolicy,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute1,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute2,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute3,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute4,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [System.Boolean]
        $HiddenFromExchangeClientsEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('Explicit', 'Implicit', 'Open', 'OwnerModerated')]
        $InformationBarrierMode,

        [Parameter()]
        [System.Boolean]
        $IsMemberAllowedToEditContent,

        [Parameter()]
        [System.String]
        $Language,

        [Parameter()]
        [System.String]
        $MailboxRegion,

        [Parameter()]
        [System.String]
        $MailTip,

        [Parameter()]
        [System.String]
        $MailTipTranslations,

        [Parameter()]
        [System.String]
        $MaxReceiveSize,

        [Parameter()]
        [System.String]
        $MaxSendSize,

        [Parameter()]
        [System.String[]]
        $ModeratedBy,

        [Parameter()]
        [System.Boolean]
        $ModerationEnabled,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.String[]]
        $RejectMessagesFromSendersOrMembers,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.String]
        $SensitivityLabelId,

        [Parameter()]
        [System.Boolean]
        $SubscriptionEnabled,

        [Parameter()]
        [System.Boolean]
        $UnifiedGroupWelcomeMessageEnabled,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Setting configuration of Office 365 group Settings for $DisplayName"

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
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
        -InboundParameters $PSBoundParameters

    $UpdateParameters = ([Hashtable]$PSBoundParameters).Clone()
    $UpdateParameters.Add('Identity', $DisplayName)
    $UpdateParameters.Remove('DisplayName') | Out-Null
    $UpdateParameters.Remove('Credential') | Out-Null
    $UpdateParameters.Remove('ApplicationId') | Out-Null
    $UpdateParameters.Remove('TenantId') | Out-Null
    $UpdateParameters.Remove('CertificateThumbprint') | Out-Null
    $UpdateParameters.Remove('CertificatePath') | Out-Null
    $UpdateParameters.Remove('CertificatePassword') | Out-Null
    $UpdateParameters.Remove('ManagedIdentity') | Out-Null
    $UpdateParameters.Remove('AccessTokens') | Out-Null

    # Cannot use PrimarySmtpAddress and EmailAddresses at the same time. If both are present, then give priority to PrimarySmtpAddress.
    if ($UpdateParameters.ContainsKey('PrimarySmtpAddress') -and $null -ne $UpdateParameters.PrimarySmtpAddress)
    {
        $UpdateParameters.Remove('EmailAddresses')
    }
    Set-UnifiedGroup @UpdateParameters
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [ValidateSet('Public', 'Private')]
        [System.String]
        $AccessType,

        [Parameter()]
        [System.Boolean]
        $AlwaysSubscribeMembersToCalendarEvents,

        [Parameter()]
        [System.String]
        $AuditLogAgeLimit,

        [Parameter()]
        [System.Boolean]
        $AutoSubscribeNewMembers,

        [Parameter()]
        [System.Boolean]
        $CalendarMemberReadOnly,

        [Parameter()]
        [System.String]
        $Classification,

        [Parameter()]
        [System.Boolean]
        $ConnectorsEnabled,

        [Parameter()]
        [System.String]
        $CustomAttribute1,

        [Parameter()]
        [System.String]
        $CustomAttribute2,

        [Parameter()]
        [System.String]
        $CustomAttribute3,

        [Parameter()]
        [System.String]
        $CustomAttribute4,

        [Parameter()]
        [System.String]
        $CustomAttribute5,

        [Parameter()]
        [System.String]
        $CustomAttribute6,

        [Parameter()]
        [System.String]
        $CustomAttribute7,

        [Parameter()]
        [System.String]
        $CustomAttribute8,

        [Parameter()]
        [System.String]
        $CustomAttribute9,

        [Parameter()]
        [System.String]
        $CustomAttribute10,

        [Parameter()]
        [System.String]
        $CustomAttribute11,

        [Parameter()]
        [System.String]
        $CustomAttribute12,

        [Parameter()]
        [System.String]
        $CustomAttribute13,

        [Parameter()]
        [System.String]
        $CustomAttribute14,

        [Parameter()]
        [System.String]
        $CustomAttribute15,

        [Parameter()]
        [System.String]
        $DataEncryptionPolicy,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute1,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute2,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute3,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute4,

        [Parameter()]
        [System.String]
        $ExtensionCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [System.Boolean]
        $HiddenFromExchangeClientsEnabled,

        [Parameter()]
        [System.String]
        [ValidateSet('Explicit', 'Implicit', 'Open', 'OwnerModerated')]
        $InformationBarrierMode,

        [Parameter()]
        [System.Boolean]
        $IsMemberAllowedToEditContent,

        [Parameter()]
        [System.String]
        $Language,

        [Parameter()]
        [System.String]
        $MailboxRegion,

        [Parameter()]
        [System.String]
        $MailTip,

        [Parameter()]
        [System.String]
        $MailTipTranslations,

        [Parameter()]
        [System.String]
        $MaxReceiveSize,

        [Parameter()]
        [System.String]
        $MaxSendSize,

        [Parameter()]
        [System.String[]]
        $ModeratedBy,

        [Parameter()]
        [System.Boolean]
        $ModerationEnabled,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.String[]]
        $RejectMessagesFromSendersOrMembers,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.String]
        $SensitivityLabelId,

        [Parameter()]
        [System.Boolean]
        $SubscriptionEnabled,

        [Parameter()]
        [System.Boolean]
        $UnifiedGroupWelcomeMessageEnabled,

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

    Write-Verbose -Message "Testing configuration of Office 365 Group Settings for $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-UnifiedGroup -ResultSize Unlimited -ErrorAction SilentlyContinue

        $i = 1
        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n"-NoNewline
        }
        $dscContent = [System.Text.StringBuilder]::New()
        foreach ($group in $Script:exportedInstances)
        {
            Write-Host "    |---[$i/$($Script:exportedInstances.Length)] $($group.DisplayName)" -NoNewline
            $groupName = $group.DisplayName
            if (-not [System.String]::IsNullOrEmpty($groupName))
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                $Params = @{
                    Credential            = $Credential
                    DisplayName           = $groupName
                    Id                    = $group.Id
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    CertificatePassword   = $CertificatePassword
                    Managedidentity       = $ManagedIdentity.IsPresent
                    CertificatePath       = $CertificatePath
                    AccessTokens          = $AccessTokens
                }
                $Script:exportedInstance = $group
                $Results = Get-TargetResource @Params

                if ($Results -is [System.Collections.Hashtable] -and $Results.Count -gt 1)
                {
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
                }
                else
                {
                    Write-Host $Global:M365DSCEmojiRedX
                }
            }
            $i++
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
