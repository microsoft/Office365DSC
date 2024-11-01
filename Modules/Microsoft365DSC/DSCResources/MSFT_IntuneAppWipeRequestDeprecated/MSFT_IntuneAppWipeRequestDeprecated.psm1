function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Status,

        [Parameter()]
        [System.String]
        $TargetedUserId,

        [Parameter()]
        [System.String]
        $TargetedDeviceRegistrationId,

        [Parameter()]
        [System.String]
        $TargetedDeviceName,

        [Parameter()]
        [System.String]
        $TargetedDeviceMacAddress,

        #endregion

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
        try {
        # Retrieve all Wipe Actions for Windows Information Protection
        $allActions = Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -ErrorAction Stop
        } catch {
            Write-Verbose "Cmdlet Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction did not return any data or encountered an issue."
            return $nullResult
        }
        # Check if $allActions is null or empty
        if (-not $allActions) {
            Write-Verbose "No Windows Information Protection Wipe Action instances found."
            return $nullResult
        }

        # Filter the results to find the specific action by ID
        $specificAction = $allActions | Where-Object { $_.id -eq $Id }

        if (-not $specificAction) {
            Write-Verbose "No Windows Information Protection Wipe Action found with Id $Id."
            return $nullResult
        }

        $results = @{
            Id                           = $specificAction.id
            Status                       = $specificAction.status
            TargetedUserId               = $specificAction.targetedUserId
            TargetedDeviceRegistrationId = $specificAction.targetedDeviceRegistrationId
            TargetedDeviceName           = $specificAction.targetedDeviceName
            TargetedDeviceMacAddress     = $specificAction.targetedDeviceMacAddressEnsure                = 'Present'
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            TenantId                     = $TenantId
            CertificateThumbprint        = $CertificateThumbprint
            ManagedIdentity              = $ManagedIdentity.IsPresent
            AccessTokens                 = $AccessTokens
        }
        return $results
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
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Status,

        [Parameter()]
        [System.String]
        $TargetedUserId,

        [Parameter()]
        [System.String]
        $TargetedDeviceRegistrationId,

        [Parameter()]
        [System.String]
        $TargetedDeviceName,

        [Parameter()]
        [System.String]
        $TargetedDeviceMacAddress,

        #endregion

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
        Write-Host "Creating a new Windows Information Protection Wipe Action..."

        try {
            $newParams = @{
                TargetedUserId              = $TargetedUserId
                TargetedDeviceRegistrationId = $TargetedDeviceRegistrationId
                TargetedDeviceName          = $TargetedDeviceName
                TargetedDeviceMacAddress    = $TargetedDeviceMacAddress
                Status                      = $Status
                LastCheckInDateTime         = (Get-Date).ToString("o")
            }

            if ((Get-Command -Name "New-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction" -ErrorAction SilentlyContinue) -and $SupportsPost) {
                New-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction @newParams
            }
            else {
                Write-Output "Creation of WindowsInformationProtectionWipeAction is unsupported or unavailable."
            }
        }
        catch {
            Write-Output "Creation failed: $_"
        }

    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
       Write-Verbose "Removing the existing Windows Information Protection Wipe Action with ID: $Id"

       # Call Remove cmdlet to delete the resource by its ID
       Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -WindowsInformationProtectionWipeActionId $Id
   }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region Intune resource parameters

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Status,

        [Parameter()]
        [System.String]
        $TargetedUserId,

        [Parameter()]
        [System.String]
        $TargetedDeviceRegistrationId,

        [Parameter()]
        [System.String]
        $TargetedDeviceName,

        [Parameter()]
        [System.String]
        $TargetedDeviceMacAddress,

        #endregion

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

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
    if (-not $CurrentValues) {
        Write-Verbose "Get-TargetResource returned null. Assuming resource is Absent."

        # Determine if resource is absent based on Ensure value
        if ($Ensure -eq 'Absent') {
            Write-Verbose "Test-TargetResource: Desired state is 'Absent', and resource is not present. Returning $true."
            return $true
        } else {
            Write-Verbose "Test-TargetResource: Desired state is 'Present', but resource is not present. Returning $false."
            return $false
        }
    }
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

function Export-TargetResource {
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
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

    # Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    # Telemetry data
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data

    try {
        $Script:ExportMode = $true
        Write-Verbose "Attempting to retrieve wipe actions using Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction..."

        # Check if the cmdlet exists to handle deprecation
        if (Get-Command -Name 'Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction' -ErrorAction SilentlyContinue) {
            try {
                [array]$Script:exportedInstances = Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -ErrorAction Stop
            }
            catch {
                Write-Verbose "Cmdlet Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction did not return any data or encountered an issue."
                return ''
            }
        }
        else {
            Write-Verbose "Cmdlet Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction is not available or deprecated."
            return ''
        }

        if (-not $Script:exportedInstances -or $Script:exportedInstances.Count -eq 0) {
            Write-Verbose "No Windows Information Protection Wipe Action instances found."
            return ''
        }

        $dscContent = ''
        $i = 1
        foreach ($config in $Script:exportedInstances) {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount) {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = $config.Id
            Write-Host "Processing [$i/$($Script:exportedInstances.Count)] $displayedKey"

            $params = @{
                Id                    = $config.Id
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ApplicationSecret     = $ApplicationSecret
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @params
            if (-not $Results) {
                Write-Verbose "Warning: No results returned for config with Id $displayedKey."
                continue
            }

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
        }

        return $dscContent
    }
    catch {
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
