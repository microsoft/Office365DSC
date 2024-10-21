function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.UInt32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.UInt32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [System.String[]]
        $SupportedServices,

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
        $instance = Get-MgBetaDomain -DomainId $Id -ErrorAction SilentlyContinue

        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            Id                               = $instance.Id
            AuthenticationType               = $instance.AuthenticationType
            AvailabilityStatus               = $instance.AvailabilityStatus
            IsAdminManaged                   = $instance.IsAdminManaged
            IsDefault                        = $instance.IsDefault
            IsRoot                           = $instance.IsRoot
            IsVerified                       = $instance.IsVerified
            PasswordNotificationWindowInDays = $instance.PasswordNotificationWindowInDays
            PasswordValidityPeriodInDays     = $instance.PasswordValidityPeriodInDays
            Ensure                           = 'Present'
            Credential                       = $Credential
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            ApplicationSecret                = $ApplicationSecret
            CertificateThumbprint            = $CertificateThumbprint
            ManagedIdentity                  = $ManagedIdentity.IsPresent
            AccessTokens                     = $AccessTokens
        }
        return [System.Collections.Hashtable] $results
    }
    catch
    {
        Write-Verbose -Message $_
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
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.UInt32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.UInt32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [System.String[]]
        $SupportedServices,

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

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $NeedAdditionalUpdate = $false
        $UpdatePasswordNotificationWindowInDays = $false
        if (-not [System.String]::IsNullOrEmpty('PasswordNotificationWindowInDays'))
        {
            $NeedAdditionalUpdate = $true
            $UpdatePasswordNotificationWindowInDays = $true
            $setParameters.Remove('PasswordNotificationWindowInDays') | Out-Null
        }
        $UpdatePasswordValidityPeriodInDays = $false
        if (-not [System.String]::IsNullOrEmpty($PasswordValidityPeriodInDays))
        {
            $NeedAdditionalUpdate = $true
            $UpdatePasswordValidityPeriodInDays = $true
            $setParameters.Remove('PasswordValidityPeriodInDays') | Out-Null
        }

        $payload = ConvertTo-Json $setParameters -Depth 10 -Compress
        Write-Verbose -Message "Creating new custom domain name {$Id} with payload: `r`n$payload"
        $domain = New-MgBetaDomain @setParameters

        if ($NeedAdditionalUpdate)
        {
            $UpdateParams = @{}
            if ($UpdatePasswordNotificationWindowInDays)
            {
                Write-Verbose -Message "Updating PasswordNotificationWindowInDays for domain {$Id}"
                $UpdateParams.Add('PasswordNotificationWindowInDays', $PasswordNotificationWindowInDays)
            }
            if ($UpdatePasswordValidityPeriodInDays)
            {
                Write-Verbose -Message "Updating PasswordValidityPeriodInDays for domain {$Id}"
                $UpdateParams.Add('PasswordValidityPeriodInDays', $PasswordValidityPeriodInDays)
            }

            Update-MgBetaDomain -DomainId $domain.Id @UpdateParams
        }
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating custom domain name {$Id}"
        $setParameters.Add('DomainId', $Id)
        $setParameters.Remove('Id') | Out-Null
        Update-MgBetaDomain @SetParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing custom domain name {$Id}"
        Invoke-MgBetaForceDomainDelete -DomainId $Id
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
        $Id,

        [Parameter()]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.String]
        $AvailabilityStatus,

        [Parameter()]
        [System.Boolean]
        $IsAdminManaged,

        [Parameter()]
        [System.Boolean]
        $IsDefault,

        [Parameter()]
        [System.Boolean]
        $IsRoot,

        [Parameter()]
        [System.Boolean]
        $IsVerified,

        [Parameter()]
        [System.UInt32]
        $PasswordNotificationWindowInDays,

        [Parameter()]
        [System.UInt32]
        $PasswordValidityPeriodInDays,

        [Parameter()]
        [System.String[]]
        $SupportedServices,

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

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
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
        [array] $Script:exportedInstances = Get-MgBetaDomain -ErrorAction Stop

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

            $displayedKey = $config.Id
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.Id
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
