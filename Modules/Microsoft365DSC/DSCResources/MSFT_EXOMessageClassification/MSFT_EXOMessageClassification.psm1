function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter()]
        [System.String]
        $ClassificationID,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('Highest', 'Higher', 'High', 'MediumHigh', 'Medium', 'MediumLow', 'Low', 'Lower', 'Lowest')]
        [System.String]
        $DisplayPrecedence = 'Medium',

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.Boolean]
        $PermissionMenuVisible,

        [Parameter()]
        [System.String]
        $RecipientDescription,

        [Parameter()]
        [System.Boolean]
        $RetainClassificationEnabled,

        [Parameter()]
        [System.String]
        $SenderDescription,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
        if (-not $Script:exportedInstance)
        {
            Write-Verbose -Message "Getting Message Classification Configuration for $($Identity)"
            $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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

            $MessageClassification = Get-MessageClassification -Identity $Identity -ErrorAction Stop

            if ($null -eq $MessageClassification)
            {
                if (-not [System.String]::IsNullOrEmpty($DisplayName))
                {
                    Write-Verbose -Message "Couldn't retrieve Message Classification policy by Id {$($Identity)}. Trying by DisplayName."
                    $MessageClassification = Get-MessageClassification -Identity $DisplayName
                }
                if ($null -eq $MessageClassification)
                {
                    return $nullReturn
                }
            }
        }
        else
        {
            $MessageClassification = $Script:exportedInstance
        }

        $result = @{
            Identity                    = $Identity
            ClassificationID            = $MessageClassification.ClassificationID
            DisplayName                 = $MessageClassification.DisplayName
            DisplayPrecedence           = $MessageClassification.DisplayPrecedence
            Name                        = $MessageClassification.Name
            PermissionMenuVisible       = $MessageClassification.PermissionMenuVisible
            RecipientDescription        = $MessageClassification.RecipientDescription
            RetainClassificationEnabled = $MessageClassification.RetainClassificationEnabled
            SenderDescription           = $MessageClassification.SenderDescription
            Credential                  = $Credential
            Ensure                      = 'Present'
            ApplicationId               = $ApplicationId
            CertificateThumbprint       = $CertificateThumbprint
            CertificatePath             = $CertificatePath
            CertificatePassword         = $CertificatePassword
            Managedidentity             = $ManagedIdentity.IsPresent
            TenantId                    = $TenantId
            AccessTokens                = $AccessTokens
        }

        Write-Verbose -Message "Found Message Classification policy $($Identity)"
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
        $Identity,

        [Parameter()]
        [System.String]
        $ClassificationID,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('Highest', 'Higher', 'High', 'MediumHigh', 'Medium', 'MediumLow', 'Low', 'Lower', 'Lowest')]
        [System.String]
        $DisplayPrecedence = 'Medium',

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.Boolean]
        $PermissionMenuVisible,

        [Parameter()]
        [System.String]
        $RecipientDescription,

        [Parameter()]
        [System.Boolean]
        $RetainClassificationEnabled,

        [Parameter()]
        [System.String]
        $SenderDescription,

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
        [Switch]
        $ManagedIdentity,

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

    Write-Verbose -Message "Setting configuration of Message Classification for $($Identity)"

    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
        -InboundParameters $PSBoundParameters

    $MessageClassification = Get-MessageClassification -Identity $Identity -ErrorAction SilentlyContinue
    $MessageClassificationParams = [System.Collections.Hashtable]($PSBoundParameters)
    $MessageClassificationParams.Remove('Ensure') | Out-Null
    $MessageClassificationParams.Remove('Credential') | Out-Null
    $MessageClassificationParams.Remove('ApplicationId') | Out-Null
    $MessageClassificationParams.Remove('TenantId') | Out-Null
    $MessageClassificationParams.Remove('CertificateThumbprint') | Out-Null
    $MessageClassificationParams.Remove('CertificatePath') | Out-Null
    $MessageClassificationParams.Remove('CertificatePassword') | Out-Null
    $MessageClassificationParams.Remove('ManagedIdentity') | Out-Null
    $MessageClassificationParams.Remove('AccessTokens') | Out-Null

    if (('Present' -eq $Ensure ) -and ($null -eq $MessageClassification))
    {
        $MessageClassificationParams.Remove('Identity') | Out-Null
        Write-Verbose -Message "Creating Message Classification policy  $($Identity)."
        New-MessageClassification @MessageClassificationParams
    }
    elseif (('Present' -eq $Ensure ) -and ($Null -ne $MessageClassification))
    {
        Write-Verbose -Message "Setting Message Classication policy $($Identity) with values: $(Convert-M365DscHashtableToString -Hashtable $MessageClassificationParams)"
        Set-MessageClassification @MessageClassificationParams -Confirm:$false
    }
    elseif (('Absent' -eq $Ensure ) -and ($null -ne $MessageClassification))
    {
        Write-Verbose -Message "Removing Message Classification policy $($Identity)"
        Remove-MessageClassification -Identity $Identity -Confirm:$false
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
        $Identity,

        [Parameter()]
        [System.String]
        $ClassificationID,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('Highest', 'Higher', 'High', 'MediumHigh', 'Medium', 'MediumLow', 'Low', 'Lower', 'Lowest')]
        [System.String]
        $DisplayPrecedence = 'Medium',

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.Boolean]
        $PermissionMenuVisible,

        [Parameter()]
        [System.String]
        $RecipientDescription,

        [Parameter()]
        [System.Boolean]
        $RetainClassificationEnabled,

        [Parameter()]
        [System.String]
        $SenderDescription,

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
        [Switch]
        $ManagedIdentity,

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

    Write-Verbose -Message "Testing configuration of Message Classification policy for $($Identity)"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck $ValuesToCheck.Keys

    Write-Verbose -Message "Test-TargetResource returned $($TestResult)"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (

        [Parameter()]
        [System.String]
        $ClassificationID,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('Highest', 'Higher', 'High', 'MediumHigh', 'Medium', 'MediumLow', 'Low', 'Lower', 'Lowest')]
        [System.String]
        $DisplayPrecedence = 'Medium',

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.Boolean]
        $PermissionMenuVisible,

        [Parameter()]
        [System.String]
        $RecipientDescription,

        [Parameter()]
        [System.Boolean]
        $RetainClassificationEnabled,

        [Parameter()]
        [System.String]
        $SenderDescription,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' -InboundParameters $PSBoundParameters -SkipModuleReload $true

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

        [Array]$MessageClassifications = Get-MessageClassification -ErrorAction Stop
        $dscContent = ''
        if ($MessageClassifications.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $i = 1
        foreach ($MessageClassification in $MessageClassifications)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($MessageClassifications.Length)] $($MessageClassification.Identity)" -NoNewline

            $Params = @{
                Identity              = $MessageClassification.Identity
                DisplayName           = $MessageClassification.Name
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }

            $Script:exportedInstance = $MessageClassification
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
            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $i++
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
