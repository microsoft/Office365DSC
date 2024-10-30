function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $AccountId,

        [Parameter()]
        [System.Boolean]
        $ConfigureWifi,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Int32]
        $EnrolledDeviceCount,

        [Parameter()]
        [System.String]
        [ValidateSet( 'corporateOwnedDedicatedDevice', 'corporateOwnedFullyManaged', 'corporateOwnedWorkProfile', 'corporateOwnedAOSPUserlessDevice', 'corporateOwnedAOSPUserAssociatedDevice')]
        $EnrollmentMode,

        [Parameter()]
        [ValidateSet( 'default', 'corporateOwnedDedicatedDeviceWithAzureADSharedMode', 'deviceStaging')]
        $EnrollmentTokenType,

        [Parameter()]
        [System.Int32]
        $EnrollmentTokenUsageCount,

        [Parameter()]
        [System.Boolean]
        $IsTeamsDeviceProfile,

        [Parameter()]
        [System.String]
        $QrCodeContent,

        [Parameter()]
        [System.String]
        $QrCodeImage,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $TokenValue,

        [Parameter()]
        [System.String]
        $TokenCreationDateTime,

        [Parameter()]
        [System.String]
        $TokenExpirationDateTime,

        [Parameter()]
        [System.Boolean]
        $WifiHidden,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $WifiPassword,

        [Parameter()]
        [System.String]
        [ValidateSet( 'none', 'wpa', 'wep' )]
        $WifiSecurityType,

        [Parameter()]
        [System.String]
        $WifiSsid,

        [Parameter()]
        [System.String]
        [ValidateSet('Present', 'Absent')]
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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Checking for the Intune Android Device Owner Enrollment Profile {$DisplayName}"
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
        if (-not [System.String]::IsNullOrEmpty($Id))
        {
            Write-Verbose -Message "Trying to retrieve profile by Id"
            $androidDeviceOwnerEnrollmentProfile = Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile `
                -AndroidDeviceOwnerEnrollmentProfileId $Id
        }
        if ($null -eq $androidDeviceOwnerEnrollmentProfile)
        {
            Write-Verbose -Message "Trying to retrieve profile by DisplayName"
            $androidDeviceOwnerEnrollmentProfile = Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile `
                -Filter "displayName eq '$DisplayName'" `
                -ErrorAction SilentlyContinue
        }

        if ($null -eq $androidDeviceOwnerEnrollmentProfile)
        {
            Write-Verbose -Message "No AndroidDeviceOwnerEnrollmentProfiles with {$Id} was found."
            return $nullResult
        }

        $results = @{
            Id                        = $androidDeviceOwnerEnrollmentProfile.Id
            DisplayName               = $androidDeviceOwnerEnrollmentProfile.DisplayName
            AccountId                 = $androidDeviceOwnerEnrollmentProfile.AccountId
            ConfigureWifi             = $androidDeviceOwnerEnrollmentProfile.ConfigureWifi
            Description               = $androidDeviceOwnerEnrollmentProfile.Description
            EnrolledDeviceCount       = $androidDeviceOwnerEnrollmentProfile.EnrolledDeviceCount
            EnrollmentMode            = $androidDeviceOwnerEnrollmentProfile.EnrollmentMode.ToString()
            EnrollmentTokenType       = $androidDeviceOwnerEnrollmentProfile.EnrollmentTokenType.ToString()
            EnrollmentTokenUsageCount = $androidDeviceOwnerEnrollmentProfile.EnrollmentTokenUsageCount
            IsTeamsDeviceProfile      = $androidDeviceOwnerEnrollmentProfile.IsTeamsDeviceProfile
            QrCodeContent             = $androidDeviceOwnerEnrollmentProfile.QrCodeContent
            QrCodeImage               = $androidDeviceOwnerEnrollmentProfile.QrCodeImage
            RoleScopeTagIds           = $androidDeviceOwnerEnrollmentProfile.RoleScopeTagIds
            TokenCreationDateTime     = $androidDeviceOwnerEnrollmentProfile.TokenCreationDateTime.ToString()
            TokenExpirationDateTime   = $androidDeviceOwnerEnrollmentProfile.TokenExpirationDateTime.ToString()
            TokenValue                = $androidDeviceOwnerEnrollmentProfile.TokenValue
            WifiHidden                = $androidDeviceOwnerEnrollmentProfile.WifiHidden
            WifiPassword              = $androidDeviceOwnerEnrollmentProfile.WifiPassword
            WifiSecurityType          = $androidDeviceOwnerEnrollmentProfile.WifiSecurityType.ToString()
            WifiSsid                  = $androidDeviceOwnerEnrollmentProfile.WifiSsid

            Ensure                    = 'Present'
            Credential                = $Credential
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            ManagedIdentity           = $ManagedIdentity.IsPresent
            AccessTokens              = $AccessTokens
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
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $AccountId,

        [Parameter()]
        [System.Boolean]
        $ConfigureWifi,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Int32]
        $EnrolledDeviceCount,

        [Parameter()]
        [System.String]
        [ValidateSet( 'corporateOwnedDedicatedDevice', 'corporateOwnedFullyManaged', 'corporateOwnedWorkProfile', 'corporateOwnedAOSPUserlessDevice', 'corporateOwnedAOSPUserAssociatedDevice')]
        $EnrollmentMode,

        [Parameter()]
        [ValidateSet( 'default', 'corporateOwnedDedicatedDeviceWithAzureADSharedMode', 'deviceStaging')]
        $EnrollmentTokenType,

        [Parameter()]
        [System.Int32]
        $EnrollmentTokenUsageCount,

        [Parameter()]
        [System.Boolean]
        $IsTeamsDeviceProfile,

        [Parameter()]
        [System.String]
        $QrCodeContent,

        [Parameter()]
        [System.String]
        $QrCodeImage,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $TokenValue,

        [Parameter()]
        [System.String]
        $TokenCreationDateTime,

        [Parameter()]
        [System.String]
        $TokenExpirationDateTime,

        [Parameter()]
        [System.Boolean]
        $WifiHidden,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $WifiPassword,

        [Parameter()]
        [System.String]
        [ValidateSet( 'none', 'wpa', 'wep' )]
        $WifiSecurityType,

        [Parameter()]
        [System.String]
        $WifiSsid,

        [Parameter()]
        [System.String]
        [ValidateSet('Present', 'Absent')]
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
        Write-Verbose -Message "Create AndroidDeviceOwnerEnrollmentProfile: $DisplayName with Enrollment Mode: $EnrollmentMode"

        $setParameters.remove('Id') | Out-Null
        $setParameters.remove('Ensure') | Out-Null
        $setParameters.Remove('Verbose') | Out-Null
        $response = New-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile @setParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating AndroidDeviceOwnerEnrollmentProfile: $DisplayName"        
        Remove-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -AndroidDeviceOwnerEnrollmentProfileId $currentInstance.Id -Confirm:$false
        $response = New-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile @setParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing AndroidDeviceOwnerEnrollmentProfile: $DisplayName"
        Remove-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -AndroidDeviceOwnerEnrollmentProfileId $currentInstance.Id -Confirm:$false
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
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $AccountId,

        [Parameter()]
        [System.Boolean]
        $ConfigureWifi,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Int32]
        $EnrolledDeviceCount,

        [Parameter()]
        [System.String]
        [ValidateSet( 'corporateOwnedDedicatedDevice', 'corporateOwnedFullyManaged', 'corporateOwnedWorkProfile', 'corporateOwnedAOSPUserlessDevice', 'corporateOwnedAOSPUserAssociatedDevice')]
        $EnrollmentMode,

        [Parameter()]
        [ValidateSet( 'default', 'corporateOwnedDedicatedDeviceWithAzureADSharedMode', 'deviceStaging')]
        $EnrollmentTokenType,

        [Parameter()]
        [System.Int32]
        $EnrollmentTokenUsageCount,

        [Parameter()]
        [System.Boolean]
        $IsTeamsDeviceProfile,

        [Parameter()]
        [System.String]
        $QrCodeContent,

        [Parameter()]
        [System.String]
        $QrCodeImage,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $TokenValue,

        [Parameter()]
        [System.String]
        $TokenCreationDateTime,

        [Parameter()]
        [System.String]
        $TokenExpirationDateTime,

        [Parameter()]
        [System.Boolean]
        $WifiHidden,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $WifiPassword,

        [Parameter()]
        [System.String]
        [ValidateSet( 'none', 'wpa', 'wep' )]
        $WifiSecurityType,

        [Parameter()]
        [System.String]
        $WifiSsid,

        [Parameter()]
        [System.String]
        [ValidateSet('Present', 'Absent')]
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

    Write-Verbose -Message "Testing configuration of AndroidDeviceOwnerEnrollmentProfile: {$DisplayName}"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('WifiPassword') | Out-Null
    $CurrentValues = Get-TargetResource @PSBoundParameters
    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    $TestResult = Test-M365DSCParameterState `
            -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys

            Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
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
        [array] $Script:exportedInstances = Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -ErrorAction Stop

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
            $displayedKey = $config.DisplayName
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.Id
                DisplayName           = $config.DisplayName

                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
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
