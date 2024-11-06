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
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PolicyRules,

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
    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Name -eq $Name}
        }
        else
        {
            $instance = Get-MgBetaNetworkAccessForwardingPolicy -Expand * -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $Name }
        }
        if ($null -eq $instance)
        {
            throw "Could not retrieve the Forwarding Policy with name: $Name"
        }

        $complexPolicyRules = Get-MicrosoftGraphNetworkAccessForwardingPolicyRules -PolicyRules $instance.PolicyRules

        $results = @{
            Name                  = $instance.name
            PolicyRules           = $complexPolicyRules
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
        $Name,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PolicyRules,

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

    $setParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    $currentPolicy = Get-MgBetaNetworkAccessForwardingPolicy -Expand * -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $setParameters.Name }
    if ($Name -eq "Custom Bypass") {
        foreach ($rule in $currentPolicy.PolicyRules) {
            Remove-MgBetaNetworkAccessForwardingPolicyRule -ForwardingPolicyId $currentPolicy.Id -PolicyRuleId $rule.Id
        }

        foreach ($rule in $setParameters.PolicyRules) {
            $complexDestinations = @()
            foreach ($destination in $rule.Destinations) {
                $complexDestinations += @{
                    "@odata.type" = "#microsoft.graph.networkaccess." + $rule.RuleType
                    value         = $destination
                }
            }
            $params = @{
                "@odata.type" = "#microsoft.graph.networkaccess.internetAccessForwardingRule"
                name = $rule.Name
                action = $rule.ActionValue
                ruleType = $rule.RuleType
                ports = ($rule.Ports | ForEach-Object { $_.ToString() })
                protocol = $rule.Protocol
                destinations = $complexDestinations
            }

            New-MgBetaNetworkAccessForwardingPolicyRule -ForwardingPolicyId $currentPolicy.Id -BodyParameter $params
        }
    } elseif ($currentPolicy.TrafficForwardingType -eq "m365") {
        $rulesParam = @()
        foreach ($desiredRule in $setParameters.PolicyRules) {
            $desiredRuleHashtable = Convert-M365DSCDRGComplexTypeToHashtable $desiredRule
            $desiredRuleHashtable.Remove('actionValue')
            $testResult = $false
            foreach ($currentRule in $currentPolicy.PolicyRules) {
                $currentRuleHashtable = Get-MicrosoftGraphNetworkAccessForwardingPolicyRules -PolicyRules @($currentRule)
                $currentRuleHashtable.Remove('ActionValue');
                $testResult = Compare-M365DSCComplexObject `
                -Source ($currentRuleHashtable) `
                -Target ($desiredRuleHashtable)
                if ($testResult) {
                    Write-Verbose "Updating: $($currentRule.Name), $($currentRule.Id)"
                    $rulesParam += @{
                        ruleId = $currentRule.Id
                        action = $desiredRule.ActionValue
                    }
                    break
                }
            }
            if($testResult -eq $false){
                Write-Verbose "Could not find rule with the given specification: $(Convert-M365DscHashtableToString -Hashtable $desiredRuleHashtable), skipping set for this."
            }
        }
        $updateParams = @{
            rules = $rulesParam
        }

        Invoke-MgGraphRequest -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/networkAccess/forwardingPolicies/$($currentPolicy.ID)/updatePolicyRules" -Method Post -Body $updateParams
    }
    else {
        Write-Verbose "Can not modify the list of poilicy rules for the forwarding policy with name: $($setParameters.Name)"
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
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PolicyRules,

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

    $testTargetResource = $true
    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($null -ne $source -and $source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                $testTargetResource = $false
            }
            else {
                $ValuesToCheck.Remove($key) | Out-Null
            }
        }
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
    -Source $($MyInvocation.MyCommand.Source) `
    -DesiredValues $PSBoundParameters `
    -ValuesToCheck $ValuesToCheck.Keys `
    -IncludedDrifts $driftedParams

    if(-not $TestResult)
    {
        $testTargetResource = $false
    }

    Write-Verbose -Message "Test-TargetResource returned $testTargetResource"

    return $testTargetResource
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
        [array] $Script:exportedInstances = Get-MgBetaNetworkAccessForwardingPolicy -Expand * -ErrorAction Stop

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
        foreach ($config in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Name
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Name                  = $config.Name
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

            if ($null -ne $Results.PolicyRules)
            {
                $Results.PolicyRules = Get-MicrosoftGraphNetworkAccessForwardingPolicyRulesAsString -PolicyRules $Results.PolicyRules
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

                if ($null -ne $Results.PolicyRules)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                        -ParameterName 'PolicyRules'
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
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

function Get-MicrosoftGraphNetworkAccessForwardingPolicyRules
{
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $PolicyRules
    )

    $newPolicyRules = @()
    foreach ($rule in $PolicyRules) {
        $destinations = @()
        foreach ($destination in $rule.AdditionalProperties.destinations) {
            $destinations += $destination.value
        }
        $newPolicyRules += @{
            Name = $rule.Name
            ActionValue = $rule.AdditionalProperties.action
            RuleType = $rule.AdditionalProperties.ruleType
            Ports = $rule.AdditionalProperties.ports
            Protocol = $rule.AdditionalProperties.protocol
            Destinations = $destinations
        }
    }

    return $newPolicyRules
}

function Get-MicrosoftGraphNetworkAccessForwardingPolicyRulesAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $PolicyRules
    )

    $StringContent = [System.Text.StringBuilder]::new()
    $StringContent.Append('@(') | Out-Null

    foreach ($rule in $PolicyRules)
    {
        $StringContent.Append("`n                MSFT_MicrosoftGraphNetworkAccessForwardingPolicyRule {`r`n") | Out-Null
        $StringContent.Append("                    Name           = '" + $rule.Name + "'`r`n") | Out-Null
        $StringContent.Append("                    ActionValue    = '" + $rule.ActionValue + "'`r`n") | Out-Null
        $StringContent.Append("                    RuleType       = '" + $rule.RuleType + "'`r`n") | Out-Null
        $StringContent.Append("                    Protocol       = '" + $rule.Protocol + "'`r`n") | Out-Null
        $StringContent.Append("                    Ports          = @(" + $($rule.Ports -join ", ") + ")`r`n") | Out-Null
        $StringContent.Append("                    Destinations   = @(" + $(($rule.Destinations | ForEach-Object { "'$_'" }) -join ", ") + ")`r`n") | Out-Null
        $StringContent.Append("                }`r`n") | Out-Null
    }

    $StringContent.Append('            )') | Out-Null
    return $StringContent.ToString()
}


Export-ModuleMember -Function *-TargetResource
