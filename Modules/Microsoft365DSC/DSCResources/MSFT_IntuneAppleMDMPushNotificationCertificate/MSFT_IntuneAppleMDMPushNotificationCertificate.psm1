function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune params

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AppleIdentifier,

        [Parameter()]
        [System.String]
        $Certificate,

        [Parameter()]
        [System.String]
        $TopicIdentifier,

        [Parameter()]
        [System.String]
        $CertificateSerialNumber,

        [Parameter()]
        [System.DateTime]
        $LastModifiedDateTime,

        [Parameter()]
        [System.DateTime]
        $ExpirationDateTime,

        [Parameter()]
        [System.String]
        $CertificateUploadStatus,

        [Parameter()]
        [System.String]
        $CertificateUploadFailureReason,

        #endregion Intune params

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
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

    try
    {
        $instance = $null
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Id -eq $Id}
        }

        if ($null -eq $instance)
        {
            # There is only one Apple push notification certificate per tenant so no need to filter by Id
            $instance = Get-MgBetaDeviceManagementApplePushNotificationCertificate -ErrorAction Stop

            if ($null -eq $instance)
            {
                Write-Verbose -Message "Apple push notification certificate."
                return $nullResult
            }
        }

        $results = @{
            Id                             = $instance.Id
            AppleIdentifier                = $instance.AppleIdentifier
            Certificate                    = $instance.Certificate
            TopicIdentifier                = $instance.TopicIdentifier
            CertificateSerialNumber        = $instance.CertificateSerialNumber
            LastModifiedDateTime           = $instance.LastModifiedDateTime
            ExpirationDateTime             = $instance.ExpirationDateTime
            CertificateUploadStatus        = $instance.CertificateUploadStatus
            CertificateUploadFailureReason = $instance.CertificateUploadFailureReason

            Ensure                         = 'Present'
            Credential                     = $Credential
            ApplicationId                  = $ApplicationId
            TenantId                       = $TenantId
            CertificateThumbprint          = $CertificateThumbprint
            ApplicationSecret              = $ApplicationSecret
            ManagedIdentity                = $ManagedIdentity.IsPresent
            AccessTokens                   = $AccessTokens
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
        #region Intune params

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AppleIdentifier,

        [Parameter()]
        [System.String]
        $Certificate,

        [Parameter()]
        [System.String]
        $TopicIdentifier,

        [Parameter()]
        [System.String]
        $CertificateSerialNumber,

        [Parameter()]
        [System.DateTime]
        $LastModifiedDateTime,

        [Parameter()]
        [System.DateTime]
        $ExpirationDateTime,

        [Parameter()]
        [System.String]
        $CertificateUploadStatus,

        [Parameter()]
        [System.String]
        $CertificateUploadFailureReason,

        #endregion Intune params

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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

    $SetParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters
    $SetParameters.Remove('Id') | Out-Null
    $SetParameters.Remove('TopicIdentifier') | Out-Null
    $SetParameters.Remove('LastModifiedDateTime') | Out-Null
    $SetParameters.Remove('ExpirationDateTime') | Out-Null
    $SetParameters.Remove('CertificateUploadStatus') | Out-Null
    $SetParameters.Remove('CertificateUploadFailureReason') | Out-Null
    $SetParameters.Remove('CertificateSerialNumber') | Out-Null

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Apple Push Notification Certificate with Apple ID: '$AppleIdentifier'."

        # There is only PATCH request hence using Update cmdlet to post the certificate
        Update-MgBetaDeviceManagementApplePushNotificationCertificate @SetParameters
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Apple Push Notification Certificate with Apple ID: '$AppleIdentifier'."
        Update-MgBetaDeviceManagementApplePushNotificationCertificate @SetParameters
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Apple Push Notification Certificate with Apple ID: '$AppleIdentifier' by patching with empty certificate."

        # There is only PATCH request hence using Update cmdlet to remove the certificate by passing empty certificate as param.
        $params = @{}
        Update-MgBetaDeviceManagementApplePushNotificationCertificate $params
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region Intune params

        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AppleIdentifier,

        [Parameter()]
        [System.String]
        $Certificate,

        [Parameter()]
        [System.String]
        $TopicIdentifier,

        [Parameter()]
        [System.String]
        $CertificateSerialNumber,

        [Parameter()]
        [System.DateTime]
        $LastModifiedDateTime,

        [Parameter()]
        [System.DateTime]
        $ExpirationDateTime,

        [Parameter()]
        [System.String]
        $CertificateUploadStatus,

        [Parameter()]
        [System.String]
        $CertificateUploadFailureReason,

        #endregion Intune params

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck
    $ValuesToCheck.Remove('Id') | Out-Null

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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
        [array] $Script:exportedInstances = Get-MgBetaDeviceManagementApplePushNotificationCertificate -ErrorAction Stop

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
            $displayedKey = $config.Id
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline

            $params = @{
                Id                             = $config.Id
                AppleIdentifier                = $config.AppleIdentifier
                Certificate                    = $config.Certificate
                TopicIdentifier                = $config.TopicIdentifier
                CertificateSerialNumber        = $config.CertificateSerialNumber
                LastModifiedDateTime           = $config.LastModifiedDateTime
                ExpirationDateTime             = $config.ExpirationDateTime
                CertificateUploadStatus        = $config.CertificateUploadStatus
                CertificateUploadFailureReason = $config.CertificateUploadFailureReason

                Ensure                         = 'Present'
                Credential                     = $Credential
                ApplicationId                  = $ApplicationId
                TenantId                       = $TenantId
                CertificateThumbprint          = $CertificateThumbprint
                ApplicationSecret              = $ApplicationSecret
                ManagedIdentity                = $ManagedIdentity.IsPresent
                AccessTokens                   = $AccessTokens
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
