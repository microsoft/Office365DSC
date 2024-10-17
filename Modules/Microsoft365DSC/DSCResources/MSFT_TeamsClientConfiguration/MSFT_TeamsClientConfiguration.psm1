function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Global')]
        $Identity,

        [Parameter()]
        [System.Boolean]
        $AllowBox,

        [Parameter()]
        [System.Boolean]
        $AllowDropBox,

        [Parameter()]
        [System.Boolean]
        $AllowEmailIntoChannel,

        [Parameter()]
        [System.Boolean]
        $AllowGoogleDrive,

        [Parameter()]
        [System.Boolean]
        $AllowGuestUser,

        [Parameter()]
        [System.Boolean]
        $AllowOrganizationTab,

        [Parameter()]
        [System.Boolean]
        $AllowResourceAccountSendMessage,

        [Parameter()]
        [System.Boolean]
        $AllowScopedPeopleSearchandAccess,

        [Parameter()]
        [System.Boolean]
        $AllowShareFile,

        [Parameter()]
        [System.Boolean]
        $AllowSkypeBusinessInterop,

        [Parameter()]
        [System.Boolean]
        $AllowEgnyte,

        [Parameter()]
        [System.String]
        [ValidateSet('NotRequired', 'RequiredOutsideScheduleMeeting', 'AlwaysRequired')]
        $ContentPin = 'RequiredOutsideScheduledMeeting',

        [Parameter()]
        [System.String]
        [ValidateSet('NoAccess', 'PartialAccess', 'FullAccess')]
        $ResourceAccountContentAccess,

        [Parameter()]
        [System.String[]]
        $RestrictedSenderList = $null,

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

    Write-Verbose -Message 'Getting configuration of Teams Client'

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
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

    $nullReturn = @{
        Identity = 'Global'
    }

    try
    {
        $config = Get-CsTeamsClientConfiguration -ErrorAction Stop

        $result = @{
            Identity                         = $config.Identity
            AllowBox                         = $config.AllowBox
            AllowDropBox                     = $config.AllowDropBox
            AllowEgnyte                      = $config.AllowEgnyte
            AllowEmailIntoChannel            = $config.AllowEmailIntoChannel
            AllowGoogleDrive                 = $config.AllowGoogleDrive
            AllowGuestUser                   = $config.AllowGuestUser
            AllowOrganizationTab             = $config.AllowOrganizationTab
            AllowResourceAccountSendMessage  = $config.AllowResourceAccountSendMessage
            AllowScopedPeopleSearchandAccess = $config.AllowScopedPeopleSearchandAccess
            AllowShareFile                   = $config.AllowShareFile
            AllowSkypeBusinessInterop        = $config.AllowSkypeBusinessInterop
            ContentPin                       = $config.ContentPin
            ResourceAccountContentAccess     = $config.ResourceAccountContentAccess
            RestrictedSenderList             = $config.RestrictedSenderList
            Credential                       = $Credential
            ApplicationId                    = $ApplicationId
            TenantId                         = $TenantId
            CertificateThumbprint            = $CertificateThumbprint
            ManagedIdentity                  = $ManagedIdentity.IsPresent
            AccessTokens                     = $AccessTokens
        }
        if ([System.String]::IsNullOrEmpty($Config.RestrictedSenderList))
        {
            $result.Remove('RestrictedSenderList') | Out-Null
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
        [ValidateSet('Global')]
        $Identity,

        [Parameter()]
        [System.Boolean]
        $AllowBox,

        [Parameter()]
        [System.Boolean]
        $AllowDropBox,

        [Parameter()]
        [System.Boolean]
        $AllowEmailIntoChannel,

        [Parameter()]
        [System.Boolean]
        $AllowGoogleDrive,

        [Parameter()]
        [System.Boolean]
        $AllowGuestUser,

        [Parameter()]
        [System.Boolean]
        $AllowOrganizationTab,

        [Parameter()]
        [System.Boolean]
        $AllowResourceAccountSendMessage,

        [Parameter()]
        [System.Boolean]
        $AllowScopedPeopleSearchandAccess,

        [Parameter()]
        [System.Boolean]
        $AllowShareFile,

        [Parameter()]
        [System.Boolean]
        $AllowSkypeBusinessInterop,

        [Parameter()]
        [System.Boolean]
        $AllowEgnyte,

        [Parameter()]
        [System.String]
        [ValidateSet('NotRequired', 'RequiredOutsideScheduleMeeting', 'AlwaysRequired')]
        $ContentPin = 'RequiredOutsideScheduledMeeting',

        [Parameter()]
        [System.String]
        [ValidateSet('NoAccess', 'PartialAccess', 'FullAccess')]
        $ResourceAccountContentAccess,

        [Parameter()]
        [System.String[]]
        $RestrictedSenderList = $null,

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

    Write-Verbose -Message 'Setting configuration of Teams Client'

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
        -InboundParameters $PSBoundParameters

    $SetParams = $PSBoundParameters
    $SetParams.Remove('Credential') | Out-Null
    $SetParams.Remove('ApplicationId') | Out-Null
    $SetParams.Remove('TenantId') | Out-Null
    $SetParams.Remove('CertificateThumbprint') | Out-Null
    $SetParams.Remove('ManagedIdentity') | Out-Null
    $SetParams.Remove('AccessTokens') | Out-Null

    if ([System.String]::IsNullOrEmpty($RestrictedSenderList))
    {
        $SetParams.Remove('RestrictedSenderList') | Out-Null
    }
    else
    {
        # https://learn.microsoft.com/en-us/powershell/module/teams/set-csteamsclientconfiguration?view=teams-ps#-restrictedsenderlist
        # This is a semicolon-separated string of the domains you'd like to allow to send emails to Teams channels
        $tempValue = $SetParams['RestrictedSenderList'] -join ';'
        $SetParams.RestrictedSenderList = $tempValue
    }
    Set-CsTeamsClientConfiguration @SetParams
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Global')]
        $Identity,

        [Parameter()]
        [System.Boolean]
        $AllowBox,

        [Parameter()]
        [System.Boolean]
        $AllowDropBox,

        [Parameter()]
        [System.Boolean]
        $AllowEmailIntoChannel,

        [Parameter()]
        [System.Boolean]
        $AllowGoogleDrive,

        [Parameter()]
        [System.Boolean]
        $AllowGuestUser,

        [Parameter()]
        [System.Boolean]
        $AllowOrganizationTab,

        [Parameter()]
        [System.Boolean]
        $AllowResourceAccountSendMessage,

        [Parameter()]
        [System.Boolean]
        $AllowScopedPeopleSearchandAccess,

        [Parameter()]
        [System.Boolean]
        $AllowShareFile,

        [Parameter()]
        [System.Boolean]
        $AllowSkypeBusinessInterop,

        [Parameter()]
        [System.Boolean]
        $AllowEgnyte,

        [Parameter()]
        [System.String]
        [ValidateSet('NotRequired', 'RequiredOutsideScheduleMeeting', 'AlwaysRequired')]
        $ContentPin = 'RequiredOutsideScheduledMeeting',

        [Parameter()]
        [System.String]
        [ValidateSet('NoAccess', 'PartialAccess', 'FullAccess')]
        $ResourceAccountContentAccess,

        [Parameter()]
        [System.String[]]
        $RestrictedSenderList = $null,

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
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message 'Testing configuration of Teams Client'

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    if ([System.String]::IsNullOrEmpty($RestrictedSenderList))
    {
        $ValuesToCheck.Remove('RestrictedSenderList') | Out-Null
    }
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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftTeams' `
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
        $params = @{
            Identity              = 'Global'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        $Results = Get-TargetResource @Params

        if ($Results -is [System.Collections.Hashtable] -and $Results.Count -gt 1)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
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
        }
        else
        {
            Write-Host $Global:M365DSCEmojiRedX
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
