function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [validateset('Public', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [System.Boolean]
        $IsMemberManagementRestricted,

        [Parameter()]
        [validateset('Assigned', 'Dynamic')]
        [System.String]
        $MembershipType,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [validateset('Paused', 'On')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Members,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ScopedRoleMembers,
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
        if (-not $Script:exportedInstance)
        {
            try
            {
                $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                    -InboundParameters $PSBoundParameters
            }
            catch
            {
                Write-Verbose -Message ($_)
            }

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
            if (-not [string]::IsNullOrEmpty($Id))
            {
                $getValue = Get-MgBetaDirectoryAdministrativeUnit -AdministrativeUnitId $Id -ErrorAction SilentlyContinue
            }

            if ($null -eq $getValue -and -not [string]::IsNullOrEmpty($DisplayName))
            {
                Write-Verbose -Message "Could not find an Azure AD Administrative Unit by Id, trying by DisplayName {$DisplayName}"
                if (-Not [string]::IsNullOrEmpty($DisplayName))
                {
                    $getValue = Get-MgBetaDirectoryAdministrativeUnit -Filter "DisplayName eq '$DisplayName'" -ErrorAction Stop
                }
            }
            #endregion
            if ($null -eq $getValue)
            {
                Write-Verbose -Message "Could not find an Azure AD Administrative Unit with DisplayName {$DisplayName}"
                return $nullResult
            }
        }
        else
        {
            $getValue = $Script:exportedInstance
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Administrative Unit with Id {$Id} and DisplayName {$DisplayName} was found."
        $results = @{
            #region resource generator code
            Description                  = $getValue.Description
            DisplayName                  = $getValue.DisplayName
            Visibility                   = $getValue.Visibility
            IsMemberManagementRestricted = $getValue.IsMemberManagementRestricted
            Id                           = $getValue.Id
            Ensure                       = 'Present'
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            TenantId                     = $TenantId
            ApplicationSecret            = $ApplicationSecret
            CertificateThumbprint        = $CertificateThumbprint
            Managedidentity              = $ManagedIdentity.IsPresent
            AccessTokens                 = $AccessTokens
            #endregion
        }

        if (-not [string]::IsNullOrEmpty($getValue.membershipType))
        {
            $results.Add('MembershipType', $getValue.membershipType)
        }
        if (-not [string]::IsNullOrEmpty($getValue.membershipRule))
        {
            $results.Add('MembershipRule', $getValue.membershipRule)
        }
        if (-not [string]::IsNullOrEmpty($getValue.membershipRuleProcessingState))
        {
            $results.Add('MembershipRuleProcessingState', $getValue.membershipRuleProcessingState)
        }

        Write-Verbose -Message "AU {$DisplayName} MembershipType {$($results.MembershipType)}"
        if ($results.MembershipType -ne 'Dynamic')
        {
            Write-Verbose -Message "AU {$DisplayName} get Members"
            [array]$auMembers = Get-MgBetaDirectoryAdministrativeUnitMember -AdministrativeUnitId $getValue.Id -All
            if ($auMembers.Count -gt 0)
            {
                Write-Verbose -Message "AU {$DisplayName} process $($auMembers.Count) members"
                $memberSpec = @()
                foreach ($auMember in $auMembers)
                {
                    $member = @{}
                    $url = (Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl + "v1.0/directoryobjects/$($auMember.Id)"
                    $memberObject = Invoke-MgGraphRequest -Uri $url
                    if ($memberObject.'@odata.type' -match 'user')
                    {
                        $member.Add('Identity', $memberObject.UserPrincipalName)
                        $member.Add('Type', 'User')
                    }
                    elseif ($memberObject.'@odata.type' -match 'group')
                    {
                        $member.Add('Identity', $memberObject.DisplayName)
                        $member.Add('Type', 'Group')
                    }
                    else
                    {
                        $member.Add('Identity', $memberObject.DisplayName)
                        $member.Add('Type', 'Device')
                    }
                    Write-Verbose -Message "AU {$DisplayName} member found: Type '$($member.Type)' identity '$($member.Identity)'"
                    $memberSpec += $member
                }
                Write-Verbose -Message "AU {$DisplayName} add Members to results"
                $results.Add('Members', $memberSpec)
            }
        }

        Write-Verbose -Message "AU {$DisplayName} get Scoped Role Members"
        $ErrorActionPreference = 'Stop'
        [array]$auScopedRoleMembers = Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId $getValue.Id -All
        if ($auScopedRoleMembers.Count -gt 0)
        {
            Write-Verbose -Message "AU {$DisplayName} process $($auScopedRoleMembers.Count) scoped role members"
            $scopedRoleMemberSpec = @()
            foreach ($auScopedRoleMember in $auScopedRoleMembers)
            {
                Write-Verbose -Message "AU {$DisplayName} verify RoleId {$($auScopedRoleMember.RoleId)}"
                $roleObject = Get-MgBetaDirectoryRole -DirectoryRoleId $auScopedRoleMember.RoleId -ErrorAction Stop
                Write-Verbose -Message "Found DirectoryRole '$($roleObject.DisplayName)' with id $($roleObject.Id)"
                $scopedRoleMember = [ordered]@{
                    RoleName       = $roleObject.DisplayName
                    RoleMemberInfo = @{
                        Type     = $null
                        Identity = $null
                    }
                }
                Write-Verbose -Message "AU {$DisplayName} verify RoleMemberInfo.Id {$($auScopedRoleMember.RoleMemberInfo.Id)}"
                $url = (Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl + "v1.0/directoryobjects/$($auScopedRoleMember.RoleMemberInfo.Id)"
                $memberObject = Invoke-MgGraphRequest -Uri $url
                Write-Verbose -Message "AU {$DisplayName} @odata.Type={$($memberObject.'@odata.type')}"
                if (($memberObject.'@odata.type') -match 'user')
                {
                    Write-Verbose -Message "AU {$DisplayName} UPN = {$($memberObject.UserPrincipalName)}"
                    $scopedRoleMember.RoleMemberInfo.Identity = $memberObject.UserPrincipalName
                    $scopedRoleMember.RoleMemberInfo.Type = 'User'
                }
                elseif (($memberObject.'@odata.type') -match 'group')
                {
                    Write-Verbose -Message "AU {$DisplayName} Group = {$($memberObject.DisplayName)}"
                    $scopedRoleMember.RoleMemberInfo.Identity = $memberObject.DisplayName
                    $scopedRoleMember.RoleMemberInfo.Type = 'Group'
                }
                else
                {
                    Write-Verbose -Message "AU {$DisplayName} SPN = {$($memberObject.DisplayName)}"
                    $scopedRoleMember.RoleMemberInfo.Identity = $memberObject.DisplayName
                    $scopedRoleMember.RoleMemberInfo.Type = 'ServicePrincipal'
                }
                Write-Verbose -Message "AU {$DisplayName} scoped role member: RoleName '$($scopedRoleMember.RoleName)' Type '$($scopedRoleMember.RoleMemberInfo.Type)' Identity '$($scopedRoleMember.RoleMemberInfo.Identity)'"
                $scopedRoleMemberSpec += $scopedRoleMember
            }
            Write-Verbose -Message "AU {$DisplayName} add $($scopedRoleMemberSpec.Count) ScopedRoleMembers to results"
            $results.Add('ScopedRoleMembers', $scopedRoleMemberSpec)
        }
        Write-Verbose -Message "AU {$DisplayName} return results"
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
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [validateset('Public', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [System.Boolean]
        $IsMemberManagementRestricted,

        [Parameter()]
        [validateset('Assigned', 'Dynamic')]
        [System.String]
        $MembershipType,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [validateset('Paused', 'On')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Members,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ScopedRoleMembers,
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
    }
    catch
    {
        Write-Verbose -Message $_
    }

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

    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null
    $PSBoundParameters.Remove('ManagedIdentity') | Out-Null
    $PSBoundParameters.Remove('Verbose') | Out-Null
    $PSBoundParameters.Remove('AccessTokens') | Out-Null

    $backCurrentMembers = $currentInstance.Members
    $backCurrentScopedRoleMembers = $currentInstance.ScopedRoleMembers

    if ($Ensure -eq 'Present')
    {
        if ($MembershipType -eq 'Dynamic' -and $Members.Count -gt 0)
        {
            throw "AU {$($DisplayName)}: Members is not allowed when MembershipType is Dynamic"
        }
        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()
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
        $memberSpecification = $null
        if ($CreateParameters.MembershipType -ne 'Dynamic' -and $CreateParameters.Members.Count -gt 0)
        {
            $memberSpecification = @()
            Write-Verbose -Message "AU {$DisplayName} process $($CreateParameters.Members.Count) Members"
            foreach ($member in $CreateParameters.Members)
            {
                Write-Verbose -Message "AU {$DisplayName} member Type '$($member.Type)' Identity '$($member.Identity)'"
                if ($member.Type -eq 'User')
                {
                    $memberIdentity = Get-MgUser -Filter "UserPrincipalName eq '$($member.Identity)'" -ErrorAction Stop
                    if ($memberIdentity)
                    {
                        $memberSpecification += [pscustomobject]@{Type = "$($member.Type)s"; Id = $memberIdentity.Id }
                    }
                    else
                    {
                        throw "AU {$($DisplayName)}: User {$($member.Identity)} does not exist"
                    }
                }
                elseif ($member.Type -eq 'Group')
                {
                    $memberIdentity = Get-MgGroup -Filter "DisplayName eq '$($member.Identity)'" -ErrorAction Stop
                    if ($memberIdentity)
                    {
                        if ($memberIdentity.Count -gt 1)
                        {
                            throw "AU {$($DisplayName)}: Group displayname {$($member.Identity)} is not unique"
                        }
                        $memberSpecification += [pscustomobject]@{Type = "$($member.Type)s"; Id = $memberIdentity.Id }
                    }
                    else
                    {
                        throw "AU {$($DisplayName)}: Group {$($member.Identity)} does not exist"
                    }
                }
                elseif ($member.Type -eq 'Device')
                {
                    $memberIdentity = Get-MgBetaDevice -Filter "DisplayName eq '$($member.Identity)'" -ErrorAction Stop
                    if ($memberIdentity)
                    {
                        if ($memberIdentity.Count -gt 1)
                        {
                            throw "AU {$($DisplayName)}: Device displayname {$($member.Identity)} is not unique"
                        }
                        $memberSpecification += [pscustomobject]@{Type = "$($member.Type)s"; Id = $memberIdentity.Id }
                    }
                    else
                    {
                        throw "AU {$($DisplayName)}: Device {$($Member.Identity)} does not exist"
                    }
                }
                else
                {
                    throw "AU {$($DisplayName)}: Member {$($Member.Identity)} has invalid type {$($Member.Type)}"
                }
            }
            # Members are added to the AU *after* it has been created
        }
        $CreateParameters.Remove('Members') | Out-Null

        # Resolve ScopedRoleMembers Type/Identity to user, group or service principal
        if ($CreateParameters.ScopedRoleMembers)
        {
            Write-Verbose -Message "AU {$DisplayName} process $($CreateParameters.ScopedRoleMembers.Count) ScopedRoleMembers"
            $scopedRoleMemberSpecification = @()
            foreach ($roleMember in $CreateParameters.ScopedRoleMembers)
            {
                Write-Verbose -Message "AU {$DisplayName} member: role '$($roleMember.RoleName)' type '$($roleMember.RoleMemberInfo.Type)' identity $($roleMember.RoleMemberInfo.Identity)"
                try
                {
                    $roleObject = Get-MgBetaDirectoryRole -Filter "DisplayName eq '$($roleMember.RoleName)'" -ErrorAction stop
                    Write-Verbose -Message "AU {$DisplayName} role is enabled"
                }
                catch
                {
                    Write-Verbose -Message "Azure AD role {$($rolemember.RoleName)} is not enabled"
                    $roleTemplate = Get-MgBetaDirectoryRoleTemplate -All -ErrorAction Stop | Where-Object { $_.DisplayName -eq $rolemember.RoleName }
                    if ($null -ne $roleTemplate)
                    {
                        Write-Verbose -Message "Enable Azure AD role {$($rolemember.RoleName)} with id {$($roleTemplate.Id)}"
                        $roleObject = New-MgBetaDirectoryRole -RoleTemplateId $roleTemplate.Id -ErrorAction Stop
                    }
                }
                if ($null -eq $roleObject)
                {
                    throw "AU {$($DisplayName)}: RoleName {$($roleMember.RoleName)} does not exist"
                }
                if ($roleMember.RoleMemberInfo.Type -eq 'User')
                {
                    $roleMemberIdentity = Get-MgUser -Filter "UserPrincipalName eq '$($roleMember.RoleMemberInfo.Identity)'" -ErrorAction Stop
                    if ($null -eq $roleMemberIdentity)
                    {
                        throw "AU {$($DisplayName)}:  Scoped Role User {$($roleMember.RoleMemberInfo.Identity)} for role {$($roleMember.RoleName)} does not exist"
                    }
                }
                elseif ($roleMember.RoleMemberInfo.Type -eq 'Group')
                {
                    $roleMemberIdentity = Get-MgGroup -Filter "displayName eq '$($roleMember.RoleMemberInfo.Identity)'" -ErrorAction Stop
                    if ($null -eq $roleMemberIdentity)
                    {
                        throw "AU {$($DisplayName)}: Scoped Role Group {$($roleMember.RoleMemberInfo.Identity)} for role {$($roleMember.RoleName)} does not exist"
                    }
                    elseif ($roleMemberIdentity.IsAssignableToRole -eq $false)
                    {
                        throw "AU {$($DisplayName)}: Scoped Role Group {$($roleMember.RoleMemberInfo.Identity)} for role {$($roleMember.RoleName)} is not role-enabled"
                    }
                }
                elseif ($roleMember.RoleMemberInfo.Type -eq 'ServicePrincipal')
                {
                    $roleMemberIdentity = Get-MgServicePrincipal -Filter "displayName eq '$($roleMember.RoleMemberInfo.Identity)'" -ErrorAction Stop
                    if ($null -eq $roleMemberIdentity)
                    {
                        throw "AU {$($DisplayName)}: Scoped Role ServicePrincipal {$($roleMember.RoleMemberInfo.Identity)} for role {$($roleMember.RoleName)} does not exist"
                    }
                }
                else
                {
                    throw "AU {$($DisplayName)}: Invalid ScopedRoleMember.RoleMemberInfo.Type {$($roleMember.RoleMemberInfo.Type)}"
                }
                if ($roleMemberIdentity.Count -gt 1)
                {
                    throw "AU {$($DisplayName)}: ScopedRoleMember for role {$($roleMember.RoleName)}: $($roleMember.RoleMemberInfo.Type) {$($roleMember.RoleMemberInfo.Identity)} is not unique"
                }
                $scopedRoleMemberSpecification += @{
                    RoleId         = $roleObject.Id
                    RoleMemberInfo = @{
                        Id = $roleMemberIdentity.Id
                    }
                }
            }
            # ScopedRoleMember-info is added after the AU is created
        }
        $CreateParameters.Remove('ScopedRoleMembers') | Out-Null
    }

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Azure AD Administrative Unit with DisplayName {$DisplayName}"

        #region resource generator code
        Write-Verbose -Message "Creating new Administrative Unit with: $(Convert-M365DscHashtableToString -Hashtable $CreateParameters)"

        $policy = New-MgBetaDirectoryAdministrativeUnit @CreateParameters

        if ($MembershipType -ne 'Dynamic')
        {
            foreach ($member in $memberSpecification)
            {
                Write-Verbose -Message "Adding new dynamic member {$($member.Id)}"
                $url = (Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl + "beta/$($member.Type)/$($member.Id)"
                $memberBodyParam = @{
                    '@odata.id' = $url
                }

                New-MgBetaDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId $policy.Id -BodyParameter $memberBodyParam
            }
        }

        foreach ($scopedRoleMember in $scopedRoleMemberSpecification)
        {
            New-MgBetaDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId $policy.Id -BodyParameter $scopedRoleMember
        }


        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Administrative Unit with Id {$($currentInstance.Id)}"

        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()
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

        $requestedMembers = $UpdateParameters.Members
        $UpdateParameters.Remove('Members') | Out-Null
        $requestedScopedRoleMembers = $UpdateParameters.ScopedRoleMembers
        $UpdateParameters.Remove('ScopedRoleMembers') | Out-Null

        #region resource generator code
        Update-MgBetaDirectoryAdministrativeUnit @UpdateParameters `
            -AdministrativeUnitId $currentInstance.Id
        #endregion

        if ($MembershipType -ne 'Dynamic')
        {
            if ($PSBoundParameters.ContainsKey('Members') -and ($backCurrentMembers.Count -gt 0 -or $requestedMembers.Count -gt 0))
            {
                $currentMembers = @()
                foreach ($member in $backCurrentMembers)
                {
                    $currentMembers += [pscustomobject]@{Type = $member.Type; Identity = $member.Identity }
                }
                $desiredMembers = @()
                foreach ($member in $requestedMembers)
                {
                    $desiredMembers += [pscustomobject]@{Type = $member.Type; Identity = $member.Identity }
                }
                $membersDiff = Compare-Object -ReferenceObject $currentMembers -DifferenceObject $desiredMembers -Property Identity, Type
                foreach ($diff in $membersDiff)
                {
                    if ($diff.Type -eq 'User')
                    {
                        $memberObject = Get-MgUser -Filter "UserPrincipalName eq '$($diff.Identity)'"
                        $memberType = 'users'
                    }
                    elseif ($diff.Type -eq 'Group')
                    {
                        $memberObject = Get-MgGroup -Filter "DisplayName eq '$($diff.Identity)'"
                        $membertype = 'groups'
                    }
                    elseif ($diff.Type -eq 'Device')
                    {
                        $memberObject = Get-MgBetaDevice -Filter "DisplayName eq '$($diff.Identity)'"
                        $membertype = 'devices'
                    }
                    else
                    {
                        # a *new* member has been specified with invalid type
                        throw "AU {$($DisplayName)}: Member {$($diff.Identity)} has invalid type {$($diff.Type)}"
                    }
                    if ($null -eq $memberObject)
                    {
                        throw "AU member {$($diff.Identity)} does not exist as a $($diff.Type)"
                    }
                    if ($memberObject.Count -gt 1)
                    {
                        throw "AU member {$($diff.Identity)} is not a unique $($diff.Type.ToLower()) (Count=$($memberObject.Count))"
                    }
                    if ($diff.SideIndicator -eq '=>')
                    {
                        Write-Verbose -Message "AdministrativeUnit {$DisplayName} Adding member {$($diff.Identity)}, type {$($diff.Type)}"

                        $url = (Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl + "beta/$memberType/$($memberObject.Id)"
                        $memberBodyParam = @{
                            '@odata.id' = $url
                        }
                        New-MgBetaDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId ($currentInstance.Id) -BodyParameter $memberBodyParam | Out-Null
                    }
                    else
                    {
                        Write-Verbose -Message "Administrative Unit {$DisplayName} Removing member {$($diff.Identity)}, type {$($diff.Type)}"
                        Remove-MgBetaDirectoryAdministrativeUnitMemberDirectoryObjectByRef -AdministrativeUnitId ($currentInstance.Id) -DirectoryObjectId ($memberObject.Id) | Out-Null
                    }
                }
            }
        }

        if ($PSBoundParameters.ContainsKey('ScopedRoleMembers') -and ($backCurrentScopedRoleMembers.Count -gt 0 -or $requestedScopedRoleMembers.Count -gt 0))
        {
            $currentScopedRoleMembersValue = @()
            if ($currentInstance.ScopedRoleMembers.Length -ne 0)
            {
                $currentScopedRoleMembersValue = $backCurrentScopedRoleMembers
            }
            if ($null -eq $currentScopedRoleMembersValue)
            {
                $currentScopedRoleMembersValue = @()
            }
            $desiredScopedRoleMembersValue = $requestedScopedRoleMembers
            if ($null -eq $desiredScopedRoleMembersValue)
            {
                $desiredScopedRoleMembersValue = @()
            }

            # flatten hashtables for compare
            $compareCurrentScopedRoleMembersValue = @()
            foreach ($roleMember in $currentScopedRoleMembersValue)
            {
                $compareCurrentScopedRoleMembersValue += [pscustomobject]@{
                    RoleName = $roleMember.RoleName
                    Identity = $roleMember.RoleMemberInfo.Identity
                    Type     = $roleMember.RoleMemberInfo.Type
                }
            }
            $compareDesiredScopedRoleMembersValue = @()
            foreach ($roleMember in $desiredScopedRoleMembersValue)
            {
                $compareDesiredScopedRoleMembersValue += [pscustomobject]@{
                    RoleName = $roleMember.RoleName
                    Identity = $roleMember.RoleMemberInfo.Identity
                    Type     = $roleMember.RoleMemberInfo.Type
                }
            }
            Write-Verbose -Message "AU {$DisplayName} Update ScopedRoleMembers: Current members: $($compareCurrentScopedRoleMembersValue.Identity -join ', ')"
            Write-Verbose -Message "                                            Desired members: $($compareDesiredScopedRoleMembersValue.Identity -join ', ')"
            $scopedRoleMembersDiff = Compare-Object -ReferenceObject $compareCurrentScopedRoleMembersValue -DifferenceObject $compareDesiredScopedRoleMembersValue -Property RoleName, Identity, Type
            # $scopedRoleMembersDiff = Compare-Object -ReferenceObject $CurrentScopedRoleMembersValue -DifferenceObject $DesiredScopedRoleMembersValue -Property RoleName, Identity, Type
            Write-Verbose -Message "                                            # compare results : $($scopedRoleMembersDiff.Count -gt 0)"

            foreach ($diff in $scopedRoleMembersDiff)
            {
                if ($diff.Type -eq 'User')
                {
                    $memberObject = Get-MgUser -Filter "UserPrincipalName eq '$($diff.Identity)'"
                    #$memberType = 'users'
                }
                elseif ($diff.Type -eq 'Group')
                {
                    $memberObject = Get-MgGroup -Filter "DisplayName eq '$($diff.Identity)'"
                    #$membertype = 'groups'
                }
                elseif ($diff.Type -eq 'ServicePrincipal')
                {
                    $memberObject = Get-MgServicePrincipal -Filter "DisplayName eq '$($diff.Identity)'"
                    #$memberType = "servicePrincipals"
                }
                else
                {
                    if ($diff.RoleName)
                    {
                        throw "AU {$DisplayName} scoped role {$($diff.RoleName)} member {$($diff.Identity)} has invalid type $($diff.Type)"
                    }
                    else
                    {
                        Write-Verbose -Message 'Compare ScopedRoleMembers - skip processing blank RoleName'
                        continue   # don't process,
                    }
                }
                if ($null -eq $memberObject)
                {
                    throw "AU scoped role member {$($diff.Identity)} does not exist as a $($diff.Type)"
                }
                if ($memberObject.Count -gt 1)
                {
                    throw "AU scoped role member {$($diff.Identity)} is not a unique $($diff.Type) (Count=$($memberObject.Count))"
                }
                if ($diff.SideIndicator -ne '==')
                {
                    $roleObject = Get-MgBetaDirectoryRole -Filter "DisplayName eq '$($diff.RoleName)'"
                    if ($null -eq $roleObject)
                    {
                        throw "AU {$DisplayName} Scoped Role {$($diff.RoleName)} does not exist as an Azure AD role"
                    }
                }
                if ($diff.SideIndicator -eq '=>')
                {
                    Write-Verbose -Message "Adding new scoped role {$($diff.RoleName)} member {$($diff.Identity)}, type {$($diff.Type)} to Administrative Unit {$DisplayName}"

                    $scopedRoleMemberParam = @{
                        RoleId         = $roleObject.Id
                        RoleMemberInfo = @{
                            Id = $memberObject.Id
                        }
                    }
                    # addition of scoped rolemember may throw if role is not supported as a scoped role
                    New-MgBetaDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId ($currentInstance.Id) -BodyParameter $scopedRoleMemberParam -ErrorAction Stop | Out-Null
                }
                else
                {
                    if (-not [string]::IsNullOrEmpty($diff.Rolename))
                    {
                        Write-Verbose -Message "Removing scoped role {$($diff.RoleName)} member {$($diff.Identity)}, type {$($diff.Type)} from Administrative Unit {$DisplayName}"
                        $scopedRoleMemberObject = Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId ($currentInstance.Id) -All | Where-Object -FilterScript { $_.RoleId -eq $roleObject.Id -and $_.RoleMemberInfo.Id -eq $memberObject.Id }
                        Remove-MgBetaDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId ($currentInstance.Id) -ScopedRoleMembershipId $scopedRoleMemberObject.Id -ErrorAction Stop | Out-Null
                    }
                }
            }
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing AU {$DisplayName}"
        # Workaround since Remove-MgBetaDirectoryAdministrativeUnit is not working with 2.11.1
        # https://github.com/microsoftgraph/msgraph-sdk-powershell/issues/2529
        $url = (Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl + "beta/administrativeUnits/$($currentInstance.Id)"
        Invoke-MgGraphRequest -Method DELETE -Uri $url | Out-Null
        #Remove-MgBetaDirectoryAdministrativeUnit -AdministrativeUnitId $currentInstance.Id
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
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [validateset('Public', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [System.Boolean]
        $IsMemberManagementRestricted,

        [Parameter()]
        [validateset('Assigned', 'Dynamic')]
        [System.String]
        $MembershipType,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [validateset('Paused', 'On')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Members,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $ScopedRoleMembers,
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

    Write-Verbose -Message "Testing configuration of the Azure AD Administrative Unit with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false - Ensure not the same"
        return $false
    }
    $testResult = $true

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($source.getType().Name -like '*CimInstance*')
        {
            $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $source

            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                Write-Verbose -Message "Difference found for $key"
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null

        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null

    # Visibility is currently not returned by Get-TargetResource
    $ValuesToCheck.Remove('Visibility') | Out-Null

    if ($ValuesToCheck.ContainsKey('MembershipType') -and $MembershipType -ne 'Dynamic' -and $CurrentValues.MembershipType -ne 'Dynamic')
    {
        # MembershipType may be returned as null or Assigned with same effect. Only compare if Dynamic is specified or returned
        $ValuesToCheck.Remove('MembershipType') | Out-Null
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
        $Script:ExportMode = $true
        #region resource generator code
        $ExportParameters = @{
            Filter      = $Filter
            All         = [switch]$true
            ErrorAction = 'Stop'
        }
        $queryTypes = @{
            'eq'         = @('description')
            'startsWith' = @('description')
            'eq null'    = @(
                'description',
                'displayName'
            )
        }

        #extract arguments from the query
        # Define the regex pattern to match all words in the query
        $pattern = '([^\s,()]+)'
        $query = $Filter

        # Match all words in the query
        $matches = [regex]::matches($query, $pattern)

        # Extract the matched argument into an array
        $arguments = @()
        foreach ($match in $matches)
        {
            $arguments += $match.Value
        }

        #extracting keys to check vs arguments in the filter
        $Keys = $queryTypes.Keys

        $matchedKey = $arguments | Where-Object { $_ -in $Keys }
        $matchedProperty = $arguments | Where-Object { $_ -in $queryTypes[$matchedKey] }
        if ($matchedProperty -and $matchedKey)
        {
            $allConditionsMatched = $true
        }

        # If all conditions match the support, add parameters to $ExportParameters
        if ($allConditionsMatched -or $Filter -like '*endsWith*')
        {
            $ExportParameters.Add('CountVariable', 'count')
            $ExportParameters.Add('headers', @{'ConsistencyLevel' = 'Eventual' })
        }

        [array] $Script:exportedInstances = Get-MgBetaDirectoryAdministrativeUnit @ExportParameters
        #endregion

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

            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                DisplayName           = $config.DisplayName
                Id                    = $config.Id
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Script:exportedInstance = $config
            $Results = Get-TargetResource @Params

            if ($null -ne $Results.ScopedRoleMembers)
            {
                $complexMapping = @(
                    @{
                        Name            = 'RoleMemberInfo'
                        CimInstanceName = 'MicrosoftGraphMember'
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.ScopedRoleMembers) `
                    -CIMInstanceName MicrosoftGraphScopedRoleMembership -ComplexTypeMapping $complexMapping

                $Results.ScopedRoleMembers = $complexTypeStringResult

                if ([String]::IsNullOrEmpty($complexTypeStringResult))
                {
                    $Results.Remove('ScopedRoleMembers') | Out-Null
                }
            }
            if ($null -ne $Results.Members)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.Members) `
                    -CIMInstanceName MicrosoftGraphMember
                $Results.Members = $complexTypeStringResult

                if ([String]::IsNullOrEmpty($complexTypeStringResult))
                {
                    $Results.Remove('Members') | Out-Null
                }
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($null -ne $Results.ScopedRoleMembers)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ScopedRoleMembers' -IsCIMArray $true
            }
            if ($null -ne $Results.Members)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'Members' -IsCIMArray $true
                $currentDSCBlock = $currentDSCBlock.Replace("`",`"`r`n", '')
                $currentDSCBlock = $currentDSCBlock.Replace(",`r`n", '').Replace("`");`r`n", ");`r`n")
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
        Write-Verbose -Message "Exception: $($_.Exception.Message)"

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
