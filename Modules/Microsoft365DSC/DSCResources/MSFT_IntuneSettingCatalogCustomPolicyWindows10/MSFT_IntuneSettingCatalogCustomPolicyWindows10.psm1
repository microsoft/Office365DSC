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
        $Name,

        [Parameter()]
        [ValidateSet('none', 'android', 'iOS', 'macOS', 'windows10X', 'windows10', 'linux', 'unknownFutureValue')]
        [System.String]
        $Platforms,

        [Parameter()]
        [ValidateSet('none', 'mdm', 'windows10XManagement', 'configManager', 'appleRemoteManagement', 'microsoftSense', 'exchangeOnline', 'linuxMdm', 'enrollment', 'endpointPrivilegeManagement', 'unknownFutureValue')]
        [System.String]
        $Technologies,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TemplateReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Settings,

        [Parameter()]
        [System.String]
        $Id,

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

        #region resource generator code
        try
        {
            $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Id -ExpandProperty 'settings' -ErrorAction Stop
        }
        catch
        {
            $getValue = $null
        }
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Setting Catalog Custom Policy for Windows10 with Id {$Id}"

            if (-not [string]::IsNullOrEmpty($Name))
            {
                $getValue = Get-MgBetaDeviceManagementConfigurationPolicy `
                    -Filter "Name eq '$Name' and Platforms eq 'windows10' and Technologies eq 'mdm' and TemplateReference/TemplateFamily eq 'none'" `
                    -All `
                    -ErrorAction SilentlyContinue

                if ($getValue.Count -gt 1)
                {
                    throw "Error: The displayName {$Name} is not unique in the tenant`r`nEnsure the display Name is unique for this type of resource."
                }

                if (-not [string]::IsNullOrEmpty($getValue.Id))
                {
                    $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $getValue.Id -ExpandProperty 'settings' -ErrorAction SilentlyContinue
                }
            }
        }
        #endregion
        if ([string]::IsNullOrEmpty($getValue.Id))
        {
            Write-Verbose -Message "Could not find an Intune Setting Catalog Custom Policy for Windows10 with Name {$Name}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Setting Catalog Custom Policy for Windows10 with Id {$Id} and Name {$Name} was found."

        $complexSettings = @()
        foreach ($currentSettings in $getValue.settings)
        {
            $mySettings = @{}
            $complexSettingInstance = @{}
            $complexSettingInstance.Add('SettingDefinitionId', $currentSettings.settingInstance.settingDefinitionId)
            $complexSettingInstance.Add('odataType', $currentSettings.settingInstance.AdditionalProperties.'@odata.type')
            $valueName = $currentSettings.settingInstance.AdditionalProperties.'@odata.type'.replace('#microsoft.graph.deviceManagementConfiguration', '').replace('Instance', 'Value')
            $valueName = Get-StringFirstCharacterToLower -Value $valueName
            $rawValue = $currentSettings.settingInstance.AdditionalProperties.$valueName
            $complexValue = get-SettingValue -SettingValue $rawValue -SettingValueType $currentSettings.settingInstance.AdditionalProperties.'@odata.type'
            $complexSettingInstance.Add($valueName,$complexValue)
            $mySettings.Add('SettingInstance', $complexSettingInstance)
            if ($mySettings.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexSettings += $mySettings
            }
        }
        #region resource generator code
        $enumPlatforms = $null
        if ($null -ne $getValue.Platforms)
        {
            $enumPlatforms = $getValue.Platforms.ToString()
        }

        $enumTechnologies = $null
        if ($null -ne $getValue.Technologies)
        {
            $enumTechnologies = $getValue.Technologies.ToString()
        }
        #endregion

        $results = @{
            #region resource generator code
            Description           = $getValue.Description
            Name                  = $getValue.Name
            Platforms             = $enumPlatforms
            Technologies          = $enumTechnologies
            Settings              = $complexSettings
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
        $assignmentsValues = Get-MgBetaDeviceManagementConfigurationPolicyAssignment -DeviceManagementConfigurationPolicyId $Id
        $assignmentResult = @()
        if ($assignmentsValues.Count -gt 0)
        {
            $assignmentResult += ConvertFrom-IntunePolicyAssignment `
                                -IncludeDeviceFilter:$true `
                                -Assignments ($assignmentsValues)
        }
        $results.Add('Assignments', $assignmentResult)

        return [System.Collections.Hashtable] $results
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        if ($_.Exception.Message -like "Error: The displayName*")
        {
            throw $_
        }

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
        $Name,

        [Parameter()]
        [ValidateSet('none', 'android', 'iOS', 'macOS', 'windows10X', 'windows10', 'linux', 'unknownFutureValue')]
        [System.String]
        $Platforms,

        [Parameter()]
        [ValidateSet('none', 'mdm', 'windows10XManagement', 'configManager', 'appleRemoteManagement', 'microsoftSense', 'exchangeOnline', 'linuxMdm', 'enrollment', 'endpointPrivilegeManagement', 'unknownFutureValue')]
        [System.String]
        $Technologies,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TemplateReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Settings,

        [Parameter()]
        [System.String]
        $Id,

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

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters
    $keyToRename = @{
        'odataType' = '@odata.type'
        'StringValue' = 'value'
        'IntValue' = 'value'
    }

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Setting Catalog Custom Policy for Windows10 with Name {$Name}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $CreateParameters = ([Hashtable]$BoundParameters).Clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters -KeyMapping $keyToRename
        $CreateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$CreateParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }
        #region resource generator code
        $CreateParameters.Add('@odata.type', '#microsoft.graph.DeviceManagementConfigurationPolicy')
        $policy = New-MgBetaDeviceManagementConfigurationPolicy -BodyParameter $CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.Id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $policy.Id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/configurationPolicies'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Setting Catalog Custom Policy for Windows10 with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove('Assignments') | Out-Null

        $UpdateParameters = ([Hashtable]$BoundParameters).Clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters -KeyMapping $keyToRename

        $UpdateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$UpdateParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }
        #region resource generator code
        Update-IntuneDeviceConfigurationPolicy  `
            -DeviceManagementConfigurationPolicyId $currentInstance.Id `
            @UpdateParameters

        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/configurationPolicies'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Setting Catalog Custom Policy for Windows10 with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $currentInstance.Id
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
        $Name,

        [Parameter()]
        [ValidateSet('none', 'android', 'iOS', 'macOS', 'windows10X', 'windows10', 'linux', 'unknownFutureValue')]
        [System.String]
        $Platforms,

        [Parameter()]
        [ValidateSet('none', 'mdm', 'windows10XManagement', 'configManager', 'appleRemoteManagement', 'microsoftSense', 'exchangeOnline', 'linuxMdm', 'enrollment', 'endpointPrivilegeManagement', 'unknownFutureValue')]
        [System.String]
        $Technologies,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TemplateReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Settings,

        [Parameter()]
        [System.String]
        $Id,

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

    Write-Verbose -Message "Testing configuration of the Intune Setting Catalog Custom Policy for Windows10 with Id {$Id} and Name {$Name}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

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
        if ($source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                $testResult = $false
                break
            }
            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys -verbose
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
        [array]$getValue = Get-MgBetaDeviceManagementConfigurationPolicy -Filter $Filter -All `
            -ErrorAction Stop | Where-Object -FilterScript { `
                $_.Platforms -eq 'windows10' -and
                $_.Technologies -eq 'mdm' -and
                $_.TemplateReference.TemplateFamily -eq 'none'
            }
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
            if (-not [String]::IsNullOrEmpty($config.Name))
            {
                $displayedKey = $config.Name
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.Id
                Name                  = $config.Name
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($null -ne $Results.Settings)
            {
                $complexMapping = @(
                    @{
                        Name            = 'Settings'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSetting'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'SettingInstance'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSettingInstance'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'SettingInstanceTemplateReference'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSettingInstanceTemplateReference'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'ChoiceSettingCollectionValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'Children'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSettingInstance'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'SettingValueTemplateReference'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSettingValueTemplateReference'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'ChoiceSettingValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'GroupSettingCollectionValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationGroupSettingValue'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'GroupSettingValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationGroupSettingValue'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'SimpleSettingCollectionValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue'
                        IsRequired      = $False
                    }
                    @{
                        Name            = 'SimpleSettingValue'
                        CimInstanceName = 'MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue'
                        IsRequired      = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Settings `
                    -CIMInstanceName 'MicrosoftGraphdeviceManagementConfigurationSetting' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Settings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Settings') | Out-Null
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

            if ($Results.Settings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Settings' -IsCIMArray:$True
            }
            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
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
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
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

function Get-SettingValue
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[System.Collections.Hashtable[]])]
    param (
        [Parameter()]
        $SettingValue,
        [Parameter()]
        $SettingValueType

    )

    switch -Wildcard ($SettingValueType)
    {
        '*ChoiceSettingInstance'
        {
            $complexValue = @{}
            $complexValue.Add('odataType',$SettingValue.'@odata.type')
            $complexValue.Add('Value',$SettingValue.value)
            $children = @()
            foreach($child in $SettingValue.children)
            {
                $complexChild = @{}
                $complexChild.Add('SettingDefinitionId', $child.settingDefinitionId)
                $complexChild.Add('odataType', $child.'@odata.type')
                $valueName = $child.'@odata.type'.replace('#microsoft.graph.deviceManagementConfiguration', '').replace('Instance', 'Value')
                $valueName = Get-StringFirstCharacterToLower -Value $valueName
                $rawValue = $child.$valueName
                $childSettingValue = Get-SettingValue -SettingValue $rawValue -SettingValueType $child.'@odata.type'
                $complexChild.Add($valueName,$childSettingValue)
                $children += $complexChild
            }
            $complexValue.Add('Children',$children)
        }
        '*ChoiceSettingCollectionInstance'
        {
            $complexCollection = @()
            foreach($item in $SettingValue)
            {
                $complexValue = @{}
                $complexValue.Add('Value',$item.value)
                $children = @()
                foreach($child in $item.children)
                {
                    $complexChild = @{}
                    $complexChild.Add('SettingDefinitionId', $child.settingDefinitionId)
                    $complexChild.Add('odataType', $child.'@odata.type')
                    $valueName = $child.'@odata.type'.replace('#microsoft.graph.deviceManagementConfiguration', '').replace('Instance', 'Value')
                    $valueName = Get-StringFirstCharacterToLower -Value $valueName
                    $rawValue = $child.$valueName
                    $childSettingValue = Get-SettingValue -SettingValue $rawValue  -SettingValueType $child.'@odata.type'
                    $complexChild.Add($valueName,$childSettingValue)
                    $children += $complexChild
                }
                $complexValue.Add('Children',$children)
                $complexCollection += $complexValue
            }
            return ,([hashtable[]]$complexCollection)
        }
        '*SimpleSettingInstance'
        {
            $complexValue = @{}
            $complexValue.Add('odataType',$SettingValue.'@odata.type')
            $valueName = 'IntValue'
            $value = $SettingValue.value
            if($SettingValue.'@odata.type' -ne '#microsoft.graph.deviceManagementConfigurationIntegerSettingValue')
            {
                $valueName = 'StringValue'
            }
            $complexValue.Add($valueName,$value)
            if($SettingValue.'@odata.type' -eq '#microsoft.graph.deviceManagementConfigurationSecretSettingValue')
            {
                $complexValue.Add('ValueState',$SettingValue.valueState)
            }
        }
        '*SimpleSettingCollectionInstance'
        {
            $complexCollection = @()

            foreach($item in $SettingValue)
            {
                $complexValue = @{}
                $complexValue.Add('odataType',$item.'@odata.type')
                $valueName = 'IntValue'
                $value = $item.value
                if($item.'@odata.type' -ne '#microsoft.graph.deviceManagementConfigurationIntegerSettingValue')
                {
                    $valueName = 'StringValue'
                }
                $complexValue.Add($valueName,$value)
                if($item.'@odata.type' -eq '#microsoft.graph.deviceManagementConfigurationSecretSettingValue')
                {
                    $complexValue.Add('ValueState',$item.valueState)
                }
                $complexCollection += $complexValue
            }
            return ,([hashtable[]]$complexCollection)
        }
        '*GroupSettingInstance'
        {
            $complexValue = @{}
            $complexValue.Add('odataType',$SettingValue.'@odata.type')
            $children = @()
            foreach($child in $SettingValue.children)
            {
                $complexChild = @{}
                $complexChild.Add('SettingDefinitionId', $child.settingDefinitionId)
                $complexChild.Add('odataType', $child.'@odata.type')
                $valueName = $child.'@odata.type'.replace('#microsoft.graph.deviceManagementConfiguration', '').replace('Instance', 'Value')
                $valueName = Get-StringFirstCharacterToLower -Value $valueName
                $rawValue = $child.$valueName
                $settingValue = Get-SettingValue -SettingValue $rawValue  -SettingValueType $child.'@odata.type'
                $complexChild.Add($valueName,$settingValue)
                $children += $complexChild
            }
            $complexValue.Add('Children',$children)
        }
        '*GroupSettingCollectionInstance'
        {
            $complexCollection = @()
            foreach($groupSettingValue in $SettingValue)
            {
                $complexValue = @{}
                #$complexValue.Add('odataType',$SettingValue.'@odata.type')
                $children = @()
                foreach($child in $groupSettingValue.children)
                {
                    $complexChild = @{}
                    $complexChild.Add('SettingDefinitionId', $child.settingDefinitionId)
                    $complexChild.Add('odataType', $child.'@odata.type')
                    $valueName = $child.'@odata.type'.replace('#microsoft.graph.deviceManagementConfiguration', '').replace('Instance', 'Value')
                    $valueName = Get-StringFirstCharacterToLower -Value $valueName
                    $rawValue = $child.$valueName
                    $settingValue = Get-SettingValue -SettingValue $rawValue  -SettingValueType $child.'@odata.type'
                    $complexChild.Add($valueName,$settingValue)
                    $children += $complexChild
                }
                $complexValue.Add('Children',$children)
                $complexCollection += $complexValue
            }
            return ,([hashtable[]]$complexCollection)
        }
    }
    return $complexValue
}

function Update-IntuneDeviceConfigurationPolicy
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceManagementConfigurationPolicyId,

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $Platforms,

        [Parameter()]
        [System.String]
        $Technologies,

        [Parameter()]
        [System.String]
        $TemplateReferenceId,

        [Parameter()]
        [Array]
        $Settings

    )
    try
    {
        $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/configurationPolicies/$DeviceManagementConfigurationPolicyId"

        $policy = @{
            'name'              = $Name
            'description'       = $Description
            'platforms'         = $Platforms
            'templateReference' = @{'templateId' = $TemplateReferenceId }
            'technologies'      = $Technologies
            'settings'          = $Settings
        }
        $body = $policy | ConvertTo-Json -Depth 20
        #write-verbose -Message $body
        Invoke-MgGraphRequest -Method PUT -Uri $Uri -Body $body -ErrorAction Stop 4> $null
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error updating data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $null
    }
}

Export-ModuleMember -Function *-TargetResource
