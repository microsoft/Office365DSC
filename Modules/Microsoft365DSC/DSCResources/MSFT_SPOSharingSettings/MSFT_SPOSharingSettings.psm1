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
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $SharingCapability,

        [Parameter()]
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $MySiteSharingCapability,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneClaim,

        [Parameter()]
        [System.boolean]
        $ShowAllUsersClaim,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneExceptExternalUsersClaim,

        [Parameter()]
        [System.boolean]
        $ProvisionSharedWithEveryoneFolder,

        [Parameter()]
        [System.boolean]
        $EnableGuestSignInAcceleration,

        [Parameter()]
        [System.boolean]
        $BccExternalSharingInvitations,

        [Parameter()]
        [System.String]
        $BccExternalSharingInvitationsList,

        [Parameter()]
        [System.Uint32]
        $RequireAnonymousLinksExpireInDays,

        [Parameter()]
        [System.Uint32]
        $ExternalUserExpireInDays,

        [Parameter()]
        [System.String[]]
        $SharingAllowedDomainList,

        [Parameter()]
        [System.String[]]
        $SharingBlockedDomainList,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'AllowList', 'BlockList')]
        $SharingDomainRestrictionMode,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Direct', 'Internal', 'AnonymousAccess')]
        $DefaultSharingLinkType,

        [Parameter()]
        [System.boolean]
        $PreventExternalUsersFromResharing,

        [Parameter()]
        [System.boolean]
        $ExternalUserExpirationRequired,

        [Parameter()]
        [System.boolean]
        $ShowPeoplePickerSuggestionsForGuestUsers,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FileAnonymousLinkType,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FolderAnonymousLinkType,

        [Parameter()]
        [System.boolean]
        $NotifyOwnersWhenItemsReshared,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'View', 'Edit')]
        $DefaultLinkPermission,

        [Parameter()]
        [System.boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

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

    Write-Verbose -Message 'Getting configuration for SPO Sharing settings'

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
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
        $SPOSharingSettings = Get-PnPTenant -ErrorAction Stop
        $MySite = Get-PnPTenantSite -Filter "Url -like '-my.sharepoint.'" | Where-Object -FilterScript { $_.Template -notmatch "^RedirectSite#" }

        if ($null -ne $MySite)
        {
            $MySiteSharingCapability = (Get-PnPTenantSite -Identity $MySite.Url).SharingCapability
        }

        if ($null -ne $SPOSharingSettings.SharingAllowedDomainList)
        {
            $allowDomains = $SPOSharingSettings.SharingAllowedDomainList.split(' ')
        }

        if ($null -ne $SPOSharingSettings.SharingBlockedDomainList)
        {
            $blockDomains = $SPOSharingSettings.SharingBlockedDomainList.split(' ')
        }

        if ($SPOSharingSettings.DefaultLinkPermission -eq 'None')
        {
            $DefaultLinkPermission = 'Edit'
        }
        else
        {
            $DefaultLinkPermission = $SPOSharingSettings.DefaultLinkPermission
        }
        $results = @{
            IsSingleInstance                           = 'Yes'
            SharingCapability                          = $SPOSharingSettings.SharingCapability
            ShowEveryoneClaim                          = $SPOSharingSettings.ShowEveryoneClaim
            ShowAllUsersClaim                          = $SPOSharingSettings.ShowAllUsersClaim
            ShowEveryoneExceptExternalUsersClaim       = $SPOSharingSettings.ShowEveryoneExceptExternalUsersClaim
            ProvisionSharedWithEveryoneFolder          = $SPOSharingSettings.ProvisionSharedWithEveryoneFolder
            EnableGuestSignInAcceleration              = $SPOSharingSettings.EnableGuestSignInAcceleration
            BccExternalSharingInvitations              = $SPOSharingSettings.BccExternalSharingInvitations
            BccExternalSharingInvitationsList          = $SPOSharingSettings.BccExternalSharingInvitationsList
            RequireAnonymousLinksExpireInDays          = $SPOSharingSettings.RequireAnonymousLinksExpireInDays
            ExternalUserExpireInDays                   = $SPOSharingSettings.ExternalUserExpireInDays
            ExternalUserExpirationRequired             = $SPOSharingSettings.ExternalUserExpirationRequired
            SharingAllowedDomainList                   = $allowDomains
            SharingBlockedDomainList                   = $blockDomains
            SharingDomainRestrictionMode               = $SPOSharingSettings.SharingDomainRestrictionMode
            DefaultSharingLinkType                     = $SPOSharingSettings.DefaultSharingLinkType
            PreventExternalUsersFromResharing          = $SPOSharingSettings.PreventExternalUsersFromResharing
            ShowPeoplePickerSuggestionsForGuestUsers   = $SPOSharingSettings.ShowPeoplePickerSuggestionsForGuestUsers
            FileAnonymousLinkType                      = $SPOSharingSettings.FileAnonymousLinkType
            FolderAnonymousLinkType                    = $SPOSharingSettings.FolderAnonymousLinkType
            NotifyOwnersWhenItemsReshared              = $SPOSharingSettings.NotifyOwnersWhenItemsReshared
            DefaultLinkPermission                      = $DefaultLinkPermission

            #DEPRECATED
            #RequireAcceptingAccountMatchInvitedAccount = $SPOSharingSettings.RequireAcceptingAccountMatchInvitedAccount
            Credential                                 = $Credential
            ApplicationId                              = $ApplicationId
            TenantId                                   = $TenantId
            ApplicationSecret                          = $ApplicationSecret
            CertificatePassword                        = $CertificatePassword
            CertificatePath                            = $CertificatePath
            CertificateThumbprint                      = $CertificateThumbprint
            Managedidentity                            = $ManagedIdentity.IsPresent
            Ensure                                     = 'Present'
            AccessTokens                               = $AccessTokens
        }

        if (-not [System.String]::IsNullOrEmpty($MySiteSharingCapability))
        {
            $results.Add('MySiteSharingCapability', $MySiteSharingCapability)
        }
        return $results
    }
    catch
    {
        if ($error[0].Exception.Message -like 'No connection available')
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
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $SharingCapability,

        [Parameter()]
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $MySiteSharingCapability,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneClaim,

        [Parameter()]
        [System.boolean]
        $ShowAllUsersClaim,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneExceptExternalUsersClaim,

        [Parameter()]
        [System.boolean]
        $ProvisionSharedWithEveryoneFolder,

        [Parameter()]
        [System.boolean]
        $EnableGuestSignInAcceleration,

        [Parameter()]
        [System.boolean]
        $BccExternalSharingInvitations,

        [Parameter()]
        [System.String]
        $BccExternalSharingInvitationsList,

        [Parameter()]
        [System.Uint32]
        $RequireAnonymousLinksExpireInDays,

        [Parameter()]
        [System.Uint32]
        $ExternalUserExpireInDays,

        [Parameter()]
        [System.String[]]
        $SharingAllowedDomainList,

        [Parameter()]
        [System.String[]]
        $SharingBlockedDomainList,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'AllowList', 'BlockList')]
        $SharingDomainRestrictionMode,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Direct', 'Internal', 'AnonymousAccess')]
        $DefaultSharingLinkType,

        [Parameter()]
        [System.boolean]
        $PreventExternalUsersFromResharing,

        [Parameter()]
        [System.boolean]
        $ExternalUserExpirationRequired,

        [Parameter()]
        [System.boolean]
        $ShowPeoplePickerSuggestionsForGuestUsers,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FileAnonymousLinkType,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FolderAnonymousLinkType,

        [Parameter()]
        [System.boolean]
        $NotifyOwnersWhenItemsReshared,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'View', 'Edit')]
        $DefaultLinkPermission,

        [Parameter()]
        [System.boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

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

    Write-Verbose -Message 'Setting configuration for SPO Sharing settings'

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

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
        -InboundParameters $PSBoundParameters

    $CurrentParameters = $PSBoundParameters
    $CurrentParameters.Remove('Credential') | Out-Null
    $CurrentParameters.Remove('Ensure') | Out-Null
    $CurrentParameters.Remove('Verbose') | Out-Null
    $CurrentParameters.Remove('IsSingleInstance') | Out-Null
    $CurrentParameters.Remove('ApplicationId') | Out-Null
    $CurrentParameters.Remove('TenantId') | Out-Null
    $CurrentParameters.Remove('CertificatePath') | Out-Null
    $CurrentParameters.Remove('CertificatePassword') | Out-Null
    $CurrentParameters.Remove('CertificateThumbprint') | Out-Null
    $CurrentParameters.Remove('ManagedIdentity') | Out-Null
    $CurrentParameters.Remove('ApplicationSecret') | Out-Null
    $CurrentParameters.Remove('AccessTokens') | Out-Null

    # DEPRECATED
    $CurrentParameters.Remove('RequireAcceptingAccountMatchInvitedAccount') | Out-Null

    [bool]$SetMySharingCapability = $false
    if ($null -ne $CurrentParameters['MySiteSharingCapability'])
    {
        $SetMySharingCapability = $true
    }
    $CurrentParameters.Remove('MySiteSharingCapability') | Out-Null

    if ($null -eq $SignInAccelerationDomain)
    {
        $CurrentParameters.Remove('SignInAccelerationDomain') | Out-Null
        $CurrentParameters.Remove('EnableGuestSignInAcceleration') | Out-Null #removing EnableGuestSignInAcceleration since it can only be configured with a configured SignINAccerlation domain
    }
    if ($SharingCapability -ne 'ExternalUserAndGuestSharing')
    {
        Write-Warning -Message 'The sharing capabilities for the tenant are not configured to be ExternalUserAndGuestSharing for that the RequireAnonymousLinksExpireInDays property cannot be configured'
        $CurrentParameters.Remove('RequireAnonymousLinksExpireInDays') | Out-Null
    }
    if ($ExternalUserExpireInDays -and $ExternalUserExpirationRequired -eq $false)
    {
        Write-Warning -Message 'ExternalUserExpirationRequired is set to be false. For that the ExternalUserExpireInDays property cannot be configured'
        $CurrentParameters.Remove('ExternalUserExpireInDays') | Out-Null
    }
    if ($RequireAcceptingAccountMatchInvitedAccount -eq $false)
    {
        Write-Warning -Message 'RequireAcceptingAccountMatchInvitedAccount is set to be false. For that SharingAllowedDomainList / SharingBlockedDomainList cannot be configured'
        $CurrentParameters.Remove('SharingAllowedDomainList') | Out-Null
        $CurrentParameters.Remove('SharingBlockedDomainList') | Out-Null
    }

    if ($SharingCapability -ne 'ExternalUserAndGuestSharing' -and ($null -ne $FileAnonymousLinkType -or $null -ne $FolderAnonymousLinkType))
    {
        Write-Warning -Message 'If anonymous file or folder links are set, SharingCapability must be set to ExternalUserAndGuestSharing '
        $CurrentParameters.Remove('FolderAnonymousLinkType') | Out-Null
        $CurrentParameters.Remove('FileAnonymousLinkType') | Out-Null
    }

    if ($SharingDomainRestrictionMode -eq 'None')
    {
        Write-Warning -Message 'SharingDomainRestrictionMode is set to None. For that SharingAllowedDomainList / SharingBlockedDomainList cannot be configured'
        $CurrentParameters.Remove('SharingAllowedDomainList') | Out-Null
        $CurrentParameters.Remove('SharingBlockedDomainList') | Out-Null
    }
    elseif ($SharingDomainRestrictionMode -eq 'AllowList')
    {
        Write-Verbose -Message 'SharingDomainRestrictionMode is set to AllowList. For that SharingBlockedDomainList cannot be configured'
        $CurrentParameters.Remove('SharingBlockedDomainList') | Out-Null
    }
    elseif ($SharingDomainRestrictionMode -eq 'BlockList')
    {
        Write-Warning -Message 'SharingDomainRestrictionMode is set to BlockList. For that SharingAllowedDomainList cannot be configured'
        $CurrentParameters.Remove('SharingAllowedDomainList') | Out-Null
    }

    if ($null -ne $CurrentParameters['SharingAllowedDomainList'])
    {
        foreach ($allowedDomain in $SharingAllowedDomainList)
        {
            $allowed += $allowedDomain
            $allowed += ' '
        }
        $CurrentParameters['SharingAllowedDomainList'] = $allowed.trim()
    }

    if ($null -ne $CurrentParameters['SharingBlockedDomainList'])
    {
        foreach ($blockedDomain in $SharingBlockedDomainList)
        {
            $blocked += $blockedDomain
            $blocked += ' '
        }
        $CurrentParameters['SharingBlockedDomainList'] = $blocked.Trim()
    }

    if ($DefaultLinkPermission -eq 'None')
    {
        Write-Verbose -Message 'Valid values to set are View and Edit. A value of None will be set to Edit as its the default value.'
        $CurrentParameters['DefaultLinkPermission'] = 'Edit'
    }

    Set-PnPTenant @CurrentParameters | Out-Null
    if ($SetMySharingCapability)
    {
        $mysite = Get-PnPTenantSite -Filter "Url -like '-my.sharepoint.'" | Where-Object -FilterScript { $_.Template -notmatch "^RedirectSite#" }
        Set-PnPTenantSite -Identity $mysite.Url -SharingCapability $MySiteSharingCapability
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
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $SharingCapability,

        [Parameter()]
        [System.String]
        [ValidateSet('ExistingExternalUserSharingOnly', 'ExternalUserAndGuestSharing', 'Disabled', 'ExternalUserSharingOnly')]
        $MySiteSharingCapability,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneClaim,

        [Parameter()]
        [System.boolean]
        $ShowAllUsersClaim,

        [Parameter()]
        [System.boolean]
        $ShowEveryoneExceptExternalUsersClaim,

        [Parameter()]
        [System.boolean]
        $ProvisionSharedWithEveryoneFolder,

        [Parameter()]
        [System.boolean]
        $EnableGuestSignInAcceleration,

        [Parameter()]
        [System.boolean]
        $BccExternalSharingInvitations,

        [Parameter()]
        [System.String]
        $BccExternalSharingInvitationsList,

        [Parameter()]
        [System.Uint32]
        $RequireAnonymousLinksExpireInDays,

        [Parameter()]
        [System.Uint32]
        $ExternalUserExpireInDays,

        [Parameter()]
        [System.String[]]
        $SharingAllowedDomainList,

        [Parameter()]
        [System.String[]]
        $SharingBlockedDomainList,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'AllowList', 'BlockList')]
        $SharingDomainRestrictionMode,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Direct', 'Internal', 'AnonymousAccess')]
        $DefaultSharingLinkType,

        [Parameter()]
        [System.boolean]
        $PreventExternalUsersFromResharing,

        [Parameter()]
        [System.boolean]
        $ExternalUserExpirationRequired,

        [Parameter()]
        [System.boolean]
        $ShowPeoplePickerSuggestionsForGuestUsers,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FileAnonymousLinkType,

        [Parameter()]
        [System.String]
        [ValidateSet('View', 'Edit')]
        $FolderAnonymousLinkType,

        [Parameter()]
        [System.boolean]
        $NotifyOwnersWhenItemsReshared,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'View', 'Edit')]
        $DefaultLinkPermission,

        [Parameter()]
        [System.boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

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

    Write-Verbose -Message 'Testing configuration for SPO Sharing settings'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null
    $ValuesToCheck.Remove('CertificatePath') | Out-Null
    $ValuesToCheck.Remove('CertificatePassword') | Out-Null
    $ValuesToCheck.Remove('CertificateThumbprint') | Out-Null
    $ValuesToCheck.Remove('ManagedIdentity') | Out-Null
    $ValuesToCheck.Remove('AccessTokens') | Out-Null
    $ValuesToCheck.Remove('RequireAcceptingAccountMatchInvitedAccount') | Out-Null

    if ($DefaultLinkPermission -eq 'None')
    {
        Write-Verbose -Message 'Valid values to set are View and Edit. A value of None will be set to Edit as its the default value.'
        $ValuesToCheck['DefaultLinkPermission'] = 'Edit'
    }

    if ($null -eq $SharingAllowedDomainList -and $null -eq $SharingBlockedDomainList -and
        ($null -ne $RequireAcceptingAccountMatchInvitedAccount -and $RequireAcceptingAccountMatchInvitedAccount -eq $false))
    {
        Write-Warning -Message 'If SharingAllowedDomainList / SharingBlockedDomainList are set to null RequireAcceptingAccountMatchInvitedAccount must be set to True '
        $ValuesToCheck.Remove('RequireAcceptingAccountMatchInvitedAccount') | Out-Null
    }

    if ($null -eq $SignInAccelerationDomain)
    {
        $ValuesToCheck.Remove('SignInAccelerationDomain') | Out-Null
        $ValuesToCheck.Remove('EnableGuestSignInAcceleration') | Out-Null #removing EnableGuestSignInAcceleration since it can only be configured with a configured SignINAccerlation domain
    }
    if ($SharingCapability -ne 'ExternalUserAndGuestSharing')
    {
        Write-Warning -Message 'The sharing capabilities for the tenant are not configured to be ExternalUserAndGuestSharing for that the RequireAnonymousLinksExpireInDays property cannot be configured'
        $ValuesToCheck.Remove('RequireAnonymousLinksExpireInDays') | Out-Null
    }
    if ($ExternalUserExpireInDays -and $ExternalUserExpirationRequired -eq $false)
    {
        Write-Warning -Message 'ExternalUserExpirationRequired is set to be false. For that the ExternalUserExpireInDays property cannot be configured'
        $ValuesToCheck.Remove('ExternalUserExpireInDays') | Out-Null
    }
    if ($RequireAcceptingAccountMatchInvitedAccount -eq $false)
    {
        Write-Warning -Message 'RequireAcceptingAccountMatchInvitedAccount is set to be false. For that SharingAllowedDomainList / SharingBlockedDomainList cannot be configured'
        $ValuesToCheck.Remove('SharingAllowedDomainList') | Out-Null
        $ValuesToCheck.Remove('SharingBlockedDomainList') | Out-Null
    }

    if ($SharingCapability -ne 'ExternalUserAndGuestSharing' -and ($null -ne $FileAnonymousLinkType -or $null -ne $FolderAnonymousLinkType))
    {
        Write-Warning -Message 'If anonymous file or folder links are set, SharingCapability must be set to ExternalUserAndGuestSharing '
        $ValuesToCheck.Remove('FolderAnonymousLinkType') | Out-Null
        $ValuesToCheck.Remove('FileAnonymousLinkType') | Out-Null
    }

    if ($SharingDomainRestrictionMode -eq 'None')
    {
        Write-Warning -Message 'SharingDomainRestrictionMode is set to None. For that SharingAllowedDomainList / SharingBlockedDomainList cannot be configured'
        $ValuesToCheck.Remove('SharingAllowedDomainList') | Out-Null
        $ValuesToCheck.Remove('SharingBlockedDomainList') | Out-Null
    }
    elseif ($SharingDomainRestrictionMode -eq 'AllowList')
    {
        Write-Verbose -Message 'SharingDomainRestrictionMode is set to AllowList. For that SharingBlockedDomainList cannot be configured'
        $ValuesToCheck.Remove('SharingBlockedDomainList') | Out-Null
    }
    elseif ($SharingDomainRestrictionMode -eq 'BlockList')
    {
        Write-Warning -Message 'SharingDomainRestrictionMode is set to BlockList. For that SharingAllowedDomainList cannot be configured'
        $ValuesToCheck.Remove('SharingAllowedDomainList') | Out-Null
    }

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
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
        if (-1 -eq $Results.RequireAnonymousLinksExpireInDays)
        {
            $Results.Remove('RequireAnonymousLinksExpireInDays') | Out-Null
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
