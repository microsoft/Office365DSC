function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $CatalogId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsHidden,

        [Parameter()]
        [System.Boolean]
        $IsRoleScopesVisible,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AccessPackageResourceRoleScopes,

        [Parameter()]
        [System.String[]]
        $IncompatibleAccessPackages,

        [Parameter()]
        [System.String[]]
        $AccessPackagesIncompatibleWith,

        [Parameter()]
        [System.String[]]
        $IncompatibleGroups,
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
        $ManagedIdentity
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'beta'
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
    try
    {
        $getValue = $null

        #region resource generator code
        $getValue = Get-MgEntitlementManagementAccessPackage -AccessPackageId $id `
            -ExpandProperty "accessPackageResourceRoleScopes(`$expand=accessPackageResourceRole,accessPackageResourceScope)" `
            -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Nothing with id {$id} was found"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgEntitlementManagementAccessPackage `
                    -Filter "displayName eq '$DisplayName'" `
                    -ExpandProperty "accessPackageResourceRoleScopes(`$expand=accessPackageResourceRole,accessPackageResourceScope)" `
                    -ErrorAction SilentlyContinue
            }
        }
        #endregion

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Nothing with DisplayName {$DisplayName} was found"
            return $nullResult
        }

        Write-Verbose -Message "Found access package with id {$($getValue.id)} and displayName {$($getValue.displayName)}"

        $getAccessPackageResourceRoleScopes = @()
        foreach ($accessPackageResourceRoleScope in $getValue.AccessPackageResourceRoleScopes)
        {
            $getAccessPackageResourceRoleScopes += @{
                Id                                   = $accessPackageResourceRoleScope.Id
                AccessPackageResourceOriginId        = $accessPackageResourceRoleScope.AccessPackageResourceScope.OriginId
                AccessPackageResourceRoleDisplayName = $accessPackageResourceRoleScope.AccessPackageResourceRole.DisplayName
            }
        }

        $getIncompatibleAccessPackages = @()
        [Array]$query = Get-MgEntitlementManagementAccessPackageIncompatibleAccessPackage -AccessPackageId $getValue.id
        if ($query.count -gt 0)
        {
            $getIncompatibleAccessPackages += $query.id
        }


        $getAccessPackagesIncompatibleWith = @()
        [Array]$query = Get-MgEntitlementManagementAccessPackageIncompatibleWith -AccessPackageId $getValue.id
        if ($query.count -gt 0)
        {
            $getIncompatibleAccessPackages += $query.id
        }

        $getIncompatibleGroups = @()
        [Array]$query = Get-MgEntitlementManagementAccessPackageIncompatibleGroup -AccessPackageId $getValue.id
        if ($query.count -gt 0)
        {
            $getIncompatibleGroups += $query.id
        }

        $results = @{
            Id                              = $getValue.Id
            CatalogId                       = $getValue.CatalogId
            Description                     = $getValue.Description
            DisplayName                     = $getValue.DisplayName
            IsHidden                        = $getValue.IsHidden
            IsRoleScopesVisible             = $getValue.IsRoleScopesVisible
            AccessPackageResourceRoleScopes = $getAccessPackageResourceRoleScopes
            IncompatibleAccessPackages      = $getIncompatibleAccessPackages
            AccessPackagesIncompatibleWith  = $getAccessPackagesIncompatibleWith #read-only
            IncompatibleGroups              = $getIncompatibleGroups
            Ensure                          = 'Present'
            Credential                      = $Credential
            ApplicationId                   = $ApplicationId
            TenantId                        = $TenantId
            ApplicationSecret               = $ApplicationSecret
            CertificateThumbprint           = $CertificateThumbprint
            Managedidentity                 = $ManagedIdentity.IsPresent
        }

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
        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $CatalogId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsHidden,

        [Parameter()]
        [System.Boolean]
        $IsRoleScopesVisible,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AccessPackageResourceRoleScopes,

        [Parameter()]
        [System.String[]]
        $IncompatibleAccessPackages,

        [Parameter()]
        [System.String[]]
        $AccessPackagesIncompatibleWith,

        [Parameter()]
        [System.String[]]
        $IncompatibleGroups,
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
        $ManagedIdentity
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'beta'
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

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating access package {$DisplayName}"

        #region basic information
        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()

        $CreateParameters.Remove('Id') | Out-Null
        $CreateParameters.Remove('Verbose') | Out-Null
        $CreateParameters.Remove('AccessPackageResourceRoleScopes') | Out-Null
        $CreateParameters.Remove('IncompatibleAccessPackages') | Out-Null
        $CreateParameters.Remove('AccessPackagesIncompatibleWith') | Out-Null
        $CreateParameters.Remove('IncompatibleGroups') | Out-Null

        $accessPackage = New-MgEntitlementManagementAccessPackage `
            -BodyParameter $CreateParameters

        #endregion

        #region IncompatibleAccessPackages
        foreach ($incompatibleAccessPackage in $IncompatibleAccessPackages)
        {
            $ref = @{
                '@odata.id' = "https://graph.microsoft.com/beta/identityGovernance/entitlementManagement/accessPackages/$incompatibleAccessPackage"
            }

            New-MgEntitlementManagementAccessPackageIncompatibleAccessPackageByRef `
                -AccessPackageId $accessPackage.Id `
                -OdataId $ref.'@odata.id'
        }
        #endregion

        #region IncompatibleGroups
        foreach ($IncompatibleGroup in $IncompatibleGroups)
        {
            $ref = @{
                '@odata.id' = "https://graph.microsoft.com/beta/groups/$IncompatibleGroup"
            }

            New-MgEntitlementManagementAccessPackageIncompatibleGroupByRef `
                -AccessPackageId $accessPackage.Id `
                -OdataId $ref.'@odata.id'
        }
        #endregion

        #region AccessPackageResourceRoleScopes
        foreach ($accessPackageResourceRoleScope in $AccessPackageResourceRoleScopes)
        {
            #Add scopeRole
            $originId = $accessPackageResourceRoleScope.AccessPackageResourceOriginId
            $roleName = $accessPackageResourceRoleScope.AccessPackageResourceRoleDisplayName

            Write-Verbose -Message "Adding roleScope {$originId`:$roleName} to access package with Id {$($accessPackage.Id)}"

            $resourceScope = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResource `
                -AccessPackageCatalogId $CatalogId `
                -Filter "originId eq '$originId'" `
                -ExpandProperty 'accessPackageResourceScopes'

            $resourceRole = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResourceRole `
                -AccessPackageCatalogId $CatalogId `
                -Filter "(accessPackageResource/Id eq '$($resourceScope.id)' and displayname eq '$roleName' and originSystem eq '$($resourceScope.originSystem)')" `
                -ExpandProperty 'accessPackageResource'

            $isValidRoleScope = $true
            if ($null -eq $resourceScope)
            {
                Write-Verbose -Message "The AccessPackageResourceOriginId {$originId} could not be found in catalog with id {$CatalogId}"
                $isValidRoleScope = $false
            }

            if ($null -eq $resourceRole)
            {
                Write-Verbose -Message "The AccessPackageResourceRoleDisplayName {$roleName} could not be found for resource with originID {$originId}"
                $isValidRoleScope = $false
            }

            if ($isValidRoleScope)
            {
                $params = [ordered]@{
                    AccessPackageResourceRole  = @{
                        OriginId              = $resourceRole.OriginId
                        DisplayName           = $resourceRole.DisplayName
                        OriginSystem          = $resourceRole.OriginSystem
                        AccessPackageResource = @{
                            Id           = $resourceScope.Id
                            ResourceType = $resourceScope.ResourceType
                            OriginId     = $resourceScope.OriginId
                            OriginSystem = $resourceRole.OriginSystem
                        }
                    }
                    AccessPackageResourceScope = @{
                        OriginId     = $resourceScope.OriginId
                        OriginSystem = $resourceScope.OriginSystem
                        IsRootScope  = $resourceScope.AccessPackageResourceScopes[0].IsRootScope
                    }
                }

                Write-Verbose -Message ("package id {$($accessPackage.Id)}")
                Write-Verbose -Message ($params | ConvertTo-Json -Depth 20)
                New-MgEntitlementManagementAccessPackageResourceRoleScope -AccessPackageId $accessPackage.Id -BodyParameter $params
            }
        }
        #endregion

    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating access package with id {$id} and displayName {$DisplayName}"

        #region basic information
        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()

        $UpdateParameters.Remove('Id') | Out-Null
        $UpdateParameters.Remove('Verbose') | Out-Null
        $UpdateParameters.Remove('AccessPackageResourceRoleScopes') | Out-Null
        $UpdateParameters.Remove('IncompatibleAccessPackages') | Out-Null
        $UpdateParameters.Remove('AccessPackagesIncompatibleWith') | Out-Null
        $UpdateParameters.Remove('IncompatibleGroups') | Out-Null

        Update-MgEntitlementManagementAccessPackage -BodyParameter $UpdateParameters `
            -AccessPackageId $currentInstance.Id
        #endregion

        #region IncompatibleAccessPackages
        [Array]$currentIncompatibleAccessPackages = $currentInstance.IncompatibleAccessPackages
        if ($null -eq $currentIncompatibleAccessPackages)
        {
            $currentIncompatibleAccessPackages = @()
        }
        if ($null -eq $IncompatibleAccessPackages)
        {
            $IncompatibleAccessPackages = @()
        }
        [Array]$compareResult = Compare-Object `
            -ReferenceObject $IncompatibleAccessPackages `
            -DifferenceObject $currentIncompatibleAccessPackages `

        [Array]$toBeAdded = $compareResult | Where-Object -FilterScript { $_.SideIndicator -eq '<=' }

        foreach ($incompatibleAccessPackage in $toBeAdded.InputObject)
        {
            $ref = @{
                '@odata.id' = "https://graph.microsoft.com/beta/identityGovernance/entitlementManagement/accessPackages/$incompatibleAccessPackage"
            }

            New-MgEntitlementManagementAccessPackageIncompatibleAccessPackageByRef `
                -AccessPackageId $currentInstance.Id `
                -OdataId $ref.'@odata.id'
        }

        [Array]$toBeRemoved = $compareResult | Where-Object -FilterScript { $_.SideIndicator -eq '=>' }

        foreach ($incompatibleAccessPackage in $toBeRemoved.InputObject)
        {
            Remove-MgEntitlementManagementAccessPackageIncompatibleAccessPackageByRef `
                -AccessPackageId $currentInstance.Id `
                -AccessPackageId1 $incompatibleAccessPackage
        }
        #endregion

        #region IncompatibleGroups
        [Array]$currentIncompatibleGroups = $currentInstance.IncompatibleGroups
        if ($null -eq $currentIncompatibleGroups)
        {
            $currentIncompatibleGroups = @()
        }
        if ($null -eq $IncompatibleGroups)
        {
            $IncompatibleGroups = @()
        }
        [Array]$compareResult = Compare-Object `
            -ReferenceObject $IncompatibleGroups `
            -DifferenceObject $currentIncompatibleGroups `

        [Array]$toBeAdded = $compareResult | Where-Object -FilterScript { $_.SideIndicator -eq '<=' }
        foreach ($incompatibleGroup in $tobeAdded.InputObject)
        {

            $ref = @{
                '@odata.id' = "https://graph.microsoft.com/beta/groups/$incompatibleGroup"
            }

            New-MgEntitlementManagementAccessPackageIncompatibleGroupByRef `
                -AccessPackageId $currentInstance.Id `
                -OdataId $ref.'@odata.id'
        }

        [Array]$toBeRemoved = $compareResult | Where-Object -FilterScript { $_.SideIndicator -eq '=>' }

        foreach ($IncompatibleGroup in $toBeRemoved.InputObject)
        {
            Remove-MgEntitlementManagementAccessPackageIncompatibleGroupByRef `
                -AccessPackageId $currentInstance.Id `
                -GroupId $incompatibleGroup
        }
        #endregion

        #region AccessPackageResourceRoleScopes
        $currentAccessPackageResourceOriginIds = $currentInstance.AccessPackageResourceRoleScopes.AccessPackageResourceOriginId
        foreach ($accessPackageResourceRoleScope in $AccessPackageResourceRoleScopes)
        {
            if ($accessPackageResourceRoleScope.AccessPackageResourceOriginId -notin ($currentAccessPackageResourceOriginIds))
            {
                #region new roleScope
                $originId = $accessPackageResourceRoleScope.AccessPackageResourceOriginId
                $roleName = $accessPackageResourceRoleScope.AccessPackageResourceRoleDisplayName

                Write-Verbose -Message "Adding roleScope {$originId`:$roleName} to access package with Id {$($currentInstance.Id)}"

                $resourceScope = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResource `
                    -AccessPackageCatalogId $CatalogId `
                    -Filter "originId eq '$originId'" `
                    -ExpandProperty 'accessPackageResourceScopes'

                $resourceRole = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResourceRole `
                    -AccessPackageCatalogId $CatalogId `
                    -Filter "(accessPackageResource/Id eq '$($resourceScope.id)' and displayname eq '$roleName' and originSystem eq '$($resourceScope.originSystem)')" `
                    -ExpandProperty 'accessPackageResource'

                $isValidRoleScope = $true
                if ($null -eq $resourceScope)
                {
                    Write-Verbose -Message "The AccessPackageResourceOriginId {$originId} could not be found in catalog with id {$CatalogId}"
                    $isValidRoleScope = $false
                }

                if ($null -eq $resourceRole)
                {
                    Write-Verbose -Message "The AccessPackageResourceRoleDisplayName {$roleName} could not be found for resource with originID {$originId}"
                    $isValidRoleScope = $false
                }

                if ($isValidRoleScope)
                {
                    $params = [ordered]@{
                        AccessPackageResourceRole  = @{
                            OriginId              = $resourceRole.OriginId
                            DisplayName           = $resourceRole.DisplayName
                            OriginSystem          = $resourceRole.OriginSystem
                            AccessPackageResource = @{
                                Id           = $resourceScope.Id
                                ResourceType = $resourceScope.ResourceType
                                OriginId     = $resourceScope.OriginId
                                OriginSystem = $resourceRole.OriginSystem
                            }
                        }
                        AccessPackageResourceScope = @{
                            OriginId     = $resourceScope.OriginId
                            OriginSystem = $resourceScope.OriginSystem
                            IsRootScope  = $resourceScope.AccessPackageResourceScopes[0].IsRootScope
                        }
                    }

                    New-MgEntitlementManagementAccessPackageResourceRoleScope -AccessPackageId $currentInstance.Id -BodyParameter $params
                }
                #endregion
            }
            else
            {
                $currentRole = $currentInstance.AccessPackageResourceRoleScopes | Where-Object `
                    -FilterScript { $_.AccessPackageResourceOriginId -eq $accessPackageResourceRoleScope.AccessPackageResourceOriginId }
                if ($accessPackageResourceRoleScope.AccessPackageResourceRoleDisplayName -ne $currentRole.AccessPackageResourceRoleDisplayName )
                {
                    #region update role

                    $originId = $accessPackageResourceRoleScope.AccessPackageResourceOriginId
                    $roleName = $accessPackageResourceRoleScope.AccessPackageResourceRoleDisplayName

                    Write-Verbose -Message "Updating role {$roleName} from access package rolescope with Id {$($accessPackageResourceRoleScope.id)}"

                    $resourceScope = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResource `
                        -AccessPackageCatalogId $CatalogId `
                        -Filter "originId eq '$originId'" `
                        -ExpandProperty 'accessPackageResourceScopes'

                    $resourceRole = Get-MgEntitlementManagementAccessPackageCatalogAccessPackageResourceRole `
                        -AccessPackageCatalogId $CatalogId `
                        -Filter "(accessPackageResource/Id eq '$($resourceScope.id)' and displayname eq '$roleName' and originSystem eq '$($resourceScope.originSystem)')" `
                        -ExpandProperty 'accessPackageResource'

                    $isValidRoleScope = $true
                    if ($null -eq $resourceScope)
                    {
                        Write-Verbose -Message "The AccessPackageResourceOriginId {$originId} could not be found in catalog with id {$CatalogId}"
                        $isValidRoleScope = $false
                    }

                    if ($null -eq $resourceRole)
                    {
                        Write-Verbose -Message "The AccessPackageResourceRoleDisplayName {$roleName} could not be found for resource with originID {$originId}"
                        $isValidRoleScope = $false
                    }

                    if ($isValidRoleScope)
                    {
                        $params = [ordered]@{
                            AccessPackageResourceRole  = @{
                                OriginId              = $resourceRole.OriginId
                                DisplayName           = $resourceRole.DisplayName
                                OriginSystem          = $resourceRole.OriginSystem
                                AccessPackageResource = @{
                                    Id           = $resourceScope.Id
                                    ResourceType = $resourceScope.ResourceType
                                    OriginId     = $resourceScope.OriginId
                                    OriginSystem = $resourceRole.OriginSystem
                                }
                            }
                            AccessPackageResourceScope = @{
                                OriginId     = $resourceScope.OriginId
                                OriginSystem = $resourceScope.OriginSystem
                                IsRootScope  = $resourceScope.AccessPackageResourceScopes[0].IsRootScope
                            }
                        }

                        Remove-MgEntitlementManagementAccessPackageResourceRoleScope `
                            -AccessPackageId $currentInstance.Id  `
                            -AccessPackageResourceRoleScopeId $currentRole.Id

                        New-MgEntitlementManagementAccessPackageResourceRoleScope `
                            -AccessPackageId $currentInstance.Id `
                            -BodyParameter $params

                    }
                    #endregion
                }
            }
        }

        #region remove roleScope
        $currentAccessPackageResourceOriginIdsToRemove = $currentAccessPackageResourceOriginIds | Where-Object `
            -FilterScript { $_ -notin $AccessPackageResourceRoleScopes.AccessPackageResourceOriginId }
        foreach ($originId in $currentAccessPackageResourceOriginIdsToRemove)
        {

            $currentRoleScope = $currentInstance.AccessPackageResourceRoleScopes | Where-Object `
                -FilterScript { $_.AccessPackageResourceOriginId -eq $originId }

            Write-Verbose -Message "Removing RoleScope with originId {$originId} from access package {$($currentInstance.Id)}"

            Remove-MgEntitlementManagementAccessPackageResourceRoleScope `
                -AccessPackageId $currentInstance.Id  `
                -AccessPackageResourceRoleScopeId $currentRoleScope.Id
        }
        #endregion

    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing access package with id {$id} and displayName {$DisplayName}"

        #region resource generator code
        Remove-MgEntitlementManagementAccessPackage -AccessPackageId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $CatalogId,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.Boolean]
        $IsHidden,

        [Parameter()]
        [System.Boolean]
        $IsRoleScopesVisible,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AccessPackageResourceRoleScopes,

        [Parameter()]
        [System.String[]]
        $IncompatibleAccessPackages,

        [Parameter()]
        [System.String[]]
        $AccessPackagesIncompatibleWith,

        [Parameter()]
        [System.String[]]
        $IncompatibleGroups,
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
        $ManagedIdentity
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

    Write-Verbose -Message "Testing configuration of {$Id}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
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
            foreach ($s in [Array]$source)
            {
                $s.remove('Id')
            }
            foreach ($t in [Array]$target)
            {
                $t.remove('Id')
            }

            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null

        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null
    $ValuesToCheck.Remove('AccessPackagesIncompatibleWith') | Out-Null #read-only

    #Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    #Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

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
        $ManagedIdentity
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters `
        -ProfileName 'beta'

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

        #region resource generator code
        [array]$getValue = Get-MgEntitlementManagementAccessPackage `
            -All `
            -ErrorAction Stop

        #endregion
        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            $displayedKey = $config.id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id                    = $config.id
                DisplayName           = $config.displayName
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
            }

            $Results = Get-TargetResource @Params

            if ($null -ne $Results.AccessPackageResourceRoleScopes)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject ([Array]$Results.AccessPackageResourceRoleScopes) `
                    -CIMInstanceName AccessPackageResourceRoleScope

                $Results.AccessPackageResourceRoleScopes = $complexTypeStringResult

                if ([String]::IsNullOrEmpty($complexTypeStringResult))
                {
                    $Results.Remove('AccessPackageResourceRoleScopes') | Out-Null
                }
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential


            if ($null -ne $Results.AccessPackageResourceRoleScopes)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'AccessPackageResourceRoleScopes' -IsCIMArray:$true
            }

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName

            Write-Host $Global:M365DSCEmojiGreenCheckMark
            $i++
        }

        #Removing extra coma between items in cim instance array created by Convert-DSCStringParamToVariable
        $dscContent = $dscContent.replace("            ,`r`n", '')

        return $dscContent
    }
    catch
    {
        if ($_.ErrorDetails.Message -like '*User is not authorized to perform the operation.*')
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) Tenant does not meet license requirement to extract this component."
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

Export-ModuleMember -Function *-TargetResource
