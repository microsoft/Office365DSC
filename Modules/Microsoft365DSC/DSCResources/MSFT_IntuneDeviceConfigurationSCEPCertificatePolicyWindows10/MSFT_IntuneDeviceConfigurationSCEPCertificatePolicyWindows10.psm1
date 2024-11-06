function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [ValidateSet('user','machine')]
        [System.String]
        $CertificateStore,

        [Parameter()]
        [ValidateSet('sha1','sha2')]
        [System.String]
        $HashAlgorithm,

        [Parameter()]
        [ValidateSet('size1024','size2048','size4096')]
        [System.String]
        $KeySize,

        [Parameter()]
        [ValidateSet('keyEncipherment','digitalSignature')]
        [System.String[]]
        $KeyUsage,

        [Parameter()]
        [System.String[]]
        $ScepServerUrls,

        [Parameter()]
        [System.String]
        $SubjectAlternativeNameFormatString,

        [Parameter()]
        [System.String]
        $SubjectNameFormatString,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomSubjectAlternativeNames,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ExtendedKeyUsages,

        [Parameter()]
        [ValidateSet('days','months','years')]
        [System.String]
        $CertificateValidityPeriodScale,

        [Parameter()]
        [System.Int32]
        $CertificateValidityPeriodValue,

        [Parameter()]
        [ValidateSet('useTpmKspOtherwiseUseSoftwareKsp','useTpmKspOtherwiseFail','usePassportForWorkKspOtherwiseFail','useSoftwareKsp')]
        [System.String]
        $KeyStorageProvider,

        [Parameter()]
        [System.Int32]
        $RenewalThresholdPercentage,

        [Parameter()]
        [ValidateSet('none','emailAddress','userPrincipalName','customAzureADAttribute','domainNameService','universalResourceIdentifier')]
        [System.String]
        $SubjectAlternativeNameType,

        [Parameter()]
        [ValidateSet('commonName','commonNameIncludingEmail','commonNameAsEmail','custom','commonNameAsIMEI','commonNameAsSerialNumber','commonNameAsAadDeviceId','commonNameAsIntuneDeviceId','commonNameAsDurableDeviceId')]
        [System.String]
        $SubjectNameFormat,

        [Parameter()]
        [System.String]
        $RootCertificateDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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
        $getValue = Get-MgBetaDeviceManagementDeviceConfiguration -DeviceConfigurationId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Configuration Scep Certificate Policy for Windows10 with Id {$Id}"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementDeviceConfiguration `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue | Where-Object `
                    -FilterScript { `
                        $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.windows81SCEPCertificateProfile" `
                    }
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Configuration Scep Certificate Policy for Windows10 with DisplayName {$DisplayName}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Device Configuration Scep Certificate Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName} was found."

        #region resource generator code
        $complexCustomSubjectAlternativeNames = @()
        foreach ($currentcustomSubjectAlternativeNames in $getValue.AdditionalProperties.customSubjectAlternativeNames)
        {
            $mycustomSubjectAlternativeNames = @{}
            $mycustomSubjectAlternativeNames.Add('Name', $currentcustomSubjectAlternativeNames.name)
            if ($null -ne $currentcustomSubjectAlternativeNames.sanType)
            {
                $mycustomSubjectAlternativeNames.Add('SanType', $currentcustomSubjectAlternativeNames.sanType.toString())
            }
            if ($mycustomSubjectAlternativeNames.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexCustomSubjectAlternativeNames += $mycustomSubjectAlternativeNames
            }
        }

        $complexExtendedKeyUsages = @()
        foreach ($currentextendedKeyUsages in $getValue.AdditionalProperties.extendedKeyUsages)
        {
            $myextendedKeyUsages = @{}
            $myextendedKeyUsages.Add('Name', $currentextendedKeyUsages.name)
            $myextendedKeyUsages.Add('ObjectIdentifier', $currentextendedKeyUsages.objectIdentifier)
            if ($myextendedKeyUsages.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexExtendedKeyUsages += $myextendedKeyUsages
            }
        }
        #endregion

        #region resource generator code
        $enumCertificateStore = $null
        if ($null -ne $getValue.AdditionalProperties.certificateStore)
        {
            $enumCertificateStore = $getValue.AdditionalProperties.certificateStore.ToString()
        }

        $enumHashAlgorithm = $null
        if ($null -ne $getValue.AdditionalProperties.hashAlgorithm)
        {
            $enumHashAlgorithm = $getValue.AdditionalProperties.hashAlgorithm.ToString()
        }

        $enumKeySize = $null
        if ($null -ne $getValue.AdditionalProperties.keySize)
        {
            $enumKeySize = $getValue.AdditionalProperties.keySize.ToString()
        }

        $enumKeyUsage = $null
        if ($null -ne $getValue.AdditionalProperties.keyUsage)
        {
            $enumKeyUsage = $getValue.AdditionalProperties.keyUsage.ToString()
        }

        $enumCertificateValidityPeriodScale = $null
        if ($null -ne $getValue.AdditionalProperties.certificateValidityPeriodScale)
        {
            $enumCertificateValidityPeriodScale = $getValue.AdditionalProperties.certificateValidityPeriodScale.ToString()
        }

        $enumKeyStorageProvider = $null
        if ($null -ne $getValue.AdditionalProperties.keyStorageProvider)
        {
            $enumKeyStorageProvider = $getValue.AdditionalProperties.keyStorageProvider.ToString()
        }

        $enumSubjectAlternativeNameType = $null
        if ($null -ne $getValue.AdditionalProperties.subjectAlternativeNameType)
        {
            $enumSubjectAlternativeNameType = $getValue.AdditionalProperties.subjectAlternativeNameType.ToString()
        }

        $enumSubjectNameFormat = $null
        if ($null -ne $getValue.AdditionalProperties.subjectNameFormat)
        {
            $enumSubjectNameFormat = $getValue.AdditionalProperties.subjectNameFormat.ToString()
        }
        #endregion

        $RootCertificate = Get-DeviceConfigurationPolicyRootCertificate -DeviceConfigurationPolicyId $getValue.Id
        $RootCertificateId = $RootCertificate.Id
        $RootCertificateDisplayName = $RootCertificate.DisplayName

        $results = @{
            #region resource generator code
            CertificateStore                   = $enumCertificateStore
            HashAlgorithm                      = $enumHashAlgorithm
            KeySize                            = $enumKeySize
            KeyUsage                           = $enumKeyUsage.Split(',')
            ScepServerUrls                     = $getValue.AdditionalProperties.scepServerUrls
            SubjectAlternativeNameFormatString = $getValue.AdditionalProperties.subjectAlternativeNameFormatString
            SubjectNameFormatString            = $getValue.AdditionalProperties.subjectNameFormatString
            CustomSubjectAlternativeNames      = $complexCustomSubjectAlternativeNames
            ExtendedKeyUsages                  = $complexExtendedKeyUsages
            CertificateValidityPeriodScale     = $enumCertificateValidityPeriodScale
            CertificateValidityPeriodValue     = $getValue.AdditionalProperties.certificateValidityPeriodValue
            KeyStorageProvider                 = $enumKeyStorageProvider
            RenewalThresholdPercentage         = $getValue.AdditionalProperties.renewalThresholdPercentage
            SubjectAlternativeNameType         = $enumSubjectAlternativeNameType
            SubjectNameFormat                  = $enumSubjectNameFormat
            RootCertificateId                  = $RootCertificateId
            RootCertificateDisplayName         = $RootCertificateDisplayName
            Description                        = $getValue.Description
            DisplayName                        = $getValue.DisplayName
            Id                                 = $getValue.Id
            Ensure                             = 'Present'
            Credential                         = $Credential
            ApplicationId                      = $ApplicationId
            TenantId                           = $TenantId
            ApplicationSecret                  = $ApplicationSecret
            CertificateThumbprint              = $CertificateThumbprint
            Managedidentity                    = $ManagedIdentity.IsPresent
            AccessTokens                       = $AccessTokens
            #endregion
        }
        
        $assignmentsValues = Get-MgBetaDeviceManagementDeviceConfigurationAssignment -DeviceConfigurationId $Id
        $assignmentResult = @()
        if ($assignmentsValues.Count -gt 0)
        {
            $assignmentResult += ConvertFrom-IntunePolicyAssignment `
                                -IncludeDeviceFilter:$true `
                                -Assignments ($assignmentsValues)
        }
        $results.Add('Assignments', $assignmentResult)

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
        [ValidateSet('user','machine')]
        [System.String]
        $CertificateStore,

        [Parameter()]
        [ValidateSet('sha1','sha2')]
        [System.String]
        $HashAlgorithm,

        [Parameter()]
        [ValidateSet('size1024','size2048','size4096')]
        [System.String]
        $KeySize,

        [Parameter()]
        [ValidateSet('keyEncipherment','digitalSignature')]
        [System.String[]]
        $KeyUsage,

        [Parameter()]
        [System.String[]]
        $ScepServerUrls,

        [Parameter()]
        [System.String]
        $SubjectAlternativeNameFormatString,

        [Parameter()]
        [System.String]
        $SubjectNameFormatString,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomSubjectAlternativeNames,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ExtendedKeyUsages,

        [Parameter()]
        [ValidateSet('days','months','years')]
        [System.String]
        $CertificateValidityPeriodScale,

        [Parameter()]
        [System.Int32]
        $CertificateValidityPeriodValue,

        [Parameter()]
        [ValidateSet('useTpmKspOtherwiseUseSoftwareKsp','useTpmKspOtherwiseFail','usePassportForWorkKspOtherwiseFail','useSoftwareKsp')]
        [System.String]
        $KeyStorageProvider,

        [Parameter()]
        [System.Int32]
        $RenewalThresholdPercentage,

        [Parameter()]
        [ValidateSet('none','emailAddress','userPrincipalName','customAzureADAttribute','domainNameService','universalResourceIdentifier')]
        [System.String]
        $SubjectAlternativeNameType,

        [Parameter()]
        [ValidateSet('commonName','commonNameIncludingEmail','commonNameAsEmail','custom','commonNameAsIMEI','commonNameAsSerialNumber','commonNameAsAadDeviceId','commonNameAsIntuneDeviceId','commonNameAsDurableDeviceId')]
        [System.String]
        $SubjectNameFormat,

        [Parameter()]
        [System.String]
        $RootCertificateDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Device Configuration Scep Certificate Policy for Windows10 with DisplayName {$DisplayName}"
        $BoundParameters.Remove("Assignments") | Out-Null
        $BoundParameters.Remove('RootCertificateId') | Out-Null

        $CreateParameters = ([Hashtable]$BoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $CreateParameters.Remove('Id') | Out-Null
        $CreateParameters['keyUsage'] = $CreateParameters['keyUsage'] -join ','

        $keys = (([Hashtable]$CreateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }

        $RootCertificate = Get-MgBetaDeviceManagementDeviceConfiguration `
            -DeviceConfigurationId $RootCertificateId `
            -ErrorAction SilentlyContinue | `
                Where-Object -FilterScript {
                    $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.windows81TrustedRootCertificate"
                }

        if ($null -eq $RootCertificate)
        {
            Write-Verbose -Message "Could not find trusted root certificate with Id {$RootCertificateId}, searching by display name {$RootCertificateDisplayName}"

            $RootCertificate = Get-MgBetaDeviceManagementDeviceConfiguration `
                -Filter "DisplayName eq '$RootCertificateDisplayName'" `
                -ErrorAction SilentlyContinue | `
                    Where-Object -FilterScript {
                        $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.windows81TrustedRootCertificate"
                    }
            $RootCertificateId = $RootCertificate.Id

            if ($null -eq $RootCertificate)
            {
                throw "Could not find trusted root certificate with Id {$RootCertificateId} or display name {$RootCertificateDisplayName}"
            }

            Write-Verbose -Message "Found trusted root certificate with Id {$($RootCertificate.Id)} and DisplayName {$($RootCertificate.DisplayName)}"
        }
        else
        {
            Write-Verbose -Message "Found trusted root certificate with Id {$RootCertificateId}"
        }

        #region resource generator code
        $CreateParameters.Add("rootCertificate@odata.bind", "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$RootCertificateId')")
        $CreateParameters.Add("@odata.type", "#microsoft.graph.windows81SCEPCertificateProfile")
        $policy = New-MgBetaDeviceManagementDeviceConfiguration -BodyParameter $CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId  $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/deviceConfigurations'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Device Configuration Scep Certificate Policy for Windows10 with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove("Assignments") | Out-Null
        $BoundParameters.Remove('RootCertificateId') | Out-Null
        $BoundParameters.Remove('RootCertificateDisplayName') | Out-Null

        $UpdateParameters = ([Hashtable]$BoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters

        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters['keyUsage'] = $UpdateParameters['keyUsage'] -join ','

        $keys = (([Hashtable]$UpdateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }
        #region resource generator code
        $UpdateParameters.Add("@odata.type", "#microsoft.graph.windows81SCEPCertificateProfile")
        Update-MgBetaDeviceManagementDeviceConfiguration  `
            -DeviceConfigurationId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/deviceConfigurations'
        #endregion

        $RootCertificate = Get-MgBetaDeviceManagementDeviceConfiguration `
            -DeviceConfigurationId $RootCertificateId `
            -ErrorAction SilentlyContinue | `
                Where-Object -FilterScript {
                    $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.windows81TrustedRootCertificate"
                }

        if ($null -eq $RootCertificate)
        {
            Write-Verbose -Message "Could not find trusted root certificate with Id {$RootCertificateId}, searching by display name {$RootCertificateDisplayName}"

            $RootCertificate = Get-MgBetaDeviceManagementDeviceConfiguration `
                -Filter "DisplayName eq '$RootCertificateDisplayName'" `
                -ErrorAction SilentlyContinue | `
                    Where-Object -FilterScript {
                        $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.windows81TrustedRootCertificate"
                    }
            $RootCertificateId = $RootCertificate.Id

            if ($null -eq $RootCertificate)
            {
                throw "Could not find trusted root certificate with Id {$RootCertificateId} or display name {$RootCertificateDisplayName}"
            }

            Write-Verbose -Message "Found trusted root certificate with Id {$($RootCertificate.Id)} and DisplayName {$($RootCertificate.DisplayName)}"
        }
        else
        {
            Write-Verbose -Message "Found trusted root certificate with Id {$RootCertificateId}"
        }

        Update-DeviceConfigurationPolicyRootCertificateId `
            -DeviceConfigurationPolicyId $currentInstance.id `
            -RootCertificateId $RootCertificateId
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Device Configuration Scep Certificate Policy for Windows10 with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementDeviceConfiguration -DeviceConfigurationId $currentInstance.Id
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
        [ValidateSet('user','machine')]
        [System.String]
        $CertificateStore,

        [Parameter()]
        [ValidateSet('sha1','sha2')]
        [System.String]
        $HashAlgorithm,

        [Parameter()]
        [ValidateSet('size1024','size2048','size4096')]
        [System.String]
        $KeySize,

        [Parameter()]
        [ValidateSet('keyEncipherment','digitalSignature')]
        [System.String[]]
        $KeyUsage,

        [Parameter()]
        [System.String[]]
        $ScepServerUrls,

        [Parameter()]
        [System.String]
        $SubjectAlternativeNameFormatString,

        [Parameter()]
        [System.String]
        $SubjectNameFormatString,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $CustomSubjectAlternativeNames,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ExtendedKeyUsages,

        [Parameter()]
        [ValidateSet('days','months','years')]
        [System.String]
        $CertificateValidityPeriodScale,

        [Parameter()]
        [System.Int32]
        $CertificateValidityPeriodValue,

        [Parameter()]
        [ValidateSet('useTpmKspOtherwiseUseSoftwareKsp','useTpmKspOtherwiseFail','usePassportForWorkKspOtherwiseFail','useSoftwareKsp')]
        [System.String]
        $KeyStorageProvider,

        [Parameter()]
        [System.Int32]
        $RenewalThresholdPercentage,

        [Parameter()]
        [ValidateSet('none','emailAddress','userPrincipalName','customAzureADAttribute','domainNameService','universalResourceIdentifier')]
        [System.String]
        $SubjectAlternativeNameType,

        [Parameter()]
        [ValidateSet('commonName','commonNameIncludingEmail','commonNameAsEmail','custom','commonNameAsIMEI','commonNameAsSerialNumber','commonNameAsAadDeviceId','commonNameAsIntuneDeviceId','commonNameAsDurableDeviceId')]
        [System.String]
        $SubjectNameFormat,

        [Parameter()]
        [System.String]
        $RootCertificateDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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

    Write-Verbose -Message "Testing configuration of the Intune Device Configuration Scep Certificate Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName}"

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
    if ($null -ne $ValuesToCheck.RootCertificateDisplayName)
    {
        $ValuesToCheck.Remove('RootCertificateId') | Out-Null
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
        [array]$getValue = Get-MgBetaDeviceManagementDeviceConfiguration -Filter $Filter -All `
            -ErrorAction Stop | Where-Object `
            -FilterScript { `
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.windows81SCEPCertificateProfile' `
            }
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
                Id = $config.Id
                DisplayName           =  $config.DisplayName
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity = $ManagedIdentity.IsPresent
                AccessTokens    = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($null -ne $Results.CustomSubjectAlternativeNames)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.CustomSubjectAlternativeNames `
                    -CIMInstanceName 'MicrosoftGraphcustomSubjectAlternativeName'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.CustomSubjectAlternativeNames = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('CustomSubjectAlternativeNames') | Out-Null
                }
            }
            if ($null -ne $Results.ExtendedKeyUsages)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ExtendedKeyUsages `
                    -CIMInstanceName 'MicrosoftGraphextendedKeyUsage'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ExtendedKeyUsages = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ExtendedKeyUsages') | Out-Null
                }
            }
            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Assignments -CIMInstanceName DeviceManagementConfigurationPolicyAssignments
                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.CustomSubjectAlternativeNames)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "CustomSubjectAlternativeNames" -isCIMArray:$True
            }
            if ($Results.ExtendedKeyUsages)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ExtendedKeyUsages" -isCIMArray:$True
            }
            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Assignments" -isCIMArray:$true
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
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
        $_.Exception -like "*Request not applicable to target tenant*")
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for Intune."
        }
        else
        {
            Write-Host $Global:M365DSCEmojiRedX

            New-M365DSCLogEntry -Message 'Error during Export:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

        return ''
    }
}

function Get-DeviceConfigurationPolicyRootCertificate
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId
    )
    $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/deviceConfigurations('$DeviceConfigurationPolicyId')/microsoft.graph.windows81SCEPCertificateProfile/rootCertificate"
    $result = Invoke-MgGraphRequest -Method Get -Uri $Uri -ErrorAction Stop

    return $result
}

function Update-DeviceConfigurationPolicyRootCertificateId
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter(Mandatory = 'true')]
        [System.String]
        $RootCertificateId
    )
    
    $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/deviceConfigurations('$DeviceConfigurationPolicyId')/microsoft.graph.windows81SCEPCertificateProfile/rootCertificate/`$ref"
    $ref = @{
        '@odata.id' = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$RootCertificateId')"
    }

    Invoke-MgGraphRequest -Method PUT -Uri $Uri -Body ($ref|ConvertTo-Json) -ErrorAction Stop
}

Export-ModuleMember -Function *-TargetResource
