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
        $Description,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $IsSchedulingEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Tasks,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExecutionConditions,

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
    $nullResult.Ensure = 'Absent'
    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.DisplayName -eq $DisplayName}
        }
        else
        {
            $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -Filter "DisplayName eq '$DisplayName'"
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -WorkflowId $instance.Id
        if($null -ne $instance) {
            $executionConditionsResults = Get-M365DSCIdentityGovernanceWorkflowExecutionConditions -WorkflowId $instance.Id
            $taskResults = Get-M365DSCIdentityGovernanceTasks -WorkflowId $instance.Id
        }

        $results = @{
            DisplayName              = $DisplayName;
            Description              = $instance.Description;
            Category                 = $instance.Category;
            IsEnabled                = $instance.IsEnabled;
            IsSchedulingEnabled      = $instance.IsSchedulingEnabled;
            Tasks                    = [Array]$taskResults
            ExecutionConditions      = $executionConditionsResults
            Ensure                   = 'Present'
            Credential               = $Credential
            ApplicationId            = $ApplicationId
            TenantId                 = $TenantId
            ApplicationSecret        = $ApplicationSecret
            CertificateThumbprint    = $CertificateThumbprint
            ManagedIdentity          = $ManagedIdentity.IsPresent
            AccessTokens             = $AccessTokens
        }
        return [System.Collections.Hashtable] $results
    }
    catch
    {
        Write-Host -Message $_
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
        $Description,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $IsSchedulingEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Tasks,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExecutionConditions,

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

    $setParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($null -ne $ExecutionConditions){
        $executionConditionsResult = @{
            Scope = @{
                Rule = $ExecutionConditions.ScopeValue.Rule
                "@odata.type" = $ExecutionConditions.ScopeValue.ODataType
            }
            Trigger = @{
                OffsetInDays = $ExecutionConditions.TriggerValue.OffsetInDays
                TimeBasedAttribute = $ExecutionConditions.TriggerValue.TimeBasedAttribute
                "@odata.type" = $ExecutionConditions.TriggerValue.ODataType
            }
            "@odata.type" = $ExecutionConditions.ODataType
        }

        $setParameters.Remove('ExecutionConditions')
        $setParameters.Add('executionConditions', $executionConditionsResult)
    }

    if ($null -ne $Tasks) {
        $taskList = @()

        # Loop through each task and create a hashtable
        foreach ($task in $Tasks) {
            [Array]$argumentsArray = @()

            if ($task.Arguments) {
                foreach ($arg in $task.Arguments) {
                    # Create a hashtable for each argument
                    $argumentsArray += @{
                        Name  = $arg.Name.ToString()
                        Value = $arg.Value.ToString()
                    }
                }
            }
            $taskHashtable = @{
                DisplayName       = $task.DisplayName.ToString()
                Description       = $task.Description.ToString()
                Category          = $task.Category.ToString()
                IsEnabled         = $task.IsEnabled
                ExecutionSequence = $task.ExecutionSequence
                ContinueOnError   = $task.ContinueOnError
                TaskDefinitionId  = $task.TaskDefinitionId

                # If Arguments exist, populate the hashtable
                Arguments = [Array]$argumentsArray
            }

            # Add the task hashtable to the task list
            $taskList += $taskHashtable
        }

        $setParameters.Remove('Tasks')
        $setParameters.Add('Tasks', $taskList)
    }

    $UpdateParameters = ([Hashtable]$setParameters).clone()

    $newParams = @{}
    $newParams.Add('workflow', $UpdateParameters)

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        New-MgBetaIdentityGovernanceLifecycleWorkflow @SetParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -Filter "DisplayName eq '$DisplayName'"
        $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -WorkflowId $instance.Id

        New-MgBetaIdentityGovernanceLifecycleWorkflowNewVersion -WorkflowId $instance.Id -BodyParameter $newParams -ErrorAction Stop

        # the below implementation of Update cmdlet can't be used for updating parameters other than basic parameters like display name,
        # description, isEnabled, isSchedulingEnabled. Hence using the new version cmdlet for exhaustive update scenarios.
        # Update-MgBetaIdentityGovernanceLifecycleWorkflow @setParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -Filter "DisplayName eq '$DisplayName'"
        Remove-MgBetaIdentityGovernanceLifecycleWorkflow -WorkflowId $instance.Id
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
        $Description,

        [Parameter()]
        [System.String]
        $Category,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $IsSchedulingEnabled,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Tasks,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExecutionConditions,

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
        [array] $Script:exportedInstances = Get-MgBetaIdentityGovernanceLifecycleWorkflow -ErrorAction Stop

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

            $displayedKey = $config.DisplayName
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                DisplayName           = $config.DisplayName
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($null -ne $Results.Tasks)
            {
                $Results.Tasks = Get-M365DSCIdentityGovernanceTasksAsString $Results.Tasks
            }

            if ($null -ne $Results.ExecutionConditions)
            {
                $Results.ExecutionConditions = Get-M365DSCIdentityGovernanceWorkflowExecutionConditionsAsString $Results.ExecutionConditions
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($null -ne $Results.Tasks)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                    -ParameterName 'Tasks'
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                    -ParameterName 'ExecutionConditions'
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

function Get-M365DSCIdentityGovernanceTasks
{
    [CmdletBinding()]
    [OutputType([Array])]
    param(
        [Parameter(Mandatory = $true)]
        $WorkflowId
    )


    # Get the tasks from the specified workflow
    $tasks = Get-MgBetaIdentityGovernanceLifecycleWorkflowTask -WorkflowId $WorkflowId

    # Initialize an array to hold the hashtables
    $taskList = @()

    if($null -eq $tasks)
    {
        return $taskList
    }

    # Loop through each task and create a hashtable
    foreach ($task in $tasks) {
        [Array]$argumentsArray = @()

        if ($task.Arguments) {
            foreach ($arg in $task.Arguments) {
                # Create a hashtable for each argument
                $argumentsArray += @{
                    Name  = $arg.Name.ToString()
                    Value = $arg.Value.ToString()
                }
            }
        }
        $taskHashtable = @{
            DisplayName       = $task.DisplayName.ToString()
            Description       = $task.Description.ToString()
            Category          = $task.Category.ToString()
            IsEnabled         = $task.IsEnabled
            ExecutionSequence = $task.ExecutionSequence
            ContinueOnError   = $task.ContinueOnError
            TaskDefinitionId  = $task.TaskDefinitionId

            # If Arguments exist, populate the hashtable
            Arguments = [Array]$argumentsArray
        }

        # Add the task hashtable to the task list
        $taskList += $taskHashtable
    }

    return $taskList
}

function Get-M365DSCIdentityGovernanceTasksAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $Tasks
    )

    $StringContent = [System.Text.StringBuilder]::new()
    $StringContent.Append('@(') | Out-Null

    foreach ($task in $Tasks)
    {
        $StringContent.Append("`n                MSFT_AADIdentityGovernanceTask {`r`n") | Out-Null
        $StringContent.Append("                    DisplayName       = '" + $task.DisplayName + "'`r`n") | Out-Null
        $StringContent.Append("                    Description       = '" + $task.Description.replace("'","''") + "'`r`n") | Out-Null
        $StringContent.Append("                    Category          = '" + $task.Category + "'`r`n") | Out-Null
        $StringContent.Append("                    IsEnabled         = $" + $task.IsEnabled + "`r`n") | Out-Null
        $StringContent.Append("                    ExecutionSequence = " + $task.ExecutionSequence + "`r`n") | Out-Null
        $StringContent.Append("                    ContinueOnError   = $" + $task.ContinueOnError + "`r`n") | Out-Null
        $StringContent.Append("                    TaskDefinitionId   = '" + $task.TaskDefinitionId + "'`r`n") | Out-Null

        if ($task.Arguments.Length -gt 0)
        {
            $StringContent.Append("                    Arguments         = @(`r`n") | Out-Null
            foreach ($argument in $task.Arguments)
            {
                $StringContent.Append("                        MSFT_AADIdentityGovernanceTaskArguments {`r`n") | Out-Null
                $StringContent.Append("                            Name  = '" + $argument.Name + "'`r`n") | Out-Null
                $StringContent.Append("                            Value = '" + $argument.Value + "'`r`n") | Out-Null
                $StringContent.Append("                        }`r`n") | Out-Null
            }
            $StringContent.Append("                    )`r`n") | Out-Null
        }
        else
        {
            $StringContent.Append("                    Arguments         = @()`r`n") | Out-Null
        }

        $StringContent.Append("                }`r`n") | Out-Null
    }

    $StringContent.Append('            )') | Out-Null
    return $StringContent.ToString()
}

function Get-M365DSCIdentityGovernanceWorkflowExecutionConditions
{
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param(
        [Parameter(Mandatory = $true)]
        $WorkflowId
    )

    $instance = Get-MgBetaIdentityGovernanceLifecycleWorkflow -WorkflowId $WorkflowId
    $executionConditionsResult = @{}

    if($null -ne $instance -and $null -ne $instance.ExecutionConditions){
        $executionConditions = $instance.ExecutionConditions.AdditionalProperties
        $executionConditionsResult = @{
            ScopeValue = @{
                Rule = $ExecutionConditions['scope']['rule']
                OdataType = $ExecutionConditions['scope']['@odata.type']
            }
            TriggerValue = @{
                OffsetInDays = $ExecutionConditions['trigger']['offsetInDays']
                TimeBasedAttribute = $ExecutionConditions['trigger']['timeBasedAttribute']
                ODataType = $ExecutionConditions['trigger']['@odata.type']
            }
            OdataType = $ExecutionConditions['@odata.type']
        }
    }

    return $executionConditionsResult
}

function Get-M365DSCIdentityGovernanceWorkflowExecutionConditionsAsString {
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = $true)]
        [hashtable] $ExecutionConditions
    )

    $StringContent = [System.Text.StringBuilder]::new()

    # Start of execution conditions
    $StringContent.Append("MSFT_IdentityGovernanceWorkflowExecutionConditions {`r`n") | Out-Null

    # Scope section
    if ($null -ne $ExecutionConditions.ScopeValue) {
        $StringContent.Append("                ScopeValue = MSFT_IdentityGovernanceScope {`r`n") | Out-Null
        $StringContent.Append("                    Rule = '" + $ExecutionConditions.ScopeValue.Rule.replace("'","''") + "'`r`n") | Out-Null
        $StringContent.Append("                    ODataType = '" + $ExecutionConditions.ScopeValue.ODataType + "'`r`n") | Out-Null
        $StringContent.Append("                }`r`n") | Out-Null
    }

    # Trigger section
    if ($null -ne $ExecutionConditions.TriggerValue) {
        $StringContent.Append("                TriggerValue = MSFT_IdentityGovernanceTrigger {`r`n") | Out-Null
        $StringContent.Append("                    OffsetInDays = " + $ExecutionConditions.TriggerValue.OffsetInDays + "`r`n") | Out-Null
        $StringContent.Append("                    TimeBasedAttribute = '" + $ExecutionConditions.TriggerValue.TimeBasedAttribute + "'`r`n") | Out-Null
        $StringContent.Append("                    ODataType = '" + $ExecutionConditions.TriggerValue.OdataType + "'`r`n") | Out-Null
        $StringContent.Append("                }`r`n") | Out-Null
    }

    # OdataType for executionConditions
    if ($null -ne $ExecutionConditions.ODataType) {
        $StringContent.Append("                ODataType = '" + $ExecutionConditions.ODataType + "'`r`n") | Out-Null
    }

    # End of execution conditions
    $StringContent.Append("            }") | Out-Null

    return $StringContent.ToString()
}

Export-ModuleMember -Function *-TargetResource
