function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $AppId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoleAssignedTo,

        [Parameter()]
        [System.String]
        $ObjectId,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $AlternativeNames,

        [Parameter()]
        [System.Boolean]
        $AccountEnabled,

        [Parameter()]
        [System.Boolean]
        $AppRoleAssignmentRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DelegatedPermissionClassifications,

        [Parameter()]
        [System.String]
        $ErrorUrl,

        [Parameter()]
        [System.String]
        $Homepage,

        [Parameter()]
        [System.String]
        $LogoutUrl,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String]
        $PublisherName,

        [Parameter()]
        [System.String[]]
        $ReplyUrls,

        [Parameter()]
        [System.String]
        $SamlMetadataURL,

        [Parameter()]
        [System.String[]]
        $ServicePrincipalNames,

        [Parameter()]
        [System.String]
        $ServicePrincipalType,

        [Parameter()]
        [System.String[]]
        $Tags,

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

    Write-Verbose -Message 'Getting configuration of Azure AD ServicePrincipal'
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
    try
    {
        try
        {
            if (-not [System.String]::IsNullOrEmpty($ObjectID))
            {
                if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
                {
                    $AADServicePrincipal = $Script:exportedInstances | Where-Object -FilterScript {$_.Id -eq $Id}
                }
                else
                {
                    $AADServicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $ObjectId `
                        -Expand 'AppRoleAssignedTo' `
                        -ErrorAction Stop
                }
            }
        }
        catch
        {
            Write-Verbose -Message "Azure AD ServicePrincipal with ObjectID: $($ObjectID) could not be retrieved"
        }

        if ($null -eq $AADServicePrincipal)
        {
            if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
            {
                $AADServicePrincipal = $Script:exportedInstances | Where-Object -FilterScript {$_.AppId -eq $AppId}
            }
            else
            {
                $ObjectGuid = [System.Guid]::empty
                if (-not [System.Guid]::TryParse($AppId, [System.Management.Automation.PSReference]$ObjectGuid))
                {
                    $appInstance = Get-MgApplication -Filter "DisplayName eq '$AppId'"
                    if ($appInstance)
                    {
                        $AADServicePrincipal = Get-MgServicePrincipal -Filter "AppID eq '$($appInstance.AppId)'" `
                                                                    -Expand 'AppRoleAssignedTo'
                    }
                }
                else
                {
                    $AADServicePrincipal = Get-MgServicePrincipal -Filter "AppID eq '$($AppId)'" `
                                                                -Expand 'AppRoleAssignedTo'
                }
            }
        }
        if ($null -eq $AADServicePrincipal)
        {
            return $nullReturn
        }
        else
        {
            $AppRoleAssignedToValues = @()
            foreach ($principal in $AADServicePrincipal.AppRoleAssignedTo)
            {
                $currentAssignment = @{
                    PrincipalType = $null
                    Identity      = $null
                }
                if ($principal.PrincipalType -eq 'User')
                {
                    $user = Get-MgUser -UserId $principal.PrincipalId
                    $currentAssignment.PrincipalType = 'User'
                    $currentAssignment.Identity = $user.UserPrincipalName.Split('@')[0]
                    $AppRoleAssignedToValues += $currentAssignment
                }
                elseif ($principal.PrincipalType -eq 'Group')
                {
                    $group = Get-MgGroup -GroupId $principal.PrincipalId
                    $currentAssignment.PrincipalType = 'Group'
                    $currentAssignment.Identity = $group.DisplayName
                    $AppRoleAssignedToValues += $currentAssignment
                }
            }

            $ownersValues = @()
            $ownersInfo = Get-MgServicePrincipalOwner -ServicePrincipalId $AADServicePrincipal.Id -ErrorAction SilentlyContinue
            foreach ($ownerInfo in $ownersInfo)
            {
                $info = Get-MgUser -UserId $ownerInfo.Id -ErrorAction SilentlyContinue
                if ($null -ne $info)
                {
                    $ownersValues += $info.UserPrincipalName
                }
            }

            [Array]$complexDelegatedPermissionClassifications = @()
            $permissionClassifications = Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$AppId')/delegatedPermissionClassifications" -Method Get
            foreach ($permissionClassification in $permissionClassifications.Value){
                $hashtable = @{
                    classification = $permissionClassification.Classification
                    permissionName = $permissionClassification.permissionName
                }
                $complexDelegatedPermissionClassifications += $hashtable
            }

            $result = @{
                AppId                              = $AADServicePrincipal.AppId
                AppRoleAssignedTo                  = $AppRoleAssignedToValues
                ObjectID                           = $AADServicePrincipal.Id
                DisplayName                        = $AADServicePrincipal.DisplayName
                AlternativeNames                   = $AADServicePrincipal.AlternativeNames
                AccountEnabled                     = [boolean]$AADServicePrincipal.AccountEnabled
                AppRoleAssignmentRequired          = $AADServicePrincipal.AppRoleAssignmentRequired
                DelegatedPermissionClassifications = [Array]$complexDelegatedPermissionClassifications
                ErrorUrl                           = $AADServicePrincipal.ErrorUrl
                Homepage                           = $AADServicePrincipal.Homepage
                LogoutUrl                          = $AADServicePrincipal.LogoutUrl
                Owners                             = $ownersValues
                PublisherName                      = $AADServicePrincipal.PublisherName
                ReplyURLs                          = $AADServicePrincipal.ReplyURLs
                SamlMetadataURL                    = $AADServicePrincipal.SamlMetadataURL
                ServicePrincipalNames              = $AADServicePrincipal.ServicePrincipalNames
                ServicePrincipalType               = $AADServicePrincipal.ServicePrincipalType
                Tags                               = $AADServicePrincipal.Tags
                Ensure                             = 'Present'
                Credential                         = $Credential
                ApplicationId                      = $ApplicationId
                ApplicationSecret                  = $ApplicationSecret
                TenantId                           = $TenantId
                CertificateThumbprint              = $CertificateThumbprint
                Managedidentity                    = $ManagedIdentity.IsPresent
                AccessTokens                       = $AccessTokens
            }
            Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
            return $result
        }
    }
    catch
    {
        Write-Verbose -Message $_
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
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $AppId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoleAssignedTo,

        [Parameter()]
        [System.String]
        $ObjectId,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $AlternativeNames,

        [Parameter()]
        [System.Boolean]
        $AccountEnabled,

        [Parameter()]
        [System.Boolean]
        $AppRoleAssignmentRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DelegatedPermissionClassifications,

        [Parameter()]
        [System.String]
        $ErrorUrl,

        [Parameter()]
        [System.String]
        $Homepage,

        [Parameter()]
        [System.String]
        $LogoutUrl,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String]
        $PublisherName,

        [Parameter()]
        [System.String[]]
        $ReplyUrls,

        [Parameter()]
        [System.String]
        $SamlMetadataURL,

        [Parameter()]
        [System.String[]]
        $ServicePrincipalNames,

        [Parameter()]
        [System.String]
        $ServicePrincipalType,

        [Parameter()]
        [System.String[]]
        $Tags,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    Write-Verbose -Message 'Setting configuration of Azure AD ServicePrincipal'
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

    $currentAADServicePrincipal = Get-TargetResource @PSBoundParameters
    $currentParameters = $PSBoundParameters
    $currentParameters.Remove('ApplicationId') | Out-Null
    $currentParameters.Remove('TenantId') | Out-Null
    $currentParameters.Remove('CertificateThumbprint') | Out-Null
    $currentParameters.Remove('ManagedIdentity') | Out-Null
    $currentParameters.Remove('Credential') | Out-Null
    $currentParameters.Remove('Ensure') | Out-Null
    $currentParameters.Remove('ObjectID') | Out-Null
    $currentParameters.Remove('ApplicationSecret') | Out-Null
    $currentParameters.Remove('AccessTokens') | Out-Null

    # ServicePrincipal should exist but it doesn't
    if ($Ensure -eq 'Present' -and $currentAADServicePrincipal.Ensure -eq 'Absent')
    {
        if ($null -ne $AppRoleAssignedTo)
        {
            $currentParameters.AppRoleAssignedTo = $AppRoleAssignedToValue
        }
        # removing Delegated permission classifications from this new call, as adding below separately
        $currentParameters.Remove('DelegatedPermissionClassifications') | Out-Null
        $ObjectGuid = [System.Guid]::empty
        if (-not [System.Guid]::TryParse($AppId, [System.Management.Automation.PSReference]$ObjectGuid))
        {
            $appInstance = Get-MgApplication -Filter "DisplayName eq '$AppId'"
            $currentParameters.AppId = $appInstance.AppId
        }

        Write-Verbose -Message 'Creating new Service Principal'
        Write-Verbose -Message "With Values: $(Convert-M365DscHashtableToString -Hashtable $currentParameters)"
        $newSP = New-MgServicePrincipal @currentParameters

        # Assign Owners
        foreach ($owner in $Owners)
        {
            $userInfo = Get-MgUser -UserId $owner
            $body = @{
                '@odata.id' = "https://graph.microsoft.com/v1.0/directoryObjects/$($userInfo.Id)"
            }
            Write-Verbose -Message "Adding new owner {$owner}"
            $newOwner = New-MgServicePrincipalOwnerByRef -ServicePrincipalId $newSP.Id -BodyParameter $body
        }

        #adding delegated permissions classifications
        if($null -ne $DelegatedPermissionClassifications){
            foreach ($permissionClassification in $DelegatedPermissionClassifications){
                $params = @{
                    classification = $permissionClassification.Classification
                    permissionName = $permissionClassification.permissionName
                }
                Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$($currentParameters.AppId)')/delegatedPermissionClassifications" -Method Post -Body $params
            }
        }
    }
    # ServicePrincipal should exist and will be configured to desired state
    elseif ($Ensure -eq 'Present' -and $currentAADServicePrincipal.Ensure -eq 'Present')
    {
        Write-Verbose -Message 'Updating existing Service Principal'
        $ObjectGuid = [System.Guid]::empty
        if (-not [System.Guid]::TryParse($AppId, [System.Management.Automation.PSReference]$ObjectGuid))
        {
            $appInstance = Get-MgApplication -Filter "DisplayName eq '$AppId'"
            $currentParameters.AppId = $appInstance.AppId
        }
        Write-Verbose -Message "CurrentParameters: $($currentParameters | Out-String)"
        Write-Verbose -Message "ServicePrincipalID: $($currentAADServicePrincipal.ObjectID)"
        $currentParameters.Remove('AppRoleAssignedTo') | Out-Null
        $currentParameters.Remove('Owners') | Out-Null
        $currentParameters.Remove('DelegatedPermissionClassifications') | Out-Null
        Update-MgServicePrincipal -ServicePrincipalId $currentAADServicePrincipal.ObjectID @currentParameters

        if ($AppRoleAssignedTo)
        {
            [Array]$currentPrincipals = $currentAADServicePrincipal.AppRoleAssignedTo.Identity
            [Array]$desiredPrincipals = $AppRoleAssignedTo.Identity

            [Array]$differences = Compare-Object -ReferenceObject $currentPrincipals -DifferenceObject $desiredPrincipals
            [Array]$membersToAdd = $differences | Where-Object -FilterScript {$_.SideIndicator -eq '=>'}
            [Array]$membersToRemove = $differences | Where-Object -FilterScript {$_.SideIndicator -eq '<='}

            if ($differences.Count -gt 0)
            {
                if ($membersToAdd.Count -gt 0)
                {
                    $AppRoleAssignedToValues = @()
                    foreach ($assignment in $AppRoleAssignedTo)
                    {
                        $AppRoleAssignedToValues += @{
                            PrincipalType = $assignment.PrincipalType
                            Identity      = $assignment.Identity
                        }
                    }
                    foreach ($member in $membersToAdd)
                    {
                        $assignment = $AppRoleAssignedToValues | Where-Object -FilterScript {$_.Identity -eq $member.InputObject}
                        if ($assignment.PrincipalType -eq 'User')
                        {
                            Write-Verbose -Message "Retrieving user {$($assignment.Identity)}"
                            $user = Get-MgUser -Filter "startswith(UserPrincipalName, '$($assignment.Identity)')"
                            $PrincipalIdValue = $user.Id
                        }
                        else
                        {
                            Write-Verbose -Message "Retrieving group {$($assignment.Identity)}"
                            $group = Get-MgGroup -Filter "DisplayName eq '$($assignment.Identity)'"
                            $PrincipalIdValue = $group.Id
                        }

                        $bodyParam = @{
                            principalId = $PrincipalIdValue
                            resourceId  = $currentAADServicePrincipal.ObjectID
                            appRoleId   = "00000000-0000-0000-0000-000000000000"
                        }
                        Write-Verbose -Message "Adding member {$($member.InputObject.ToString())}"
                        New-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $currentAADServicePrincipal.ObjectID `
                            -BodyParameter $bodyParam | Out-Null
                    }
                }

                if ($membersToRemove.Count -gt 0)
                {
                    $AppRoleAssignedToValues = @()
                    foreach ($assignment in $currentAADServicePrincipal.AppRoleAssignedTo)
                    {
                        $AppRoleAssignedToValues += @{
                            PrincipalType = $assignment.PrincipalType
                            Identity      = $assignment.Identity
                        }
                    }
                    foreach ($member in $membersToRemove)
                    {
                        $assignment = $AppRoleAssignedToValues | Where-Object -FilterScript {$_.Identity -eq $member.InputObject}
                        if ($assignment.PrincipalType -eq 'User')
                        {
                            Write-Verbose -Message "Retrieving user {$($assignment.Identity)}"
                            $user = Get-MgUser -Filter "startswith(UserPrincipalName, '$($assignment.Identity)')"
                            $PrincipalIdValue = $user.Id
                        }
                        else
                        {
                            Write-Verbose -Message "Retrieving group {$($assignment.Identity)}"
                            $group = Get-MgGroup -Filter "DisplayName eq '$($assignment.Identity)'"
                            $PrincipalIdValue = $group.Id
                        }
                        Write-Verbose -Message "PrincipalID Value = '$PrincipalIdValue'"
                        Write-Verbose -Message "ServicePrincipalId = '$($currentAADServicePrincipal.ObjectID)'"
                        $allAssignments = Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $currentAADServicePrincipal.ObjectID
                        $assignmentToRemove = $allAssignments | Where-Object -FilterScript {$_.PrincipalId -eq $PrincipalIdValue}
                        Write-Verbose -Message "Removing member {$($member.InputObject.ToString())}"
                        Remove-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $currentAADServicePrincipal.ObjectID `
                            -AppRoleAssignmentId $assignmentToRemove.Id | Out-Null
                    }
                }
            }
        }

        Write-Verbose -Message "Checking if owners need to be updated..."

        if ($null -ne $Owners)
        {
            $diffOwners = Compare-Object -ReferenceObject $currentAADServicePrincipal.Owners -DifferenceObject $Owners
        }
        foreach ($diff in $diffOwners)
        {
            $userInfo = Get-MgUser -UserId $diff.InputObject
            if ($diff.SideIndicator -eq '=>')
            {
                $body = @{
                    '@odata.id' = "https://graph.microsoft.com/v1.0/directoryObjects/$($userInfo.Id)"
                }
                Write-Verbose -Message "Adding owner {$($userInfo.Id)}"
                New-MgServicePrincipalOwnerByRef -ServicePrincipalId $currentAADServicePrincipal.ObjectId `
                                                 -BodyParameter $body | Out-Null
            }
            else
            {
                Write-Verbose -Message "Removing owner {$($userInfo.Id)}"
                Remove-MgServicePrincipalOwnerByRef -ServicePrincipalId $currentAADServicePrincipal.ObjectId `
                                                    -DirectoryObjectId $userInfo.Id | Out-Null
            }
        }

        Write-Verbose -Message "Checking if DelegatedPermissionClassifications need to be updated..."

        if ($null -ne $DelegatedPermissionClassifications)
        {
            # removing old perm classifications
            $permissionClassificationList = Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$($currentParameters.AppId)')/delegatedPermissionClassifications" -Method Get
            foreach($permissionClassification in $permissionClassificationList.Value){
                Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$($currentParameters.AppId)')/delegatedPermissionClassifications/$($permissionClassification.Id)" -Method Delete
            }

            # adding new perm classifications
            foreach ($permissionClassification in $DelegatedPermissionClassifications){
                $params = @{
                    classification = $permissionClassification.Classification
                    permissionName = $permissionClassification.permissionName
                }
                Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$($currentParameters.AppId)')/delegatedPermissionClassifications" -Method Post -Body $params
            }
        }
    }
    # ServicePrincipal exists but should not
    elseif ($Ensure -eq 'Absent' -and $currentAADServicePrincipal.Ensure -eq 'Present')
    {
        Write-Verbose -Message 'Removing Service Principal'
        Remove-MgServicePrincipal -ServicePrincipalId $currentAADServicePrincipal.ObjectID
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
        $AppId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoleAssignedTo,

        [Parameter()]
        [System.String]
        $ObjectId,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $AlternativeNames,

        [Parameter()]
        [System.Boolean]
        $AccountEnabled,

        [Parameter()]
        [System.Boolean]
        $AppRoleAssignmentRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $DelegatedPermissionClassifications,

        [Parameter()]
        [System.String]
        $ErrorUrl,

        [Parameter()]
        [System.String]
        $Homepage,

        [Parameter()]
        [System.String]
        $LogoutUrl,

        [Parameter()]
        [System.String[]]
        $Owners,

        [Parameter()]
        [System.String]
        $PublisherName,

        [Parameter()]
        [System.String[]]
        $ReplyUrls,

        [Parameter()]
        [System.String]
        $SamlMetadataURL,

        [Parameter()]
        [System.String[]]
        $ServicePrincipalNames,

        [Parameter()]
        [System.String]
        $ServicePrincipalType,

        [Parameter()]
        [System.String[]]
        $Tags,

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

    Write-Verbose -Message 'Testing configuration of Azure AD ServicePrincipal'

    $testTargetResource = $true
    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($null -ne $source -and $source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                $testTargetResource = $false
            }
            else {
                $ValuesToCheck.Remove($key) | Out-Null
            }
        }
    }

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
    -Source $($MyInvocation.MyCommand.Source) `
    -DesiredValues $PSBoundParameters `
    -ValuesToCheck $ValuesToCheck.Keys `
    -IncludedDrifts $driftedParams

    if(-not $TestResult)
    {
        $testTargetResource = $false
    }

    Write-Verbose -Message "Test-TargetResource returned $testTargetResource"

    return $testTargetResource
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

    $dscContent = ''
    try
    {
        $i = 1
        Write-Host "`r`n" -NoNewline
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-MgServicePrincipal -All:$true `
                                                                   -Filter $Filter `
                                                                   -Expand 'AppRoleAssignedTo' `
                                                                   -ErrorAction Stop
        foreach ($AADServicePrincipal in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($AADServicePrincipal.DisplayName)" -NoNewline
            $Params = @{
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                ApplicationSecret     = $ApplicationSecret
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                AppID                 = $AADServicePrincipal.AppId
                AccessTokens          = $AccessTokens
            }
            $Results = Get-TargetResource @Params

            if ($Results.Ensure -eq 'Present')
            {
                $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                    -Results $Results
                if ($Results.AppRoleAssignedTo.Count -gt 0)
                {
                    $Results.AppRoleAssignedTo = Get-M365DSCAzureADServicePrincipalAssignmentAsString -Assignments $Results.AppRoleAssignedTo
                }
                if ($Results.DelegatedPermissionClassifications.Count -gt 0)
                {
                    $Results.DelegatedPermissionClassifications = Get-M365DSCAzureADServicePrincipalDelegatedPermissionClassifications -PermissionClassifications $Results.DelegatedPermissionClassifications
                }
                $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                    -ConnectionMode $ConnectionMode `
                    -ModulePath $PSScriptRoot `
                    -Results $Results `
                    -Credential $Credential
                if ($null -ne $Results.AppRoleAssignedTo)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                        -ParameterName 'AppRoleAssignedTo'
                }
                if ($null -ne $Results.DelegatedPermissionClassifications)
                {
                    $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock `
                        -ParameterName 'DelegatedPermissionClassifications'
                }
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

function Get-M365DSCAzureADServicePrincipalAssignmentAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $Assignments
    )

    $StringContent = '@('
    foreach ($assignment in $Assignments)
    {
        $StringContent += "MSFT_AADServicePrincipalRoleAssignment {`r`n"
        $StringContent += "                PrincipalType = '" + $assignment.PrincipalType + "'`r`n"
        $StringContent += "                Identity      = '" + $assignment.Identity + "'`r`n"
        $StringContent += "            }`r`n"
    }
    $StringContent += '            )'
    return $StringContent
}

function Get-M365DSCAzureADServicePrincipalDelegatedPermissionClassifications
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.ArrayList]
        $PermissionClassifications
    )

    $StringContent = "@(`r`n"
    foreach ($permissionClassification in $PermissionClassifications)
    {
        $StringContent += "                MSFT_AADServicePrincipalDelegatedPermissionClassification {`r`n"
        $StringContent += "                     Classification = '" + $PermissionClassification.Classification + "'`r`n"
        $StringContent += "                     PermissionName = '" + $PermissionClassification.PermissionName + "'`r`n"
        $StringContent += "                }`r`n"
    }
    $StringContent += '            )'
    return $StringContent
}

Export-ModuleMember -Function *-TargetResource
