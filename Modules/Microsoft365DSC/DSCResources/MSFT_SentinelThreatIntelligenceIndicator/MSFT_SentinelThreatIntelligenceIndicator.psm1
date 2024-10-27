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
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $WorkspaceName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PatternType,

        [Parameter()]
        [System.String]
        $Pattern,

        [Parameter()]
        [System.Boolean]
        $Revoked,

        [Parameter()]
        [System.String]
        $ValidFrom,

        [Parameter()]
        [System.String]
        $ValidUntil,

        [Parameter()]
        [System.String]
        $Source,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ThreatIntelligenceTags,

        [Parameter()]
        [System.String[]]
        $ThreatTypes,

        [Parameter()]
        [System.String[]]
        $KillChainPhases,

        [Parameter()]
        [System.UInt32]
        $Confidence,

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

    if ([System.String]::IsNullOrEmpty($TenantId) -and -not $null -eq $Credential)
    {
        $TenantId = $Credential.UserName.Split('@')[1]
    }
    try
    {
        if (-not [System.String]::IsNullOrEmpty($Id))
        {
            Write-Verbose -Message "Retrieving indicator by id {$Id}"
            $instance = Get-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $SubscriptionId `
                                                                       -ResourceGroupName $ResourceGroupName `
                                                                       -WorkspaceName $WorkspaceName `
                                                                       -TenantId $TenantId `
                                                                       -Id $Id
        }
        if ($null -eq $instance)
        {
            Write-Verbose -Message "Retrieving indicator by DisplayName {$DisplayName}"
            $instances = Get-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $SubscriptionId `
                                                                        -ResourceGroupName $ResourceGroupName `
                                                                        -WorkspaceName $WorkspaceName `
                                                                        -TenantId $TenantId
            $instance = $instances | Where-Object -FilterScript {$_.properties.displayName -eq $DisplayName}
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            DisplayName            = $instance.properties.displayName
            SubscriptionId         = $SubscriptionId
            ResourceGroupName      = $ResourceGroupName
            WorkspaceName          = $WorkspaceName
            Id                     = $instance.name
            Description            = $instance.properties.description
            PatternType            = $instance.properties.patternType
            Pattern                = $instance.properties.pattern
            Revoked                = $instance.properties.revoked
            ValidFrom              = $instance.properties.validFrom
            ValidUntil             = $instance.properties.validUntil
            Labels                 = $instance.properties.labels
            ThreatIntelligenceTags = $instance.properties.threatIntelligenceTags
            ThreatTypes            = $instance.properties.threatTypes
            KillChainPhases        = $instance.properties.KillChainPhases.phaseName
            Confidence             = $instance.properties.confidence
            Source                 = $instance.properties.source
            Ensure                 = 'Present'
            Credential             = $Credential
            ApplicationId          = $ApplicationId
            TenantId               = $TenantId
            CertificateThumbprint  = $CertificateThumbprint
            ManagedIdentity        = $ManagedIdentity.IsPresent
            AccessTokens           = $AccessTokens
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
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $WorkspaceName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PatternType,

        [Parameter()]
        [System.String]
        $Pattern,

        [Parameter()]
        [System.Boolean]
        $Revoked,

        [Parameter()]
        [System.String]
        $ValidFrom,

        [Parameter()]
        [System.String]
        $ValidUntil,

        [Parameter()]
        [System.String]
        $Source,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ThreatIntelligenceTags,

        [Parameter()]
        [System.String[]]
        $ThreatTypes,

        [Parameter()]
        [System.String[]]
        $KillChainPhases,

        [Parameter()]
        [System.UInt32]
        $Confidence,

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

    $instanceParameters = @{
        kind = 'indicator'
        properties = @{
            confidence             = $Confidence
            description            = $Description
            displayName            = $DisplayName
            labels                 = $Labels
            pattern                = $Pattern
            patternType            = $patternType
            revoked                = $revoked
            source                 = $Source
            threatIntelligenceTags = $ThreatIntelligenceTags
            threatTypes            = $ThreatTypes
            validFrom              = $ValidFrom
            validUntil             = $ValidUntil
        }
    }

    if ($null -ne $KillChainPhases)
    {
        $values = @()
        foreach ($phase in $KillChainPhases)
        {
            $values += @{
                killChainName = 'lockheed-martin-cyber-kill-chain'
                phaseName     = $phase.phaseName
            }
        }
        $instanceParameters.properties.Add('KillChainPhases', $values)
    }


    if ([System.String]::IsNullOrEmpty($TenantId) -and -not $null -eq $Credential)
    {
        $TenantId = $Credential.UserName.Split('@')[1]
    }

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating a new indicator {$DisplayName}"
        New-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $SubscriptionId `
                                                       -ResourceGroupName $ResourceGroupName `
                                                       -WorkspaceName $WorkspaceName `
                                                       -TenantId $TenantId `
                                                       -Body $instanceParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating indicator {$DisplayName}"
        Set-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $SubscriptionId `
                                                       -ResourceGroupName $ResourceGroupName `
                                                       -WorkspaceName $WorkspaceName `
                                                       -TenantId $TenantId `
                                                       -Body $instanceParameters `
                                                       -Id $currentInstance.Id
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing indicator {$DisplayName}"
        Remove-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $SubscriptionId `
                                                          -ResourceGroupName $ResourceGroupName `
                                                          -WorkspaceName $WorkspaceName `
                                                          -TenantId $TenantId `
                                                          -Id $currentInstance.Id
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
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $WorkspaceName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PatternType,

        [Parameter()]
        [System.String]
        $Pattern,

        [Parameter()]
        [System.Boolean]
        $Revoked,

        [Parameter()]
        [System.String]
        $ValidFrom,

        [Parameter()]
        [System.String]
        $ValidUntil,

        [Parameter()]
        [System.String]
        $Source,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ThreatIntelligenceTags,

        [Parameter()]
        [System.String[]]
        $ThreatTypes,

        [Parameter()]
        [System.String[]]
        $KillChainPhases,

        [Parameter()]
        [System.UInt32]
        $Confidence,

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
        $workspaces = Get-AzResource -ResourceType 'Microsoft.OperationalInsights/workspaces'
        $Script:exportedInstances = @()
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

        if ([System.String]::IsNullOrEmpty($TenantId) -and $null -ne $Credential)
        {
            $TenantId = $Credential.UserName.Split('@')[1]
        }
        foreach ($workspace in $workspaces)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($workspaces.Length)] $($workspace.Name)" -NoNewline
            $subscriptionId    = $workspace.ResourceId.Split('/')[2]
            $resourceGroupName = $workspace.ResourceGroupName
            $workspaceName     = $workspace.Name

            $indicators = Get-M365DSCSentinelThreatIntelligenceIndicator -SubscriptionId $subscriptionId `
                                                                         -ResourceGroupName $resourceGroupName `
                                                                         -WorkspaceName $workspaceName `
                                                                         -TenantId $TenantId

            $j = 1
            if ($currentWatchLists.Length -eq 0 )
            {
                Write-Host $Global:M365DSCEmojiGreenCheckMark
            }
            else
            {
                Write-Host "`r`n" -NoNewline
            }

            foreach ($indicator in $indicators)
            {
                $displayedKey = $indicator.properties.DisplayName
                Write-Host "        |---[$j/$($indicators.Count)] $displayedKey" -NoNewline
                $params = @{
                    DisplayName           = $indicator.properties.displayName
                    Id                    = $indicator.name
                    SubscriptionId        = $subscriptionId
                    ResourceGroupName     = $resourceGroupName
                    WorkspaceName         = $workspaceName
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

function Get-M365DSCSentinelThreatIntelligenceIndicator
{
    [CmdletBinding()]
    [OutputType([Array])]
    param(
        [Parameter()]
        [System.String]
        $SubscriptionId,

        [Parameter()]
        [System.String]
        $ResourceGroupName,

        [Parameter()]
        [System.String]
        $WorkspaceName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $Id
    )

    try
    {
        $hostUrl = Get-M365DSCAPIEndpoint -TenantId $TenantId
        $uri = $hostUrl.AzureManagement + "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/"
        if (-not [System.String]::IsNullOrEmpty($Id))
        {
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/$($Id)?api-version=2024-03-01"
            $response = Invoke-AzRest -Uri $uri -Method 'GET'
            $result = ConvertFrom-Json $response.Content
            return $result
        }
        else
        {
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators?api-version=2024-03-01"
            $response = Invoke-AzRest -Uri $uri -Method 'GET'
            $result = ConvertFrom-Json $response.Content
            return $result.value
        }
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId
        throw $_
    }
}

function New-M365DSCSentinelThreatIntelligenceIndicator
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [System.String]
        $SubscriptionId,

        [Parameter()]
        [System.String]
        $ResourceGroupName,

        [Parameter()]
        [System.String]
        $WorkspaceName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    try
    {
        $hostUrl = Get-M365DSCAPIEndpoint -TenantId $TenantId
        $uri = $hostUrl.AzureManagement + "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/"

        $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/threatIntelligence/main/createIndicator?api-version=2024-03-01"
        $payload = ConvertTo-Json $Body -Depth 10 -Compress
        $response = Invoke-AzRest -Uri $uri -Method 'POST' -Payload $payload
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId
        throw $_
    }
}

function Set-M365DSCSentinelThreatIntelligenceIndicator
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [System.String]
        $SubscriptionId,

        [Parameter()]
        [System.String]
        $ResourceGroupName,

        [Parameter()]
        [System.String]
        $WorkspaceName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TenantId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    try
    {
        $hostUrl = Get-M365DSCAPIEndpoint -TenantId $TenantId
        $uri = $hostUrl.AzureManagement + "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/"

        $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/$($Id)?api-version=2024-03-01"
        $payload = ConvertTo-Json $Body -Depth 10 -Compress
        $response = Invoke-AzRest -Uri $uri -Method 'PUT' -Payload $payload
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId
        throw $_
    }
}

function Remove-M365DSCSentinelThreatIntelligenceIndicator
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [System.String]
        $SubscriptionId,

        [Parameter()]
        [System.String]
        $ResourceGroupName,

        [Parameter()]
        [System.String]
        $WorkspaceName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TenantId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id
    )

    try
    {
        $hostUrl = Get-M365DSCAPIEndpoint -TenantId $TenantId
        $uri = $hostUrl.AzureManagement + "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/"

        $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/$($Id)?api-version=2024-03-01"
        $response = Invoke-AzRest -Uri $uri -Method 'DELETE'
    }
    catch
    {
        Write-Verbose -Message $_
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId
        throw $_
    }
}

Export-ModuleMember -Function *-TargetResource
