function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.Int32]
        $AuthenticationBlockPeriodInMinutes,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $AuthenticationMethod,

        [Parameter()]
        [System.Int32]
        $AuthenticationPeriodInSeconds,

        [Parameter()]
        [System.Int32]
        $AuthenticationRetryDelayPeriodInSeconds,

        [Parameter()]
        [ValidateSet('none', 'user', 'machine', 'machineOrUser', 'guest', 'unknownFutureValue')]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.Boolean]
        $CacheCredentials,

        [Parameter()]
        [System.Boolean]
        $DisableUserPromptForServerValidation,

        [Parameter()]
        [System.Int32]
        $EapolStartPeriodInSeconds,

        [Parameter()]
        [ValidateSet('eapTls', 'leap', 'eapSim', 'eapTtls', 'peap', 'eapFast', 'teap')]
        [System.String]
        $EapType,

        [Parameter()]
        [System.Boolean]
        $Enforce8021X,

        [Parameter()]
        [System.Boolean]
        $ForceFIPSCompliance,

        [Parameter()]
        [ValidateSet('unencryptedPassword', 'challengeHandshakeAuthenticationProtocol', 'microsoftChap', 'microsoftChapVersionTwo')]
        [System.String]
        $InnerAuthenticationProtocolForEAPTTLS,

        [Parameter()]
        [System.Int32]
        $MaximumAuthenticationFailures,

        [Parameter()]
        [System.Int32]
        $MaximumEAPOLStartMessages,

        [Parameter()]
        [System.String]
        $OuterIdentityPrivacyTemporaryValue,

        [Parameter()]
        [System.Boolean]
        $PerformServerValidation,

        [Parameter()]
        [System.Boolean]
        $RequireCryptographicBinding,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $SecondaryAuthenticationMethod,

        [Parameter()]
        [System.String[]]
        $TrustedServerCertificateNames,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationIds,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationDisplayNames,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationDisplayName,

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
        $getValue = Get-MgBetaDeviceManagementDeviceConfiguration -DeviceConfigurationId $Id -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Configuration Wired Network Policy for Windows10 with Id {$Id}"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementDeviceConfiguration `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue | Where-Object `
                    -FilterScript { `
                        $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.windowsWiredNetworkConfiguration' `
                }
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Device Configuration Wired Network Policy for Windows10 with DisplayName {$DisplayName}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Device Configuration Wired Network Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName} was found."

        #region resource generator code
        $enumAuthenticationMethod = $null
        if ($null -ne $getValue.AdditionalProperties.authenticationMethod)
        {
            $enumAuthenticationMethod = $getValue.AdditionalProperties.authenticationMethod.ToString()
        }

        $enumAuthenticationType = $null
        if ($null -ne $getValue.AdditionalProperties.authenticationType)
        {
            $enumAuthenticationType = $getValue.AdditionalProperties.authenticationType.ToString()
        }

        $enumEapType = $null
        if ($null -ne $getValue.AdditionalProperties.eapType)
        {
            $enumEapType = $getValue.AdditionalProperties.eapType.ToString()
        }

        $enumInnerAuthenticationProtocolForEAPTTLS = $null
        if ($null -ne $getValue.AdditionalProperties.innerAuthenticationProtocolForEAPTTLS)
        {
            $enumInnerAuthenticationProtocolForEAPTTLS = $getValue.AdditionalProperties.innerAuthenticationProtocolForEAPTTLS.ToString()
        }

        $enumSecondaryAuthenticationMethod = $null
        if ($null -ne $getValue.AdditionalProperties.secondaryAuthenticationMethod)
        {
            $enumSecondaryAuthenticationMethod = $getValue.AdditionalProperties.secondaryAuthenticationMethod.ToString()
        }
        #endregion

        $rootCertificateForClientValidation                  = Get-DeviceConfigurationPolicyCertificate -DeviceConfigurationPolicyId $getValue.Id -CertificateName rootCertificateForClientValidation
        $rootCertificatesForServerValidation                 = Get-DeviceConfigurationPolicyCertificate -DeviceConfigurationPolicyId $getValue.Id -CertificateName rootCertificatesForServerValidation
        $identityCertificateForClientAuthentication          = Get-DeviceConfigurationPolicyCertificate -DeviceConfigurationPolicyId $getValue.Id -CertificateName identityCertificateForClientAuthentication
        $secondaryIdentityCertificateForClientAuthentication = Get-DeviceConfigurationPolicyCertificate -DeviceConfigurationPolicyId $getValue.Id -CertificateName secondaryIdentityCertificateForClientAuthentication
        $secondaryRootCertificateForClientValidation         = Get-DeviceConfigurationPolicyCertificate -DeviceConfigurationPolicyId $getValue.Id -CertificateName secondaryRootCertificateForClientValidation

        $results = @{
            #region resource generator code
            AuthenticationBlockPeriodInMinutes                             = $getValue.AdditionalProperties.authenticationBlockPeriodInMinutes
            AuthenticationMethod                                           = $enumAuthenticationMethod
            AuthenticationPeriodInSeconds                                  = $getValue.AdditionalProperties.authenticationPeriodInSeconds
            AuthenticationRetryDelayPeriodInSeconds                        = $getValue.AdditionalProperties.authenticationRetryDelayPeriodInSeconds
            AuthenticationType                                             = $enumAuthenticationType
            CacheCredentials                                               = $getValue.AdditionalProperties.cacheCredentials
            DisableUserPromptForServerValidation                           = $getValue.AdditionalProperties.disableUserPromptForServerValidation
            EapolStartPeriodInSeconds                                      = $getValue.AdditionalProperties.eapolStartPeriodInSeconds
            EapType                                                        = $enumEapType
            Enforce8021X                                                   = $getValue.AdditionalProperties.enforce8021X
            ForceFIPSCompliance                                            = $getValue.AdditionalProperties.forceFIPSCompliance
            InnerAuthenticationProtocolForEAPTTLS                          = $enumInnerAuthenticationProtocolForEAPTTLS
            MaximumAuthenticationFailures                                  = $getValue.AdditionalProperties.maximumAuthenticationFailures
            MaximumEAPOLStartMessages                                      = $getValue.AdditionalProperties.maximumEAPOLStartMessages
            OuterIdentityPrivacyTemporaryValue                             = $getValue.AdditionalProperties.outerIdentityPrivacyTemporaryValue
            PerformServerValidation                                        = $getValue.AdditionalProperties.performServerValidation
            RequireCryptographicBinding                                    = $getValue.AdditionalProperties.requireCryptographicBinding
            SecondaryAuthenticationMethod                                  = $enumSecondaryAuthenticationMethod
            TrustedServerCertificateNames                                  = $getValue.AdditionalProperties.trustedServerCertificateNames
            RootCertificatesForServerValidationIds                         = @($rootCertificatesForServerValidation.Id)
            RootCertificatesForServerValidationDisplayNames                = @($rootCertificatesForServerValidation.DisplayName)
            IdentityCertificateForClientAuthenticationId                   = $identityCertificateForClientAuthentication.Id
            IdentityCertificateForClientAuthenticationDisplayName          = $identityCertificateForClientAuthentication.DisplayName
            SecondaryIdentityCertificateForClientAuthenticationId          = $secondaryIdentityCertificateForClientAuthentication.Id
            SecondaryIdentityCertificateForClientAuthenticationDisplayName = $secondaryIdentityCertificateForClientAuthentication.DisplayName
            RootCertificateForClientValidationId                           = $rootCertificateForClientValidation.Id
            RootCertificateForClientValidationDisplayName                  = $rootCertificateForClientValidation.DisplayName
            SecondaryRootCertificateForClientValidationId                  = $secondaryRootCertificateForClientValidation.Id
            SecondaryRootCertificateForClientValidationDisplayName         = $secondaryRootCertificateForClientValidation.DisplayName
            Description                                                    = $getValue.Description
            DisplayName                                                    = $getValue.DisplayName
            Id                                                             = $getValue.Id
            Ensure                                                         = 'Present'
            Credential                                                     = $Credential
            ApplicationId                                                  = $ApplicationId
            TenantId                                                       = $TenantId
            ApplicationSecret                                              = $ApplicationSecret
            CertificateThumbprint                                          = $CertificateThumbprint
            ManagedIdentity                                                = $ManagedIdentity.IsPresent
            AccessTokens                                                   = $AccessTokens
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
        [System.Int32]
        $AuthenticationBlockPeriodInMinutes,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $AuthenticationMethod,

        [Parameter()]
        [System.Int32]
        $AuthenticationPeriodInSeconds,

        [Parameter()]
        [System.Int32]
        $AuthenticationRetryDelayPeriodInSeconds,

        [Parameter()]
        [ValidateSet('none', 'user', 'machine', 'machineOrUser', 'guest', 'unknownFutureValue')]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.Boolean]
        $CacheCredentials,

        [Parameter()]
        [System.Boolean]
        $DisableUserPromptForServerValidation,

        [Parameter()]
        [System.Int32]
        $EapolStartPeriodInSeconds,

        [Parameter()]
        [ValidateSet('eapTls', 'leap', 'eapSim', 'eapTtls', 'peap', 'eapFast', 'teap')]
        [System.String]
        $EapType,

        [Parameter()]
        [System.Boolean]
        $Enforce8021X,

        [Parameter()]
        [System.Boolean]
        $ForceFIPSCompliance,

        [Parameter()]
        [ValidateSet('unencryptedPassword', 'challengeHandshakeAuthenticationProtocol', 'microsoftChap', 'microsoftChapVersionTwo')]
        [System.String]
        $InnerAuthenticationProtocolForEAPTTLS,

        [Parameter()]
        [System.Int32]
        $MaximumAuthenticationFailures,

        [Parameter()]
        [System.Int32]
        $MaximumEAPOLStartMessages,

        [Parameter()]
        [System.String]
        $OuterIdentityPrivacyTemporaryValue,

        [Parameter()]
        [System.Boolean]
        $PerformServerValidation,

        [Parameter()]
        [System.Boolean]
        $RequireCryptographicBinding,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $SecondaryAuthenticationMethod,

        [Parameter()]
        [System.String[]]
        $TrustedServerCertificateNames,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationIds,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationDisplayNames,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationDisplayName,

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
        Write-Verbose -Message "Creating an Intune Device Configuration Wired Network Policy for Windows10 with DisplayName {$DisplayName}"
        $BoundParameters.Remove('Assignments') | Out-Null
        $BoundParameters.Remove('RootCertificatesForServerValidationIds') | Out-Null
        $BoundParameters.Remove('RootCertificatesForServerValidationDisplayNames') | Out-Null
        $BoundParameters.Remove('IdentityCertificateForClientAuthenticationId') | Out-Null
        $BoundParameters.Remove('IdentityCertificateForClientAuthenticationDisplayName') | Out-Null
        $BoundParameters.Remove('SecondaryIdentityCertificateForClientAuthenticationId') | Out-Null
        $BoundParameters.Remove('SecondaryIdentityCertificateForClientAuthenticationDisplayName') | Out-Null
        $BoundParameters.Remove('RootCertificateForClientValidationId') | Out-Null
        $BoundParameters.Remove('RootCertificateForClientValidationDisplayName') | Out-Null
        $BoundParameters.Remove('SecondaryRootCertificateForClientValidationId') | Out-Null
        $BoundParameters.Remove('SecondaryRootCertificateForClientValidationDisplayName') | Out-Null

        $CreateParameters = ([Hashtable]$BoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $CreateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$CreateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }
        #region resource generator code

        if ($null -ne $RootCertificatesForServerValidationIds -and $RootCertificatesForServerValidationIds.count -gt 0 )
        {
            $rootCertificatesForServerValidation = @()
            for ($i = 0; $i -lt $RootCertificatesForServerValidationIds.Length; $i++)
            {
                $checkedCertId = Get-IntuneDeviceConfigurationCertificateId `
                    -CertificateId $RootCertificatesForServerValidationIds[$i] `
                    -CertificateDisplayName $RootCertificatesForServerValidationDisplayNames[$i] `
                    -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
                $rootCertificatesForServerValidation += "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$checkedCertId')"
            }
            $CreateParameters.Add('rootCertificatesForServerValidation@odata.bind', $rootCertificatesForServerValidation)
        }

        if (-not [String]::IsNullOrWhiteSpace($IdentityCertificateForClientAuthenticationId))
        {
            $checkedCertId = Get-IntuneDeviceConfigurationCertificateId `
                -CertificateId $IdentityCertificateForClientAuthenticationId `
                -CertificateDisplayName $IdentityCertificateForClientAuthenticationDisplayName `
                -OdataTypes @( `
                    '#microsoft.graph.windows81SCEPCertificateProfile', `
                    '#microsoft.graph.windows81TrustedRootCertificate', `
                    '#microsoft.graph.windows10PkcsCertificateProfile' `
                )
            $ref = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$checkedCertId')"
            $CreateParameters.Add('identityCertificateForClientAuthentication@odata.bind', $ref)
        }

        if (-not [String]::IsNullOrWhiteSpace($SecondaryIdentityCertificateForClientAuthenticationId))
        {
            $checkedCertId = Get-IntuneDeviceConfigurationCertificateId `
                -CertificateId $SecondaryIdentityCertificateForClientAuthenticationId `
                -CertificateDisplayName $SecondaryIdentityCertificateForClientAuthenticationDisplayName `
                -OdataTypes @( `
                    '#microsoft.graph.windows81SCEPCertificateProfile', `
                    '#microsoft.graph.windows81TrustedRootCertificate', `
                    '#microsoft.graph.windows10PkcsCertificateProfile' `
                )
            $ref = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$checkedCertId')"
            $CreateParameters.Add('secondaryIdentityCertificateForClientAuthentication@odata.bind', $ref)
        }

        if (-not [String]::IsNullOrWhiteSpace($RootCertificateForClientValidationId))
        {
            $checkedCertId = Get-IntuneDeviceConfigurationCertificateId `
                -CertificateId $RootCertificateForClientValidationId `
                -CertificateDisplayName $RootCertificateForClientValidationDisplayName `
                -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
            $ref = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$checkedCertId')"
            $CreateParameters.Add('rootCertificateForClientValidation@odata.bind', $ref)
        }

        if (-not [String]::IsNullOrWhiteSpace($SecondaryRootCertificateForClientValidationId))
        {
            $checkedCertId = Get-IntuneDeviceConfigurationCertificateId `
                -CertificateId $SecondaryRootCertificateForClientValidationId `
                -CertificateDisplayName $SecondaryRootCertificateForClientValidationDisplayName `
                -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
            $ref = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$checkedCertId')"
            $CreateParameters.Add('secondaryRootCertificateForClientValidation@odata.bind', $ref)
        }

        $CreateParameters.Add('@odata.type', '#microsoft.graph.windowsWiredNetworkConfiguration')
        $policy = New-MgBetaDeviceManagementDeviceConfiguration -BodyParameter $CreateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments

        if ($policy.id)
        {
            Update-DeviceConfigurationPolicyAssignment -DeviceConfigurationPolicyId $policy.id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/deviceConfigurations'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Device Configuration Wired Network Policy for Windows10 with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove('Assignments') | Out-Null
        $BoundParameters.Remove('RootCertificatesForServerValidationIds') | Out-Null
        $BoundParameters.Remove('RootCertificatesForServerValidationDisplayNames') | Out-Null
        $BoundParameters.Remove('IdentityCertificateForClientAuthenticationId') | Out-Null
        $BoundParameters.Remove('IdentityCertificateForClientAuthenticationDisplayName') | Out-Null
        $BoundParameters.Remove('SecondaryIdentityCertificateForClientAuthenticationId') | Out-Null
        $BoundParameters.Remove('SecondaryIdentityCertificateForClientAuthenticationDisplayName') | Out-Null
        $BoundParameters.Remove('RootCertificateForClientValidationId') | Out-Null
        $BoundParameters.Remove('RootCertificateForClientValidationDisplayName') | Out-Null
        $BoundParameters.Remove('SecondaryRootCertificateForClientValidationId') | Out-Null
        $BoundParameters.Remove('SecondaryRootCertificateForClientValidationDisplayName') | Out-Null

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
        $UpdateParameters.Add('@odata.type', '#microsoft.graph.windowsWiredNetworkConfiguration')
        Update-MgBetaDeviceManagementDeviceConfiguration  `
            -DeviceConfigurationId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/deviceConfigurations'
        #endregion

        if ($null -ne $RootCertificatesForServerValidationIds -and $RootCertificatesForServerValidationIds.count -gt 0 )
        {
            [Array]$rootCertificatesForServerValidationChecked = @()
            for ($i = 0; $i -lt $RootCertificatesForServerValidationIds.Count; $i++)
            {
                $certId = $RootCertificatesForServerValidationIds[$i]
                $certName = $RootCertificatesForServerValidationDisplayNames[$i]
                $checkedCertId = Get-IntuneDeviceConfigurationCertificateId -CertificateId $certId -CertificateDisplayName $certName -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
                $rootCertificatesForServerValidationChecked += $checkedCertId
            }
            $RootCertificatesForServerValidationIds = $rootCertificatesForServerValidationChecked
            $compareResult = Compare-Object -ReferenceObject $currentInstance.RootCertificatesForServerValidationIds `
                -DifferenceObject $RootCertificatesForServerValidationIds

            [Array]$certsToAdd = ($compareResult | Where-Object { $_.SideIndicator -eq '=>' }).InputObject
            [Array]$certsToRemove = ($compareResult | Where-Object { $_.SideIndicator -eq '<=' }).InputObject

            if ($certsToAdd.count -gt 0)
            {
                Update-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $certsToAdd `
                    -CertificateName rootCertificatesForServerValidation
            }

            if ($certsToRemove.count -gt 0)
            {
                Remove-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $certsToRemove `
                    -CertificateName rootCertificatesForServerValidation
            }
        }

        if (-not [String]::IsNullOrWhiteSpace($IdentityCertificateForClientAuthenticationId))
        {
            if ($IdentityCertificateForClientAuthenticationId -ne $currentInstance.IdentityCertificateForClientAuthenticationId)
            {
                $IdentityCertificateForClientAuthenticationId = Get-IntuneDeviceConfigurationCertificateId `
                    -CertificateId $IdentityCertificateForClientAuthenticationId `
                    -CertificateDisplayName $IdentityCertificateForClientAuthenticationDisplayName `
                    -OdataTypes @( `
                        '#microsoft.graph.windows81SCEPCertificateProfile', `
                        '#microsoft.graph.windows81TrustedRootCertificate', `
                        '#microsoft.graph.windows10PkcsCertificateProfile' `
                    )
                Update-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $IdentityCertificateForClientAuthenticationId `
                    -CertificateName identityCertificateForClientAuthentication
            }
        }

        if (-not [String]::IsNullOrWhiteSpace($SecondaryIdentityCertificateForClientAuthenticationId))
        {
            if ($SecondaryIdentityCertificateForClientAuthenticationId -ne $currentInstance.SecondaryIdentityCertificateForClientAuthenticationId)
            {
                $SecondaryIdentityCertificateForClientAuthenticationId = Get-IntuneDeviceConfigurationCertificateId `
                    -CertificateId $SecondaryIdentityCertificateForClientAuthenticationId `
                    -CertificateDisplayName $SecondaryIdentityCertificateForClientAuthenticationDisplayName `
                    -OdataTypes @( `
                        '#microsoft.graph.windows81SCEPCertificateProfile', `
                        '#microsoft.graph.windows81TrustedRootCertificate', `
                        '#microsoft.graph.windows10PkcsCertificateProfile' `
                    )
                Update-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $SecondaryIdentityCertificateForClientAuthenticationId `
                    -CertificateName secondaryIdentityCertificateForClientAuthentication
            }
        }

        if (-not [String]::IsNullOrWhiteSpace($RootCertificateForClientValidationId))
        {
            if ($RootCertificateForClientValidationId -ne $currentInstance.RootCertificateForClientValidationId)
            {
                $RootCertificateForClientValidationId = Get-IntuneDeviceConfigurationCertificateId `
                    -CertificateId $RootCertificateForClientValidationId `
                    -CertificateDisplayName $RootCertificateForClientValidationDisplayName `
                    -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
                Update-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $RootCertificateForClientValidationId `
                    -CertificateName rootCertificateForClientValidation
            }
        }

        if (-not [String]::IsNullOrWhiteSpace($SecondaryRootCertificateForClientValidationId))
        {
            if ($SecondaryRootCertificateForClientValidationId -ne $currentInstance.SecondaryRootCertificateForClientValidationId)
            {
                $SecondaryRootCertificateForClientValidationId = Get-IntuneDeviceConfigurationCertificateId `
                    -CertificateId $SecondaryRootCertificateForClientValidationId `
                    -CertificateDisplayName $SecondaryRootCertificateForClientValidationDisplayName `
                    -OdataTypes @('#microsoft.graph.windows81TrustedRootCertificate')
                Update-DeviceConfigurationPolicyCertificateId -DeviceConfigurationPolicyId $currentInstance.Id `
                    -CertificateIds $SecondaryRootCertificateForClientValidationId `
                    -CertificateName secondaryRootCertificateForClientValidation
            }
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Device Configuration Wired Network Policy for Windows10 with Id {$($currentInstance.Id)}"
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
        [System.Int32]
        $AuthenticationBlockPeriodInMinutes,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $AuthenticationMethod,

        [Parameter()]
        [System.Int32]
        $AuthenticationPeriodInSeconds,

        [Parameter()]
        [System.Int32]
        $AuthenticationRetryDelayPeriodInSeconds,

        [Parameter()]
        [ValidateSet('none', 'user', 'machine', 'machineOrUser', 'guest', 'unknownFutureValue')]
        [System.String]
        $AuthenticationType,

        [Parameter()]
        [System.Boolean]
        $CacheCredentials,

        [Parameter()]
        [System.Boolean]
        $DisableUserPromptForServerValidation,

        [Parameter()]
        [System.Int32]
        $EapolStartPeriodInSeconds,

        [Parameter()]
        [ValidateSet('eapTls', 'leap', 'eapSim', 'eapTtls', 'peap', 'eapFast', 'teap')]
        [System.String]
        $EapType,

        [Parameter()]
        [System.Boolean]
        $Enforce8021X,

        [Parameter()]
        [System.Boolean]
        $ForceFIPSCompliance,

        [Parameter()]
        [ValidateSet('unencryptedPassword', 'challengeHandshakeAuthenticationProtocol', 'microsoftChap', 'microsoftChapVersionTwo')]
        [System.String]
        $InnerAuthenticationProtocolForEAPTTLS,

        [Parameter()]
        [System.Int32]
        $MaximumAuthenticationFailures,

        [Parameter()]
        [System.Int32]
        $MaximumEAPOLStartMessages,

        [Parameter()]
        [System.String]
        $OuterIdentityPrivacyTemporaryValue,

        [Parameter()]
        [System.Boolean]
        $PerformServerValidation,

        [Parameter()]
        [System.Boolean]
        $RequireCryptographicBinding,

        [Parameter()]
        [ValidateSet('certificate', 'usernameAndPassword', 'derivedCredential', 'unknownFutureValue')]
        [System.String]
        $SecondaryAuthenticationMethod,

        [Parameter()]
        [System.String[]]
        $TrustedServerCertificateNames,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationIds,

        [Parameter()]
        [System.String[]]
        $RootCertificatesForServerValidationDisplayNames,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $IdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationId,

        [Parameter()]
        [System.String]
        $SecondaryIdentityCertificateForClientAuthenticationDisplayName,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $RootCertificateForClientValidationDisplayName,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationId,

        [Parameter()]
        [System.String]
        $SecondaryRootCertificateForClientValidationDisplayName,

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

    Write-Verbose -Message "Testing configuration of the Intune Device Configuration Wired Network Policy for Windows10 with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    $testResult = Compare-M365DSCIntunePolicyAssignment -Source $CurrentValues.Assignments -Target $Assignments

    $ValuesToCheck.remove('Id') | Out-Null
    $ValuesToCheck.Remove('Assignments') | Out-Null

    if ($null -ne $ValuesToCheck.RootCertificatesForServerValidationDisplayNames)
    {
        $ValuesToCheck.Remove('RootCertificatesForServerValidationIds')
    }
    if ($null -ne $ValuesToCheck.IdentityCertificateForClientAuthenticationDisplayName)
    {
        $ValuesToCheck.Remove('IdentityCertificateForClientAuthenticationId')
    }
    if ($null -ne $ValuesToCheck.SecondaryIdentityCertificateForClientAuthenticationDisplayName)
    {
        $ValuesToCheck.Remove('SecondaryIdentityCertificateForClientAuthenticationId')
    }
    if ($null -ne $ValuesToCheck.RootCertificateForClientValidationDisplayName)
    {
        $ValuesToCheck.Remove('RootCertificateForClientValidationId')
    }
    if ($null -ne $ValuesToCheck.SecondaryRootCertificateForClientValidationDisplayName)
    {
        $ValuesToCheck.Remove('SecondaryRootCertificateForClientValidationId')
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
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.windowsWiredNetworkConfiguration' `
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
                Id                    = $config.Id
                DisplayName           = $config.DisplayName
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
            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Assignments' -IsCIMArray:$true
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
            $_.Exception -like "*Message: Location header not present in redirection response.*" -or `
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

function Get-DeviceConfigurationPolicyCertificate
{
    [CmdletBinding()]
    [OutputType([System.String], [System.String[]])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter(Mandatory = 'true')]
        [ValidateSet('rootCertificatesForServerValidation', 'identityCertificateForClientAuthentication', 'secondaryIdentityCertificateForClientAuthentication', 'rootCertificateForClientValidation', 'secondaryRootCertificateForClientValidation')]
        [System.String]
        $CertificateName
    )
    $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/deviceConfigurations('$DeviceConfigurationPolicyId')/microsoft.graph.windowsWiredNetworkConfiguration/$CertificateName"
    try
    {
        $result = Invoke-MgGraphRequest -Method Get -Uri $Uri 4>$null

        return $(if ($result.value)
        {
            $result.value
        }
        else
        {
            $result
        })
    }
    catch
    {
        return $null
    }

}

function Update-DeviceConfigurationPolicyCertificateId
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter(Mandatory = 'true')]
        [System.String[]]
        $CertificateIds,

        [Parameter(Mandatory = 'true')]
        [ValidateSet('rootCertificatesForServerValidation', 'identityCertificateForClientAuthentication', 'secondaryIdentityCertificateForClientAuthentication', 'rootCertificateForClientValidation', 'secondaryRootCertificateForClientValidation')]
        [System.String]
        $CertificateName
    )
    $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/deviceConfigurations('$DeviceConfigurationPolicyId')/microsoft.graph.windowsWiredNetworkConfiguration/$CertificateName/`$ref"
    
    if ($CertificateName -eq 'rootCertificatesForServerValidation')
    {
        $method = 'POST'
    }
    else
    {
        $method = 'PUT'
    }

    foreach ($certificateId in $CertificateIds)
    {
        $ref = @{
            '@odata.id' = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('$certificateId')"
        }

        Invoke-MgGraphRequest -Method $method -Uri $Uri -Body ($ref | ConvertTo-Json) -ErrorAction Stop 4>$null
    }
}

function Remove-DeviceConfigurationPolicyCertificateId
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter(Mandatory = 'true')]
        [System.String[]]
        $CertificateIds,

        [Parameter(Mandatory = 'true')]
        [ValidateSet('rootCertificatesForServerValidation', 'identityCertificateForClientAuthentication', 'secondaryIdentityCertificateForClientAuthentication', 'rootCertificateForClientValidation', 'secondaryRootCertificateForClientValidation')]
        [System.String]
        $CertificateName
    )

    foreach ($certificateId in $CertificateIds)
    {
        $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/deviceManagement/deviceConfigurations('$DeviceConfigurationPolicyId')/microsoft.graph.windowsWiredNetworkConfiguration/$CertificateName/$certificateId/`$ref"
        Invoke-MgGraphRequest -Method DELETE -Uri $Uri -Body ($ref | ConvertTo-Json) -ErrorAction Stop 4>$null
    }
}

function Get-IntuneDeviceConfigurationCertificateId
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $CertificateId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $CertificateDisplayName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $OdataTypes
    )
    $Certificate = Get-MgBetaDeviceManagementDeviceConfiguration `
        -DeviceConfigurationId $CertificateId `
        -ErrorAction SilentlyContinue | `
            Where-Object -FilterScript {
                $_.AdditionalProperties.'@odata.type' -in $OdataTypes
            }

    if ($null -eq $Certificate)
    {
        Write-Verbose -Message "Could not find certificate with Id {$CertificateId}, searching by display name {$CertificateDisplayName}"

        $Certificate = Get-MgBetaDeviceManagementDeviceConfiguration `
            -Filter "DisplayName eq '$CertificateDisplayName'" `
            -ErrorAction SilentlyContinue | `
                Where-Object -FilterScript {
                    $_.AdditionalProperties.'@odata.type' -in $OdataTypes
                }

        if ($null -eq $Certificate)
        {
            throw "Could not find certificate with Id {$CertificateId} or display name {$CertificateDisplayName}"
        }

        $CertificateId = $Certificate.Id
        Write-Verbose -Message "Found certificate with Id {$($CertificateId)} and DisplayName {$($Certificate.DisplayName)}"
    }
    else
    {
        Write-Verbose -Message "Found certificate with Id {$CertificateId}"
    }

    return $CertificateId
}

Export-ModuleMember -Function *-TargetResource
