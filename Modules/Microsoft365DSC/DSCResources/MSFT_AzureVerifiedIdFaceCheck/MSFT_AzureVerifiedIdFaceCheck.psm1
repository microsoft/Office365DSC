function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $VerifiedIdAuthorityId,

        [Parameter()]
        [System.Boolean]
        $FaceCheckEnabled,

        [Parameter()]
        [System.String]
        $VerifiedIdAuthorityLocation,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'Azure' `
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
        $resourceGroupInstance = Get-AzResourceGroup -Id "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)" -ErrorAction SilentlyContinue
        if ($null -eq $resourceGroupInstance)
        {
            return $nullResult
        }

        $uri = "https://management.azure.com/$($resourceGroupInstance.ResourceId)/providers/Microsoft.VerifiedId/authorities/$($VerifiedIdAuthorityId)?api-version=2024-01-26-preview"
        $response = Invoke-AzRest -Uri $uri -Method Get
        $authorities = ConvertFrom-Json $response.Content

        $EnabledValue = $false
        if ($null -eq $authorities.error -and $null -ne $authorities.id)
        {
            $EnabledValue = $true
        }

        $results = @{
            SubscriptionId              = $SubscriptionId
            ResourceGroupName           = $ResourceGroupName
            VerifiedIdAuthorityId       = $VerifiedIdAuthorityId
            VerifiedIdAuthorityLocation = $authorities.location
            FaceCheckEnabled            = $EnabledValue
            Ensure                      = 'Present'
            Credential                  = $Credential
            ApplicationId               = $ApplicationId
            TenantId                    = $TenantId
            CertificateThumbprint       = $CertificateThumbprint
            ManagedIdentity             = $ManagedIdentity.IsPresent
            AccessTokens                = $AccessTokens
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
        [System.String]
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $VerifiedIdAuthorityId,

        [Parameter()]
        [System.Boolean]
        $FaceCheckEnabled,

        [Parameter()]
        [System.String]
        $VerifiedIdAuthorityLocation,

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

    New-M365DSCConnection -Workload 'Azure' `
        -InboundParameters $PSBoundParameters | Out-Null
    if ($FaceCheckEnabled)
    {
        Write-Verbose -Message "Enabling FaceCheck on Verified ID Authority {$($VerifiedIDAuthorityId)}"
        $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.VerifiedId/authorities/$($VerifiedIdAuthorityId)?api-version=2024-01-26-preview"
        $payload = '{"location": "' + $VerifiedIdAuthorityLocation + '"}'
        $response = Invoke-AzRest -Uri $uri -Method Put -Payload $payload
    }
    else
    {
        Write-Verbose -Message "Disabling FaceCheck on Verified ID Authority {$($VerifiedIDAuthorityId)}"
        $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.VerifiedId/authorities/$($VerifiedIdAuthorityId)?api-version=2024-01-26-preview"
        $payload = '{"location": null}'
        $response = Invoke-AzRest -Uri $uri -Method DELETE
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
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $VerifiedIdAuthorityId,

        [Parameter()]
        [System.Boolean]
        $FaceCheckEnabled,

        [Parameter()]
        [System.String]
        $VerifiedIdAuthorityLocation,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'AdminAPI' `
        -InboundParameters $PSBoundParameters
    $ConnectionMode = New-M365DSCConnection -Workload 'Azure' `
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
        $headers = @{
            Authorization = $Global:MSCloudLoginConnectionProfile.AdminAPI.AccessToken
        }
        $uri = 'https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities'
        $response = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
        $authorities = ConvertFrom-Json $response.Content

        $resourceGroups = Get-AzResourceGroup -ErrorAction Stop
        $i = 1
        $dscContent = ''
        if ($resourceGroups.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $j = 1
        foreach ($resourceGroup in $resourceGroups)
        {
            $displayedKey = $resourceGroup.ResourceGroupName
            Write-Host "    |---[$j/$($resourceGroups.Length)] $displayedKey" -NoNewline

            if ($authorities.Length -eq 0)
            {
                Write-Host $Global:M365DSCEmojiGreenCheckMark
            }
            else
            {
                Write-Host "`r`n" -NoNewline
            }

            $i = 1
            foreach ($authority in $authorities.value)
            {
                $uri = "https://management.azure.com/$($resourceGroup.ResourceId)/providers/Microsoft.VerifiedId/authorities/$($authority.id)?api-version=2024-01-26-preview"
                $response = Invoke-AzRest -Uri $uri -Method Get
                $entries = ConvertFrom-Json $response.Content

                $Global:M365DSCExportResourceInstancesCount++

                $displayedKey = $authority.name
                Write-Host "        |---[$i/$($authorities.value.Length)] $displayedKey" -NoNewline

                $SubscriptionId = $resourceGroup.ResourceId.Split('/')
                $SubscriptionId = $SubscriptionId[2]

                $params = @{
                    VerifiedIdAuthorityId = $authority.id
                    SubscriptionId        = $SubscriptionId
                    ResourceGroupName     = $resourceGroup.ResourceGroupName
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
            $j++
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
