function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String]
        $DescriptionForAdmins,

        [Parameter()]
        [System.String]
        $DescriptionForReviewers,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScopeValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SettingsValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $StageSettings,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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

    try
    {
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

        $nullResult = $PSBoundParameters
        $nullResult.Ensure = 'Absent'

        $getValue = $null
        #region resource generator code
        $getValue = Get-MgBetaIdentityGovernanceAccessReviewDefinition -AccessReviewScheduleDefinitionId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Access Review Definition with Id {$Id}"

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaIdentityGovernanceAccessReviewDefinition `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue | Where-Object `
                    -FilterScript {
                        $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.AccessReviewScheduleDefinition"
                    }
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Access Review Definition with DisplayName {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Access Review Definition with Id {$Id} and DisplayName {$DisplayName} was found"

        #region resource generator code
        $complexScope = @{}
        $complexScope.Add('Query', $getValue.Scope.AdditionalProperties.query)
        $complexScope.Add('QueryRoot', $getValue.Scope.AdditionalProperties.queryRoot)
        $complexScope.Add('QueryType', $getValue.Scope.AdditionalProperties.queryType)

        $complexPrincipalScopes = @()
        foreach ($currentPrincipalScopes in $getValue.Scope.AdditionalProperties.principalScopes)
        {
            $myPrincipalScopes = @{}
            $myPrincipalScopes.Add('Query', $currentPrincipalScopes.query)
            $myPrincipalScopes.Add('QueryRoot', $currentPrincipalScopes.queryRoot)
            $myPrincipalScopes.Add('QueryType', $currentPrincipalScopes.queryType)
            if ($null -ne $currentPrincipalScopes.'@odata.type')
            {
                $myPrincipalScopes.Add('odataType', $currentPrincipalScopes.'@odata.type'.ToString())
            }
            if ($myPrincipalScopes.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexPrincipalScopes += $myPrincipalScopes
            }
        }
        $complexScope.Add('PrincipalScopes',$complexPrincipalScopes)
        $complexResourceScopes = @()
        foreach ($currentResourceScopes in $getValue.Scope.AdditionalProperties.resourceScopes)
        {
            $myResourceScopes = @{}
            $myResourceScopes.Add('Query', $currentResourceScopes.query)
            $myResourceScopes.Add('QueryRoot', $currentResourceScopes.queryRoot)
            $myResourceScopes.Add('QueryType', $currentResourceScopes.queryType)
            if ($null -ne $currentResourceScopes.'@odata.type')
            {
                $myResourceScopes.Add('odataType', $currentResourceScopes.'@odata.type'.ToString())
            }
            if ($myResourceScopes.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexResourceScopes += $myResourceScopes
            }
        }
        $complexScope.Add('ResourceScopes',$complexResourceScopes)


        if ($null -ne $getValue.Scope.AdditionalProperties.'@odata.type')
        {
            $complexScope.Add('odataType', $getValue.Scope.AdditionalProperties.'@odata.type'.ToString())
        }
        if ($complexScope.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexScope = $null
        }

        $complexSettings = @{}
        $complexApplyActions = @()
        foreach ($currentApplyActions in $getValue.Settings.applyActions)
        {
            $myApplyActions = @{}
            if ($null -ne $currentApplyActions.AdditionalProperties.'@odata.type')
            {
                $myApplyActions.Add('odataType', $currentApplyActions.AdditionalProperties.'@odata.type'.ToString())
            }
            if ($myApplyActions.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexApplyActions += $myApplyActions
            }
        }
        $complexSettings.Add('ApplyActions',$complexApplyActions)
        $complexSettings.Add('AutoApplyDecisionsEnabled', $getValue.Settings.autoApplyDecisionsEnabled)
        $complexSettings.Add('DecisionHistoriesForReviewersEnabled', $getValue.Settings.decisionHistoriesForReviewersEnabled)
        $complexSettings.Add('DefaultDecision', $getValue.Settings.defaultDecision)
        $complexSettings.Add('DefaultDecisionEnabled', $getValue.Settings.defaultDecisionEnabled)
        $complexSettings.Add('InstanceDurationInDays', $getValue.Settings.instanceDurationInDays)
        $complexSettings.Add('JustificationRequiredOnApproval', $getValue.Settings.justificationRequiredOnApproval)
        $complexSettings.Add('MailNotificationsEnabled', $getValue.Settings.mailNotificationsEnabled)
        $complexRecommendationInsightSettings = @()
        foreach ($currentRecommendationInsightSettings in $getValue.Settings.recommendationInsightSettings)
        {
            $myRecommendationInsightSettings = @{}
            $myRecommendationInsightSettings.Add('RecommendationLookBackDuration', $currentRecommendationInsightSettings.AdditionalProperties.recommendationLookBackDuration)
            if ($null -ne $currentRecommendationInsightSettings.AdditionalProperties.signInScope)
            {
                $myRecommendationInsightSettings.Add('SignInScope', $currentRecommendationInsightSettings.AdditionalProperties.signInScope.ToString())
            }
            if ($null -ne $currentRecommendationInsightSettings.AdditionalProperties.'@odata.type')
            {
                $myRecommendationInsightSettings.Add('odataType', $currentRecommendationInsightSettings.AdditionalProperties.'@odata.type'.ToString())
            }
            if ($myRecommendationInsightSettings.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexRecommendationInsightSettings += $myRecommendationInsightSettings
            }
        }
        $complexSettings.Add('RecommendationInsightSettings',$complexRecommendationInsightSettings)

        if ($null -ne $getValue.Settings.recommendationLookBackDuration)
        {
            $complexSettings.Add('RecommendationLookBackDuration', $getValue.Settings.recommendationLookBackDuration.ToString())
        }
        $complexSettings.Add('RecommendationsEnabled', $getValue.Settings.recommendationsEnabled)
        $complexRecurrence = @{}
        $complexPattern = @{}
        $complexPattern.Add('DayOfMonth', $getValue.settings.recurrence.pattern.dayOfMonth)
        if ($null -ne $getValue.settings.recurrence.pattern.daysOfWeek)
        {
            $complexPattern.Add('DaysOfWeek', $getValue.settings.recurrence.pattern.daysOfWeek)
        }
        if ($null -ne $getValue.settings.recurrence.pattern.firstDayOfWeek)
        {
            $complexFirstDaysOfWeek = [String]::Join(", ", $getValue.settings.recurrence.pattern.firstDayOfWeek)
            $complexPattern.Add('FirstDayOfWeek',$complexFirstDaysOfWeek)
        }
        if ($null -ne $getValue.settings.recurrence.pattern.index)
        {
            $complexPattern.Add('Index', $getValue.settings.recurrence.pattern.index.ToString())
        }
        $complexPattern.Add('Interval', $getValue.settings.recurrence.pattern.interval)
        $complexPattern.Add('Month', $getValue.settings.recurrence.pattern.month)
        if ($null -ne $getValue.settings.recurrence.pattern.type)
        {
            $complexPattern.Add('Type', $getValue.settings.recurrence.pattern.type.ToString())
        }
        if ($complexPattern.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexPattern = $null
        }
        $complexRecurrence.Add('Pattern',$complexPattern)
        $complexRange = @{}
        if ($null -ne $getValue.settings.recurrence.range.endDate)
        {
            $complexRange.Add('EndDate', ([DateTime]$getValue.settings.recurrence.range.endDate).ToString(''))
        }
        $complexRange.Add('NumberOfOccurrences', $getValue.settings.recurrence.range.numberOfOccurrences)
        $complexRange.Add('RecurrenceTimeZone', $getValue.settings.recurrence.range.recurrenceTimeZone)
        if ($null -ne $getValue.settings.recurrence.range.startDate)
        {
            $complexRange.Add('StartDate', ([DateTime]$getValue.settings.recurrence.range.startDate).ToString(''))
        }
        if ($null -ne $getValue.settings.recurrence.range.type)
        {
            $complexRange.Add('Type', $getValue.settings.recurrence.range.type.ToString())
        }
        if ($complexRange.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexRange = $null
        }
        $complexRecurrence.Add('Range',$complexRange)
        if ($complexRecurrence.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexRecurrence = $null
        }
        $complexSettings.Add('Recurrence',$complexRecurrence)
        $complexSettings.Add('ReminderNotificationsEnabled', $getValue.Settings.reminderNotificationsEnabled)
        if ($complexSettings.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexSettings = $null
        }

        $complexStageSettings = @()
        foreach ($currentStageSettings in $getValue.stageSettings)
        {
            $myStageSettings = @{}
            $myStageSettings.Add('DecisionsThatWillMoveToNextStage', $currentStageSettings.decisionsThatWillMoveToNextStage)
            $myStageSettings.Add('DependsOnValue', $currentStageSettings.dependsOn)
            $myStageSettings.Add('DurationInDays', $currentStageSettings.durationInDays)
            $complexRecommendationInsightSettings = @()
            foreach ($currentRecommendationInsightSettings in $currentStageSettings.recommendationInsightSettings)
            {
                $myRecommendationInsightSettings = @{}

                if ($null -ne $currentRecommendationInsightSettings.recommendationLookBackDuration)
                {

                    $myRecommendationInsightSettings.Add('RecommendationLookBackDuration', $currentRecommendationInsightSettings.recommendationLookBackDuration.ToString())
                }
                if ($null -ne $currentRecommendationInsightSettings.signInScope)
                {
                    $myRecommendationInsightSettings.Add('SignInScope', $currentRecommendationInsightSettings.signInScope.ToString())
                }
                if ($null -ne $currentRecommendationInsightSettings.'@odata.type')
                {
                    $myRecommendationInsightSettings.Add('odataType', $currentRecommendationInsightSettings.'@odata.type'.ToString())
                }
                if ($myRecommendationInsightSettings.values.Where({$null -ne $_}).Count -gt 0)
                {
                    $complexRecommendationInsightSettings += $myRecommendationInsightSettings
                }
            }
            $myStageSettings.Add('RecommendationInsightSettings',$complexRecommendationInsightSettings)
            $myStageSettings.Add('RecommendationLookBackDuration', $currentStageSettings.recommendationLookBackDuration)
            $myStageSettings.Add('RecommendationsEnabled', $currentStageSettings.recommendationsEnabled)
            $myStageSettings.Add('StageId', $currentStageSettings.stageId)
            if ($myStageSettings.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexStageSettings += $myStageSettings
            }
        }
        #endregion

        $results = @{
            DescriptionForAdmins             = $getValue.DescriptionForAdmins
            DescriptionForReviewers          = $getValue.DescriptionForReviewers
            DisplayName                      = $getValue.DisplayName
            ScopeValue                       = $complexScope
            SettingsValue                    = $complexSettings
            StageSettings                    = $complexStageSettings
            Id                               = $getValue.Id
            Ensure                           = 'Present'
            Credential                       = $Credential
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            ApplicationSecret                = $ApplicationSecret
            CertificateThumbprint            = $CertificateThumbprint
            ManagedIdentity                  = $ManagedIdentity.IsPresent
        }

        return [System.Collections.Hashtable] $results
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
        [Parameter()]
        [System.String]
        $DescriptionForAdmins,

        [Parameter()]
        [System.String]
        $DescriptionForReviewers,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScopeValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SettingsValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $StageSettings,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if($StageSettings -ne $null)
    {
        Write-Verbose -Message "StageSettings cannot be updated after creation of access review definition."

        if($currentInstance.Ensure -ne 'Absent') {
            Write-Verbose -Message "Removing the Azure AD Access Review Definition with Id {$($currentInstance.Id)}"
            Remove-MgBetaIdentityGovernanceAccessReviewDefinition -AccessReviewScheduleDefinitionId $currentInstance.Id
        }

        Write-Verbose -Message "Creating an Azure AD Access Review Definition with DisplayName {$DisplayName}"

        $createParameters = ([Hashtable]$BoundParameters).Clone()

        $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters
        $createParameters.Remove('Id') | Out-Null

        $createParameters.Add('Scope', $createParameters.ScopeValue)
        $createParameters.Remove('ScopeValue') | Out-Null

        $createParameters.Add('Settings', $createParameters.SettingsValue)
        $createParameters.Remove('SettingsValue') | Out-Null

        foreach ($hashtable in $createParameters.StageSettings) {
            $propertyToRemove = 'DependsOnValue'
            $newProperty = 'DependsOn'
            if ($hashtable.ContainsKey($propertyToRemove)) {
                $value = $hashtable[$propertyToRemove]
                $hashtable[$newProperty] = $value
                $hashtable.Remove($propertyToRemove)
            }
        }

        foreach ($hashtable in $createParameters.StageSettings) {
            $keys = (([Hashtable]$hashtable).Clone()).Keys
            foreach ($key in $keys)
            {
                $value = $hashtable.$key
                $hashtable.Remove($key)
                $hashtable.Add($key.Substring(0,1).ToLower() + $key.Substring(1), $value)
            }
        }

        foreach ($hashtable in $createParameters.StageSettings) {
            Write-Verbose -Message "Priting Values: $(Convert-M365DscHashtableToString -Hashtable $hashtable)"
        }

        $keys = (([Hashtable]$createParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $createParameters.$key -and $createParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $createParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $createParameters.$key
            }
        }
        $createParameters.Add("@odata.type", "#microsoft.graph.AccessReviewScheduleDefinition")
        $policy = New-MgBetaIdentityGovernanceAccessReviewDefinition -BodyParameter $createParameters
        return;
    }

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Azure AD Access Review Definition with DisplayName {$DisplayName}"

        $createParameters = ([Hashtable]$BoundParameters).Clone()

        $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters

        $createParameters.Remove('Id') | Out-Null

        $createParameters.Add('Scope', $createParameters.ScopeValue)
        $createParameters.Remove('ScopeValue') | Out-Null

        $createParameters.Add('Settings', $createParameters.SettingsValue)
        $createParameters.Remove('SettingsValue') | Out-Null

        foreach ($hashtable in $createParameters.StageSettings) {
            $propertyToRemove = 'DependsOnValue'
            $newProperty = 'DependsOn'
            if ($hashtable.ContainsKey($propertyToRemove)) {
                $value = $hashtable[$propertyToRemove]
                $hashtable[$newProperty] = $value
                $hashtable.Remove($propertyToRemove)
            }
        }

        foreach ($hashtable in $createParameters.StageSettings) {
            $keys = (([Hashtable]$hashtable).Clone()).Keys
            foreach ($key in $keys)
            {
                $value = $hashtable.$key
                $hashtable.Remove($key)
                $hashtable.Add($key.Substring(0,1).ToLower() + $key.Substring(1), $value)
            }
        }

        foreach ($hashtable in $createParameters.StageSettings) {
            Write-Verbose -Message "Priting Values: $(Convert-M365DscHashtableToString -Hashtable $hashtable)"
        }

        $keys = (([Hashtable]$createParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $createParameters.$key -and $createParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $createParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $createParameters.$key
            }
        }
        #region resource generator code
        $createParameters.Add("@odata.type", "#microsoft.graph.AccessReviewScheduleDefinition")
        $policy = New-MgBetaIdentityGovernanceAccessReviewDefinition -BodyParameter $createParameters
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Access Review Definition with Id {$($currentInstance.Id)}"

        $updateParameters = ([Hashtable]$BoundParameters).Clone()
        $updateParameters = Rename-M365DSCCimInstanceParameter -Properties $updateParameters

        $updateParameters.Remove('Id') | Out-Null

        $updateParameters.Add('Scope', $updateParameters.ScopeValue)
        $updateParameters.Remove('ScopeValue') | Out-Null

        $updateParameters.Add('Settings', $updateParameters.SettingsValue)
        $updateParameters.Remove('SettingsValue') | Out-Null


        $keys = (([Hashtable]$updateParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $pdateParameters.$key -and $updateParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $updateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $updateParameters.AccessReviewScheduleDefinitionId
            }
        }

        #region resource generator code
        $UpdateParameters.Add("@odata.type", "#microsoft.graph.AccessReviewScheduleDefinition")
        Set-MgBetaIdentityGovernanceAccessReviewDefinition `
            -AccessReviewScheduleDefinitionId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Azure AD Access Review Definition with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaIdentityGovernanceAccessReviewDefinition -AccessReviewScheduleDefinitionId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        [System.String]
        $DescriptionForAdmins,

        [Parameter()]
        [System.String]
        $DescriptionForReviewers,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ScopeValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SettingsValue,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $StageSettings,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
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

    Write-Verbose -Message "Testing configuration of the Azure AD Access Review Definition with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

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

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

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
        [System.String]
        $Filter,

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
        #region resource generator code
        [array]$getValue = Get-MgBetaIdentityGovernanceAccessReviewDefinition `
            -Filter $Filter `
            -All `
            -ErrorAction Stop
        #endregion

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            elseif (-not [string]::IsNullOrEmpty($config.name))
            {
                $displayedKey = $config.name
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                DisplayName           =  $config.DisplayName
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity = $ManagedIdentity.IsPresent
                AccessTokens = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($null -ne $Results.ScopeValue)
            {
                $complexMapping = @(
                    @{
                        Name = 'ScopeValue'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'PrincipalScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ResourceScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ScopeValue `
                    -CIMInstanceName 'MicrosoftGraphaccessReviewScope' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ScopeValue = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ScopeValue') | Out-Null
                }
            }
            if ($null -ne $Results.SettingsValue)
            {
                $complexMapping = @(
                    @{
                        Name = 'SettingsValue'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScheduleSettings'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ApplyActions'
                        CimInstanceName = 'MicrosoftGraphAccessReviewApplyAction'
                        IsRequired = $False
                    }
                    @{
                        Name = 'RecommendationInsightSettings'
                        CimInstanceName = 'MicrosoftGraphAccessReviewRecommendationInsightSetting'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Recurrence'
                        CimInstanceName = 'MicrosoftGraphPatternedRecurrence'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Pattern'
                        CimInstanceName = 'MicrosoftGraphRecurrencePattern'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Range'
                        CimInstanceName = 'MicrosoftGraphRecurrenceRange'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.SettingsValue `
                    -CIMInstanceName 'MicrosoftGraphaccessReviewScheduleSettings' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.SettingsValue = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('SettingsValue') | Out-Null
                }
            }
            if ($null -ne $Results.StageSettings)
            {
                $complexMapping = @(
                    @{
                        Name = 'StageSettings'
                        CimInstanceName = 'MicrosoftGraphAccessReviewStageSettings'
                        IsRequired = $False
                    }
                    @{
                        Name = 'PrincipalScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ResourceScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'RecommendationInsightSettings'
                        CimInstanceName = 'MicrosoftGraphAccessReviewRecommendationInsightSetting'
                        IsRequired = $False
                    }
                    @{
                        Name = 'PrincipalScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ResourceScopes'
                        CimInstanceName = 'MicrosoftGraphAccessReviewScope'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.StageSettings `
                    -CIMInstanceName 'MicrosoftGraphaccessReviewStageSettings' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.StageSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('StageSettings') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.ScopeValue)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ScopeValue" -IsCIMArray:$False
            }
            if ($Results.SettingsValue)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "SettingsValue" -IsCIMArray:$False
            }
            if ($Results.StageSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "StageSettings" -IsCIMArray:$True
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

Export-ModuleMember -Function *-TargetResource
