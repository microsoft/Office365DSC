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
        [ValidateSet('ChangeOwner', 'ChangePermission', 'DeleteItem', 'ExternalAccount', 'FullAccess', 'ReadPermission')]
        [System.String[]]
        $AccessRights,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('None', 'All', 'Children', 'Descendents', 'SelfAndChildren')]
        $InheritanceType = 'All',

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter(Mandatory = $true)]
        [System.String]
        $User,

        [Parameter()]
        [System.Boolean]
        $Deny,

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
            Write-Verbose -Message "Getting permissions for Mailbox {$Identity}"

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

            $nullResult = @{
                Identity = $Identity
                Ensure   = 'Absent'
            }

            [Array]$permission = Get-MailboxPermission -Identity $Identity -ErrorAction Stop

            if ($permission.Length -gt 1)
            {
                $permission = $permission | Where-Object -FilterScript { $_.User -eq $User -and (Compare-Object -ReferenceObject $_.AccessRights.Replace(' ', '').Split(',') -DifferenceObject $AccessRights).Count -eq 0 }
            }

            if ($permission.Length -gt 1)
            {
                $permission = $permission[0]
            }

            if ($null -eq $permission)
            {
                Write-Verbose -Message "Permission for mailbox {$($Identity)} do not exist."
                return $nullResult
            }
        }
        else
        {
            $permission = $Script:exportedInstance
        }

        $result = @{
            Identity              = $permission.Identity
            AccessRights          = [Array]$permission.AccessRights.Replace(' ', '').Split(',')
            InheritanceType       = $permission.InheritanceType
            Owner                 = $permission.Owner
            User                  = $permission.User
            Deny                  = [Boolean]$permission.Deny
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

        Write-Verbose -Message "Found permissions for mailbox {$($Identity)}"
        return $result
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

        [Parameter(Mandatory = $true)]
        [ValidateSet('ChangeOwner', 'ChangePermission', 'DeleteItem', 'ExternalAccount', 'FullAccess', 'ReadPermission')]
        [System.String[]]
        $AccessRights,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('None', 'All', 'Children', 'Descendents', 'SelfAndChildren')]
        $InheritanceType = 'All',

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter(Mandatory = $true)]
        [System.String]
        $User,

        [Parameter()]
        [System.Boolean]
        $Deny,

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

    Write-Verbose -Message "Setting configuration of Mailbox Permissions for {$Identity}"

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

    $currentValues = Get-TargetResource @PSBoundParameters
    $instanceParams = [System.Collections.Hashtable]($PSBoundParameters)
    $instanceParams.Remove('Ensure') | Out-Null
    $instanceParams.Remove('Credential') | Out-Null
    $instanceParams.Remove('ApplicationId') | Out-Null
    $instanceParams.Remove('TenantId') | Out-Null
    $instanceParams.Remove('CertificateThumbprint') | Out-Null
    $instanceParams.Remove('CertificatePath') | Out-Null
    $instanceParams.Remove('CertificatePassword') | Out-Null
    $instanceParams.Remove('ManagedIdentity') | Out-Null
    $instanceParams.Remove('AccessTokens') | Out-Null

    if ($Ensure -eq 'Present' -and $currentValues.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Adding new permission for user {$User} on Mailbox {$Identity}"
        Add-MailboxPermission @instanceParams | Out-Null
    }
    elseif ($Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Removing permission for user {$User} on Mailbox {$Identity}"
        Remove-MailboxPermission @instanceParams
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
        [ValidateSet('ChangeOwner', 'ChangePermission', 'DeleteItem', 'ExternalAccount', 'FullAccess', 'ReadPermission')]
        [System.String[]]
        $AccessRights,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('None', 'All', 'Children', 'Descendents', 'SelfAndChildren')]
        $InheritanceType = 'All',

        [Parameter()]
        [System.String]
        $Owner,

        [Parameter(Mandatory = $true)]
        [System.String]
        $User,

        [Parameter()]
        [System.Boolean]
        $Deny,

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

    Write-Verbose -Message "Testing configuration of Mailbox Permission for {$Identity}"

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
        [array]$mailboxes = Get-Mailbox -ResultSize 'Unlimited' -ErrorAction Stop

        if ($mailboxes.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $dscContent = ''
        $i = 1
        foreach ($mailbox in $mailboxes)
        {
            Write-Host "    |---[$i/$($mailboxes.Count)] $($mailbox.UserPrincipalName)" -NoNewline

            [Array]$permissions = Get-MailboxPermission -Identity $mailbox.UserPrincipalName

            $j = 1
            Write-Host "`r`n" -NoNewline
            foreach ($permission in $permissions)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                Write-Host "        |---[$j/$($permissions.Count)] $($permission.Identity)" -NoNewline
                $Params = @{
                    Identity              = $mailbox.UserPrincipalName
                    AccessRights          = [Array]$permission.AccessRights.Replace(' ', '').Replace('SendAs,', '').Split(',') # ignore SendAs permissions since they are not supported by *-MailboxPermission cmdlets
                    InheritanceType       = $permission.InheritanceType
                    User                  = $permission.User
                    Credential            = $Credential
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    CertificatePassword   = $CertificatePassword
                    Managedidentity       = $ManagedIdentity.IsPresent
                    CertificatePath       = $CertificatePath
                    AccessTokens          = $AccessTokens
                }

                $Script:exportedInstance = $permission
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
                    $dscContent += $currentDSCBlock

                    Save-M365DSCPartialExport -Content $currentDSCBlock `
                        -FileName $Global:PartialExportFileName

                    Write-Host $Global:M365DSCEmojiGreenCheckMark
                }
                else
                {
                    Write-Host $Global:M365DSCEmojiRedX
                }
                $j++
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

Export-ModuleMember -Function *-TargetResource
