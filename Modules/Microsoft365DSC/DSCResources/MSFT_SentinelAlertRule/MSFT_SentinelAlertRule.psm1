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
        $ProductFilter,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.String]
        $Severity,

        [Parameter()]
        [System.String[]]
        $Tactics,

        [Parameter()]
        [System.String[]]
        $Techniques,

        [Parameter()]
        [System.String[]]
        $SubTechniques,

        [Parameter()]
        [System.String]
        $Query,

        [Parameter()]
        [System.String]
        $QueryFrequency,

        [Parameter()]
        [System.String]
        $QueryPeriod,

        [Parameter()]
        [System.String]
        $TriggerOperator,

        [Parameter()]
        [System.UInt32]
        $TriggerThreshold,

        [Parameter()]
        [System.String]
        $SuppressionDuration,

        [Parameter()]
        [System.String]
        $SuppressionEnabled,

        [Parameter()]
        [System.String]
        $AlertRuleTemplateName,

        [Parameter()]
        [System.String[]]
        $DisplayNamesExcludeFilter,

        [Parameter()]
        [System.String[]]
        $DisplayNamesFilter,

        [Parameter()]
        [System.String[]]
        $SeveritiesFilter,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EventGroupingSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomDetails,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EntityMappings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $AlertDetailsOverride,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $IncidentConfiguration,

        [Parameter()]
        [System.String]
        $Kind,

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
        if ([System.String]::IsNullOrEmpty($TenantId) -and -not $null -eq $Credential)
        {
            $TenantId = $Credential.UserName.Split('@')[1]
        }

        if (-not [System.String]::IsNullOrEmpty($Id))
        {
            $instance = Get-M365DSCSentinelAlertRule -SubscriptionId $SubscriptionId `
                                                     -ResourceGroupName $ResourceGroupName `
                                                     -WorkspaceName $WorkspaceName `
                                                     -TenantId $TenantId `
                                                     -Id $Id
        }
        if ($null -eq $instance)
        {
            $instances = Get-M365DSCSentinelAlertRule -SubscriptionId $SubscriptionId `
                                                     -ResourceGroupName $ResourceGroupName `
                                                     -WorkspaceName $WorkspaceName `
                                                     -TenantId $TenantId
            $instance = $instances | Where-Object -FilterScript {$_.properties.displayName -eq $DisplayName}
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        # EventGroupingSettings
        $EventGroupingValueSettingsValue = $null
        if ($null -ne $instance.properties.eventGroupingSettings)
        {
            $EventGroupingValueSettingsValue = @{
                aggregationKind = $instance.properties.eventGroupingSettings.aggregationKind
            }
        }

        # CustomDetails
        $CustomDetailsValue = @()
        if ($null -ne $instance.properties.customDetails)
        {
            $detailAsHash = @{}
            $instance.properties.customDetails.psobject.properties | foreach { $detailAsHash[$_.Name] = $_.Value }
            foreach ($key in $detailAsHash.Keys)
            {
                $CustomDetailsValue += @{
                    DetailKey   = $key
                    DetailValue = $detailAsHash.$key
                }
            }
        }

        #EntityMappings
        $EntityMappingsValue = @()
        if ($null -ne $instance.properties.entityMappings)
        {
            foreach ($mapping in $instance.properties.entityMappings)
            {
                $entity = @{
                    entityType = $mapping.entityType
                    fieldMappings = @()
                }

                foreach ($fieldMapping in $mapping.fieldMappings)
                {
                    $entity.fieldMappings += @{
                        identifier = $fieldMapping.identifier
                        columnName = $fieldMapping.columnName
                    }
                }

                $EntityMappingsValue += $entity
            }
        }

        #AlertDetailsOverride
        if ($null -ne $instance.properties.alertDetailsOverride)
        {
            $info = $instance.properties.alertDetailsOverride
            $AlertDetailsOverrideValue = @{
                alertDisplayNameFormat = $info.alertDisplayNameFormat
                alertDescriptionFormat = $info.alertDescriptionFormat
                alertDynamicProperties = @()
            }

            foreach ($propertyEntry in $info.alertDynamicProperties)
            {
                $AlertDetailsOverrideValue.alertDynamicProperties += @{
                    alertProperty      = $propertyEntry.alertProperty
                    alertPropertyValue = $propertyEntry.value
                }
            }
        }

        #IncidentConfiguration
        if ($null -ne $instance.properties.incidentConfiguration)
        {
            $info = $instance.properties.incidentConfiguration
            $IncidentConfigurationValue = @{
                createIncident = [Boolean]::Parse($info.createIncident.ToString())
                groupingConfiguration = @{
                    enabled              = $info.groupingConfiguration.enabled
                    reopenClosedIncident = $info.groupingConfiguration.reopenClosedIncident
                    lookbackDuration     = $info.groupingConfiguration.lookbackDuration
                    matchingMethod       = $info.groupingConfiguration.matchingMethod
                    groupByEntities      = $info.groupingConfiguration.groupByEntities
                    groupByAlertDetails  = $info.groupingConfiguration.groupByAlertDetails
                    groupByCustomDetails = $info.groupingConfiguration.groupByCustomDetails
                }
            }
        }

        $results = @{
            ProductFilter              = $instance.properties.ProductFilter
            Enabled                    = $instance.properties.Enabled
            Severity                   = $instance.properties.Severity
            Tactics                    = $instance.properties.Tactics
            Techniques                 = $instance.properties.Techniques
            SubTechniques              = $instance.properties.SubTechniques
            Query                      = $instance.properties.Query
            QueryFrequency             = $instance.properties.QueryFrequency
            QueryPeriod                = $instance.properties.QueryPeriod
            TriggerOperator            = $instance.properties.TriggerOperator
            TriggerThreshold           = $instance.properties.TriggerThreshold
            SuppressionDuration        = $instance.properties.SuppressionDuration
            SuppressionEnabled          = $instance.properties.SuppressionEnabled
            AlertRuleTemplateName      = $instance.properties.AlertRuleTemplateName
            DisplayNamesExcludeFilter  = $instance.properties.DisplayNamesExcludeFilter
            DisplayNamesFilter         = $instance.properties.DisplayNamesFilter
            SeveritiesFilter           = $instance.properties.SeveritiesFilter
            DisplayName                = $instance.properties.displayName
            EventGroupingSettings      = $EventGroupingValueSettingsValue
            CustomDetails              = $CustomDetailsValue
            EntityMappings             = $EntityMappingsValue
            AlertDetailsOverride       = $AlertDetailsOverrideValue
            IncidentConfiguration      = $IncidentConfigurationValue
            SubscriptionId             = $SubscriptionId
            ResourceGroupName          = $ResourceGroupName
            WorkspaceName              = $WorkspaceName
            Id                         = $instance.name
            Kind                       = $instance.kind
            Description                = $instance.properties.description
            Ensure                     = 'Present'
            Credential                 = $Credential
            ApplicationId              = $ApplicationId
            TenantId                   = $TenantId
            CertificateThumbprint      = $CertificateThumbprint
            ManagedIdentity            = $ManagedIdentity.IsPresent
            AccessTokens               = $AccessTokens
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
        $ProductFilter,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.String]
        $Severity,

        [Parameter()]
        [System.String[]]
        $Tactics,

        [Parameter()]
        [System.String[]]
        $Techniques,

        [Parameter()]
        [System.String[]]
        $SubTechniques,

        [Parameter()]
        [System.String]
        $Query,

        [Parameter()]
        [System.String]
        $QueryFrequency,

        [Parameter()]
        [System.String]
        $QueryPeriod,

        [Parameter()]
        [System.String]
        $TriggerOperator,

        [Parameter()]
        [System.UInt32]
        $TriggerThreshold,

        [Parameter()]
        [System.String]
        $SuppressionDuration,

        [Parameter()]
        [System.String]
        $SuppressionEnabled,

        [Parameter()]
        [System.String]
        $AlertRuleTemplateName,

        [Parameter()]
        [System.String[]]
        $DisplayNamesExcludeFilter,

        [Parameter()]
        [System.String[]]
        $DisplayNamesFilter,

        [Parameter()]
        [System.String[]]
        $SeveritiesFilter,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EventGroupingSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomDetails,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EntityMappings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $AlertDetailsOverride,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $IncidentConfiguration,

        [Parameter()]
        [System.String]
        $Kind,

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

    if ([System.String]::IsNullOrEmpty($TenantId) -and -not $null -eq $Credential)
    {
        $TenantId = $Credential.UserName.Split('@')[1]
    }

    $instance = @{}
    if ($Kind -eq 'Fusion')
    {
        $instance = @{
            kind = $Kind
            properties = @{
                alertRuleTemplateName = $AlertRuleTemplateName
                enabled               = $Enabled
            }
        }
    }
    elseif ($Kind -eq 'MicrosoftSecurityIncidentCreation')
    {
        $instance = @{
            kind = $Kind
            properties = @{
                displayName               = $DisplayName
                description               = $Description
                productFilter             = $ProductFilter
                displayNamesExcludeFilter = $DisplayNamesExcludeFilter
                displayNamesFilter        = $DisplayNamesFilter
                enabled                   = $Enabled
                severitiesFilter          = $AlertSeverity
            }
        }
    }
    elseif ($Kind -eq 'Scheduled')
    {
        $instance = @{
            kind = $Kind
            properties = @{
                displayName                = $DisplayName
                enabled                    = $Enabled
                description                = $Description
                query                      = $Query
                queryFrequency             = $QueryFrequency
                queryPeriod                = $QueryPeriod
                severity                   = $Severity
                suppressionDuration        = $SuppressionDuration
                suppressionEnabled         = $SuppressionEnabled
                triggerOperator            = $TriggerOperator
                triggerThreshold           = $TriggerThreshold
                eventGroupingSettings      = @{
                    aggregationKind = $EventGroupingSettings.aggregationKind
                }
                customDetails              = @{}
                alertDetailsOverride       = @{
                    alertDisplayNameFormat = $AlertDetailsOverride.alertDisplayNameFormat
                    alertDescriptionFormat = $AlertDetailsOverride.alertDescriptionFormat
                    alertDynamicProperties = @()
                }
                entityMappings             = @()
                incidentConfiguration      = @{
                    createIncident        = $IncidentConfiguration.createIncident
                    groupingConfiguration = @{
                        enabled              = $IncidentConfiguration.groupingConfiguration.enabled
                        reopenClosedIncident = $IncidentConfiguration.groupingConfiguration.reopenClosedIncident
                        lookbackDuration     = $IncidentConfiguration.groupingConfiguration.lookbackDuration
                        matchingMethod       = $IncidentConfiguration.groupingConfiguration.matchingMethod
                        groupByEntities      = $IncidentConfiguration.groupingConfiguration.groupByEntities
                        groupByAlertDetails  = $IncidentConfiguration.groupingConfiguration.groupByAlertDetails
                        groupByCustomDetails = $IncidentConfiguration.groupingConfiguration.groupByCustomDetails
                    }
                }
                productFilter              = $ProductFilter
                displayNamesExcludeFilter  = $DisplayNamesExcludeFilter
                displayNamesFilter         = $DisplayNamesFilter
                severitiesFilter           = $AlertSeverity
            }
        }

        foreach ($entity in $EntityMappings)
        {
            $entry = @{
                entityType = $entity.entityType
                fieldMappings = @()
            }

            foreach ($field in $entity.fieldMappings)
            {
                $entry.fieldMappings += @{
                    identifier = $field.identifier
                    columnName = $field.columnName
                }
            }

            $instance.properties.entityMappings += $entry
        }

        foreach ($detail in $CustomDetails)
        {
            $instance.properties.customDetails.Add($detail.DetailKey, $detail.DetailValue)
        }

        foreach ($dynamicProp in $AlertDetailsOverride.alertDynamicProperties)
        {
            $instance.properties.alertDetailsOverride.alertDynamicProperties += @{
                alertProperty = $dynamicProp.alertProperty
                value         = $dynamicProp.alertPropertyValue
            }
        }
    }
    elseif ($Kind -eq 'NRT')
    {
        $instance = @{
            kind = $Kind
            properties = @{
                displayName                = $DisplayName
                enabled                    = $Enabled
                description                = $Description
                query                      = $Query
                severity                   = $Severity
                suppressionDuration        = $SuppressionDuration
                suppressionEnabled         = $SuppressionEnabled
                eventGroupingSettings      = @{
                    aggregationKind = $EventGroupingSettings.aggregationKind
                }
                alertDetailsOverride       = @{
                    alertDisplayNameFormat = $AlertDetailsOverride.alertDisplayNameFormat
                    alertDescriptionFormat = $AlertDetailsOverride.alertDescriptionFormat
                    alertDynamicProperties = @()
                }
                entityMappings             = @()
                customDetails              = @{}
                incidentConfiguration      = @{
                    createIncident        = $IncidentConfiguration.createIncident
                    groupingConfiguration = @{
                        enabled              = $IncidentConfiguration.groupingConfiguration.enabled
                        reopenClosedIncident = $IncidentConfiguration.groupingConfiguration.reopenClosedIncident
                        lookbackDuration     = $IncidentConfiguration.groupingConfiguration.lookbackDuration
                        matchingMethod       = $IncidentConfiguration.groupingConfiguration.matchingMethod
                        groupByEntities      = $IncidentConfiguration.groupingConfiguration.groupByEntities
                        groupByAlertDetails  = $IncidentConfiguration.groupingConfiguration.groupByAlertDetails
                        groupByCustomDetails = $IncidentConfiguration.groupingConfiguration.groupByCustomDetails
                    }
                }
                techniques                 = $Techniques
                subTechniques              = $SubTechniques
                tactics                    = $Tactics
            }
        }

        if ($null -eq $EntityMappings -or $EntityMappings.Length -eq 0)
        {
            $instance.properties.Remove('entityMappings') | Out-Null
        }
        else
        {
            foreach ($entity in $EntityMappings)
            {
                $entry = @{
                    entityType = $entity.entityType
                    fieldMappings = @()
                }

                foreach ($field in $entity.fieldMappings)
                {
                    $entry.fieldMappings += @{
                        identifier = $field.identifier
                        columnName = $field.columnName
                    }
                }

                $instance.properties.entityMappings += $entry
            }
        }

        foreach ($detail in $CustomDetails)
        {
            $instance.properties.customDetails.Add($detail.DetailKey, $detail.DetailValue)
        }

        foreach ($dynamicProp in $AlertDetailsOverride.alertDynamicProperties)
        {
            $instance.properties.alertDetailsOverride.alertDynamicProperties += @{
                alertProperty = $dynamicProp.alertProperty
                value         = $dynamicProp.alertPropertyValue
            }
        }
    }

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating new Alert Rule {$DisplayName}"
        New-M365DSCSentinelAlertRule -SubscriptionId $SubscriptionId `
                                     -ResourceGroupName $ResourceGroupName `
                                     -WorkspaceName $WorkspaceName `
                                     -TenantId $TenantId `
                                     -Body $instance
    }
    # UPDATE
    elseif($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating Alert Rule {$DisplayName}"
        New-M365DSCSentinelAlertRule -SubscriptionId $SubscriptionId `
                                     -ResourceGroupName $ResourceGroupName `
                                     -WorkspaceName $WorkspaceName `
                                     -TenantId $TenantId `
                                     -Body $instance `
                                     -Id $currentInstance.Id
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing Alert Rule {$DisplayName}"
        Remove-M365DSCSentinelAlertRule -SubscriptionId $SubscriptionId `
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
        $ProductFilter,

        [Parameter()]
        [System.Boolean]
        $Enabled,

        [Parameter()]
        [System.String]
        $Severity,

        [Parameter()]
        [System.String[]]
        $Tactics,

        [Parameter()]
        [System.String[]]
        $Techniques,

        [Parameter()]
        [System.String[]]
        $SubTechniques,

        [Parameter()]
        [System.String]
        $Query,

        [Parameter()]
        [System.String]
        $QueryFrequency,

        [Parameter()]
        [System.String]
        $QueryPeriod,

        [Parameter()]
        [System.String]
        $TriggerOperator,

        [Parameter()]
        [System.UInt32]
        $TriggerThreshold,

        [Parameter()]
        [System.String]
        $SuppressionDuration,

        [Parameter()]
        [System.String]
        $SuppressionEnabled,

        [Parameter()]
        [System.String]
        $AlertRuleTemplateName,

        [Parameter()]
        [System.String[]]
        $DisplayNamesExcludeFilter,

        [Parameter()]
        [System.String[]]
        $DisplayNamesFilter,

        [Parameter()]
        [System.String[]]
        $SeveritiesFilter,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EventGroupingSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomDetails,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $EntityMappings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $AlertDetailsOverride,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $IncidentConfiguration,

        [Parameter()]
        [System.String]
        $Kind,

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
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

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

            $rules = Get-M365DSCSentinelAlertRule -SubscriptionId $subscriptionId `
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

            foreach ($rule in $rules)
            {
                $displayedKey = $rule.properties.DisplayName
                Write-Host "        |---[$j/$($rules.Count)] $displayedKey" -NoNewline
                $params = @{
                    DisplayName           = $rule.properties.displayName
                    Id                    = $rule.name
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

                if ( $null -ne $Results.EventGroupingSettings)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'EventGroupingSettings'
                            CimInstanceName = 'SentinelAlertRuleEventGroupingSettings'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.EventGroupingSettings `
                        -CIMInstanceName 'SentinelAlertRuleEventGroupingSettings' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.EventGroupingSettings = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('EventGroupingSettings') | Out-Null
                    }
                }

                if ($null -ne $Results.CustomDetails)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'CustomDetails'
                            CimInstanceName = 'SentinelAlertRuleCustomDetails'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.CustomDetails `
                        -CIMInstanceName 'SentinelAlertRuleCustomDetails' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.CustomDetails = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('CustomDetails') | Out-Null
                    }
                }

                if ( $null -ne $Results.EntityMappings)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'EntityMappings'
                            CimInstanceName = 'SentinelAlertRuleEntityMapping'
                            IsRequired      = $False
                        },
                        @{
                            Name            = 'fieldMappings'
                            CimInstanceName = 'SentinelAlertRuleEntityMappingFieldMapping'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.EntityMappings `
                        -CIMInstanceName 'SentinelAlertRuleEntityMapping' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.EntityMappings = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('EntityMappings') | Out-Null
                    }
                }

                if ($null -ne $Results.AlertDetailsOverride)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'AlertDetailsOverride'
                            CimInstanceName = 'SentinelAlertRuleAlertDetailsOverride'
                            IsRequired      = $False
                        },
                        @{
                            Name            = 'alertDynamicProperties'
                            CimInstanceName = 'SentinelAlertRuleAlertDetailsOverrideAlertDynamicProperty'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.AlertDetailsOverride `
                        -CIMInstanceName 'SentinelAlertRuleAlertDetailsOverride' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.AlertDetailsOverride = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('AlertDetailsOverride') | Out-Null
                    }
                }

                if ($null -ne $Results.IncidentConfiguration)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'IncidentConfiguration'
                            CimInstanceName = 'SentinelAlertRuleIncidentConfiguration'
                            IsRequired      = $False
                        },
                        @{
                            Name            = 'groupingConfiguration'
                            CimInstanceName = 'SentinelAlertRuleIncidentConfigurationGroupingConfiguration'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'groupByAlertDetails'
                            CimInstanceName = 'SentinelAlertRuleIncidentConfigurationGroupingConfigurationAlertDetail'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.IncidentConfiguration `
                        -CIMInstanceName 'SentinelAlertRuleIncidentConfiguration' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.IncidentConfiguration = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('IncidentConfiguration') | Out-Null
                    }
                }

                $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                    -ConnectionMode $ConnectionMode `
                    -ModulePath $PSScriptRoot `
                    -Results $Results `
                    -Credential $Credential

                if ($Results.EventGroupingSettings)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'EventGroupingSettings' -IsCIMArray:$False
                }
                if ($Results.CustomDetails)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'CustomDetails' -IsCIMArray:$False
                }
                if ($Results.EntityMappings)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'EntityMappings' -IsCIMArray:$True
                }
                if ($Results.AlertDetailsOverride)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'AlertDetailsOverride' -IsCIMArray:$True
                }
                if ($Results.IncidentConfiguration)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'IncidentConfiguration' -IsCIMArray:$True
                }

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

function Get-M365DSCSentinelAlertRule
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
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/alertrules/$($Id)?api-version=2023-12-01-preview"
            $response = Invoke-AzRest -Uri $uri -Method 'GET'
            $result = ConvertFrom-Json $response.Content
            return $result
        }
        else
        {
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/alertrules?api-version=2023-12-01-preview"
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

function New-M365DSCSentinelAlertRule
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
        $Body,

        [Parameter()]
        [System.String]
        $Id
    )

    try
    {
        $hostUrl = Get-M365DSCAPIEndpoint -TenantId $TenantId
        $uri = $hostUrl.AzureManagement + "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/"

        if ($null -eq $Id)
        {
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/alertrules/$((New-GUID).ToString())?api-version=2024-04-01-preview"
        }
        else
        {
            $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/alertrules/$($Id)?api-version=2024-04-01-preview"
        }
        $payload = ConvertTo-Json $Body -Depth 10 -Compress
        Write-Verbose -Message "Creating new rule against URL:`r`n$($uri)`r`nWith payload:`r`n$payload"
        $response = Invoke-AzRest -Uri $uri -Method 'PUT' -Payload $payload
        Write-Verbose -Message $response.Content
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

function Remove-M365DSCSentinelAlertRule
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

        $uri += "providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/providers/Microsoft.SecurityInsights/alertRules/$($Id)?api-version=2024-04-01-preview"
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
