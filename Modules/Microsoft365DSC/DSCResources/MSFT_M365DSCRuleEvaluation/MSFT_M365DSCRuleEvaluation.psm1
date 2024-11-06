function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceTypeName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RuleDefinition,

        [Parameter()]
        [System.String]
        $AfterRuleCountQuery,

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
    return $null
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceTypeName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RuleDefinition,

        [Parameter()]
        [System.String]
        $AfterRuleCountQuery,

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
    # Not Implemented
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceTypeName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $RuleDefinition,

        [Parameter()]
        [System.String]
        $AfterRuleCountQuery,

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
    #region Telemetry
    $CurrentResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $CurrentResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message 'Testing configuration of AzureAD Tenant Details'

    $Global:PartialExportFileName = "$((New-Guid).ToString()).partial"
    $module = Join-Path -Path $PSScriptRoot -ChildPath "..\MSFT_$ResourceTypeName\MSFT_$ResourceTypeName.psm1" -Resolve
    if ($null -ne $module)
    {
        $params = @{
            Credential            = $PSBoundParameters.Credential
            ApplicationId         = $PSBoundParameters.ApplicationId
            TenantId              = $PSBoundParameters.TenantId
            CertificateThumbprint = $PSBoundParameters.CertificateThumbprint
            ManagedIdentity       = $PSBoundParameters.ManagedIdentity
            AccessTokens          = $AccessTokens
        }

        if ($null -ne $PSBoundParameters.ApplicationSecret)
        {
            $params.Add("ApplicationSecret", $PSBoundParameters.ApplicationSecret)
        }

        Write-Verbose -Message "Importing module from Path {$($module)}"
        Import-Module $module -Force -Function 'Export-TargetResource' | Out-Null
        $cmdName = "MSFT_$ResourceTypeName\Export-TargetResource"

        [Array]$instances = &$cmdName @params

        $DSCStringContent = @"
        # Generated with Microsoft365DSC version 1.23.906.1
        # For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
        param (
        )

        Configuration M365TenantConfig
        {
            param (
            )

            `$OrganizationName = `$ConfigurationData.NonNodeData.OrganizationName

            Import-DscResource -ModuleName 'Microsoft365DSC'

            Node localhost
            {
                $instances
            }
        }

        M365TenantConfig -ConfigurationData .\ConfigurationData.psd1
"@
        Write-Verbose -Message "Converting the retrieved instances into DSC Objects"
        $DSCConvertedInstances = ConvertTo-DSCObject -Content $DSCStringContent
        Write-Verbose -Message "Successfully converted {$($DSCConvertedInstances.Length)} DSC Objects."

        Write-Verbose -Message "Querying DSC Objects for invalid instances based on the specified Rule Definition."
        if ($RuleDefinition -eq '*')
        {
            [Array]$instances = $DSCConvertedInstances
            Write-Verbose -Message "Identified {$($instances.Length)} instances matching rule."
        }
        else
        {
            $queryBlock = [Scriptblock]::Create($RuleDefinition)
            [Array]$instances = $DSCConvertedInstances | Where-Object -FilterScript $queryBlock
            Write-Verbose -Message "Identified {$($instances.Length)} instances matching rule."
        }

        $result = ($instances.Length - $DSCConvertedInstances.Length) -eq 0

        $message = [System.Text.StringBuilder]::New()
        [void]$message.AppendLine("<M365DSCRuleEvaluation>")
        [void]$message.AppendLine("  <ResourceName>$ResourceTypeName</ResourceName>")
        [void]$message.AppendLine("  <RuleDefinition>$RuleDefinition</RuleDefinition>")

        if ($instances.Length -eq 0)
        {
            [array]$invalidInstances = $DSCConvertedInstances.ResourceInstanceName
            [void]$message.AppendLine("  <AfterRuleCount></AfterRuleCount>")
            [void]$message.AppendLine("  <Match></Match>")
        }
        else
        {
            if (-not [System.String]::IsNullOrEmpty($AfterRuleCountQuery))
            {
                [void]$message.AppendLine("  <AfterRuleCount>")
                [void]$message.AppendLine("    <Query>$AfterRuleCountQuery</Query>")

                Write-Verbose -Message "Checking the After Rule Count Query"
                $afterRuleCountQueryString = "`$instances.Length $AfterRuleCountQuery"
                $afterRuleCountQueryBlock = [Scriptblock]::Create($afterRuleCountQueryString)
                $result = [Boolean](Invoke-Command -ScriptBlock $afterRuleCountQueryBlock)
                [array]$validInstances = $instances.ResourceInstanceName
                [array]$invalidInstances = $DSCConvertedInstances.ResourceInstanceName | Where-Object -FilterScript { $_ -notin $validInstances }

                if (-not $result)
                {
                    [void]$message.AppendLine("    <MetQuery>False</MetQuery>")
                    [void]$message.AppendLine("  </AfterRuleCount>")
                    if ($validInstances.Count -gt 0)
                    {
                        [void]$message.AppendLine("  <Match>")
                        foreach ($validInstance in $validInstances)
                        {
                            [void]$message.AppendLine("    <ResourceInstanceName>[$ResourceTypeName]$validInstance</ResourceInstanceName>")
                        }
                        [void]$message.AppendLine("  </Match>")
                    }
                    else
                    {
                        [void]$message.AppendLine("  <Match></Match>")
                    }
                }
                else
                {
                    [void]$message.AppendLine("    <MetQuery>True</MetQuery>")
                    [void]$message.AppendLine("  </AfterRuleCount>")
                    [void]$message.AppendLine("  <Match>")
                    foreach ($validInstance in $validInstances)
                    {
                        [void]$message.AppendLine("    <ResourceInstanceName>[$ResourceTypeName]$validInstance</ResourceInstanceName>")
                    }
                    [void]$message.AppendLine("  </Match>")
                }
            }
            else
            {
                [void]$message.AppendLine("  <AfterRuleCount></AfterRuleCount>")

                $compareInstances = @()
                $compareInstances += Compare-Object -ReferenceObject $DSCConvertedInstances.ResourceInstanceName -DifferenceObject $instances.ResourceInstanceName -IncludeEqual
                if ($compareInstances.Count -gt 0)
                {
                    [array]$validInstances = $($compareInstances | Where-Object -FilterScript { $_.SideIndicator -eq '==' }).InputObject
                    [array]$invalidInstances = $($compareInstances | Where-Object -FilterScript { $_.SideIndicator -eq '<=' }).InputObject
                }
                else
                {
                    [array]$validInstances = @()
                    [array]$invalidInstances = [array]$DSCConvertedInstances.ResourceInstanceName
                }

                if ($validInstances.Count -gt 0)
                {
                    [void]$message.AppendLine("  <Match>")
                    foreach ($validInstance in $validInstances)
                    {
                        [void]$message.AppendLine("    <ResourceInstanceName>[$ResourceTypeName]$validInstance</ResourceInstanceName>")
                    }
                    [void]$message.AppendLine("  </Match>")
                }
                else
                {
                    [void]$message.AppendLine("  <Match></Match>")
                }
            }
        }

        # Log drifts for each invalid instances found.
        if ($invalidInstances.Count -gt 0)
        {
            [void]$message.AppendLine("  <NotMatch>")
            foreach ($invalidInstance in $invalidInstances)
            {
                [void]$message.AppendLine("    <ResourceInstanceName>[$ResourceTypeName]$invalidInstance</ResourceInstanceName>")
            }
            [void]$message.AppendLine("  </NotMatch>")
        }
        else
        {
            [void]$message.AppendLine("  <NotMatch></NotMatch>")
        }
        [void]$message.AppendLine("</M365DSCRuleEvaluation>")

        $Parameters = @{
            Message   = $message.ToString()
            EventType = 'RuleEvaluation'
            EventID   = 1
            Source    = $CurrentResourceName
        }
        if (-not $result)
        {
            $Parameters.Add('EntryType', 'Warning')
        }
        else
        {
            $Parameters.Add('EntryType', 'Information')
        }
        Add-M365DSCEvent @Parameters

        Write-Verbose -Message "Test-TargetResource returned $result"

        return $result
    }
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
    Write-Host "`r`n" -NoNewline
    return $null
}

Export-ModuleMember -Function *-TargetResource
