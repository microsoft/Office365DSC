function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.onTokenIssuanceStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension'
        )]
        $CustomAuthenticationExtensionType,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.azureAdTokenAuthentication',
            '#microsoft.graph.azureAdPopTokenAuthentication'
        )]
        $AuthenticationConfigurationType,

        [Parameter()]
        [System.String]
        $AuthenticationConfigurationResourceId,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationTimeoutMilliseconds,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationMaximumRetries,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EndPointConfiguration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ClaimsForTokenConfiguration,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present'
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
    Write-Verbose -Message "Fetching result...."
    try
    {
        # check for export.
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            # check with Id first
            if (-not [System.String]::IsNullOrEmpty($Id))
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Id -eq $Id}
            }

            # check with display name next.
            if ($null -eq $instance)
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.DisplayName -eq $DisplayName}
            }
        }
        else
        {
            if (-not [System.String]::IsNullOrEmpty($Id))
            {
                $instance = Get-MgBetaIdentityCustomAuthenticationExtension -CustomAuthenticationExtensionId $Id `
                                                                                 -ErrorAction SilentlyContinue
            }
            if ($null -eq $instance)
            {
                $instance = Get-MgBetaIdentityCustomAuthenticationExtension -Filter "DisplayName eq '$DisplayName'" `
                                                                                 -ErrorAction SilentlyContinue
            }
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        Write-Verbose "Instance found for the resource. Calculating result...."

        $results = @{
            DisplayName = $instance.DisplayName
            Id          = $instance.Id
            Description = $instance.Description
            Ensure      = 'Present'
        }

        if ($instance.AdditionalProperties -ne $null)
        {
            $results.Add('CustomAuthenticationExtensionType', $instance.AdditionalProperties["@odata.type"])
        }

        if ($instance.AuthenticationConfiguration -ne $null)
        {
            $results.Add('AuthenticationConfigurationType', $instance.AuthenticationConfiguration["@odata.type"])
            $results.Add('AuthenticationConfigurationResourceId', $instance.AuthenticationConfiguration["resourceId"])
        }

        if ($instance.ClientConfiguration -ne $null)
        {
            $results.Add('ClientConfigurationTimeoutMilliseconds', $instance.ClientConfiguration.TimeoutInMilliseconds)
            $results.Add('ClientConfigurationMaximumRetries', $instance.ClientConfiguration.MaximumRetries)
        }

        $endpointConfigurationInstance = @{}
        if ($instance.EndPointConfiguration -ne $null -and $instance.EndPointConfiguration.AdditionalProperties -ne $null)
        {
            $endpointConfigurationInstance.Add("EndpointType", $instance.EndPointConfiguration.AdditionalProperties["@odata.type"])

            if ($endpointConfigurationInstance["EndpointType"] -eq '#microsoft.graph.httpRequestEndpoint')
            {
                $endpointConfigurationInstance.Add("TargetUrl", $instance.EndPointConfiguration.AdditionalProperties["targetUrl"])
            }

            if ($endpointConfigurationInstance["EndpointType"] -eq '#microsoft.graph.logicAppTriggerEndpointConfiguration')
            {
                $endpointConfigurationInstance.Add("SubscriptionId", $instance.EndPointConfiguration.AdditionalProperties["subscriptionId"])
                $endpointConfigurationInstance.Add("ResourceGroupName", $instance.EndPointConfiguration.AdditionalProperties["resourceGroupName"])
                $endpointConfigurationInstance.Add("LogicAppWorkflowName", $instance.EndPointConfiguration.AdditionalProperties["logicAppWorkflowName"])
            }
        }

        $ClaimsForTokenConfigurationInstance = @()
        if ($instance.AdditionalProperties -ne $null -and $instance.AdditionalProperties["claimsForTokenConfiguration"] -ne $null)
        {
            foreach ($claim in $instance.AdditionalProperties["claimsForTokenConfiguration"])
            {
                $c = @{
                    ClaimIdInApiResponse = $claim.claimIdInApiResponse
                }

                $ClaimsForTokenConfigurationInstance += $c
            }
        }

        $results.Add('EndPointConfiguration', $endpointConfigurationInstance)
        $results.Add('ClaimsForTokenConfiguration', $ClaimsForTokenConfigurationInstance)

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
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.onTokenIssuanceStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension'
        )]
        $CustomAuthenticationExtensionType,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.azureAdTokenAuthentication',
            '#microsoft.graph.azureAdPopTokenAuthentication'
        )]
        $AuthenticationConfigurationType,

        [Parameter()]
        [System.String]
        $AuthenticationConfigurationResourceId,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationTimeoutMilliseconds,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationMaximumRetries,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EndPointConfiguration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ClaimsForTokenConfiguration,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present'
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

    $params = @{
        "@odata.type" = $setParameters.CustomAuthenticationExtensionType
        displayName = $setParameters.DisplayName
        description = $setParameters.Description
        endpointConfiguration = @{
            "@odata.type" = $setParameters.EndPointConfiguration.EndpointType
        }
        authenticationConfiguration = @{
            "@odata.type" = $setParameters.AuthenticationConfigurationType
            resourceId = $setParameters.AuthenticationConfigurationResourceId
        }
        clientConfiguration = @{
            timeoutInMilliseconds = $setParameters["ClientConfigurationTimeoutMilliseconds"]
            maximumRetries = $setParameters["ClientConfigurationMaximumRetries"]
        }
    }

    if ($params.endpointConfiguration["@odata.type"] -eq "#microsoft.graph.httpRequestEndpoint")
    {
        Write-Verbose -Message "{$setParameters.EndPointConfiguration.TargetUrl}"
        $params.endpointConfiguration["targetUrl"] = $setParameters.EndPointConfiguration.TargetUrl
    }

    if ($params.endpointConfiguration["@odata.type"] -eq "#microsoft.graph.logicAppTriggerEndpointConfiguration")
    {
        $params.endpointConfiguration["subscriptionId"] = $setParameters.EndPointConfiguration["SubscriptionId"]
        $params.endpointConfiguration["resourceGroupName"] = $setParameters.EndPointConfiguration["ResourceGroupName"]
        $params.endpointConfiguration["logicAppWorkflowName"] = $setParameters.EndPointConfiguration["LogicAppWorkflowName"]
    }

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $params.Add("claimsForTokenConfiguration", @())
        foreach ($claim in $setParameters.claimsForTokenConfiguration)
        {
            $val = $claim.claimIdInApiResponse
            Write-Verbose -Message "{$val}"
            $c = @{
                "claimIdInApiResponse" = $claim.claimIdInApiResponse
            }

            $params.claimsForTokenConfiguration += $c
        }

        $params.Remove('Id') | Out-Null
        $type = $params["@odata.type"]
        Write-Verbose -Message "Creating new Custom authentication extension with display name {$DisplayName} and type {$type}"
        New-MgBetaIdentityCustomAuthenticationExtension -BodyParameter $params
    }

    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating custom authentication extension {$DisplayName}"
        $params.Add('CustomAuthenticationExtensionId', $currentInstance.Id)
        $params.Remove('Id') | Out-Null

        $params.Add("AdditionalProperties", @{})
        $params["AdditionalProperties"].Add("ClaimsForTokenConfiguration", @())

        foreach ($claim in $setParameters["ClaimsForTokenConfiguration"])
        {
            $c = @{
                "claimIdInApiResponse" = $claim["ClaimIdInApiResponse"]
            }

            $params["AdditionalProperties"]["claimsForTokenConfiguration"] += $c
        }

        Write-Verbose -Message "{$params['@odata.type']}"
        Update-MgBetaIdentityCustomAuthenticationExtension -CustomAuthenticationExtensionId $Id -BodyParameter $params
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing custom authentication extension {$DisplayName}."
        Remove-MgBetaIdentityCustomAuthenticationExtension -CustomAuthenticationExtensionId $currentInstance.Id
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
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.onTokenIssuanceStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension',
            '#microsoft.graph.onAttributeCollectionStartCustomExtension'
        )]
        $CustomAuthenticationExtensionType,

        [Parameter()]
        [System.String]
        [ValidateSet(
            '#microsoft.graph.azureAdTokenAuthentication',
            '#microsoft.graph.azureAdPopTokenAuthentication'
        )]
        $AuthenticationConfigurationType,

        [Parameter()]
        [System.String]
        $AuthenticationConfigurationResourceId,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationTimeoutMilliseconds,

        [Parameter()]
        [System.Int32]
        $ClientConfigurationMaximumRetries,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $EndPointConfiguration,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ClaimsForTokenConfiguration,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present'
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
                Write-Verbose "TestResult returned False for $source"
                $testTargetResource = $false
            }
            else {
                $ValuesToCheck.Remove($key) | Out-Null
            }
        }
    }

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
        [array] $Script:exportedInstances = Get-MgBetaIdentityCustomAuthenticationExtension -ErrorAction Stop

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
                DisplayName           = $config.DisplayName
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params

            $endpointConfigurationCimString = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.EndpointConfiguration `
                        -CIMInstanceName 'MSFT_AADCustomAuthenticationExtensionEndPointConfiguration'

            $ClaimsForTokenConfigurationCimString = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.ClaimsForTokenConfiguration `
                        -CIMInstanceName 'MSFT_AADCustomAuthenticationExtensionClaimForTokenConfiguration'

            $Results.EndPointConfiguration = $endpointConfigurationCimString
            $Results.ClaimsForTokenConfiguration = $ClaimsForTokenConfigurationCimString

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($Results.EndPointConfiguration -ne $null)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "EndPointConfiguration"
            }

            if ($Results.ClaimsForTokenConfiguration -ne $null)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ClaimsForTokenConfiguration" -IsCIMArray $true
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
