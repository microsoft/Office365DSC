function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedODB,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedSPO,

        [Parameter()]
        [System.Boolean]
        $AdvancedRecordVersioningDisabled,

        [Parameter()]
        [System.Boolean]
        $MetadataEditBlockingEnabled,

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

    New-M365DSCConnection -Workload 'PnP' `
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

    $AllowFilesWithKeepLabelToBeDeletedODBValue = Invoke-M365DSCSPORetentionLabelsSetting -CommandName 'GetAllowFilesWithKeepLabelToBeDeletedODB'
    $AllowFilesWithKeepLabelToBeDeletedSPOValue = Invoke-M365DSCSPORetentionLabelsSetting -CommandName 'GetAllowFilesWithKeepLabelToBeDeletedSPO'
    $AdvancedRecordVersioningDisabledValue      = Invoke-M365DSCSPORetentionLabelsSetting -CommandName 'GetAdvancedRecordVersioningDisabled'
    $MetadataEditBlockingEnabledValue           = Invoke-M365DSCSPORetentionLabelsSetting -CommandName 'GetMetadataEditBlockingEnabled'
    try
    {

        $results = @{
            IsSingleInstance      = 'Yes'
            AllowFilesWithKeepLabelToBeDeletedODB = $AllowFilesWithKeepLabelToBeDeletedODBValue
            AllowFilesWithKeepLabelToBeDeletedSPO = $AllowFilesWithKeepLabelToBeDeletedSPOValue
            AdvancedRecordVersioningDisabled      = $AdvancedRecordVersioningDisabledValue
            MetadataEditBlockingEnabled           = $MetadataEditBlockingEnabledValue
            Credential                            = $Credential
            ApplicationId                         = $ApplicationId
            TenantId                              = $TenantId
            CertificateThumbprint                 = $CertificateThumbprint
            ManagedIdentity                       = $ManagedIdentity.IsPresent
            AccessTokens                          = $AccessTokens
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
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedODB,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedSPO,

        [Parameter()]
        [System.Boolean]
        $AdvancedRecordVersioningDisabled,

        [Parameter()]
        [System.Boolean]
        $MetadataEditBlockingEnabled,

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

    if ($AllowFilesWithKeepLabelToBeDeletedODB -ne $currentInstance.AllowFilesWithKeepLabelToBeDeletedODB)
    {
        Write-verbose -Message "Updating AllowFilesWithKeepLabelToBeDeletedODB with value {$AllowFilesWithKeepLabelToBeDeletedODB}"
        Invoke-M365DSCSPORetentionLabelsSetting -CommandName "SetAllowFilesWithKeepLabelToBeDeletedODB" `
                                                -Method 'POST' `
                                                -Body @{allowDeletion = $AllowFilesWithKeepLabelToBeDeletedODB}
    }
    if ($AllowFilesWithKeepLabelToBeDeletedSPO -ne $currentInstance.AllowFilesWithKeepLabelToBeDeletedSPO)
    {
        Write-verbose -Message "Updating AllowFilesWithKeepLabelToBeDeletedSPO with value {$AllowFilesWithKeepLabelToBeDeletedSPO}"
        Invoke-M365DSCSPORetentionLabelsSetting -CommandName "SetAllowFilesWithKeepLabelToBeDeletedSPO" `
                                                -Method 'POST' `
                                                -Body @{allowDeletion = $AllowFilesWithKeepLabelToBeDeletedSPO}
    }
    if ($AdvancedRecordVersioningDisabled -ne $currentInstance.AdvancedRecordVersioningDisabled)
    {
        Write-verbose -Message "Updating AdvancedRecordVersioningDisabled with value {$AdvancedRecordVersioningDisabled}"
        Invoke-M365DSCSPORetentionLabelsSetting -CommandName "SetAdvancedRecordVersioningDisabled" `
                                                -Method 'POST' `
                                                -Body @{disabled = $AdvancedRecordVersioningDisabled}
    }
    if ($MetadataEditBlockingEnabled -ne $currentInstance.MetadataEditBlockingEnabled)
    {
        Write-verbose -Message "Updating MetadataEditBlockingEnabled with value {$MetadataEditBlockingEnabled}"
        Invoke-M365DSCSPORetentionLabelsSetting -CommandName "SetMetadataEditBlockingEnabled" `
                                                -Method 'POST' `
                                                -Body @{enabled = $MetadataEditBlockingEnabled}
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedODB,

        [Parameter()]
        [System.Boolean]
        $AllowFilesWithKeepLabelToBeDeletedSPO,

        [Parameter()]
        [System.Boolean]
        $AdvancedRecordVersioningDisabled,

        [Parameter()]
        [System.Boolean]
        $MetadataEditBlockingEnabled,

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

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

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

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
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

        $dscContent = ''
        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }
        $params = @{
            IsSingleInstance      = 'Yes'
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
        Write-Host $Global:M365DSCEmojiGreenCheckMark
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

function Invoke-M365DSCSPORetentionLabelsSetting
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $CommandName,

        [Parameter()]
        [System.String]
        $Method = "GET",

        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    try
    {
        $url = $($MSCloudLoginConnectionProfile.SharePointOnlineREST.AdminUrl) + `
            "/_api/SP.CompliancePolicy.SPPolicyStoreProxy.$($CommandName)/"

        $invokeParams = @{
            Url = $url
            Method = $Method
            Content = $Body
        }

        $result = Invoke-PnPSPRestMethod @invokeParams

        if ($Method -eq 'GET')
        {
            return $result.Value
        }
    }
    catch
    {
        throw $_
    }

    return $true
}

Export-ModuleMember -Function *-TargetResource
