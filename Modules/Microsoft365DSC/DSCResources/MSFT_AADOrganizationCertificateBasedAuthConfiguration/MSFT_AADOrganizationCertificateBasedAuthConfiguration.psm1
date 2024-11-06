function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CertificateAuthorities,

        [Parameter()]
        [System.String]
        $OrganizationId,
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

        # This GUID is ALWAYS fixed as per the documentation.
        $CertificateBasedAuthConfigurationId = "29728ade-6ae4-4ee9-9103-412912537da5"
        $getValue = Get-MgBetaOrganizationCertificateBasedAuthConfiguration `
            -CertificateBasedAuthConfigurationId $CertificateBasedAuthConfigurationId `
            -OrganizationId $OrganizationId  -ErrorAction SilentlyContinue

        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Organization Certificate Based Auth Configuration with Id {$Id}."
            return $nullResult
        }

        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Organization Certificate Based Auth Configuration with Id {$Id} was found"

        #region resource generator code
        $complexCertificateAuthorities = @()
        foreach ($currentCertificateAuthorities in $getValue.certificateAuthorities)
        {
            $myCertificateAuthorities = @{}
            $myCertificateAuthorities.Add('Certificate', [System.Convert]::ToBase64String($currentCertificateAuthorities.certificate))
            $myCertificateAuthorities.Add('CertificateRevocationListUrl', $currentCertificateAuthorities.certificateRevocationListUrl)
            $myCertificateAuthorities.Add('DeltaCertificateRevocationListUrl', $currentCertificateAuthorities.deltaCertificateRevocationListUrl)
            $myCertificateAuthorities.Add('IsRootAuthority', $currentCertificateAuthorities.isRootAuthority)
            if ($myCertificateAuthorities.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexCertificateAuthorities += $myCertificateAuthorities
            }
        }
        #endregion

        $results = @{
            #region resource generator code
            CertificateAuthorities = $complexCertificateAuthorities
            OrganizationId         = $OrganizationId
            Ensure                 = 'Present'
            Credential             = $Credential
            ApplicationId          = $ApplicationId
            TenantId               = $TenantId
            ApplicationSecret      = $ApplicationSecret
            CertificateThumbprint  = $CertificateThumbprint
            ManagedIdentity        = $ManagedIdentity.IsPresent
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
        $CertificateAuthorities,

        [Parameter()]
        [System.String]
        $OrganizationId,
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

    # This GUID is ALWAYS fixed as per the documentation.
    $CertificateBasedAuthConfigurationId = "29728ade-6ae4-4ee9-9103-412912537da5"

    # Delete the old configuration
    Write-Verbose -Message "Removing the current Azure AD Organization Certificate Based Auth Configuration."
    Invoke-MgGraphRequest -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/organization/$OrganizationId/certificateBasedAuthConfiguration/$CertificateBasedAuthConfigurationId" -Method DELETE

    if ($Ensure -eq 'Present')
    {
        Write-Verbose -Message "Creating an Azure AD Organization Certificate Based Auth Configuration with Id {$CertificateBasedAuthConfigurationId}"

        $createParameters = ([Hashtable]$BoundParameters).Clone()
        $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters
        $createParameters.Remove('OrganizationId') | Out-Null

        $createCertAuthorities = @()
        foreach ($CertificateAuthority in $CertificateAuthorities)
        {
            $createCertAuthorities += @{
                certificate = $CertificateAuthority.Certificate
                certificateRevocationListUrl = $CertificateAuthority.CertificateRevocationListUrl
                deltaCertificateRevocationListUrl = $CertificateAuthority.DeltaCertificateRevocationListUrl
                isRootAuthority = $CertificateAuthority.IsRootAuthority
            }
        }
        $params = @{
            certificateAuthorities = $createCertAuthorities
        }

        $policy = Invoke-MgGraphRequest -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/organization/$OrganizationId/certificateBasedAuthConfiguration/" -Method POST -Body $params
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
        $CertificateAuthorities,

        [Parameter()]
        [System.String]
        $OrganizationId,
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

    # This GUID is ALWAYS fixed as per the documentation.
    $CertificateBasedAuthConfigurationId = "29728ade-6ae4-4ee9-9103-412912537da5"

    Write-Verbose -Message "Testing configuration of the Azure AD Organization Certificate Based Auth Configuration with Id {$CertificateBasedAuthConfigurationId}"

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
        # This GUID is ALWAYS fixed as per the documentation.
        $CertificateBasedAuthConfigurationId = "29728ade-6ae4-4ee9-9103-412912537da5"
        $getValue = Get-MgBetaOrganization

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
            $displayedKey = "CertificateBasedAuthConfigurations for $($getValue.DisplayName)"
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Ensure = 'Present'
                OrganizationId = $getValue.Id
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
            if ($null -ne $Results.CertificateAuthorities)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.CertificateAuthorities `
                    -CIMInstanceName 'MicrosoftGraphcertificateAuthority'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.CertificateAuthorities = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('CertificateAuthorities') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.CertificateAuthorities)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "CertificateAuthorities" -IsCIMArray:$True
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
