function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Url,

        [Parameter()]
        [System.String]
        $Title,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $LogoUrl,

        [Parameter()]
        [System.Boolean]
        $RequiresJoinApproval,

        [Parameter()]
        [System.String[]]
        $AllowedToJoin,

        [Parameter()]
        [System.String]
        $SiteDesignId,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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
            Write-Verbose -Message "Getting configuration for hub site collection $Url"

            $ConnectionModeGraph = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                -InboundParameters $PSBoundParameters

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

            Write-Verbose -Message "Getting hub site collection $Url"
            $site = Get-PnPTenantSite -Identity $Url -ErrorAction SilentlyContinue
            if ($null -eq $site)
            {
                Write-Verbose -Message "The specified Site Collection doesn't already exist."
                return $nullReturn
            }

            if ($site.IsHubSite -eq $false)
            {
                Write-Verbose -Message "The specified Site Collection isn't a hub site."
                return $nullReturn
            }
        }
        else
        {
            $hubSite = $Script:exportedInstance
        }

        $hubSite = Get-PnPHubSite -Identity $Url
        $principals = @()
        foreach ($permission in $hubSite.Permissions.PrincipalName)
        {
            $result = $permission.Split('|')
            if ($result[0].StartsWith('c') -eq $true)
            {
                # Group permissions
                $group = Get-MgGroup -GroupId $result[2]

                if ($null -eq $group.EmailAddress)
                {
                    $principal = $group.DisplayName
                }
                else
                {
                    $principal = $group.EmailAddress
                }
                $principals += $principal
            }
            else
            {
                # User permissions
                $principals += $result[2]
            }
        }

        if ($LogoUrl.StartsWith('http'))
        {
            $configuredLogo = $hubSite.LogoUrl
        }
        else
        {
            $configuredLogo = ([System.Uri]$hubSite.LogoUrl).AbsolutePath
        }

        $result = @{
            Url                   = $Url
            Title                 = $hubSite.Title
            Description           = $hubSite.Description
            LogoUrl               = $configuredLogo
            RequiresJoinApproval  = $hubSite.RequiresJoinApproval
            AllowedToJoin         = $principals
            SiteDesignId          = $hubSite.SiteDesignId
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
            Managedidentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        return $result
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
        $Url,

        [Parameter()]
        [System.String]
        $Title,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $LogoUrl,

        [Parameter()]
        [System.Boolean]
        $RequiresJoinApproval,

        [Parameter()]
        [System.String[]]
        $AllowedToJoin,

        [Parameter()]
        [System.String]
        $SiteDesignId,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Setting configuration for hub site collection $Url"

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

    $ConnectionModeGraph = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    $ConnectionMode = New-M365DSCConnection -Workload 'PnP' `
        -InboundParameters $PSBoundParameters

    try
    {
        Write-Verbose -Message "Setting hub site collection $Url"
        $site = Get-PnPTenantSite $Url
    }
    catch
    {
        $Message = "The specified Site Collection {$Url} for SPOHubSite doesn't already exist."
        New-M365DSCLogEntry -Message $Message `
            -Exception $_ `
            -Source $MyInvocation.MyCommand.ModuleName
        throw $Message
    }

    $currentValues = Get-TargetResource @PSBoundParameters

    if ($Ensure -eq 'Present' -and $currentValues.Ensure -eq 'Absent')
    {
        Write-Verbose -Message 'Configuring site collection as Hub Site'
        Register-PnPHubSite -Site $site.Url | Out-Null

        $params = @{
            Identity = $site.Url
        }

        if ($PSBoundParameters.ContainsKey('Title') -eq $true)
        {
            $params.Title = $Title
        }

        if ($PSBoundParameters.ContainsKey('Description') -eq $true)
        {
            $params.Description = $Description
        }

        if ($PSBoundParameters.ContainsKey('LogoUrl') -eq $true)
        {
            $params.LogoUrl = $LogoUrl
        }

        if ($PSBoundParameters.ContainsKey('RequiresJoinApproval') -eq $true)
        {
            $params.RequiresJoinApproval = $RequiresJoinApproval
        }

        if ($PSBoundParameters.ContainsKey('SiteDesignId') -eq $true)
        {
            $params.SiteDesignId = $SiteDesignId
        }

        if ($params.Count -ne 1)
        {
            Write-Verbose -Message 'Updating Hub Site properties'
            Set-PnPHubSite @params | Out-Null
        }

        if ($PSBoundParameters.ContainsKey('AllowedToJoin') -eq $true)
        {
            $groups = Get-MgGroup -All:$true
            $regex = "^[a-zA-Z0-9.!£#$%&'^_`{}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"

            Write-Verbose -Message 'Validating AllowedToJoin principals'
            foreach ($principal in $AllowedToJoin)
            {
                Write-Verbose -Message "Processing $principal"
                if ($principal -notmatch $regex)
                {
                    $group = $groups | Where-Object -FilterScript {
                        $_.DisplayName -eq $principal
                    }

                    if ($group.Count -ne 1)
                    {
                        throw "Error for principal $principal. Number of occurences: $($group.Count)"
                    }
                }
            }
            Grant-PnPHubSiteRights -Identity $site.Url `
                -Principals $AllowedToJoin | Out-Null
        }
    }
    elseif ($Ensure -eq 'Present' -and $currentValues.Ensure -eq 'Present')
    {
        Write-Verbose -Message 'Updating Hub Site settings'
        $params = @{
            Identity = $site.Url
        }

        if ($PSBoundParameters.ContainsKey('Title') -eq $true -and
            $currentValues.Title -ne $Title)
        {
            $params.Title = $Title
        }

        if ($PSBoundParameters.ContainsKey('Description') -eq $true -and
            $currentValues.Description -ne $Description)
        {
            $params.Description = $Description
        }

        if ($PSBoundParameters.ContainsKey('LogoUrl') -eq $true -and
            $currentValues.LogoUrl -ne $LogoUrl)
        {
            $params.LogoUrl = $LogoUrl
        }

        if ($PSBoundParameters.ContainsKey('RequiresJoinApproval') -eq $true -and
            $currentValues.RequiresJoinApproval -ne $RequiresJoinApproval)
        {
            $params.RequiresJoinApproval = $RequiresJoinApproval
        }

        if ($PSBoundParameters.ContainsKey('SiteDesignId') -eq $true -and
            $currentValues.SiteDesignId -ne $SiteDesignId)
        {
            $params.SiteDesignId = $SiteDesignId
        }

        if ($params.Count -ne 1)
        {
            Write-Verbose -Message 'Updating Hub Site properties'
            Set-PnPHubSite @params | Out-Null
        }

        if ($PSBoundParameters.ContainsKey('AllowedToJoin') -eq $true)
        {
            if ($null -eq $currentValues.AllowedToJoin)
            {
                $differences = Compare-Object -ReferenceObject $AllowedToJoin -DifferenceObject @()
            }
            else
            {
                $differences = Compare-Object -ReferenceObject $AllowedToJoin -DifferenceObject $currentValues.AllowedToJoin
            }

            if ($null -ne $differences)
            {
                $groups = Get-MgGroup -All:$true
                $regex = "^[a-zA-Z0-9.!£#$%&'^_`{}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"

                Write-Verbose -Message 'Updating Hub Site permissions'
                foreach ($item in $differences)
                {
                    if ($item.SideIndicator -eq '<=')
                    {
                        Write-Verbose -Message 'Validating AllowedToJoin principals'
                        foreach ($principal in $AllowedToJoin)
                        {
                            Write-Verbose -Message "Processing $principal"
                            if ($principal -notmatch $regex)
                            {
                                $group = $groups | Where-Object -FilterScript {
                                    $_.DisplayName -eq $principal
                                }

                                if ($group.Count -ne 1)
                                {
                                    throw "Error for principal $principal. Number of occurences: $($group.Count)"
                                }
                            }
                        }
                        Grant-PnPHubSiteRights -Identity $site.Url `
                            -Principals $item.InputObject | Out-Null
                    }
                    else
                    {
                        # Remove item from principals
                        Grant-PnPHubSiteRights -Identity $site.Url `
                            -Principals $item.InputObject | Out-Null
                    }
                }
            }
        }
    }
    else
    {
        # Remove hub site
        Unregister-PnPHubSite -Site $site.Url
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
        $Url,

        [Parameter()]
        [System.String]
        $Title,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $LogoUrl,

        [Parameter()]
        [System.Boolean]
        $RequiresJoinApproval,

        [Parameter()]
        [System.String[]]
        $AllowedToJoin,

        [Parameter()]
        [System.String]
        $SiteDesignId,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message "Testing configuration for hub site collection $Url"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @('Ensure', `
            'Url', `
            'Title', `
            'Description', `
            'LogoUrl', `
            'RequiresJoinApproval', `
            'AllowedToJoin', `
            'SiteDesignId')

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
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
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

        [array]$hubSites = Get-PnPHubSite -ErrorAction Stop

        $i = 1
        if ($hubSites.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }

        $principal = '' # Principal represents the "NetBios" name of the tenant (e.g. the M365DSC part of M365DSC.onmicrosoft.com)
        if ($null -ne $Credential -and $Credential.UserName.Contains('@'))
        {
            $organization = $Credential.UserName.Split('@')[1]

            if ($organization.IndexOf('.') -gt 0)
            {
                $principal = $organization.Split('.')[0]
            }
        }
        else
        {
            $organization = $TenantId
            $principal = $organization.Split('.')[0]
        }

        $dscContent = ''
        foreach ($hub in $hubSites)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    [$i/$($hubSites.Length)] $($hub.SiteUrl)" -NoNewline

            $Params = @{
                Url                   = $hub.SiteUrl
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity       = $ManagedIdentity.IsPresent
                Credential            = $Credential
                CertificatePassword   = $CertificatePassword
                CertificatePath       = $CertificatePath
                ApplicationSecret     = $ApplicationSecret
                AccessTokens          = $AccessTokens
            }

            $Script:exportedInstance = $hub
            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            # Make the Url parameterized
            if ($currentDSCBlock.ToLower().Contains($organization.ToLower()) -or `
                    $currentDSCBlock.ToLower().Contains($principal.ToLower()))
            {
                $currentDSCBlock = $currentDSCBlock -ireplace [regex]::Escape('https://' + $principal + '.sharepoint.com/'), "https://`$(`$OrganizationName.Split('.')[0]).sharepoint.com/"
                $currentDSCBlock = $currentDSCBlock -ireplace [regex]::Escape('@' + $organization), "@`$(`$OrganizationName)"
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

Export-ModuleMember -Function *-TargetResource
