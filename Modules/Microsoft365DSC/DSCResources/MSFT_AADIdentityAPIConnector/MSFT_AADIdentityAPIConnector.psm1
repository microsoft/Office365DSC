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
        $TargetUrl,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Username,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Password,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Certificates,

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
        $getValue = Get-MgBetaIdentityAPIConnector -IdentityApiConnectorId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Identity A P I Connector with Id {$Id}"

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaIdentityAPIConnector `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue 
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Identity API Connector with DisplayName {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Identity API Connector with Id {$Id} and DisplayName {$DisplayName} was found"

        #region resource generator code
        $complexAuthenticationConfiguration = @{}

        if($null -ne $getValue.AuthenticationConfiguration.AdditionalProperties.password) {
            $securePassword = ConvertTo-SecureString $getValue.AuthenticationConfiguration.AdditionalProperties.password -AsPlainText -Force

            $Password = New-Object System.Management.Automation.PSCredential ('Password', $securePassword)
        }


        $complexCertificates = @()
        foreach ($currentCertificate in $getValue.AuthenticationConfiguration.AdditionalProperties.certificateList)
        {
            $myCertificate= @{}
            $myCertificate.Add('Pkcs12Value', "Please insert a valid Pkcs12Value")
            $myCertificate.Add('Thumbprint', $currentCertificate.thumbprint)
            $myCertificate.Add('Password', "Please insert a valid Password for the certificate")
            $myCertificate.Add('IsActive', $currentCertificate.isActive)

            if ($myCertificate.values.Where({$null -ne $_}).Count -gt 0)
            {
                $complexCertificates += $myCertificate
            }
        }
        #endregion

        $results = @{
            #region resource generator code
            DisplayName                 = $getValue.DisplayName
            TargetUrl                   = $getValue.TargetUrl
            Id                          = $getValue.Id
            Username                    = $getValue.AuthenticationConfiguration.AdditionalProperties.username
            Password                    = $Password
            Certificates                = $complexCertificates
            Ensure                      = 'Present'
            Credential                  = $Credential
            ApplicationId               = $ApplicationId
            TenantId                    = $TenantId
            ApplicationSecret           = $ApplicationSecret
            CertificateThumbprint       = $CertificateThumbprint
            ManagedIdentity             = $ManagedIdentity.IsPresent
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
        $TargetUrl,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Username,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Password,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Certificates,

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

    # If the certificates array is not empty, then we need to create a new instance of New-MgBetaAADIdentityAPIConnector

    $needToUpdateCertificates = $false
    if($null -ne $Certificates -and $Certificates.Count -gt 0) {
        $needToUpdateCertificates = $true
    }

    if($needToUpdateCertificates -eq $false) {
        if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
        {
            Write-Verbose -Message "Creating an Azure AD Identity API Connector with DisplayName {$DisplayName}"

            $createParameters = ([Hashtable]$BoundParameters).Clone()
            $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters
            $createParameters.Remove('Id') | Out-Null

            $createParameters.Remove('Password') | Out-Null
            $createParameters.Remove('Pkcs12Value') | Out-Null

            if($username -ne $null) {
                $createParameters.Add("AuthenticationConfiguration", @{
                    '@odata.type' = "microsoft.graph.basicAuthentication"
                    "password" = $Password.GetNetworkCredential().Password
                    "username" = $Username
                })
            }

            $createParameters.Add("@odata.type", "#microsoft.graph.IdentityApiConnector")
            $policy = New-MgBetaIdentityAPIConnector -BodyParameter $createParameters
        }
        elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
        {
            Write-Verbose -Message "Updating the Azure AD Identity API Connector with Id {$($currentInstance.Id)}"

            $updateParameters = ([Hashtable]$BoundParameters).Clone()
            $updateParameters = Rename-M365DSCCimInstanceParameter -Properties $updateParameters

            $updateParameters.Remove('Id') | Out-Null

            $updateParameters.Remove('Password') | Out-Null
            $updateParameters.Remove('Pkcs12Value') | Out-Null

            $updateParameters.Add("AuthenticationConfiguration", @{
                '@odata.type' = "microsoft.graph.basicAuthentication"
                "password" = $Password.GetNetworkCredential().Password
                "username" = $Username
            })

            $UpdateParameters.Add("@odata.type", "#microsoft.graph.IdentityApiConnector")
            Update-MgBetaIdentityAPIConnector `
            -IdentityApiConnectorId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        }
        elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
        {
            Write-Verbose -Message "Removing the Azure AD Identity API Connector with Id {$($currentInstance.Id)}"
            Remove-MgBetaIdentityAPIConnector -IdentityApiConnectorId $currentInstance.Id
        }
    }
    else {

        # Remove the existing instance if already present
        if($currentInstance.Ensure -ne 'Absent') {
            Write-Verbose -Message "Removing the Azure AD Identity API Connector with Id {$($currentInstance.Id)}"
            Remove-MgBetaIdentityAPIConnector -IdentityApiConnectorId $currentInstance.Id
        }

        # Create a new instance with the certificates
        Write-Verbose -Message "Creating an Azure AD Identity API Connector with DisplayName {$DisplayName}"

        $createParameters = ([Hashtable]$BoundParameters).Clone()
        $createParameters = Rename-M365DSCCimInstanceParameter -Properties $createParameters
        $createParameters.Remove('Id') | Out-Null

        $createParameters.Remove('Password') | Out-Null
        $createParameters.Remove('Pkcs12Value') | Out-Null

        # Get the active and inactive certificates
        $activeCertificates = @()
        $inactiveCertificates = @()
        foreach ($currentCertificate in $Certificates)
        {
            $myCertificate = @{}
            $myCertificate.Add('Pkcs12Value', ($currentCertificate.Pkcs12Value).Password)
            $myCertificate.Add('Password', ($currentCertificate.Password).Password)

            if($currentCertificate.IsActive -eq $true) {
                $activeCertificates += $myCertificate
            }
            else {
                $inactiveCertificates += $myCertificate
            }
        }

        # Only one certificate can be active
        if($activeCertificates.Count -ne 1) {
            Write-Error "There should be one active certificate"
            throw
        }
        
        if($inactiveCertificates.Count -eq 0) {
            $createParameters.Add("AuthenticationConfiguration", @{
                '@odata.type' = "microsoft.graph.pkcs12Certificate"
                "password" = $activeCertificates[0].Password
                "pkcs12Value" = $activeCertificates[0].Pkcs12Value
            })
            $activeCertificates = $activeCertificates[1..$activeCertificates.Count]
        }
        else {
            $createParameters.Add("AuthenticationConfiguration", @{
                '@odata.type' = "microsoft.graph.pkcs12Certificate"
                "password" = $inactiveCertificates[0].Password
                "pkcs12Value" = $inactiveCertificates[0].Pkcs12Value
            })
            # remove the first element from the inactive certificates
            $inactiveCertificates = $inactiveCertificates[1..$inactiveCertificates.Count]
        }

        $createParameters.Add("@odata.type", "#microsoft.graph.IdentityApiConnector")
        $policy = New-MgBetaIdentityAPIConnector -BodyParameter $createParameters


        # Upload the inactive certificates
        foreach ($currentCertificate in $inactiveCertificates)
        {
            $params = @{
                pkcs12Value = $currentCertificate.Pkcs12Value
                password = $currentCertificate.Password
            }

            Invoke-MgBetaUploadIdentityApiConnectorClientCertificate -IdentityApiConnectorId $policy.Id -BodyParameter $params
        }

        # Upload active certificate
        foreach ($currentCertificate in $activeCertificates)
        {
            $params = @{
                pkcs12Value = $currentCertificate.Pkcs12Value
                password = $currentCertificate.Password
            }

            Invoke-MgBetaUploadIdentityApiConnectorClientCertificate -IdentityApiConnectorId $policy.Id -BodyParameter $params
        }

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
        $TargetUrl,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Username,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Password,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Certificates,

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

    Write-Verbose -Message "Testing configuration of the Azure AD Identity A P I Connector with Id {$Id} and DisplayName {$DisplayName}"

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
            
            # create a list of thumbprints from the source list
            $sourceThumbprints = @()
            foreach ($item in $source)
            {
                $myCertificate = @{}
                $myCertificate.Add('Thumbprint', $item.Thumbprint)
                $myCertificate.Add('IsActive', $item.IsActive)
                $sourceThumbprints += $myCertificate
            }

            # create a list of thumbprints from the target list
            $targetThumbprints = @()
            foreach ($item in $target)
            {
                $myCertificate = @{}
                $myCertificate.Add('Thumbprint', $item.Thumbprint)
                $myCertificate.Add('IsActive', $item.IsActive)
                $targetThumbprints += $myCertificate
            }
            # sort the lists
            $sourceThumbprints = $sourceThumbprints | Sort-Object -Property { $_.Thumbprint }
            $targetThumbprints = $targetThumbprints | Sort-Object -Property { $_.Thumbprint }

            # print the list in verbose logs
            foreach ($item in $sourceThumbprints)
            {
                Write-Verbose -Message "Source Thumbprints: $(Convert-M365DscHashtableToString -Hashtable $item)"
            }

            foreach ($item in $targetThumbprints)
            {
                Write-Verbose -Message "Target Thumbprints: $(Convert-M365DscHashtableToString -Hashtable $item)"
            }
            
            # check if the lists are identical
            $compareResult = $true
            if ($sourceThumbprints.Count -ne $targetThumbprints.Count)
            {
                $compareResult = $false
            }
            else
            {
                for ($i = 0; $i -lt $sourceThumbprints.Count; $i++)
                {
                    if ($sourceThumbprints[$i].Thumbprint -ne $targetThumbprints[$i].Thumbprint)
                    {
                        $compareResult = $false
                        Write-Verbose -Message "Thumbprint mismatch: $($sourceThumbprints[$i].Thumbprint) - $($targetThumbprints[$i].Thumbprint)"
                        break
                    }
                }
            }

            if($compareResult -eq $true)
            {
                $ValuesToCheck.Remove($key) | Out-Null
            }
        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck.Remove('Password') | Out-Null
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
        #region resource generator code
        [array]$getValue = Get-MgBetaIdentityAPIConnector `
            -Filter $Filter `
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
            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            elseif (-not [string]::IsNullOrEmpty($config.name))
            {
                $displayedKey = $config.name
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                DisplayName           =  $config.DisplayName
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity = $ManagedIdentity.IsPresent
                AccessTokens = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results.Password = "Please insert a valid Password"

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results


            if ($null -ne $Results.Certificates)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                -ComplexObject $Results.Certificates`
                -CIMInstanceName 'AADIdentityAPIConnectionCertificate'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Certificates = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Certificates') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential


            if ($Results.Certificates)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Certificates" -IsCIMArray:$True
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
