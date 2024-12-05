function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $PeriodOnlineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $AllowedInboundDataTransferSources,

        [Parameter()]
        [System.String]
        $AllowedOutboundDataTransferDestinations,

        [Parameter()]
        [System.Boolean]
        $OrganizationalCredentialsRequired,

        [Parameter()]
        [System.String]
        $AllowedOutboundClipboardSharingLevel,

        [Parameter()]
        [System.Boolean]
        $DataBackupBlocked,

        [Parameter()]
        [System.Boolean]
        $DeviceComplianceRequired,

        [Parameter()]
        [System.Boolean]
        $ManagedBrowserToOpenLinksRequired,

        [Parameter()]
        [System.Boolean]
        $SaveAsBlocked,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeWipeIsEnforced,

        [Parameter()]
        [System.Boolean]
        $PinRequired,

        [Parameter()]
        [System.Boolean]
        $DisableAppPinIfDevicePinIsSet,

        [Parameter()]
        [System.UInt32]
        $MaximumPinRetries,

        [Parameter()]
        [System.Boolean]
        $SimplePinBlocked,

        [Parameter()]
        [System.UInt32]
        $MinimumPinLength,

        [Parameter()]
        [System.String]
        $PinCharacterSet,

        [Parameter()]
        [System.String[]]
        $AllowedDataStorageLocations,

        [Parameter()]
        [System.Boolean]
        $ContactSyncBlocked,

        [Parameter()]
        [System.String]
        $PeriodBeforePinReset,

        [Parameter()]
        [System.Boolean]
        $PrintBlocked,

        [Parameter()]
        [System.Boolean]
        $RequireClass3Biometrics,

        [Parameter()]
        [System.Boolean]
        $RequirePinAfterBiometricChange,

        [Parameter()]
        [System.Boolean]
        $FingerprintBlocked,

        [Parameter()]
        [System.Boolean]
        $DisableAppEncryptionIfDeviceEncryptionIsEnabled,

        [Parameter()]
        [System.String]
        $CustomBrowserDisplayName,

        [Parameter()]
        [System.String]
        $CustomBrowserPackageId,

        [Parameter()]
        [System.String[]]
        $Apps,

        [Parameter()]
        [ValidateSet('allApps', 'allMicrosoftApps', 'allCoreMicrosoftApps', 'selectedPublicApps' )]
        [System.String]
        $AppGroupType,

        [Parameter()]
        [System.String[]]
        $Assignments,

        [Parameter()]
        [System.String[]]
        $ExcludedGroups,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'microsoftEdge')]
        $ManagedBrowser,

        [Parameter()]
        [System.String]
        $MinimumRequiredAppVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredOSVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredPatchVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningAppVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningOSVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningPatchVersion,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Boolean]
        $ScreenCaptureBlocked,

        [Parameter()]
        [System.Boolean]
        $EncryptAppData,

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
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    Write-Verbose -Message "Checking for the Intune Android App Protection Policy {$DisplayName}"
    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

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

    $nullResult = $PSBoundParameters
    $nullResult.Ensure = 'Absent'

    try
    {
        if ($id -ne '')
        {
            Write-Verbose -Message "Searching for Policy using Id {$Id}"
            $policyInfo = Get-MgBetaDeviceAppManagementAndroidManagedAppProtection -Filter "Id eq '$Id'" -ExpandProperty Apps, assignments `
                -ErrorAction Stop
            if ($null -eq $policyInfo)
            {
                Write-Verbose -Message "No Android App Protection Policy with Id {$Id} was found"
                Write-Verbose -Message "Function will now search for a policy with the same displayName {$Displayname} - If found this policy will be amended"
            }
        }
        if ($null -eq $policyInfo)
        {
            Write-Verbose -Message "Searching for Policy using DisplayName {$DisplayName}"
            $policyInfoArray = Get-MgBetaDeviceAppManagementAndroidManagedAppProtection -ExpandProperty Apps, assignments `
                -ErrorAction Stop -All:$true
            $policyInfo = $policyInfoArray | Where-Object -FilterScript { $_.displayName -eq $DisplayName }
        }
        if ($null -eq $policyInfo)
        {
            Write-Verbose -Message "No Android App Protection Policy {$DisplayName} was found"
            return $nullResult
        }

        # handle multiple results - throw error - may be able to remediate to specify ID in configuration at later date
        if ($policyInfo.gettype().isarray)
        {
            Write-Verbose -Message "Multiple Android Policies with name {$DisplayName} were found - Where No valid ID is specified Module will only function with unique names, please manually remediate"
            $nullResult.Ensure = 'ERROR'
            throw 'Multiple Policies with same displayname identified - Module currently only functions with unique names'
        }

        Write-Verbose -Message "Found Android App Protection Policy {$DisplayName}"

        $appsArray = @()
        if ($null -ne $policyInfo.Apps)
        {
            foreach ($app in $policyInfo.Apps)
            {
                $appsArray += $app.MobileAppIdentifier.AdditionalProperties.packageId
            }
        }

        $assignmentsArray = @()
        $exclusionArray = @()
        if ($null -ne $policyInfo.Assignments)
        {
            foreach ($assignment in $policyInfo.Assignments)
            {
                switch ($assignment.Target.AdditionalProperties.'@odata.type')
                {
                    '#microsoft.graph.groupAssignmentTarget'
                    {
                        $assignmentsArray += $assignment.Target.AdditionalProperties.groupId
                    }

                    '#microsoft.graph.exclusionGroupAssignmentTarget'
                    {
                        $exclusionArray += $assignment.Target.AdditionalProperties.groupId
                    }
                }
            }
        }
        $Allparams = get-InputParameters
        $policy = @{}

        #loop regular parameters and add from $polycyinfo
        foreach ($param in ($Allparams.keys | Where-Object { $allparams.$_.Type -eq 'Parameter' }) )
        {
            # we need to process this because reverseDSC doesn't handle certain object types
            switch ($Allparams.$param.ExportFileType)
            {
                'String'
                {
                    $policy.add($param, $policyInfo.$param.tostring())
                }

                'Array'
                {
                    $tmparray = @()
                    $policyInfo.$param | ForEach-Object { $tmparray += $_.tostring() }
                    $policy.add($param, $tmparray)
                }

                DEFAULT
                {
                    $policy.add($param, $policyInfo.$param)
                }
            }
        }
        # loop credential parameters and add them from input params
        foreach ($param in ($Allparams.keys | Where-Object { $allparams.$_.Type -eq 'Credential' }) )
        {
            $policy.add($param, (Get-Variable -Name $param).value)
        }
        # fix for managed identity credential value
        $policy.add('ManagedIdentity', $ManagedIdentity.IsPresent)
        # add complex parameters manually as they all have different requirements - potential to change in future
        $policy.add('Ensure', 'Present')
        $policy.add('Apps', $appsArray)
        $policy.add('Assignments', $assignmentsArray)
        $policy.add('ExcludedGroups', $exclusionArray)
        $policy.add('AppGroupType', $policyInfo.AppGroupType.toString())
        #managed browser settings - export as is, when re-applying function will correct
        $policy.add('ManagedBrowser', $policyInfo.ManagedBrowser.toString())
        $policy.add('ManagedBrowserToOpenLinksRequired', $policyInfo.ManagedBrowserToOpenLinksRequired)
        $policy.add('CustomBrowserDisplayName', $policyInfo.CustomBrowserDisplayName)
        $policy.add('CustomBrowserPackageId', $policyInfo.CustomBrowserPackageId)
        $policy.add('AccessTokens', $AccessTokens)

        return $policy
    }
    catch
    {
        if ($_.Exception.Message -eq 'Multiple Policies with same displayname identified - Module currently only functions with unique names')
        {
            throw $_
        }
        else
        {
            New-M365DSCLogEntry -Message 'Error retrieving data:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential

            $nullResult = Clear-M365DSCAuthenticationParameter -BoundParameters $nullResult
            return $nullResult
        }
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $PeriodOnlineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $AllowedInboundDataTransferSources,

        [Parameter()]
        [System.String]
        $AllowedOutboundDataTransferDestinations,

        [Parameter()]
        [System.Boolean]
        $OrganizationalCredentialsRequired,

        [Parameter()]
        [System.String]
        $AllowedOutboundClipboardSharingLevel,

        [Parameter()]
        [System.Boolean]
        $DataBackupBlocked,

        [Parameter()]
        [System.Boolean]
        $DeviceComplianceRequired,

        [Parameter()]
        [System.Boolean]
        $ManagedBrowserToOpenLinksRequired,

        [Parameter()]
        [System.Boolean]
        $SaveAsBlocked,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeWipeIsEnforced,

        [Parameter()]
        [System.Boolean]
        $PinRequired,

        [Parameter()]
        [System.Boolean]
        $DisableAppPinIfDevicePinIsSet,

        [Parameter()]
        [System.UInt32]
        $MaximumPinRetries,

        [Parameter()]
        [System.Boolean]
        $SimplePinBlocked,

        [Parameter()]
        [System.UInt32]
        $MinimumPinLength,

        [Parameter()]
        [System.String]
        $PinCharacterSet,

        [Parameter()]
        [System.String[]]
        $AllowedDataStorageLocations,

        [Parameter()]
        [System.Boolean]
        $ContactSyncBlocked,

        [Parameter()]
        [System.String]
        $PeriodBeforePinReset,

        [Parameter()]
        [System.Boolean]
        $PrintBlocked,

        [Parameter()]
        [System.Boolean]
        $RequireClass3Biometrics,

        [Parameter()]
        [System.Boolean]
        $RequirePinAfterBiometricChange,

        [Parameter()]
        [System.Boolean]
        $FingerprintBlocked,

        [Parameter()]
        [System.Boolean]
        $DisableAppEncryptionIfDeviceEncryptionIsEnabled,

        [Parameter()]
        [System.String]
        $CustomBrowserDisplayName,

        [Parameter()]
        [System.String]
        $CustomBrowserPackageId,

        [Parameter()]
        [System.String[]]
        $Apps,

        [Parameter()]
        [ValidateSet('allApps', 'allMicrosoftApps', 'allCoreMicrosoftApps', 'selectedPublicApps' )]
        [System.String]
        $AppGroupType,

        [Parameter()]
        [System.String[]]
        $Assignments,

        [Parameter()]
        [System.String[]]
        $ExcludedGroups,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'microsoftEdge')]
        $ManagedBrowser,

        [Parameter()]
        [System.String]
        $MinimumRequiredAppVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredOSVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredPatchVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningAppVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningOSVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningPatchVersion,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Boolean]
        $ScreenCaptureBlocked,

        [Parameter()]
        [System.Boolean]
        $EncryptAppData,

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
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

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

    $currentPolicy = Get-TargetResource @PSBoundParameters

    if ($currentPolicy.Ensure -eq 'ERROR')
    {

        Throw 'Error when searching for current policy details - Please check verbose output for further detail'

    }
    if (($Ensure -eq 'Absent') -and ($currentPolicy.Ensure -eq 'Present'))
    {
        Write-Verbose -Message "Removing Android App Protection Policy {$DisplayName}"
        Remove-MgBetaDeviceAppManagementAndroidManagedAppProtection -AndroidManagedAppProtectionId $currentPolicy.id
        # then exit
        return
    }

    $setParams = @{}
    $assignmentsArray = @()
    $appsarray = @()

    $configstring = "`r`nConfiguration To Be Applied:`r`n"

    $Allparams = get-InputParameters

    # loop through regular parameters
    foreach ($param in ($Allparams.keys | Where-Object { $allparams.$_.Type -eq 'Parameter' }) )
    {
        if ($PSBoundParameters.keys -contains $param )
        {
            switch ($Allparams.$param.ExportFileType)
            {
                'Duration'
                {
                    $setParams.add($param, (set-TimeSpan -duration $PSBoundParameters.$param))
                    $configstring += ($param + ':' + ($setParams.$param.tostring()) + "`r`n")
                }

                default
                {
                    $setParams.add($param, $psboundparameters.$param)
                    $configstring += ($param + ':' + $setParams.$param + "`r`n")
                }
            }
        }
    }

    # handle complex parameters - manually for now
    if ($PSBoundParameters.keys -contains 'Assignments' )
    {
        $PSBoundParameters.Assignments | ForEach-Object {
            if ($_ -ne $null)
            {
                $assignmentsArray += set-JSONstring -id $_ -type 'Assignments'
            }
        }
        $configstring += ( 'Assignments' + ":`r`n" + ($PSBoundParameters.Assignments | Out-String) + "`r`n" )
    }
    if ($PSBoundParameters.keys -contains 'ExcludedGroups' )
    {
        $PSBoundParameters.ExcludedGroups | ForEach-Object {
            if ($_ -ne $null)
            {
                $assignmentsArray += set-JSONstring -id $_ -type 'ExcludedGroups'
            }
        }
        $configstring += ( 'ExcludedGroups' + ":`r`n" + ($PSBoundParameters.ExcludedGroups | Out-String) + "`r`n" )

    }
    # set the apps values
    $AppsHash = set-AppsHash -AppGroupType $AppGroupType -apps $apps
    $appshash.Apps | ForEach-Object {
        if ($_ -ne $null)
        {
            $appsarray += set-JSONstring -id $_ -type 'Apps'
        }
    }
    $configstring += ('AppGroupType:' + $appshash.AppGroupType + "`r`n")
    $configstring += ('Apps' + ":`r`n" + ($appshash.Apps | Out-String) + "`r`n" )

    # Set the managedbrowser values
    $ManagedBrowserValuesHash = set-ManagedBrowserValues @PSBoundParameters
    foreach ($param in $ManagedBrowserValuesHash.keys)
    {
        $setParams.add($param, $ManagedBrowserValuesHash.$param)
        $configstring += ($param + ':' + $setParams.$param + "`r`n")
    }

    Write-Verbose -Message $configstring

    if (($Ensure -eq 'Present') -and ($currentPolicy.Ensure -eq 'Absent'))
    {
        Write-Verbose -Message "Creating new Android App Protection Policy {$DisplayName}"
        if ($id -ne '')
        {
            Write-Verbose -Message 'ID in Configuration Document will be ignored, Policy will be created with a new ID'
        }
        $setParams.add('Assignments', $assignmentsArray)
        $newpolicy = New-MgBetaDeviceAppManagementAndroidManagedAppProtection @setParams
        $setParams.add('AndroidManagedAppProtectionId', $newpolicy.Id)

    }
    elseif (($Ensure -eq 'Present') -and ($currentPolicy.Ensure -eq 'Present'))
    {
        Write-Verbose -Message "Updating existing Android App Protection Policy {$DisplayName}"
        if ( ($id -ne '') -and ( $id -ne $currentPolicy.id ) )
        {
            Write-Verbose -Message ("id in configuration document and returned policy do not match - updating policy with matching Displayname {$displayname} - ID {" + $currentPolicy.id + '}')
        }
        $setParams.add('AndroidManagedAppProtectionId', $currentPolicy.id)
        Update-MgBetaDeviceAppManagementAndroidManagedAppProtection @setParams

        Write-Verbose -Message 'Setting Group Assignments...'
        Set-MgBetaDeviceAppManagementTargetedManagedAppConfiguration -TargetedManagedAppConfigurationId $setParams.AndroidManagedAppProtectionId -Assignments $assignmentsArray

    }
    # now we need to set up the apps
    Write-Verbose -Message ('Setting Application values of type: ' + $AppsHash.AppGroupType)
    Invoke-MgBetaTargetDeviceAppManagementTargetedManagedAppConfigurationApp -TargetedManagedAppConfigurationId $setParams.AndroidManagedAppProtectionId -Apps $appsarray -AppGroupType $AppsHash.AppGroupType
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $PeriodOnlineBeforeAccessCheck,

        [Parameter()]
        [System.String]
        $AllowedInboundDataTransferSources,

        [Parameter()]
        [System.String]
        $AllowedOutboundDataTransferDestinations,

        [Parameter()]
        [System.Boolean]
        $OrganizationalCredentialsRequired,

        [Parameter()]
        [System.String]
        $AllowedOutboundClipboardSharingLevel,

        [Parameter()]
        [System.Boolean]
        $DataBackupBlocked,

        [Parameter()]
        [System.Boolean]
        $DeviceComplianceRequired,

        [Parameter()]
        [System.Boolean]
        $ManagedBrowserToOpenLinksRequired,

        [Parameter()]
        [System.Boolean]
        $SaveAsBlocked,

        [Parameter()]
        [System.String]
        $PeriodOfflineBeforeWipeIsEnforced,

        [Parameter()]
        [System.Boolean]
        $PinRequired,

        [Parameter()]
        [System.Boolean]
        $DisableAppPinIfDevicePinIsSet,

        [Parameter()]
        [System.UInt32]
        $MaximumPinRetries,

        [Parameter()]
        [System.Boolean]
        $SimplePinBlocked,

        [Parameter()]
        [System.UInt32]
        $MinimumPinLength,

        [Parameter()]
        [System.String]
        $PinCharacterSet,

        [Parameter()]
        [System.String[]]
        $AllowedDataStorageLocations,

        [Parameter()]
        [System.Boolean]
        $ContactSyncBlocked,

        [Parameter()]
        [System.String]
        $PeriodBeforePinReset,

        [Parameter()]
        [System.Boolean]
        $PrintBlocked,

        [Parameter()]
        [System.Boolean]
        $RequireClass3Biometrics,

        [Parameter()]
        [System.Boolean]
        $RequirePinAfterBiometricChange,

        [Parameter()]
        [System.Boolean]
        $FingerprintBlocked,

        [Parameter()]
        [System.Boolean]
        $DisableAppEncryptionIfDeviceEncryptionIsEnabled,

        [Parameter()]
        [System.String]
        $CustomBrowserDisplayName,

        [Parameter()]
        [System.String]
        $CustomBrowserPackageId,

        [Parameter()]
        [System.String[]]
        $Apps,

        [Parameter()]
        [ValidateSet('allApps', 'allMicrosoftApps', 'allCoreMicrosoftApps', 'selectedPublicApps' )]
        [System.String]
        $AppGroupType,

        [Parameter()]
        [System.String[]]
        $Assignments,

        [Parameter()]
        [System.String[]]
        $ExcludedGroups,

        [Parameter()]
        [System.String]
        [ValidateSet('notConfigured', 'microsoftEdge')]
        $ManagedBrowser,

        [Parameter()]
        [System.String]
        $MinimumRequiredAppVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredOSVersion,

        [Parameter()]
        [System.String]
        $MinimumRequiredPatchVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningAppVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningOSVersion,

        [Parameter()]
        [System.String]
        $MinimumWarningPatchVersion,

        [Parameter()]
        [System.Boolean]
        $IsAssigned,

        [Parameter()]
        [System.Boolean]
        $ScreenCaptureBlocked,

        [Parameter()]
        [System.Boolean]
        $EncryptAppData,

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
        [System.String]
        $Id,

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
    Write-Verbose -Message "Testing configuration of Android App Protection Policy {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $CurrentValues))
    {
        Write-Verbose "An error occured in Get-TargetResource, the policy {$displayName} will not be processed"
        throw "An error occured in Get-TargetResource, the policy {$displayName} will not be processed. Refer to the event viewer logs for more information."
    }

    if ($CurrentValues.Ensure -eq 'ERROR')
    {
        Throw 'Error when searching for current policy details - Please check verbose output for further detail'
    }

    if ($Ensure -eq 'Absent')
    {
        if ($currentvalues.Ensure -eq 'Present')
        {
            Write-Verbose -Message "Existing Policy {$DisplayName} will be removed"
            return $False
        }
        else
        {
            Write-Verbose -Message "Policy {$DisplayName} already removed"
            return $True
        }
    }

    if (($CurrentValues.Ensure -eq 'Absent') -and ($Ensure -eq 'Present'))
    {
        Write-Verbose -Message "Policy {$DisplayName} Not Present on tenant - New Policy will be created"
        return $false
    }

    $targetvalues = @{}

    $Allparams = get-InputParameters

    ($Allparams.keys | Where-Object { $allparams.$_.Type -eq 'Credential' }) | ForEach-Object {
        $CurrentValues.Remove($_) | Out-Null
    }

    # loop through regular parameters
    foreach ($param in ($Allparams.keys | Where-Object { $allparams.$_.Type -eq 'Parameter' }) )
    {
        if ($PSBoundParameters.keys -contains $param )
        {
            switch ($Allparams.$param.ExportFileType)
            {
                'Duration'
                {
                    $targetvalues.add($param, (set-TimeSpan -duration $PSBoundParameters.$param))
                }

                default
                {
                    $targetvalues.add($param, $psboundparameters.$param)
                }
            }
        }
        else
        {
            Write-Verbose -Message ('Unspecified Parameter in Config: ' + $param + '  Current Value Will be retained: ' + $CurrentValues.$param)
        }
    }
    Write-Verbose -Message 'Starting Assignments Check'
    # handle complex parameters - manually for now
    if ($PSBoundParameters.keys -contains 'Assignments' )
    {
        $targetvalues.add('Assignments', $psboundparameters.Assignments)
    }

    Write-Verbose -Message 'Starting Exluded Groups Check'
    if ($PSBoundParameters.keys -contains 'ExcludedGroups' )
    {
        $targetvalues.add('ExcludedGroups', $psboundparameters.ExcludedGroups)
    }

    # set the apps values
    Write-Verbose -Message "AppGroupType: $AppGroupType"
    Write-Verbose -Message "apps: $apps"
    $AppsHash = set-AppsHash -AppGroupType $AppGroupType -apps $apps
    $targetvalues.add('Apps', $AppsHash.Apps)
    $targetvalues.add('AppGroupType', $AppsHash.AppGroupType)
    # wipe out the current apps value if AppGroupType is anything but selectedpublicapps to match the appshash values
    if ($CurrentValues.AppGroupType -ne 'selectedPublicApps')
    {
        $CurrentValues.Apps = @()
    }

    # remove thre ID from the values to check as it may not match
    $targetvalues.remove('ID') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $targetvalues)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $targetvalues `
        -ValuesToCheck $targetvalues.Keys
    #-verbose

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        if (-not [string]::IsNullOrEmpty($Filter))
        {
            $complexFunctions = Get-ComplexFunctionsFromFilterQuery -FilterQuery $Filter
            $Filter = Remove-ComplexFunctionsFromFilterQuery -FilterQuery $Filter
        }
        [array]$policies = Get-MgBetaDeviceAppManagementAndroidManagedAppProtection -All:$true -Filter $Filter -ErrorAction Stop
        $policies = Find-GraphDataUsingComplexFunctions -ComplexFunctions $complexFunctions -Policies $policies

        $i = 1
        $dscContent = ''
        if ($policies.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($policy in $policies)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($policies.Count)] $($policy.displayName)" -NoNewline
            $params = @{
                Id                    = $policy.id
                DisplayName           = $policy.displayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationID         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }
            $Results = Get-TargetResource @params
            if (-not (Test-M365DSCAuthenticationParameter -BoundParameters $Results))
            {
                Write-Verbose "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed"
                throw "An error occured in Get-TargetResource, the policy {$($params.displayName)} will not be processed. Refer to the event viewer logs for more information."
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
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        return $dscContent
    }
    catch
    {
        if ($_.Exception -like '*401*' -or $_.ErrorDetails.Message -like "*`"ErrorCode`":`"Forbidden`"*" -or `
                $_.Exception -like '*Request not applicable to target tenant*')
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

function Set-JSONstring
{
    param
    (
        [string]$id,
        [string]$type
    )

    $JsonContent = ''

    switch ($type)
    {

        'Apps'
        {
            $JsonContent = @"
                    {
                    "id":"$($id)",
                    "mobileAppIdentifier": {
                        "@odata.type": "#microsoft.graph.AndroidMobileAppIdentifier",
                        "packageId": "$id"
                    }
                }
"@

        }
        'Assignments'
        {
            $JsonContent = @"
            {
            "id":"$($id)_incl",
            "target": {
                        "@odata.type": "#microsoft.graph.groupAssignmentTarget",
                        "groupId": "$($id)"
                    }
            }
"@
        }
        'ExcludedGroups'
        {
            $JsonContent = @"
            {
            "id":"$($id)_excl",
            "target": {
                        "@odata.type": "#microsoft.graph.exclusionGroupAssignmentTarget",
                        "groupId": "$($id)"
                    }
            }
"@

        }
    }

    return $JsonContent

}

function Set-Timespan
{
    param
    (
        [string]$duration
    )

    try
    {
        if ($duration.startswith('P'))
        {
            $timespan = [System.Xml.XmlConvert]::ToTimeSpan($duration)
        }
        else
        {
            $timespan = [TimeSpan]$duration
        }
    }
    catch
    {
        throw 'Problem converting input to a timespan - If configuration document is using iso8601 string (e.g. PT15M) try using new-timespan (e.g. new-timespan -minutes 15)'
    }
    return $timespan
}

function Set-AppsHash
{
    param
    (
        [string]$AppGroupType,
        [array]$Apps
    )

    if ($AppGroupType -eq '')
    {
        if ($apps.count -eq 0 )
        {
            $AppGroupType = 'allApps'
        }
        else
        {
            $AppGroupType = 'selectedPublicApps'
        }
        Write-Verbose -Message "setting AppGroupType to $AppGroupType"
    }

    $appsarray = @()
    if ($AppGroupType -eq 'selectedPublicApps' )
    {
        $appsarray = $apps
    }

    $AppsHash = @{
        'AppGroupType' = $AppGroupType
        'Apps'         = $appsarray
    }

    return $AppsHash
}

function Set-ManagedBrowserValues
{
    param
    (
        [string]$ManagedBrowser,
        [switch]$ManagedBrowserToOpenLinksRequired,
        [string]$CustomBrowserDisplayName,
        [string]$CustomBrowserPackageId
    )

    # via the gui there are only 3 possible configs:
    # edge - edge, true, empty id strings
    # any app - not configured, false, empty strings
    # unmanaged browser not configured, true, strings must not be empty
    if (!$ManagedBrowserToOpenLinksRequired)
    {
        $ManagedBrowser = 'notConfigured'
        $ManagedBrowserToOpenLinksRequired = $false
        $CustomBrowserDisplayName = ''
        $CustomBrowserPackageId = ''

    }
    else
    {
        if (($CustomBrowserDisplayName -ne '') -and ($CustomBrowserPackageId -ne ''))
        {
            $ManagedBrowser = 'notConfigured'
            $ManagedBrowserToOpenLinksRequired = $true
            $CustomBrowserDisplayName = $CustomBrowserDisplayName
            $CustomBrowserPackageId = $CustomBrowserPackageId
        }
        else
        {
            $ManagedBrowser = 'microsoftEdge'
            $ManagedBrowserToOpenLinksRequired = $true
            $CustomBrowserDisplayName = ''
            $CustomBrowserPackageId = ''
        }

    }

    $ManagedBrowserHash = @{
        'ManagedBrowser'                    = $ManagedBrowser
        'ManagedBrowserToOpenLinksRequired' = $ManagedBrowserToOpenLinksRequired
        'CustomBrowserDisplayName'          = $CustomBrowserDisplayName
        'CustomBrowserPackageId'            = $CustomBrowserPackageId
    }

    return $ManagedBrowserHash
}

function Get-InputParameters
{
    return @{
        AllowedDataStorageLocations                     = @{Type = 'Parameter'        ; ExportFileType = 'Array'; }
        AllowedInboundDataTransferSources               = @{Type = 'Parameter'        ; ExportFileType = 'String'; }
        AllowedOutboundClipboardSharingLevel            = @{Type = 'Parameter'        ; ExportFileType = 'String'; }
        AllowedOutboundDataTransferDestinations         = @{Type = 'Parameter'        ; ExportFileType = 'String'; }
        ApplicationId                                   = @{Type = 'Credential'       ; ExportFileType = 'NA'; }
        ApplicationSecret                               = @{Type = 'Credential'       ; ExportFileType = 'NA'; }
        AppGroupType                                    = @{Type = 'ComplexParameter' ; ExportFileType = 'String'; }
        Apps                                            = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        Assignments                                     = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        CertificateThumbprint                           = @{Type = 'Credential'       ; ExportFileType = 'NA'; }
        Managedidentity                                 = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        ContactSyncBlocked                              = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        Credential                                      = @{Type = 'Credential'       ; ExportFileType = 'NA'; }
        CustomBrowserDisplayName                        = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        CustomBrowserPackageId                          = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        DataBackupBlocked                               = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        Description                                     = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        DeviceComplianceRequired                        = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        DisableAppEncryptionIfDeviceEncryptionIsEnabled = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        DisableAppPinIfDevicePinIsSet                   = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        DisplayName                                     = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        EncryptAppData                                  = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        Ensure                                          = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        ExcludedGroups                                  = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        FingerprintBlocked                              = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        Id                                              = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        IsAssigned                                      = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        ManagedBrowser                                  = @{Type = 'ComplexParameter' ; ExportFileType = 'String'; }
        ManagedBrowserToOpenLinksRequired               = @{Type = 'ComplexParameter' ; ExportFileType = 'NA'; }
        MaximumPinRetries                               = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumPinLength                                = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumRequiredAppVersion                       = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumRequiredOSVersion                        = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumRequiredPatchVersion                     = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumWarningAppVersion                        = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumWarningOSVersion                         = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        MinimumWarningPatchVersion                      = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        OrganizationalCredentialsRequired               = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        PeriodBeforePinReset                            = @{Type = 'Parameter'        ; ExportFileType = 'Duration'; }
        PeriodOfflineBeforeAccessCheck                  = @{Type = 'Parameter'        ; ExportFileType = 'Duration'; }
        PeriodOfflineBeforeWipeIsEnforced               = @{Type = 'Parameter'        ; ExportFileType = 'Duration'; }
        PeriodOnlineBeforeAccessCheck                   = @{Type = 'Parameter'        ; ExportFileType = 'Duration'; }
        PinCharacterSet                                 = @{Type = 'Parameter'        ; ExportFileType = 'String'; }
        PinRequired                                     = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        PrintBlocked                                    = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        RequireClass3Biometrics                         = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        RequirePinAfterBiometricChange                  = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        SaveAsBlocked                                   = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        ScreenCaptureBlocked                            = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        SimplePinBlocked                                = @{Type = 'Parameter'        ; ExportFileType = 'NA'; }
        TenantId                                        = @{Type = 'Credential'       ; ExportFileType = 'NA'; }
    }
}

Export-ModuleMember -Function *-TargetResource
