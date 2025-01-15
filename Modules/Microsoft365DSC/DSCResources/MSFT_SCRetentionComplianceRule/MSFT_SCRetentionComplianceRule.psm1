function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $ExcludedItemClasses,

        [Parameter()]
        [System.String]
        $RetentionDuration,

        [Parameter()]
        [ValidateSet('Days', 'Months', 'Years')]
        [System.String]
        $RetentionDurationDisplayHint = 'Days',

        [Parameter()]
        [System.String]
        $ContentMatchQuery,

        [Parameter()]
        [ValidateSet('CreationAgeInDays', 'ModificationAgeInDays')]
        [System.String]
        $ExpirationDateOption,

        [Parameter()]
        [ValidateSet('Delete', 'Keep', 'KeepAndDelete')]
        [System.String]
        $RetentionComplianceAction,

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
        [System.String[]]
        $AccessTokens
    )

    try
    {
        if (-not $Script:exportedInstance)
        {
            Write-Verbose -Message "Getting configuration of RetentionComplianceRule for $Name"

            $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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

            $RuleObject = Get-RetentionComplianceRule -Identity $Name `
                -ErrorAction SilentlyContinue

            if ($null -eq $RuleObject)
            {
                Write-Verbose -Message "RetentionComplianceRule $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $RuleObject = $Script:exportedInstance
        }

        Write-Verbose "Found existing RetentionComplianceRule $($Name)"
        $AssociatedPolicy = Get-RetentionCompliancePolicy $RuleObject.Policy
        $RetentionComplianceActionValue = $null
        if (-not [System.String]::IsNullOrEmpty($ruleObject.RetentionComplianceAction))
        {
            $RetentionComplianceActionValue = $RuleObject.RetentionComplianceAction
        }
        $result = @{
            Name                         = $RuleObject.Name
            Comment                      = $RuleObject.Comment
            Policy                       = $AssociatedPolicy.Name
            RetentionDuration            = $RuleObject.RetentionDuration
            RetentionComplianceAction    = $RetentionComplianceActionValue
            RetentionDurationDisplayHint = $RuleObject.RetentionDurationDisplayHint
            ExpirationDateOption         = $RuleObject.ExpirationDateOption
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            TenantId                     = $TenantId
            CertificateThumbprint        = $CertificateThumbprint
            CertificatePath              = $CertificatePath
            CertificatePassword          = $CertificatePassword
            Ensure                       = 'Present'
            AccessTokens                 = $AccessTokens
        }
        if (-not $associatedPolicy.TeamsPolicy)
        {
            $result.Add('ExcludedItemClasses', $RuleObject.ExcludedItemClasses)
            $result.Add('ContentMatchQuery', $RuleObject.ContentMatchQuery)
        }

        Write-Verbose -Message "Found RetentionComplianceRule $($Name)"
        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
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
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $ExcludedItemClasses,

        [Parameter()]
        [System.String]
        $RetentionDuration,

        [Parameter()]
        [ValidateSet('Days', 'Months', 'Years')]
        [System.String]
        $RetentionDurationDisplayHint = 'Days',

        [Parameter()]
        [System.String]
        $ContentMatchQuery,

        [Parameter()]
        [ValidateSet('CreationAgeInDays', 'ModificationAgeInDays')]
        [System.String]
        $ExpirationDateOption,

        [Parameter()]
        [ValidateSet('Delete', 'Keep', 'KeepAndDelete')]
        [System.String]
        $RetentionComplianceAction,

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
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Setting configuration of RetentionComplianceRule for $Name"

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

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters

    $CurrentRule = Get-TargetResource @PSBoundParameters

    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentRule.Ensure))
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove('Ensure')

        # Remove authentication parameters
        $CreationParams.Remove('Credential') | Out-Null
        $CreationParams.Remove('ApplicationId') | Out-Null
        $CreationParams.Remove('TenantId') | Out-Null
        $CreationParams.Remove('CertificatePath') | Out-Null
        $CreationParams.Remove('CertificatePassword') | Out-Null
        $CreationParams.Remove('CertificateThumbprint') | Out-Null
        $CreationParams.Remove('ManagedIdentity') | Out-Null
        $CreationParams.Remove('ApplicationSecret') | Out-Null
        $CreationParams.Remove('AccessTokens') | Out-Null

        Write-Verbose -Message 'Checking to see if the policy is a Teams based one.'
        $RuleObject = Get-RetentionComplianceRule -Identity $Name `
            -ErrorAction SilentlyContinue
        $AssociatedPolicy = Get-RetentionCompliancePolicy $Policy

        if ($AssociatedPolicy.TeamsPolicy)
        {
            Write-Verbose -Message 'The current policy is a Teams based one, removing invalid parameters for Creation.'
            if ($CreationParams.ContainsKey('ApplyComplianceTag'))
            {
                $CreationParams.Remove('ApplyComplianceTag') | Out-Null
            }
            if ($CreationParams.ContainsKey('ContentContainsSensitiveInformation'))
            {
                $CreationParams.Remove('ContentContainsSensitiveInformation') | Out-Null
            }
            if ($CreationParams.ContainsKey('ContentMatchQuery'))
            {
                $CreationParams.Remove('ContentMatchQuery') | Out-Null
            }
            if ($CreationParams.ContainsKey('ExcludedItemClasses'))
            {
                $CreationParams.Remove('ExcludedItemClasses') | Out-Null
            }
            if ($CreationParams.ContainsKey('ExpirationDateOption'))
            {
                $CreationParams.Remove('ExpirationDateOption') | Out-Null
            }
            if ($CreationParams.ContainsKey('PublishComplianceTag'))
            {
                $CreationParams.Remove('PublishComplianceTag') | Out-Null
            }
            if ($CreationParams.ContainsKey('RetentionDurationDisplayHint'))
            {
                $CreationParams.Remove('RetentionDurationDisplayHint') | Out-Null
            }
        }

        Write-Verbose -Message "Creating new RetentionComplianceRule with values:`r`n$(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        New-RetentionComplianceRule @CreationParams
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentRule.Ensure))
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove('Ensure')
        $CreationParams.Remove('Name')
        $CreationParams.Add('Identity', $Name)
        $CreationParams.Remove('Policy')

        # Remove authentication parameters
        $CreationParams.Remove('Credential') | Out-Null
        $CreationParams.Remove('ApplicationId') | Out-Null
        $CreationParams.Remove('TenantId') | Out-Null
        $CreationParams.Remove('CertificatePath') | Out-Null
        $CreationParams.Remove('CertificatePassword') | Out-Null
        $CreationParams.Remove('CertificateThumbprint') | Out-Null
        $CreationParams.Remove('ManagedIdentity') | Out-Null
        $CreationParams.Remove('ApplicationSecret') | Out-Null
        $CreationParams.Remove('AccessTokens') | Out-Null

        Write-Verbose -Message 'Checking to see if the policy is a Teams based one.'
        $RuleObject = Get-RetentionComplianceRule -Identity $Name `
            -ErrorAction SilentlyContinue
        $AssociatedPolicy = Get-RetentionCompliancePolicy $RuleObject.Policy

        if ($AssociatedPolicy.TeamsPolicy)
        {
            Write-Verbose -Message 'The current policy is a Teams based one, removing invalid parameters for Update.'

            if ($CreationParams.ContainsKey('ApplyComplianceTag'))
            {
                $CreationParams.Remove('ApplyComplianceTag') | Out-Null
            }
            if ($CreationParams.ContainsKey('ContentContainsSensitiveInformation'))
            {
                $CreationParams.Remove('ContentContainsSensitiveInformation') | Out-Null
            }
            if ($CreationParams.ContainsKey('ContentMatchQuery'))
            {
                $CreationParams.Remove('ContentMatchQuery') | Out-Null
            }
            if ($CreationParams.ContainsKey('ExcludedItemClasses'))
            {
                $CreationParams.Remove('ExcludedItemClasses') | Out-Null
            }
            if ($CreationParams.ContainsKey('ExpirationDateOption'))
            {
                $CreationParams.Remove('ExpirationDateOption') | Out-Null
            }
            if ($CreationParams.ContainsKey('PublishComplianceTag'))
            {
                $CreationParams.Remove('PublishComplianceTag') | Out-Null
            }
            if ($CreationParams.ContainsKey('RetentionDurationDisplayHint'))
            {
                $CreationParams.Remove('RetentionDurationDisplayHint') | Out-Null
            }
        }

        Write-Verbose -Message "Updating RetentionComplianceRule with values:`r`n$(Convert-M365DscHashtableToString -Hashtable $CreationParams)"

        $success = $false
        $retries = 1
        while (!$success -and $retries -le 10)
        {
            try
            {
                Set-RetentionComplianceRule @CreationParams -ErrorAction Stop
                $success = $true
            }
            catch
            {
                if ($_.Exception.Message -like '*are being deployed. Once deployed, additional actions can be performed*')
                {
                    Write-Verbose -Message "The associated policy has pending changes being deployed. Waiting 30 seconds for a maximum of 300 seconds (5 minutes). Total time waited so far {$($retries * 30) seconds}"
                    Start-Sleep -Seconds 30
                }
                else
                {
                    $success = $true
                }
            }
            $retries++
        }
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentPolicy.Ensure))
    {
        # If the Rule exists and it shouldn't, simply remove it;
        Remove-RetentionComplianceRule -Identity $Name
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

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $ExcludedItemClasses,

        [Parameter()]
        [System.String]
        $RetentionDuration,

        [Parameter()]
        [ValidateSet('Days', 'Months', 'Years')]
        [System.String]
        $RetentionDurationDisplayHint = 'Days',

        [Parameter()]
        [System.String]
        $ContentMatchQuery,

        [Parameter()]
        [ValidateSet('CreationAgeInDays', 'ModificationAgeInDays')]
        [System.String]
        $ExpirationDateOption,

        [Parameter()]
        [ValidateSet('Delete', 'Keep', 'KeepAndDelete')]
        [System.String]
        $RetentionComplianceAction,

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

    Write-Verbose -Message "Testing configuration of RetentionComplianceRule for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters
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
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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
        [array]$policies = Get-RetentionCompliancePolicy -ErrorAction Stop

        $j = 1
        $dscContent = ''
        if ($policies.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($policy in $policies)
        {
            [array]$rules = Get-RetentionComplianceRule -Policy $policy.Name
            Write-Host "    Policy [$j/$($policies.Length)] $($policy.Name)"
            $i = 1

            foreach ($rule in $rules)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                Write-Host "        |---[$i/$($rules.Length)] $($rule.Name)" -NoNewline

                $Script:exportedInstance = $rule
                $Results = Get-TargetResource @PSBoundParameters `
                    -Name $rule.Name `
                    -Policy $rule.Policy

                if ([System.String]::IsNullOrEmpty($Results.ExpirationDateOption))
                {
                    $Results.Remove('ExpirationDateOption') | Out-Null
                }
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
                $i++
            }
            $j++
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
