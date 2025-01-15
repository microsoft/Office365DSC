function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $MailNickName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        $Description,

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
            Write-Verbose -Message "Setting configuration of Office 365 Group $DisplayName"
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

            Write-Verbose -Message "Retrieving AzureADGroup by MailNickName {$MailNickName}"
            [array]$ADGroup = Get-MgGroup -All:$true | Where-Object -FilterScript { $_.MailNickName -eq $MailNickName }
            if ($null -eq $ADGroup)
            {
                Write-Verbose -Message "Retrieving AzureADGroup by DisplayName {$DisplayName}"
                [array]$ADGroup = Get-MgGroup -All:$true | Where-Object -FilterScript { $_.DisplayName -eq $DisplayName }
                if ($null -eq $ADGroup)
                {
                    Write-Verbose -Message "Office 365 Group {$DisplayName} was not found."
                    return $nullReturn
                }
            }
            if ($ADGroup.Length -gt 1)
            {
                $Message = "Multiple O365 groups were found with DisplayName {$DisplayName}. Please specify the MailNickName parameter to uniquely identify the group."
                New-M365DSCLogEntry -Message $Message `
                    -Exception $_ `
                    -Source $MyInvocation.MyCommand.ModuleName
            }
            $ADGroup = $ADGroup[0]
        }
        else
        {
            $ADGroup = $Script:exportedInstance
        }
        Write-Verbose -Message "Found Existing Instance of Group {$($ADGroup.DisplayName)}"

        try
        {
            $membersList = Get-MgGroupMember -GroupId $ADGroup.Id
            Write-Verbose -Message "Found Members for Group {$($ADGroup.DisplayName)}"
            $owners = Get-MgGroupOwner -GroupId $ADGroup.Id
            Write-Verbose -Message "Found Owners for Group {$($ADGroup.DisplayName)}"
            $ownersUPN = @()
            if ($null -ne $owners)
            {
                # Need to cast as an array for the test to properly compare cases with
                # a single owner;
                $ownersUPN = [System.String[]]$owners.AdditionalProperties.userPrincipalName

                # Also need to remove the owners from the members list for Test
                # to handle the validation properly;
                $newMemberList = @()

                foreach ($member in $membersList)
                {
                    if ($null -ne $ownersUPN -and $ownersUPN.Length -ge 1 -and `
                            -not [System.String]::IsNullOrEmpty($member.AdditionalProperties.userPrincipalName) -and `
                            -not $ownersUPN.Contains($member.AdditionalProperties.sserPrincipalName))
                    {
                        $newMemberList += $member.AdditionalProperties.userPrincipalName
                    }
                }
            }

            $description = ''
            if ($null -ne $ADGroup.Description)
            {
                $description = $ADGroup.Description.ToString()
            }

            $returnValue = @{
                DisplayName           = $ADGroup.DisplayName
                MailNickName          = $ADGroup.MailNickName
                Members               = $newMemberList
                ManagedBy             = $ownersUPN
                Description           = $description
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                ApplicationSecret     = $ApplicationSecret
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                Ensure                = 'Present'
                AccessTokens          = $AccessTokens
            }
            return $returnValue
        }
        catch
        {
            $Message = "An error occured retrieving info for Group $DisplayName"
            New-M365DSCLogEntry -Message $Message `
                -Exception $_ `
                -Source $MyInvocation.MyCommand.ModuleName
        }
        return $nullReturn
    }
    catch
    {
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
        $MailNickName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        $Description,

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

    Write-Verbose -Message "Setting configuration of Office 365 Group $DisplayName"

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

    $currentGroup = Get-TargetResource @PSBoundParameters

    if ($Ensure -eq 'Present')
    {
        $CurrentParameters = $PSBoundParameters
        $CurrentParameters.Remove('Ensure') | Out-Null
        $CurrentParameters.Remove('Credential') | Out-Null
        $CurrentParameters.Remove('ApplicationId') | Out-Null
        $CurrentParameters.Remove('TenantId') | Out-Null
        $CurrentParameters.Remove('CertificateThumbprint') | Out-Null
        $CurrentParameters.Remove('ApplicationSecret') | Out-Null
        $CurrentParameters.Remove('ManagedIdentity') | Out-Null
        $CurrentParameters.Remove('AccessTokens') | Out-Null

        if ($currentGroup.Ensure -eq 'Absent')
        {
            Write-Verbose -Message "Creating Office 365 Group {$DisplayName}"
            $groupParams = @{
                DisplayName     = $DisplayName
                Description     = $Description
                MailEnabled     = $true
                SecurityEnabled = $true
            }

            if ('' -ne $MailNickName)
            {
                $groupParams.Add('mailNickName', $MailNickName)
            }
            Write-Verbose -Message 'Initiating Group Creation'
            Write-Verbose -Message "Owner = $($groupParams.Owners)"
            Write-Verbose -Message "Creating New Group with values: $(Convert-M365DscHashtableToString -Hashtable $groupParams)"
            New-MgGroup @groupParams -GroupTypes @('Unified')
            Write-Verbose -Message 'Group Created'
        }

        [array]$ADGroup = Get-MgGroup -All:$true | Where-Object -FilterScript { $_.MailNickName -eq $MailNickName }
        if ($null -eq $ADGroup)
        {
            Write-Verbose -Message "Retrieving AzureADGroup by DisplayName {$DisplayName}"
            [array]$ADGroup = Get-MgGroup -All:$true | Where-Object -FilterScript { $_.DisplayName -eq $DisplayName }
            if ($null -eq $ADGroup)
            {
                Write-Verbose -Message "Office 365 Group {$DisplayName} was not found."
                return $nullReturn
            }
            elseif ($ADGroup.Length -gt 1)
            {
                $Message = "Multiple O365 groups were found with DisplayName {$DisplayName}. Please specify the MailNickName parameter to uniquely identify the group."
                New-M365DSCLogEntry -Message $Message `
                    -Exception $_ `
                    -Source $MyInvocation.MyCommand.ModuleName
            }
        }
        Write-Verbose -Message "Found Existing Instance of Group {$($ADGroup.DisplayName)}"

        #region Members
        $membersList = Get-MgGroupMember -GroupId $ADGroup[0].Id

        $curMembers = @()
        foreach ($member in $membersList)
        {
            $curMembers += $member.AdditionalProperties.userPrincipalName
        }

        if ($null -ne $CurrentParameters.Members)
        {
            Write-Verbose -Message "Current Members: $($curMembers | Out-String)"
            Write-Verbose -Message "Desired Members: $($CurrentParameters.Members | Out-String)"
            $difference = Compare-Object -ReferenceObject $curMembers -DifferenceObject $CurrentParameters.Members

            if ($null -ne $difference.InputObject)
            {
                Write-Verbose -Message 'Detected a difference in the current list of members and the desired one'
                $membersToRemove = @()
                $membersToAdd = @()
                foreach ($diff in $difference)
                {
                    if (-not $ManagedBy.Contains($diff.InputObject))
                    {
                        if ($diff.SideIndicator -eq '<=' -and $diff.InputObject -ne $ManagedBy.Split('@')[0])
                        {
                            Write-Verbose "Will be removing Member: {$($diff.InputObject)}"
                            $membersToRemove += $diff.InputObject
                        }
                        elseif ($diff.SideIndicator -eq '=>')
                        {
                            Write-Verbose "Will be adding Member: {$($diff.InputObject)}"
                            $membersToAdd += $diff.InputObject
                        }
                    }
                }

                foreach ($member in $membersToAdd)
                {
                    Write-Verbose "Adding members {$member}"
                    $userId = (Get-MgUser -UserId $member).Id
                    New-MgGroupMember -GroupId $ADGroup[0].Id -DirectoryObjectId $userId
                }

                foreach ($member in $membersToRemove)
                {
                    Write-Verbose "Removing members {$member}"
                    $userId = (Get-MgUser -UserId $member).Id

                    # There are no cmldet to remove members from group available at the time of writing this resource (March 8th 2022)
                    $url = "$((Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl)v1.0/groups/$($ADGroup[0].Id)/members/$userId/`$ref"
                    Invoke-MgGraphRequest -Method DELETE -Uri $url | Out-Null
                }
            }
        }
        #endregion

        #region Owners
        $ownersList = Get-MgGroupOwner -GroupId $ADGroup[0].Id

        $curOwners = @()
        foreach ($owner in $ownersList)
        {
            $curOwners += $owner.AdditionalProperties.userPrincipalName
        }

        if ($null -ne $CurrentParameters.ManagedBy)
        {
            Write-Verbose -Message "Current Owners: $($curOwners | Out-String)"
            Write-Verbose -Message "Desired Owners: $($CurrentParameters.ManagedBy | Out-String)"
            $difference = Compare-Object -ReferenceObject $curOwners -DifferenceObject $CurrentParameters.ManagedBy

            if ($null -ne $difference.InputObject)
            {
                Write-Verbose -Message 'Detected a difference in the current list of members and the desired one'
                $ownersToRemove = @()
                $ownersToAdd = @()
                foreach ($diff in $difference)
                {
                    if ($diff.SideIndicator -eq '<=')
                    {
                        Write-Verbose "Will be removing Member: {$($diff.InputObject)}"
                        $ownersToRemove += $diff.InputObject
                    }
                    elseif ($diff.SideIndicator -eq '=>')
                    {
                        Write-Verbose "Will be adding Owner: {$($diff.InputObject)}"
                        $ownersToAdd += $diff.InputObject
                    }
                }

                foreach ($owner in $ownersToAdd)
                {
                    Write-Verbose -Message "Adding Owner {$owner}"
                    $userId = (Get-MgUser -UserId $owner).Id
                    $newGroupOwner = @{
                        '@odata.id' = "$((Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl)v1.0/users/{$userId}"
                    }

                    New-MgGroupOwnerByRef -GroupId $ADGroup[0].Id -BodyParameter $newGroupOwner
                }

                foreach ($owner in $ownersToRemove)
                {
                    Write-Verbose "Removing owner {$owner}"
                    $userId = (Get-MgUser -UserId $owner).Id

                    # There are no cmldet to remove members from group available at the time of writing this resource (March 8th 2022)
                    $url = "$((Get-MSCloudLoginConnectionProfile -Workload MicrosoftGraph).ResourceUrl)v1.0/groups/$($ADGroup[0].Id)/owners/$userId/`$ref"
                    Invoke-MgGraphRequest -Method DELETE -Uri $url | Out-Null
                }
            }
        }
        #endregion
    }
    elseif ($Ensure -eq 'Absent')
    {
        if ($ADGroup.Length -eq 1)
        {
            Write-Verbose -Message "Removing O365Group $($existingO365Group.Name)"
            Remove-MgGroup -GroupId $ADGroup[0].Id -Confirm:$false | Out-Null
        }
        else
        {
            Write-Verbose -Message "There was more than one group identified with the name $($currentGroup.MailNickName)."
            Write-Verbose -Message 'No action taken. Please remove the group manually.'
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
        $MailNickName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $ManagedBy,

        [Parameter()]
        [System.String]
        $Description,

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

    Write-Verbose -Message "Testing configuration of Office 365 Group $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters

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
        $dscContent = ''
        $ExportParameters = @{
            Filter      = $Filter
            All         = [switch]$true
            ErrorAction = 'Stop'
        }
        if ($Filter -like '*endsWith*')
        {
            $ExportParameters.Add('CountVariable', 'count')
            $ExportParameters.Add('ConsistencyLevel', 'eventual')
        }
        $groups = Get-MgGroup @ExportParameters | Where-Object -FilterScript {
            $_.MailNickName -ne '00000000-0000-0000-0000-000000000000'
        }

        $i = 1
        Write-Host "`r`n" -NoNewline
        foreach ($group in $groups)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($groups.Length)] $($group.DisplayName)" -NoNewline
            $Params = @{
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                ApplicationSecret     = $ApplicationSecret
                DisplayName           = $group.DisplayName
                ManagedBy             = 'DummyUser'
                MailNickName          = $group.MailNickName
                AccessTokens          = $AccessTokens
            }
            $Script:exportedInstance = $group
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

Export-ModuleMember -Function *-TargetResource
