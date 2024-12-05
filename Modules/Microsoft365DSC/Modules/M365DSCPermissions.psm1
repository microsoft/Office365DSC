using namespace System.Management.Automation.Language

<#
.Description
This function lists all Graph, SharePoint or Exchange permissions required for the specified
resources, both for reading/updating and Delegated/Applications. With the parameters, you can
specify a specific subset of permissions, to be use with the Permissions parameter of
Update-M365DSCAzureAdApplication.

.Parameter ResourceNameList
An array of resource names for which the permissions should be determined.

.Parameter PermissionsType
Specifies what type of permissions need to get returned, Delegated or Application.

.Parameter AccessType
Specifies the workload of the permissions that need to get returned.

.Example
Get-M365DSCCompiledPermissionList -ResourceNameList @('EXOAcceptedDomain')

.Example
Get-M365DSCCompiledPermissionList -ResourceNameList (Get-M365DSCAllResources)

.Example
Get-M365DSCCompiledPermissionList -ResourceNameList (Get-M365DSCAllResources) -PermissionType 'Application' -AccessType 'Update'

.Example
Get-M365DSCCompiledPermissionList -ResourceNameList (Get-M365DSCAllResources) -PermissionType 'Delegated' -AccessType 'Read'

.Functionality
Public
#>
function Get-M365DSCCompiledPermissionList
{
    [CmdletBinding(DefaultParametersetName = 'None')]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true, Position = 0)]
        [System.String[]]
        $ResourceNameList,

        [Parameter()]
        [System.String]
        [ValidateSet('Delegated', 'Application')]
        $PermissionType,

        [Parameter()]
        [System.String]
        [ValidateSet('Read', 'Update')]
        $AccessType
    )

    if (($PSBoundParameters.ContainsKey('PermissionType') -eq $true -and $PSBoundParameters.ContainsKey('AccessType') -eq $false))
    {
        throw 'You specified parameter PermissionType without AccessType. Please specify both parameters.'
    }

    if (($PSBoundParameters.ContainsKey('PermissionType') -eq $false -and $PSBoundParameters.ContainsKey('AccessType') -eq $true))
    {
        throw 'You specified parameter AccessType without PermissionType. Please specify both parameters.'
    }

    $results = @{
        Read               = @(
            @{
                API        = 'Graph'
                Permission = @{
                    Name = 'Organization.Read.All'
                    Type = 'Application'
                }
            }
        )
        Update             = @(
            @{
                API        = 'Graph'
                Permission = @{
                    Name = 'Organization.Read.All'
                    Type = 'Application'
                }
            }
        )
        RequiredRoles      = @()
        RequiredRoleGroups = @()
    }

    $total = $ResourceNameList.Count
    $count = 1
    foreach ($resourceName in $ResourceNameList)
    {
        $percentage = ($count / $total) * 100
        Write-Progress -Activity 'Retrieving required permissions' -PercentComplete $percentage -Status 'Processing resource' -CurrentOperation $resourceName

        Write-Verbose -Message "Processing $resourceName"
        $settingsFilePath = $null
        try
        {
            $settingsFilePath = Join-Path -Path $PSScriptRoot `
                -ChildPath "..\DSCResources\MSFT_$resourceName\settings.json" `
                -Resolve `
                -ErrorAction Stop
        }
        catch
        {
            Write-Warning -Message "File settings.json was not found for resource {$resourceName}"
        }

        if ($null -ne $settingsFilePath)
        {
            $fileContent = Get-Content $settingsFilePath -Raw
            $resourceSettings = ConvertFrom-Json -InputObject $fileContent

            if ($null -eq $resourceSettings.permissions)
            {
                Write-Warning "Error in reading permissions. Missing permissions node in settings.json for $resourceName."
                continue
            }

            # Graph permissions
            if ($null -ne $resourceSettings.permissions.graph)
            {
                Write-Verbose -Message '  Retrieving Graph permissions'

                # Delegated Update permissions
                Update-M365DSCPermissionsMatrix -Source 'Graph' `
                    -PermissionType 'Delegated' `
                    -AccessType 'Update' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Application Update permissions
                Update-M365DSCPermissionsMatrix -Source 'Graph' `
                    -PermissionType 'Application' `
                    -AccessType 'Update' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Delegated Read permissions
                Update-M365DSCPermissionsMatrix -Source 'Graph' `
                    -PermissionType 'Delegated' `
                    -AccessType 'Read' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Application Read permissions
                Update-M365DSCPermissionsMatrix -Source 'Graph' `
                    -PermissionType 'Application' `
                    -AccessType 'Read' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)
            }
            else
            {
                Write-Verbose "  No Graph node in settings.json for $resourceName."
            }

            # Exchange permissions
            if ($null -ne $resourceSettings.permissions.exchange)
            {
                Write-Verbose -Message '  Retrieving Exchange permissions'
                # Required Role
                foreach ($requiredRole in $resourceSettings.permissions.exchange.requiredroles)
                {
                    if (-not $results.RequiredRoles.Contains($requiredRole))
                    {
                        Write-Verbose -Message "    Found new Required Role {$($requiredRole)}"
                        $results.RequiredRoles += $requiredRole
                    }
                    else
                    {
                        Write-Verbose -Message "    Required Role {$($requiredRole)} was already added"
                    }
                }

                # Required RoleGroups
                foreach ($requiredRoleGroup in $resourceSettings.permissions.exchange.requiredrolegroups)
                {
                    if (-not $results.RequiredRoleGroups.Contains($requiredRoleGroup))
                    {
                        Write-Verbose -Message "    Found new Required Role Group {$($requiredRoleGroup)}"
                        $results.RequiredRoleGroups += $requiredRoleGroup
                    }
                    else
                    {
                        Write-Verbose -Message "    Required Role Group {$($requiredRoleGroup)} was already added"
                    }
                }

                $exchangeRead = $results.Read | Where-Object -FilterScript { $_.API -eq 'Exchange' -and $_.Permission.Name -eq 'Exchange.ManageAsApp' }
                if ($null -eq $exchangeRead)
                {
                    $results.Read += @{
                        API        = 'Exchange'
                        Permission = @{
                            Type = 'Application'
                            Name = 'Exchange.ManageAsApp'
                        }
                    }
                }

                $exchangeUpdate = $results.Update | Where-Object -FilterScript { $_.API -eq 'Exchange' -and $_.Permission.Name -eq 'Exchange.ManageAsApp' }
                if ($null -eq $exchangeUpdate)
                {
                    $results.Update += @{
                        API        = 'Exchange'
                        Permission = @{
                            Type = 'Application'
                            Name = 'Exchange.ManageAsApp'
                        }
                    }
                }
            }
            else
            {
                Write-Verbose "  No Exchange node in settings.json for $resourceName."
            }

            # SharePoint permissions
            if ($null -ne $resourceSettings.permissions.sharepoint)
            {
                Write-Verbose -Message '  Retrieving SharePoint permissions'

                # Delegated Update permissions
                Update-M365DSCPermissionsMatrix -Source 'SharePoint' `
                    -PermissionType 'Delegated' `
                    -AccessType 'Update' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Application Update permissions
                Update-M365DSCPermissionsMatrix -Source 'SharePoint' `
                    -PermissionType 'Application' `
                    -AccessType 'Update' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Delegated Read permissions
                Update-M365DSCPermissionsMatrix -Source 'SharePoint' `
                    -PermissionType 'Delegated' `
                    -AccessType 'Read' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)

                # Application Read permissions
                Update-M365DSCPermissionsMatrix -Source 'SharePoint' `
                    -PermissionType 'Application' `
                    -AccessType 'Read' `
                    -Matrix ([ref]$results) `
                    -Settings ($resourceSettings)
            }
            else
            {
                Write-Verbose "  No SharePoint node in settings.json for $resourceName."
            }
        }
        $count++
    }

    if ($PSBoundParameters.ContainsKey('PermissionType'))
    {
        $results = $results.$AccessType | Where-Object -FilterScript { $_. Permission.Type -eq $PermissionType }
        $results | ForEach-Object -Process {
            $_.PermissionName = $_.Permission.Name
            $_.Remove('Permission')
        }
    }

    return $results
}

<#
.Description
This function updates the inputted permissions matrix.
It is generic code used in the Get-M365DSCCompiledPermissionList function.

.Functionality
Internal, Hidden
#>
function Update-M365DSCPermissionsMatrix
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Source,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Delegated', 'Application')]
        $PermissionType,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Read', 'Update')]
        $AccessType,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        [ref]$Matrix,

        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $Settings
    )

    foreach ($permission in $Settings.permissions.$Source.$PermissionType.$AccessType)
    {
        if ($permission.Name -ne 'NotSupported')
        {
            $matrixPermission = $results.$AccessType | Where-Object -FilterScript {
                $_.API -eq $Source -and $_.Permission.Name -eq $permission.name -and $_.Permission.Type -eq $PermissionType
            }

            if ($null -eq $matrixPermission)
            {
                Write-Verbose -Message "    Found new $AccessType permission {$($permission.name)} for API {$Source}"
                $results.$AccessType += @{
                    API        = $Source
                    Permission = @{
                        Type = $PermissionType
                        Name = $permission.name
                    }
                }
            }
            else
            {
                Write-Verbose -Message "    $AccessType permission {$($permission.name)} was already added for API {$Source}"
            }
        }
    }
}

<#
.Description
This function updates the required permissions for the specified resources and type
for the Microsoft Graph delegated application in Azure Active Directory.

.Parameter ResourceNameList
An array of resource names for which the permissions should be determined.

.Parameter All
Specifies that the permissions should be determined for all resources.

.Parameter Type
For which action should the permissions be updated: Read or Update.

.Example
Update-M365DSCAllowedGraphScopes -ResourceNameList @('AADUSer', 'AADApplication') -Type 'Read'

.Example
Update-M365DSCAllowedGraphScopes -All -Type 'Update' -Environment 'Global'

.Functionality
Public
#>
function Update-M365DSCAllowedGraphScopes
{
    [CmdletBinding()]
    [OutputType()]
    param
    (
        [Parameter()]
        [System.String[]]
        $ResourceNameList,

        [Parameter()]
        [Switch]
        $All,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Read', 'Update')]
        [System.String]
        $Type,

        [Parameter()]
        [ValidateSet('Global', 'China', 'USGov', 'USGovDoD', 'Germany')]
        [System.String]
        $Environment = 'Global'
    )

    if ($All)
    {
        Write-Verbose -Message 'All parameter specified'
        $resourceNames = Get-M365DSCAllResources
    }
    else
    {
        if ($PSBoundParameters.ContainsKey('ResourceNameList') -eq $false)
        {
            throw 'You have to specify either the All or ResourceNameList parameter!'
        }

        Write-Verbose -Message "Specified resources: $($ResourceNameList -join ', ')"
        $resourceNames = $ResourceNameList
    }

    Write-Verbose -Message "Specified type: $Type"
    $results = Get-M365DSCCompiledPermissionList -ResourceNameList $resourceNames -PermissionType 'Delegated' -AccessType $Type
    $permissions = ($results | Where-Object -FilterScript { $_.API -eq 'Graph' }).PermissionName

    Write-Verbose -Message "Found permissions: $($permissions -join ', ')"
    $params = @{
        Scopes = $permissions
    }

    Write-Verbose -Message 'Connecting to MS Graph to update permissions'
    $result = Connect-MgGraph @params -Environment $Environment
    if ($result -like '*Welcome To Microsoft Graph!*')
    {
        Write-Output 'Allowed Graph scopes updated!'
    }
    else
    {
        Write-Output 'Error during updating allowed Graph scopes!'
    }
}

<#
.Description
This function updates the settings.json files for all resources that use Graph cmdlets.
It is compiling a permissions list based on all used Graph cmdlets in the resource and
retrieving the permissions for these cmdlets from the Graph. Then it updates the
settings.json file

.Example
Update-M365DSCResourcesSettingsJSON

.Functionality
Public
#>
<#
## HIDDEN BECAUSE OF ISSUES WITH THE FIND-MGGRAPHCOMMAND CMDLET. TEMPORARILY REPLACED WITH BELOW FUNCTION.
function Update-M365DSCResourcesSettingsJSON
{
    [CmdletBinding()]
    param()

    Write-Verbose "Determining DSCResources path"
    $dscResourcesRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\DSCResources'
    Write-Verbose "  DSCResouces path: $dscResourcesRoot"

    Write-Verbose "Getting all psm1 files"
    $files = Get-ChildItem -Path "$dscResourcesRoot\*.psm1" -Recurse
    Write-Verbose "  Found $($files.Count) psm1 files"

    $ignoredCmdlets = @("Get-MgContext")

    foreach ($file in $files)
    {
        $readPermissions = @()
        $updatePermissions = @()
        if ($file -notlike "*Intune*")
        {
            Write-Verbose "Processing file: $($file.BaseName)"
            $content = Get-Content $file -Raw

            $sb = [ScriptBlock]::Create($content)

            $functions = $sb.Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)

            $functions = $functions | Where-Object { $_.Name -in ("Get-TargetResource", "Set-TargetResource") }

            foreach ($function in $functions)
            {
                Write-Verbose "  Function: $($function.Name)"

                $regex = [Regex]::new('(?<Cmdlet>(Update|Get|Remove|Set)-Mg\w*)')
                $regexMatches = $regex.Matches($function.Extent.Text)

                $cmdlets = $regexMatches.Value | Sort-Object | Select-Object -Unique

                $functionPermissions = @()
                foreach ($cmdlet in $cmdlets)
                {
                    if ($cmdlet -notin $ignoredCmdlets)
                    {
                        $commands = Find-MgGraphCommand -Command $cmdlet

                        $cmdletPermissions = $commands[0].Permissions
                        $functionPermissions += $cmdletPermissions.Name
                    }
                }
                $cleanFunctionPermissions = $functionPermissions | Sort-Object | Select-Object -Unique

                if ($null -ne $cleanFunctionPermissions)
                {
                    switch ($function.Name)
                    {
                        "Get-TargetResource"
                        {
                            $readPermissions = @()
                            foreach ($item in $cleanFunctionPermissions)
                            {
                                $readPermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                        "Set-TargetResource"
                        {
                            $updatePermissions = @()
                            foreach ($item in $cleanFunctionPermissions)
                            {
                                $updatePermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                    }
                }
            }

            $settingsFile = Join-Path -Path $file.DirectoryName -ChildPath 'settings.json'
            if (Test-Path -Path $settingsFile)
            {
                Write-Verbose "  Updating existing settings.json file"
                $settingsJson = Get-Content -Path $settingsFile -Raw
                $settings = ConvertFrom-Json $settingsJson

                if ($readPermissions.Count -eq 0 -and $settings.permissions.read.Count -ne 0)
                {
                    [array]$readPermissions = $settings.permissions.read
                }

                if ($updatePermissions.Count -eq 0 -and $settings.permissions.update.Count -ne 0)
                {
                    [array]$updatePermissions = $settings.permissions.update
                }

                $settings.permissions = @([PSCustomObject]@{
                        read   = $readPermissions
                        update = $updatePermissions
                    })

            }
            else
            {
                Write-Verbose "    Creating new settings.json file"
                $settings = [PSCustomObject]@{
                    resourceName = $file.BaseName -replace 'MSFT_'
                    description  = ""
                    permissions  = @([PSCustomObject]@{
                            read   = $readPermissions
                            update = $updatePermissions
                        })
                }
            }
            $json = ConvertTo-Json -InputObject $settings -Depth 10
            Set-Content -Path $settingsFile -Value $json -Encoding UTF8
        }
        else
        {
            Write-Verbose "$($file.BaseName) - Skipping Intune resources (unable to process those Graph cmdlets)"
        }
    }
}
#>

<#
.Description
This function updates the settings.json files for all resources that use Graph cmdlets.
It is compiling a permissions list based on all used Graph cmdlets in the resource and
retrieving the permissions for these cmdlets from the Graph. Then it updates the
settings.json file

.Example
Update-M365DSCResourcesSettingsJSON

.Functionality
Internal
#>
function Update-M365DSCResourcesSettingsJSON
{
    [CmdletBinding()]
    param()

    Write-Verbose 'Determining DSCResources path'
    $dscResourcesRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\DSCResources'
    Write-Verbose "  DSCResouces path: $dscResourcesRoot"

    Write-Verbose 'Reading Graph Cmdlet Permissions input file'
    $graphCmdletPermissionsFile = Join-Path -Path $PSScriptRoot -ChildPath '..\Dependencies\GraphCmdletPermissions.csv'
    $cmdletPermissions = Import-Csv -Path $graphCmdletPermissionsFile -Delimiter ',' -Encoding UTF8
    Write-Verbose "  Input file path: $graphCmdletPermissionsFile"

    Write-Verbose 'Getting all psm1 files'
    $files = Get-ChildItem -Path "$dscResourcesRoot\*.psm1" -Recurse
    Write-Verbose "  Found $($files.Count) psm1 files"

    $ignoredCmdlets = @('Get-MgContext')

    foreach ($file in $files)
    {
        $delegatedReadPermissions = @()
        $delegatedUpdatePermissions = @()
        $applicationReadPermissions = @()
        $applicationUpdatePermissions = @()
        if ($file -notlike '*Intune*')
        {
            Write-Verbose "Processing file: $($file.BaseName)"

            $content = Get-Content $file -Raw

            $sb = [ScriptBlock]::Create($content)

            $functions = $sb.Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)

            $functions = $functions | Where-Object { $_.Name -in ('Get-TargetResource', 'Set-TargetResource') }

            foreach ($function in $functions)
            {
                Write-Verbose "  Function: $($function.Name)"

                $regex = [Regex]::new('(?<Cmdlet>(Update|Get|Remove|Set|New)-Mg\w*)')
                $regexMatches = $regex.Matches($function.Extent.Text)

                $cmdlets = $regexMatches.Value | Sort-Object | Select-Object -Unique

                $delegatedFunctionPermissions = @()
                $applicationFunctionPermissions = @()
                foreach ($cmdlet in $cmdlets)
                {
                    if ($cmdlet -notin $ignoredCmdlets)
                    {
                        $delegatedFunctionPermissions += ($cmdletPermissions | Where-Object { $_.Cmdlet -eq $cmdlet }).DelegatedPermissions -split '/'
                        $applicationFunctionPermissions += ($cmdletPermissions | Where-Object { $_.Cmdlet -eq $cmdlet }).ApplicationPermissions -split '/'
                    }
                }
                $cleanDelegatedFunctionPermissions = $delegatedFunctionPermissions | Sort-Object | Select-Object -Unique
                $cleanApplicationFunctionPermissions = $applicationFunctionPermissions | Sort-Object | Select-Object -Unique

                if ($cleanDelegatedFunctionPermissions -contains 'NotSupported')
                {
                    $cleanDelegatedFunctionPermissions = @('NotSupported')
                }

                if ($cleanApplicationFunctionPermissions -contains 'NotSupported')
                {
                    $cleanApplicationFunctionPermissions = @('NotSupported')
                }

                if ($null -ne $cleanDelegatedFunctionPermissions)
                {
                    switch ($function.Name)
                    {
                        'Get-TargetResource'
                        {
                            $delegatedReadPermissions = @()
                            foreach ($item in $cleanDelegatedFunctionPermissions)
                            {
                                $delegatedReadPermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                        'Set-TargetResource'
                        {
                            $delegatedUpdatePermissions = @()
                            foreach ($item in $cleanDelegatedFunctionPermissions)
                            {
                                $delegatedUpdatePermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                    }
                }

                if ($null -ne $cleanApplicationFunctionPermissions)
                {
                    switch ($function.Name)
                    {
                        'Get-TargetResource'
                        {
                            $applicationReadPermissions = @()
                            foreach ($item in $cleanApplicationFunctionPermissions)
                            {
                                $applicationReadPermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                        'Set-TargetResource'
                        {
                            $applicationUpdatePermissions = @()
                            foreach ($item in $cleanApplicationFunctionPermissions)
                            {
                                $applicationUpdatePermissions += [PSCustomObject]@{
                                    name = $item
                                }
                            }
                        }
                    }
                }
            }

            $settingsFile = Join-Path -Path $file.DirectoryName -ChildPath 'settings.json'
            if (Test-Path -Path $settingsFile)
            {
                Write-Verbose '  Updating existing settings.json file'
                $settingsJson = Get-Content -Path $settingsFile -Raw
                $settings = ConvertFrom-Json $settingsJson

                $newPermissions = @{
                    graph = @{
                        delegated   = @{
                            read   = @()
                            update = @()
                        }
                        application = @{
                            read   = @()
                            update = @()
                        }
                    }
                }

                if ($delegatedReadPermissions.Count -eq 0 -and $settings.permissions.graph.delegated.read.Count -ne 0)
                {
                    [array]$delegatedReadPermissions = $settings.permissions.graph.delegated.read
                }

                if ($delegatedUpdatePermissions.Count -eq 0 -and $settings.permissions.graph.delegated.update.Count -ne 0)
                {
                    [array]$delegatedUpdatePermissions = $settings.permissions.graph.delegated.update
                }

                if ($applicationReadPermissions.Count -eq 0 -and $settings.permissions.graph.application.read.Count -ne 0)
                {
                    [array]$applicationReadPermissions = $settings.permissions.graph.application.read
                }

                if ($applicationUpdatePermissions.Count -eq 0 -and $settings.permissions.graph.application.update.Count -ne 0)
                {
                    [array]$applicationUpdatePermissions = $settings.permissions.graph.application.update
                }

                $settings.permissions = @{
                    graph = @{
                        delegated   = [PSCustomObject]@{
                            read   = $delegatedReadPermissions
                            update = $delegatedUpdatePermissions
                        }
                        application = [PSCustomObject]@{
                            read   = $applicationReadPermissions
                            update = $applicationUpdatePermissions
                        }
                    }
                }

            }
            else
            {
                Write-Verbose '    Creating new settings.json file'
                $settings = [PSCustomObject]@{
                    resourceName = $file.BaseName -replace 'MSFT_'
                    description  = ''
                    permissions  = @{
                        graph = @{
                            delegated   = [PSCustomObject]@{
                                read   = $delegatedReadPermissions
                                update = $delegatedUpdatePermissions
                            }
                            application = [PSCustomObject]@{
                                read   = $applicationReadPermissions
                                update = $applicationUpdatePermissions
                            }
                        }
                    }
                }
            }
            $json = ConvertTo-Json -InputObject $settings -Depth 10
            Set-Content -Path $settingsFile -Value $json -Encoding UTF8
        }
        else
        {
            Write-Verbose "$($file.BaseName) - Skipping Intune resources (unable to process those Graph cmdlets)"
        }
    }
}

<#
.Description
This function updates the settings.json files for all Exchange resources. It is
compiling a permissions list based on all used Exchange cmdlets in the resource and
retrieving the permissions for these cmdlets. Then it updates the
settings.json file

.Example
Update-M365DSCExchangeResourcesSettingsJSON -UserPrincipalName m365dsc@contoso.onmicrosoft.com

.Functionality
Internal
#>
function Update-M365DSCExchangeResourcesSettingsJSON
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $UserPrincipalName
    )

    Write-Verbose 'Connecting to Exchange Online'
    if ($null -eq (Get-Command -Name Get-Mailbox -ErrorAction SilentlyContinue))
    {
        Import-Module ExchangeOnlineManagement
        Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName
    }

    Write-Verbose 'Determining DSCResources path'
    $dscResourcesRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\DSCResources'
    Write-Verbose "  DSCResouces path: $dscResourcesRoot"

    Write-Verbose 'Getting all psm1 files'
    $files = Get-ChildItem -Path "$dscResourcesRoot\MSFT_EXO*\*.psm1" -Recurse
    Write-Verbose "  Found $($files.Count) psm1 files"

    foreach ($file in $files)
    {
        Write-Verbose "Processing file: $($file.BaseName)"

        $content = Get-Content $file -Raw

        $sb = [ScriptBlock]::Create($content)

        $functions = $sb.Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)

        $functions = $functions | Where-Object { $_.Name -in ('Get-TargetResource', 'Set-TargetResource') }

        $roleGroups = @()
        $allRoles = @()
        foreach ($function in $functions)
        {
            $errors = $null

            $functionCode = [ScriptBlock]::Create($function.Extent.Text)
            $tokens = [System.Management.Automation.PSParser]::Tokenize($functionCode, [ref]$errors)
            $allCmdlets = $tokens | Where-Object { $_.Type -eq 'Command' } | Select-Object -Property Content -Unique -ExpandProperty Content

            foreach ($cmdlet in $allCmdlets)
            {
                # Checking all cmdlets, even none-EXO ones. This because requesting
                # cmdlets from the module depends on the permissions the user has.
                # No permissions for the Role means no cmdlet.
                $roles = Get-ManagementRole -Cmdlet $cmdlet

                if ($null -eq $roles)
                {
                    continue
                }

                foreach ($role in $roles)
                {
                    $roleAssignments = Get-ManagementRoleAssignment -Role $role.Name -Delegating $false
                    if ($null -eq $roleAssignments -and $allRoles -notcontains $role.Name)
                    {
                        $allRoles += $role.Name
                    }
                    else
                    {
                        $roleGroupAssignments = $roleAssignments | Where-Object { $_.RoleAssigneeType -eq 'RoleGroup' }
                        if ($null -ne $roleGroupAssignments)
                        {
                            if ($allRoles -notcontains $role.Name)
                            {
                                $allRoles += $role.Name
                            }

                            $roleAssigneeName = $roleGroupAssignments.RoleAssigneeName
                            if ($roleGroups.Count -eq 0)
                            {
                                $roleGroups += $roleAssigneeName
                            }
                            else
                            {
                                $roleGroups = (Compare-Object -ReferenceObject $roleGroups -DifferenceObject $roleAssigneeName -IncludeEqual -ExcludeDifferent).InputObject
                            }
                        }
                    }
                }
            }
        }

        Write-Verbose "  Required Roles      : $($allRoles -join ', ')"
        Write-Verbose "  Required Role Groups: $($roleGroups -join ', ')"

        $settingsFile = Join-Path -Path $file.DirectoryName -ChildPath 'settings.json'
        if (Test-Path -Path $settingsFile)
        {
            Write-Verbose '  Updating existing settings.json file'
            $settingsJson = Get-Content -Path $settingsFile -Raw
            $settings = ConvertFrom-Json $settingsJson

            if ($null -eq $settings.permissions)
            {
                $settings | Add-Member -MemberType NoteProperty -Name 'permissions' -Value $value

                $value = [PSCustomObject]@{
                    requiredroles      = $allRoles
                    requiredrolegroups = $roleGroups
                }
                $settings.permissions | Add-Member -MemberType NoteProperty -Name 'exchange' -Value $value
            }
            else
            {
                if ($null -eq $settings.permissions.exchange)
                {
                    $value = [PSCustomObject]@{
                        requiredroles      = $allRoles
                        requiredrolegroups = $roleGroups
                    }
                    $settings.permissions | Add-Member -MemberType NoteProperty -Name 'exchange' -Value $value
                }
                else
                {
                    $settings.permissions.exchange | Add-Member -MemberType NoteProperty -Name 'requiredroles' -Value $allRoles
                    $settings.permissions.exchange | Add-Member -MemberType NoteProperty -Name 'requiredrolegroups' -Value $roleGroups
                }
            }
        }
        else
        {
            Write-Verbose '    Creating new settings.json file'
            $settings = [PSCustomObject]@{
                resourceName = $file.BaseName -replace 'MSFT_'
                description  = ''
                permissions  = [PSCustomObject]@{
                    graph    = [PSCustomObject]@{
                        delegated   = [PSCustomObject]@{
                            read   = @()
                            update = @()
                        }
                        application = [PSCustomObject]@{
                            read   = @()
                            update = @()
                        }
                    }
                    exchange = [PSCustomObject]@{
                        requiredroles      = $allRoles
                        requiredrolegroups = $roleGroups
                    }
                }
            }
        }
        $json = ConvertTo-Json -InputObject $settings -Depth 10
        Set-Content -Path $settingsFile -Value $json -Encoding UTF8
    }
}

<#
.Description
This function updates the settings.json files for all SharePoint resources. It is
setting the Sites.FullControl.All permissions for all available actions, since
all used PnP cmdlets require this permissions.
Then it updates the settings.json file

.Example
Update-M365DSCSharePointResourcesSettingsJSON

.Functionality
Internal
#>
function Update-M365DSCSharePointResourcesSettingsJSON
{
    [CmdletBinding()]
    param ()

    Write-Verbose 'Determining DSCResources path'
    $dscResourcesRoot = Join-Path -Path $PSScriptRoot -ChildPath '..\DSCResources'
    Write-Verbose "  DSCResouces path: $dscResourcesRoot"

    Write-Verbose 'Getting all psm1 files'
    $files = Get-ChildItem -Path "$dscResourcesRoot\MSFT_SPO*\*.psm1" -Recurse
    Write-Verbose "  Found $($files.Count) psm1 files"

    foreach ($file in $files)
    {
        Write-Verbose "Processing file: $($file.BaseName)"

        $settingsFile = Join-Path -Path $file.DirectoryName -ChildPath 'settings.json'
        if (Test-Path -Path $settingsFile)
        {
            Write-Verbose '  Updating existing settings.json file'
            $settingsJson = Get-Content -Path $settingsFile -Raw
            $settings = ConvertFrom-Json $settingsJson

            if ($null -eq $settings.permissions)
            {
                $settings | Add-Member -MemberType NoteProperty -Name 'permissions' -Value $value

                $value = [PSCustomObject]@{
                    delegated   = [PSCustomObject]@{
                        read   = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                        update = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                    }
                    application = [PSCustomObject]@{
                        read   = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                        update = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                    }
                }
                $settings.permissions | Add-Member -MemberType NoteProperty -Name 'sharepoint' -Value $value
            }
            else
            {
                if ($null -eq $settings.permissions.sharepoint)
                {
                    $value = [PSCustomObject]@{
                        delegated   = [PSCustomObject]@{
                            read   = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                            update = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                        }
                        application = [PSCustomObject]@{
                            read   = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                            update = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                        }
                    }

                    $settings.permissions | Add-Member -MemberType NoteProperty -Name 'sharepoint' -Value $value
                }
                else
                {
                    $value = [PSCustomObject]@{
                        read   = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                        update = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )
                    }

                    if ($null -eq $settings.permissions.sharepoint.delegated)
                    {
                        $settings.permissions.sharepoint | Add-Member -MemberType NoteProperty -Name 'delegated' -Value $value
                    }
                    else
                    {
                        $value = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )

                        if ($null -eq $settings.permissions.sharepoint.delegated.read)
                        {
                            $settings.permissions.sharepoint.delegated | Add-Member -MemberType NoteProperty -Name 'read' -Value $value
                        }
                        else
                        {
                            $settings.permissions.sharepoint.delegated.read = $value
                        }

                        if ($null -eq $settings.permissions.sharepoint.delegated.update)
                        {
                            $settings.permissions.sharepoint.delegated | Add-Member -MemberType NoteProperty -Name 'update' -Value $value
                        }
                        else
                        {
                            $settings.permissions.sharepoint.delegated.update = $value
                        }
                    }

                    if ($null -eq $settings.permissions.sharepoint.application)
                    {
                        $settings.permissions.sharepoint | Add-Member -MemberType NoteProperty -Name 'application' -Value $value
                    }
                    else
                    {
                        $value = @(
                            [PSCustomObject]@{
                                name = 'Sites.FullControl.All'
                            }
                        )

                        if ($null -eq $settings.permissions.sharepoint.application.read)
                        {
                            $settings.permissions.sharepoint.application | Add-Member -MemberType NoteProperty -Name 'read' -Value $value
                        }
                        else
                        {
                            $settings.permissions.sharepoint.application.read = $value
                        }

                        if ($null -eq $settings.permissions.sharepoint.application.update)
                        {
                            $settings.permissions.sharepoint.application | Add-Member -MemberType NoteProperty -Name 'update' -Value $value
                        }
                        else
                        {
                            $settings.permissions.sharepoint.application.update = $value
                        }

                    }
                }
            }
        }
        else
        {
            Write-Verbose '    Creating new settings.json file'
            $settings = [PSCustomObject]@{
                resourceName = $file.BaseName -replace 'MSFT_'
                description  = ''
                permissions  = [PSCustomObject]@{
                    graph      = [PSCustomObject]@{
                        delegated   = [PSCustomObject]@{
                            read   = @()
                            update = @()
                        }
                        application = [PSCustomObject]@{
                            read   = @()
                            update = @()
                        }
                    }
                    sharepoint = [PSCustomObject]@{
                        delegated   = [PSCustomObject]@{
                            read   = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                            update = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                        }
                        application = [PSCustomObject]@{
                            read   = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                            update = @(
                                [PSCustomObject]@{
                                    name = 'Sites.FullControl.All'
                                }
                            )
                        }
                    }
                }
            }
        }
        $json = ConvertTo-Json -InputObject $settings -Depth 10
        Set-Content -Path $settingsFile -Value $json -Encoding UTF8
    }
}

<#
.Description
This function creates or updates an application in Azure AD. It assigns permissions,
grants consent and creates a secret or uploads a certificate to the application.

This application can then be used for Application Authentication.

The provided permissions have to be as an array of hashtables, with Api=Graph, SharePoint
or Exchange and PermissionsName set to a list of permissions. See examples for more information.

NOTE:
Please make sure you have the following permissions for the 'Microsoft Graph Command Line Tools'
Enterprise Application in your tenant:

- Application.ReadWrite.All

You can add this scope to the 'Microsoft Graph Command Line Tools' Enterprise Application by running
the following command:

```powershell
Connect-MgGraph -Scopes 'Application.ReadWrite.All'
```

NOTE:
If consent cannot be given for whatever reason, make sure all these permissions are
given Admin Consent by browsing to the App Registration in Azure AD > API Permissions
and clicking the "Grant admin consent for <orgname>" button.

More information:
Graph API permissions: https://docs.microsoft.com/en-us/graph/permissions-reference
Exchange permissions: https://docs.microsoft.com/en-us/exchange/permissions-exo/permissions-exo

Note:
If you want to configure App-Only permission for Exchange, as described here:
https://docs.microsoft.com/en-us/powershell/exchange/app-only-auth-powershell-v2?view=exchange-ps#step-2-assign-api-permissions-to-the-application
Using the following permission will achieve exactly that: @{Api='Exchange';PermissionsName='Exchange.ManageAsApp'}

Note 2:
If you want to configure App-Only permission for Security and compliance, please refer to this information on how to setup the permissions:
https://microsoft365dsc.com/user-guide/get-started/authentication-and-permissions/#security-and-compliance-center-permissions

Note 3:
If you want to configure App-Only permission for Power Platform, please refer to this information on how to setup the permissions:
https://microsoft365dsc.com/user-guide/get-started/authentication-and-permissions/#power-apps-permissions


.Parameter ApplicationName
The name of the application to create or update. Default value is 'Microsoft365DSC'.

.Parameter Permissions
The permissions to assign to the application. This has to be an array of hashtables, with Api=Graph, SharePoint or Exchange and PermissionsName set to a list of permissions. See examples for more information.

.Parameter Type
The type of credential to create. Default value is 'Secret'. Valid values are 'Secret' and 'Certificate'.

.Parameter MonthsValid
The number of months the certificate should be valid. Default value is 12.

.Parameter CreateNewSecret
If specified, a new secret will be created for the application. -CreateNewSecret or -CertificatePath can be used, not both.

.Parameter CertificatePath
The path to the certificate to be uploaded for the app registration. If using with -CreateSelfSignedCertificate - a file with this name will be created and uploaded (file must not exist). Otherwise the file must already exist. Cannot be used with -CreateNewSecret simultaneously.

.Parameter CreateSelfSignedCertificate
If specified, a self-signed certificate will be created for the application. -CreateSelfSignedCertificate or -CertificatePath can be used, not both.

.Parameter AdminConsent
If specified, admin consent will be granted for the application.

.Parameter Credential
The credential to use for authenticating the request. Mutually exclusive with -TenantId.

.Parameter ApplicationId
The ApplicationId to use for authenticating the request. -Credential or -ApplicationId can be used, not both.

.Parameter TenantId
The name of the tenant to use for the request. Must be in the form of contoso.onmicrosoft.com. Mutually exclusive with -Credential.

.Parameter ApplicationSecret
The ApplicationSecret to use for authenticating the request. -Credential or -ApplicationSecret can be used, not both.

.Parameter CertificateThumbprint
Thumbprint of an existing auth certificate to use for authenticating the request. Mutually exclusive with -Credential.

.Parameter ManagedIdentity
If specified, Managed Identity will be used for authenticating the request. -Credential or -ApplicationId or -ManagedIdentity can be used, only one of them.

.Example
Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='SharePoint';PermissionName='Sites.FullControl.All'}) -AdminConsent -Type Secret -Credential $creds

.EXAMPLE
Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='Graph';PermissionName='Domain.Read.All'}) -AdminConsent  -Credential $creds -Type Certificate -CreateSelfSignedCertificate -CertificatePath c:\Temp\M365DSC.cer

.EXAMPLE
Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='SharePoint';PermissionName='Sites.FullControl.All'},@{Api='Graph';PermissionName='Group.ReadWrite.All'},@{Api='Exchange';PermissionName='Exchange.ManageAsApp'}) -AdminConsent -Credential $creds -Type Certificate -CertificatePath c:\Temp\M365DSC.cer

.EXAMPLE
Update-M365DSCAzureAdApplication -ApplicationName $Microsoft365DSC -Permissions $(Get-M365DSCCompiledPermissionList -ResourceNameList (Get-M365DSCAllResources) -PermissionType Application -AccessType Read) -Type Certificate -CreateSelfSignedCertificate -AdminConsent -MonthsValid 12 -Credential $creds -CertificatePath c:\Temp\M365DSC.cer


.Functionality
Public
#>
function Update-M365DSCAzureAdApplication
{
    [CmdletBinding(DefaultParameterSetName = 'Secret')]
    param
    (
        [Parameter(ParameterSetName = 'Secret')]
        [Parameter(ParameterSetName = 'Certificate')]
        [System.String]
        $ApplicationName = 'Microsoft365DSC',

        [Parameter(Mandatory = $true, ParameterSetName = 'Secret')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Certificate')]
        [System.Collections.Hashtable[]]
        $Permissions,

        [Parameter(ParameterSetName = 'Secret')]
        [Parameter(ParameterSetName = 'Certificate')]
        [ValidateSet('Secret', 'Certificate')]
        [System.String]
        $Type = 'Secret',

        [Parameter(ParameterSetName = 'Secret')]
        [Parameter(ParameterSetName = 'Certificate')]
        [System.Int32]
        $MonthsValid = 12,

        [Parameter(ParameterSetName = 'Secret')]
        [Switch]
        $CreateNewSecret,

        [Parameter(ParameterSetName = 'Certificate')]
        [System.String]
        $CertificatePath,

        [Parameter(ParameterSetName = 'Certificate')]
        [Switch]
        $CreateSelfSignedCertificate,

        [Parameter(ParameterSetName = 'Secret')]
        [Parameter(ParameterSetName = 'Certificate')]
        [Switch]
        $AdminConsent,

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
    function Write-LogEntry
    {
        param
        (
            [Parameter(Mandatory = $true)]
            [System.String]
            $Message,

            [Parameter()]
            [ValidateSet('Error', 'Warning', 'Info')]
            [System.String]
            $Type = 'Info'
        )

        $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

        switch ($Type)
        {
            'Error'
            {
                $params = @{
                    Object          = ('{0} - [ERROR] {1}' -f $timestamp, $Message)
                    ForegroundColor = 'Red'
                }
            }
            'Warning'
            {
                $params = @{
                    Object          = ('{0} - [WARNING] {1}' -f $timestamp, $Message)
                    ForegroundColor = 'Yellow'
                }
            }
            'Info'
            {
                $params = @{
                    Object          = ('{0} - {1}' -f $timestamp, $Message)
                    ForegroundColor = 'White'
                }
            }
        }

        Write-Host @params
    }

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    $requireWait = $false
    Write-LogEntry -Message 'Checking specified parameters'
    switch ($Type)
    {
        'Secret'
        {
            Write-LogEntry -Message '  Using a Secret as credential'
        }
        'Certificate'
        {
            Write-LogEntry -Message '  Using a Certificate as credential'
            Write-LogEntry -Message ' '
            Write-LogEntry -Message '  Make sure your certificate has the following prerequisites:'
            Write-LogEntry -Message '    KeySpec           : Signature'
            Write-LogEntry -Message '    KeyLength         : 2048'
            Write-LogEntry -Message '    KeyAlgorithm      : RSA'
            Write-LogEntry -Message '    HashAlgorithm     : SHA256 or SHA1'
            Write-LogEntry -Message '    Enhanced Key Uses : Client Authentication and Server Authentication'
            Write-LogEntry -Message '    And the entire certificate chain is available!'
            Write-LogEntry -Message ' '

            if ($PSBoundParameters.ContainsKey('CertificatePath') -eq $false)
            {
                if ($PSBoundParameters.ContainsKey('CreateSelfSignedCertificate'))
                {
                    # CreateSelfSignedCertificate is specified, but CertificatePath is missing.
                    Write-LogEntry -Message 'You have to specify CertificatePath, when specifying the CreateSelfSignedCertificate parameter.' -Type Error
                    return
                }
                else
                {
                    # Neither CertificatePath and CreateSelfSignedCertificate are specified.
                    Write-LogEntry -Message 'Certificate is specified as Type, but neither the CertificatePath or CreateSelfSignedCertificate parameters are specified.' -Type Error
                    return
                }
            }
            else
            {
                if ($PSBoundParameters.ContainsKey('CreateSelfSignedCertificate'))
                {
                    # CreateSelfSignedCertificate is specified and path specified in CertificatePath already exists.
                    if ((Test-Path -Path $CertificatePath) -eq $true)
                    {
                        Write-LogEntry -Message "Specified CertificatePath '$CertificatePath', where the Self Signed Certificate should be exported, already exists." -Type Error
                        return
                    }
                }
                else
                {
                    # CreateSelfSignedCertificate is NOT specified and path specified in CertificatePath does not exists.
                    if ((Test-Path -Path $CertificatePath) -eq $false)
                    {
                        Write-LogEntry -Message "Specified CertificatePath '$CertificatePath' does not exist." -Type Error
                        return
                    }
                }
            }
        }
    }

    $resourceAppIdMsGraph = '00000003-0000-0000-c000-000000000000'
    $resourceAppIdSharePoint = '00000003-0000-0ff1-ce00-000000000000'
    $resourceAppIdExchange = '00000002-0000-0ff1-ce00-000000000000'

    $graphSvcprincipal = Get-MgServicePrincipal -Filter "AppId eq '$resourceAppIdMsGraph'"
    $spSvcprincipal = Get-MgServicePrincipal -Filter "AppId eq '$resourceAppIdSharePoint'"
    $exSvcprincipal = Get-MgServicePrincipal -Filter "AppId eq '$resourceAppIdExchange'"

    Write-LogEntry ' '
    Write-LogEntry 'Checking existance of AD Application'
    if (-not ($azureADApp = Get-MgApplication -Filter "DisplayName eq '$($ApplicationName)'" -ErrorAction SilentlyContinue))
    {
        $azureADApp = New-MgApplication -DisplayName $ApplicationName
        Write-LogEntry "  New Azure AD application '$ApplicationName' created!"
        $requireWait = $true
    }
    else
    {
        Write-LogEntry "  Application '$ApplicationName' already exists!"
    }

    if ($null -ne $azureADApp)
    {
        Write-LogEntry ' '
        Write-LogEntry 'Checking app permissions'
        $allRequiredAccess = @{}
        foreach ($permission in $Permissions)
        {
            if ($null -eq $permission.Api -or $permission.Api -notin @('Graph', 'SharePoint', 'Exchange'))
            {
                Write-LogEntry "Specified permission is invalid $(Convert-M365DscHashtableToString -Hashtable $permission)" -Type Warning
                continue
            }
            Write-LogEntry "  Checking permission '$($permission.Api)\$($permission.PermissionName)'"

            switch ($permission.Api)
            {
                'Graph'
                {
                    $svcprincipal = $graphSvcprincipal
                }
                'SharePoint'
                {
                    $svcprincipal = $spSvcprincipal
                }
                'Exchange'
                {
                    $svcprincipal = $exSvcprincipal
                }
            }

            $appRole = $azureADApp.AppRoles | Where-Object -FilterScript { $_.Value -eq $permission.PermissionName }

            if ($null -eq $appRole)
            {
                $currentAPIAccess = $allRequiredAccess.($svcprincipal.AppId)

                if ($null -eq $currentAPIAccess)
                {
                    $allRequiredAccess.Add(($svcprincipal.AppId), @())
                }
                $role = $svcPrincipal.AppRoles | Where-Object -FilterScript { $_.Value -eq $permission.PermissionName }
                if ($null -eq $role)
                {
                    $ObjectGuid = [System.Guid]::empty
                    if ([System.Guid]::TryParse($permission.PermissionName , [System.Management.Automation.PSReference]$ObjectGuid))
                    {
                        $appPermission = @{
                            Id   = $permission.PermissionName
                            Type = 'Role'
                        }
                    }
                    else
                    {
                        continue
                    }
                }
                else
                {
                    $appPermission = @{
                        Id   = $role.Id
                        Type = 'Role'
                    }
                }
                $allRequiredAccess.($svcprincipal.AppId) += $appPermission
            }
            else
            {
                Write-LogEntry "    Permission '$($permission.Api)\$($permission.PermissionName)' already added to the application!"
            }
        }

        $requiredResourceAccess = @()
        foreach ($provider in $allRequiredAccess.Keys)
        {
            $valueToAdd = @{
                ResourceAppId  = $provider
                ResourceAccess = @()
            }

            foreach ($permissionEntry in $allRequiredAccess.$provider)
            {
                $permissionToAdd = @{
                    Type = $permissionEntry.Type
                    Id   = $permissionEntry.Id
                }
                $valueToAdd.ResourceAccess += $permissionToAdd
            }
            $requiredResourceAccess += $valueToAdd
        }

        Update-MgApplication -ApplicationId ($azureADApp.Id) `
            -RequiredResourceAccess $requiredResourceAccess | Out-Null

        Write-LogEntry '    Permission updated for application'

        if ($AdminConsent)
        {
            if (-not $PSBoundParameters.ContainsKey('Credential'))
            {
                Write-LogEntry '[ERROR] You need to provide admin credentials when specifying the AdminConsent parameter.'
            }
            else
            {
                $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                    -InboundParameters $PSBoundParameters
                if ($requireWait)
                {
                    Write-LogEntry ' '
                    Write-LogEntry 'Waiting 10 seconds for application creation'
                    Write-LogEntry '  ...'
                    Start-Sleep -Seconds 10
                }

                Write-LogEntry ' '
                Write-LogEntry 'Providing Admin Consent for application permissions'
                $tenantid = $Credential.UserName.Split('@')[1]
                $username = $Credential.UserName
                $password = $Credential.GetNetworkCredential().password

                $uri = 'https://login.microsoftonline.com/{0}/oauth2/token' -f $tenantid
                $body = 'resource=74658136-14ec-4630-ad9b-26e160ff0fc6&client_id=1950a258-227b-4e31-a9cf-717495945fc2&grant_type=password&username={1}&password={0}' -f [System.Web.HttpUtility]::UrlEncode($password), $username
                $token = Invoke-RestMethod $uri `
                    -Method POST `
                    -Body $body `
                    -ContentType 'application/x-www-form-urlencoded' `
                    -ErrorAction SilentlyContinue

                $headers = @{
                    Authorization            = "Bearer $($token.access_token)"
                    'x-ms-client-request-id' = [guid]::NewGuid().ToString()
                    'x-ms-client-session-id' = [guid]::NewGuid().ToString()
                }

                $applicationId = $azureADApp.AppId
                $url = "https://main.iam.ad.ext.azure.com/api/RegisteredApplications/$applicationId/Consent?onBehalfOfAll=true"
                try
                {
                    $null = Invoke-RestMethod -Uri $url -Headers $headers -Method POST -ErrorAction Stop
                    Write-LogEntry '  Admin Consent for application permissions provided'
                }
                catch
                {
                    Write-LogEntry '[ERROR] Error while providing consent to the requested permissions. Please make sure you provide consent via the Azure AD Admin Portal.' -Type Error
                    Write-LogEntry "Error details: $($_.Exception.Message)"
                }
            }
        }

        Write-LogEntry ' '
        Write-LogEntry 'Checking app credentials'
        $endDate = (Get-Date).AddMonths($MonthsValid)
        switch ($Type)
        {
            'Secret'
            {
                # Filtering retrieved credentials for PasswordCredentials
                $passwordCreds = $azureADApp.PasswordCredentials

                $createSecret = $false
                if ($passwordCreds.Count -eq 0)
                {
                    Write-LogEntry '  No app credentials found, creating new'
                    Write-LogEntry '    Creating App Secret'
                    $createSecret = $true
                }
                else
                {
                    if ($CreateNewSecret)
                    {
                        Write-LogEntry '  Existing app credentials found, but CreateNewSecret specified. Creating new secret!'
                        $createSecret = $true
                    }
                    else
                    {
                        Write-LogEntry '  Existing app credentials found, but CreateNewSecret not specified. Please use an existing secret!'
                    }
                }

                if ($createSecret)
                {
                    $passwordCred = @{
                        displayName = 'Created by Microsoft365DSC'
                        endDateTime = $endDate
                    }
                    $appCred = Add-MgApplicationPassword -ApplicationId $azureADApp.Id -PasswordCredential $passwordCred
                }
            }
            'Certificate'
            {
                $createCertificate = $false

                # Filtering retrieved credentials for CertificateCredentials
                $certCreds = $azureADApp.KeyCredentials

                if (($PSBoundParameters.ContainsKey('CertificatePath') -and (-not $CreateSelfSignedCertificate)))
                {
                    $cerCert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList $CertificatePath
                }

                if ($certCreds.Count -eq 0)
                {
                    Write-LogEntry '  Uploading App Certificate'
                    $createCertificate = $true
                }
                else
                {
                    if ($PSBoundParameters.ContainsKey('CreateSelfSignedCertificate') -eq $false)
                    {
                        Write-LogEntry "  CertificatePath specified '$CertificatePath', using that certificate"
                        $certCred = $certCreds | Where-Object { $_.DisplayName -eq $cerCert.Subject -and $_.EndDateTime -eq $cerCert.NotAfter.ToUniversalTime() }
                        if ($null -eq $certCred)
                        {
                            Write-LogEntry '    Specified certificate does not exist in the app, uploading now'
                            $createCertificate = $true
                        }
                        else
                        {
                            Write-LogEntry '    Specified certificate already exists in the app, continuing'
                        }

                    }
                    else
                    {
                        Write-LogEntry 'Parameter CreateSelfSignedCertificate has been specified, but a Certificate has already been added to the application.' -Type Warning
                        Write-LogEntry 'Ignoring creating a new self signed certificate.' -Type Warning
                    }
                }

                if ($createCertificate)
                {
                    if ($CreateSelfSignedCertificate)
                    {
                        Write-LogEntry '    CreateSelfSignedCertificate specified, generating new Self Signed Certificate'
                        $cerCert = New-SelfSignedCertificate -CertStoreLocation 'Cert:\CurrentUser\My' `
                            -Subject "CN=$ApplicationName" `
                            -KeySpec Signature `
                            -NotAfter $endDate `
                            -KeyLength 2048 `
                            -KeyAlgorithm RSA `
                            -HashAlgorithm SHA256

                        $null = Export-Certificate -Cert $cerCert -Type CERT -FilePath $CertificatePath
                        Write-LogEntry "    Certificate exported to $CertificatePath"
                    }

                    Write-LogEntry "    Certificate details: $($cerCert.Subject) ($($cerCert.Thumbprint))"
                    $params = @{
                        Type        = 'AsymmetricX509Cert'
                        Usage       = 'Verify'
                        Key         = $cerCert.GetRawCertData()
                    }

                    $maxRetries = 3
                    $retryCount = 0
                    $retryDelay = 10 # seconds

                    do
                    {
                        try
                        {
                            $appCred = Update-MgApplication -ApplicationId $azureAdApp.Id -KeyCredentials $params -ErrorAction Stop
                            break # exit the loop if the operation succeeds
                        }
                        catch
                        {
                            if ($_.Exception.Message -match 'Key credential end date is invalid')
                            {
                                Write-Error $($_.Exception.Message) -ErrorAction Continue
                                if ($retryCount -lt $maxRetries)
                                {
                                    $retryCount++
                                    Write-Host "Retrying in $retryDelay seconds..."
                                    Start-Sleep -Seconds $retryDelay
                                }
                                else
                                {
                                    Write-Host 'Maximum number of retries reached.'
                                    throw # re-throw the exception if the maximum number of retries is reached
                                }
                            }
                            else
                            {
                                throw # re-throw the exception if it's not the expected error
                            }
                        }
                    } while ($true)
                }
            }
        }

        Write-LogEntry ' '
        Write-LogEntry "Application Id: $($azureADapp.AppId)"

        if ($null -ne $appCred)
        {
            Write-LogEntry "Secret        : $($appCred.SecretText)"
            Write-LogEntry ' '
            Write-LogEntry 'IMPORTANT: A new secret has been created. This is only displayed once: Make sure you store this information!'
        }

        Write-LogEntry ' '
        Write-LogEntry 'NOTE: Make sure you add the application to the required Microsoft 365 (e.g. Global Admin) or Exchange (e.g. Organization Management) role groups as well!'
        Write-LogEntry '      See the documentation for any required permissions.'
    }
}

Export-ModuleMember -Function @(
    'Get-M365DSCCompiledPermissionList',
    'Update-M365DSCAllowedGraphScopes',
    'Update-M365DSCAzureAdApplication',
    'Update-M365DSCExchangeResourcesSettingsJSON',
    'Update-M365DSCSharePointResourcesSettingsJSON',
    'Update-M365DSCResourcesSettingsJSON'
)
