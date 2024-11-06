function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ExcludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IncludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OpenIdConnectSetting,

        [Parameter()]
        [ValidateSet('enabled', 'disabled')]
        [System.String]
        $State,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

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

        if (-Not [string]::IsNullOrEmpty($DisplayName))
        {
            if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
            {
                $getValue = $Script:exportedInstances | Where-Object -FilterScript {$_.DisplayName -eq $DisplayName}
            }
            else
            {
                $response = Invoke-MgGraphRequest -Method Get -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/policies/authenticationMethodsPolicy/"
                $getValue = $response.authenticationMethodConfigurations | Where-Object -FilterScript {$_.DisplayName -eq $DisplayName}
            }
        }

        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Authentication Method Policy External with DisplayName {$DisplayName}"
            return $nullResult
        }

        Write-Verbose -Message "An Azure AD Authentication Method Policy External with displayName {$DisplayName} was found."

        #region resource generator code
        $complexExcludeTargets = @()
        foreach ($currentExcludeTargets in $getValue.excludeTargets)
        {
            $myExcludeTargets = @{}
            if ($currentExcludeTargets.id -ne 'all_users'){
                $myExcludeTargetsDisplayName = get-MgGroup -GroupId $currentExcludeTargets.id
                $myExcludeTargets.Add('Id', $myExcludeTargetsDisplayName.DisplayName)
            }
            else{
                $myExcludeTargets.Add('Id', $currentExcludeTargets.id)
            }
            if ($null -ne $currentExcludeTargets.targetType)
            {
                $myExcludeTargets.Add('TargetType', $currentExcludeTargets.targetType.toString())
            }
            if ($myExcludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexExcludeTargets += $myExcludeTargets
            }
        }
        #endregion

        $complexincludeTargets = @()
        foreach ($currentincludeTargets in $getValue.includeTargets)
        {
            $myincludeTargets = @{}
            if ($currentIncludeTargets.id -ne 'all_users'){
                $myIncludeTargetsDisplayName = get-MgGroup -GroupId $currentIncludeTargets.id
                $myIncludeTargets.Add('Id', $myIncludeTargetsDisplayName.DisplayName)
            }
            else{
                $myIncludeTargets.Add('Id', $currentIncludeTargets.id)
            }
            if ($null -ne $currentincludeTargets.targetType)
            {
                $myincludeTargets.Add('TargetType', $currentincludeTargets.targetType.toString())
            }
            if ($myincludeTargets.values.Where({ $null -ne $_ }).count -gt 0)
            {
                $complexincludeTargets += $myincludeTargets
            }
        }

        $complexOpenIdConnectSetting = @{
            clientId = $getValue.OpenIdConnectSetting.ClientId
            discoveryUrl = $getValue.OpenIdConnectSetting.DiscoveryUrl
        }

        #region resource generator code
        $enumState = $null
        if ($null -ne $getValue.State)
        {
            $enumState = $getValue.State.ToString()
        }
        #endregion

        $results = @{
            #region resource generator code
            ExcludeTargets        = $complexExcludeTargets
            IncludeTargets        = $complexincludeTargets
            OpenIdConnectSetting  = $complexOpenIdConnectSetting
            State                 = $enumState
            AppId                 = $getValue.appId
            DisplayName           = $getValue.displayName
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
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ExcludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IncludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OpenIdConnectSetting,

        [Parameter()]
        [ValidateSet('enabled', 'disabled')]
        [System.String]
        $State,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

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
    $params = ([Hashtable]$BoundParameters).clone()
    $params = Rename-M365DSCCimInstanceParameter -Properties $params

    $params = Get-UpdatedTargetProperty($params)

    $params.Add('@odata.type', '#microsoft.graph.externalAuthenticationMethodConfiguration')

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating the Azure AD Authentication Method Policy External with name {$DisplayName}"

        $newobj = New-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -BodyParameter $params

        Write-Verbose -Message "Creating the Azure AD Authentication Method Policy External with name {$($newObj.displayName)}"
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Authentication Method Policy External with name {$($currentInstance.displayName)}"

        $response = Invoke-MgGraphRequest -Method Get -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/policies/authenticationMethodsPolicy/"
        $getValue = $response.authenticationMethodConfigurations | Where-Object -FilterScript {$_.displayName -eq $currentInstance.displayName}

        $params.Remove('displayName') | Out-Null

        Update-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration  `
            -AuthenticationMethodConfigurationId $getValue.Id `
            -BodyParameter $params
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Azure AD Authentication Method Policy External with Id {$($currentInstance.displayName)}"

        $response = Invoke-MgGraphRequest -Method Get -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/policies/authenticationMethodsPolicy/"
        $getValue = $response.authenticationMethodConfigurations | Where-Object -FilterScript {$_.displayName -eq $currentInstance.displayName}

        Remove-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -AuthenticationMethodConfigurationId $getValue.Id
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
        $ExcludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $IncludeTargets,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OpenIdConnectSetting,

        [Parameter()]
        [ValidateSet('enabled', 'disabled')]
        [System.String]
        $State,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

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

    Write-Verbose -Message "Testing configuration of the Azure AD Authentication Method Policy External with Name {$DisplayName}"

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
        $desiredType = "#microsoft.graph.externalAuthenticationMethodConfiguration"
        $getPolicy = Invoke-MgGraphRequest -Method Get -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/policies/authenticationMethodsPolicy/"
        $getValue = $getPolicy.AuthenticationMethodConfigurations | Where-Object -FilterScript {$_.'@odata.type' -eq $desiredType}
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

            $displayedKey = $config.displayName

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
            if ($null -ne $Results.ExcludeTargets)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ExcludeTargets `
                    -CIMInstanceName 'AADAuthenticationMethodPolicyExternalExcludeTarget'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ExcludeTargets = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ExcludeTargets') | Out-Null
                }
            }

            if ($null -ne $Results.IncludeTargets)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.IncludeTargets `
                    -CIMInstanceName 'AADAuthenticationMethodPolicyExternalIncludeTarget'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.IncludeTargets = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('IncludeTargets') | Out-Null
                }
            }

            if ($null -ne $Results.OpenIdConnectSetting)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.OpenIdConnectSetting `
                    -CIMInstanceName 'AADAuthenticationMethodPolicyExternalOpenIdConnectSetting'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.OpenIdConnectSetting = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('OpenIdConnectSetting') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.ExcludeTargets)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ExcludeTargets' -IsCIMArray:$True
            }
            if ($Results.IncludeTargets)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'IncludeTargets' -IsCIMArray:$True
            }
            if ($Results.OpenIdConnectSetting)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'OpenIdConnectSetting' -IsCIMArray:$False
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

function Get-UpdatedTargetProperty
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.Collections.Hashtable]
        $params
    )

    $keys = (([Hashtable]$params).clone()).Keys
    foreach ($key in $keys)
    {
        if ($null -ne $params.$key -and $params.$key.getType().Name -like '*cimInstance*')
        {
            $params.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $params.$key
        }
        if ($key -eq 'IncludeTargets')
        {
            $i = 0
            foreach ($entry in $params.$key){
                if ($entry.id -notmatch '^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$|all_users')
                {
                    $Filter = "Displayname eq '$($entry.id)'" | Out-String
                    $params.$key[$i].foreach('id',(Get-MgGroup -Filter $Filter).id.ToString())
                }
                $i++
            }
        }
        if ($key -eq 'ExcludeTargets')
        {
            $i = 0
            foreach ($entry in $params.$key){
                if ($entry.id -notmatch '^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$|all_users')
                {
                    $Filter = "Displayname eq '$($entry.id)'" | Out-String
                    $params.$key[$i].foreach('id',(Get-MgGroup -Filter $Filter).id.ToString())
                }
                $i++
            }
        }
    }

    return $params
}

Export-ModuleMember -Function *-TargetResource
