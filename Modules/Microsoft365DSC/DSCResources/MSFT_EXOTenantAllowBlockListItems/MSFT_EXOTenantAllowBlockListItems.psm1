function Add-ActionParameters
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $Action,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Parameters
    )

    if ($Action -eq 'Allow')
    {
        $Parameters.Add('Allow', $true) | Out-Null
    }
    elseif ($Action -eq 'Block')
    {
        $Parameters.Add('Block', $true) | Out-Null
    }
    $Parameters.Remove('Action') | Out-Null
}

function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Allow', 'Block')]
        [System.String]
        $Action,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Value,

        [Parameter()]
        [System.DateTime]
        $ExpirationDate,

        [Parameter()]
        [ValidateSet('AdvancedDelivery', 'Tenant')]
        [System.String]
        $ListSubType,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ListType,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.UInt32]
        $RemoveAfter,

        [Parameter()]
        [System.String]
        $SubmissionID,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
    )

    New-M365DSCConnection -Workload 'ExchangeOnline' `
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
    $nullResult.ListType = $ListType
    try
    {
        $getParams = @{ ListType = $ListType; Entry = $Value; }
        if ($Action -eq 'Allow')
        {
            $getParams.Allow = $true
        }
        elseif ($Action -eq 'Block')
        {
            $getParams.Block = $true
        }
        $instance = Get-TenantAllowBlockListItems @getParams -ErrorAction SilentlyContinue
        if ($null -eq $instance)
        {
            return $nullResult
        }

        Write-Verbose -Message "Found an instance with Action {$Action}, Value {$Value}, and ListType {$ListType}"
        $results = @{
            Action                = $Action
            Value                 = $instance.Value
            ExpirationDate        = $instance.ExpirationDate
            ListSubType           = $instance.ListSubType
            ListType              = $ListType
            Notes                 = $instance.Notes
            RemoveAfter           = $instance.RemoveAfter
            SubmissionID          = $instance.SubmissionID
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ApplicationSecret     = $ApplicationSecret
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
        [Parameter(Mandatory = $true)]
        [ValidateSet('Allow', 'Block')]
        [System.String]
        $Action,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Value,

        [Parameter()]
        [System.DateTime]
        $ExpirationDate,

        [Parameter()]
        [ValidateSet('AdvancedDelivery', 'Tenant')]
        [System.String]
        $ListSubType,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ListType,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.UInt32]
        $RemoveAfter,

        [Parameter()]
        [System.String]
        $SubmissionID,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
    )

    New-M365DSCConnection -Workload 'ExchangeOnline' `
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

    $currentInstance = Get-TargetResource @PSBoundParameters

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $CreateParameters = ([Hashtable]$BoundParameters).Clone()

        $CreateParameters.Remove('Verbose') | Out-Null
        $CreateParameters.Remove('Value') | Out-Null
        $CreateParameters.Add('Entries', @($Value)) | Out-Null
        Add-ActionParameters -Action $Action -Parameters $CreateParameters

        $keys = $CreateParameters.Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $keyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
                $CreateParameters.Remove($key) | Out-Null
                $CreateParameters.Add($keyName, $keyValue)
            }
        }
        Write-Verbose -Message "Creating {$Value} with Parameters:`r`n$(Convert-M365DscHashtableToString -Hashtable $CreateParameters)"
        New-TenantAllowBlockListItems @CreateParameters | Out-Null
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating {$Value}"

        if ($currentInstance.SubmissionID -ne $SubmissionID)
        {
            throw "SubmissionID can not be changed"
        }

        $UpdateParameters = ([Hashtable]$BoundParameters).Clone()
        $UpdateParameters.Remove('Verbose') | Out-Null
        $UpdateParameters.Remove('Value') | Out-Null
        $UpdateParameters.Remove('SubmissionID') | Out-Null #SubmissionID can not be changed
        $UpdateParameters.Add('Entries', @($Value)) | Out-Null
        $UpdateParameters.Remove('Action') | Out-Null

        $keys = $UpdateParameters.Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.GetType().Name -like '*cimInstance*')
            {
                $keyValue = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
                $UpdateParameters.Remove($key) | Out-Null
                $UpdateParameters.Add($keyName, $keyValue)
            }
        }

        Set-TenantAllowBlockListItems @UpdateParameters | Out-Null
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing {$Value}"
        Remove-TenantAllowBlockListItems -Entries $currentInstance.Value -ListType $currentInstance.ListType
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Allow', 'Block')]
        [System.String]
        $Action,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Value,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ListType,

        [Parameter()]
        [System.DateTime]
        $ExpirationDate,

        [Parameter()]
        [ValidateSet('AdvancedDelivery', 'Tenant')]
        [System.String]
        $ListSubType,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.Int32]
        $RemoveAfter,

        [Parameter()]
        [System.String]
        $SubmissionID,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
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

    Write-Verbose -Message "Testing configuration of {$Value}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }

    if ($null -ne $ValuesToCheck.ExpirationDate -and $ValuesToCheck.ExpirationDate.Kind -eq 'Local')
    {
        $ValuesToCheck.ExpirationDate = $ValuesToCheck.ExpirationDate.ToUniversalTime().ToString()
    }

    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck
    $ValuesToCheck.Remove('Entries') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    #Convert any DateTime to String
    $keys = $ValuesToCheck.Keys
    foreach ($key in $keys)
    {
        if (($null -ne $CurrentValues[$key]) `
                -and ($CurrentValues[$key].GetType().Name -eq 'DateTime'))
        {
            $CurrentValues[$key] = $CurrentValues[$key].ToString()
        }
    }

    $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $ValuesToCheck `
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
        $ManagedIdentity
    )

   $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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
        $ListTypes = ("FileHash", "Sender", "Url");

        [array]$getValues = @()

        foreach ($ListType in $ListTypes)
        {
            $listValues = Get-TenantAllowBlockListItems -ListType $ListType -ErrorAction Stop
            $listValues | ForEach-Object {
                $getValues += @{
                    Action = $_.Action
                    Value = $_.Value
                    ListType = $ListType
                }
            }
        }

        $i = 1
        $dscContent = ''
        if ($getValues.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValues)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = "[$($config.Action)] [$($config.ListType)] $($config.Value)"
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValues.Count)] $displayedKey" -NoNewline
            $params = @{
                Action = $config.Action
                ListType = $config.ListType
                Value = $config.Value
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ApplicationSecret = $ApplicationSecret

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
