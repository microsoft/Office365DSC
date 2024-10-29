function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String]
        $id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $linkedDomainUrl,

        [Parameter()]
        [System.String]
        $authorityId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $name,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $displays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $rules,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'AdminAPI' `
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
    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instances = $Script:exportedInstances
        }
        else
        {
            $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities"
            $response = Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'GET'
            $authorities = $response.value
            if ($null -eq $authorities)
            {
                return $nullResult
            }
            $authority = Get-M365DSCVerifiedIdAuthorityObject -Authority ($authorities | Where-Object -FilterScript {$_.didModel.linkedDomainUrls[0] -eq $linkedDomainUrl})

            if ($null -eq $authority)
            {
                return $nullResult
            }

            $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities/$($authority.Id)/contracts"
            $response = Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'GET'
            $contracts = $response.value
        }
        if ($null -eq $contracts)
        {
            return $nullResult
        }

        $contract = Get-M365DSCVerifiedIdAuthorityContractObject -Contract ($contracts | Where-Object -FilterScript {$_.name -eq $name})
        if ($null -eq $contract)
        {
            return $nullResult
        }

        $results = @{
            id                                                                    = $contract.id
            name                                                                  = $contract.name
            linkedDomainUrl                                                       = $linkedDomainUrl
            authorityId                                                           = $authority.Id
            displays                                                              = $contract.displays
            rules                                                                 = $contract.rules
            Ensure                                                                = 'Present'
            Credential                                                            = $Credential
            ApplicationId                                                         = $ApplicationId
            TenantId                                                              = $TenantId
            CertificateThumbprint                                                 = $CertificateThumbprint
            ApplicationSecret                                                     = $ApplicationSecret
            AccessTokens                                                          = $AccessTokens
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
        [Parameter()]
        [System.String]
        $id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $linkedDomainUrl,

        [Parameter()]
        [System.String]
        $authorityId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $name,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $displays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $rules,

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

    New-M365DSCConnection -Workload 'AdminAPI' `
        -InboundParameters $PSBoundParameters | Out-Null

    $currentInstance = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Retrieved current instance: $($currentInstance.Name) with Id $($currentInstance.Id)"
    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    $rulesHashmap = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $rules
    $displaysHashmap = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $displays
    if($rulesHashmap.attestations.idTokens -ne $null)
    {
        foreach($idToken in $rulesHashmap.attestations.idTokens)
        {
            if($idToken.scopeValue -ne $null)
            {
                $idToken.Add('scope', $idToken.scopeValue)
                $idToken.Remove('scopeValue') | Out-Null
            }
        }

    }

    $body = @{
        name = $Name
        rules = $rulesHashmap
        displays = $displaysHashmap
    }
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities"
        $response = Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'GET'
        $authorities = $response.value
        $authority = Get-M365DSCVerifiedIdAuthorityObject -Authority ($authorities | Where-Object -FilterScript {$_.didModel.linkedDomainUrls[0] -eq $linkedDomainUrl})

        Write-Verbose -Message "Creating an VerifiedId Authority Contract with Name {$name} for Authority Id $($authority.Id)"

        $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities/$($authority.Id)/contracts"
        Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'POST' -Body $body
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating an VerifiedId Authority Contract with Name {$name} for Authority Id $($authority.Id)"
        $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities/$($authority.Id)/contracts/$($currentInstance.id)"
        $body.Remove('name') | Out-Null
        Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'PATCH' -Body $body
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Warning -Message "Removal of Contracts is not supported"
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
        $id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $linkedDomainUrl,

        [Parameter()]
        [System.String]
        $authorityId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $name,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $displays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $rules,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message 'Testing configuration of AADVerifiedIdAuthorityContract'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    $testTargetResource = $true

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
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
    -Source $($MyInvocation.MyCommand.Source) `
    -DesiredValues $PSBoundParameters `
    -ValuesToCheck $ValuesToCheck.Keys `
    -IncludedDrifts $driftedParams

    if(-not $TestResult)
    {
        $testTargetResource = $false
    }


    Write-Verbose -Message "Test-TargetResource returned $testTargetResource"

    return $testTargetResource


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

    $ConnectionMode = New-M365DSCConnection -Workload 'AdminAPI' `
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

    $dscContent = [System.Text.StringBuilder]::new()
    $i = 1
    Write-Host "`r`n" -NoNewline
    try
    {
        $Script:ExportMode = $true
        $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities"
        $response = Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'GET'
        [array] $authorities = $response.value


        [array] $Script:exportedInstances = $()

        foreach ($authority in $authorities)
        {
            $uri = "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities/$($authority.Id)/contracts"
            $response = Invoke-M365DSCVerifiedIdWebRequest -Uri $uri -Method 'GET'
            $contracts = $response.value

            foreach($contract in $contracts)
            {
                $Script:exportedInstances += $contract

                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($contract.name)" -NoNewline
                $Params = @{
                    linkedDomainUrl       = $authority.didModel.linkedDomainUrls[0]
                    name                  = $contract.name
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    ApplicationSecret     = $ApplicationSecret
                    Credential            = $Credential
                    Managedidentity       = $ManagedIdentity.IsPresent
                    AccessTokens          = $AccessTokens
                }

                $Results = Get-TargetResource @Params

                if ($Results.Ensure -eq 'Present')
                {
                    $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                    -Results $Results

                    if ($null -ne $Results.displays)
                    {
                        $complexMapping = @(
                            @{
                                Name = 'displays'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractDisplayModel'
                                IsRequired = $False
                            }
                            @{
                                Name = 'logo'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractDisplayCredentialLogo'
                                IsRequired = $False
                            }
                            @{
                                Name = 'card'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractDisplayCard'
                                IsRequired = $False
                            }
                            @{
                                Name = 'consent'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractDisplayConsent'
                                IsRequired = $False
                            }
                            @{
                                Name = 'claims'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractDisplayClaims'
                                IsRequired = $False
                            }
                        )
                        $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.displays `
                        -CIMInstanceName 'AADVerifiedIdAuthorityContractDisplayModel' `
                        -ComplexTypeMapping $complexMapping

                        if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                        {
                            $Results.displays = $complexTypeStringResult
                        }
                        else
                        {
                            $Results.Remove('displays') | Out-Null
                        }
                    }


                    if ($null -ne $Results.rules)
                    {
                        $complexMapping = @(
                            @{
                                Name = 'rules'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractRulesModel'
                                IsRequired = $False
                            }
                            @{
                                Name = 'attestations'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestations'
                                IsRequired = $False
                            }
                            @{
                                Name = 'vc'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractVcType'
                                IsRequired = $False
                            }
                            @{
                                Name = 'customStatusEndpoint'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractCustomStatusEndpoint'
                                IsRequired = $False
                            }
                            @{
                                Name = 'idTokenHints'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestationValues'
                                IsRequired = $False
                            }
                            @{
                                Name = 'idTokens'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestationValues'
                                IsRequired = $False
                            }
                            @{
                                Name = 'presentations'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestationValues'
                                IsRequired = $False
                            }
                            @{
                                Name = 'selfIssued'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestationValues'
                                IsRequired = $False
                            }
                            @{
                                Name = 'accessTokens'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractAttestationValues'
                                IsRequired = $False
                            }
                            @{
                                Name = 'mapping'
                                CimInstanceName = 'AADVerifiedIdAuthorityContractClaimMapping'
                                IsRequired = $False
                            }
                        )
                        $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $Results.rules`
                        -CIMInstanceName 'AADVerifiedIdAuthorityContractRulesModel' `
                        -ComplexTypeMapping $complexMapping

                        if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                        {
                            $Results.rules = $complexTypeStringResult
                        }
                        else
                        {
                            $Results.Remove('rules') | Out-Null
                        }
                    }


                    $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                    -ConnectionMode $ConnectionMode `
                    -ModulePath $PSScriptRoot `
                    -Results $Results `
                    -Credential $Credential

                    if ($Results.displays)
                    {
                        $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "displays" -IsCIMArray:$true
                    }

                    if ($Results.rules)
                    {
                        $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "rules" -IsCIMArray:$false
                    }

                    $dscContent.Append($currentDSCBlock) | Out-Null
                    Save-M365DSCPartialExport -Content $currentDSCBlock `
                    -FileName $Global:PartialExportFileName
                    Write-Host $Global:M365DSCEmojiGreenCheckMark
                    $i++
                }
            }
        }
        return $dscContent.ToString()
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


function Get-M365DSCVerifiedIdAuthorityContractObject
{
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter()]
        $Contract
    )

    if ($null -eq $Contract)
    {
        return $null
    }

    Write-Verbose -Message "Retrieving values for contract {$($Contract.name)}"
    $values = @{
        id                 = $Contract.id
        name               = $Contract.name
    }
    if ($null -ne $Contract.displays)
    {
        $displays = @()
        foreach ($display in $Contract.displays)
        {
            $claims = @()
            foreach ($claim in $display.claims)
            {
                $claims += @{
                    claim = $claim.claim
                    label = $claim.label
                    type = $claim.type
                }
            }
            $displays += @{
                locale = $display.locale
                card = @{
                    title = $display.card.title
                    issuedBy = $display.card.issuedBy
                    backgroundColor = $display.card.backgroundColor
                    textColor = $display.card.textColor
                    logo = @{
                        uri = $display.card.logo.uri
                        description = $display.card.logo.description
                    }
                    description = $display.card.description
                }
                consent = @{
                    title = $display.consent.title
                    instructions = $display.consent.instructions
                }
                claims = $claims
            }
        }

        $values.Add('displays', $displays)
    }


    if ($null -ne $Contract.rules)
    {
        $rules = @{}
        $attestations = @{}
        if($null -ne $Contract.rules.attestations.idTokenHints)
        {
            $idTokenHints = @()
            foreach($idTokenHint in $Contract.rules.attestations.idTokenHints)
            {
                $mapping = @()
                foreach($map in $idTokenHint.mapping)
                {
                    $mapping += @{
                        outputClaim = $map.outputClaim
                        inputClaim = $map.inputClaim
                        required = $map.required
                        indexed = $map.indexed
                        type = $map.type
                    }
                }
                $idTokenHints += @{
                    required = $idTokenHint.required
                    mapping = $mapping
                    trustedIssuers = $idTokenHint.trustedIssuers
                }
            }
            $attestations.Add('idTokenHints', $idTokenHints)
        }

        if($null -ne $Contract.rules.attestations.idTokens)
        {
            $idTokens = @()
            foreach($idToken in $Contract.rules.attestations.idTokens)
            {
                $mapping = @()
                foreach($map in $idToken.mapping)
                {
                    $mapping += @{
                        outputClaim = $map.outputClaim
                        inputClaim = $map.inputClaim
                        required = $map.required
                        indexed = $map.indexed
                        type = $map.type
                    }
                }
                $idTokens += @{
                    required = $idToken.required
                    mapping = $mapping
                    configuration = $idToken.configuration
                    clientId = $idToken.clientId
                    redirectUri = $idToken.redirectUri
                    scopeValue = $idToken.scope
                }
            }
            $attestations.Add('idTokens', $idTokens)
        }

        if($null -ne $Contract.rules.attestations.presentations)
        {
            $presentations = @()
            foreach($presentation in $Contract.rules.attestations.presentations)
            {
                $mapping = @()
                foreach($map in $presentation.mapping)
                {
                    $mapping += @{
                        outputClaim = $map.outputClaim
                        inputClaim = $map.inputClaim
                        required = $map.required
                        indexed = $map.indexed
                        type = $map.type
                    }
                }
                $presentations += @{
                    required = $presentation.required
                    mapping = $mapping
                    trustedIssuers = $presentation.trustedIssuers
                    credentialType = $presentation.credentialType
                }
            }
            $attestations.Add('presentations', $presentations)
        }

        if($null -ne $Contract.rules.attestations.selfIssued)
        {
            $mySelfIssueds = @()
            foreach($mySelfIssued in $Contract.rules.attestations.selfIssued)
            {
                $mapping = @()
                foreach($map in $mySelfIssued.mapping)
                {
                    $mapping += @{
                        outputClaim = $map.outputClaim
                        inputClaim = $map.inputClaim
                        required = $map.required
                        indexed = $map.indexed
                        type = $map.type
                    }
                }
                $mySelfIssueds += @{
                    required = $mySelfIssued.required
                    mapping = $mapping
                }
            }
            $attestations.Add('selfIssued', $mySelfIssueds)
        }

        if($null -ne $Contract.rules.attestations.accessTokens)
        {
            $accessTokens = @()
            foreach($accessToken in $Contract.rules.attestations.accessTokens)
            {
                $mapping = @()
                foreach($map in $accessToken.mapping)
                {
                    $mapping += @{
                        outputClaim = $map.outputClaim
                        inputClaim = $map.inputClaim
                        required = $map.required
                        indexed = $map.indexed
                        type = $map.type
                    }
                }
                $accessTokens += @{
                    required = $accessToken.required
                    mapping = $mapping
                }
            }
            $attestations.Add('accessTokens', $accessTokens)
        }


        $rules.Add('attestations', $attestations)
        $rules.Add('vc', @{
            type = $Contract.rules.vc.type
        })
        $rules.Add('validityInterval', $Contract.rules.validityInterval)

        $values.Add('rules', $rules)
    }

    return $values
}


function Get-M365DSCVerifiedIdAuthorityObject
{
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter()]
        $Authority
    )

    if ($null -eq $Authority)
    {
        return $null
    }

    Write-Verbose -Message "Retrieving values for authority {$($Authority.didModel.linkedDomainUrls[0])}"
    $did = ($Authority.didModel.did -split ":")[1]
    $values = @{
        Id                 = $Authority.Id
        Name               = $Authority.Name
        LinkedDomainUrl    = $Authority.didModel.linkedDomainUrls[0]
        DidMethod          = $did
    }
    if ($null -ne $Authority.KeyVaultMetadata)
    {
        $KeyVaultMetadata = @{
            SubscriptionId = $Authority.KeyVaultMetadata.SubscriptionId
            ResourceGroup = $Authority.KeyVaultMetadata.ResourceGroup
            ResourceName = $Authority.KeyVaultMetadata.ResourceName
            ResourceUrl = $Authority.KeyVaultMetadata.ResourceUrl
        }

        $values.Add('KeyVaultMetadata', $KeyVaultMetadata)
    }
    return $values
}

function Invoke-M365DSCVerifiedIdWebRequest
{
    [OutputType([PSCustomObject])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $Uri,

        [Parameter()]
        [System.String]
        $Method = 'GET',

        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    $headers = @{
        Authorization = $Global:MSCloudLoginConnectionProfile.AdminAPI.AccessToken
        "Content-Type" = "application/json"
    }

    if($Method -eq 'PATCH' -or $Method -eq 'POST')
    {
        $BodyJson = $body | ConvertTo-Json -Depth 10
        $response = Invoke-WebRequest -Method $Method -Uri $Uri -Headers $headers -Body $BodyJson
    }
    else {
        $response = Invoke-WebRequest -Method $Method -Uri $Uri -Headers $headers 
    }

    if($Method -eq 'DELETE')
    {
        return $null
    }
    $result = ConvertFrom-Json $response.Content
    return $result
}

Export-ModuleMember -Function *-TargetResource
