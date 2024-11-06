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

        [Parameter(Mandatory = $true)]
        [System.String]
        $InvoiceSectionId,

        [Parameter()]
        [System.String]
        $Status,

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
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            if (-not [System.String]::IsNullOrEmpty($Id))
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Name -eq $Id}
            }
            elseif ($null -eq $instance -and -not [System.String]::IsNullOrEmpty($Name))
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.properties.displayName -eq $DisplayName -and `
                                                                                    $_.properties.invoiceSectionId -eq $InvoiceSectionId}
            }
        }
        else
        {
            if (-not [System.String]::IsNullOrEmpty($Id))
            {
                $uri = "https://management.azure.com$($InvoiceSectionId)/billingSubscriptions/$($Id)?api-version=2024-04-01"
                $response = Invoke-AzRest -Uri $uri -Method Get
                $instance = (ConvertFrom-Json $response.Content).value
            }
            elseif ($null -eq $instance -and -not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $uri = "https://management.azure.com$($InvoiceSectionId)/billingSubscriptions?api-version=2024-04-01"
                $response = Invoke-AzRest -Uri $uri -Method Get
                $instances = (ConvertFrom-Json $response.Content).value
                $instance = $instances | Where-Object -FilterScript {$_.properties.displayName -eq $DisplayName}
            }
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            DisplayName           = $instance.properties.displayName
            Id                    = $instance.name
            InvoiceSectionId      = $instance.properties.invoiceSectionId
            Status                = $instance.properties.status
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
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $InvoiceSectionId,

        [Parameter()]
        [System.String]
        $Status,

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

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $uri = "https://management.azure.com/providers/Microsoft.Subscription/aliases/$((New-GUID).ToString())?api-version=2021-10-01"
        $params = @{
            properties = @{
                billingScope = $InvoiceSectionId
                DisplayName  = $DisplayName
                Workload     = "Production"
            }
        }
        $payload = ConvertTo-Json $params -Depth 10 -Compress
        Write-Verbose -Message "Creating new subscription {$DisplayName} with payload:`r`n$payload"
        $response = Invoke-AzRest -Uri $uri -Method PUT -Payload $payload
        Write-Verbose -Message "Result: $($response.Content)"
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        if ($Status -eq 'Active')
        {
            Write-Verbose -Message "Enabling subscription {$Name}"
            Enable-AzSubscription -Id $currentInstance.Id | Out-Null
        }
        elseif (-not $Enabled)
        {
            Write-Verbose -Message "Disabling subscription {$Name}"
            Disable-AzSubscription -Id $currentInstance.Id | Out-Null
        }
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        throw "This resource cannot remove Azure subscriptions."
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

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $InvoiceSectionId,

        [Parameter()]
        [System.String]
        $Status,

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

        $uri = 'https://management.azure.com/providers/Microsoft.Billing/billingaccounts/?api-version=2020-05-01'
        $response = Invoke-AzRest -Uri $uri -Method Get
        $billingAccounts = (ConvertFrom-Json $response.Content).value

        foreach ($billingAccount in $billingAccounts)
        {
            $uri = "https://management.azure.com/providers/Microsoft.Billing/billingaccounts/$($billingAccount.Name)/billingprofiles/?api-version=2020-05-01"
            $response = Invoke-AzRest -Uri $uri -Method Get
            $billingProfiles = (ConvertFrom-Json $response.Content).value

            foreach ($profile in $billingProfiles)
            {
                $uri = "https://management.azure.com/providers/Microsoft.Billing/billingAccounts/$($billingAccount.name)/billingProfiles/$($profile.name)/billingSubscriptions?api-version=2024-04-01"
                $response = Invoke-AzRest -Uri $uri -Method Get
                $subscriptions = (ConvertFrom-Json $response.Content).value
                [array] $Script:exportedInstances += $subscriptions

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
                foreach ($config in $subscriptions)
                {
                    if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                    {
                        $Global:M365DSCExportResourceInstancesCount++
                    }
                    $displayedKey = $config.properties.displayName
                    Write-Host "    |---[$i/$($subscriptions.Count)] $displayedKey" -NoNewline
                    $params = @{
                        DisplayName           = $config.properties.displayName
                        Id                    = $config.Name
                        InvoiceSectionId      = $config.properties.invoiceSectionId
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
                    $i++
                    Write-Host $Global:M365DSCEmojiGreenCheckMark
                }
            }
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
