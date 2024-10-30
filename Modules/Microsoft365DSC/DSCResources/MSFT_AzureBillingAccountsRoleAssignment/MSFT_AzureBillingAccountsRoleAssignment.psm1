function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalType,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalTenantId,

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

    New-M365DSCConnection -Workload 'Azure' `
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
    try
    {
        $accounts = Get-M365DSCAzureBillingAccount
        $currentAccount = $accounts.value | Where-Object -FilterScript {$_.properties.displayName -eq $BillingAccount}

        if ($null -ne $currentAccount)
        {
            $instances = Get-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $currentAccount.Name -ErrorAction Stop
            $PrincipalIdValue = Get-M365DSCPrincipalIdFromName -PrincipalName $PrincipalName `
                                                               -PrincipalType $PrincipalType
            $instance = $instances.value | Where-Object -FilterScript {$_.properties.principalId -eq $PrincipalIdValue}

            if ($null -ne $instance)
            {
                $roleDefinitionId = $instance.properties.roleDefinitionId.Split('/')
                $roleDefinitionId = $roleDefinitionId[$roleDefinitionId.Length -1]
                $RoleDefinitionValue = Get-M365DSCAzureBillingAccountsRoleDefinition -BillingAccountId $currentAccount.Name `
                                                                                     -RoleDefinitionId $roleDefinitionId
            }
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            BillingAccount        = $BillingAccount
            PrincipalName         = $PrincipalName
            PrincipalType         = $PrincipalType
            PrincipalTenantId     = $instance.properties.principalTenantId
            RoleDefinition        = $RoleDefinitionValue.properties.roleName
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
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
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalType,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalTenantId,

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

    $currentInstance = Get-TargetResource @PSBoundParameters
    $billingAccounts = Get-M365DSCAzureBillingAccount
    $account = $billingAccounts.value | Where-Object -FilterScript {$_.properties.displayName -eq $BillingAccount}
    $PrincipalIdValue = Get-M365DSCPrincipalIdFromName -PrincipalName $PrincipalName `
                                                       -PrincipalType $PrincipalType
    $RoleDefinitionValues = Get-M365DSCAzureBillingAccountsRoleDefinition -BillingAccountId $account.Name
    $roleDefinitionInstance = $RoleDefinitionValues.value | Where-Object -FilterScript {$_.properties.roleName -eq $currentInstance.RoleDefinition}
    $instanceParams = @{
        principalId       = $PrincipalIdValue
        principalTenantId = $currentInstance.PrincipalTenantId
        roleDefinitionId  = $roleDefinitionInstance.id
    }
    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Adding new role assignment for user {$PrincipalName} for role {$RoleDefinition}"
        New-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $account.Name `
                                                      -Body $instanceParams
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating role assignment for user {$PrincipalName} for role {$RoleDefinition}"
        New-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $account.Name `
                                                      -Body $instanceParams
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        $instances = Get-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $account.Name -ErrorAction Stop
        $instance = $instances.value | Where-Object -FilterScript {$_.properties.principalId -eq $PrincipalIdValue}
        $AssignmentId = $instance.Id.Split('/')
        $AssignmentId = $AssignmentId[$roleDefinitionId.Length -1]
        Write-Verbose -Message "Removing role assignment for user {$PrincipalName} for role {$RoleDefinition}"
        Remove-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $account.Name `
                                                         -AssignmentId $AssignmentId
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
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalType,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RoleDefinition,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalTenantId,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'Azure' `
        -InboundParameters $PSBoundParameters

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

        #Get all billing account
        $accounts = Get-M365DSCAzureBillingAccount

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
        foreach ($config in $accounts.value)
        {
            $displayedKey = $config.properties.displayName
            Write-Host "    |---[$i/$($accounts.Count)] $displayedKey"

            $assignments = Get-M365DSCAzureBillingAccountsRoleAssignment -BillingAccountId $config.name

            $j = 1
            foreach ($assignment in $assignments.value)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                $PrincipalNameValue = Get-M365DSCPrincipalNameFromId -PrincipalId $assignment.properties.principalId `
                                                                     -PrincipalType $assignment.properties.principalType
                $roleDefinitionId = $assignment.properties.roleDefinitionId.Split('/')
                $roleDefinitionId = $roleDefinitionId[$roleDefinitionId.Length -1]

                Write-Host "        |---[$j/$($assignments.value.Length)] $($assignment.properties.principalId)" -NoNewline
                $params = @{
                    BillingAccount        = $config.properties.displayName
                    PrincipalName         = $PrincipalNameValue
                    PrincipalType         = $assignment.properties.principalType
                    PrincipalTenantId     = $assignment.properties.principalTenantId
                    RoleDefinition        = "AnyRole"
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
                $dscContent += $currentDSCBlock
                Save-M365DSCPartialExport -Content $currentDSCBlock `
                    -FileName $Global:PartialExportFileName
                $j++
                Write-Host $Global:M365DSCEmojiGreenCheckMark
            }
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

function Get-M365DSCPrincipalNameFromId
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalId,


        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalType
    )

    $result = $null
    if ($PrincipalType -eq 'User')
    {
        $userInfo = Get-MgUser -UserId $PrincipalId
        if ($null -ne $userInfo)
        {
            $result = $userInfo.UserPrincipalName
        }
    }
    elseif ($PrincipalType -eq 'ServicePrincipal')
    {
        $spnInfo = Get-MgServicePrincipal -ServicePrincipalId $PrincipalId
        if ($null -ne $spnInfo)
        {
            $result = $spnInfo.DisplayName
        }
    }
    elseif ($PrincipalType -eq 'Group')
    {
        $groupInfo = Get-MgGroup -GroupId $PrincipalId
        if ($null -ne $groupInfo)
        {
            $result = $groupInfo.DisplayName
        }
    }
    return $result
}

function Get-M365DSCPrincipalIdFromName
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,


        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalType
    )

    $result = $null
    if ($PrincipalType -eq 'User')
    {
        $userInfo = Get-MgUser -Filter "UserPrincipalName eq '$PrincipalName'"
        if ($null -ne $userInfo)
        {
            $result = $userInfo.Id
        }
    }
    elseif ($PrincipalType -eq 'ServicePrincipal')
    {
        $spnInfo = Get-MgServicePrincipal -Filter "DisplayName eq '$PrincipalName'"
        if ($null -ne $spnInfo)
        {
            $result = $spnInfo.Id
        }
    }
    elseif ($PrincipalType -eq 'Group')
    {
        $groupInfo = Get-MgGroup -Filter "DisplayName eq '$PrincipalName'"
        if ($null -ne $groupInfo)
        {
            $result = $groupInfo.Id
        }
    }
    return $result
}

Export-ModuleMember -Function *-TargetResource
