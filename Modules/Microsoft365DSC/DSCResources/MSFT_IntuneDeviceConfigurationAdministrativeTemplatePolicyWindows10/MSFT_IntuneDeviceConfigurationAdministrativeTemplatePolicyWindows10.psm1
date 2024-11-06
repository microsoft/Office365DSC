function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('unknown', 'custom', 'builtIn', 'mixed', 'unknownFutureValue')]
        [System.String]
        $PolicyConfigurationIngestionType,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DefinitionValues,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion

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
        $getValue = Get-MgBetaDeviceManagementGroupPolicyConfiguration -GroupPolicyConfigurationId $Id -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Configuration Administrative Template Policy for Windows10 with Id {$Id}"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementGroupPolicyConfiguration `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue
                if ($null -eq $getValue)
                {
                    Write-Verbose -Message "Could not find an Intune Device Configuration Administrative Template Policy for Windows10 with DisplayName {$DisplayName}"
                    return $nullResult
                }
                if(([array]$getValue).count -gt 1)
                {
                    throw "A policy with a duplicated displayName {'$DisplayName'} was found - Ensure displayName is unique"
                }
            }
        }
        #endregion

        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Device Configuration Administrative Template Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName} was found."

        #region resource generator code
        $enumPolicyConfigurationIngestionType = $null
        if ($null -ne $getValue.PolicyConfigurationIngestionType)
        {
            $enumPolicyConfigurationIngestionType = $getValue.PolicyConfigurationIngestionType.ToString()
        }
        #endregion

        #region
        $settings = Get-MgBetaDeviceManagementGroupPolicyConfigurationDefinitionValue `
            -GroupPolicyConfigurationId $Id

        $complexDefinitionValues = @()
        foreach ($setting in $settings)
        {
            $definitionValue = @{}
            $definitionValue.Add('Id', $setting.Id)
            if ($null -ne $setting.ConfigurationType)
            {
                $definitionValue.Add('ConfigurationType', $setting.ConfigurationType.toString())
            }
            $definitionValue.Add('Enabled', $setting.Enabled)
            $definition = Get-MgBetaDeviceManagementGroupPolicyConfigurationDefinitionValueDefinition `
                -GroupPolicyConfigurationId $Id `
                -GroupPolicyDefinitionValueId $setting.Id

            $enumClassType = $null
            if ($null -ne $definition.ClassType)
            {
                $enumClassType = $definition.ClassType.ToString()
            }

            $enumPolicyType = $null
            if ($null -ne $definition.PolicyType)
            {
                $enumPolicyType = $definition.PolicyType.ToString()
            }
            $complexDefinition = @{
                CategoryPath = $definition.CategoryPath
                ClassType    = $enumClassType
                DisplayName  = $definition.DisplayName
                PolicyType   = $enumPolicyType
                SupportedOn  = $definition.SupportedOn
                Id           = $definition.Id
            }

            $definitionValue.Add('Definition', $complexDefinition)

            $presentationValues = Get-MgBetaDeviceManagementGroupPolicyConfigurationDefinitionValuePresentationValue `
                -GroupPolicyConfigurationId $Id `
                -GroupPolicyDefinitionValueId $setting.Id `
                -ExpandProperty 'presentation'

            $complexPresentationValues = @()
            foreach ($presentationValue in $presentationValues)
            {
                $complexPresentationValue = @{}
                $complexPresentationValue.Add('odataType', $presentationValue.AdditionalProperties.'@odata.type')
                $complexPresentationValue.Add('Id', $presentationValue.Id)
                $complexPresentationValue.Add('presentationDefinitionId', $presentationValue.Presentation.Id)
                $complexPresentationValue.Add('presentationDefinitionLabel', $presentationValue.Presentation.Label)
                switch -Wildcard ($presentationValue.AdditionalProperties.'@odata.type')
                {
                    '*.groupPolicyPresentationValueBoolean'
                    {
                        $complexPresentationValue.Add('BooleanValue', $presentationValue.AdditionalProperties.value)
                    }
                    '*.groupPolicyPresentationValue*Decimal'
                    {
                        $complexPresentationValue.Add('DecimalValue', $presentationValue.AdditionalProperties.value)
                    }
                    '*.groupPolicyPresentationValueList'
                    {
                        $complexKeyValuePairValues = @()
                        foreach ($value in $presentationValue.AdditionalProperties.values)
                        {
                            $complexKeyValuePairValues += @{
                                Name  = $(if ($null -ne $value.name)
                                    {
                                        $value.name.replace('"', '')
                                    })
                                Value = $(if ($null -ne $value.value)
                                    {
                                        $value.value.replace('"', '')
                                    })
                            }
                        }
                        $complexPresentationValue.Add('KeyValuePairValues', $complexKeyValuePairValues)
                    }
                    '*.groupPolicyPresentationValueMultiText'
                    {
                        $complexPresentationValue.Add('StringValues', $presentationValue.AdditionalProperties.values)
                    }
                    '*.groupPolicyPresentationValueText'
                    {
                        $complexPresentationValue.Add('StringValue', $presentationValue.AdditionalProperties.value)
                    }
                }
                $complexPresentationValues += $complexPresentationValue
            }

            $definitionValue.Add('PresentationValues', $complexPresentationValues)
            $complexDefinitionValues += $definitionValue
        }
        #endregion

        $results = @{
            #region resource generator code
            Description           = $getValue.Description
            DisplayName           = $getValue.DisplayName
            #PolicyConfigurationIngestionType = $enumPolicyConfigurationIngestionType
            DefinitionValues      = $complexDefinitionValues
            Id                    = $getValue.Id
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
            Managedidentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
            #endregion
        }
        $returnAssignments = @()
        $graphAssignments = Get-MgBetaDeviceManagementGroupPolicyConfigurationAssignment -GroupPolicyConfigurationId $Id
        if ($graphAssignments.count -gt 0)
        {
            $returnAssignments += ConvertFrom-IntunePolicyAssignment `
                                -IncludeDeviceFilter:$true `
                                -Assignments ($graphAssignments)
        }
        $results.Add('Assignments', $returnAssignments)

        return $results
    }
    catch
    {
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
            $_.Exception -like "*Unable to perform redirect as Location Header is not set in response*")
        {
            if (Assert-M365DSCIsNonInteractiveShell)
            {
                Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for Intune."
            }
        }
        else
        {
            New-M365DSCLogEntry -Message 'Error retrieving data:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }
        $nullResult = Clear-M365DSCAuthenticationParameter -BoundParameters $nullResult
        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('unknown', 'custom', 'builtIn', 'mixed', 'unknownFutureValue')]
        [System.String]
        $PolicyConfigurationIngestionType,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DefinitionValues,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion

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

    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null
    $PSBoundParameters.Remove('ManagedIdentity') | Out-Null
    $PSBoundParameters.Remove('Verbose') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null
    $keyToRename = @{
        'odataType'          = '@odata.type'
        'BooleanValue'       = 'value'
        'StringValue'        = 'value'
        'DecimalValue'       = 'value'
        'KeyValuePairValues' = 'values'
        'StringValues'       = 'values'
    }
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Device Configuration Administrative Template Policy for Windows10 with DisplayName {$DisplayName}"
        $PSBoundParameters.Remove('Assignments') | Out-Null

        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters -KeyMapping $keyToRename
        $CreateParameters.Remove('Id') | Out-Null
        $CreateParameters.Remove('DefinitionValues') | Out-Null

        $keys = (([Hashtable]$CreateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.getType().Name -like '*cimInstance*')
            {
                if ($key -eq 'DefinitionValues')
                {
                    #Removing Key Definition because it is Read-Only
                    foreach ($definitionValue in ($CreateParameters.$key).DefinitionValues)
                    {
                        $definitionValue.remove('Definition')
                    }
                }
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }
        #region resource generator code
        $policy = New-MgBetaDeviceManagementGroupPolicyConfiguration -BodyParameter $CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/groupPolicyConfigurations'
        }

        #Create DefinitionValues
        [Array]$targetDefinitionValues = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $DefinitionValues
        $formattedDefinitionValuesToAdd = @()
        foreach ($definitionValue in $targetDefinitionValues)
        {
            $definitionValue = Rename-M365DSCCimInstanceParameter -Properties $definitionValue -KeyMapping $keyToRename
            $enumConfigurationType = $null
            if ($null -ne $definitionValue.ConfigurationType)
            {
                $enumConfigurationType = $definitionValue.ConfigurationType.toString()
            }
            $complexPresentationValues = @()
            if ($null -ne $definitionValue.PresentationValues)
            {
                foreach ($presentationValue in [Hashtable[]]$definitionValue.PresentationValues)
                {
                    $value = $presentationValue.clone()
                    $value = Rename-M365DSCCimInstanceParameter -Properties $value -KeyMapping $keyToRename
                    $value.add('presentation@odata.bind', "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')/presentations('$($presentationValue.presentationDefinitionId)')")
                    $value.remove('PresentationDefinitionId')
                    $value.remove('PresentationDefinitionLabel')
                    $value.remove('id')
                    $complexPresentationValues += $value
                }
            }
            $complexDefinitionValue = @{
                'definition@odata.bind' = "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')"
                enabled                 = $definitionValue.Enabled
                presentationValues      = $complexPresentationValues
            }
            $formattedDefinitionValuesToAdd += $complexDefinitionValue
        }

        Update-DeviceConfigurationGroupPolicyDefinitionValue `
            -DeviceConfigurationPolicyId $policy.Id `
            -DefinitionValueToAdd $formattedDefinitionValuesToAdd
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Device Configuration Administrative Template Policy for Windows10 with Id {$($currentInstance.Id)}"
        $PSBoundParameters.Remove('Assignments') | Out-Null

        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters -KeyMapping $keyToRename

        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters.Remove('DefinitionValues') | Out-Null

        $keys = (([Hashtable]$UpdateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }
        #region resource generator code
        #Update Core policy
        $UpdateParameters.Add('@odata.type', '#microsoft.graph.GroupPolicyConfiguration')
        Update-MgBetaDeviceManagementGroupPolicyConfiguration  `
            -GroupPolicyConfigurationId $currentInstance.Id `
            -BodyParameter $UpdateParameters

        #Update Assignments
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $currentInstance.id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/groupPolicyConfigurations'
        #endregion

        #Update DefinitionValues
        $currentDefinitionValues = @()
        $currentDefinitionValuesIds = @()
        if ($null -ne $currentInstance.DefinitionValues -and $currentInstance.DefinitionValues.count -gt 0 )
        {
            [Array]$currentDefinitionValues = $currentInstance.DefinitionValues
            [Array]$currentDefinitionValuesIds = $currentDefinitionValues.definition.id
        }
        $targetDefinitionValues = @()
        $targetDefinitionValuesIds = @()
        if ($null -ne $DefinitionValues -and $DefinitionValues.count -gt 0)
        {
            [Array]$targetDefinitionValues = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $DefinitionValues
            [Array]$targetDefinitionValuesIds = $targetDefinitionValues.Definition.Id
        }

        $comparedDefinitionValues = Compare-Object `
            -ReferenceObject ($currentDefinitionValuesIds) `
            -DifferenceObject ($targetDefinitionValuesIds) `
            -IncludeEqual

        $definitionValuesToAdd = ($comparedDefinitionValues | Where-Object -FilterScript { $_.SideIndicator -eq '=>' }).InputObject
        $definitionValuesToRemove = ($comparedDefinitionValues | Where-Object -FilterScript { $_.SideIndicator -eq '<=' }).InputObject
        $definitionValuesToCheck = ($comparedDefinitionValues | Where-Object -FilterScript { $_.SideIndicator -eq '==' }).InputObject
        #Write-Verbose ("Add: $($definitionValuesToAdd.count) - Remove: $($definitionValuesToRemove.count) - Check: $($definitionValuesToCheck.count)")

        $formattedDefinitionValuesToAdd = @()
        foreach ($definitionValueId in $definitionValuesToAdd)
        {
            $definitionValue = $targetDefinitionValues | Where-Object -FilterScript { $_.Definition.Id -eq $definitionValueId }
            $definitionValue = Rename-M365DSCCimInstanceParameter -Properties $definitionValue -KeyMapping $keyToRename
            $enumConfigurationType = $null
            if ($null -ne $definitionValue.ConfigurationType)
            {
                $enumConfigurationType = $definitionValue.ConfigurationType.toString()
            }
            $complexPresentationValues = @()
            if ($null -ne $definitionValue.PresentationValues)
            {
                foreach ($presentationValue in [Hashtable[]]$definitionValue.PresentationValues)
                {
                    $value = $presentationValue.clone()
                    $value = Rename-M365DSCCimInstanceParameter -Properties $value -KeyMapping $keyToRename
                    $value.add('presentation@odata.bind', "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')/presentations('$($presentationValue.presentationDefinitionId)')")
                    $value.remove('PresentationDefinitionId')
                    $value.remove('PresentationDefinitionLabel')
                    $value.remove('id')
                    $complexPresentationValues += $value
                }
            }
            $complexDefinitionValue = @{
                'definition@odata.bind' = "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')"
                enabled                 = $definitionValue.Enabled
                presentationValues      = $complexPresentationValues
            }
            $formattedDefinitionValuesToAdd += $complexDefinitionValue
        }

        $formattedDefinitionValuesToUpdate = @()
        foreach ($definitionValueId in $definitionValuesToCheck)
        {
            $definitionValue = $targetDefinitionValues | Where-Object -FilterScript { $_.Definition.Id -eq $definitionValueId }
            $currentDefinitionValue = $currentDefinitionValues | Where-Object -FilterScript { $_.definition.id -eq $definitionValueId }
            $definitionValue = Rename-M365DSCCimInstanceParameter -Properties $definitionValue -KeyMapping $keyToRename
            $enumConfigurationType = $null
            if ($null -ne $definitionValue.ConfigurationType)
            {
                $enumConfigurationType = $definitionValue.ConfigurationType.toString()
            }
            $complexPresentationValues = @()
            if ($null -ne $definitionValue.PresentationValues)
            {
                foreach ($presentationValue in [Hashtable[]]$definitionValue.PresentationValues)
                {
                    $currentPresentationValue = $currentDefinitionValue.PresentationValues | Where-Object { $_.PresentationDefinitionId -eq $presentationValue.presentationDefinitionId }
                    $value = $presentationValue.clone()
                    $value = Rename-M365DSCCimInstanceParameter -Properties $value -KeyMapping $keyToRename
                    $value.add('presentation@odata.bind', "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')/presentations('$($presentationValue.presentationDefinitionId)')")
                    $value.remove('PresentationDefinitionId')
                    $value.remove('PresentationDefinitionLabel')
                    $value.remove('id')
                    $value.add('id', $currentPresentationValue.Id)
                    $complexPresentationValues += $value
                }
            }
            $complexDefinitionValue = @{
                id                      = $currentDefinitionValue.Id
                'definition@odata.bind' = "https://graph.microsoft.com/beta/deviceManagement/groupPolicyDefinitions('$($definitionValue.Definition.Id)')"
                enabled                 = $definitionValue.Enabled
                presentationValues      = $complexPresentationValues
            }
            $formattedDefinitionValuesToUpdate += $complexDefinitionValue
        }

        $formattedDefinitionValuesToRemove = @()
        foreach ($definitionValueId in $definitionValuesToRemove)
        {
            $formattedDefinitionValuesToremove += ($currentDefinitionValues | Where-Object { $_.definition.id -eq $definitionValueId }).id
        }

        Update-DeviceConfigurationGroupPolicyDefinitionValue `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -DefinitionValueToAdd $formattedDefinitionValuesToAdd `
            -DefinitionValueToUpdate $formattedDefinitionValuesToUpdate `
            -DefinitionValueToRemove $formattedDefinitionValuesToRemove

    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Device Configuration Administrative Template Policy for Windows10 with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementGroupPolicyConfiguration -GroupPolicyConfigurationId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('unknown', 'custom', 'builtIn', 'mixed', 'unknownFutureValue')]
        [System.String]
        $PolicyConfigurationIngestionType,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DefinitionValues,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
        #endregion

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

    Write-Verbose -Message "Testing configuration of the Intune Device Configuration Administrative Template Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $CurrentValues))
    {
        Write-Verbose "An error occured in Get-TargetResource, the policy {$displayName} will not be processed"
        throw "An error occured in Get-TargetResource, the policy {$displayName} will not be processed. Refer to the event viewer logs for more information."
    }

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
        if ($source.getType().Name -like '*CimInstance*')
        {
            #Removing Key Definition because it is Read-Only and ID as random
            if ($key -eq 'DefinitionValues')
            {
                $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $source
                foreach ($definitionValue in $source)
                {
                    $definitionValue.remove('Definition')
                    $definitionValue.remove('Id')
                    #Removing Key presentationDefinitionLabel because it is Read-Only and ID as random
                    foreach ($presentationValue in $definitionValue.PresentationValues)
                    {
                        $presentationValue.remove('presentationDefinitionLabel')
                        $presentationValue.remove('Id')
                    }
                }
                foreach ($definitionValue in $target)
                {
                    $definitionValue.remove('Definition')
                    $definitionValue.remove('Id')
                    #Removing Key presentationDefinitionLabel because it is Read-Only and ID as random
                    foreach ($presentationValue in $definitionValue.PresentationValues)
                    {
                        $presentationValue.remove('presentationDefinitionLabel')
                        $presentationValue.remove('Id')
                    }
                }
            }

            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck.Remove('Ensure') | Out-Null
    $ValuesToCheck.Remove('PolicyConfigurationIngestionType') | Out-Null

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
        [array]$getValue = Get-MgBetaDeviceManagementGroupPolicyConfiguration -Filter $Filter -All -ErrorAction Stop
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
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.Id
                DisplayName           = $config.DisplayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                AccessTokens`         = $AccessTokens
            }

            $Results = Get-TargetResource @params
            if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $Results))
            {
                Write-Verbose "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed"
                throw "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed. Refer to the event viewer logs for more information."
            }
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($Results.DefinitionValues)
            {
                $complexMapping = @(
                    @{
                        Name            = 'Definition'
                        CimInstanceName = 'MSFT_IntuneGroupPolicyDefinitionValueDefinition'
                        IsRequired      = $false
                    }
                    @{
                        Name            = 'PresentationValues'
                        CimInstanceName = 'MSFT_IntuneGroupPolicyDefinitionValuePresentationValue'
                        IsRequired      = $false
                    }
                    @{
                        Name            = 'KeyValuePairValues'
                        CimInstanceName = 'MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair'
                        IsRequired      = $false
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.DefinitionValues `
                    -CIMInstanceName IntuneGroupPolicyDefinitionValue `
                    -ComplexTypeMapping $complexMapping
                if ($complexTypeStringResult)
                {
                    $Results.DefinitionValues = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('DefinitionValues') | Out-Null
                }
            }
            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Assignments -CIMInstanceName DeviceManagementConfigurationPolicyAssignments
                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
            }
            if ($Results.DefinitionValues)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'DefinitionValues' -IsCIMArray:$true
            }
            if ($Results.DefinitionValues.Definition)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Definition'
            }
            if ($Results.DefinitionValues.PresentationValues)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'PresentationValues'
            }
            if ($Results.DefinitionValues.PresentationValues.KeyValuePairValues)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'KeyValuePairValues'
            }

            #removing trailing commas and semi colons between items of an array of cim instances added by Convert-DSCStringParamToVariable
            $currentDSCBlock = $currentDSCBlock.replace( "    ,`r`n" , "    `r`n" )
            $currentDSCBlock = $currentDSCBlock.replace( "`r`n;`r`n" , "`r`n" )
            $currentDSCBlock = $currentDSCBlock.replace( "`r`n,`r`n" , "`r`n" )
            $currentDSCBlock = $currentDSCBlock.Replace("}                    Enabled = `$","}`r`n                    Enabled = `$")

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
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
                $_.Exception -like "*Unable to perform redirect as Location Header is not set in response*" -or `
                $_.Exception -like "*Request not applicable to target tenant*")
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for Intune."
        }
        else
        {
            Write-Host $Global:M365DSCEmojiRedX

            New-M365DSCLogEntry -Message 'Error during Export:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

        return ''
    }
}

function Update-DeviceConfigurationGroupPolicyDefinitionValue
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter()]
        [Array]
        $DefinitionValueToAdd = @(),

        [Parameter()]
        [Array]
        $DefinitionValueToUpdate = @(),

        [Parameter()]
        [Array]
        $DefinitionValueToRemove = @()
    )
    try
    {
        $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/groupPolicyConfigurations/$DeviceConfigurationPolicyId/updateDefinitionValues"

        $body = @{}
        $DefinitionValueToRemoveIds = @()
        if ($null -ne $DefinitionValueToRemove -and $DefinitionValueToRemove.count -gt 0)
        {
            $DefinitionValueToRemoveIds = $DefinitionValueToRemove
        }
        $body = @{
            'added'      = $DefinitionValueToAdd
            'updated'    = $DefinitionValueToUpdate
            'deletedIds' = $DefinitionValueToRemoveIds
        }
        #Write-Verbose -Message ($body | ConvertTo-Json -Depth 100)
        Invoke-MgGraphRequest -Method POST -Uri $Uri -Body ($body | ConvertTo-Json -Depth 20) -ErrorAction Stop 4> $null
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error updating data:'
        -Exception $_
        -Source $($MyInvocation.MyCommand.Source)
        -TenantId $TenantId
        -Credential $Credential

        return $null
    }
}

Export-ModuleMember -Function *-TargetResource
