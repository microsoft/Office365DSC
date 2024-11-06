function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $MailNickname,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $GroupAsMembers,

        [Parameter()]
        [System.String[]]
        $MemberOf,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.Boolean]
        $IsAssignableToRole,

        [Parameter()]
        [System.String[]]
        $AssignedToRole,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AssignedLicenses,

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

    Write-Verbose -Message 'Getting configuration of AzureAD Group'
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

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'
    $nullReturn.Owners = @()
    $nullReturn.Members = @()
    $nullReturn.MemberOf = @()
    $nullReturn.AssignedToRole = @()
    try
    {
        if ($PSBoundParameters.ContainsKey('Id'))
        {
            Write-Verbose -Message 'GroupID was specified'
            try
            {
                if ($null -ne $Script:exportedGroups -and $Script:ExportMode)
                {
                    $Group = $Script:exportedGroups | Where-Object -FilterScript { $_.Id -eq $Id }
                }
                else
                {
                    $Group = Get-MgGroup -GroupId $Id -ErrorAction Stop
                }
            }
            catch
            {
                Write-Verbose -Message "Couldn't get group by ID, trying by name"
                if ($null -ne $Script:exportedGroups -and $Script:ExportMode)
                {
                    $Group = $Script:exportedGroups | Where-Object -FilterScript { $_.DisplayName -eq $DisplayName }
                }
                else
                {
                    if ($DisplayName.Contains("'"))
                    {
                        $DisplayName = $DisplayName -replace "'", "''"
                    }
                    $filter = "DisplayName eq '$DisplayName'"
                    $Group = Get-MgGroup -Filter $filter -ErrorAction Stop
                }
                if ($Group.Length -gt 1)
                {
                    throw "Duplicate AzureAD Groups named $DisplayName exist in tenant"
                }
            }
        }
        else
        {
            Write-Verbose -Message 'Id was NOT specified'
            ## Can retreive multiple AAD Groups since displayname is not unique
            if ($null -ne $Script:exportedGroups -and $Script:ExportMode)
            {
                $Group = $Script:exportedGroups | Where-Object -FilterScript { $_.DisplayName -eq $DisplayName }
            }
            else
            {
                if ($DisplayName.Contains("'"))
                {
                    $DisplayName = $DisplayName -replace "'", "''"
                }
                $filter = "DisplayName eq '$DisplayName'"
                $Group = Get-MgGroup -Filter $filter -ErrorAction Stop
            }
            if ($Group.Length -gt 1)
            {
                throw "Duplicate AzureAD Groups named $DisplayName exist in tenant"
            }
        }

        if ($null -eq $Group)
        {
            Write-Verbose -Message 'Group was null, returning null'
            return $nullReturn
        }
        else
        {
            Write-Verbose -Message 'Found existing AzureAD Group'

            # Owners
            [Array]$owners = Get-MgBetaGroupOwner -GroupId $Group.Id -All:$true
            $OwnersValues = @()
            foreach ($owner in $owners)
            {
                if ($owner.AdditionalProperties.userPrincipalName -ne $null)
                {
                    $OwnersValues += $owner.AdditionalProperties.userPrincipalName
                }
                elseif($owner.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.servicePrincipal")
                {
                    $OwnersValues += $owner.AdditionalProperties.displayName
                }
            }

            $MembersValues = $null
            if ($Group.MembershipRuleProcessingState -ne 'On')
            {
                # Members
                [Array]$members = Get-MgBetaGroupMember -GroupId $Group.Id -All:$true
                $MembersValues = @()
                $GroupAsMembersValues = @()
                foreach ($member in $members)
                {
                    if ($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.user")
                    {
                        $MembersValues += $member.AdditionalProperties.userPrincipalName
                    }
                    elseif ($member.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.servicePrincipal')
                    {
                        $MembersValues += $member.AdditionalProperties.displayName
                    }
                    elseif($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.group")
                    {
                        $GroupAsMembersValues += $member.AdditionalProperties.displayName
                    }
                }
            }

            # MemberOf
            [Array]$memberOf = Get-MgBetaGroupMemberOf -GroupId $Group.Id -All # result also used for/by AssignedToRole
            $MemberOfValues = @()
            # Note: only process security-groups that this group is a member of and not directory roles (if any)
            foreach ($member in ($memberOf | Where-Object -FilterScript { $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.group' }))
            {
                if ($null -ne $member.AdditionalProperties.displayName)
                {
                    $MemberOfValues += $member.AdditionalProperties.displayName
                }
            }

            # AssignedToRole
            $AssignedToRoleValues = $null
            if ($Group.IsAssignableToRole -eq $true)
            {
                $AssignedToRoleValues = @()
                $roleAssignments = Get-MgBetaRoleManagementDirectoryRoleAssignment -Filter "PrincipalId eq '$($Group.Id)'"
                foreach ($assignment in $roleAssignments)
                {
                    $roleDefinition = Get-MgBetaRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $assignment.RoleDefinitionId
                    $AssignedToRoleValues += $roleDefinition.DisplayName
                }
            }

            # Licenses
            $assignedLicensesValues = $null
            $uri = $Global:MSCloudLoginConnectionProfile.MicrosoftGraph.ResourceUrl + "v1.0/groups/$($Group.Id)/assignedLicenses"
            $assignedLicensesRequest = Invoke-MgGraphRequest -Method 'GET' `
                -Uri $uri

            if ($assignedLicensesRequest.value.Length -gt 0)
            {
                $assignedLicensesValues = Get-M365DSCAzureADGroupLicenses -AssignedLicenses $assignedLicensesRequest.value

            }

            $result = @{
                DisplayName                   = $Group.DisplayName
                Id                            = $Group.Id
                Owners                        = $OwnersValues
                Members                       = $MembersValues
                GroupAsMembers                = $GroupAsMembersValues
                MemberOf                      = $MemberOfValues
                Description                   = $Group.Description
                GroupTypes                    = [System.String[]]$Group.GroupTypes
                MembershipRule                = $Group.MembershipRule
                MembershipRuleProcessingState = $Group.MembershipRuleProcessingState
                SecurityEnabled               = $Group.SecurityEnabled
                MailEnabled                   = $Group.MailEnabled
                IsAssignableToRole            = $Group.IsAssignableToRole
                AssignedToRole                = $AssignedToRoleValues
                MailNickname                  = $Group.MailNickname
                Visibility                    = $Group.Visibility
                AssignedLicenses              = $assignedLicensesValues
                Ensure                        = 'Present'
                ApplicationId                 = $ApplicationId
                TenantId                      = $TenantId
                CertificateThumbprint         = $CertificateThumbprint
                ApplicationSecret             = $ApplicationSecret
                Credential                    = $Credential
                Managedidentity               = $ManagedIdentity.IsPresent
                AccessTokens                  = $AccessTokens
            }

            return $result
        }
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        throw $_
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

        [Parameter(Mandatory = $true)]
        [System.String]
        $MailNickname,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $GroupAsMembers,

        [Parameter()]
        [System.String[]]
        $MemberOf,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.Boolean]
        $IsAssignableToRole,

        [Parameter()]
        [System.string[]]
        $AssignedToRole,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AssignedLicenses,

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

    Write-Verbose -Message 'Setting configuration of Azure AD Groups'

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

    $currentParameters = [hashtable]$PSBoundParameters
    $currentGroup = Get-TargetResource @PSBoundParameters
    $currentParameters.Remove('ApplicationId') | Out-Null
    $currentParameters.Remove('TenantId') | Out-Null
    $currentParameters.Remove('CertificateThumbprint') | Out-Null
    $currentParameters.Remove('ApplicationSecret') | Out-Null
    $currentParameters.Remove('Ensure') | Out-Null
    $currentParameters.Remove('Credential') | Out-Null
    $currentParameters.Remove('ManagedIdentity') | Out-Null
    $backCurrentOwners = $currentGroup.Owners
    $backCurrentMembers = $currentGroup.Members
    $backCurrentGroupAsMembers = $currentGroup.GroupAsMembers
    $backCurrentMemberOf = $currentGroup.MemberOf
    $backCurrentAssignedToRole = $currentGroup.AssignedToRole
    $currentParameters.Remove('Owners') | Out-Null
    $currentParameters.Remove('Members') | Out-Null
    $currentParameters.Remove('GroupAsMembers') | Out-Null
    $currentParameters.Remove('MemberOf') | Out-Null
    $currentParameters.Remove('AssignedToRole') | Out-Null

    if ($Ensure -eq 'Present' -and `
        ($null -ne $GroupTypes -and $GroupTypes.Contains('Unified')) -and `
        ($null -ne $MailEnabled -and $MailEnabled -eq $false))
    {
        Write-Verbose -Message 'Cannot set mailenabled to false if GroupTypes is set to Unified when creating group.'
        throw 'Cannot set mailenabled to false if GroupTypes is set to Unified when creating a group.'
    }

    $currentValuesToCheck = @()
    if ($currentGroup.AssignedLicenses.Length -gt 0)
    {
        $currentValuesToCheck = $currentGroup.AssignedLicenses.SkuId
    }
    $desiredValuesToCheck = @()
    if ($AssignedLicenses.Length -gt 0)
    {
        $desiredValuesToCheck = $AssignedLicenses.SkuId
    }

    [Array]$licensesDiff = Compare-Object -ReferenceObject $currentValuesToCheck -DifferenceObject $desiredValuesToCheck -IncludeEqual
    $toAdd = @()
    $toRemove = @()
    foreach ($diff in $licensesDiff)
    {
        if ($diff.SideIndicator -eq '=>')
        {
            $toAdd += $diff.InputObject
        }
        elseif ($diff.SideIndicator -eq '<=')
        {
            $toRemove += $diff.InputObject
        }
        elseif ($diff.SideIndicator -eq '==')
        {
            # This will take care of the scenario where the license is already assigned but has different disabled plans
            $toAdd += $diff.InputObject
        }
    }

    # Convert AssignedLicenses from SkuPartNumber back to GUID
    $licensesToAdd = @()
    $licensesToRemove = @()
    [Array]$AllLicenses = Get-M365DSCCombinedLicenses -DesiredLicenses $AssignedLicenses -CurrentLicenses $currentGroup.AssignedLicenses

    $allSkus = Get-MgBetaSubscribedSku
    # Create complete list of all Service Plans
    $allServicePlans = @()
    Write-Verbose -Message 'Getting all Service Plans'
    foreach ($sku in $allSkus)
    {
        foreach ($serviceplan in $sku.ServicePlans)
        {
            if ($allServicePlans.Length -eq 0 -or -not $allServicePlans.ServicePlanName.Contains($servicePlan.ServicePlanName))
            {
                $allServicePlans += @{
                    ServicePlanId   = $serviceplan.ServicePlanId
                    ServicePlanName = $serviceplan.ServicePlanName
                }
            }
        }
    }

    foreach ($assignedLicense in $AllLicenses)
    {
        $skuInfo = $allSkus | Where-Object -FilterScript { $_.SkuPartNumber -eq $assignedLicense.SkuId }
        if ($skuInfo)
        {
            if ($toAdd.Contains($assignedLicense.SkuId))
            {
                $disabledPlansValues = @()
                foreach ($plan in $assignedLicense.DisabledPlans)
                {
                    $foundItem = $allServicePlans | Where-Object -FilterScript { $_.ServicePlanName -eq $plan }
                    $disabledPlansValues += $foundItem.ServicePlanId
                }

                $skuInfo = $allSkus | Where-Object -FilterScript { $_.SkuPartNumber -eq $assignedLicense.SkuId }
                $licensesToAdd += @{
                    DisabledPlans = $disabledPlansValues
                    SkuId         = $skuInfo.SkuId
                }
            }
            elseif ($toRemove.Contains($assignedLicense.SkuId))
            {
                $licensesToRemove += $skuInfo.SkuId
            }
        }
    }

    $currentParameters.Remove('AssignedLicenses') | Out-Null

    if ($Ensure -eq 'Present' -and $currentGroup.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Checking to see if an existing deleted group exists with DisplayName {$DisplayName}"
        $restoringExisting = $false
        [Array]$groups = Get-MgBetaDirectoryDeletedItemAsGroup -Filter "DisplayName eq '$DisplayName'"
        if ($groups.Length -gt 1)
        {
            throw "Multiple deleted groups with the name {$DisplayName} were found. Cannot restore the existig group. Please ensure that you either have no instance of the group in the deleted list or that you have a single one."
        }

        if ($groups.Length -eq 1)
        {
            Write-Verbose -Message "Found an instance of a deleted group {$DisplayName}. Restoring it."
            Restore-MgBetaDirectoryDeletedItem -DirectoryObjectId $groups[0].Id
            $restoringExisting = $true
            $currentGroup = Get-MgGroup -Filter "DisplayName eq '$DisplayName'" -ErrorAction Stop
        }

        if (-not $restoringExisting)
        {
            Write-Verbose -Message "Creating new group {$DisplayName}"
            $currentParameters.Remove('Id') | Out-Null

            try
            {
                Write-Verbose -Message "Creating Group with Values: $(Convert-M365DscHashtableToString -Hashtable $currentParameters)"
                $currentGroup = New-MgGroup @currentParameters
                Write-Verbose -Message "Created Group $($currentGroup.id)"
            }
            catch
            {
                Write-Verbose -Message $_
                New-M365DSCLogEntry -Message "Couldn't create group $DisplayName" `
                    -Exception $_ `
                    -Source $MyInvocation.MyCommand.ModuleName
            }
        }
    }
    if ($Ensure -eq 'Present')
    {
        Write-Verbose -Message "Group {$DisplayName} exists and it should."
        try
        {
            Write-Verbose -Message "Updating settings by ID for group {$DisplayName}"
            if ($true -eq $currentParameters.ContainsKey('IsAssignableToRole'))
            {
                Write-Verbose -Message 'Cannot set IsAssignableToRole once group is created.'
                $currentParameters.Remove('IsAssignableToRole') | Out-Null
            }

            if ($false -eq $currentParameters.ContainsKey('Id'))
            {
                Update-MgGroup @currentParameters -GroupId $currentGroup.Id | Out-Null
            }
            else
            {
                $currentParameters.Remove('Id') | Out-Null
                $currentParameters.Add('GroupId', $currentGroup.Id)
                Write-Verbose -Message "Updating Group with Values: $(Convert-M365DscHashtableToString -Hashtable $currentParameters)"
                Update-MgGroup @currentParameters | Out-Null
            }

            if (($licensesToAdd.Length -gt 0 -or $licensesToRemove.Length -gt 0) -and $PSBoundParameters.ContainsKey('AssignedLicenses'))
            {
                try
                {
                    Write-Verbose -Message "Setting Group Licenses"
                    Set-MgGroupLicense -GroupId $currentGroup.Id `
                        -AddLicenses $licensesToAdd `
                        -RemoveLicenses $licensesToRemove `
                        -ErrorAction Stop | Out-Null
                }
                catch
                {
                    Write-Verbose -Message $_
                }
            }
        }
        catch
        {
            New-M365DSCLogEntry -Message "Couldn't set group $DisplayName" `
                -Exception $_ `
                -Source $MyInvocation.MyCommand.ModuleName
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentGroup.Ensure -eq 'Present')
    {
        try
        {
            Remove-MgGroup -GroupId $currentGroup.ID | Out-Null
        }
        catch
        {
            New-M365DSCLogEntry -Message "Couldn't delete group $DisplayName" `
                -Exception $_ `
                -Source $MyInvocation.MyCommand.ModuleName
        }
    }

    if ($Ensure -ne 'Absent')
    {
        #Owners
        Write-Verbose -Message "Updating Owners"
        if ($PSBoundParameters.ContainsKey('Owners'))
        {
            $currentOwnersValue = @()
            if ($currentParameters.Owners.Length -gt 0)
            {
                $currentOwnersValue = $backCurrentOwners
            }
            $desiredOwnersValue = @()
            if ($Owners.Length -gt 0)
            {
                $desiredOwnersValue = $Owners
            }
            if ($backCurrentOwners -eq $null)
            {
                $backCurrentOwners = @()
            }
            $ownersDiff = Compare-Object -ReferenceObject $backCurrentOwners -DifferenceObject $desiredOwnersValue
            foreach ($diff in $ownersDiff)
            {
                $directoryObject = Get-MgUser -UserId $diff.InputObject -ErrorAction SilentlyContinue
                if ($null -eq $directoryObject)
                {
                    Write-Verbose -Message "Trying to retrieve Service Principal {$($diff.InputObject)}"
                    $app = Get-MgApplication -Filter "DisplayName eq '$($diff.InputObject)'"
                    if ($null -ne $app)
                    {
                        $directoryObject = Get-MgServicePrincipal -Filter "AppId eq '$($app.AppId)'"
                    }
                }
                if ($diff.SideIndicator -eq '=>')
                {
                    Write-Verbose -Message "Adding new owner {$($diff.InputObject)} to AAD Group {$($currentGroup.DisplayName)}"
                    $ownerObject = @{
                        '@odata.id' = "https://graph.microsoft.com/v1.0/directoryObjects/{$($directoryObject.Id)}"
                    }
                    try
                    {
                        New-MgGroupOwnerByRef -GroupId ($currentGroup.Id) -BodyParameter $ownerObject -ErrorAction Stop | Out-Null
                    }
                    catch
                    {
                        if ($_.Exception.Message -notlike '*One or more added object references already exist for the following modified properties*')
                        {
                            throw $_
                        }
                    }
                }
                elseif ($diff.SideIndicator -eq '<=')
                {
                    Write-Verbose -Message "Removing new owner {$($diff.InputObject)} to AAD Group {$($currentGroup.DisplayName)}"
                    Remove-MgGroupOwnerDirectoryObjectByRef -GroupId ($currentGroup.Id) -DirectoryObjectId ($user.Id) | Out-Null
                }
            }

        }

        #Members
        Write-Verbose -Message "Updating Members"
        if ($MembershipRuleProcessingState -ne 'On' -and $PSBoundParameters.ContainsKey('Members'))
        {
            $currentMembersValue = @()
            if ($currentParameters.Members.Length -ne 0)
            {
                $currentMembersValue = $backCurrentMembers
            }
            $desiredMembersValue = @()
            if ($Members.Length -ne 0)
            {
                $desiredMembersValue = $Members
            }
            if ($backCurrentMembers -eq $null)
            {
                $backCurrentMembers = @()
            }
            Write-Verbose -Message "Comparing current members and desired list"
            $membersDiff = Compare-Object -ReferenceObject $backCurrentMembers -DifferenceObject $desiredMembersValue
            foreach ($diff in $membersDiff)
            {
                Write-Verbose -Message "Found difference for member {$($diff.InputObject)}"
                $directoryObject = Get-MgUser -UserId $diff.InputObject -ErrorAction SilentlyContinue

                if ($null -eq $directoryObject)
                {
                    Write-Verbose -Message "Trying to retrieve Service Principal {$($diff.InputObject)}"
                    $app = Get-MgApplication -Filter "DisplayName eq '$($diff.InputObject)'"
                    if ($null -ne $app)
                    {
                        $directoryObject = Get-MgServicePrincipal -Filter "AppId eq '$($app.AppId)'"
                    }
                }

                if ($diff.SideIndicator -eq '=>')
                {
                    Write-Verbose -Message "Adding new member {$($diff.InputObject)} to AAD Group {$($currentGroup.DisplayName)}"
                    $memberObject = @{
                        '@odata.id' = "https://graph.microsoft.com/v1.0/directoryObjects/{$($directoryObject.Id)}"
                    }
                    New-MgGroupMemberByRef -GroupId ($currentGroup.Id) -BodyParameter $memberObject | Out-Null
                }
                elseif ($diff.SideIndicator -eq '<=')
                {
                    Write-Verbose -Message "Removing new member {$($diff.InputObject)} to AAD Group {$($currentGroup.DisplayName)}"
                    $memberObject = @{
                        '@odata.id' = "https://graph.microsoft.com/v1.0/directoryObjects/{$($directoryObject.Id)}"
                    }
                    Remove-MgGroupMemberDirectoryObjectByRef -GroupId ($currentGroup.Id) -DirectoryObjectId ($directoryObject.Id) | Out-Null
                }
            }
        }
        elseif ($MembershipRuleProcessingState -eq 'On')
        {
            Write-Verbose -Message 'Ignoring membership since this is a dynamic group.'
        }

        #GroupAsMembers
        Write-Verbose -Message "Updating GroupAsMembers"
        if ($MembershipRuleProcessingState -ne 'On' -and $PSBoundParameters.ContainsKey('GroupAsMembers'))
        {
            $currentGroupAsMembersValue = @()
            if ($currentParameters.GroupAsMembers.Length -ne 0)
            {
                $currentGroupAsMembersValue = $backCurrentGroupAsMembers
            }
            $desiredGroupAsMembersValue = @()
            if ($GroupAsMembers.Length -ne 0)
            {
                $desiredGroupAsMembersValue = $GroupAsMembers
            }
            if ($backCurrentGroupAsMembers -eq $null)
            {
                $backCurrentGroupAsMembers = @()
            }
            $groupAsMembersDiff = Compare-Object -ReferenceObject $backCurrentGroupAsMembers -DifferenceObject $desiredGroupAsMembersValue
            foreach ($diff in $groupAsMembersDiff)
            {
                try
                {
                    $groupAsMember = Get-MgGroup -Filter "DisplayName eq '$($diff.InputObject)'" -ErrorAction SilentlyContinue
                }
                catch
                {
                    $groupAsMember = $null
                }
                if ($null -eq $groupAsMember)
                {
                    throw "Group '$($diff.InputObject)' does not exist"
                }
                else
                {
                    if ($diff.SideIndicator -eq '=>')
                    {
                        Write-Verbose -Message "Adding AAD group {$($groupAsMember.DisplayName)} as member of AAD group {$($currentGroup.DisplayName)}"
                        $groupAsMemberObject = @{
                            "@odata.id"= "https://graph.microsoft.com/v1.0/directoryObjects/$($groupAsMember.Id)"
                        }
                        New-MgBetaGroupMemberByRef -GroupId ($currentGroup.Id) -Body $groupAsMemberObject | Out-Null
                    }
                    if ($diff.SideIndicator -eq '<=')
                    {
                        Write-Verbose -Message "Removing AAD Group {$($groupAsMember.DisplayName)} from AAD group {$($currentGroup.DisplayName)}"
                        Remove-MgBetaGroupMemberDirectoryObjectByRef -GroupId ($currentGroup.Id) -DirectoryObjectId ($groupAsMember.Id) | Out-Null
                    }
                }
            }
        }

        #MemberOf
        Write-Verbose -Message "Updating MemberOf"
        if ($PSBoundParameters.ContainsKey('MemberOf'))
        {
            $currentMemberOfValue = @()
            if ($currentParameters.MemberOf.Length -ne 0)
            {
                $currentMemberOfValue = $backCurrentMemberOf
            }
            $desiredMemberOfValue = @()
            if ($MemberOf.Length -ne 0)
            {
                $desiredMemberOfValue = $MemberOf
            }
            if ($null -eq $backCurrentMemberOf)
            {
                $backCurrentMemberOf = @()
            }
            $memberOfDiff = Compare-Object -ReferenceObject $backCurrentMemberOf -DifferenceObject $desiredMemberOfValue
            foreach ($diff in $memberOfDiff)
            {
                try
                {
                    $memberOfGroup = Get-MgGroup -Filter "DisplayName eq '$($diff.InputObject)'" -ErrorAction Stop
                }
                catch
                {
                    $memberOfGroup = $null
                }
                if ($null -eq $memberOfGroup)
                {
                    throw "Security-group or directory role '$($diff.InputObject)' does not exist"
                }
                else
                {
                    if ($diff.SideIndicator -eq '=>')
                    {
                        # see if memberOfGroup contains property SecurityEnabled (it can be true or false)
                        if ($memberOfgroup.psobject.Typenames -match 'Group')
                        {
                            Write-Verbose -Message "Adding AAD group {$($currentGroup.DisplayName)} as member of AAD group {$($memberOfGroup.DisplayName)}"
                            #$memberOfObject = @{
                            #    "@odata.id"= "https://graph.microsoft.com/v1.0/groups/{$($group.Id)}"
                            #}
                            New-MgGroupMember -GroupId ($memberOfGroup.Id) -DirectoryObject ($currentGroup.Id) | Out-Null
                        }
                        else
                        {
                            Throw "Cannot add AAD group {$($currentGroup.DisplayName)} to {$($memberOfGroup.DisplayName)} as it is not a security-group"
                        }
                    }
                    elseif ($diff.SideIndicator -eq '<=')
                    {
                        if ($memberOfgroup.psobject.Typenames -match 'Group')
                        {
                            Write-Verbose -Message "Removing AAD Group {$($currentGroup.DisplayName)} from AAD group {$($memberOfGroup.DisplayName)}"
                            Remove-MgGroupMemberDirectoryObjectByRef -GroupId ($memberOfGroup.Id) -DirectoryObjectId ($currentGroup.Id) | Out-Null
                        }
                        else
                        {
                            Throw "Cannot remove AAD group {$($currentGroup.DisplayName)} from {$($memberOfGroup.DisplayName)} as it is not a security-group"
                        }
                    }
                }
            }
        }

        if ($currentGroup.IsAssignableToRole -eq $true -and $PSBoundParameters.ContainsKey('AssignedToRole'))
        {
            #AssignedToRole
            $currentAssignedToRoleValue = @()
            if ($currentParameters.AssignedToRole.Length -ne 0)
            {
                $currentAssignedToRoleValue = $backCurrentAssignedToRole
            }
            $desiredAssignedToRoleValue = @()
            if ($AssignedToRole.Length -ne 0)
            {
                $desiredAssignedToRoleValue = $AssignedToRole
            }
            if ($null -eq $backCurrentAssignedToRole)
            {
                $backCurrentAssignedToRole = @()
            }
            $assignedToRoleDiff = Compare-Object -ReferenceObject $backCurrentAssignedToRole -DifferenceObject $desiredAssignedToRoleValue
            foreach ($diff in $assignedToRoleDiff)
            {
                try
                {
                    $role = Get-MgBetaRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$($diff.InputObject)'"
                }
                catch
                {
                    $role = $null
                }
                if ($null -eq $role)
                {
                    throw "Directory Role '$($diff.InputObject)' does not exist"
                }
                else
                {
                    if ($diff.SideIndicator -eq '=>')
                    {
                        Write-Verbose -Message "Assigning AAD group {$($currentGroup.DisplayName)} to Directory Role {$($diff.InputObject)}"
                        New-MgBetaRoleManagementDirectoryRoleAssignment -RoleDefinitionId $role.Id -PrincipalId $currentGroup.Id -DirectoryScopeId '/'
                    }
                    elseif ($diff.SideIndicator -eq '<=')
                    {
                        Write-Verbose -Message "Removing AAD group {$($currentGroup.DisplayName)} from Directory Role {$($role.DisplayName)}"
                        Write-Verbose "GroupId = $($currentGroup.Id)"
                        Write-Verbose "RoleDefinitionId = $($role.Id)"
                        $roleAssignment = Get-MgBetaRoleManagementDirectoryRoleAssignment -Filter "PrincipalId eq '$($currentGroup.Id)' and RoleDefinitionId eq '$($role.Id)'"
                        Remove-MgBetaRoleManagementDirectoryRoleAssignment -UnifiedRoleAssignmentId $roleAssignment.Id
                    }
                }
            }
        }
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
        $DisplayName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $MailNickname,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String[]]
        $Members,

        [Parameter()]
        [System.String[]]
        $GroupAsMembers,

        [Parameter()]
        [System.String[]]
        $MemberOf,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter(Mandatory = $true)]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.Boolean]
        $IsAssignableToRole,

        [Parameter()]
        [System.String[]]
        $AssignedToRole,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AssignedLicenses,

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

    Write-Verbose -Message 'Testing configuration of AzureAD Groups'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    # Check Licenses
    if (-not ($null -eq $AssignedLicenses -and $null -eq $CurrentValues.AssignedLicenses))
    {
        try
        {
            if ($null -ne $CurrentValues.AssignedLicenses -and $CurrentValues.AssignedLicenses.Length -gt 0 -and `
                ($PSBoundParameters.ContainsKey('AssignedLicenses') -and $null -eq $AssignedLicenses))
            {
                Write-Verbose -Message "The group {$DisplayName} currently has licenses assigned but it shouldn't"
                Write-Verbose -Message "Test-TargetResource returned $false"
                $EventMessage = "Assigned Licenses for Azure AD Group {$DisplayName} were not in the desired state.`r`nThe group should not have any licenses assigned but instead contained {$($CurrentValues.AssignedLicenses.SkuId -join ',')}"
                Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                    -EventID 1 -Source $($MyInvocation.MyCommand.Source)

                return $false
            }
            elseif ($null -eq $CurrentValues.AssignedLicenses -and $null -ne $AssignedLicenses -and `
                    $AssignedLicenses.Length -gt 0)
            {
                Write-Verbose -Message "The group {$DisplayName} currently doesn't have licenses assigned but it should"
                Write-Verbose -Message "Test-TargetResource returned $false"
                $EventMessage = "Assigned Licenses for Azure AD Group {$DisplayName} were not in the desired state.`r`nThe group doesn't not have any licenses assigned but should have {$($CurrentValues.AssignedLicenses.SkuId -join ',')}"
                Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                    -EventID 1 -Source $($MyInvocation.MyCommand.Source)

                return $false
            }
            elseif ($CurrentValues.AssignedLicenses.Length -gt 0 -and $AssignedLicenses.Length -gt 0)
            {
                Write-Verbose -Message "Current assigned licenses and desired assigned licenses for group {$DisplayName} are not null and will be compared"
                $licensesDiff = Compare-Object -ReferenceObject ($CurrentValues.AssignedLicenses.SkuId) -DifferenceObject ($AssignedLicenses.SkuId)
                if ($null -ne $licensesDiff)
                {
                    Write-Verbose -Message "AssignedLicenses differ for group {$DisplayName}: $($licensesDiff | Out-String)"
                    Write-Verbose -Message "Test-TargetResource returned $false"
                    $EventMessage = "Assigned Licenses for Azure AD Group {$DisplayName} were not in the desired state.`r`nThey should contain {$($AssignedLicenses.SkuId -join ',')} but instead contained {$($CurrentValues.AssignedLicenses.SkuId -join ',')}"
                    Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                        -EventID 1 -Source $($MyInvocation.MyCommand.Source)

                    return $false
                }
                else
                {
                    Write-Verbose -Message "AssignedLicenses for Azure AD Group {$DisplayName} are the same, checking DisabledPlans"
                }

                # Disabled Plans
                #Compare DisabledPlans for each SkuId - all SkuId's are processed regardless of result
                $result = $true
                foreach ($assignedLicense in $AssignedLicenses)
                {
                    Write-Verbose "Compare DisabledPlans for SkuId $($assignedLicense.SkuId) in group {$DisplayName}"
                    $currentLicense = $CurrentValues.AssignedLicenses | Where-Object -FilterScript {$_.SkuId -eq $assignedLicense.SkuId}
                    if ($assignedLicense.DisabledPlans.Count -ne 0 -or $currentLicense.DisabledPlans.Count -ne 0)
                    {
                        try {
                            $licensesDiff = Compare-Object -ReferenceObject $assignedLicense.DisabledPlans -DifferenceObject $currentLicense.DisabledPlans
                            if ($null -ne $licensesDiff)
                            {
                                Write-Verbose -Message "DisabledPlans for SkuId $($assignedLicense.SkuId) differ: $($licensesDiff | Out-String)"
                                Write-Verbose -Message "Test-TargetResource returned $false"
                                $EventMessage = "Disabled Plans for Azure AD Group Licenses {$DisplayName} SkuId $($assignedLicense.SkuId) were not in the desired state.`r`n" + `
                                    "They should contain {$($assignedLicense.DisabledPlans -join ',')} but instead contained {$($currentLicense.DisabledPlans -join ',')}"
                                Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                                    -EventID 1 -Source $($MyInvocation.MyCommand.Source)

                                $result = $false
                            }
                            else
                            {
                                Write-Verbose -Message "DisabledPlans for SkuId $($assignedLicense.SkuId) are the same"
                            }
                        }
                        catch
                        {
                            Write-Verbose -Message "Test-TargetResource returned `$false (DisabledPlans: $($_.Exception.Message))"
                            $result = $false
                        }
                    }
                }
                if ($true -ne $result)
                {
                    return $result
                }
            }
            elseif ($PSBoundParameters.ContainsKey('AssignedLicenses'))
            {
                Write-Verbose -Message "The group {$DisplayName} currently has licenses assigned but it shouldn't have"
                Write-Verbose -Message "Test-TargetResource returned $false"
                $EventMessage = "Assigned Licenses for Azure AD Group {$DisplayName} were not in the desired state.`r`nThe group has licenses assigned but shouldn't have {$($CurrentValues.AssignedLicenses.SkuId)}"
                Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                    -EventID 1 -Source $($MyInvocation.MyCommand.Source)

                return $false
            }
            else
            {
                Write-Verbose -Message "Both the current and desired assigned licenses lists for group {$DisplayName} are empty or not specified."
            }
        }
        catch
        {
            Write-Verbose -Message "Error evaluating the AssignedLicenses for group {$DisplayName}: $_"
            Write-Verbose -Message "Test-TargetResource returned $false"
            return $false
        }
    }

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck.Remove('GroupTypes') | Out-Null
    $ValuesToCheck.Remove('AssignedLicenses') | Out-Null

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
        $Script:ExportMode = $true
        $ExportParameters = @{
            Filter      = $Filter
            All         = [switch]$true
            ErrorAction = 'Stop'
        }

        # Define the list of attributes
        $attributesToCheck = @(
            'description',
            'displayName',
            'hasMembersWithLicenseErrors',
            'mail',
            'mailNickname',
            'onPremisesSecurityIdentifier',
            'onPremisesSyncEnabled',
            'preferredLanguage'
        )

        # Initialize a flag to indicate whether any attribute matches the condition
        $matchConditionFound = $false

        # Check each attribute in the list
        foreach ($attribute in $attributesToCheck)
        {
            if ($Filter -like "*$attribute eq null*")
            {
                $matchConditionFound = $true
                break
            }
        }

        # If any attribute matches, add parameters to $ExportParameters
        if ($matchConditionFound -or $Filter -like '*endsWith*')
        {
            $ExportParameters.Add('CountVariable', 'count')
            $ExportParameters.Add('ConsistencyLevel', 'eventual')
        }

        [array] $Script:exportedGroups = Get-MgGroup @ExportParameters
        $Script:exportedGroups = $Script:exportedGroups | Where-Object -FilterScript {
            -not ($_.MailEnabled -and ($null -eq $_.GroupTypes -or $_.GroupTypes.Length -eq 0)) -and `
                -not ($_.MailEnabled -and $_.SecurityEnabled)
        }

        $i = 1
        $dscContent = ''
        Write-Host "`r`n" -NoNewline
        foreach ($group in $Script:exportedGroups)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedGroups.Count)] $($group.DisplayName)" -NoNewline
            $Params = @{
                ApplicationSecret     = $ApplicationSecret
                DisplayName           = $group.DisplayName
                MailNickName          = $group.MailNickName
                SecurityEnabled       = $true
                MailEnabled           = $true
                Id                    = $group.Id
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Credential            = $Credential
                Managedidentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }
            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($results.AssignedLicenses.Length -gt 0)
            {
                $Results.AssignedLicenses = Get-M365DSCAzureADGroupLicensesAsString $Results.AssignedLicenses
            }
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($null -ne $Results.AssignedLicenses)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                    -ParameterName 'AssignedLicenses'
            }
            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName

            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $i++
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

function Get-M365DSCAzureADGroupLicenses
{
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory = $true)]
        $AssignedLicenses
    )

    $returnValue = @()
    $allSkus = Get-MgBetaSubscribedSku

    # Create complete list of all Service Plans
    $allServicePlans = @()
    Write-Verbose -Message 'Getting all Service Plans'
    foreach ($sku in $allSkus)
    {
        foreach ($serviceplan in $sku.ServicePlans)
        {
            if ($allServicePlans.Length -eq 0 -or -not $allServicePlans.ServicePlanName.Contains($servicePlan.ServicePlanName))
            {
                $allServicePlans += @{
                    ServicePlanId   = $serviceplan.ServicePlanId
                    ServicePlanName = $serviceplan.ServicePlanName
                }
            }
        }
    }

    foreach ($assignedLicense in $AssignedLicenses)
    {
        $skuPartNumber = $allSkus | Where-Object -FilterScript { $_.SkuId -eq $assignedLicense.SkuId }
        $disabledPlansValues = @()
        foreach ($plan in $assignedLicense.DisabledPlans)
        {
            $foundItem = $allServicePlans | Where-Object -FilterScript { $_.ServicePlanId -eq $plan }
            $disabledPlansValues += $foundItem.ServicePlanName
        }
        $currentLicense = @{
            DisabledPlans = $disabledPlansValues
            SkuId         = $skuPartNumber.SkuPartNumber
        }
        $returnValue += $currentLicense
    }

    return $returnValue
}

function Get-M365DSCAzureADGroupLicensesAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $AssignedLicenses
    )

    $StringContent = [System.Text.StringBuilder]::new()
    $StringContent.Append('@(') | Out-Null
    foreach ($assignedLicense in $AssignedLicenses)
    {
        $StringContent.Append("MSFT_AADGroupLicense { `r`n") | Out-Null
        if ($assignedLicense.DisabledPlans.Length -gt 0)
        {
            $StringContent.Append("                DisabledPlans = @('" + ($assignedLicense.DisabledPlans -join "','") + "')`r`n") | Out-Null
        }
        else
        {
            $StringContent.Append("                DisabledPlans = @()`r`n") | Out-Null
        }
        $StringContent.Append("                SkuId         = '" + $assignedLicense.SkuId + "'`r`n") | Out-Null
        $StringContent.Append("            }`r`n") | Out-Null
    }
    $StringContent.Append('            )') | Out-Null
    return $StringContent.ToString()
}

function Get-M365DSCCombinedLicenses
{
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param(
        [Parameter()]
        [System.Object[]]
        $CurrentLicenses,

        [Parameter()]
        [System.Object[]]
        $DesiredLicenses
    )
    $result = @()
    if ($currentLicenses.Length -gt 0)
    {
        foreach ($license in $CurrentLicenses)
        {
            Write-Verbose -Message "Including Current $license"
            $result += @{
                SkuId         = $license.SkuId
                DisabledPlans = $license.DisabledPlans
            }
        }
    }

    if ($DesiredLicenses.Length -gt 0)
    {
        foreach ($license in $DesiredLicenses)
        {
            if ($result.Length -eq 0)
            {
                $result += @{
                    SkuId         = $license.SkuId
                    DisabledPlans = $license.DisabledPlans
                }
            }
            else
            {
                if (-not $result.SkuId.Contains($license.SkuId))
                {
                    $result += @{
                        SkuId         = $license.SkuId
                        DisabledPlans = $license.DisabledPlans
                    }
                }
                else
                {
                    #Set the Desired Disabled Plans if the sku is already added to the list
                    foreach ($item in $result)
                    {
                        if ($item.SkuId -eq $license.SkuId)
                        {
                            $item.DisabledPlans = $license.DisabledPlans
                        }
                    }
                }
            }
        }
    }

    return $result
}
Export-ModuleMember -Function *-TargetResource
