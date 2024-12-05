function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Role,

        [Parameter()]
        [System.String]
        $App,

        [Parameter()]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $SecurityGroup,

        [Parameter()]
        [System.String]
        $User,

        [Parameter()]
        [System.String]
        $CustomRecipientWriteScope,

        [Parameter()]
        [System.String]
        $CustomResourceScope,

        [Parameter()]
        [System.String]
        $ExclusiveRecipientWriteScope,

        [Parameter()]
        [System.String]
        $RecipientAdministrativeUnitScope,

        [Parameter()]
        [System.String]
        $RecipientOrganizationalUnitScope,

        [Parameter()]
        [System.String]
        $RecipientRelativeWriteScope,

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

    Write-Verbose -Message "Getting Management Role Assignment for $Name"
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

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'

    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $roleAssignment = $Script:exportedInstances | Where-Object -FilterScript { $_.Identity -eq $Name }
        }
        else
        {
            $roleAssignment = Get-ManagementRoleAssignment -Identity $Name -ErrorAction SilentlyContinue
        }

        if ($null -eq $roleAssignment)
        {
            Write-Verbose -Message "Management Role Assignment $($Name) does not exist."
            return $nullReturn
        }
        else
        {
            $RecipientAdministrativeUnitScopeValue = $null
            if ($roleAssignment.RecipientWriteScope -eq 'AdministrativeUnit')
            {
                $adminUnit = Get-AdministrativeUnit -Identity $roleAssignment.CustomRecipientWriteScope

                if ($RecipientAdministrativeUnitScope -eq $adminUnit.Id)
                {
                    $RecipientAdministrativeUnitScopeValue = $RecipientAdministrativeUnitScope
                }
                else
                {
                    $RecipientAdministrativeUnitScopeValue = $adminUnit.DisplayName
                }
            }

            $result = @{
                Name                             = $roleAssignment.Name
                CustomRecipientWriteScope        = $roleAssignment.CustomRecipientWriteScope
                CustomResourceScope              = $roleAssignment.CustomResourceScope
                ExclusiveRecipientWriteScope     = $roleAssignment.ExclusiveRecipientWriteScope
                RecipientAdministrativeUnitScope = $RecipientAdministrativeUnitScopeValue
                RecipientOrganizationalUnitScope = $roleAssignment.RecipientOrganizationalUnitScope
                RecipientRelativeWriteScope      = $roleAssignment.RecipientRelativeWriteScope
                Role                             = $roleAssignment.Role
                Ensure                           = 'Present'
                Credential                       = $Credential
                ApplicationId                    = $ApplicationId
                CertificateThumbprint            = $CertificateThumbprint
                CertificatePath                  = $CertificatePath
                CertificatePassword              = $CertificatePassword
                Managedidentity                  = $ManagedIdentity.IsPresent
                TenantId                         = $TenantId
                AccessTokens                     = $AccessTokens
            }

            if ($roleAssignment.RoleAssigneeType -eq 'SecurityGroup' -or $roleAssignment.RoleAssigneeType -eq 'RoleGroup')
            {
                $result.Add('SecurityGroup', $roleAssignment.RoleAssignee)
            }
            elseif ($roleAssignment.RoleAssigneeType -eq 'RoleAssignmentPolicy')
            {
                $result.Add('Policy', $roleAssignment.RoleAssignee)
            }
            elseif ($roleAssignment.RoleAssigneeType -eq 'ServicePrincipal')
            {
                $result.Add('App', $roleAssignment.RoleAssignee)
            }
            elseif ($roleAssignment.RoleAssigneeType -eq 'User')
            {
                $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                    -InboundParameters $PSBoundParameters
                $userInfo = Get-MgUser -UserId ($roleAssignment.RoleAssignee)
                $result.Add('User', $userInfo.UserPrincipalName)
            }

            Write-Verbose -Message "Found Management Role Assignment $($Name)"
            return $result
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
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Role,

        [Parameter()]
        [System.String]
        $App,

        [Parameter()]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $SecurityGroup,

        [Parameter()]
        [System.String]
        $User,

        [Parameter()]
        [System.String]
        $CustomRecipientWriteScope,

        [Parameter()]
        [System.String]
        $CustomResourceScope,

        [Parameter()]
        [System.String]
        $ExclusiveRecipientWriteScope,

        [Parameter()]
        [System.String]
        $RecipientAdministrativeUnitScope,

        [Parameter()]
        [System.String]
        $RecipientOrganizationalUnitScope,

        [Parameter()]
        [System.String]
        $RecipientRelativeWriteScope,

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
    Write-Verbose -Message "Setting Management Role Assignment for $Name"

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

    $currentManagementRoleConfig = Get-TargetResource @PSBoundParameters

    $NewManagementRoleParams = ([Hashtable]$PSBoundParameters).Clone()
    $NewManagementRoleParams.Remove('Ensure') | Out-Null
    $NewManagementRoleParams.Remove('Credential') | Out-Null
    $NewManagementRoleParams.Remove('ApplicationId') | Out-Null
    $NewManagementRoleParams.Remove('TenantId') | Out-Null
    $NewManagementRoleParams.Remove('CertificateThumbprint') | Out-Null
    $NewManagementRoleParams.Remove('CertificatePath') | Out-Null
    $NewManagementRoleParams.Remove('CertificatePassword') | Out-Null
    $NewManagementRoleParams.Remove('ManagedIdentity') | Out-Null
    $NewManagementRoleParams.Remove('AccessTokens') | Out-Null

    # If the RecipientAdministrativeUnitScope parameter is provided, then retrieve its ID by Name
    if (-not [System.String]::IsNullOrEmpty($RecipientAdministrativeUnitScope))
    {
        $NewManagementRoleParams.Remove('CustomRecipientWriteScope') | Out-Null
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters
        $adminUnit = Get-MgBetaDirectoryAdministrativeUnit -AdministrativeUnitId $RecipientAdministrativeUnitScope -ErrorAction SilentlyContinue
        if ($null -eq $adminUnit)
        {
            $adminUnit = Get-MgBetaDirectoryAdministrativeUnit -All | Where-Object -FilterScript { $_.DisplayName -eq $RecipientAdministrativeUnitScope }
        }
        $NewManagementRoleParams.RecipientAdministrativeUnitScope = $adminUnit.Id
    }

    # CASE: Management Role doesn't exist but should;
    if ($Ensure -eq 'Present' -and $currentManagementRoleConfig.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Management Role Assignment'$($Name)' does not exist but it should. Create and configure it."
        # Create Management Role
        New-ManagementRoleAssignment @NewManagementRoleParams | Out-Null
    }
    # CASE: Management Role exists but it shouldn't;
    elseif ($Ensure -eq 'Absent' -and $currentManagementRoleConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Management Role Assignment'$($Name)' exists but it shouldn't. Remove it."
        Remove-ManagementRoleAssignment -Identity $Name -Confirm:$false -Force | Out-Null
    }
    # CASE: Management Role exists and it should, but has different values than the desired ones
    elseif ($Ensure -eq 'Present' -and $currentManagementRoleConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Management Role Assignment'$($Name)' already exists, but needs updating. Deleting and recreating the instance."
        Remove-ManagementRoleAssignment -Identity $Name -Confirm:$false -Force | Out-Null
        New-ManagementRoleAssignment @NewManagementRoleParams | Out-Null
    }

    # Wait for the permission to be applied
    $testResults = $false
    $retries = 12
    $count = 1
    do
    {
        Write-Verbose -Message 'Testing to ensure changes were applied.'
        $testResults = Test-TargetResource @PSBoundParameters
        if (-not $testResults)
        {
            Write-Verbose -Message "Test-TargetResource returned $false. Waiting for a total of $(($count * 10).ToString()) out of 120)"
            Start-Sleep -Seconds 10
        }
        $retries--
        $count++
    } while (-not $testResults -and $retries -gt 0)

    # Need to force reconnect to Exchange for the new permissions to kick in.
    if ($null -ne $Global:MSCloudLoginConnectionProfile.ExchangeOnline)
    {
        Write-Verbose -Message 'Waiting for 20 seconds for new permissions to be effective.'
        Start-Sleep 20
        Write-Verbose -Message 'Disconnecting from Exchange Online'
        $Global:MSCloudLoginConnectionProfile.ExchangeOnline.Disconnect()
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Role,

        [Parameter()]
        [System.String]
        $App,

        [Parameter()]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $SecurityGroup,

        [Parameter()]
        [System.String]
        $User,

        [Parameter()]
        [System.String]
        $CustomRecipientWriteScope,

        [Parameter()]
        [System.String]
        $CustomResourceScope,

        [Parameter()]
        [System.String]
        $ExclusiveRecipientWriteScope,

        [Parameter()]
        [System.String]
        $RecipientAdministrativeUnitScope,

        [Parameter()]
        [System.String]
        $RecipientOrganizationalUnitScope,

        [Parameter()]
        [System.String]
        $RecipientRelativeWriteScope,

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

    Write-Verbose -Message "Testing Management Role Assignment for $Name"

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
        [array] $Script:exportedInstances = Get-ManagementRoleAssignment | Where-Object -FilterScript { $_.RoleAssigneeType -eq 'ServicePrincipal' -or `
                $_.RoleAssigneeType -eq 'User' -or $_.RoleAssigneeType -eq 'RoleAssignmentPolicy' -or $_.RoleAssigneeType -eq 'SecurityGroup' `
                -or $_.RoleAssigneeType -eq 'RoleGroup' }

        $dscContent = [System.Text.StringBuilder]::New()

        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $i = 1
        foreach ($assignment in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($assignment.Name)" -NoNewline

            $Params = @{
                Name                  = $assignment.Name
                Role                  = $assignment.Role
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
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
            Write-Host $Global:M365DSCEmojiGreenCheckMark
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

