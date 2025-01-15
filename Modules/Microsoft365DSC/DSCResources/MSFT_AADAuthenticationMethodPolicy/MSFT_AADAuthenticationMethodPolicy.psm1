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
        [ValidateSet('preMigration', 'migrationInProgress', 'migrationComplete', 'unknownFutureValue')]
        [System.String]
        $PolicyMigrationState,

        [Parameter()]
        [System.String]
        $PolicyVersion,

        [Parameter()]
        [System.Int32]
        $ReconfirmationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RegistrationEnforcement,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ReportSuspiciousActivitySettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SystemCredentialPreferences,

        [Parameter()]
        [System.String]
        $Id,
        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Present')]
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
        if (-not $Script:exportedInstance)
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
            if (-not [System.String]::IsNullOrEmpty($Id))
            {
                $getValue = Get-MgBetaPolicyAuthenticationMethodPolicy -ErrorAction SilentlyContinue
            }

            if ($null -eq $getValue)
            {
                Write-Verbose -Message "Could not find an Azure AD Authentication Method Policy with Id {$Id}"

                if (-Not [string]::IsNullOrEmpty($DisplayName))
                {
                    $getValue = Get-MgBetaPolicyAuthenticationMethodPolicy `
                        -ErrorAction SilentlyContinue | Where-Object `
                        -FilterScript { `
                            $_.DisplayName -eq "$($DisplayName)" `
                            -and $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.AuthenticationMethodsPolicy' `
                    }
                }
            }
            #endregion
            if ($null -eq $getValue)
            {
                Write-Verbose -Message "Could not find an Azure AD Authentication Method Policy with DisplayName {$DisplayName}"
                return $nullResult
            }
        }
        else
        {
            $getValue = $Script:exportedInstance
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Authentication Method Policy with Id {$Id} and DisplayName {$DisplayName} was found."

        #region resource generator code
        $complexRegistrationEnforcement = @{}
        $complexAuthenticationMethodsRegistrationCampaign = @{}
        $complexExcludeTargets = @()
        foreach ($currentExcludeTargets in $getValue.registrationEnforcement.authenticationMethodsRegistrationCampaign.excludeTargets)
        {
            $myExcludeTargets = @{}
            $myExcludeTargets.Add('Id', $currentExcludeTargets.id)
            if ($null -ne $currentExcludeTargets.targetType)
            {
                $myExcludeTargets.Add('TargetType', $currentExcludeTargets.targetType.toString())
            }
            if ($myExcludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexExcludeTargets += $myExcludeTargets
            }
        }
        $complexAuthenticationMethodsRegistrationCampaign.Add('ExcludeTargets', $complexExcludeTargets)
        $complexIncludeTargets = @()
        foreach ($currentIncludeTargets in $getValue.registrationEnforcement.authenticationMethodsRegistrationCampaign.includeTargets)
        {
            $myIncludeTargets = @{}
            $myIncludeTargets.Add('Id', $currentIncludeTargets.id)
            $myIncludeTargets.Add('TargetedAuthenticationMethod', $currentIncludeTargets.targetedAuthenticationMethod)
            if ($null -ne $currentIncludeTargets.targetType)
            {
                $myIncludeTargets.Add('TargetType', $currentIncludeTargets.targetType.toString())
            }
            if ($myIncludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexIncludeTargets += $myIncludeTargets
            }
        }
        $complexAuthenticationMethodsRegistrationCampaign.Add('IncludeTargets', $complexIncludeTargets)
        $complexAuthenticationMethodsRegistrationCampaign.Add('SnoozeDurationInDays', $getValue.registrationEnforcement.authenticationMethodsRegistrationCampaign.snoozeDurationInDays)
        if ($null -ne $getValue.registrationEnforcement.authenticationMethodsRegistrationCampaign.state)
        {
            $complexAuthenticationMethodsRegistrationCampaign.Add('State', $getValue.registrationEnforcement.authenticationMethodsRegistrationCampaign.state.toString())
        }
        if ($complexAuthenticationMethodsRegistrationCampaign.values.Where({ $null -ne $_ }).count -eq 0)
        {
            $complexAuthenticationMethodsRegistrationCampaign = $null
        }
        $complexRegistrationEnforcement.Add('AuthenticationMethodsRegistrationCampaign', $complexAuthenticationMethodsRegistrationCampaign)
        if ($complexRegistrationEnforcement.values.Where({ $null -ne $_ }).count -eq 0)
        {
            $complexRegistrationEnforcement = $null
        }

        $complexReportSuspiciousActivitySettings = @{}
        $newComplexIncludeTarget = @{}
        $newComplexIncludeTarget.Add('Id', $getValue.ReportSuspiciousActivitySettings.IncludeTarget.id)
        if ($null -ne $getValue.ReportSuspiciousActivitySettings.IncludeTarget.targetType)
        {
            $newComplexIncludeTarget.Add('TargetType', $getValue.ReportSuspiciousActivitySettings.IncludeTarget.targetType.toString())
        }
        $complexReportSuspiciousActivitySettings.Add('IncludeTarget', $newComplexIncludeTarget)

        if ($null -ne $getValue.ReportSuspiciousActivitySettings.state)
        {
            $complexReportSuspiciousActivitySettings.Add('State', $getValue.ReportSuspiciousActivitySettings.state.toString())
        }
        if ($null -ne $getValue.ReportSuspiciousActivitySettings.VoiceReportingCode)
        {
            $complexReportSuspiciousActivitySettings.Add('VoiceReportingCode', $getValue.ReportSuspiciousActivitySettings.VoiceReportingCode)
        }
        if ($complexReportSuspiciousActivitySettings.values.Where({ $null -ne $_ }).count -eq 0)
        {
            $complexReportSuspiciousActivitySettings = $null
        }

        $complexSystemCredentialPreferences = @{}
        $complexExcludeTargets = @()
        foreach ($currentExcludeTargets in $getValue.SystemCredentialPreferences.excludeTargets)
        {
            $myExcludeTargets = @{}
            $myExcludeTargets.Add('Id', $currentExcludeTargets.id)
            if ($null -ne $currentExcludeTargets.targetType)
            {
                $myExcludeTargets.Add('TargetType', $currentExcludeTargets.targetType.toString())
            }
            if ($myExcludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexExcludeTargets += $myExcludeTargets
            }
        }
        $complexSystemCredentialPreferences.Add('ExcludeTargets', $complexExcludeTargets)
        $complexIncludeTargets = @()
        foreach ($currentIncludeTargets in $getValue.SystemCredentialPreferences.includeTargets)
        {
            $myIncludeTargets = @{}
            $myIncludeTargets.Add('Id', $currentIncludeTargets.id)
            if ($null -ne $currentIncludeTargets.targetType)
            {
                $myIncludeTargets.Add('TargetType', $currentIncludeTargets.targetType.toString())
            }
            if ($myIncludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexIncludeTargets += $myIncludeTargets
            }
        }
        $complexSystemCredentialPreferences.Add('IncludeTargets', $complexIncludeTargets)
        if ($null -ne $getValue.SystemCredentialPreferences.state)
        {
            $complexSystemCredentialPreferences.Add('State', $getValue.SystemCredentialPreferences.state.toString())
        }
        if ($complexSystemCredentialPreferences.values.Where({ $null -ne $_ }).count -eq 0)
        {
            $complexSystemCredentialPreferences = $null
        }
        #endregion

        #region resource generator code
        $enumPolicyMigrationState = $null
        if ($null -ne $getValue.PolicyMigrationState)
        {
            $enumPolicyMigrationState = $getValue.PolicyMigrationState.ToString()
        }
        #endregion

        $results = @{
            #region resource generator code
            Description                      = $getValue.Description
            DisplayName                      = $getValue.DisplayName
            PolicyMigrationState             = $enumPolicyMigrationState
            PolicyVersion                    = $getValue.PolicyVersion
            ReconfirmationInDays             = $getValue.ReconfirmationInDays
            RegistrationEnforcement          = $complexRegistrationEnforcement
            ReportSuspiciousActivitySettings = $complexReportSuspiciousActivitySettings
            SystemCredentialPreferences      = $complexSystemCredentialPreferences
            Id                               = $getValue.Id
            Ensure                           = 'Present'
            Credential                       = $Credential
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            ApplicationSecret                = $ApplicationSecret
            CertificateThumbprint            = $CertificateThumbprint
            Managedidentity                  = $ManagedIdentity.IsPresent
            AccessTokens                     = $AccessTokens
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
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('preMigration', 'migrationInProgress', 'migrationComplete', 'unknownFutureValue')]
        [System.String]
        $PolicyMigrationState,

        [Parameter()]
        [System.String]
        $PolicyVersion,

        [Parameter()]
        [System.Int32]
        $ReconfirmationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RegistrationEnforcement,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ReportSuspiciousActivitySettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SystemCredentialPreferences,

        [Parameter()]
        [System.String]
        $Id,

        #endregion
        [Parameter()]
        [System.String]
        [ValidateSet('Present')]
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
        Write-Verbose -Message 'Azure AD Authentication Method Policy instance cannot be created'
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Authentication Method Policy with Id {$($currentInstance.Id)}"

        $UpdateParameters = ([Hashtable]$BoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters

        $UpdateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$UpdateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }
        #region resource generator code
        $UpdateParameters.Add('@odata.type', '#microsoft.graph.AuthenticationMethodsPolicy')
        Write-Verbose -Message "Updating AuthenticationMethodPolicy with: `r`n$(Convert-M365DscHashtableToString -Hashtable $UpdateParameters)"
        Update-MgBetaPolicyAuthenticationMethodPolicy -BodyParameter $UpdateParameters
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
        [ValidateSet('preMigration', 'migrationInProgress', 'migrationComplete', 'unknownFutureValue')]
        [System.String]
        $PolicyMigrationState,

        [Parameter()]
        [System.String]
        $PolicyVersion,

        [Parameter()]
        [System.Int32]
        $ReconfirmationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RegistrationEnforcement,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ReportSuspiciousActivitySettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $SystemCredentialPreferences,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        [ValidateSet('Present')]
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

    Write-Verbose -Message "Testing configuration of the Azure AD Authentication Method Policy with Id {$Id} and DisplayName {$DisplayName}"

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
        [array]$getValue = Get-MgBetaPolicyAuthenticationMethodPolicy `
            -ErrorAction Stop | Where-Object -FilterScript { $null -ne $_.DisplayName }
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
                    ManagedIdentity       = $ManagedIdentity.IsPresent
                    AccessTokens          = $AccessTokens
                }

                $Script:exportedInstance = $config
                $Results = Get-TargetResource @Params
                $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                    -Results $Results
                if ($null -ne $Results.RegistrationEnforcement)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'RegistrationEnforcement'
                            CimInstanceName = 'MicrosoftGraphRegistrationEnforcement'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'AuthenticationMethodsRegistrationCampaign'
                            CimInstanceName = 'MicrosoftGraphAuthenticationMethodsRegistrationCampaign'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'ExcludeTargets'
                            CimInstanceName = 'MicrosoftGraphExcludeTarget'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'IncludeTargets'
                            CimInstanceName = 'MicrosoftGraphAuthenticationMethodsRegistrationCampaignIncludeTarget'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.RegistrationEnforcement `
                        -CIMInstanceName 'MicrosoftGraphregistrationEnforcement' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.RegistrationEnforcement = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('RegistrationEnforcement') | Out-Null
                    }
                }

                if ($null -ne $Results.ReportSuspiciousActivitySettings)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'ReportSuspiciousActivitySettings'
                            CimInstanceName = 'MicrosoftGraphReportSuspiciousActivitySettings'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'IncludeTarget'
                            CimInstanceName = 'AADAuthenticationMethodPolicyIncludeTarget'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.ReportSuspiciousActivitySettings `
                        -CIMInstanceName 'MicrosoftGraphreportSuspiciousActivitySettings' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.ReportSuspiciousActivitySettings = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('ReportSuspiciousActivitySettings') | Out-Null
                    }
                }


                if ($null -ne $Results.SystemCredentialPreferences)
                {
                    $complexMapping = @(
                        @{
                            Name            = 'SystemCredentialPreferences'
                            CimInstanceName = 'MicrosoftGraphSystemCredentialPreferences'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'ExcludeTargets'
                            CimInstanceName = 'AADAuthenticationMethodPolicyExcludeTarget'
                            IsRequired      = $False
                        }
                        @{
                            Name            = 'IncludeTargets'
                            CimInstanceName = 'AADAuthenticationMethodPolicyIncludeTarget'
                            IsRequired      = $False
                        }
                    )
                    $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.SystemCredentialPreferences `
                        -CIMInstanceName 'MicrosoftGraphsystemCredentialPreferences' `
                        -ComplexTypeMapping $complexMapping

                    if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                    {
                        $Results.SystemCredentialPreferences = $complexTypeStringResult
                    }
                    else
                    {
                        $Results.Remove('SystemCredentialPreferences') | Out-Null
                    }
                }

                $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                    -ConnectionMode $ConnectionMode `
                    -ModulePath $PSScriptRoot `
                    -Results $Results `
                    -Credential $Credential
                if ($Results.RegistrationEnforcement)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'RegistrationEnforcement' -IsCIMArray:$False
                }
                if ($Results.SystemCredentialPreferences)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'SystemCredentialPreferences' -IsCIMArray:$False
                }

                if ($Results.ReportSuspiciousActivitySettings)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ReportSuspiciousActivitySettings' -IsCIMArray:$False
                }
                $dscContent += $currentDSCBlock
                Save-M365DSCPartialExport -Content $currentDSCBlock `
                    -FileName $Global:PartialExportFileName
            }
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
