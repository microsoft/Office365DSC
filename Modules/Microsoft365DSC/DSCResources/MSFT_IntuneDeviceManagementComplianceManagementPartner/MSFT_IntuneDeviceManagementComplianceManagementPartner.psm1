function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AndroidEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $AndroidOnboarded,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IosEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $IosOnboarded,

        [Parameter()]
        [System.String]
        $LastHeartbeatDateTime,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $MacOsEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $MacOsOnboarded,

        [Parameter()]
        [ValidateSet('unknown','unavailable','enabled','terminated','rejected','unresponsive')]
        [System.String]
        $PartnerState,

        [Parameter()]
        [System.String]
        $Id,

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
        $ConnectionMode = New-M365DSCConnection -Workload 'Intune' `
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
        $getValue = Get-MgBetaDeviceManagementComplianceManagementPartner `
            -Filter "DisplayName eq '$DisplayName'" `
            -ErrorAction SilentlyContinue <# | Where-Object `
            -FilterScript {
                $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.ComplianceManagementPartner"
            } #>

        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Management Compliance Management Partner with DisplayName {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Device Management Compliance Management Partner with Id {$Id} and DisplayName {$DisplayName} was found"

        #region resource generator code
        $complexAndroidEnrollmentAssignments = @()
        foreach ($currentAndroidEnrollmentAssignments in $getValue.androidEnrollmentAssignments)
        {
            $myAndroidEnrollmentAssignments = @{}
            $complexTarget = @{}
            $complexTarget.Add('DeviceAndAppManagementAssignmentFilterId', $currentAndroidEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterId)
            if ($null -ne $currentAndroidEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType)
            {
                $complexTarget.Add('DeviceAndAppManagementAssignmentFilterType', $currentAndroidEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType.ToString())
            }
            $complexTarget.Add('GroupId', $currentAndroidEnrollmentAssignments.target.groupId)
            $complexTarget.Add('CollectionId', $currentAndroidEnrollmentAssignments.target.collectionId)
            if ($null -ne $currentAndroidEnrollmentAssignments.target.'@odata.type')
            {
                $complexTarget.Add('odataType', $currentAndroidEnrollmentAssignments.target.'@odata.type'.ToString())
            }
            if ($complexTarget.values.Where({$null -ne $_}).Count -eq 0)
            {
                $complexTarget = $null
            }
            $myAndroidEnrollmentAssignments.Add('Target',$complexTarget)
            if ($myAndroidEnrollmentAssignments.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexAndroidEnrollmentAssignments += $myAndroidEnrollmentAssignments
            }
        }

        $complexIosEnrollmentAssignments = @()
        foreach ($currentIosEnrollmentAssignments in $getValue.iosEnrollmentAssignments)
        {
            $myIosEnrollmentAssignments = @{}
            $complexTarget = @{}
            $complexTarget.Add('DeviceAndAppManagementAssignmentFilterId', $currentIosEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterId)
            if ($null -ne $currentIosEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType)
            {
                $complexTarget.Add('DeviceAndAppManagementAssignmentFilterType', $currentIosEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType.ToString())
            }
            $complexTarget.Add('GroupId', $currentIosEnrollmentAssignments.target.groupId)
            $complexTarget.Add('CollectionId', $currentIosEnrollmentAssignments.target.collectionId)
            if ($null -ne $currentIosEnrollmentAssignments.target.'@odata.type')
            {
                $complexTarget.Add('odataType', $currentIosEnrollmentAssignments.target.'@odata.type'.ToString())
            }
            if ($complexTarget.values.Where({$null -ne $_}).Count -eq 0)
            {
                $complexTarget = $null
            }
            $myIosEnrollmentAssignments.Add('Target',$complexTarget)
            if ($myIosEnrollmentAssignments.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexIosEnrollmentAssignments += $myIosEnrollmentAssignments
            }
        }

        $complexMacOsEnrollmentAssignments = @()
        foreach ($currentMacOsEnrollmentAssignments in $getValue.macOsEnrollmentAssignments)
        {
            $myMacOsEnrollmentAssignments = @{}
            $complexTarget = @{}
            $complexTarget.Add('DeviceAndAppManagementAssignmentFilterId', $currentMacOsEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterId)
            if ($null -ne $currentMacOsEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType)
            {
                $complexTarget.Add('DeviceAndAppManagementAssignmentFilterType', $currentMacOsEnrollmentAssignments.target.deviceAndAppManagementAssignmentFilterType.ToString())
            }
            $complexTarget.Add('GroupId', $currentMacOsEnrollmentAssignments.target.groupId)
            $complexTarget.Add('CollectionId', $currentMacOsEnrollmentAssignments.target.collectionId)
            if ($null -ne $currentMacOsEnrollmentAssignments.target.'@odata.type')
            {
                $complexTarget.Add('odataType', $currentMacOsEnrollmentAssignments.target.'@odata.type'.ToString())
            }
            if ($complexTarget.values.Where({$null -ne $_}).Count -eq 0)
            {
                $complexTarget = $null
            }
            $myMacOsEnrollmentAssignments.Add('Target',$complexTarget)
            if ($myMacOsEnrollmentAssignments.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexMacOsEnrollmentAssignments += $myMacOsEnrollmentAssignments
            }
        }
        #endregion

        #region resource generator code
        $enumPartnerState = $null
        if ($null -ne $getValue.PartnerState)
        {
            $enumPartnerState = $getValue.PartnerState.ToString()
        }
        #endregion

        #region resource generator code
        $dateLastHeartbeatDateTime = $null
        if ($null -ne $getValue.LastHeartbeatDateTime)
        {
            $dateLastHeartbeatDateTime = ([DateTimeOffset]$getValue.LastHeartbeatDateTime).ToString('o')
        }
        #endregion

        $results = @{
            #region resource generator code
            AndroidEnrollmentAssignments = $complexAndroidEnrollmentAssignments
            AndroidOnboarded             = $getValue.AndroidOnboarded
            DisplayName                  = $getValue.DisplayName
            IosEnrollmentAssignments     = $complexIosEnrollmentAssignments
            IosOnboarded                 = $getValue.IosOnboarded
            LastHeartbeatDateTime        = $dateLastHeartbeatDateTime
            MacOsEnrollmentAssignments   = $complexMacOsEnrollmentAssignments
            MacOsOnboarded               = $getValue.MacOsOnboarded
            PartnerState                 = $enumPartnerState
            Id                           = $getValue.Id
            Ensure                       = 'Present'
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            TenantId                     = $TenantId
            ApplicationSecret            = $ApplicationSecret
            CertificateThumbprint        = $CertificateThumbprint
            ManagedIdentity              = $ManagedIdentity.IsPresent
            #endregion
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
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AndroidEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $AndroidOnboarded,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IosEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $IosOnboarded,

        [Parameter()]
        [System.String]
        $LastHeartbeatDateTime,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $MacOsEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $MacOsOnboarded,

        [Parameter()]
        [ValidateSet('unknown','unavailable','enabled','terminated','rejected','unresponsive')]
        [System.String]
        $PartnerState,

        [Parameter()]
        [System.String]
        $Id,

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


    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Device Management Compliance Management Partner with DisplayName {$DisplayName}"

        $createParameters = ([Hashtable]$BoundParameters).Clone()
        $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters
        $createParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$createParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $createParameters.$key -and $createParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $createParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $createParameters.$key
            }
        }
        #region resource generator code
        $createParameters.Add("@odata.type", "#microsoft.graph.ComplianceManagementPartner")
        $policy = New-MgBetaDeviceManagementComplianceManagementPartner -BodyParameter $createParameters
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Device Management Compliance Management Partner with Id {$($currentInstance.Id)}"

        $updateParameters = ([Hashtable]$BoundParameters).Clone()
        $updateParameters = Rename-M365DSCCimInstanceParameter -Properties $updateParameters

        $updateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$updateParameters).Clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $pdateParameters.$key -and $updateParameters.$key.GetType().Name -like '*CimInstance*')
            {
                $updateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $updateParameters.ComplianceManagementPartnerId
            }
        }

        #region resource generator code
        $UpdateParameters.Add("@odata.type", "#microsoft.graph.ComplianceManagementPartner")
        Update-MgBetaDeviceManagementComplianceManagementPartner `
            -ComplianceManagementPartnerId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Device Management Compliance Management Partner with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementComplianceManagementPartner -ComplianceManagementPartnerId $currentInstance.Id
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
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AndroidEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $AndroidOnboarded,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IosEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $IosOnboarded,

        [Parameter()]
        [System.String]
        $LastHeartbeatDateTime,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $MacOsEnrollmentAssignments,

        [Parameter()]
        [System.Boolean]
        $MacOsOnboarded,

        [Parameter()]
        [ValidateSet('unknown','unavailable','enabled','terminated','rejected','unresponsive')]
        [System.String]
        $PartnerState,

        [Parameter()]
        [System.String]
        $Id,

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

    Write-Verbose -Message "Testing configuration of the Intune Device Management Compliance Management Partner with Id {$Id} and DisplayName {$DisplayName}"

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

    $ConnectionMode = New-M365DSCConnection -Workload 'Intune' `
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
        [array]$getValue = Get-MgBetaDeviceManagementComplianceManagementPartner `
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
            if ($null -ne $Results.AndroidEnrollmentAssignments)
            {
                $complexMapping = @(
                    @{
                        Name = 'AndroidEnrollmentAssignments'
                        CimInstanceName = 'IntuneComplianceManagementPartnerAssignment'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Target'
                        CimInstanceName = 'IntuneDeviceAndAppManagementAssignmentTarget'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.AndroidEnrollmentAssignments `
                    -CIMInstanceName 'IntunecomplianceManagementPartnerAssignment' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.AndroidEnrollmentAssignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('AndroidEnrollmentAssignments') | Out-Null
                }
            }
            if ($null -ne $Results.IosEnrollmentAssignments)
            {
                $complexMapping = @(
                    @{
                        Name = 'IosEnrollmentAssignments'
                        CimInstanceName = 'IntuneComplianceManagementPartnerAssignment'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Target'
                        CimInstanceName = 'IntuneDeviceAndAppManagementAssignmentTarget'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.IosEnrollmentAssignments `
                    -CIMInstanceName 'IntunecomplianceManagementPartnerAssignment' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.IosEnrollmentAssignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('IosEnrollmentAssignments') | Out-Null
                }
            }
            if ($null -ne $Results.MacOsEnrollmentAssignments)
            {
                $complexMapping = @(
                    @{
                        Name = 'MacOsEnrollmentAssignments'
                        CimInstanceName = 'IntuneComplianceManagementPartnerAssignment'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Target'
                        CimInstanceName = 'IntuneDeviceAndAppManagementAssignmentTarget'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.MacOsEnrollmentAssignments `
                    -CIMInstanceName 'IntunecomplianceManagementPartnerAssignment' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.MacOsEnrollmentAssignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('MacOsEnrollmentAssignments') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.AndroidEnrollmentAssignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "AndroidEnrollmentAssignments" -IsCIMArray:$True
            }
            if ($Results.IosEnrollmentAssignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "IosEnrollmentAssignments" -IsCIMArray:$True
            }
            if ($Results.MacOsEnrollmentAssignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "MacOsEnrollmentAssignments" -IsCIMArray:$True
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
