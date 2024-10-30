function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
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
        [System.String]
        $DataType,

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

    Write-Verbose -Message "Getting configuration of user flow attribute: $DisplayName"
    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    Write-Verbose -Message 'Getting configuration of user flow attribute'

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

    $userFlowAttribute = $null
    if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
    {
        $userFlowAttribute = $Script:exportedInstances | Where-Object -FilterScript { $_.Id -eq $Id }
    }
    elseif (-not [System.String]::IsNullOrEmpty($Id))
    {
        $UserFlowAttribute = Get-MgBetaIdentityUserFlowAttribute -IdentityUserFlowAttributeId $Id -ErrorAction SilentlyContinue
    }

    if ($null -eq $UserFlowAttribute -and -not [System.String]::IsNullOrEmpty($DisplayName))
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $UserFlowAttribute = $Script:exportedInstances | Where-Object -FilterScript { $_.DisplayName -eq $DisplayName }
        }
        else
        {
            $UserFlowAttribute = Get-MgBetaIdentityUserFlowAttribute -Filter "displayName eq '$DisplayName'"
        }
    }

    if ($null -eq $UserFlowAttribute)
    {
        return $nullReturn
    }
    try
    {
        Write-Verbose -Message "Found configuration of user flow attribute $($DisplayName)"
        $result = @{
            Id                                                        = $UserFlowAttribute.Id
            DisplayName                                               = $UserFlowAttribute.DisplayName
            Description                                               = $UserFlowAttribute.Description
            DataType                                                  = $UserFlowAttribute.DataType
            Ensure                                                    = 'Present'
            ApplicationId                                             = $ApplicationId
            TenantId                                                  = $TenantId
            CertificateThumbprint                                     = $CertificateThumbprint
            ApplicationSecret                                         = $ApplicationSecret
            Credential                                                = $Credential
            ManagedIdentity                                           = $ManagedIdentity.IsPresent
            AccessTokens                                              = $AccessTokens
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
        [System.String]
        $DataType,

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

    Write-Verbose -Message "Setting configuration of user flow attribute: $DisplayName"

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

    $currentUserFlowAttribute = Get-TargetResource @PSBoundParameters

    # doesn't exist but it should
    if ($Ensure -eq 'Present' -and $currentUserFlowAttribute.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "The user flow attribute '$($DisplayName)' does not exist but it should. Creating it."

        try
        {
            New-MgBetaIdentityUserFlowAttribute -DataType $DataType -Description $Description -DisplayName $DisplayName
        }
        catch
        {
            Write-Error -ErrorRecord $_
        }
    }
    #exists but shouldn't
    elseif ($Ensure -eq 'Absent' -and $currentUserFlowAttribute.Ensure -eq 'Present')
    {
        Write-Verbose -Message "User flow attribute '$($DisplayName)' exists but shouldn't. Removing it."
        Remove-MgBetaIdentityUserFlowAttribute -IdentityUserFlowAttributeId $Id
    }
    elseif ($Ensure -eq 'Present' -and $currentUserFlowAttribute.Ensure -eq 'Present')
    {
        Write-Verbose -Message "User flow attribute '$($DisplayNameName)' already exists. Updating settings"

        if ($currentUserFlowAttribute.DisplayName -ne $DisplayName -or $currentUserFlowAttribute.DataType -ne $DataType)
        {
            Write-Warning -Message "There is a deviation in display name and data type for the resource with ID '$($Id)' but these values are not settable so cannot update them."
        }

        Write-Verbose -Message "Updating description of user flow attribute with display name '$($DisplayName)'"
        Update-MgBetaIdentityUserFlowAttribute -IdentityUserFlowAttributeId $Id -Description $Description
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
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $DataType,

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
    $Script:ExportMode = $false

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

    Write-Verbose -Message "Testing configuration of User flow attribute : $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion
    try
    {
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-MgBetaIdentityUserFlowAttribute -Filter "userFlowAttributeType ne 'builtIn'" -Sort DisplayName -ErrorAction Stop
        $i = 1
        $dscContent = ''
        Write-Host "`r`n" -NoNewline
        foreach ($userFlowAttribute in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($userFlowAttribute.DisplayName)" -NoNewline
            $Params = @{
                Id                    = $userFlowAttribute.Id
                DisplayName           = $userFlowAttribute.DisplayName
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                ApplicationSecret     = $ApplicationSecret
                Credential            = $Credential
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params

            if ($Results.Ensure -eq 'Present')
            {
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
            }
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
