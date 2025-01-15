function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFrom,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromDLMembers,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.Boolean]
        $BccBlocked,

        [Parameter()]
        [System.Boolean]
        $BypassNestedModerationEnabled,

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
        $Description,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenGroupMembershipEnabled,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed')]
        $MemberDepartRestriction,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed', 'ApprovalRequired')]
        $MemberJoinRestriction,

        [Parameter()]
        [System.String[]]
        $Members,

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
        $OrganizationalUnit,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.Boolean]
        $RoomList,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [ValidateSet('Always', 'Internal', 'Never')]
        [System.String]
        $SendModerationNotifications,

        [Parameter()]
        [System.Boolean]
        $SendOofMessageToOriginatorEnabled,

        [Parameter()]
        [ValidateSet('Distribution', 'Security')]
        [System.String]
        $Type,

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
            Write-Verbose -Message "Getting configuration of Distribution Group for $Identity"

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

            $nullReturn = $PSBoundParameters
            $nullReturn.Ensure = 'Absent'

            if ($null -ne $PrimarySmtpAddress)
            {
                $distributionGroup = Get-DistributionGroup -Identity $PrimarySmtpAddress -ErrorAction Stop
            }
            else
            {
                $distributionGroup = Get-DistributionGroup -Identity $Identity -ErrorAction Stop
            }

            if ($null -eq $distributionGroup)
            {
                Write-Verbose -Message "Distribution Group $($Identity) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $distributionGroup = $Script:exportedInstance
        }

        if ($null -ne $PrimarySmtpAddress)
        {
            $distributionGroupMembers = Get-DistributionGroupMember -Identity $PrimarySmtpAddress `
                -ErrorAction 'Stop' `
                -ResultSize 'Unlimited'
        }
        else
        {
            $distributionGroupMembers = Get-DistributionGroupMember -Identity $Identity `
                    -ErrorAction 'Stop' `
                    -ResultSize 'Unlimited'
        }

        Write-Verbose -Message "Found existing Distribution Group {$Identity}."
        $descriptionValue = $null
        if ($distributionGroup.Description.Length -gt 0)
        {
            $descriptionValue = $distributionGroup.Description[0].Replace("`r", '').Replace("`n", '')
        }

        $groupTypeValue = 'Distribution'
        if (([Array]$distributionGroup.GroupType.Replace(' ', '').Split(',')).Contains('SecurityEnabled'))
        {
            $groupTypeValue = 'Security'
        }

        $ManagedByValue = @()
        if ($null -ne $distributionGroup.ManagedBy)
        {
            foreach ($user in $distributionGroup.ManagedBy)
            {
                try
                {
                    $user = Get-MgUser -UserId $user -ErrorAction Stop
                    $ManagedByValue += $user.UserPrincipalName
                }
                catch
                {
                    Write-Verbose -Message "Couldn't retrieve user {$user}"
                }
            }
        }

        $ModeratedByValue = @()
        if ($null -ne $distributionGroup.ModeratedBy)
        {
            foreach ($user in $distributionGroup.ModeratedBy)
            {
                try
                {
                    $user = Get-MgUser -UserId $user -ErrorAction Stop
                    $ModeratedByValue += $user.UserPrincipalName
                }
                catch
                {
                    Write-Verbose -Message "Couldn't retrieve moderating user {$user}"
                }
            }
        }
        $result = @{
            Identity                               = $distributionGroup.Identity
            Alias                                  = $distributionGroup.Alias
            BccBlocked                             = $distributionGroup.BccBlocked
            BypassNestedModerationEnabled          = $distributionGroup.BypassNestedModerationEnabled
            Description                            = $descriptionValue
            DisplayName                            = $distributionGroup.DisplayName
            HiddenGroupMembershipEnabled           = $distributionGroup.HiddenGroupMembershipEnabled
            ManagedBy                              = $ManagedByValue
            MemberDepartRestriction                = $distributionGroup.MemberDepartRestriction
            MemberJoinRestriction                  = $distributionGroup.MemberJoinRestriction
            Members                                = $distributionGroupMembers.Name
            ModeratedBy                            = $ModeratedByValue
            ModerationEnabled                      = $distributionGroup.ModerationEnabled
            Name                                   = $distributionGroup.Name
            Notes                                  = $distributionGroup.Notes
            OrganizationalUnit                     = $distributionGroup.OrganizationalUnit
            PrimarySmtpAddress                     = $distributionGroup.PrimarySmtpAddress
            RequireSenderAuthenticationEnabled     = $distributionGroup.RequireSenderAuthenticationEnabled
            RoomList                               = $distributionGroup.RoomList
            SendModerationNotifications            = $distributionGroup.SendModerationNotifications
            AcceptMessagesOnlyFrom                 = [Array]$distributionGroup.AcceptMessagesOnlyFrom
            AcceptMessagesOnlyFromDLMembers        = [Array]$distributionGroup.AcceptMessagesOnlyFromDLMembers
            AcceptMessagesOnlyFromSendersOrMembers = [Array]$distributionGroup.AcceptMessagesOnlyFromSendersOrMembers
            CustomAttribute1                       = $distributionGroup.CustomAttribute1
            CustomAttribute2                       = $distributionGroup.CustomAttribute2
            CustomAttribute3                       = $distributionGroup.CustomAttribute3
            CustomAttribute4                       = $distributionGroup.CustomAttribute4
            CustomAttribute5                       = $distributionGroup.CustomAttribute5
            CustomAttribute6                       = $distributionGroup.CustomAttribute6
            CustomAttribute7                       = $distributionGroup.CustomAttribute7
            CustomAttribute8                       = $distributionGroup.CustomAttribute8
            CustomAttribute9                       = $distributionGroup.CustomAttribute9
            CustomAttribute10                      = $distributionGroup.CustomAttribute10
            CustomAttribute11                      = $distributionGroup.CustomAttribute11
            CustomAttribute12                      = $distributionGroup.CustomAttribute12
            CustomAttribute13                      = $distributionGroup.CustomAttribute13
            CustomAttribute14                      = $distributionGroup.CustomAttribute14
            CustomAttribute15                      = $distributionGroup.CustomAttribute15
            EmailAddresses                         = [Array]$distributionGroup.EmailAddresses
            GrantSendOnBehalfTo                    = [Array]$distributionGroup.GrantSendOnBehalfTo
            HiddenFromAddressListsEnabled          = [Boolean]$distributionGroup.HiddenFromAddressListsEnabled
            SendOofMessageToOriginatorEnabled      = [Boolean]$distributionGroup.SendOofMessageToOriginatorEnabled
            Type                                   = $groupTypeValue
            Ensure                                 = 'Present'
            Credential                             = $Credential
            ApplicationId                          = $ApplicationId
            CertificateThumbprint                  = $CertificateThumbprint
            CertificatePath                        = $CertificatePath
            CertificatePassword                    = $CertificatePassword
            Managedidentity                        = $ManagedIdentity.IsPresent
            TenantId                               = $TenantId
            AccessTokens                           = $AccessTokens
        }

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
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFrom,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromDLMembers,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.Boolean]
        $BccBlocked,

        [Parameter()]
        [System.Boolean]
        $BypassNestedModerationEnabled,

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
        $Description,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenGroupMembershipEnabled,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed')]
        $MemberDepartRestriction,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed', 'ApprovalRequired')]
        $MemberJoinRestriction,

        [Parameter()]
        [System.String[]]
        $Members,

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
        $OrganizationalUnit,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.Boolean]
        $RoomList,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [ValidateSet('Always', 'Internal', 'Never')]
        [System.String]
        $SendModerationNotifications,

        [Parameter()]
        [System.Boolean]
        $SendOofMessageToOriginatorEnabled,

        [Parameter()]
        [ValidateSet('Distribution', 'Security')]
        [System.String]
        $Type,

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

    if ($Global:CurrentModeIsExport)
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters `
            -SkipModuleReload $true
    }
    else
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters
    }

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

    $currentDistributionGroup = Get-TargetResource @PSBoundParameters

    $currentParameters = $PSBoundParameters
    $currentParameters.Remove('Ensure') | Out-Null
    $currentParameters.Remove('Credential') | Out-Null
    $currentParameters.Remove('ApplicationId') | Out-Null
    $currentParameters.Remove('TenantId') | Out-Null
    $currentParameters.Remove('CertificateThumbprint') | Out-Null
    $currentParameters.Remove('CertificatePath') | Out-Null
    $currentParameters.Remove('CertificatePassword') | Out-Null
    $currentParameters.Remove('ManagedIdentity') | Out-Null
    $currentParameters.Remove('AccessTokens') | Out-Null

    # Distribution group doesn't exist but it should
    $newGroup = $null
    if ($Ensure -eq 'Present' -and $currentDistributionGroup.Ensure -eq 'Absent')
    {
        $CreateParameters = ([Hashtable]$PSBoundParameters).Clone()
        Write-Verbose -Message "The Distribution Group {$Identity} does not exist but it should. Creating it."
        $CreateParameters.Remove('Identity') | Out-Null
        $CreateParameters.Remove('AcceptMessagesOnlyFrom') | Out-Null
        $CreateParameters.Remove('AcceptMessagesOnlyFromSendersOrMembers') | Out-Null
        $CreateParameters.Remove('CustomAttribute1') | Out-Null
        $CreateParameters.Remove('CustomAttribute2') | Out-Null
        $CreateParameters.Remove('CustomAttribute3') | Out-Null
        $CreateParameters.Remove('CustomAttribute4') | Out-Null
        $CreateParameters.Remove('CustomAttribute5') | Out-Null
        $CreateParameters.Remove('CustomAttribute6') | Out-Null
        $CreateParameters.Remove('CustomAttribute7') | Out-Null
        $CreateParameters.Remove('CustomAttribute8') | Out-Null
        $CreateParameters.Remove('CustomAttribute9') | Out-Null
        $CreateParameters.Remove('CustomAttribute10') | Out-Null
        $CreateParameters.Remove('CustomAttribute11') | Out-Null
        $CreateParameters.Remove('CustomAttribute12') | Out-Null
        $CreateParameters.Remove('CustomAttribute13') | Out-Null
        $CreateParameters.Remove('CustomAttribute14') | Out-Null
        $CreateParameters.Remove('CustomAttribute15') | Out-Null
        $CreateParameters.Remove('EmailAddresses') | Out-Null
        $CreateParameters.Remove('GrantSendOnBehalfTo') | Out-Null
        $CreateParameters.Remove('HiddenFromAddressListsEnabled') | Out-Null
        $CreateParameters.Remove('SendOofMessageToOriginatorEnabled') | Out-Null
        $newGroup = New-DistributionGroup @CreateParameters
        Write-Verbose -Message "New Distribution Group with Identity {$($newGroup.Identity)} was successfully created"
    }
    # Distribution group exists but shouldn't
    elseif ($Ensure -eq 'Absent' -and $currentDistributionGroup.Ensure -eq 'Present')
    {
        Write-Verbose -Message "The Distribution Group {$Identity} exists but shouldn't. Removing it."
        Remove-DistributionGroup -Identity $Identity -Confirm:$false
    }
    # Update even if we just created the group. There are properties that can only be set with th set- cmdlet.
    if ($Ensure -eq 'Present')
    {
        $currentParameters.Remove('Type') | Out-Null
        Write-Verbose -Message "Updating Distribution Group {$Identity} with values: $(Convert-M365DscHashtableToString -Hashtable $currentParameters)"

        if ($null -ne $OrganizationalUnit -and $currentDistributionGroup.OrganizationalUnit -ne $OrganizationalUnit)
        {
            Write-Warning -Message 'Desired and current OrganizationalUnit values differ. This property cannot be updated once the distribution group has been created. Delete and recreate the distribution group to update the value.'
        }
        $currentParameters.Remove('OrganizationalUnit') | Out-Null
        $currentParameters.Remove('Type') | Out-Null
        $currentParameters.Remove('Members') | Out-Null

        if ($EmailAddresses.Length -gt 0)
        {
            $currentParameters.Remove('PrimarySmtpAddress') | Out-Null
        }

        if ($AcceptMessagesOnlyFrom.Length -gt 0)
        {
            $currentParameters.Remove('AcceptMessagesOnlyFromDLMembers') | Out-Null
            $currentParameters.Remove('AcceptMessagesOnlyFromSendersOrMembers') | Out-Null
        }

        if ($null -ne $newGroup)
        {
            $currentParameters.Identity = $newGroup.Identity
        }
        Set-DistributionGroup @currentParameters -BypassSecurityGroupManagerCheck
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

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFrom,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromDLMembers,

        [Parameter()]
        [System.String[]]
        $AcceptMessagesOnlyFromSendersOrMembers,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.Boolean]
        $BccBlocked,

        [Parameter()]
        [System.Boolean]
        $BypassNestedModerationEnabled,

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
        $Description,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

        [Parameter()]
        [System.String[]]
        $GrantSendOnBehalfTo,

        [Parameter()]
        [System.Boolean]
        $HiddenGroupMembershipEnabled,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed')]
        $MemberDepartRestriction,

        [Parameter()]
        [System.String]
        [ValidateSet('Open', 'Closed', 'ApprovalRequired')]
        $MemberJoinRestriction,

        [Parameter()]
        [System.String[]]
        $Members,

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
        $OrganizationalUnit,

        [Parameter()]
        [System.String]
        $PrimarySmtpAddress,

        [Parameter()]
        [System.Boolean]
        $RequireSenderAuthenticationEnabled,

        [Parameter()]
        [System.Boolean]
        $RoomList,

        [Parameter()]
        [System.Boolean]
        $HiddenFromAddressListsEnabled,

        [Parameter()]
        [ValidateSet('Always', 'Internal', 'Never')]
        [System.String]
        $SendModerationNotifications,

        [Parameter()]
        [System.Boolean]
        $SendOofMessageToOriginatorEnabled,

        [Parameter()]
        [ValidateSet('Distribution', 'Security')]
        [System.String]
        $Type,

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

    Write-Verbose -Message "Testing Distribution Group configuration for {$Name}"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    if (!$ValuesToCheck.OrganizationalUnit)
    {
        $ValuesToCheck.Remove('OrganizationalUnit') | Out-Null
    }

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
    param (
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
        $dscContent = [System.Text.StringBuilder]::New()
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-DistributionGroup -ResultSize 'Unlimited' -ErrorAction Stop
        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $i = 1

        foreach ($distributionGroup in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($distributionGroup.Identity)" -NoNewline
            $params = @{
                Identity              = $distributionGroup.Identity
                PrimarySmtpAddress    = $distributionGroup.PrimarySmtpAddress
                Name                  = $distributionGroup.Name
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }
            $Script:exportedInstance = $distributionGroup
            $Results = Get-TargetResource @Params

            if ($Results.AcceptMessagesOnlyFromSendersOrMembers.Length -eq 0)
            {
                $Results.Remove('AcceptMessagesOnlyFromSendersOrMembers') | Out-Null
            }

            if ($Results.AcceptMessagesOnlyFrom.Length -eq 0)
            {
                $Results.Remove('AcceptMessagesOnlyFrom') | Out-Null
            }

            if ($Results.AcceptMessagesOnlyFromDLMembers.Length -eq 0)
            {
                $Results.Remove('AcceptMessagesOnlyFromDLMembers') | Out-Null
            }

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
            $i ++
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
