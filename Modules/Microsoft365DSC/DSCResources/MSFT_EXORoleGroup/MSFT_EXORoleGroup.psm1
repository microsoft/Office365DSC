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

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $Roles,

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
            Write-Verbose -Message "Getting Role Group configuration for $Name"
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

            $AllRoleGroups = Get-RoleGroup -ErrorAction Stop
            $RoleGroup = $AllRoleGroups | Where-Object -FilterScript { $_.Name -eq $Name }

            if ($null -eq $RoleGroup)
            {
                Write-Verbose -Message "Role Group $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $RoleGroup = $Script:exportedInstance
        }

        # Get RoleGroup Members DN if RoleGroup exists. This is required especially when adding Members like "Exchange Administrator" or "Global Administrator" that have different Names across Tenants
        $roleGroupMember = Get-RoleGroupMember -Identity $Name | Select-Object DisplayName

        $result = @{
            Name                  = $RoleGroup.Name
            Description           = $RoleGroup.Description
            Members               = $roleGroupMember.DisplayName
            Roles                 = $RoleGroup.Roles
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            CertificateThumbprint = $CertificateThumbprint
            CertificatePath       = $CertificatePath
            CertificatePassword   = $CertificatePassword
            Managedidentity       = $ManagedIdentity.IsPresent
            TenantId              = $TenantId
            AccessTokens          = $AccessTokens
        }

        Write-Verbose -Message "Found Role Group $($Name)"
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
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $Roles,

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

    Write-Verbose -Message "Setting Role Group configuration for $Name"

    $currentRoleGroupConfig = Get-TargetResource @PSBoundParameters

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

    $NewRoleGroupParams = @{
        Name        = $Name
        Description = $Description
        Roles       = $Roles
        Confirm     = $false
    }
    # Remove Description Parameter if null or Empty as the creation fails with $null parameter
    if ([System.String]::IsNullOrEmpty($Description))
    {
        $NewRoleGroupParams.Remove('Description') | Out-Null
    }
    # CASE: Role Group doesn't exist but should;
    if ($Ensure -eq 'Present' -and $currentRoleGroupConfig.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Role Group '$($Name)' does not exist but it should. Create and configure it."
        # Create Role Group
        if ($Members.Length -gt 0)
        {
            $NewRoleGroupParams.Add('Members', $Members)
        }
        New-RoleGroup @NewRoleGroupParams
    }
    # CASE: Role Group exists but it shouldn't;
    elseif ($Ensure -eq 'Absent' -and $currentRoleGroupConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Role Group '$($Name)' exists but it shouldn't. Remove it."
        Remove-RoleGroup -Identity $Name -Confirm:$false -Force
    }
    # CASE: Role Group exists and it should, but has different member values than the desired ones
    elseif ($Ensure -eq 'Present' -and $currentRoleGroupConfig.Ensure -eq 'Present' -and $null -ne (Compare-Object -ReferenceObject @($($currentRoleGroupConfig.Members) | Select-Object) -DifferenceObject @($Members | Select-Object)))
    {
        Write-Verbose -Message "Role Group '$($Name)' already exists, but members need updating."
        Write-Verbose -Message "Updating Role Group $($Name) members with values: $(Convert-M365DscHashtableToString -Hashtable $NewRoleGroupParams)"
        Update-RoleGroupMember -Identity $Name -Members $Members -Confirm:$false
    }
    # CASE: Role Assignment Policy exists and it should, but Role has no members as its never been set
    elseif ($Ensure -eq 'Present' -and $currentRoleGroupConfig.Ensure -eq 'Present' -and $currentRoleGroupConfig.Members -eq '')
    {
        Write-Verbose -Message "Role Group '$($Name)' already exists, but members need updating."
        Write-Verbose -Message "Updating Role Group $($Name) members with values: $(Convert-M365DscHashtableToString -Hashtable $NewRoleGroupParams)"
        Update-RoleGroupMember -Identity $Name -Members $Members -Confirm:$false
    }
    # CASE: Role Assignment Policy exists and it should, but Roles attribute has different values than the desired ones
    # Set-RoleGroup cannot change Roles attribute. Therefore we have to remove and recreate the assignment policies for the group if Roles attribute should be changed.
    elseif ($Ensure -eq 'Present' -and $currentRoleGroupConfig.Ensure -eq 'Present' -and $null -ne (Compare-Object -ReferenceObject $($currentRoleGroupConfig.Roles) -DifferenceObject $Roles))
    {
        Write-Verbose -Message "Role Group '$($Name)' already exists, but roles attribute needs updating."
        $differences = Compare-Object -ReferenceObject $($currentRoleGroupConfig.Roles) -DifferenceObject $Roles
        foreach ($difference in $differences)
        {
            if ($difference.SideIndicator -eq '=>')
            {
                Write-Verbose -Message "Adding Role {$($difference.InputObject)} to Role Group {$Name}"
                New-ManagementRoleAssignment -Role $($difference.InputObject) -SecurityGroup $Name
            }
            elseif ($difference.SideIndicator -eq '<=')
            {
                Write-Verbose -Message "Removing Role {$($difference.InputObject)} from Role Group {$Name}"
                Remove-ManagementRoleAssignment -Identity "$($difference.InputObject)-$Name"
            }
        }
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

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $Roles,

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

    Write-Verbose -Message "Testing Role Group configuration for $Name"

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
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-RoleGroup

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
        foreach ($RoleGroup in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($RoleGroup.Name)" -NoNewline
            $roleGroupMember = Get-RoleGroupMember -Identity $RoleGroup.Name | Select-Object DisplayName

            $Params = @{
                Name                  = $RoleGroup.Name
                Members               = $roleGroupMember.DisplayName
                Roles                 = $RoleGroup.Roles
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }
            $Script:exportedInstance = $RoleGroup
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

