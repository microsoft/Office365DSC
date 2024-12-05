function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AzurePortalTimeOut,

        [Parameter()]
        [System.String]
        $DefaultTimeOut,

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
        $getValue = Get-MgBetaPolicyActivityBasedTimeoutPolicy -ErrorAction SilentlyContinue
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Activity Based Timeout Policy with DisplayName {$DisplayName}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Activity Based Timeout Policy with Id {$Id} and DisplayName {$DisplayName} was found."

        #Azure portal timeout
        $timeout = $getValue.Definition | ConvertFrom-Json
        $AzurePortalTimeOut = ($timeout.ActivityBasedTimeoutPolicy.ApplicationPolicies | Where-Object { $_.ApplicationId -match 'c44b4083-3bb0-49c1-b47d-974e53cbdf3c' }).WebSessionIdleTimeout
        $DefaultTimeOut = ($timeout.ActivityBasedTimeoutPolicy.ApplicationPolicies | Where-Object { $_.ApplicationId -match 'default' }).WebSessionIdleTimeout

        $results = @{
            #region resource generator code
            DisplayName           = $getValue.displayName
            Id                    = $getValue.Id
            AzurePortalTimeOut    = $AzurePortalTimeOut
            DefaultTimeOut        = $DefaultTimeOut
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
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AzurePortalTimeOut,

        [Parameter()]
        [System.String]
        $DefaultTimeOut,

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
    $AzurePortalTimeOutexist = $false
    $DefaultTimeOutexistst = $false
    if ($BoundParameters.ContainsKey('AzurePortalTimeOut') `
            -and $null -ne $BoundParameters.AzurePortalTimeOut `
            -and $BoundParameters.AzurePortalTimeOut -ne '' `
            -and $BoundParameters.AzurePortalTimeOut -ne $nullString)
    {
        $AzurePortalTimeOutexist = $true
    }
    if ($BoundParameters.ContainsKey('DefaultTimeOut') `
            -and $null -ne $BoundParameters.DefaultTimeOut `
            -and $BoundParameters.DefaultTimeOut -ne '' `
            -and $BoundParameters.DefaultTimeOut -ne $nullString)
    {
        $DefaultTimeOutexistst = $true
    }
    $ApplicationPolicies = @()
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Azure AD Activity Based Timeout Policy with DisplayName {$DisplayName}"
        if ($AzurePortalTimeOutexist)
        {
            $ApplicationPolicies += @{
                ApplicationId         = 'c44b4083-3bb0-49c1-b47d-974e53cbdf3c'
                WebSessionIdleTimeout = "$AzurePortalTimeOut"
            }
        }
        if ($DefaultTimeOutexistst)
        {
            $ApplicationPolicies += @{
                ApplicationId         = 'default'
                WebSessionIdleTimeout = "$DefaultTimeOut"
            }
        }
        if ($null -eq $ApplicationPolicies)
        {
            throw 'At least one of the parameters AzurePortalTimeOut or DefaultTimeOut must be specified'
        }
        elseif ($AzurePortalTimeOutexist -or $DefaultTimeOutexistst)
        {
            $policy = @{
                ActivityBasedTimeoutPolicy = @{
                    Version             = 1
                    ApplicationPolicies = @(
                        $ApplicationPolicies
                    )
                }
            }

            $json = $policy | ConvertTo-Json -Depth 10 -Compress
            $params = @{
                definition            = @(
                    "$json"
                )
                displayName           = 'displayName-value'
                isOrganizationDefault = $true
            }

            New-MgBetaPolicyActivityBasedTimeoutPolicy -BodyParameter $params
        }
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Creating an Azure AD Activity Based Timeout Policy with DisplayName {$DisplayName}"
        if ($AzurePortalTimeOutexist)
        {
            $ApplicationPolicies += @{
                ApplicationId         = 'c44b4083-3bb0-49c1-b47d-974e53cbdf3c'
                WebSessionIdleTimeout = "$AzurePortalTimeOut"
            }
        }
        if ($DefaultTimeOutexistst)
        {
            $ApplicationPolicies += @{
                ApplicationId         = 'default'
                WebSessionIdleTimeout = "$DefaultTimeOut"
            }
        }
        if ($null -eq $ApplicationPolicies)
        {
            throw 'At least one of the parameters AzurePortalTimeOut or DefaultTimeOut must be specified'
        }
        elseif ($AzurePortalTimeOutexist -or $DefaultTimeOutexistst)
        {
            $policy = @{
                ActivityBasedTimeoutPolicy = @{
                    Version             = 1
                    ApplicationPolicies = @(
                        $ApplicationPolicies
                    )
                }
            }

            $json = $policy | ConvertTo-Json -Depth 10 -Compress
            $params = @{
                definition            = @(
                    "$json"
                )
                displayName           = 'displayName-value'
                isOrganizationDefault = $true
            }

            Update-MgBetaPolicyActivityBasedTimeoutPolicy -ActivityBasedTimeoutPolicyId $currentInstance.Id -BodyParameter $params
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Azure AD Activity Based Timeout Policy with Id {$($currentInstance.Id)}"
        Remove-MgBetaPolicyActivityBasedTimeoutPolicy -ActivityBasedTimeoutPolicyId $currentInstance.Id
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $AzurePortalTimeOut,

        [Parameter()]
        [System.String]
        $DefaultTimeOut,

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

    Write-Verbose -Message "Testing configuration of the Azure AD Activity Based Timeout Policy with Id {$Id} and DisplayName {$DisplayName}"

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
        if ($source.getType().Name -like '*CimInstance*')
        {
            $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $source

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

    $ValuesToCheck.remove('Id') | Out-Null
    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null

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
        [array]$getValue = Get-MgBetaPolicyActivityBasedTimeoutPolicy `
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
                DisplayName           = $config.displayName
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
