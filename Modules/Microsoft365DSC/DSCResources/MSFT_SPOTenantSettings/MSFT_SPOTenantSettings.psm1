function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [System.Boolean]
        $HideSyncButtonOnTeamSite,

        [Parameter()]
        [ValidateSet('AllowExternalSharing', 'BlockExternalSharing')]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [System.Boolean]
        $IsFluidEnabled,

        [Parameter()]
        [System.Boolean]
        $SocialBarOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $CommentsOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $EnableAIPIntegration,

        [Parameter()]
        [System.String]
        $TenantDefaultTimezone,

        [Parameter()]
        [System.Boolean]
        $ExemptNativeUsersFromTenantLevelRestricedAccessControl,

        [Parameter()]
        [System.String[]]
        $AllowSelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSecurityGroupsInSPSitesList,

        [Parameter()]
        [System.String[]]
        $AllowSelectSecurityGroupsInSPSitesList,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message 'Getting configuration for SPO Tenant'

    $ConnectionModeGraph = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    $ConnectionMode = New-M365DSCConnection -Workload 'PNP' `
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

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'

    try
    {
        $SPOTenantSettings = Get-PnPTenant -ErrorAction Stop
        $SPOTenantGraphSettings = Get-MgAdminSharepointSetting -Property TenantDefaultTimeZone # get tenantDefaultTimezone
        $CompatibilityRange = $SPOTenantSettings.CompatibilityRange.Split(',')
        $MinCompat = $null
        $MaxCompat = $null
        if ($CompatibilityRange.Length -eq 2)
        {
            $MinCompat = $CompatibilityRange[0]
            $MaxCompat = $CompatibilityRange[1]
        }

        # Additional Properties via REST
        $parametersToRetrieve = @('ExemptNativeUsersFromTenantLevelRestricedAccessControl',
                                  'AllowSelectSGsInODBListInTenant',
                                  'DenySelectSGsInODBListInTenant',
                                  'DenySelectSecurityGroupsInSPSitesList',
                                  'AllowSelectSecurityGroupsInSPSitesList')

        $response = Invoke-PnPSPRestMethod -Method Get `
                       -Url "$($Global:MSCloudLoginConnectionProfile.PnP.AdminUrl)/_api/SPO.Tenant?`$select=$($parametersToRetrieve -join ',')"


        return @{
            IsSingleInstance                                       = 'Yes'
            ExemptNativeUsersFromTenantLevelRestricedAccessControl = $response.ExemptNativeUsersFromTenantLevelRestricedAccessControl
            AllowSelectSGsInODBListInTenant                        = $response.AllowSelectSGsInODBListInTenant
            DenySelectSGsInODBListInTenant                         = $response.DenySelectSGsInODBListInTenant
            DenySelectSecurityGroupsInSPSitesList                  = $response.DenySelectSecurityGroupsInSPSitesList
            AllowSelectSecurityGroupsInSPSitesList                 = $response.AllowSelectSecurityGroupsInSPSitesList
            MinCompatibilityLevel                                  = $MinCompat
            MaxCompatibilityLevel                                  = $MaxCompat
            SearchResolveExactEmailOrUPN                           = $SPOTenantSettings.SearchResolveExactEmailOrUPN
            OfficeClientADALDisabled                               = $SPOTenantSettings.OfficeClientADALDisabled
            LegacyAuthProtocolsEnabled                             = $SPOTenantSettings.LegacyAuthProtocolsEnabled
            SignInAccelerationDomain                               = $SPOTenantSettings.SignInAccelerationDomain
            UsePersistentCookiesForExplorerView                    = $SPOTenantSettings.UsePersistentCookiesForExplorerView
            PublicCdnEnabled                                       = $SPOTenantSettings.PublicCdnEnabled
            PublicCdnAllowedFileTypes                              = $SPOTenantSettings.PublicCdnAllowedFileTypes
            UseFindPeopleInPeoplePicker                            = $SPOTenantSettings.UseFindPeopleInPeoplePicker
            NotificationsInSharePointEnabled                       = $SPOTenantSettings.NotificationsInSharePointEnabled
            OwnerAnonymousNotification                             = $SPOTenantSettings.OwnerAnonymousNotification
            ApplyAppEnforcedRestrictionsToAdHocRecipients          = $SPOTenantSettings.ApplyAppEnforcedRestrictionsToAdHocRecipients
            FilePickerExternalImageSearchEnabled                   = $SPOTenantSettings.FilePickerExternalImageSearchEnabled
            HideDefaultThemes                                      = $SPOTenantSettings.HideDefaultThemes
            HideSyncButtonOnTeamSite                               = $SPOTenantSettings.HideSyncButtonOnTeamSite
            MarkNewFilesSensitiveByDefault                         = $SPOTenantSettings.MarkNewFilesSensitiveByDefault
            DisabledWebPartIds                                     = [String[]]$SPOTenantSettings.DisabledWebPartIds
            SocialBarOnSitePagesDisabled                           = $SPOTenantSettings.SocialBarOnSitePagesDisabled
            CommentsOnSitePagesDisabled                            = $SPOTenantSettings.CommentsOnSitePagesDisabled
            EnableAIPIntegration                                   = $SPOTenantSettings.EnableAIPIntegration
            TenantDefaultTimezone                                  = $SPOTenantGraphSettings.TenantDefaultTimeZone
            Credential                                             = $Credential
            ApplicationId                                          = $ApplicationId
            TenantId                                               = $TenantId
            ApplicationSecret                                      = $ApplicationSecret
            CertificatePassword                                    = $CertificatePassword
            CertificatePath                                        = $CertificatePath
            CertificateThumbprint                                  = $CertificateThumbprint
            Managedidentity                                        = $ManagedIdentity.IsPresent
            Ensure                                                 = 'Present'
            AccessTokens                                           = $AccessTokens
        }
    }
    catch
    {
        if ($_.Exception.Message -like 'No connection available')
        {
            Write-Verbose -Message 'Make sure that you are connected to your SPOService'
        }

        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullReturn
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [System.Boolean]
        $HideSyncButtonOnTeamSite,

        [Parameter()]
        [ValidateSet('AllowExternalSharing', 'BlockExternalSharing')]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [System.Boolean]
        $SocialBarOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $CommentsOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $EnableAIPIntegration,

        [Parameter()]
        [System.String]
        $TenantDefaultTimezone,

        [Parameter()]
        [System.Boolean]
        $ExemptNativeUsersFromTenantLevelRestricedAccessControl,

        [Parameter()]
        [System.String[]]
        $AllowSelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSecurityGroupsInSPSitesList,

        [Parameter()]
        [System.String[]]
        $AllowSelectSecurityGroupsInSPSitesList,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message 'Setting configuration for SPO Tenant'

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

    if (-not [string]::IsNullOrEmpty($TenantDefaultTimezone))
    {
        $ConnectionModeGraph = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters
    }
    $ConnectionMode = New-M365DSCConnection -Workload 'PNP' -InboundParameters $PSBoundParameters

    $CurrentParameters = $PSBoundParameters
    $CurrentParameters.Remove('Credential') | Out-Null
    $CurrentParameters.Remove('IsSingleInstance') | Out-Null
    $CurrentParameters.Remove('Ensure') | Out-Null
    $CurrentParameters.Remove('ApplicationId') | Out-Null
    $CurrentParameters.Remove('TenantId') | Out-Null
    $CurrentParameters.Remove('CertificatePath') | Out-Null
    $CurrentParameters.Remove('CertificatePassword') | Out-Null
    $CurrentParameters.Remove('CertificateThumbprint') | Out-Null
    $CurrentParameters.Remove('ManagedIdentity') | Out-Null
    $CurrentParameters.Remove('ApplicationSecret') | Out-Null
    $CurrentParameters.Remove('AccessTokens') | Out-Null
    $CurrentParameters.Remove('ExemptNativeUsersFromTenantLevelRestricedAccessControl') | Out-Null
    $CurrentParameters.Remove('AllowSelectSGsInODBListInTenant') | Out-Null
    $CurrentParameters.Remove('DenySelectSGsInODBListInTenant') | Out-Null
    $CurrentParameters.Remove('DenySelectSecurityGroupsInSPSitesList') | Out-Null
    $CurrentParameters.Remove('AllowSelectSecurityGroupsInSPSitesList') | Out-Null

    $CurrentParameters.Remove('TenantDefaultTimezone') | Out-Null # this one is updated separately using Graph
    if ($CurrentParameters.Keys.Contains('UserVoiceForFeedbackEnabled'))
    {
        Write-Verbose -Message 'Property UserVoiceForFeedbackEnabled is deprecated, removing it'
        $CurrentParameters.Remove('UserVoiceForFeedbackEnabled') | Out-Null
    }

    if ($PublicCdnEnabled -eq $false)
    {
        Write-Verbose -Message 'The use of the public CDN is not enabled, for that the PublicCdnAllowedFileTypes parameter can not be configured and will be removed'
        $CurrentParameters.Remove('PublicCdnAllowedFileTypes') | Out-Null
    }
    $tenant = Set-PnPTenant @CurrentParameters

    if (-not [string]::IsNullOrEmpty($TenantDefaultTimezone))
    {
        $tenantGraph = Update-MgAdminSharepointSetting -TenantDefaultTimezone $TenantDefaultTimezone -ErrorAction Stop
    }

    # Updating via REST
    try
    {
        $paramsToUpdate = @{}
        $needToUpdate = $false

        if ($null -ne $ExemptNativeUsersFromTenantLevelRestricedAccessControl)
        {
            $needToUpdate = $true
            $paramsToUpdate.Add("ExemptNativeUsersFromTenantLevelRestricedAccessControl", $ExemptNativeUsersFromTenantLevelRestricedAccessControl)
        }

        if ($null -ne $AllowSelectSGsInODBListInTenant)
        {
            $needToUpdate = $true
            $paramsToUpdate.Add("AllowSelectSGsInODBListInTenant", $AllowSelectSGsInODBListInTenant)
        }

        if ($null -ne $DenySelectSGsInODBListInTenant)
        {
            $needToUpdate = $true
            $paramsToUpdate.Add("DenySelectSGsInODBListInTenant", $DenySelectSGsInODBListInTenant)
        }

        if ($null -ne $DenySelectSecurityGroupsInSPSitesList)
        {
            $needToUpdate = $true
            $paramsToUpdate.Add("DenySelectSecurityGroupsInSPSitesList", $DenySelectSecurityGroupsInSPSitesList)
        }

        if ($null -ne $AllowSelectSecurityGroupsInSPSitesList)
        {
            $needToUpdate = $true
            $paramsToUpdate.Add("AllowSelectSecurityGroupsInSPSitesList", $AllowSelectSecurityGroupsInSPSitesList)
        }

        if ($needToUpdate)
        {
            Write-Verbose -Message "Updating properties via REST PATCH call."
            Invoke-PnPSPRestMethod -Method PATCH `
                        -Url "$($Global:MSCloudLoginConnectionProfile.PnP.AdminUrl)/_api/SPO.Tenant" `
                        -Content $paramsToUpdate
        }
    }
    catch
    {
        if ($_.Exception.Message.Contains("The requested operation is part of an experimental feature that is not supported in the current environment."))
        {
            Write-Verbose -Message "Updating via REST: The associated feature is not available in the given tenant."
        }
        else
        {
            throw $_
        }
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [System.Boolean]
        $HideSyncButtonOnTeamSite,

        [Parameter()]
        [ValidateSet('AllowExternalSharing', 'BlockExternalSharing')]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [System.Boolean]
        $SocialBarOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $CommentsOnSitePagesDisabled,

        [Parameter()]
        [System.Boolean]
        $EnableAIPIntegration,

        [Parameter()]
        [System.String]
        $TenantDefaultTimezone,

        [Parameter()]
        [System.Boolean]
        $ExemptNativeUsersFromTenantLevelRestricedAccessControl,

        [Parameter()]
        [System.String[]]
        $AllowSelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSGsInODBListInTenant,

        [Parameter()]
        [System.String[]]
        $DenySelectSecurityGroupsInSPSitesList,

        [Parameter()]
        [System.String[]]
        $AllowSelectSecurityGroupsInSPSitesList,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message 'Testing configuration for SPO Tenant'
    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @('IsSingleInstance', `
            'MaxCompatibilityLevel', `
            'SearchResolveExactEmailOrUPN', `
            'OfficeClientADALDisabled', `
            'LegacyAuthProtocolsEnabled', `
            'SignInAccelerationDomain', `
            'UsePersistentCookiesForExplorerView', `
            'UserVoiceForFeedbackEnabled', `
            'PublicCdnEnabled', `
            'PublicCdnAllowedFileTypes', `
            'UseFindPeopleInPeoplePicker', `
            'NotificationsInSharePointEnabled', `
            'OwnerAnonymousNotification', `
            'ApplyAppEnforcedRestrictionsToAdHocRecipients', `
            'FilePickerExternalImageSearchEnabled', `
            'HideDefaultThemes', `
            'HideSyncButtonOnTeamSite', `
            'MarkNewFilesSensitiveByDefault', `
            'DisabledWebPartIds', `
            'SocialBarOnSitePagesDisabled', `
            'CommentsOnSitePagesDisabled', `
            'EnableAIPIntegration', `
            'TenantDefaultTimezone'
    )

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
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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
        $ConnectionModeGraph = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters

        $ConnectionMode = New-M365DSCConnection -Workload 'PNP' `
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

        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }

        $Params = @{
            IsSingleInstance      = 'Yes'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificatePassword   = $CertificatePassword
            CertificatePath       = $CertificatePath
            CertificateThumbprint = $CertificateThumbprint
            Managedidentity       = $ManagedIdentity.IsPresent
            Credential            = $Credential
            AccessTokens          = $AccessTokens
        }

        $Results = Get-TargetResource @Params
        if ($null -eq $Results.MaxCompatibilityLevel)
        {
            $Results.Remove('MaxCompatibilityLevel') | Out-Null
        }
        if ($null -eq $Results.MinCompatibilityLevel)
        {
            $Results.Remove('MinCompatibilityLevel') | Out-Null
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
        Write-Host $Global:M365DSCEmojiGreenCheckmark
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
