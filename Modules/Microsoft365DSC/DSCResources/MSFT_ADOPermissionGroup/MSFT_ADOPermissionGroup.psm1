function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $OrganizationName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter()]
        [System.String]
        $Descriptor,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [ValidateSet('Project', 'Organization')]
        [System.String]
        $Level,

        [Parameter()]
        [System.String[]]
        $Members,

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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'AzureDevOPS' `
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
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            if (-not [System.String]::IsNullOrEmpty($Descriptor))
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.descriptor -eq $Descriptor}
            }

            if ($null -eq $instance)
            {
                $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.principalName -eq $PrincipalName}
            }
        }
        else
        {
            $uri = "https://vssps.dev.azure.com/$OrganizationName/_apis/graph/groups?api-version=7.1-preview.1"
            $allInstances = (Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri).value
            if (-not [System.String]::IsNullOrEmpty($Descriptor))
            {
                $instance = $allInstances | Where-Object -FilterScript {$_.descriptor -eq $Descriptor}
            }
            if ($null -eq $instance)
            {
                $instance = $allInstances | Where-Object -FilterScript {$_.principalName -eq $PrincipalName}
            }
        }
        if ($null -eq $instance)
        {
            return $nullResult
        }

        # Level
        $LevelValue = 'Project'
        if ($instance.domain.StartsWith('vstfs:///Framework/IdentityDomain/'))
        {
            $LevelValue = 'Organization'
        }

        # Membership
        $MembersValue = @()
        $uri = "https://vsaex.dev.azure.com/$($OrganizationName)/_apis/GroupEntitlements/$($instance.originId)/members?api-version=7.1"
        $membership = (Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri).members

        foreach ($member in $membership)
        {
            $MembersValue += $member.user.principalName
        }

        $results = @{
            OrganizationName      = $OrganizationName
            PrincipalName         = $instance.principalName
            Description           = $instance.description
            DisplayName           = $instance.displayName
            Descriptor            = $instance.descriptor
            Level                 = $LevelValue
            Id                    = $instance.originId
            Members               = $MembersValue
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        return [System.Collections.Hashtable] $results
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
        [Parameter(Mandatory = $true)]
        [System.String]
        $OrganizationName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Descriptor,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [ValidateSet('Project', 'Organization')]
        [System.String]
        $Level,

        [Parameter()]
        [System.String[]]
        $Members,

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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    New-M365DSCConnection -Workload 'AzureDevOPS' `
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

    $currentInstance = Get-TargetResource @PSBoundParameters

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        $newGroup = $null
        if ($Level -eq 'Organization')
        {
            $uri = "https://vssps.dev.azure.com/$OrganizationName/_apis/graph/groups?api-version=7.1-preview.1"
            $body = '{"displayName": "' + $DisplayName + '","description": "' + $Description + '"}'
            $newGroup = Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri -Method POST -Body $body -ContentType 'application/json'
        }
        elseif ($Level -eq 'Project')
        {
            $projectName = $PrincipalName.Split(']')[0]
            $projectName = $projectName.Substring(1, $projectName.Length -1)
            $uri = "https://dev.azure.com/$($OrganizationName)/_apis/projects/$($ProjectName)?api-version=7.1"
            $response = Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri
            $projectId = $response.id

            $uri = "https://vssps.dev.azure.com/$($OrganizationName)/_apis/graph/descriptors/$($projectId)?api-version=7.1-preview.1"
            $response = Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri
            $scope = $response.value

            $uri = "https://vssps.dev.azure.com/$($OrganizationName)/_apis/graph/groups?scopeDescriptor=$($scope)&api-version=7.1-preview.1"
            $body = '{"displayName": "' + $DisplayName + '","description": "' + $Description + '"}'
            $newGroup = Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri -Method POST -Body $body -ContentType 'application/json'
        }

        Write-Host "NEWGROUP::: $($newGroup | fl * | Out-String)"
        foreach ($member in $Members)
        {
            Write-Verbose -Message "Adding Member {$member} to group ${$PrincipalName}"
            Set-M365DSCADOPermissionGroupMember -OrganizationName $OrganizationName `
                                                -GroupId $newGroup.originId `
                                                -PrincipalName $member
        }
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        if ($Description -ne $currentInstance.Description)
        {
            Write-Verbose -Message "Updating group {$PrincipalName} description to {$Description}"
            $uri = "https://vssps.dev.azure.com/$($OrganizationName)/_apis/graph/groups/$($currentInstance.Descriptor)?api-version=7.1-preview.1"
            $body = '[{"op": "replace", "path": "/description", "from": null, "value": "' + $Description + '"}]'
        }

        $membershipChanges = Compare-Object -ReferenceObject $currentInstance.Members -DifferenceObject $Members
        foreach ($diff in $membershipChanges)
        {
            if ($diff.SideIndicator -eq '=>')
            {
                Write-Verbose -Message "Adding Member {$($diff.InputObject)} to group ${$PrincipalName}"
                Set-M365DSCADOPermissionGroupMember -OrganizationName $OrganizationName `
                                                    -GroupId $currentInstance.Id `
                                                    -PrincipalName $diff.InputObject `
                                                    -Method 'PUT'
            }
            else
            {
                Write-Verbose -Message "Removing Member {$($diff.InputObject)} to group ${$PrincipalName}"
                Set-M365DSCADOPermissionGroupMember -OrganizationName $OrganizationName `
                                                    -GroupId $currentInstance.Id `
                                                    -PrincipalName $diff.InputObject `
                                                    -Method 'DELETE'
            }
        }
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing group {$principalName} with Descriptor {$($currentInstance.Descriptor)}"
        $uri = "https://vssps.dev.azure.com/$($OrganizationName)/_apis/graph/groups/$($currentInstance.Descriptor)?api-version=7.1-preview.1"
        Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri -Method 'DELETE' -ContentType 'application/json' | Out-Null
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
        $OrganizationName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Descriptor,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [ValidateSet('Project', 'Organization')]
        [System.String]
        $Level,

        [Parameter()]
        [System.String[]]
        $Members,

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
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'AzureDevOPS' `
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

        $profileValue = Invoke-M365DSCAzureDevOPSWebRequest -Uri 'https://app.vssps.visualstudio.com/_apis/profile/profiles/me?api-version=5.1'
        $accounts = Invoke-M365DSCAzureDevOPSWebRequest -Uri "https://app.vssps.visualstudio.com/_apis/accounts?api-version=7.1-preview.1&memberId=$($profileValue.id)"

        $i = 1
        $dscContent = ''
        if ($accounts.count -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
            return ''
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($account in $accounts)
        {
            $organization = $account.Value.accountName
            $uri = "https://vssps.dev.azure.com/$organization/_apis/graph/groups?api-version=7.1-preview.1"

            [array] $Script:exportedInstances = (Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri).Value

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
                $displayedKey = $config.principalName
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }
                Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
                $params = @{
                    OrganizationName      = $Organization
                    PrincipalName         = $config.principalName
                    Descriptor            = $config.descriptor
                    Credential            = $Credential
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    ManagedIdentity       = $ManagedIdentity.IsPresent
                    AccessTokens          = $AccessTokens
                }

                if (-not $config.principalName.StartsWith("[TEAM FOUNDATION]"))
                {
                    $Results = Get-TargetResource @Params
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
                }
                $i++
                Write-Host $Global:M365DSCEmojiGreenCheckMark
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

function Set-M365DSCADOPermissionGroupMember
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $OrganizationName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $GroupId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $PrincipalName,

        [Parameter()]
        [System.String]
        $Method = 'Put'
    )
    if ($null -eq $Script:allUsers)
    {
        $uri = "https://vsaex.dev.azure.com/$($OrganizationName)/_apis/userentitlements?api-version=7.2-preview.4"
        $Script:allUsers = Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri
    }
    $user = $Script:allUsers.items | Where-Object -FilterScript {$_.user.principalName -eq $PrincipalName}
    $UserId = $user.id
    $uri = "https://vsaex.dev.azure.com/$($OrganizationName)/_apis/GroupEntitlements/$($GroupId)/members/$($UserId)?api-version=5.0-preview.1"
    Invoke-M365DSCAzureDevOPSWebRequest -Uri $uri -Method $Method | Out-Null
}

Export-ModuleMember -Function *-TargetResource
