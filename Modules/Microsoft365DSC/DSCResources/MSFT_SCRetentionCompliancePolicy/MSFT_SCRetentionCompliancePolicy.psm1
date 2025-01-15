function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $DynamicScopeLocation,

        [Parameter()]
        [System.Boolean]
        $Enabled = $true,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation = @(),

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException = @(),

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation = @(),

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException = @(),

        [Parameter()]
        [System.String[]]
        $OneDriveLocation = @(),

        [Parameter()]
        [System.String[]]
        $OneDriveLocationException = @(),

        [Parameter()]
        [System.String[]]
        $PublicFolderLocation = @(),

        [Parameter()]
        [System.Boolean]
        $RestrictiveRetention = $true,

        [Parameter()]
        [System.String[]]
        $SharePointLocation = @(),

        [Parameter()]
        [System.String[]]
        $SharePointLocationException = @(),

        [Parameter()]
        [System.String[]]
        $SkypeLocation = @(),

        [Parameter()]
        [System.String[]]
        $SkypeLocationException = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocation = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocationException = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChatLocation = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChatLocationException = @(),

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
        if (-not $Script:exportedInstance)
        {
            Write-Verbose -Message "Getting configuration of RetentionCompliancePolicy for $Name"

            $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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

            $PolicyObject = Get-RetentionCompliancePolicy $Name -DistributionDetail -ErrorAction SilentlyContinue

            if ($null -eq $PolicyObject)
            {
                Write-Verbose -Message "RetentionCompliancePolicy $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $PolicyObject = $Script:exportedInstance
        }

        Write-Verbose "Found existing RetentionCompliancePolicy $($Name)"

        if ($PolicyObject.TeamsPolicy)
        {
            $result = @{
                Ensure                        = 'Present'
                Name                          = $PolicyObject.Name
                Comment                       = $PolicyObject.Comment
                Enabled                       = $PolicyObject.Enabled
                RestrictiveRetention          = $PolicyObject.RestrictiveRetention
                TeamsChannelLocation          = @()
                TeamsChannelLocationException = @()
                TeamsChatLocation             = @()
                TeamsChatLocationException    = @()
                Credential                    = $Credential
                ApplicationId                 = $ApplicationId
                TenantId                      = $TenantId
                CertificateThumbprint         = $CertificateThumbprint
                CertificatePath               = $CertificatePath
                CertificatePassword           = $CertificatePassword
                AccessTokens                  = $AccessTokens
            }

            if ($PolicyObject.TeamsChannelLocation.Count -gt 0)
            {
                $result.TeamsChannelLocation = [array]$PolicyObject.TeamsChannelLocation.Name
            }
            if ($PolicyObject.TeamsChatLocation.Count -gt 0)
            {
                $result.TeamsChatLocation = [array]$PolicyObject.TeamsChatLocation.Name
            }
            if ($PolicyObject.TeamsChannelLocationException.Count -gt 0)
            {
                $result.TeamsChannelLocationException = [array]$PolicyObject.TeamsChannelLocationException.Name
            }
            if ($PolicyObject.TeamsChatLocationException.Count -gt 0)
            {
                $result.TeamsChatLocationException = $PolicyObject.TeamsChatLocationException.Name
            }
        }
        else
        {
            $result = @{
                Ensure                       = 'Present'
                Name                         = $PolicyObject.Name
                Comment                      = $PolicyObject.Comment
                DynamicScopeLocation         = @()
                Enabled                      = $PolicyObject.Enabled
                ExchangeLocation             = @()
                ExchangeLocationException    = @()
                ModernGroupLocation          = @()
                ModernGroupLocationException = @()
                OneDriveLocation             = @()
                OneDriveLocationException    = @()
                PublicFolderLocation         = @()
                RestrictiveRetention         = $PolicyObject.RestrictiveRetention
                SharePointLocation           = @()
                SharePointLocationException  = @()
                SkypeLocation                = @()
                SkypeLocationException       = @()
                Credential                   = $Credential
                ApplicationId                = $ApplicationId
                TenantId                     = $TenantId
                CertificateThumbprint        = $CertificateThumbprint
                CertificatePath              = $CertificatePath
                CertificatePassword          = $CertificatePassword
                AccessTokens                 = $AccessTokens
            }

            if ($PolicyObject.DynamicScopeLocation.Count -gt 0)
            {
                $result.DynamicScopeLocation = [array]$PolicyObject.DynamicScopeLocation.Name
            }
            if ($PolicyObject.ExchangeLocation.Count -gt 0)
            {
                $result.ExchangeLocation = [array]$PolicyObject.ExchangeLocation.Name
            }
            if ($PolicyObject.ModernGroupLocation.Count -gt 0)
            {
                $result.ModernGroupLocation = [array]$PolicyObject.ModernGroupLocation.Name
            }
            if ($PolicyObject.OneDriveLocation.Count -gt 0)
            {
                $result.OneDriveLocation = [array]$PolicyObject.OneDriveLocation.Name
            }
            if ($PolicyObject.PublicFolderLocation.Count -gt 0)
            {
                $result.PublicFolderLocation = [array]$PolicyObject.PublicFolderLocation.Name
            }
            if ($PolicyObject.SharePointLocation.Count -gt 0)
            {
                $result.SharePointLocation = [array]$PolicyObject.SharePointLocation.Name
            }
            if ($PolicyObject.SkypeLocation.Count -gt 0)
            {
                $result.SkypeLocation = [array]$PolicyObject.SkypeLocation.Name
            }
            if ($PolicyObject.ExchangeLocationException.Count -gt 0)
            {
                $result.ExchangeLocationException = [array]$PolicyObject.ExchangeLocationException.Name
            }
            if ($PolicyObject.ModernGroupLocationException.Count -gt 0)
            {
                $result.ModernGroupLocationException = [array]$PolicyObject.ModernGroupLocationException.Name
            }
            if ($PolicyObject.OneDriveLocationException.Count -gt 0)
            {
                $result.OneDriveLocationException = [array]$PolicyObject.OneDriveLocationException.Name
            }
            if ($PolicyObject.SharePointLocationException.Count -gt 0)
            {
                $result.SharePointLocationException = [array]$PolicyObject.SharePointLocationException.Name
            }
            if ($PolicyObject.SkypeLocationException.Count -gt 0)
            {
                $result.SkypeLocationException = [array]$PolicyObject.SkypeLocationException.Name
            }
        }

        Write-Verbose -Message "Found RetentionCompliancePolicy $($Name)"
        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
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
        $Name,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $DynamicScopeLocation,

        [Parameter()]
        [System.Boolean]
        $Enabled = $true,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation,

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation,

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException,

        [Parameter()]
        [System.String[]]
        $OneDriveLocation,

        [Parameter()]
        [System.String[]]
        $OneDriveLocationException,

        [Parameter()]
        [System.String[]]
        $PublicFolderLocation,

        [Parameter()]
        [System.Boolean]
        $RestrictiveRetention = $true,

        [Parameter()]
        [System.String[]]
        $SharePointLocation,

        [Parameter()]
        [System.String[]]
        $SharePointLocationException,

        [Parameter()]
        [System.String[]]
        $SkypeLocation,

        [Parameter()]
        [System.String[]]
        $SkypeLocationException,

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocation,

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocationException,

        [Parameter()]
        [System.String[]]
        $TeamsChatLocation,

        [Parameter()]
        [System.String[]]
        $TeamsChatLocationException,

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    if ($null -eq $SharePointLocation -and $null -eq $ExchangeLocation -and $null -eq $OneDriveLocation -and `
            $null -eq $SkypeLocation -and $null -eq $PublicFolderLocation -and $null -eq $ModernGroupLocation -and `
            $null -eq $TeamsChannelLocation -and $null -eq $TeamsChatLocation -and $Ensure -eq 'Present')
    {
        throw 'You need to specify at least one Location for this Policy.'
    }

    if ($null -ne $SkypeLocation -and $SkypeLocation -eq 'all')
    {
        throw 'Skype Location must be a any value that uniquely identifies the user.Ex Name, email address, GUID'
    }

    Write-Verbose -Message "Setting configuration of RetentionCompliancePolicy for $Name"

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

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters

    $CurrentPolicy = Get-TargetResource @PSBoundParameters

    $isTeamsBased = $false
    if ($null -eq $TeamsChannelLocation -and $null -eq $TeamsChatLocation)
    {
        $CreationParams = $PSBoundParameters
        $CreationParams.Remove('Ensure')
        $CreationParams.Remove('Name')
        $CreationParams.Add('Identity', $Name)
        $CreationParams.Remove('TeamsChannelLocation')
        $CreationParams.Remove('TeamsChannelLocationException')
        $CreationParams.Remove('TeamsChatLocation')
        $CreationParams.Remove('TeamsChatLocationException')
        $CreationParams.Remove('DynamicScopeLocation')

        # Remove authentication parameters
        $CreationParams.Remove('Credential') | Out-Null
        $CreationParams.Remove('ApplicationId') | Out-Null
        $CreationParams.Remove('TenantId') | Out-Null
        $CreationParams.Remove('CertificatePath') | Out-Null
        $CreationParams.Remove('CertificatePassword') | Out-Null
        $CreationParams.Remove('CertificateThumbprint') | Out-Null
        $CreationParams.Remove('ManagedIdentity') | Out-Null
        $CreationParams.Remove('ApplicationSecret') | Out-Null
        $CreationParams.Remove('AccessTokens') | Out-Null

        if ($CurrentPolicy.Ensure -eq 'Present')
        {
            # Exchange Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.ExchangeLocation -or `
                    $null -ne $ExchangeLocation)
            {
                $ToBeRemoved = $CurrentPolicy.ExchangeLocation | `
                        Where-Object { $ExchangeLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveExchangeLocation', $ToBeRemoved)
                }

                $ToBeAdded = $ExchangeLocation | `
                        Where-Object { $CurrentPolicy.ExchangeLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddExchangeLocation', $ToBeAdded)
                }

                $CreationParams.Remove('ExchangeLocation')
            }

            # Exchange Location Exception is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.ExchangeLocationException -or `
                    $null -ne $ExchangeLocationException)
            {
                $ToBeRemoved = $CurrentPolicy.ExchangeLocationException | `
                        Where-Object { $ExchangeLocationException -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveExchangeLocationException', $ToBeRemoved)
                }

                $ToBeAdded = $ExchangeLocationException | `
                        Where-Object { $CurrentPolicy.ExchangeLocationException -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddExchangeLocationException', $ToBeAdded)
                }
                $CreationParams.Remove('ExchangeLocationException')
            }

            # Modern Group Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.ModernGroupLocation -or `
                    $null -ne $ModernGroupLocation)
            {
                $ToBeRemoved = $CurrentPolicy.ModernGroupLocation | `
                        Where-Object { $ModernGroupLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveModernGroupLocation', $ToBeRemoved)
                }

                $ToBeAdded = $ModernGroupLocation | `
                        Where-Object { $CurrentPolicy.ModernGroupLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddModernGroupLocation', $ToBeAdded)
                }
                $CreationParams.Remove('ModernGroupLocation')
            }

            # Modern Group Location Exception is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.ModernGroupLocationException -or `
                    $null -ne $ModernGroupLocationException)
            {
                $ToBeRemoved = $CurrentPolicy.ModernGroupLocationException | `
                        Where-Object { $ModernGroupLocationException -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveModernGroupLocationException', $ToBeRemoved)
                }

                $ToBeAdded = $ModernGroupLocationException | `
                        Where-Object { $CurrentPolicy.ModernGroupLocationException -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddModernGroupLocationException', $ToBeAdded)
                }
                $CreationParams.Remove('ModernGroupLocationException')
            }

            # OneDrive Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.OneDriveLocation -or `
                    $null -ne $OneDriveLocation)
            {
                $ToBeRemoved = $CurrentPolicy.OneDriveLocation | `
                        Where-Object { $OneDriveLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveOneDriveLocation', $ToBeRemoved)
                }

                $ToBeAdded = $OneDriveLocation | `
                        Where-Object { $CurrentPolicy.OneDriveLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddOneDriveLocation', $ToBeAdded)
                }
                $CreationParams.Remove('OneDriveLocation')
            }

            # OneDrive Location Exception is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.OneDriveLocationException -or `
                    $null -ne $OneDriveLocationException)
            {
                $ToBeRemoved = $CurrentPolicy.OneDriveLocationException | `
                        Where-Object { $OneDriveLocationException -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveOneDriveLocationException', $ToBeRemoved)
                }

                $ToBeAdded = $OneDriveLocationException | `
                        Where-Object { $CurrentPolicy.OneDriveLocationException -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddOneDriveLocationException', $ToBeAdded)
                }
                $CreationParams.Remove('OneDriveLocationException')
            }

            # Public Folder Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.PublicFolderLocation -or `
                    $null -ne $PublicFolderLocation)
            {
                $ToBeRemoved = $CurrentPolicy.PublicFolderLocation | `
                        Where-Object { $PublicFolderLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemovePublicFolderLocation', $ToBeRemoved)
                }

                $ToBeAdded = $PublicFolderLocation | `
                        Where-Object { $CurrentPolicy.PublicFolderLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddPublicFolderLocation', $ToBeAdded)
                }
                $CreationParams.Remove('PublicFolderLocation')
            }

            # SharePoint Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.SharePointLocation -or `
                    $null -ne $SharePointLocation)
            {
                $ToBeRemoved = $CurrentPolicy.SharePointLocation | `
                        Where-Object { $SharePointLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveSharePointLocation', $ToBeRemoved)
                }

                $ToBeAdded = $SharePointLocation | `
                        Where-Object { $CurrentPolicy.SharePointLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddSharePointLocation', $ToBeAdded)
                }
                $CreationParams.Remove('SharePointLocation')
            }

            # SharePoint Location Exception is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.SharePointLocationException -or `
                    $null -ne $SharePointLocationException)
            {
                $ToBeRemoved = $CurrentPolicy.SharePointLocationException | `
                        Where-Object { $SharePointLocationException -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveSharePointLocationException', $ToBeRemoved)
                }

                $ToBeAdded = $SharePointLocationException | `
                        Where-Object { $CurrentPolicy.SharePointLocationException -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddSharePointLocationException', $ToBeAdded)
                }
                $CreationParams.Remove('SharePointLocationException')
            }

            # Skype Location is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.SkypeLocation -or `
                    $null -ne $SkypeLocation)
            {
                $ToBeRemoved = $CurrentPolicy.SkypeLocation | `
                        Where-Object { $SkypeLocation -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveSkypeLocation', $ToBeRemoved)
                }

                $ToBeAdded = $SkypeLocation | `
                        Where-Object { $CurrentPolicy.SkypeLocation -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddSkypeLocation', $ToBeAdded)
                }
                $CreationParams.Remove('SkypeLocation')
            }

            # Skype Location Exception is specified or already existing, we need to determine
            # the delta.
            if ($null -ne $CurrentPolicy.SkypeLocationException -or `
                    $null -ne $SkypeLocationException)
            {
                $ToBeRemoved = $CurrentPolicy.SkypeLocationException | `
                        Where-Object { $SkypeLocationException -NotContains $_ }
                if ($null -ne $ToBeRemoved)
                {
                    $CreationParams.Add('RemoveSkypeLocationException', $ToBeRemoved)
                }

                $ToBeAdded = $SkypeLocationException | `
                        Where-Object { $CurrentPolicy.SkypeLocationException -NotContains $_ }
                if ($null -ne $ToBeAdded)
                {
                    $CreationParams.Add('AddSkypeLocationException', $ToBeAdded)
                }
                $CreationParams.Remove('SkypeLocationException')
            }
        }
    }
    else
    {
        $isTeamsBased = $true
        Write-Verbose -Message "Policy $Name is a Teams Policy"
        $CreationParams = @{
            Identity             = $Name
            Comment              = $Comment
            Enabled              = $Enabled
            RestrictiveRetention = $RestrictiveRetention
        }

        if ($null -ne $TeamsChannelLocation)
        {
            $CreationParams.Add('TeamsChannelLocation', $TeamsChannelLocation)
        }
        if ($null -ne $TeamsChannelLocationException)
        {
            $CreationParams.Add('TeamsChannelLocationException', $TeamsChannelLocationException)
        }
        if ($null -ne $TeamsChatLocation)
        {
            $CreationParams.Add('TeamsChatLocation', $TeamsChatLocation)
        }
        if ($null -ne $TeamsChatLocationException)
        {
            $CreationParams.Add('TeamsChatLocationException', $TeamsChatLocationException)
        }

        # Teams Chat Location is specified or already existing, we need to determine
        # the delta.
        if ($null -ne $CurrentPolicy.TeamsChatLocation -or `
                $null -ne $TeamsChatLocation)
        {
            $ToBeRemoved = $CurrentPolicy.TeamsChatLocation | `
                    Where-Object { $TeamsChatLocation -NotContains $_ }
            if ($null -ne $ToBeRemoved)
            {
                Write-Verbose -Message 'Adding the RemoveTeamsChatLocation property.'
                $CreationParams.Add('RemoveTeamsChatLocation', $ToBeRemoved)
            }

            $ToBeAdded = $TeamsChatLocation | `
                    Where-Object { $CurrentPolicy.TeamsChatLocation -NotContains $_ }
            if ($null -ne $ToBeAdded)
            {
                Write-Verbose -Message 'Adding the AddTeamsChatLocation property.'
                $CreationParams.Add('AddTeamsChatLocation', $ToBeAdded)
            }
        }

        # Teams Chat Location Exception is specified or already existing, we need to determine
        # the delta.
        if ($null -ne $CurrentPolicy.TeamsChatLocationException -or `
                $null -ne $TeamsChatLocationException)
        {
            $ToBeRemoved = $CurrentPolicy.TeamsChatLocationException | `
                    Where-Object { $TeamsChatLocationException -NotContains $_ }
            if ($null -ne $ToBeRemoved)
            {
                Write-Verbose -Message 'Adding the RemoveTeamsChatLocationException property.'
                $CreationParams.Add('RemoveTeamsChatLocationException', $ToBeRemoved)
            }

            $ToBeAdded = $TeamsChatLocationException | `
                    Where-Object { $CurrentPolicy.TeamsChatLocationException -NotContains $_ }
            if ($null -ne $ToBeAdded)
            {
                Write-Verbose -Message 'Adding the AddTeamsChatLocationException property.'
                $CreationParams.Add('AddTeamsChatLocationException', $ToBeAdded)
            }
        }

        # Teams Channel Location is specified or already existing, we need to determine
        # the delta.
        if ($null -ne $CurrentPolicy.TeamsChannelLocation -or `
                $null -ne $TeamsChannelLocation)
        {
            $ToBeRemoved = $CurrentPolicy.TeamsChannelLocation | `
                    Where-Object { $TeamsChannelLocation -NotContains $_ }
            if ($null -ne $ToBeRemoved)
            {
                Write-Verbose -Message 'Adding the RemoveTeamsChannelLocation property.'
                $CreationParams.Add('RemoveTeamsChannelLocation', $ToBeRemoved)
            }

            $ToBeAdded = $TeamsChannelLocation | `
                    Where-Object { $CurrentPolicy.TeamsChannelLocation -NotContains $_ }
            if ($null -ne $ToBeAdded)
            {
                Write-Verbose -Message 'Adding the AddTeamsChannelLocation property.'
                $CreationParams.Add('AddTeamsChannelLocation', $ToBeAdded)
            }
        }

        # Teams Channel Location Exception is specified or already existing, we need to determine
        # the delta.
        if ($null -ne $CurrentPolicy.TeamsChannelLocationException -or `
                $null -ne $TeamsChannelLocationException)
        {
            $ToBeRemoved = $CurrentPolicy.TeamsChannelChannelLocationException | `
                    Where-Object { $TeamsChannelLocationException -NotContains $_ }
            if ($null -ne $ToBeRemoved)
            {
                Write-Verbose -Message 'Adding the RemoveTeamsChannelLocationException property.'
                $CreationParams.Add('RemoveTeamsChannelLocationException', $ToBeRemoved)
            }

            $ToBeAdded = $TeamsChannelLocationException | `
                    Where-Object { $CurrentPolicy.TeamsChannelLocationException -NotContains $_ }
            if ($null -ne $ToBeAdded)
            {
                Write-Verbose -Message 'Adding the AddTeamsChannelLocationException property.'
                $CreationParams.Add('AddTeamsChannelLocationException', $ToBeAdded)
            }
        }
    }
    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentPolicy.Ensure))
    {
        $CreationParams.Add('Name', $Name)
        $CreationParams.Remove('Identity') | Out-Null
        Write-Verbose -Message "Creating new Retention Compliance Policy $Name with values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        New-RetentionCompliancePolicy @CreationParams
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentPolicy.Ensure))
    {
        # Remove Teams specific parameters
        $CreationParams.Remove('TeamsChatLocationException') | Out-Null
        $CreationParams.Remove('TeamsChannelLocationException') | Out-Null
        $CreationParams.Remove('TeamsChannelLocation') | Out-Null
        $CreationParams.Remove('TeamsChatLocation') | Out-Null

        if ($isTeamsBased)
        {
            $CreationParams.Remove('RestrictiveRetention') | Out-Null
        }

        Write-Verbose "Updating Policy with values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        $success = $false
        $retries = 1
        while (!$success -and $retries -le 10)
        {
            try
            {
                Set-RetentionCompliancePolicy @CreationParams -Force -ErrorAction Stop
                $success = $true
            }
            catch
            {
                if ($_.Exception.Message -like '*are being deployed. Once deployed, additional actions can be performed*')
                {
                    Write-Verbose -Message "The policy has pending changes being deployed. Waiting 30 seconds for a maximum of 300 seconds (5 minutes). Total time waited so far {$($retries * 30) seconds}"
                    Start-Sleep -Seconds 30
                }
                else
                {
                    $success = $true
                }
            }
            $retries++
        }
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentPolicy.Ensure))
    {
        # If the Policy exists and it shouldn't, simply remove it;
        Remove-RetentionCompliancePolicy -Identity $Name
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
        $Name,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String[]]
        $DynamicScopeLocation,

        [Parameter()]
        [System.Boolean]
        $Enabled = $true,

        [Parameter()]
        [System.String[]]
        $ExchangeLocation = @(),

        [Parameter()]
        [System.String[]]
        $ExchangeLocationException = @(),

        [Parameter()]
        [System.String[]]
        $ModernGroupLocation = @(),

        [Parameter()]
        [System.String[]]
        $ModernGroupLocationException = @(),

        [Parameter()]
        [System.String[]]
        $OneDriveLocation = @(),

        [Parameter()]
        [System.String[]]
        $OneDriveLocationException = @(),

        [Parameter()]
        [System.String[]]
        $PublicFolderLocation = @(),

        [Parameter()]
        [System.Boolean]
        $RestrictiveRetention = $true,

        [Parameter()]
        [System.String[]]
        $SharePointLocation = @(),

        [Parameter()]
        [System.String[]]
        $SharePointLocationException = @(),

        [Parameter()]
        [System.String[]]
        $SkypeLocation = @(),

        [Parameter()]
        [System.String[]]
        $SkypeLocationException = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocation = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChannelLocationException = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChatLocation = @(),

        [Parameter()]
        [System.String[]]
        $TeamsChatLocationException = @(),

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
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

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

    Write-Verbose -Message "Testing configuration of RetentionCompliancePolicy for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

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
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
        -InboundParameters $PSBoundParameters `
        -SkipModuleReload $true

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
        [array]$policies = Get-RetentionCompliancePolicy -DistributionDetail -ErrorAction Stop

        $i = 1
        if ($policies.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $dscContent = ''
        foreach ($policy in $policies)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($policies.Length)] $($policy.Name)" -NoNewline

            $Script:exportedInstance = $policy
            $Results = Get-TargetResource @PSBoundParameters -Name $policy.Name
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
