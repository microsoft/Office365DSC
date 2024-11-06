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
        [ValidateSet('disabled', 'enabled', 'enabledForReportingButNotEnforced')]
        $State,

        #ConditionalAccessApplicationCondition
        [Parameter()]
        [System.String[]]
        $IncludeApplications,

        [Parameter()]
        [System.String[]]
        $ExcludeApplications,

        [Parameter()]
        [System.String]
        $ApplicationsFilter,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ApplicationsFilterMode,

        [Parameter()]
        [System.String[]]
        $IncludeUserActions,

        #ConditionalAccessUserCondition
        [Parameter()]
        [System.String[]]
        $IncludeUsers,

        [Parameter()]
        [System.String[]]
        $ExcludeUsers,

        [Parameter()]
        [System.String[]]
        $IncludeGroups,

        [Parameter()]
        [System.String[]]
        $ExcludeGroups,

        [Parameter()]
        [System.String[]]
        $IncludeRoles,

        [Parameter()]
        [System.String[]]
        $ExcludeRoles,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $IncludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $IncludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $IncludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $ExcludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $ExcludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $ExcludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        $IncludeServicePrincipals,

        [Parameter()]
        [System.String[]]
        $ExcludeServicePrincipals,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ServicePrincipalFilterMode,

        [Parameter()]
        [System.String]
        $ServicePrincipalFilterRule,

        #ConditionalAccessPlatformCondition
        [Parameter()]
        [System.String[]]
        $IncludePlatforms,

        [Parameter()]
        [System.String[]]
        $ExcludePlatforms,

        #ConditionalAccessLocationCondition
        [Parameter()]
        [System.String[]]
        $IncludeLocations,

        [Parameter()]
        [System.String[]]
        $ExcludeLocations,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $DeviceFilterMode,

        [Parameter()]
        [System.String]
        $DeviceFilterRule,

        #Further conditions
        [Parameter()]
        [System.String[]]
        $UserRiskLevels,

        [Parameter()]
        [System.String[]]
        $SignInRiskLevels,

        [Parameter()]
        [System.String[]]
        $ClientAppTypes,

        #ConditionalAccessGrantControls
        [Parameter()]
        [ValidateSet('AND', 'OR')]
        [System.String]
        $GrantControlOperator,

        [Parameter()]
        [System.String[]]
        $BuiltInControls,

        #ConditionalAccessSessionControls
        [Parameter()]
        [System.Boolean]
        $ApplicationEnforcedRestrictionsIsEnabled,

        [Parameter()]
        [System.Boolean]
        $CloudAppSecurityIsEnabled,

        [Parameter()]
        [System.String]
        $CloudAppSecurityType,

        [Parameter()]
        [System.Int32]
        $SignInFrequencyValue,

        [Parameter()]
        [ValidateSet('Days', 'Hours', '')]
        [System.String]
        $SignInFrequencyType,

        [Parameter()]
        [System.Boolean]
        $SignInFrequencyIsEnabled,

        [Parameter()]
        [ValidateSet('timeBased', 'everyTime', 'unknownFutureValue')]
        [System.String]
        $SignInFrequencyInterval,

        [Parameter()]
        [ValidateSet('Always', 'Never', '')]
        [System.String]
        $PersistentBrowserMode,

        [Parameter()]
        [System.Boolean]
        $PersistentBrowserIsEnabled,

        [Parameter()]
        [System.String]
        $TermsOfUse,

        [Parameter()]
        [System.String[]]
        $CustomAuthenticationFactors,

        [Parameter()]
        [System.String]
        $AuthenticationStrength,

        [Parameter()]
        [System.String[]]
        $AuthenticationContexts,

        [Parameter()]
        [System.String]
        $TransferMethods,

        [Parameter()]
        [System.String]
        $InsiderRiskLevels,

        #generic
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
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message 'Getting configuration of AzureAD Conditional Access Policy'
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

    if ($PSBoundParameters.ContainsKey('Id'))
    {
        Write-Verbose -Message 'PolicyID was specified'
        try
        {
            $Policy = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $Id -ErrorAction Stop
        }
        catch
        {
            Write-Verbose -Message "Couldn't find existing policy by ID {$Id}"
            $Policy = Get-MgBetaIdentityConditionalAccessPolicy -Filter "DisplayName eq '$DisplayName'"
            if ($Policy.Length -gt 1)
            {
                throw "Duplicate CA Policies named $DisplayName exist in tenant"
            }
        }
    }
    else
    {
        Write-Verbose -Message 'Id was NOT specified'
        ## Can retreive multiple CA Policies since displayname is not unique
        $Policy = Get-MgBetaIdentityConditionalAccessPolicy -Filter "DisplayName eq '$DisplayName'"
        if ($Policy.Length -gt 1)
        {
            throw "Duplicate CA Policies named $DisplayName exist in tenant"
        }
    }

    if ([String]::IsNullOrEmpty($Policy.id))
    {
        Write-Verbose -Message "No existing Policy with name {$DisplayName} were found"
        $currentValues = $PSBoundParameters
        $currentValues.Ensure = 'Absent'
        return $currentValues
    }

    Write-Verbose -Message 'Get-TargetResource: Found existing Conditional Access policy'
    $PolicyDisplayName = $Policy.DisplayName

    Write-Verbose -Message 'Get-TargetResource: Process IncludeUsers'
    #translate IncludeUser GUIDs to UPN, except id value is GuestsOrExternalUsers, None or All
    $IncludeUsers = @()
    if ($Policy.Conditions.Users.IncludeUsers)
    {
        foreach ($IncludeUserGUID in $Policy.Conditions.Users.IncludeUsers)
        {
            if ($IncludeUserGUID -notin 'GuestsOrExternalUsers', 'All', 'None')
            {
                $IncludeUser = $null
                try
                {
                    $IncludeUser = (Get-MgUser -UserId $IncludeUserGUID -ErrorAction Stop).userprincipalname
                }
                catch
                {
                    $message = "Couldn't find IncludedUser '$IncludeUserGUID', that is defined in policy '$PolicyDisplayName'. Skipping user."
                    New-M365DSCLogEntry -Message $message `
                        -Exception $_ `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                    continue
                }
                if ($IncludeUser)
                {
                    $IncludeUsers += $IncludeUser
                }
            }
            else
            {
                $IncludeUsers += $IncludeUserGUID
            }
        }
    }

    Write-Verbose -Message 'Get-TargetResource: Process ExcludeUsers'
    #translate ExcludeUser GUIDs to UPN, except id value is GuestsOrExternalUsers, None or All
    $ExcludeUsers = @()
    if ($Policy.Conditions.Users.ExcludeUsers)
    {
        foreach ($ExcludeUserGUID in $Policy.Conditions.Users.ExcludeUsers)
        {
            if ($ExcludeUserGUID -notin 'GuestsOrExternalUsers', 'All', 'None')
            {
                $ExcludeUser = $null
                try
                {
                    $ExcludeUser = (Get-MgUser -UserId $ExcludeUserGUID -ErrorAction Stop).userprincipalname
                }
                catch
                {
                    $message = "Couldn't find ExcludedUser '$ExcludeUserGUID', that is defined in policy '$PolicyDisplayName'. Skipping user."
                    New-M365DSCLogEntry -Message $message `
                        -Exception $_ `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                    continue
                }
                if ($ExcludeUser)
                {
                    $ExcludeUsers += $ExcludeUser
                }
            }
            else
            {
                $ExcludeUsers += $ExcludeUserGUID
            }
        }
    }

    Write-Verbose -Message 'Get-TargetResource: Process IncludeGroups'
    #translate IncludeGroup GUIDs to DisplayName
    $IncludeGroups = @()
    if ($Policy.Conditions.Users.IncludeGroups)
    {
        foreach ($IncludeGroupGUID in $Policy.Conditions.Users.IncludeGroups)
        {
            $IncludeGroup = $null
            try
            {
                $IncludeGroup = (Get-MgGroup -GroupId $IncludeGroupGUID -ErrorAction Stop).displayname
            }
            catch
            {
                $message = "Couldn't find IncludedGroup '$IncludeGroupGUID', that is defined in policy '$PolicyDisplayName'. Skipping group."
                New-M365DSCLogEntry -Message $message `
                    -Exception $_ `
                    -Source $($MyInvocation.MyCommand.Source) `
                    -TenantId $TenantId `
                    -Credential $Credential
                continue
            }
            if ($IncludeGroup)
            {
                $IncludeGroups += $IncludeGroup
            }
        }
    }

    Write-Verbose -Message 'Get-TargetResource: Process ExcludeGroups'
    #translate ExcludeGroup GUIDs to DisplayName
    $ExcludeGroups = @()
    if ($Policy.Conditions.Users.ExcludeGroups)
    {
        foreach ($ExcludeGroupGUID in $Policy.Conditions.Users.ExcludeGroups)
        {
            $ExcludeGroup = $null
            try
            {
                $ExcludeGroup = (Get-MgGroup -GroupId $ExcludeGroupGUID -ErrorAction Stop).displayname
            }
            catch
            {
                $message = "Couldn't find ExcludedGroup '$ExcludeGroupGUID', that is defined in policy '$PolicyDisplayName'. Skipping group."
                New-M365DSCLogEntry -Message $message `
                    -Exception $_ `
                    -Source $($MyInvocation.MyCommand.Source) `
                    -TenantId $TenantId `
                    -Credential $Credential
                continue
            }
            if ($ExcludeGroup)
            {
                $ExcludeGroups += $ExcludeGroup
            }
        }
    }

    $IncludeRoles = @()
    $ExcludeRoles = @()
    #translate role template guids to role name
    if ($Policy.Conditions.Users.IncludeRoles -or $Policy.Conditions.Users.ExcludeRoles)
    {
        Write-Verbose -Message 'Get-TargetResource: Role condition defined, processing'
        #build role translation table
        $rolelookup = @{}
        foreach ($role in Get-MgBetaDirectoryRoleTemplate -All)
        {
            $rolelookup[$role.Id] = $role.DisplayName
        }

        Write-Verbose -Message 'Get-TargetResource: Processing IncludeRoles'
        if ($Policy.Conditions.Users.IncludeRoles)
        {
            foreach ($IncludeRoleGUID in $Policy.Conditions.Users.IncludeRoles)
            {
                if ($null -eq $rolelookup[$IncludeRoleGUID])
                {
                    $message = "Couldn't find IncludedRole '$IncludeRoleGUID', that is defined in policy '$PolicyDisplayName'. Skipping role."
                    New-M365DSCLogEntry -Message $message `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                }
                else
                {
                    $IncludeRoles += $rolelookup[$IncludeRoleGUID]
                }
            }
        }

        Write-Verbose -Message 'Get-TargetResource: Processing ExcludeRoles'
        if ($Policy.Conditions.Users.ExcludeRoles)
        {
            foreach ($ExcludeRoleGUID in $Policy.Conditions.Users.ExcludeRoles)
            {
                if ($null -eq $rolelookup[$ExcludeRoleGUID])
                {
                    $message = "Couldn't find ExcludedRole '$ExcludeRoleGUID', that is defined in policy '$PolicyDisplayName'. Skipping role."
                    New-M365DSCLogEntry -Message $message `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                }
                else
                {
                    $ExcludeRoles += $rolelookup[$ExcludeRoleGUID]
                }
            }
        }
    }

    $IncludeLocations = @()
    $ExcludeLocations = @()
    #translate Location template guids to Location name
    if ($Policy.Conditions.Locations)
    {
        Write-Verbose -Message 'Get-TargetResource: Location condition defined, processing'
        #build Location translation table
        $Locationlookup = @{}
        foreach ($Location in Get-MgBetaIdentityConditionalAccessNamedLocation)
        {
            $Locationlookup[$Location.Id] = $Location.DisplayName
        }

        Write-Verbose -Message 'Get-TargetResource: Processing IncludeLocations'
        if ($Policy.Conditions.Locations.IncludeLocations)
        {
            foreach ($IncludeLocationGUID in $Policy.Conditions.Locations.IncludeLocations)
            {
                if ($IncludeLocationGUID -in 'All', 'AllTrusted')
                {
                    $IncludeLocations += $IncludeLocationGUID
                }
                elseif ($IncludeLocationGUID -eq '00000000-0000-0000-0000-000000000000')
                {
                    $IncludeLocations += 'Multifactor authentication trusted IPs'
                }
                elseif ($null -eq $Locationlookup[$IncludeLocationGUID])
                {
                    $message = "Couldn't find Location $IncludeLocationGUID , couldn't add to policy $PolicyDisplayName"
                    New-M365DSCLogEntry -Message $message `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                }
                else
                {
                    $IncludeLocations += $Locationlookup[$IncludeLocationGUID]
                }
            }
        }

        Write-Verbose -Message 'Get-TargetResource: Processing ExcludeLocations'
        if ($Policy.Conditions.Locations.ExcludeLocations)
        {
            foreach ($ExcludeLocationGUID in $Policy.Conditions.Locations.ExcludeLocations)
            {
                if ($ExcludeLocationGUID -in 'All', 'AllTrusted')
                {
                    $ExcludeLocations += $ExcludeLocationGUID
                }
                elseif ($ExcludeLocationGUID -eq '00000000-0000-0000-0000-000000000000')
                {
                    $ExcludeLocations += 'Multifactor authentication trusted IPs'
                }
                elseif ($null -eq $Locationlookup[$ExcludeLocationGUID])
                {
                    $message = "Couldn't find Location $ExcludeLocationGUID , couldn't add to policy $PolicyDisplayName"
                    New-M365DSCLogEntry -Message $message `
                        -Source $($MyInvocation.MyCommand.Source) `
                        -TenantId $TenantId `
                        -Credential $Credential
                }
                else
                {
                    $ExcludeLocations += $Locationlookup[$ExcludeLocationGUID]
                }
            }
        }
    }
    if ($Policy.SessionControls.CloudAppSecurity.IsEnabled)
    {
        $CloudAppSecurityType = [System.String]$Policy.SessionControls.CloudAppSecurity.CloudAppSecurityType
    }
    else
    {
        $CloudAppSecurityType = $null
    }
    if ($Policy.SessionControls.SignInFrequency.IsEnabled)
    {
        $SignInFrequencyType = [System.String]$Policy.SessionControls.SignInFrequency.Type
        $SignInFrequencyIntervalValue = [System.String]$Policy.SessionControls.SignInFrequency.FrequencyInterval
    }
    else
    {
        $SignInFrequencyType = $null
        $SignInFrequencyIntervalValue = $null
    }
    if ($Policy.SessionControls.PersistentBrowser.IsEnabled)
    {
        $PersistentBrowserMode = [System.String]$Policy.SessionControls.PersistentBrowser.Mode
    }
    else
    {
        $PersistentBrowserMode = $null
    }
    if ($Policy.Conditions.Users.IncludeGuestsOrExternalUsers.GuestOrExternalUserTypes)
    {
        [Array]$IncludeGuestOrExternalUserTypes = ($Policy.Conditions.Users.IncludeGuestsOrExternalUsers.GuestOrExternalUserTypes).Split(',')
    }
    if ($Policy.Conditions.Users.ExcludeGuestsOrExternalUsers.GuestOrExternalUserTypes)
    {
        [Array]$ExcludeGuestOrExternalUserTypes = ($Policy.Conditions.Users.ExcludeGuestsOrExternalUsers.GuestOrExternalUserTypes).Split(',')
    }

    $termsOfUseName = $null
    if ($Policy.GrantControls.TermsOfUse)
    {
        $termofUse = Get-MgBetaAgreement | Where-Object -FilterScript { $_.Id -eq $Policy.GrantControls.TermsOfUse }
        if ($termOfUse)
        {
            $termOfUseName = $termOfUse.DisplayName
        }
    }

    $AuthenticationStrengthValue = $null
    if ($null -ne $Policy.GrantControls -and $null -ne $Policy.GrantControls.AuthenticationStrength -and `
            $null -ne $Policy.GrantControls.AuthenticationStrength.Id)
    {
        $strengthPolicy = Get-MgBetaPolicyAuthenticationStrengthPolicy -AuthenticationStrengthPolicyId $Policy.GrantControls.AuthenticationStrength.Id
        if ($null -ne $strengthPolicy)
        {
            $AuthenticationStrengthValue = $strengthPolicy.DisplayName
        }
    }

    $AuthenticationContextsValues = @()
    if ($null -ne $Policy.Conditions.Applications.IncludeAuthenticationContextClassReferences)
    {
        foreach ($class in $Policy.Conditions.Applications.IncludeAuthenticationContextClassReferences)
        {
            $classReference = Get-MgBetaIdentityConditionalAccessAuthenticationContextClassReference `
                -AuthenticationContextClassReferenceId $class `
                -ErrorAction SilentlyContinue
            if ($null -ne $classReference)
            {
                $AuthenticationContextsValues += $classReference.DisplayName
            }
        }
    }

    $result = @{
        DisplayName                              = $Policy.DisplayName
        Id                                       = $Policy.Id
        State                                    = $Policy.State
        IncludeApplications                      = [System.String[]](@() + $Policy.Conditions.Applications.IncludeApplications)
        #no translation of Application GUIDs, return empty string array if undefined
        ExcludeApplications                      = [System.String[]](@() + $Policy.Conditions.Applications.ExcludeApplications)
        ApplicationsFilter                       = $Policy.Conditions.Applications.ApplicationFilter.Rule
        ApplicationsFilterMode                   = $Policy.Conditions.Applications.ApplicationFilter.Mode
        #no translation of GUIDs, return empty string array if undefined
        IncludeUserActions                       = [System.String[]](@() + $Policy.Conditions.Applications.IncludeUserActions)
        #no translation needed, return empty string array if undefined
        IncludeUsers                             = $IncludeUsers
        ExcludeUsers                             = $ExcludeUsers
        IncludeGroups                            = $IncludeGroups
        ExcludeGroups                            = $ExcludeGroups
        IncludeRoles                             = $IncludeRoles
        ExcludeRoles                             = $ExcludeRoles
        IncludeGuestOrExternalUserTypes          = [System.String[]]$IncludeGuestOrExternalUserTypes
        IncludeExternalTenantsMembershipKind     = [System.String]$Policy.Conditions.Users.IncludeGuestsOrExternalUsers.ExternalTenants.MembershipKind
        IncludeExternalTenantsMembers            = [System.String[]](@() + $Policy.Conditions.Users.IncludeGuestsOrExternalUsers.ExternalTenants.AdditionalProperties.members)

        ExcludeGuestOrExternalUserTypes          = [System.String[]]$ExcludeGuestOrExternalUserTypes
        ExcludeExternalTenantsMembershipKind     = [System.String]$Policy.Conditions.Users.ExcludeGuestsOrExternalUsers.ExternalTenants.MembershipKind
        ExcludeExternalTenantsMembers            = [System.String[]](@() + $Policy.Conditions.Users.ExcludeGuestsOrExternalUsers.ExternalTenants.AdditionalProperties.members)

        IncludeServicePrincipals                 = $Policy.Conditions.ClientApplications.IncludeServicePrincipals
        ExcludeServicePrincipals                 = $Policy.Conditions.ClientApplications.ExcludeServicePrincipals
        ServicePrincipalFilterMode               = $Policy.Conditions.ClientApplications.ServicePrincipalFilter.Mode
        ServicePrincipalFilterRule               = $Policy.Conditions.ClientApplications.ServicePrincipalFilter.Rule

        IncludePlatforms                         = [System.String[]](@() + $Policy.Conditions.Platforms.IncludePlatforms)
        #no translation needed, return empty string array if undefined
        ExcludePlatforms                         = [System.String[]](@() + $Policy.Conditions.Platforms.ExcludePlatforms)
        #no translation needed, return empty string array if undefined
        IncludeLocations                         = $IncludeLocations
        ExcludeLocations                         = $ExcludeLocations

        #no translation needed, return empty string array if undefined
        DeviceFilterMode                         = [System.String]$Policy.Conditions.Devices.DeviceFilter.Mode
        #no translation or conversion needed
        DeviceFilterRule                         = [System.String]$Policy.Conditions.Devices.DeviceFilter.Rule
        #no translation or conversion needed
        UserRiskLevels                           = [System.String[]](@() + $Policy.Conditions.UserRiskLevels)
        #no translation needed, return empty string array if undefined
        SignInRiskLevels                         = [System.String[]](@() + $Policy.Conditions.SignInRiskLevels)
        #no translation needed, return empty string array if undefined
        ClientAppTypes                           = [System.String[]](@() + $Policy.Conditions.ClientAppTypes)
        #no translation needed, return empty string array if undefined
        GrantControlOperator                     = $Policy.GrantControls.Operator
        #no translation or conversion needed
        BuiltInControls                          = [System.String[]](@() + $Policy.GrantControls.BuiltInControls)
        CustomAuthenticationFactors              = [System.String[]](@() + $Policy.GrantControls.CustomAuthenticationFactors)
        #no translation needed, return empty string array if undefined
        ApplicationEnforcedRestrictionsIsEnabled = $false -or $Policy.SessionControls.ApplicationEnforcedRestrictions.IsEnabled
        #make false if undefined, true if true
        CloudAppSecurityIsEnabled                = $false -or $Policy.SessionControls.CloudAppSecurity.IsEnabled
        #make false if undefined, true if true
        CloudAppSecurityType                     = [System.String]$Policy.SessionControls.CloudAppSecurity.CloudAppSecurityType
        #no translation needed, return empty string array if undefined
        SignInFrequencyIsEnabled                 = $false -or $Policy.SessionControls.SignInFrequency.IsEnabled
        #make false if undefined, true if true
        SignInFrequencyValue                     = $Policy.SessionControls.SignInFrequency.Value
        #no translation or conversion needed, $null returned if undefined
        SignInFrequencyType                      = [System.String]$Policy.SessionControls.SignInFrequency.Type
        SignInFrequencyInterval                  = $SignInFrequencyIntervalValue
        #no translation needed
        PersistentBrowserIsEnabled               = $false -or $Policy.SessionControls.PersistentBrowser.IsEnabled
        #make false if undefined, true if true
        PersistentBrowserMode                    = [System.String]$Policy.SessionControls.PersistentBrowser.Mode
        #no translation needed
        AuthenticationStrength                   = $AuthenticationStrengthValue
        AuthenticationContexts                   = $AuthenticationContextsValues
        TransferMethods                          = [System.String]$Policy.Conditions.AuthenticationFlows.TransferMethods
        #Standard part
        TermsOfUse                               = $termOfUseName
        InsiderRiskLevels                        = $Policy.Conditions.InsiderRiskLevels
        Ensure                                   = 'Present'
        Credential                               = $Credential
        ApplicationSecret                        = $ApplicationSecret
        ApplicationId                            = $ApplicationId
        TenantId                                 = $TenantId
        CertificateThumbprint                    = $CertificateThumbprint
        Managedidentity                          = $ManagedIdentity.IsPresent
        AccessTokens                             = $AccessTokens
    }

    Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
    return $result
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
        [ValidateSet('disabled', 'enabled', 'enabledForReportingButNotEnforced')]
        $State,

        #ConditionalAccessApplicationCondition
        [Parameter()]
        [System.String[]]
        $IncludeApplications,

        [Parameter()]
        [System.String[]]
        $ExcludeApplications,

        [Parameter()]
        [System.String]
        $ApplicationsFilter,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ApplicationsFilterMode,

        [Parameter()]
        [System.String[]]
        $IncludeUserActions,

        #ConditionalAccessUserCondition
        [Parameter()]
        [System.String[]]
        $IncludeUsers,

        [Parameter()]
        [System.String[]]
        $ExcludeUsers,

        [Parameter()]
        [System.String[]]
        $IncludeGroups,

        [Parameter()]
        [System.String[]]
        $ExcludeGroups,

        [Parameter()]
        [System.String[]]
        $IncludeRoles,

        [Parameter()]
        [System.String[]]
        $ExcludeRoles,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $IncludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $IncludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $IncludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $ExcludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $ExcludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $ExcludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        $IncludeServicePrincipals,

        [Parameter()]
        [System.String[]]
        $ExcludeServicePrincipals,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ServicePrincipalFilterMode,

        [Parameter()]
        [System.String]
        $ServicePrincipalFilterRule,

        #ConditionalAccessPlatformCondition
        [Parameter()]
        [System.String[]]
        $IncludePlatforms,

        [Parameter()]
        [System.String[]]
        $ExcludePlatforms,

        #ConditionalAccessLocationCondition
        [Parameter()]
        [System.String[]]
        $IncludeLocations,

        [Parameter()]
        [System.String[]]
        $ExcludeLocations,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $DeviceFilterMode,

        [Parameter()]
        [System.String]
        $DeviceFilterRule,

        #Further conditions
        [Parameter()]
        [System.String[]]
        $UserRiskLevels,

        [Parameter()]
        [System.String[]]
        $SignInRiskLevels,

        [Parameter()]
        [System.String[]]
        $ClientAppTypes,

        #ConditionalAccessGrantControls
        [Parameter()]
        [ValidateSet('AND', 'OR')]
        [System.String]
        $GrantControlOperator,

        [Parameter()]
        [System.String[]]
        $BuiltInControls,

        #ConditionalAccessSessionControls
        [Parameter()]
        [System.Boolean]
        $ApplicationEnforcedRestrictionsIsEnabled,

        [Parameter()]
        [System.Boolean]
        $CloudAppSecurityIsEnabled,

        [Parameter()]
        [System.String]
        $CloudAppSecurityType,

        [Parameter()]
        [System.Int32]
        $SignInFrequencyValue,

        [Parameter()]
        [ValidateSet('Days', 'Hours', '')]
        [System.String]
        $SignInFrequencyType,

        [Parameter()]
        [System.Boolean]
        $SignInFrequencyIsEnabled,

        [Parameter()]
        [ValidateSet('timeBased', 'everyTime', 'unknownFutureValue')]
        [System.String]
        $SignInFrequencyInterval,

        [Parameter()]
        [ValidateSet('Always', 'Never', '')]
        [System.String]
        $PersistentBrowserMode,

        [Parameter()]
        [System.Boolean]
        $PersistentBrowserIsEnabled,

        [Parameter()]
        [System.String]
        $TermsOfUse,

        [Parameter()]
        [System.String[]]
        $CustomAuthenticationFactors,

        [Parameter()]
        [System.String]
        $AuthenticationStrength,

        [Parameter()]
        [System.String[]]
        $AuthenticationContexts,

        [Parameter()]
        [System.String]
        $TransferMethods,

        [Parameter()]
        [System.String]
        $InsiderRiskLevels,

        #generic
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
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    Write-Verbose -Message 'Setting configuration of AzureAD Conditional Access Policy'

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

    Write-Verbose -Message 'Set-Targetresource: Running Get-TargetResource'
    $currentPolicy = Get-TargetResource @PSBoundParameters
    Write-Verbose -Message 'Set-Targetresource: Cleaning up parameters'
    $currentParameters = $PSBoundParameters
    $currentParameters.Remove('ApplicationId') | Out-Null
    $currentParameters.Remove('TenantId') | Out-Null
    $currentParameters.Remove('CertificateThumbprint') | Out-Null
    $currentParameters.Remove('ApplicationSecret') | Out-Null
    $currentParameters.Remove('Ensure') | Out-Null
    $currentParameters.Remove('Credential') | Out-Null
    $currentParameters.Remove('ManagedIdentity') | Out-Null
    $currentParameters.Remove('AccessTokens') | Out-Null

    if ($Ensure -eq 'Present')#create policy attribute objects
    {
        Write-Verbose -Message "Set-Targetresource: Policy $Displayname Ensure Present"
        $NewParameters = @{}
        $NewParameters.Add('displayName', $DisplayName)
        $NewParameters.Add('state', $State)
        #create Conditions object
        Write-Verbose -Message 'Set-Targetresource: create Conditions object'
        $conditions = @{
            applications = @{}
            users        = @{}
        }
        #create and provision Application Condition object
        Write-Verbose -Message 'Set-Targetresource: create Application Condition object'
        if ($currentParameters.ContainsKey('IncludeApplications'))
        {
            $conditions.Applications.Add('includeApplications', $IncludeApplications)
        }
        if ($currentParameters.ContainsKey('excludeApplications'))
        {
            $conditions.Applications.Add('excludeApplications', $ExcludeApplications)
        }
        if ($ApplicationsFilter -and $ApplicationsFilterMode)
        {
            $appFilterValue = @{
                rule = $ApplicationsFilter
                mode = $ApplicationsFilterMode
            }
            $conditions.Applications.Add('applicationFilter', $appFilterValue)
        }
        if ($IncludeUserActions)
        {
            $conditions.Applications.Add('includeUserActions', $IncludeUserActions)
        }
        if ($AuthenticationContexts)
        {
            # Retrieve the class reference based on display name.
            $AuthenticationContextsValues = @()
            $classReferences = Get-MgBetaIdentityConditionalAccessAuthenticationContextClassReference -ErrorAction SilentlyContinue
            foreach ($authContext in $AuthenticationContexts)
            {
                $currentClassId = $classReferences | Where-Object -FilterScript { $_.DisplayName -eq $authContext }
                if ($null -ne $currentClassId)
                {
                    $AuthenticationContextsValues += $currentClassId.Id
                }
            }
            $conditions.Applications.Add('includeAuthenticationContextClassReferences', $AuthenticationContextsValues)
        }

        #create and provision User Condition object
        Write-Verbose -Message 'Set-Targetresource: process includeusers'
        if ($currentParameters.ContainsKey('IncludeUsers'))
        {
            $conditions.Users.Add('includeUsers', @())
            foreach ($includeuser in $IncludeUsers)
            {
                #translate user UPNs to GUID, except id value is GuestsOrExternalUsers, None or All
                if ($includeuser)
                {
                    if ($includeuser -notin 'GuestsOrExternalUsers', 'All', 'None')
                    {
                        $userguid = $null
                        try
                        {
                            $userguid = (Get-MgUser -UserId $includeuser -ErrorAction Stop).Id
                        }
                        catch
                        {
                            New-M365DSCLogEntry -Message 'Error updating data:' `
                                -Exception $_ `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $_
                        }
                        if ($null -eq $userguid)
                        {
                            $message = "Couldn't find user '$includeuser', couldn't add to policy '$DisplayName'"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $message
                        }
                        else
                        {
                            $conditions.users.includeUsers += $userguid
                        }
                    }
                    else
                    {
                        $conditions.users.includeUsers += $includeuser
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process excludeusers'
        if ($currentParameters.ContainsKey('ExcludeUsers'))
        {
            $conditions.users.Add('excludeUsers', @())
            foreach ($excludeuser in $ExcludeUsers)
            {
                #translate user UPNs to GUID, except id value is GuestsOrExternalUsers, None or All
                if ($excludeuser)
                {
                    if ($excludeuser -notin 'GuestsOrExternalUsers', 'All', 'None')
                    {
                        $userguid = $null
                        try
                        {
                            $userguid = (Get-MgUser -UserId $excludeuser -ErrorAction Stop).Id
                        }
                        catch
                        {
                            New-M365DSCLogEntry -Message 'Error updating data:' `
                                -Exception $_ `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $_
                        }
                        if ($null -eq $userguid)
                        {
                            $message = "Couldn't find user '$excludeuser', couldn't add to policy '$DisplayName'"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $message
                        }
                        else
                        {
                            $conditions.users.excludeUsers += $userguid
                        }
                    }
                    else
                    {
                        $conditions.users.excludeUsers += $excludeuser
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process includegroups'
        if ($currentParameters.ContainsKey('IncludeGroups'))
        {
            $conditions.users.Add('includeGroups', @())
            foreach ($includegroup in $IncludeGroups)
            {
                #translate user Group names to GUID
                if ($includegroup)
                {
                    $GroupLookup = $null
                    try
                    {
                        $GroupLookup = Get-MgGroup -Filter "DisplayName eq '$includegroup'" -ErrorAction Stop
                    }
                    catch
                    {
                        New-M365DSCLogEntry -Message 'Error updating data:' `
                            -Exception $_ `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $_
                    }
                    if ($GroupLookup.Length -gt 1)
                    {
                        $message = "Duplicate group found with displayname '$includegroup', couldn't add to policy '$DisplayName'"
                        New-M365DSCLogEntry -Message $message `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $message
                    }
                    elseif ($null -eq $GroupLookup)
                    {
                        $message = "Couldn't find group '$includegroup', couldn't add to policy '$DisplayName'"
                        New-M365DSCLogEntry -Message $message `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $message
                    }
                    else
                    {
                        Write-Verbose -Message 'Adding group to includegroups'
                        $conditions.Users.IncludeGroups += $GroupLookup.Id
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process excludegroups'
        if ($currentParameters.ContainsKey('ExcludeGroups'))
        {
            $conditions.users.Add('excludeGroups', @())
            foreach ($ExcludeGroup in $ExcludeGroups)
            {
                #translate user Group names to GUID
                if ($ExcludeGroup)
                {
                    $GroupLookup = $null
                    try
                    {
                        $GroupLookup = Get-MgGroup -Filter "DisplayName eq '$ExcludeGroup'" -ErrorAction Stop
                    }
                    catch
                    {
                        New-M365DSCLogEntry -Message 'Error updating data:' `
                            -Exception $_ `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $_
                    }
                    if ($GroupLookup.Length -gt 1)
                    {
                        $message = "Duplicate group found with displayname '$ExcludeGroup', couldn't add to policy '$DisplayName'"
                        New-M365DSCLogEntry -Message $message `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $message
                    }
                    elseif ($null -eq $GroupLookup)
                    {
                        $message = "Couldn't find group '$ExcludeGroup', couldn't add to policy '$DisplayName'"
                        New-M365DSCLogEntry -Message $message `
                            -Source $($MyInvocation.MyCommand.Source) `
                            -TenantId $TenantId `
                            -Credential $Credential
                        throw $message
                    }
                    else
                    {
                        Write-Verbose -Message 'Adding group to ExcludeGroups'
                        $conditions.users.excludeGroups += $GroupLookup.Id
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process includeroles'
        if ($currentParameters.ContainsKey('IncludeRoles'))
        {
            $conditions.Users.Add('includeRoles', @())
            if ($IncludeRoles)
            {
                #translate role names to template guid if defined
                $rolelookup = @{}
                foreach ($role in Get-MgBetaDirectoryRoleTemplate -All)
                {
                    $rolelookup[$role.DisplayName] = $role.Id
                }
                foreach ($IncludeRole in $IncludeRoles)
                {
                    if ($IncludeRole)
                    {
                        if ($null -eq $rolelookup[$IncludeRole])
                        {
                            $message = "Couldn't find role '$IncludeRole', couldn't add to policy '$DisplayName'"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $message
                        }
                        else
                        {
                            $conditions.users.includeRoles += $rolelookup[$IncludeRole]
                        }
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process excluderoles'
        if ($currentParameters.ContainsKey('ExcludeRoles'))
        {
            $conditions.users.Add('excludeRoles', @())
            if ($ExcludeRoles)
            {
                #translate role names to template guid if defined
                $rolelookup = @{}
                foreach ($role in Get-MgBetaDirectoryRoleTemplate -All)
                {
                    $rolelookup[$role.DisplayName] = $role.Id
                }
                foreach ($ExcludeRole in $ExcludeRoles)
                {
                    if ($ExcludeRole)
                    {
                        if ($null -eq $rolelookup[$ExcludeRole])
                        {
                            $message = "Couldn't find role '$ExcludeRole', couldn't add to policy '$DisplayName'"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                            throw $message
                        }
                        else
                        {
                            $conditions.users.excludeRoles += $rolelookup[$ExcludeRole]
                        }
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process includeGuestOrExternalUser'
        If ($currentParameters.ContainsKey('IncludeGuestOrExternalUserTypes'))
        {
            $includeGuestsOrExternalUsers = $null
            if ($IncludeGuestOrExternalUserTypes.Count -ne 0)
            {
                if ($IncludeGuestOrExternalUserTypes -ne 'None')
                {
                    $includeGuestsOrExternalUsers = @{}
                    [string]$IncludeGuestOrExternalUserTypes = $IncludeGuestOrExternalUserTypes -join ','
                    $includeGuestsOrExternalUsers.Add('guestOrExternalUserTypes', $IncludeGuestOrExternalUserTypes)
                    $externalTenants = @{}
                    if ($IncludeExternalTenantsMembershipKind -eq 'All')
                    {
                        $externalTenants.Add('@odata.type', '#microsoft.graph.conditionalAccessAllExternalTenants')
                    }
                    elseif ($IncludeExternalTenantsMembershipKind -eq 'enumerated')
                    {
                        $externalTenants.Add('@odata.type', '#microsoft.graph.conditionalAccessEnumeratedExternalTenants')
                    }
                    $externalTenants.Add('membershipKind', $IncludeExternalTenantsMembershipKind)
                    if ($IncludeExternalTenantsMembers)
                    {
                        $externalTenants.Add('members', $IncludeExternalTenantsMembers)
                    }
                    $includeGuestsOrExternalUsers.Add('externalTenants', $externalTenants)
                }
            }
            $conditions.Users.Add('includeGuestsOrExternalUsers', $includeGuestsOrExternalUsers)
        }

        Write-Verbose -Message 'Set-Targetresource: process excludeGuestsOrExternalUsers'
        If ($currentParameters.ContainsKey('ExcludeGuestOrExternalUserTypes'))
        {
            $excludeGuestsOrExternalUsers = $null
            if ($ExcludeGuestOrExternalUserTypes.Count -ne 0)
            {
                if ($ExcludeGuestOrExternalUserTypes -ne 'None')
                {
                    $excludeGuestsOrExternalUsers = @{}
                    [string]$ExcludeGuestOrExternalUserTypes = $ExcludeGuestOrExternalUserTypes -join ','
                    $excludeGuestsOrExternalUsers.Add('guestOrExternalUserTypes', $ExcludeGuestOrExternalUserTypes)
                    $externalTenants = @{}
                    if ($ExcludeExternalTenantsMembershipKind -eq 'All')
                    {
                        $externalTenants.Add('@odata.type', '#microsoft.graph.conditionalAccessAllExternalTenants')
                    }
                    elseif ($ExcludeExternalTenantsMembershipKind -eq 'enumerated')
                    {
                        $externalTenants.Add('@odata.type', '#microsoft.graph.conditionalAccessEnumeratedExternalTenants')
                    }
                    $externalTenants.Add('membershipKind', $ExcludeExternalTenantsMembershipKind)
                    if ($ExcludeExternalTenantsMembers)
                    {
                        $externalTenants.Add('members', $ExcludeExternalTenantsMembers)
                    }
                    $excludeGuestsOrExternalUsers.Add('externalTenants', $externalTenants)
                }
            }
            $conditions.Users.Add('excludeGuestsOrExternalUsers', $excludeGuestsOrExternalUsers)
        }

        Write-Verbose -Message 'Set-Targetresource: process includeServicePrincipals'
        if ($currentParameters.ContainsKey('IncludeServicePrincipals'))
        {
            if (-not $conditions.ContainsKey('clientApplications')) {
                $conditions.Add('clientApplications', @{})
            }
            $conditions.clientApplications.Add('includeServicePrincipals', $IncludeServicePrincipals)
        }

        Write-Verbose -Message 'Set-Targetresource: process excludeServicePrincipals'
        if ($currentParameters.ContainsKey('ExcludeServicePrincipals'))
        {
            if (-not $conditions.ContainsKey('clientApplications')) {
                $conditions.Add('clientApplications', @{})
            }
            $conditions.clientApplications.Add('excludeServicePrincipals', $ExcludeServicePrincipals)
        }

        Write-Verbose -Message 'Set-Targetresource: process servicePrincipalFilter'
        if ($currentParameters.ContainsKey('ServicePrincipalFilterMode') -and $currentParameters.ContainsKey('ServicePrincipalFilterRule'))
        {
            #check if the custom attribute exist.
            $customattribute = Invoke-MgGraphRequest -Method GET -Uri $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "v1.0/directory/customSecurityAttributeDefinitions"
            $ServicePrincipalFilterRule -match "CustomSecurityAttribute.(?<attribute>.*) -.*"
            $attrinrule = $matches.attribute
            if ($customattribute.value.id -contains $attrinrule){
                if (-not $conditions.ContainsKey('clientApplications')) {
                    $conditions.Add('clientApplications', @{})
                }
                $conditions.clientApplications.Add('servicePrincipalFilter', @{})
                $conditions.clientApplications.servicePrincipalFilter.Add('mode', $ServicePrincipalFilterMode)
                $conditions.clientApplications.servicePrincipalFilter.Add('rule', $ServicePrincipalFilterRule)
            }
            else{
                $message = "Couldn't find the custom attribute $attrinrule in the tenant, couldn't add the filter to policy $DisplayName"
                Write-Verbose -Message $message
                New-M365DSCLogEntry -Message $message `
                    -Source $($MyInvocation.MyCommand.Source) `
                    -TenantId $TenantId `
                    -Credential $Credential
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process platform condition'
        if ($currentParameters.ContainsKey('IncludePlatforms') -or $currentParameters.ContainsKey('ExcludePlatforms'))
        {
            if ($IncludePlatforms -or $ExcludePlatforms)
            {
                #create and provision Platform condition object if used
                if (-not $conditions.Contains('platforms'))
                {
                    $conditions.Add('platforms', @{
                            excludePlatforms = @()
                            includePlatforms = @()
                        })
                }
                else
                {
                    $conditions.platforms.Add('excludePlatforms', @())
                    $conditions.platforms.Add('includePlatforms', @())
                }
                Write-Verbose -Message "Set-Targetresource: IncludePlatforms: $IncludePlatforms"
                if (([Array]$IncludePlatforms).Length -eq 0)
                {
                    $conditions.platforms.includePlatforms = @('all')
                }
                else
                {
                    $conditions.platforms.includePlatforms = @() + $IncludePlatforms
                }
                #no translation or conversion needed
                Write-Verbose -Message "Set-Targetresource: ExcludePlatforms: $ExcludePlatforms"
                $conditions.platforms.excludePlatforms = @() + $ExcludePlatforms
                #no translation or conversion needed
            }
            else
            {
                Write-Verbose -Message 'Set-Targetresource: setting platform condition to null'
                $conditions.platforms = $null
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process include and exclude locations'
        if ($currentParameters.ContainsKey('IncludeLocations') -or $currentParameters.ContainsKey('ExcludeLocations'))
        {
            if ($IncludeLocations -or $ExcludeLocations)
            {
                $conditions.Add('locations', @{
                        excludeLocations = @()
                        includeLocations = @()
                    })
                $conditions.locations.includeLocations = @()
                $conditions.locations.excludeLocations = @()
                Write-Verbose -Message 'Set-Targetresource: locations specified'
                #create and provision Location condition object if used, translate Location names to guid
                $LocationLookup = @{}
                foreach ($Location in Get-MgBetaIdentityConditionalAccessNamedLocation)
                {
                    $LocationLookup[$Location.displayName] = $Location.Id
                }
                foreach ($IncludeLocation in $IncludeLocations)
                {
                    if ($IncludeLocation)
                    {
                        if ($IncludeLocation -in 'All', 'AllTrusted')
                        {
                            $conditions.locations.includeLocations += $IncludeLocation
                        }
                        elseif ($IncludeLocation -eq 'Multifactor authentication trusted IPs')
                        {
                            $conditions.locations.includeLocations += '00000000-0000-0000-0000-000000000000'
                        }
                        elseif ($null -eq $LocationLookup[$IncludeLocation])
                        {
                            $message = "Couldn't find Location $IncludeLocation , couldn't add to policy $DisplayName"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                        }
                        else
                        {
                            $conditions.locations.includeLocations += $LocationLookup[$IncludeLocation]
                        }
                    }
                }
                foreach ($ExcludeLocation in $ExcludeLocations)
                {
                    if ($ExcludeLocation)
                    {
                        if ($ExcludeLocation -eq 'All' -or $ExcludeLocation -eq 'AllTrusted')
                        {
                            $conditions.locations.excludeLocations += $ExcludeLocation
                        }
                        elseif ($ExcludeLocation -eq 'Multifactor authentication trusted IPs')
                        {
                            $conditions.locations.excludeLocations += '00000000-0000-0000-0000-000000000000'
                        }
                        elseif ($null -eq $LocationLookup[$ExcludeLocation])
                        {
                            $message = "Couldn't find Location $ExcludeLocation , couldn't add to policy $DisplayName"
                            New-M365DSCLogEntry -Message $message `
                                -Source $($MyInvocation.MyCommand.Source) `
                                -TenantId $TenantId `
                                -Credential $Credential
                        }
                        else
                        {
                            $conditions.locations.excludeLocations += $LocationLookup[$ExcludeLocation]
                        }
                    }
                }
            }
        }

        Write-Verbose -Message 'Set-Targetresource: process device filter'
        if ($currentParameters.ContainsKey('DeviceFilterMode') -and $currentParameters.ContainsKey('DeviceFilterRule'))
        {
            if ($DeviceFilterMode -and $DeviceFilterRule)
            {
                if (-not $conditions.Contains('Devices'))
                {
                    $conditions.Add('devices', @{})
                    $conditions.devices.Add('deviceFilter', @{})
                    $conditions.devices.deviceFilter.Add('mode', $DeviceFilterMode)
                    $conditions.devices.deviceFilter.Add('rule', $DeviceFilterRule)
                }
                else
                {
                    if (-not $conditions.Devices.Contains('DeviceFilter'))
                    {
                        $conditions.devices.Add('DeviceFilter', @{})
                        $conditions.devices.deviceFilter.Add('mode', $DeviceFilterMode)
                        $conditions.devices.deviceFilter.Add('rule', $DeviceFilterRule)
                    }
                    else
                    {
                        if (-not $conditions.devices.deviceFilter.Contains('mode'))
                        {
                            $conditions.devices.deviceFilter.Add('mode', $DeviceFilterMode)
                        }
                        else
                        {
                            $conditions.devices.deviceFilter.mode = $DeviceFilterMode
                        }
                        if (-not $conditions.devices.deviceFilter.Contains('rule'))
                        {
                            $conditions.devices.deviceFilter.Add('rule', $DeviceFilterRule)
                        }
                        else
                        {
                            $conditions.devices.deviceFilter.rule = $DeviceFilterRule
                        }
                    }
                }
            }
        }

        if ($null -ne $InsiderRiskLevels)
        {
            $conditions.Add("insiderRiskLevels", $InsiderRiskLevels)
        }

        Write-Verbose -Message 'Set-Targetresource: process risk levels and app types'
        Write-Verbose -Message "Set-Targetresource: UserRiskLevels: $UserRiskLevels"
        If ($currentParameters.ContainsKey('UserRiskLevels'))
        {
            $Conditions.Add('userRiskLevels', $UserRiskLevels)
            #no translation or conversion needed
        }


        Write-Verbose -Message "Set-Targetresource: SignInRiskLevels: $SignInRiskLevels"
        If ($currentParameters.ContainsKey('SignInRiskLevels'))
        {
            $Conditions.Add('signInRiskLevels', $SignInRiskLevels)
            #no translation or conversion needed
        }


        Write-Verbose -Message "Set-Targetresource: ClientAppTypes: $ClientAppTypes"
        If ($currentParameters.ContainsKey('ClientAppTypes'))
        {
            $Conditions.Add('clientAppTypes', $ClientAppTypes)
            #no translation or conversion needed
        }

        Write-Verbose -Message "Set-Targetresource: authenticationFlows transferMethods: $TransferMethods"
        if ($currentParameters.ContainsKey('TransferMethods'))
        {
            #create and provision TransferMethods condition object if used
            $authenticationFlows = if ([System.String]::IsNullOrEmpty($TransferMethods))
            {
                $null
            }
            else
            {
                @{
                    transferMethods = $TransferMethods
                }
            }
            if (-not $conditions.Contains('authenticationFlows'))
            {
                $conditions.Add('authenticationFlows', $authenticationFlows)
            }
            else
            {
                $conditions.authenticationFlows = $authenticationFlows
            }

        }
        Write-Verbose -Message 'Set-Targetresource: Adding processed conditions'
        #add all conditions to the parameter list
        $NewParameters.Add('conditions', $Conditions)
        #create and provision Grant Control object
        Write-Verbose -Message 'Set-Targetresource: create and provision Grant Control object'

        if ($GrantControlOperator -and ($BuiltInControls -or $TermsOfUse -or $CustomAuthenticationFactors -or $AuthenticationStrength))
        {
            $grantControls = @{
                operator = $GrantControlOperator
            }

            if ($BuiltInControls)
            {
                $GrantControls.Add('builtInControls', $BuiltInControls)
            }
            if ($customAuthenticationFactors)
            {
                $GrantControls.Add('customAuthenticationFactors', $CustomAuthenticationFactors)
            }
            if ($AuthenticationStrength)
            {
                $strengthPolicy = Get-MgBetaPolicyAuthenticationStrengthPolicy | Where-Object -FilterScript { $_.DisplayName -eq $AuthenticationStrength } -ErrorAction SilentlyContinue
                if ($null -ne $strengthPolicy)
                {
                    $authenticationStrengthInstance = @{
                        id            = $strengthPolicy.Id
                        '@odata.type' = '#microsoft.graph.authenticationStrengthPolicy'
                    }
                    $GrantControls.Add('authenticationStrength', $authenticationStrengthInstance)
                }
            }

            if ($TermsOfUse)
            {
                Write-Verbose -Message "Gettign Terms of Use {$TermsOfUse}"
                $TermsOfUseObj = Get-MgBetaAgreement | Where-Object -FilterScript { $_.DisplayName -eq $TermsOfUse }
                $GrantControls.Add('termsOfUse', $TermsOfUseObj.Id)
            }

            #no translation or conversion needed
            Write-Verbose -Message 'Set-Targetresource: Adding processed grant controls'
            $NewParameters.Add('grantControls', $GrantControls)
        }

        Write-Verbose -Message 'Set-Targetresource: process session controls'

        $sessioncontrols = $null
        if ($ApplicationEnforcedRestrictionsIsEnabled -or $CloudAppSecurityIsEnabled -or $SignInFrequencyIsEnabled -or $PersistentBrowserIsEnabled)
        {
            Write-Verbose -Message 'Set-Targetresource: create provision Session Control object'
            $sessioncontrols = @{
                applicationEnforcedRestrictions = @{}
            }

            if ($ApplicationEnforcedRestrictionsIsEnabled -eq $true)
            {
                #create and provision ApplicationEnforcedRestrictions object if used
                $sessioncontrols.applicationEnforcedRestrictions.Add('IsEnabled', $true)
            }
            if ($CloudAppSecurityIsEnabled)
            {
                $cloudAppSecurityValue = @{
                    isEnabled            = $false
                    cloudAppSecurityType = $null
                }

                $sessioncontrols.Add('cloudAppSecurity', $CloudAppSecurityValue)
                #create and provision CloudAppSecurity object if used
                $sessioncontrols.cloudAppSecurity.isEnabled = $true
                $sessioncontrols.cloudAppSecurity.cloudAppSecurityType = $CloudAppSecurityType
            }
            if ($SignInFrequencyIsEnabled)
            {
                $signinFrequencyProp = @{
                    isEnabled         = $true
                    type              = $null
                    value             = $null
                    frequencyInterval = $null
                }

                $sessioncontrols.Add('signInFrequency', $SigninFrequencyProp)
                #create and provision SignInFrequency object if used
                $sessioncontrols.signInFrequency.isEnabled = $true
                if ($SignInFrequencyType -ne '')
                {
                    $sessioncontrols.signInFrequency.type = $SignInFrequencyType
                }
                else
                {
                    $sessioncontrols.signInFrequency.Remove('type') | Out-Null
                }
                if ($SignInFrequencyValue -gt 0)
                {
                    $sessioncontrols.signInFrequency.value = $SignInFrequencyValue
                }
                else
                {
                    $sessioncontrols.signInFrequency.Remove('value') | Out-Null
                }
                $sessioncontrols.signInFrequency.frequencyInterval = $SignInFrequencyInterval
            }
            if ($PersistentBrowserIsEnabled)
            {
                $persistentBrowserValue = @{
                    isEnabled = $false
                    mode      = $false
                }
                $sessioncontrols.Add('persistentBrowser', $PersistentBrowserValue)
                Write-Verbose -Message "Set-Targetresource: Persistent Browser settings defined: PersistentBrowserIsEnabled:$PersistentBrowserIsEnabled, PersistentBrowserMode:$PersistentBrowserMode"
                #create and provision PersistentBrowser object if used
                $sessioncontrols.persistentBrowser.isEnabled = $true
                $sessioncontrols.persistentBrowser.mode = $PersistentBrowserMode
            }
        }
        $NewParameters.Add('sessionControls', $sessioncontrols)
        #add SessionControls to the parameter list
    }

    Write-Host "newparameters: $($NewParameters | ConvertTo-Json -Depth 5)"

    if ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Set-Targetresource: Change policy $DisplayName"
        $NewParameters.Add('ConditionalAccessPolicyId', $currentPolicy.Id)
        try
        {
            Write-Verbose -Message "Updating existing policy with values: $(Convert-M365DscHashtableToString -Hashtable $NewParameters)"

            $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/identity/conditionalAccess/policies/$($currentPolicy.Id)"
            Invoke-MgGraphRequest -Method PATCH -Uri $Uri -Body $NewParameters
        }
        catch
        {
            New-M365DSCLogEntry -Message 'Error updating data:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential

            Write-Error -Message "Set-Targetresource: Failed changing policy $DisplayName"
        }
    }
    elseif ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Set-Targetresource: create policy $DisplayName"
        Write-Verbose -Message 'Create Parameters:'
        Write-Verbose -Message (Convert-M365DscHashtableToString $NewParameters)

        if ($newparameters.Conditions.applications.count -gt 0 -and $newparameters.Conditions.Users.count -gt 0 -and ($newparameters.GrantControls.count -gt 0 -or $newparameters.SessionControls.count -gt 0))
        {
            try
            {
                $Uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "beta/identity/conditionalAccess/policies"
                Invoke-MgGraphRequest -Method POST -Uri $Uri -Body $NewParameters
            }
            catch
            {
                New-M365DSCLogEntry -Message 'Error creating new policy:' `
                    -Exception $_ `
                    -Source $($MyInvocation.MyCommand.Source) `
                    -TenantId $TenantId `
                    -Credential $Credential

                Write-Error -Message 'Set-Targetresource: Failed creating new policy'
            }
        }
        else
        {
            New-M365DSCLogEntry -Message 'Error creating new policy:' `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential

            Write-Error -Message 'Set-Targetresource: Failed creating new policy. At least a user rule, application rule and grant or session control is required'
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Set-Targetresource: delete policy $DisplayName"
        try
        {
            Remove-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $currentPolicy.ID
        }
        catch
        {
            New-M365DSCLogEntry -Message 'Error updating data:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential

            Write-Error -Message "Set-Targetresource: Failed deleting policy $DisplayName"
        }
    }
    Write-Verbose -Message "Set-Targetresource: Finished processing Policy $Displayname"
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
        [ValidateSet('disabled', 'enabled', 'enabledForReportingButNotEnforced')]
        $State,

        #ConditionalAccessApplicationCondition
        [Parameter()]
        [System.String[]]
        $IncludeApplications,

        [Parameter()]
        [System.String[]]
        $ExcludeApplications,

        [Parameter()]
        [System.String]
        $ApplicationsFilter,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ApplicationsFilterMode,

        [Parameter()]
        [System.String[]]
        $IncludeUserActions,

        #ConditionalAccessUserCondition
        [Parameter()]
        [System.String[]]
        $IncludeUsers,

        [Parameter()]
        [System.String[]]
        $ExcludeUsers,

        [Parameter()]
        [System.String[]]
        $IncludeGroups,

        [Parameter()]
        [System.String[]]
        $ExcludeGroups,

        [Parameter()]
        [System.String[]]
        $IncludeRoles,

        [Parameter()]
        [System.String[]]
        $ExcludeRoles,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $IncludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $IncludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $IncludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        [validateSet('none', 'internalGuest', 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'otherExternalUser', 'serviceProvider', 'unknownFutureValue')]
        $ExcludeGuestOrExternalUserTypes,

        [Parameter()]
        [System.String]
        [ValidateSet('', 'all', 'enumerated', 'unknownFutureValue')]
        $ExcludeExternalTenantsMembershipKind,

        [Parameter()]
        [System.String[]]
        $ExcludeExternalTenantsMembers,

        [Parameter()]
        [System.String[]]
        $IncludeServicePrincipals,

        [Parameter()]
        [System.String[]]
        $ExcludeServicePrincipals,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $ServicePrincipalFilterMode,

        [Parameter()]
        [System.String]
        $ServicePrincipalFilterRule,

        #ConditionalAccessPlatformCondition
        [Parameter()]
        [System.String[]]
        $IncludePlatforms,

        [Parameter()]
        [System.String[]]
        $ExcludePlatforms,

        #ConditionalAccessLocationCondition
        [Parameter()]
        [System.String[]]
        $IncludeLocations,

        [Parameter()]
        [System.String[]]
        $ExcludeLocations,

        [Parameter()]
        [ValidateSet('include', 'exclude')]
        [System.String]
        $DeviceFilterMode,

        [Parameter()]
        [System.String]
        $DeviceFilterRule,

        #Further conditions
        [Parameter()]
        [System.String[]]
        $UserRiskLevels,

        [Parameter()]
        [System.String[]]
        $SignInRiskLevels,

        [Parameter()]
        [System.String[]]
        $ClientAppTypes,

        #ConditionalAccessGrantControls
        [Parameter()]
        [ValidateSet('AND', 'OR')]
        [System.String]
        $GrantControlOperator,

        [Parameter()]
        [System.String[]]
        $BuiltInControls,

        #ConditionalAccessSessionControls
        [Parameter()]
        [System.Boolean]
        $ApplicationEnforcedRestrictionsIsEnabled,

        [Parameter()]
        [System.Boolean]
        $CloudAppSecurityIsEnabled,

        [Parameter()]
        [System.String]
        $CloudAppSecurityType,

        [Parameter()]
        [System.Int32]
        $SignInFrequencyValue,

        [Parameter()]
        [ValidateSet('Days', 'Hours', '')]
        [System.String]
        $SignInFrequencyType,

        [Parameter()]
        [System.Boolean]
        $SignInFrequencyIsEnabled,

        [Parameter()]
        [ValidateSet('timeBased', 'everyTime', 'unknownFutureValue')]
        [System.String]
        $SignInFrequencyInterval,

        [Parameter()]
        [ValidateSet('Always', 'Never', '')]
        [System.String]
        $PersistentBrowserMode,

        [Parameter()]
        [System.Boolean]
        $PersistentBrowserIsEnabled,

        [Parameter()]
        [System.String]
        $TermsOfUse,

        [Parameter()]
        [System.String[]]
        $CustomAuthenticationFactors,

        [Parameter()]
        [System.String]
        $AuthenticationStrength,

        [Parameter()]
        [System.String[]]
        $AuthenticationContexts,

        [Parameter()]
        [System.String]
        $TransferMethods,

        [Parameter()]
        [System.String]
        $InsiderRiskLevels,

        #generic
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
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message 'Testing configuration of AzureAD CA Policies'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Id') | Out-Null

    # If no TransferMethod is specified, ignore it
    # If a TransferMethod is specified, check if it is equal to the current value
    # while ignoring the order of the values
    if (-not $PSBoundParameters.ContainsKey('TransferMethods') -or
        $null -eq (Compare-Object -ReferenceObject $TransferMethods.Split(',') -DifferenceObject $CurrentValues.TransferMethods.Split(',')))
    {
        $ValuesToCheck.Remove('TransferMethods') | Out-Null
        $TestResult = $true
    }
    else
    {
        Write-Verbose -Message "TransferMethods are not equal: [$TransferMethods] - [$($CurrentValues.TransferMethods)]"
        $TestResult  = $false
    }

    if ($TestResult)
    {
        $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    try
    {
        [array] $Policies = Get-MgBetaIdentityConditionalAccessPolicy -Filter $Filter -All:$true -ErrorAction Stop
        $i = 1
        $dscContent = ''

        if ($Policies.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
            foreach ($Policy in $Policies)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                Write-Host "    |---[$i/$($Policies.Count)] $($Policy.DisplayName)" -NoNewline
                $Params = @{
                    DisplayName           = $Policy.DisplayName
                    Id                    = $Policy.Id
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    ApplicationSecret     = $ApplicationSecret
                    CertificateThumbprint = $CertificateThumbprint
                    Credential            = $Credential
                    Managedidentity       = $ManagedIdentity.IsPresent
                    AccessTokens          = $AccessTokens
                }
                $Results = Get-TargetResource @Params

                if ([System.String]::IsNullOrEmpty($Results.DeviceFilterMode))
                {
                    $Results.Remove('DeviceFilterMode') | Out-Null
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
                Write-Host $Global:M365DSCEmojiGreenCheckMark
                $i++
            }
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
