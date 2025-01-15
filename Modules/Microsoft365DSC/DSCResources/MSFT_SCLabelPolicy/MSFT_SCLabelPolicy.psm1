function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AdvancedSettings,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation,

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $AddLabels,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocation,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveLabels,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocation,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocationException,

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
            Write-Verbose -Message "Getting configuration of Sensitivity Label Policy for $Name"

            if ($PSBoundParameters.ContainsKey('Labels') -and `
                ($PSBoundParameters.ContainsKey('AddLabels') -or $PSBoundParameters.ContainsKey('RemoveLabels')))
            {
                throw 'You cannot use the Labels parameter and the AddLabels or RemoveLabels parameters at the same time.'
            }

            if ($PSBoundParameters.ContainsKey('AddLabels') -and $PSBoundParameters.ContainsKey('RemoveLabels'))
            {
                # Check if AddLabels and RemoveLabels contain the same labels
                [array]$diff = Compare-Object -ReferenceObject $AddLabels -DifferenceObject $RemoveLabels -ExcludeDifferent -IncludeEqual
                if ($diff.Count -gt 0)
                {
                    throw 'Parameters AddLabels and RemoveLabels cannot contain the same labels. Make sure labels are not present in both parameters.'
                }
            }

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

            try
            {
                $policy = Get-LabelPolicy -Identity $Name -ErrorAction SilentlyContinue -WarningAction Ignore
            }
            catch
            {
                throw $_
            }

            if ($null -eq $policy)
            {
                Write-Verbose -Message "Sensitivity label policy $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $policy = $Script:exportedInstance
        }

        if ($null -ne $policy.Settings)
        {
            $advancedSettingsValue = Convert-StringToAdvancedSettings -AdvancedSettings $policy.Settings
        }

        Write-Verbose "Found existing Sensitivity Label policy $($Name)"
        $result = @{
            Name                         = $policy.Name
            Comment                      = $policy.Comment
            AdvancedSettings             = $advancedSettingsValue
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            TenantId                     = $TenantId
            CertificateThumbprint        = $CertificateThumbprint
            CertificatePath              = $CertificatePath
            CertificatePassword          = $CertificatePassword
            Ensure                       = 'Present'
            Labels                       = $policy.Labels
            ExchangeLocation             = Convert-ArrayList -CurrentProperty $policy.ExchangeLocation
            ExchangeLocationException    = Convert-ArrayList -CurrentProperty $policy.ExchangeLocationException
            ModernGroupLocation          = Convert-ArrayList -CurrentProperty $policy.ModernGroupLocation
            ModernGroupLocationException = Convert-ArrayList -CurrentProperty $policy.ModernGroupLocationException
            AccessTokens                 = $AccessTokens
        }

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

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AdvancedSettings,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation,

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $AddLabels,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocation,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveLabels,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocation,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocationException,

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

    Write-Verbose -Message "Setting configuration of Sensitivity label policy for $Name"

    if ($PSBoundParameters.ContainsKey('Labels') -and `
        ($PSBoundParameters.ContainsKey('AddLabels') -or $PSBoundParameters.ContainsKey('RemoveLabels')))
    {
        throw 'You cannot use the Labels parameter and the AddLabels or RemoveLabels parameters at the same time.'
    }

    if ($PSBoundParameters.ContainsKey('AddLabels') -and $PSBoundParameters.ContainsKey('RemoveLabels'))
    {
        # Check if AddLabels and RemoveLabels contain the same labels
        [array]$diff = Compare-Object -ReferenceObject $AddLabels -DifferenceObject $RemoveLabels -ExcludeDifferent -IncludeEqual
        if ($diff.Count -gt 0)
        {
            throw 'Parameters AddLabels and RemoveLabels cannot contain the same labels. Make sure labels are not present in both parameters.'
        }
    }

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

    $CurrentPolicy = Get-TargetResource @PSBoundParameters

    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentPolicy.Ensure))
    {
        Write-Verbose "Creating new Sensitivity label policy '$Name'."

        $CreationParams = ([Hashtable]$PSBoundParameters).Clone()

        if ($PSBoundParameters.ContainsKey('AdvancedSettings'))
        {
            $advanced = Convert-CIMToAdvancedSettings -AdvancedSettings $AdvancedSettings
            $CreationParams['AdvancedSettings'] = $advanced
        }

        if ($PSBoundParameters.ContainsKey('AddLabels'))
        {
            $CreationParams['Labels'] = $AddLabels
        }
        $CreationParams.Remove('AddLabels') | Out-Null
        $CreationParams.Remove('RemoveLabels') | Out-Null

        #Remove parameters not used in New-LabelPolicy
        $CreationParams.Remove('Ensure') | Out-Null
        $CreationParams.Remove('AddExchangeLocation') | Out-Null
        $CreationParams.Remove('AddExchangeLocationException') | Out-Null
        $CreationParams.Remove('AddModernGroupLocation') | Out-Null
        $CreationParams.Remove('AddModernGroupLocationException') | Out-Null
        $CreationParams.Remove('RemoveExchangeLocation') | Out-Null
        $CreationParams.Remove('RemoveExchangeLocationException') | Out-Null
        $CreationParams.Remove('RemoveModernGroupLocation') | Out-Null
        $CreationParams.Remove('RemoveModernGroupLocationException') | Out-Null

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

        try
        {
            New-LabelPolicy @CreationParams
        }
        catch
        {
            Write-Warning "New-LabelPolicy is not available in tenant $($Credential.UserName.Split('@')[1]): $_"
        }
        try
        {
            Start-Sleep 5
            Write-Verbose "Updating Sensitivity label policy '$Name' settings."
            $SetParams = ([Hashtable]$PSBoundParameters).Clone()

            if ($PSBoundParameters.ContainsKey('AdvancedSettings'))
            {
                $advanced = Convert-CIMToAdvancedSettings -AdvancedSettings $AdvancedSettings
                $SetParams['AdvancedSettings'] = $advanced
            }

            #Remove unused parameters for Set-Label cmdlet
            $SetParams.Remove('Ensure') | Out-Null
            $SetParams.Remove('Name') | Out-Null
            $SetParams.Remove('ExchangeLocationException') | Out-Null
            $SetParams.Remove('ExchangeLocation') | Out-Null
            $SetParams.Remove('ModernGroupLocation') | Out-Null
            $SetParams.Remove('ModernGroupLocationException') | Out-Null

            # Labels are already set during creation, removing parameters
            $SetParams.Remove('Labels') | Out-Null
            $SetParams.Remove('AddLabels') | Out-Null
            $SetParams.Remove('RemoveLabels') | Out-Null

            # Remove authentication parameters
            $SetParams.Remove('Credential') | Out-Null
            $SetParams.Remove('ApplicationId') | Out-Null
            $SetParams.Remove('TenantId') | Out-Null
            $SetParams.Remove('CertificatePath') | Out-Null
            $SetParams.Remove('CertificatePassword') | Out-Null
            $SetParams.Remove('CertificateThumbprint') | Out-Null
            $SetParams.Remove('ManagedIdentity') | Out-Null
            $SetParams.Remove('ApplicationSecret') | Out-Null
            $SetParams.Remove('AccessTokens') | Out-Null

            Set-LabelPolicy @SetParams -Identity $Name
        }
        catch
        {
            Write-Warning "Set-LabelPolicy is not available in tenant $($Credential.UserName.Split('@')[1]): $_"
        }
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentPolicy.Ensure))
    {
        Write-Verbose "Updating existing Sensitivity label policy '$Name'."

        $SetParams = ([Hashtable]$PSBoundParameters).Clone()

        if ($PSBoundParameters.ContainsKey('AdvancedSettings'))
        {
            $advanced = Convert-CIMToAdvancedSettings -AdvancedSettings $AdvancedSettings
            $SetParams['AdvancedSettings'] = $advanced
        }

        if ($PSBoundParameters.ContainsKey('Labels'))
        {
            [array]$diffs = Compare-Object -ReferenceObject $CurrentPolicy.Labels -DifferenceObject $Labels
            if ($diffs.Count -gt 0)
            {
                $add = @()
                $remove = @()
                foreach ($diff in $diffs)
                {
                    if ($diff.SideIndicator -eq '<=')
                    {
                        Write-Verbose "Removing label $($diff.InputObject) from policy $Name."
                        $remove += $diff.InputObject
                    }
                    elseif ($diff.SideIndicator -eq '=>')
                    {
                        Write-Verbose "Adding label $($diff.InputObject) to policy $Name."
                        $add += $diff.InputObject
                    }
                }

                if ($add.Count -gt 0)
                {
                    $SetParams['AddLabels'] = $add
                }

                if ($remove.Count -gt 0)
                {
                    $SetParams['RemoveLabels'] = $remove
                }
            }
            $SetParams.Remove('Labels') | Out-Null
        }

        #Remove unused parameters for Set-Label cmdlet
        $SetParams.Remove('Ensure') | Out-Null
        $SetParams.Remove('Name') | Out-Null
        $SetParams.Remove('ExchangeLocationException') | Out-Null
        $SetParams.Remove('ExchangeLocation') | Out-Null
        $SetParams.Remove('ModernGroupLocation') | Out-Null
        $SetParams.Remove('ModernGroupLocationException') | Out-Null

        # Remove authentication parameters
        $SetParams.Remove('Credential') | Out-Null
        $SetParams.Remove('ApplicationId') | Out-Null
        $SetParams.Remove('TenantId') | Out-Null
        $SetParams.Remove('CertificatePath') | Out-Null
        $SetParams.Remove('CertificatePassword') | Out-Null
        $SetParams.Remove('CertificateThumbprint') | Out-Null
        $SetParams.Remove('ManagedIdentity') | Out-Null
        $SetParams.Remove('ApplicationSecret') | Out-Null
        $SetParams.Remove('AccessTokens') | Out-Null

        try
        {
            Set-LabelPolicy @SetParams -Identity $Name
        }
        catch
        {
            Write-Warning "Set-LabelPolicy is not available in tenant $($Credential.UserName.Split('@')[1]): $_"
        }
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentPolicy.Ensure))
    {
        # If the label exists and it shouldn't, simply remove it;Need to force deletoion
        Write-Verbose -Message "Deleting Sensitivity label policy $Name."

        try
        {
            Remove-LabelPolicy -Identity $Name -Confirm:$false
        }
        catch
        {
            Write-Warning "Remove-LabelPolicy is not available in tenant $($Credential.UserName.Split('@')[1]): $_"
        }
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

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AdvancedSettings,

        [Parameter()]
        [System.String[]]
        $Labels,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation,

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $AddLabels,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocation,

        [Parameter()]
        [System.String[]]
        $AddExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $AddModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveLabels,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocation,

        [Parameter()]
        [System.String[]]
        $RemoveExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $RemoveModernGroupLocationException,

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

    Write-Verbose -Message "Testing configuration of Sensitivity label for $Name"
    $CurrentValues = Get-TargetResource @PSBoundParameters

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('AddLabels') | Out-Null
    $ValuesToCheck.Remove('AddExchangeLocation') | Out-Null
    $ValuesToCheck.Remove('AddExchangeLocationException') | Out-Null
    $ValuesToCheck.Remove('AddModernGroupLocation') | Out-Null
    $ValuesToCheck.Remove('AddModernGroupLocationException') | Out-Null
    $ValuesToCheck.Remove('RemoveLabels') | Out-Null
    $ValuesToCheck.Remove('RemoveExchangeLocation') | Out-Null
    $ValuesToCheck.Remove('RemoveExchangeLocationException') | Out-Null
    $ValuesToCheck.Remove('RemoveModernGroupLocation') | Out-Null
    $ValuesToCheck.Remove('RemoveModernGroupLocationException') | Out-Null

    if ($null -ne $AdvancedSettings)
    {
        $TestAdvancedSettings = Test-AdvancedSettings -DesiredProperty $AdvancedSettings -CurrentProperty $CurrentValues.AdvancedSettings
        if ($false -eq $TestAdvancedSettings)
        {
            return $false
        }
    }

    if ($null -ne $RemoveModernGroupLocation -or $null -ne $AddModernGroupLocation -or $null -ne $ModernGroupLocation)
    {
        $configData = New-PolicyData -configData $ModernGroupLocation -currentData $CurrentValues.ModernGroupLocation `
            -removedData $RemoveModernGroupLocation -additionalData $AddModernGroupLocation
        if ($null -ne $configData)
        {
            $ValuesToCheck['ModernGroupLocation'] = $configData
        }
        if ($null -eq $configData -and $null -ne $CurrentValues.ModernGroupLocation `
                -and $null -ne $RemoveModernGroupLocation)
        {
            return $false
        }
    }

    if ($null -ne $RemoveModernGroupLocationException -or $null -ne $AddModernGroupLocationException `
            -or $null -ne $ModernGroupLocationException)
    {
        $configData = New-PolicyData -configData $ModernGroupLocationException -currentData $CurrentValues.ModernGroupLocationException `
            -removedData $RemoveModernGroupLocationException -additionalData $AddModernGroupLocationException

        if ($null -ne $configData)
        {
            $ValuesToCheck['ModernGroupLocationException'] = $configData
        }
        if ($null -eq $configData -and $null -ne $CurrentValues.ModernGroupLocationException `
                -and $null -ne $RemoveModernGroupLocationException)
        {
            return $false
        }
    }

    if ($null -ne $RemoveExchangeLocation -or $null -ne $AddExchangeLocation -or $null -ne $ExchangeLocation)
    {
        $configData = New-PolicyData -configData $ExchangeLocation -currentData $CurrentValues.ExchangeLocation `
            -removedData $RemoveExchangeLocation -additionalData $AddExchangeLocation
        if ($null -ne $configData)
        {
            $ValuesToCheck['ExchangeLocation'] = $configData
        }
        if ($null -eq $configData -and $null -ne $CurrentValues.ExchangeLocation `
                -and $null -ne $RemoveExchangeLocation)
        {
            return $false
        }
    }

    if ($null -ne $RemoveExchangeLocationException -or $null -ne $AddExchangeLocationException -or $null -ne $ExchangeLocationException)
    {
        $configData = New-PolicyData -configData $ExchangeLocationException -currentData $CurrentValues.ExchangeLocationException `
            -removedData $RemoveExchangeLocationException -additionalData $AddExchangeLocationException

        if ($null -ne $configData)
        {
            $ValuesToCheck['ExchangeLocationException'] = $configData
        }

        if ($null -eq $configData -and $null -ne $CurrentValues.ExchangeLocationException `
                -and $null -ne $RemoveExchangeLocationException)
        {
            return $false
        }
    }

    if ($null -ne $RemoveLabels -or $null -ne $AddLabels -or $null -ne $Labels)
    {
        $configData = New-PolicyData -configData $Labels -currentData $CurrentValues.Labels `
            -removedData $RemoveLabels -additionalData $AddLabels

        if ($null -ne $configData)
        {
            $ValuesToCheck['Labels'] = $configData
        }

        if ($null -eq $configData -and $null -ne $CurrentValues.Labels `
                -and $null -ne $RemoveLabels)
        {
            return $false
        }
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $ValuesToCheck `
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
        [array]$policies = Get-LabelPolicy -ErrorAction Stop -WarningAction Ignore

        $dscContent = ''
        $i = 1
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
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($policies.Count)] $($policy.Name)" -NoNewline

            $Script:exportedInstance = $policy
            $Results = Get-TargetResource @PSBoundParameters -Name $policy.Name

            if ($null -ne $Results.AdvancedSettings)
            {
                $Results.AdvancedSettings = ConvertTo-AdvancedSettingsString -AdvancedSettings $Results.AdvancedSettings
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($null -ne $Results.AdvancedSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'AdvancedSettings'
            }

            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
        }
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
    return $dscContent
}

function Convert-StringToAdvancedSettings
{
    [CmdletBinding()]
    [OutputType([Microsoft.Management.Infrastructure.CimInstance[]])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String[]]
        $AdvancedSettings
    )

    $settings = @()
    foreach ($setting in $AdvancedSettings)
    {
        $settingString = $setting.Replace('[', '').Replace(']', '')
        $settingKey = $settingString.Split(',')[0]

        if ($settingKey -ne 'displayname')
        {
            $startPos = $settingString.IndexOf(',', 0) + 1
            $valueString = $settingString.Substring($startPos, $settingString.Length - $startPos).Trim()
            if ($valueString -like '*,*')
            {
                $values = $valueString -split ','
            }
            else
            {
                $values = $valueString
            }

            if ($settingKey -like '*defaultlabel*')
            {
                if ($values -ne 'None')
                {
                    $label = Get-Label -Identity $values
                    $values = $label.DisplayName
                }
            }

            $entry = @{
                Key   = $settingKey
                Value = $values
            }
            $settings += $entry
        }
    }

    return $settings
}

function Convert-CIMToAdvancedSettings
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AdvancedSettings
    )

    $entry = @{ }
    foreach ($obj in $AdvancedSettings)
    {
        $settingsValues = ''
        if ($obj.Key -like '*defaultlabel*')
        {
            if ($obj.Value -ne 'None')
            {
                $label = Get-Label | Where-Object -FilterScript { $_.DisplayName -eq $obj.Value }
                if ($null -eq $label)
                {
                    Write-Error -Message "Label {$($obj.value)} doesn't exist. Please define the Sensitivy label first before trying to assign it to a policy."
                }
                else
                {
                    $settingsValues = $label.ImmutableId.ToString()
                }
            }
            else
            {
                $settingsValues = 'None'
            }
        }
        else
        {
            foreach ($objVal in $obj.Value)
            {
                $settingsValues += $objVal
                $settingsValues += ','
            }
        }
        $entry[$obj.Key] = $settingsValues.TrimEnd(',')
    }

    return $entry
}

function Test-AdvancedSettings
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter (Mandatory = $true)]
        $DesiredProperty,

        [Parameter (Mandatory = $true)]
        $CurrentProperty
    )

    $foundSettings = $true
    foreach ($desiredSetting in $DesiredProperty)
    {
        $foundKey = $CurrentProperty | Where-Object { $_.Key -eq $desiredSetting.Key }
        if ($null -ne $foundKey)
        {
            $checkValue = $desiredSetting.Value
            if ($checkValue.Count -eq 1)
            {
                $checkValue = $desiredSetting.Value[0]
            }
            if ($foundKey.Value.ToString() -ne $checkValue.ToString())
            {
                $foundSettings = $false
                break
            }
        }
    }

    Write-Verbose -Message "Test AdvancedSettings  returns $foundSettings"
    return $foundSettings
}

function ConvertTo-AdvancedSettingsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        $AdvancedSettings
    )

    $StringContent = "@(`r`n"
    foreach ($advancedSetting in $AdvancedSettings)
    {
        $StringContent += "                MSFT_SCLabelSetting`r`n"
        $StringContent += "                {`r`n"
        $StringContent += "                    Key   = '$($advancedSetting.Key.Replace("'", "''"))'`r`n"
        $StringContent += "                    Value = '$($advancedSetting.Value.Replace("'", "''"))'`r`n"
        $StringContent += "                }`r`n"
    }
    $StringContent += '            )'
    return $StringContent
}

function Convert-ArrayList
{
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
    param
    (
        [Parameter ()]
        $CurrentProperty
    )

    [System.Collections.ArrayList]$currentItems = @()
    foreach ($currentProp in $CurrentProperty)
    {
        $currentItems.Add($currentProp.Name) | Out-Null
    }

    return $currentItems

}

function New-PolicyData
{
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
    param
    (
        [Parameter ()]
        $configData,

        [Parameter ()]
        $currentData,

        [Parameter ()]
        $removedData,

        [Parameter ()]
        $additionalData
    )

    [System.Collections.ArrayList]$desiredData = @()
    foreach ($currItem in $currentData)
    {
        if (!$desiredData.Contains($currItem))
        {
            $desiredData.add($currItem) | Out-Null
        }
    }

    foreach ($currItem in $configData)
    {
        if (!$desiredData.Contains("$curritem"))
        {
            $desiredData.add($currItem) | Out-Null
        }
    }

    foreach ($currItem in $removedData)
    {
        $desiredData.remove($currItem) | Out-Null
    }

    foreach ($currItem in $additionalData)
    {
        if (!$desiredData.Contains("$curritem"))
        {
            $desiredData.add($currItem) | Out-Null
        }
    }

    return $desiredData
}

Export-ModuleMember -Function *-TargetResource
