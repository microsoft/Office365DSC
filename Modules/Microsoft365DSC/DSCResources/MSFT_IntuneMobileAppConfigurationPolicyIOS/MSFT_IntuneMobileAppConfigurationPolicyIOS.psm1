function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune resource parameters
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $targetedMobileApps,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $settings,

        [Parameter()]
        [System.String]
        $encodedSettingXml,

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
    }
    catch
    {
        Write-Verbose -Message 'Connection to the workload failed.'
    }

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
        if (-not [string]::IsNullOrWhiteSpace($id)){ $getValue = Get-MgBetaDeviceAppManagementMobileAppConfiguration -ManagedDeviceMobileAppConfigurationId $id -ErrorAction SilentlyContinue }
        
        #region resource generator code
        if ($null -eq $getValue)
        {
            $getValue = Get-MgBetaDeviceAppManagementMobileAppConfiguration -Filter "DisplayName eq '$Displayname'" -ErrorAction SilentlyContinue | Where-Object `
            -FilterScript { `
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.iosMobileAppConfiguration' `
            }
        }
        #endregion

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "No Intune Mobile App Configuration Policy for iOS with Id {$id} was found"
            return $nullResult
        }

        Write-Verbose -Message "An Intune Mobile App Configuration Policy for iOS with Id {$id} and DisplayName {$DisplayName} was found"

        #need to convert dictionary object into a hashtable array so we can work with it
        $complexSettings = @()
        foreach ($setting in $getValue.AdditionalProperties.settings)
        {
            $mySettings = @{}
            $mySettings.Add('appConfigKey', $setting['appConfigKey'])
            $mySettings.Add('appConfigKeyType', $setting['appConfigKeyType'])
            $mySettings.Add('appConfigKeyValue', $setting['appConfigKeyValue'])
            
            if ($mySettings.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexSettings += $mySettings
            }
        }

        $results = @{
            #region resource generator code
            Id                             = $getValue.Id
            Description                    = $getValue.Description
            DisplayName                    = $getValue.DisplayName   
            targetedMobileApps             = $getValue.TargetedMobileApps
            settings                       = $complexSettings #$getValue.AdditionalProperties.settings
            encodedSettingXml              = $getValue.AdditionalProperties.encodedSettingXml
            Ensure                         = 'Present'
            Credential                     = $Credential
            ApplicationId                  = $ApplicationId
            TenantId                       = $TenantId
            ApplicationSecret              = $ApplicationSecret
            CertificateThumbprint          = $CertificateThumbprint
            Managedidentity                = $ManagedIdentity.IsPresent
            AccessTokens                   = $AccessTokens
            version                        = $getValue.AdditionalProperties.version

        }
                                          
        $assignmentsValues = Get-MgBetaDeviceAppManagementMobileAppConfigurationAssignment -ManagedDeviceMobileAppConfigurationId $Results.Id
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

        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        #region Intune resource parameters
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $targetedMobileApps,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $settings,

        [Parameter()]
        [System.String]
        $encodedSettingXml,

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
    }
    catch
    {
        Write-Verbose -Message $_
    }

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
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating {$DisplayName}"
        $PSBoundParameters.Remove('Assignments') | Out-Null
        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $AdditionalProperties = Get-M365DSCAdditionalProperties -Properties ($CreateParameters)

        foreach ($key in $AdditionalProperties.keys)
        {
            if ($key -ne '@odata.type')
            {
                $keyName = $key.substring(0, 1).ToUpper() + $key.substring(1, $key.length - 1)
                $CreateParameters.remove($keyName)
            }
        }

        $CreateParameters.Remove('Id') | Out-Null
        $CreateParameters.Remove('Verbose') | Out-Null

        foreach ($key in ($CreateParameters.clone()).Keys)
        {
            if ($CreateParameters[$key].getType().Fullname -like '*CimInstance*')
            {
                $CreateParameters[$key] = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters[$key]
            }
        }

        $CreateParameters.add('AdditionalProperties', $AdditionalProperties)
           
        #region resource generator code
        $policy = New-MgBetaDeviceAppManagementMobileAppConfiguration @CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceAppManagement/mobileAppConfigurations'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating {$DisplayName}"
        $PSBoundParameters.Remove('Assignments') | Out-Null
        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters
        $AdditionalProperties = Get-M365DSCAdditionalProperties -Properties ($UpdateParameters)
        foreach ($key in $AdditionalProperties.keys)
        {
            if ($key -ne '@odata.type')
            {
                $keyName = $key.substring(0, 1).ToUpper() + $key.substring(1, $key.length - 1)
                $UpdateParameters.remove($keyName)
            }
        }

        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters.Remove('Verbose') | Out-Null

        foreach ($key in ($UpdateParameters.clone()).Keys)
        {
            if ($UpdateParameters[$key].getType().Fullname -like '*CimInstance*')
            {
                $UpdateParameters[$key] = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters[$key]
            }
        }

        $UpdateParameters.add('AdditionalProperties', $AdditionalProperties)

        #region resource generator code
        Update-MgBetaDeviceAppManagementMobileAppConfiguration @UpdateParameters `
            -ManagedDeviceMobileAppConfigurationId $currentInstance.Id
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $currentInstance.id `
            -Targets $assignmentsHash `
            -Repository 'deviceAppManagement/mobileAppConfigurations'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing {$DisplayName}"
        #region resource generator code
        Remove-MgBetaDeviceAppManagementMobileAppConfiguration -ManagedDeviceMobileAppConfigurationId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region Intune resource parameters
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $targetedMobileApps,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $settings,

        [Parameter()]
        [System.String]
        $encodedSettingXml,

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

    Write-Verbose -Message "Testing configuration of {$id}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    foreach ($key in $PSBoundParameters.Keys)
    {
        if ($PSBoundParameters[$key].getType().Name -like '*CimInstance*')
        {
            $CIMArraySource = @()
            $CIMArrayTarget = @()
            $CIMArraySource += $PSBoundParameters[$key]
            $CIMArrayTarget += $CurrentValues.$key
            if ($CIMArraySource.count -ne $CIMArrayTarget.count)
            {
                Write-Verbose -Message "Configuration drift:Number of items does not match: Source=$($CIMArraySource.count) Target=$($CIMArrayTarget.count)"
                $testResult = $false
                break
            }
            $i = 0
            foreach ($item in $CIMArraySource )
            {
                $testResult = Compare-M365DSCComplexObject `
                    -Source (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $CIMArraySource[$i]) `
                    -Target ($CIMArrayTarget[$i])
                $i++
                if (-Not $testResult)
                {
                    $testResult = $false
                    break
                }
            }
            if (-Not $testResult)
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

    #Convert any DateTime to String
    foreach ($key in $ValuesToCheck.Keys)
    {
        if (($null -ne $CurrentValues[$key]) `
                -and ($CurrentValues[$key].getType().Name -eq 'DateTime'))
        {
            $CurrentValues[$key] = $CurrentValues[$key].toString()
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
        [array]$getValue = Get-MgBetaDeviceAppManagementMobileAppConfiguration -Filter $Filter -All `
            -ErrorAction Stop | Where-Object `
            -FilterScript { `
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.iosMobileAppConfiguration'  `
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

            Write-Host "    |---[$i/$($getValue.Count)] $($config.DisplayName)" -NoNewline
            $params = @{
                Id                    = $config.id
                DisplayName           = $config.DisplayName
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

            if ($null -ne $Results.settings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.settings `
                    -CIMInstanceName 'MSFT_appConfigurationSettingItem'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.settings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('settings') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($Results.Assignments)
            {
                $isCIMArray = $false
                if ($Results.Assignments.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$isCIMArray
            }
           
            if ($Results.settings)
            {
                $isCIMArray = $false
                if ($Results.settings.getType().Fullname -like '*[[\]]')
                {
                    $isCIMArray = $true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'settings' -IsCIMArray:$isCIMArray
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



function Get-M365DSCAdditionalProperties
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $Properties
    )

    $additionalProperties = @(
        'encodedSettingXml'
        'settings'
    )

    $results = @{'@odata.type' = '#microsoft.graph.iosMobileAppConfiguration' }
    $cloneProperties = $Properties.clone()
    foreach ($property in $cloneProperties.Keys)
    {
        if ($property -in ($additionalProperties) )
        {
            $propertyName = $property[0].ToString().ToLower() + $property.Substring(1, $property.Length - 1)
            if ($properties.$property -and $properties.$property.getType().FullName -like '*CIMInstance*')
            {
                if ($properties.$property.getType().FullName -like '*[[\]]')
                {
                    $array = @()
                    foreach ($item in $properties.$property)
                    {
                        $array += Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
                    }
                    $propertyValue = $array
                }
                else
                {
                    $propertyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $properties.$property
                }

            }
            else
            {
                $propertyValue = $properties.$property
            }

            $results.Add($propertyName, $propertyValue)
        }
    }
    if ($results.Count -eq 1)
    {
        return $null
    }
    return $results
}

Export-ModuleMember -Function *-TargetResource
