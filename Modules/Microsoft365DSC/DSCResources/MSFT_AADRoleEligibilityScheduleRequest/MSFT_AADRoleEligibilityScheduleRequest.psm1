function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Principal,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter()]
        [ValidateSet('User', 'Group')]
        [System.String]
        $PrincipalType = 'User',

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DirectoryScopeId,

        [Parameter()]
        [System.String]
        $AppScopeId,

        [Parameter()]
        [ValidateSet("adminAssign", "adminUpdate", "adminRemove", "selfActivate", "selfDeactivate", "adminExtend", "adminRenew", "selfExtend", "selfRenew", "unknownFutureValue")]
        [System.String]
        $Action,

        [Parameter()]
        [System.String]
        $Justification,

        [Parameter()]
        [System.Boolean]
        $IsValidationOnly,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScheduleInfo,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TicketInfo,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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
    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters
    }
    catch
    {
        Write-Verbose -Message ($_)
    }

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
        $request = $null
        if (-not [System.String]::IsNullOrEmpty($Id))
        {
            if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
            {
                    $request = $Script:exportedInstances | Where-Object -FilterScript {$_.Id -eq $Id}
            }
            else
            {
                Write-Verbose -Message "Getting Role Eligibility by Id {$Id}"
                $request = Get-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest -UnifiedRoleEligibilityScheduleRequestId $Id `
                    -ErrorAction SilentlyContinue
            }
        }

        if ($null -eq $request)
        {
            if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
            {
                    Write-Verbose -Message "Getting Role Eligibility by PrincipalId and RoleDefinitionId"
                    $PrincipalTypeValue = $null
                    if ($PrincipalType -eq 'User')
                    {
                        Write-Verbose -Message "Retrieving Principal by UserPrincipalName {$Principal}"
                        $PrincipalIdValue = Get-MgUser -Filter "UserPrincipalName eq '$Principal'" -ErrorAction SilentlyContinue
                        $PrincipalTypeValue = 'User'
                    }
                    if ($null -eq $PrincipalIdValue -or $PrincipalType -eq 'Group')
                    {
                        Write-Verbose -Message "Retrieving Principal by DisplayName {$Principal}"
                        $PrincipalIdValue = Get-MgGroup -Filter "DisplayName eq '$Principal'" -ErrorAction SilentlyContinue
                        $PrincipalTypeValue = 'Group'
                    }

                    if ($null -ne $PrincipalIdValue)
                    {
                        $PrincipalId = $PrincipalIdValue.Id
                    }
                    else
                    {
                        return $nullResult
                    }
                    Write-Verbose -Message "Found Principal {$PrincipalId}"
                    $RoleDefinitionId = (Get-MgBetaRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$RoleDefinition'").Id
                    $request = $Script:exportedInstances | Where-Object -FilterScript {$_.PrincipalId -eq $PrincipalId -and $_.RoleDefinitionId -eq $RoleDefinition} | Sort-Object -Property CompletedDateTime -Descending
            }
            else
            {
                Write-Verbose -Message "Getting Role Eligibility by PrincipalId and RoleDefinitionId"
                if ($PrincipalType -eq 'User')
                {
                    Write-Verbose -Message "Retrieving principal {$Principal} of type {$PrincipalType}"
                    $PrincipalIdValue = Get-MgUser -Filter "UserPrincipalName eq '$Principal'" -ErrorAction SilentlyContinue
                    $PrincipalTypeValue = 'User'
                }

                if ($null -eq $PrincipalIdValue -or $PrincipalType -eq 'Group')
                {
                    Write-Verbose -Message "Retrieving principal {$Principal} of type {$PrincipalType}"
                    $PrincipalIdValue = Get-MgGroup -Filter "DisplayName eq '$Principal'" -ErrorAction SilentlyContinue
                    $PrincipalTypeValue = 'Group'
                }

                if ($null -ne $PrincipalIdValue)
                {
                    $PrincipalId = $PrincipalIdValue.Id
                }
                else
                {
                    return $nullResult
                }
                Write-Verbose -Message "Found Principal {$PrincipalId}"
                $schedulesForPrincipal = Get-MgBetaRoleManagementDirectoryRoleEligibilitySchedule -Filter "PrincipalId eq '$PrincipalId'"
                foreach ($instance in $schedulesForPrincipal)
                {
                    $roleInfo = Get-MgBetaRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $instance.RoleDefinitionId
                    if ($roleInfo.DisplayName -eq $RoleDefinition)
                    {
                        $schedule = $instance
                    }
                }
                [Array]$request = Get-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest -Filter "PrincipalId eq '$PrincipalId' and RoleDefinitionId eq '$($schedule.RoleDefinitionId)'" | Sort-Object -Property CompletedDateTime -Descending
`
                if ($request.Length -gt 1)
                {
                    $request = $request[0]
                }
            }
        }
        else
        {
            Write-Verbose -Message "Request is not null: $request"
            $ObjectGuid = [System.Guid]::empty
            if ($PrincipalType -eq 'User')
            {
                Write-Verbose -Message "Retrieving principal {$Principal} of type {$PrincipalType}"

                if ([System.Guid]::TryParse($Principal,[System.Management.Automation.PSReference]$ObjectGuid))
                {
                    $PrincipalIdValue = Get-MgUser -UserId $Principal -ErrorAction SilentlyContinue
                }
                else
                {
                    $PrincipalIdValue = Get-MgUser -Filter "UserPrincipalName eq '$Principal'" -ErrorAction SilentlyContinue
                }
                $PrincipalTypeValue = 'User'
            }

            if ($null -eq $PrincipalIdValue -or $PrincipalType -eq 'Group')
            {
                Write-Verbose -Message "Retrieving principal {$Principal} of type {$PrincipalType}"
                if ([System.Guid]::TryParse($Principal,[System.Management.Automation.PSReference]$ObjectGuid))
                {
                    $PrincipalIdValue = Get-MgGroup -GroupId $Principal -ErrorAction SilentlyContinue
                }
                else
                {
                    $PrincipalIdValue = Get-MgGroup -Filter "DisplayName eq '$Principal'" -ErrorAction SilentlyContinue
                }
                $PrincipalTypeValue = 'Group'
            }

            if ($null -ne $PrincipalIdValue)
            {
                $PrincipalId = $PrincipalIdValue.Id
            }
            else
            {
                return $nullResult
            }
            $RoleDefinitionId = (Get-MgBetaRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$RoleDefinition'").Id
            $schedule = Get-MgBetaRoleManagementDirectoryRoleEligibilitySchedule -Filter "PrincipalId eq '$($request.PrincipalId)' and RoleDefinitionId eq '$RoleDefinitionId'"
        }
        if ($null -eq $schedule -or $null -eq $request)
        {
            if ($null -eq $schedule)
            {
                Write-Verbose -Message "Could not retrieve the schedule for {$($request.PrincipalId)} & RoleDefinitionId {$RoleDefinitionId}"
            }
            if ($null -eq $request)
            {
                Write-Verbose -Message "Could not request the schedule for {$RoleDefinition}"
            }
            return $nullResult
        }

        Write-Verbose -Message "Found existing AADRolelLigibilityScheduleRequest"
        if ($PrincipalType -eq 'User')
        {
            Write-Verbose -Message "Retrieving Principal by UserId {$($request.PrincipalId)}"
            $PrincipalInstance = Get-MgUser -UserId $request.PrincipalId -ErrorAction SilentlyContinue
            $PrincipalTypeValue = 'User'
        }
        if ($null -eq $PrincipalInstance -or $PrincipalType -eq 'Group')
        {
            Write-Verbose -Message "Retrieving Principal by GroupId {$($request.PrincipalId)}"
            $requestArray = [Array]$request
            if ($requestArray.Count -gt 1)
            {
                $requestArray = $requestArray | Sort-Object -Property CreatedDateTime -Descending
                $request = $requestArray[0]
            }
            $PrincipalInstance = Get-MGGroup -GroupId $request.PrincipalId -ErrorAction SilentlyContinue
            $PrincipalTypeValue = 'Group'
        }

        if ($null -eq $PrincipalInstance)
        {
            Write-Verbose -Message "Couldn't retrieve Principal {$($request.PrincipalId)}"
            return $nullResult
        }

        $ScheduleInfoValue = @{}

        if ($null -ne $schedule.ScheduleInfo.Expiration)
        {
            $expirationValue = @{
                duration    = $schedule.ScheduleInfo.Expiration.Duration
                type        = $schedule.ScheduleInfo.Expiration.Type
            }
            if ($null -ne $schedule.ScheduleInfo.Expiration.EndDateTime)
            {
                $expirationValue.Add('endDateTime', $schedule.ScheduleInfo.Expiration.EndDateTime.ToString("yyyy-MM-ddThh:mm:ssZ"))
            }
            $ScheduleInfoValue.Add('expiration', $expirationValue)
        }
        if ($null -ne $schedule.ScheduleInfo.Recurrence)
        {
            $recurrenceValue = @{
                pattern = @{
                    dayOfMonth     = $schedule.ScheduleInfo.Recurrence.Pattern.dayOfMonth
                    daysOfWeek     = $schedule.ScheduleInfo.Recurrence.Pattern.daysOfWeek
                    firstDayOfWeek = $schedule.ScheduleInfo.Recurrence.Pattern.firstDayOfWeek
                    index          = $schedule.ScheduleInfo.Recurrence.Pattern.index
                    interval       = $schedule.ScheduleInfo.Recurrence.Pattern.interval
                    month          = $schedule.ScheduleInfo.Recurrence.Pattern.month
                    type           = $schedule.ScheduleInfo.Recurrence.Pattern.type
                }
                range   = @{
                    endDate             = $schedule.ScheduleInfo.Recurrence.Range.endDate
                    numberOfOccurrences = $schedule.ScheduleInfo.Recurrence.Range.numberOfOccurrences
                    recurrenceTimeZone  = $schedule.ScheduleInfo.Recurrence.Range.recurrenceTimeZone
                    startDate           = $schedule.ScheduleInfo.Recurrence.Range.startDate
                    type                = $schedule.ScheduleInfo.Recurrence.Range.type
                }
            }
            $ScheduleInfoValue.Add('Recurrence', $recurrenceValue)
        }
        if ($null -ne $schedule.ScheduleInfo.StartDateTime)
        {
            $ScheduleInfoValue.Add('StartDateTime', $schedule.ScheduleInfo.StartDateTime.ToString("yyyy-MM-ddThh:mm:ssZ"))
        }

        $ticketInfoValue = $null
        if ($null -ne $request.TicketInfo)
        {
            $ticketInfoValue = @{
                ticketNumber = $request.TicketInfo.TicketNumber
                ticketSystem = $request.TicketInfo.TicketSystem
            }
        }

        $PrincipalValue = $null
        if ($PrincipalType -eq 'User')
        {
            $PrincipalValue = $PrincipalInstance.UserPrincipalName
        }
        if ($null -eq $PrincipalValue -or $PrincipalTypeValue -eq 'Group')
        {
            $PrincipalValue = $PrincipalInstance.DisplayName
        }

        $results = @{
            Principal             = $PrincipalValue
            PrincipalType         = $PrincipalTypeValue
            RoleDefinition        = $RoleDefinition
            DirectoryScopeId      = $request.DirectoryScopeId
            AppScopeId            = $request.AppScopeId
            Action                = $request.Action
            Id                    = $request.Id
            Justification         = $request.Justification
            IsValidationOnly      = $request.IsValidationOnly
            ScheduleInfo          = $ScheduleInfoValue
            TicketInfo            = $ticketInfoValue
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
            Managedidentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        return $results
    }
    catch
    {
        Write-Verbose "Error: $_"
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
        $Principal,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter()]
        [ValidateSet('User', 'Group')]
        [System.String]
        $PrincipalType = 'User',

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DirectoryScopeId,

        [Parameter()]
        [System.String]
        $AppScopeId,

        [Parameter()]
        [ValidateSet("adminAssign", "adminUpdate", "adminRemove", "selfActivate", "selfDeactivate", "adminExtend", "adminRenew", "selfExtend", "selfRenew", "unknownFutureValue")]
        [System.String]
        $Action,

        [Parameter()]
        [System.String]
        $Justification,

        [Parameter()]
        [System.Boolean]
        $IsValidationOnly,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScheduleInfo,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TicketInfo,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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
    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
    }
    catch
    {
        Write-Verbose -Message $_
    }

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
    $PSBoundParameters.Remove('Verbose') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    $ParametersOps = ([Hashtable]$PSBoundParameters).clone()

    if ($PrincipalType -eq 'User')
    {
        [Array]$PrincipalIdValue = (Get-MgUser -Filter "UserPrincipalName eq '$Principal'").Id
    }
    elseif ($PrincipalType -eq 'Group')
    {
        [Array]$PrincipalIdValue = (Get-MgGroup -Filter "DisplayName eq '$Principal'").Id
    }

    if ($null -eq $PrincipalIdValue)
    {
        throw "Couldn't find Principal {$PrincipalId} of type {$PrincipalType}"
    }
    elseif ($PrincipalIdValue.Length -gt 1)
    {
        throw "Multiple Principal with ID {$PrincipalId} of type {$PrincipalType} were found. Cannot create schedule."
    }
    $ParametersOps.Add("PrincipalId", $PrincipalIdValue[0])
    $ParametersOps.Remove("Principal") | Out-Null

    $RoleDefinitionIdValue = (Get-MgBetaRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$RoleDefinition'").Id
    $ParametersOps.Add("RoleDefinitionId", $RoleDefinitionIdValue)
    $ParametersOps.Remove("RoleDefinition") | Out-Null

    if ($null -ne $ScheduleInfo)
    {
        $ScheduleInfoValue = @{}

        if ($ScheduleInfo.StartDateTime)
        {
            $ScheduleInfoValue.Add("startDateTime", $ScheduleInfo.StartDateTime)
        }

        if ($ScheduleInfo.Expiration)
        {
            $expirationValue = @{
                endDateTime = $ScheduleInfo.Expiration.endDateTime
                type        = $ScheduleInfo.Expiration.type
            }
            if ($ScheduleInfo.Expiration.duration)
            {
                $expirationValue.Add('duration', $ScheduleInfo.Expiration.duration)
            }
            $ScheduleInfoValue.Add("Expiration", $expirationValue)
        }

        if ($ScheduleInfo.Recurrence)
        {
            $Found = $false
            $recurrenceValue = @{}

            if ($ScheduleInfo.Recurrence.Pattern)
            {
                $Found = $true
                $patternValue = @{
                    dayOfMonth     = $ScheduleInfo.Recurrence.Pattern.dayOfMonth
                    daysOfWeek     = $ScheduleInfo.Recurrence.Pattern.daysOfWeek
                    firstDayOfWeek = $ScheduleInfo.Recurrence.Pattern.firstDayOfWeek
                    index          = $ScheduleInfo.Recurrence.Pattern.index
                    interval       = $ScheduleInfo.Recurrence.Pattern.interval
                    month          = $ScheduleInfo.Recurrence.Pattern.month
                    type           = $ScheduleInfo.Recurrence.Pattern.type
                }
                $recurrenceValue.Add("Pattern", $patternValue)
            }
            if ($ScheduleInfo.Recurrence.Range)
            {
                $Found = $true
                $rangeValue = @{
                    endDate             = $ScheduleInfo.Recurrence.Range.endDate
                    numberOfOccurrences = $ScheduleInfo.Recurrence.Range.numberOfOccurrences
                    recurrenceTimeZone  = $ScheduleInfo.Recurrence.Range.recurrenceTimeZone
                    startDate           = $ScheduleInfo.Recurrence.Range.startDate
                    type                = $ScheduleInfo.Recurrence.Range.type
                }
                $recurrenceValue.Add("Range", $rangeValue)
            }
            if ($Found)
            {
                $ScheduleInfoValue.Add("Recurrence", $recurrenceValue)
            }
        }
        Write-Verbose -Message "ScheduleInfo: $(Convert-M365DscHashtableToString -Hashtable $ScheduleInfoValue)"
        $ParametersOps.ScheduleInfo = $ScheduleInfoValue
    }
    $ParametersOps.Remove("PrincipalType") | Out-Null
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating a Role Eligibility Schedule Request for user {$Principal} and role {$RoleDefinition}"
        $ParametersOps.Remove("Id") | Out-Null
        Write-Verbose -Message "Values: $(Convert-M365DscHashtableToString -Hashtable $ParametersOps)"
        New-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest @ParametersOps
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Role Eligibility Schedule Request for user {$Principal} and role {$RoleDefinition}"
        $ParametersOps.Remove("Id") | Out-Null
        $ParametersOps.Action = 'AdminUpdate'
        New-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest @ParametersOps
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Role Eligibility Schedule Request for user {$Principal} and role {$RoleDefinition}"
        $ParametersOps.Remove("Id") | Out-Null
        $ParametersOps.Action = 'AdminRemove'
        New-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest @ParametersOps
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
        $Principal,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter()]
        [ValidateSet('User', 'Group')]
        [System.String]
        $PrincipalType = 'User',

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DirectoryScopeId,

        [Parameter()]
        [System.String]
        $AppScopeId,

        [Parameter()]
        [ValidateSet("adminAssign", "adminUpdate", "adminRemove", "selfActivate", "selfDeactivate", "adminExtend", "adminRenew", "selfExtend", "selfRenew", "unknownFutureValue")]
        [System.String]
        $Action,

        [Parameter()]
        [System.String]
        $Justification,

        [Parameter()]
        [System.Boolean]
        $IsValidationOnly,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScheduleInfo,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TicketInfo,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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

    Write-Verbose -Message "Testing configuration of the Azure AD Role Eligibility Schedule Request for user {$Principal} and role {$RoleDefinition}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()
    $ValuesToCheck.Remove("Action") | Out-Null
    if($null -ne $CurrentValues.ScheduleInfo -and $null -ne $ValuesToCheck.ScheduleInfo)
    {
        # Compare ScheduleInfo.Expiration
        if ($CurrentValues.ScheduleInfo.Expiration.duration -ne $ValuesToCheck.ScheduleInfo.Expiration.duration -or `
            $CurrentValues.ScheduleInfo.Expiration.endDateTime -ne $ValuesToCheck.ScheduleInfo.Expiration.endDateTime -or `
            $CurrentValues.ScheduleInfo.Expiration.type -ne $ValuesToCheck.ScheduleInfo.Expiration.type)
        {
            Write-Verbose -Message "Discrepancy found in ScheduleInfo.Expiration"
            Write-Verbose -Message "Current: $($CurrentValues.ScheduleInfo.Expiration | Out-String)"
            Write-Verbose -Message "Desired: $($ValuesToCheck.ScheduleInfo.Expiration | Out-String)"
            return $false
        }

        # Compare ScheduleInfo.Recurrence.Pattern
        if ($CurrentValues.ScheduleInfo.Recurrence.Pattern.dayOfMonth -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.dayOfMonth -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.daysOfWeek -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.daysOfWeek -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.firstDayOfWeek -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.firstDayOfWeek -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.index -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.index -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.interval -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.interval -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.month -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.month -or `
            $CurrentValues.ScheduleInfo.Recurrence.Pattern.type -ne $ValuesToCheck.ScheduleInfo.Recurrence.Pattern.type)
        {
            Write-Verbose -Message "Discrepancy found in ScheduleInfo.Recurrence.Pattern"
            Write-Verbose -Message "Current: $($CurrentValues.ScheduleInfo.Recurrence.Pattern | Out-String)"
            Write-Verbose -Message "Desired: $($ValuesToCheck.ScheduleInfo.Recurrence.Pattern | Out-String)"
            return $false
        }

        # Compare ScheduleInfo.Recurrence.Range
        if ($CurrentValues.ScheduleInfo.Recurrence.Range.endDate -ne $ValuesToCheck.ScheduleInfo.Recurrence.Range.endDate -or `
            $CurrentValues.ScheduleInfo.Recurrence.Range.numberOfOccurrences -ne $ValuesToCheck.ScheduleInfo.Recurrence.Range.numberOfOccurrences -or `
            $CurrentValues.ScheduleInfo.Recurrence.Range.recurrenceTimeZone -ne $ValuesToCheck.ScheduleInfo.Recurrence.Range.recurrenceTimeZone -or `
            $CurrentValues.ScheduleInfo.Recurrence.Range.startDate -ne $ValuesToCheck.ScheduleInfo.Recurrence.Range.startDate -or `
            $CurrentValues.ScheduleInfo.Recurrence.Range.type -ne $ValuesToCheck.ScheduleInfo.Recurrence.Range.type)
        {
            Write-Verbose -Message "Discrepancy found in ScheduleInfo.Recurrence.Range"
            Write-Verbose -Message "Current: $($CurrentValues.ScheduleInfo.Recurrence.Range | Out-String)"
            Write-Verbose -Message "Desired: $($ValuesToCheck.ScheduleInfo.Recurrence.Range | Out-String)"
            return $false
        }
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    $ValuesToCheck.Remove("ScheduleInfo") | Out-Null
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
        #region resource generator code
        $schedules = Get-MgBetaRoleManagementDirectoryRoleEligibilitySchedule -All -ErrorAction Stop
        [array] $Script:exportedInstances = @()
        [array] $allRequests = Get-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest -All `
                -Filter "Status ne 'Revoked'" -ErrorAction Stop
        foreach ($schedule in $schedules)
        {
            [array] $Script:exportedInstances += $allRequests | Where-Object -FilterScript {$_.TargetScheduleId -eq $schedule.Id}
        }
        #endregion

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
        foreach ($request in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $request.Id
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline

            $RoleDefinitionId = Get-MgBetaRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $request.RoleDefinitionId
            $params = @{
                Id                    = $request.Id
                Principal             = $request.PrincipalId
                RoleDefinition        = $RoleDefinitionId.DisplayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            try
            {
                if ($null -ne $results.ScheduleInfo)
                {
                    $Results.ScheduleInfo = Get-M365DSCAzureADEligibilityRequestScheduleInfoAsString -ScheduleInfo $Results.ScheduleInfo
                }
            }
            catch
            {
                Write-Verbose -Message "Error converting Schedule: $_"
            }
            if ($Results.TicketInfo)
            {
                $Results.TicketInfo = Get-M365DSCAzureADEligibilityRequestTicketInfoAsString -TicketInfo $Results.TicketInfo
            }
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($null -ne $Results.ScheduleInfo)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                    -ParameterName 'ScheduleInfo'
            }
            if ($null -ne $Results.TicketInfo)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                    -ParameterName 'TicketInfo'
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
        if ($_.ErrorDetails.Message -like "*The tenant needs an AAD Premium*" -or `
            $_.ErrorDetails.MEssage -like "*[AadPremiumLicenseRequired]*")
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) Tenant does not meet license requirement to extract this component."
        }
        else
        {
            Write-Verbose -Message "Exception: $($_.Exception.Message)"
            Write-Host $Global:M365DSCEmojiRedX
            New-M365DSCLogEntry -Message 'Error during Export:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

        return ''
    }
}

function Get-M365DSCAzureADEligibilityRequestTicketInfoAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $TicketInfo
    )

    if ($TicketInfo.TicketNumber -or $TicketInfo.TicketSystem)
    {
        $StringContent  = "MSFT_AADRoleEligibilityScheduleRequestTicketInfo {`r`n"
        $StringContent += "                ticketNumber = '$($TicketInfo.TicketNumber)'`r`n"
        $StringContent += "                ticketSystem = '$($TicketInfo.TicketSystem)'`r`n"
        $StringContent += "             }`r`n"
        return $StringContent
    }
    else
    {
        return $null
    }
}

function Get-M365DSCAzureADEligibilityRequestScheduleInfoAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $ScheduleInfo
    )

    $Found = $false
    $StringContent  = "MSFT_AADRoleEligibilityScheduleRequestSchedule {`r`n"
    if ($ScheduleInfo.StartDateTime)
    {
        $StringContent += "                startDateTime             = '$($ScheduleInfo.StartDateTime)'`r`n"
    }
    if ($ScheduleInfo.Expiration.Duration -or $ScheduleInfo.Expiration.EndDateTime -or $ScheduleInfo.Expiration.Type)
    {
        $Found = $true
        $StringContent += "                expiration                = MSFT_AADRoleEligibilityScheduleRequestScheduleExpiration`r`n"
        $StringContent += "                    {`r`n"
        if ($ScheduleInfo.Expiration.Duration)
        {
            $StringContent += "                        duration    = '$($ScheduleInfo.Expiration.Duration)'`r`n"
        }
        if ($ScheduleInfo.Expiration.EndDateTime)
        {
            $StringContent += "                        endDateTime = '$($ScheduleInfo.Expiration.EndDateTime.ToString())'`r`n"
        }
        if($ScheduleInfo.Expiration.Type)
        {
            $StringContent += "                        type        = '$($ScheduleInfo.Expiration.Type)'`r`n"
        }
        $StringContent += "                    }`r`n"
    }
    if($ScheduleInfo.Recurrence.Pattern.DayOfMonth -or $ScheduleInfo.Recurrence.Pattern.DaysOfWeek -or `
    $ScheduleInfo.Recurrence.Pattern.firstDayOfWeek -or $ScheduleInfo.Recurrence.Pattern.Index -or `
    $ScheduleInfo.Recurrence.Pattern.Interval -or $ScheduleInfo.Recurrence.Pattern.Month -or `
    $ScheduleInfo.Recurrence.Pattern.Type -or $ScheduleInfo.Recurrence.Range.EndDate -or $ScheduleInfo.Recurrence.Range.numberOfOccurrences -or `
    $ScheduleInfo.Recurrence.Range.recurrenceTimeZone -or $ScheduleInfo.Recurrence.Range.startDate -or `
    $ScheduleInfo.Recurrence.Range.type)
    {
        $StringContent += "                recurrence                = MSFT_AADRoleEligibilityScheduleRequestScheduleRecurrence`r`n"
        $StringContent += "                    {`r`n"

        if ($ScheduleInfo.Recurrence.Pattern.DayOfMonth -or $ScheduleInfo.Recurrence.Pattern.DaysOfWeek -or `
            $ScheduleInfo.Recurrence.Pattern.firstDayOfWeek -or $ScheduleInfo.Recurrence.Pattern.Index -or `
            $ScheduleInfo.Recurrence.Pattern.Interval -or $ScheduleInfo.Recurrence.Pattern.Month -or `
            $ScheduleInfo.Recurrence.Pattern.Type)
        {
            $Found = $true
            $StringContent += "                         pattern = MSFT_AADRoleEligibilityScheduleRequestScheduleRecurrencePattern`r`n"
            $StringContent += "                             {`r`n"
            if ($ScheduleInfo.Recurrence.Pattern.DayOfMonth)
            {
                $StringContent += "                                 dayOfMonth     = $($ScheduleInfo.Recurrence.Pattern.DayOfMonth)`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.DaysOfWeek)
            {
                $StringContent += "                                 daysOfWeek     = @($($ScheduleInfo.Recurrence.Pattern.DaysOfWeek -join ','))`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.firstDayOfWeek)
            {
                $StringContent += "                                 firstDayOfWeek = '$($ScheduleInfo.Recurrence.Pattern.firstDayOfWeek)'`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.Index)
            {
                $StringContent += "                                 index          = '$($ScheduleInfo.Recurrence.Pattern.Index)'`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.Interval)
            {
                $StringContent += "                                 interval       = $($ScheduleInfo.Recurrence.Pattern.Interval.ToString())`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.Month)
            {
                $StringContent += "                                 month          = $($ScheduleInfo.Recurrence.Pattern.Month.ToString())`r`n"
            }
            if ($ScheduleInfo.Recurrence.Pattern.Type)
            {
                $StringContent += "                                 type           = '$($ScheduleInfo.Recurrence.Pattern.Type)'`r`n"
            }
            $StringContent += "                             }`r`n"
        }
        if ($ScheduleInfo.Recurrence.Range.EndDate -or $ScheduleInfo.Recurrence.Range.numberOfOccurrences -or `
            $ScheduleInfo.Recurrence.Range.recurrenceTimeZone -or $ScheduleInfo.Recurrence.Range.startDate -or `
            $ScheduleInfo.Recurrence.Range.type)
        {
            $Found = $true
            $StringContent += "                         range = MSFT_AADRoleEligibilityScheduleRequestScheduleRange`r`n"
            $StringContent += "                             {`r`n"
            $StringContent += "                                 endDate             = '$($ScheduleInfo.Recurrence.Range.EndDate)'`r`n"
            $StringContent += "                                 numberOfOccurrences = $($ScheduleInfo.Recurrence.Range.numberOfOccurrences)`r`n"
            $StringContent += "                                 recurrenceTimeZone  = '$($ScheduleInfo.Recurrence.Range.recurrenceTimeZone)'`r`n"
            $StringContent += "                                 startDate           = '$($ScheduleInfo.Recurrence.Range.startDate)'`r`n"
            $StringContent += "                                 type                = '$($ScheduleInfo.Recurrence.Range.type)'`r`n"
            $StringContent += "                             }`r`n"
        }

        $StringContent += "                    }`r`n"
    }
    $StringContent += "            }`r`n"

    if ($Found)
    {
        return $StringContent
    }
    return $null
}

Export-ModuleMember -Function *-TargetResource
