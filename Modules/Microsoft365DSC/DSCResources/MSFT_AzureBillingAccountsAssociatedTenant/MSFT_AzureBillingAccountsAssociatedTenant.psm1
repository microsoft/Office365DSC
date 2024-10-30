function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AssociatedTenantId,

        [Parameter()]
        [System.String]
        $BillingManagementState,

        [Parameter()]
        [System.String]
        $ProvisioningManagementState,

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
            $instances = Get-M365DSCAzureBillingAccountsAssociatedTenant -BillingAccountId $currentAccount.Name -ErrorAction Stop
            $instance = $instances.value | Where-Object -FilterScript {$_.properties.displayName -eq $DisplayName}
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            BillingAccount              = $BillingAccount
            DisplayName                 = $DisplayName
            AssociatedTenantId          = $instance.properties.tenantId
            BillingManagementState      = $instance.properties.billingManagementState
            ProvisioningManagementState = $instance.properties.provisioningManagementState
            Ensure                      = 'Present'
            Credential                  = $Credential
            ApplicationId               = $ApplicationId
            TenantId                    = $TenantId
            CertificateThumbprint       = $CertificateThumbprint
            ManagedIdentity             = $ManagedIdentity.IsPresent
            AccessTokens                = $AccessTokens
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
        $DisplayName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AssociatedTenantId,

        [Parameter()]
        [System.String]
        $BillingManagementState,

        [Parameter()]
        [System.String]
        $ProvisioningManagementState,

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
    $billingAccounts = Get-M365DSCAzureBillingAccount
    $account = $billingAccounts.value | Where-Object -FilterScript {$_.properties.displayName -eq $BillingAccount}

    $instanceParams = @{
        properties = @{
            displayName                 = $DisplayName
            tenantId                    = $AssociatedTenantId
            billingManagementState      = $BillingManagementState
            provisioningManagementState = $ProvisioningManagementState
        }
    }
    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Adding associated tenant {$AssociatedTenantId}"
        New-M365DSCAzureBillingAccountsAssociatedTenant  -BillingAccountId $account.Name `
                                                         -AssociatedTenantId $AssociatedTenantId `
                                                         -Body $instanceParams
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating associated tenant {$AssociatedTenantId}"
        New-M365DSCAzureBillingAccountsAssociatedTenant  -BillingAccountId $account.Name `
                                                         -AssociatedTenantId $AssociatedTenantId `
                                                         -Body $instanceParams
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing associated tenant {$AssociatedTenantId}"
        Remove-M365DSCAzureBillingAccountsAssociatedTenant -BillingAccountId $account.Name `
                                                           -AssociatedTenantId $AssociatedTenantId
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
        $DisplayName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $BillingAccount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AssociatedTenantId,

        [Parameter()]
        [System.String]
        $BillingManagementState,

        [Parameter()]
        [System.String]
        $ProvisioningManagementState,

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
        [array] $Script:exportedInstances = @()
        foreach ($config in $accounts.value)
        {
            $displayedKey = $config.properties.displayName
            Write-Host "    |---[$i/$($accounts.Count)] $displayedKey"

            $associatedTenants += Get-M365DSCAzureBillingAccountsAssociatedTenant -BillingAccountId $config.name

            $j = 1
            foreach ($associatedTenant in $associatedTenants.value)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }
                Write-Host "        |---[$j/$($associatedTenants.value.Length)] $($associatedTenant.properties.DisplayName)" -NoNewline
                $params = @{
                    BillingAccount        = $config.properties.displayName
                    DisplayName           = $associatedTenant.properties.displayName
                    AssociatedTenantId    = $associatedTenant.properties.tenantId
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

Export-ModuleMember -Function *-TargetResource
