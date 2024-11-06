function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $TimeZone,

        [Parameter()]
        [System.String]
        $Locale,

        [Parameter()]
        [System.String]
        $RetentionPolicy,

        [Parameter()]
        [System.String]
        $AddressBookPolicy,

        [Parameter()]
        [System.String]
        $RoleAssignmentPolicy,

        [Parameter()]
        [System.String]
        $SharingPolicy,

        [Parameter()]
        [ValidateSet('Present')]
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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Getting configuration of Office 365 Mailbox Settings for $DisplayName"

    if ($Global:CurrentModeIsExport)
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters `
            -SkipModuleReload $true
    }
    else
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters
    }

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
        DisplayName = $DisplayName
    }

    try
    {
        $mailboxSettings = Get-MailboxRegionalConfiguration -Identity $DisplayName -ErrorAction Stop
        $mailboxInfo     = Get-Mailbox  -Identity $DisplayName -ErrorAction Stop
    }
    catch
    {
        return $nullReturn
    }

    if ($null -eq $mailboxSettings)
    {
        Write-Verbose -Message "The specified Mailbox doesn't already exist."
        return $nullReturn
    }

    $result = @{
        DisplayName           = $DisplayName
        TimeZone              = $mailboxSettings.TimeZone
        Locale                = $mailboxSettings.Language.Name
        RetentionPolicy       = $mailboxInfo.RetentionPolicy
        AddressBookPolicy     = $mailboxInfo.AddressBookPolicy
        RoleAssignmentPolicy  = $mailboxInfo.RoleAssignmentPolicy
        SharingPolicy         = $mailboxInfo.SharingPolicy
        Ensure                = "Present"
        Credential            = $Credential
        ApplicationId         = $ApplicationId
        CertificateThumbprint = $CertificateThumbprint
        CertificatePath       = $CertificatePath
        CertificatePassword   = $CertificatePassword
        Managedidentity       = $ManagedIdentity.IsPresent
        TenantId              = $TenantId
        AccessTokens          = $AccessTokens
    }

    Write-Verbose -Message "Found an existing instance of Mailbox '$($DisplayName)'"
    return $result
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $TimeZone,

        [Parameter()]
        [System.String]
        $Locale,

        [Parameter()]
        [System.String]
        $RetentionPolicy,

        [Parameter()]
        [System.String]
        $AddressBookPolicy,

        [Parameter()]
        [System.String]
        $RoleAssignmentPolicy,

        [Parameter()]
        [System.String]
        $SharingPolicy,

        [Parameter()]
        [ValidateSet('Present')]
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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Setting configuration of Office 365 Mailbox Settings for $DisplayName"

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
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
        -InboundParameters $PSBoundParameters

    Set-MailboxRegionalConfiguration -Identity $DisplayName `
        -Language $Locale `
        -TimeZone $TimeZone

    $needToUpdate = $false
    $updateParams = @{
        Identity = $DisplayName
    }
    if (-not [System.String]::IsNullOrEmpty($AddressBookPolicy))
    {
        $needToUpdate = $true
        $updateParams.Add('AddressBookPolicy', $AddressBookPolicy)
    }
    if (-not [System.String]::IsNullOrEmpty($RoleAssignmentPolicy))
    {
        $needToUpdate = $true
        $updateParams.Add('RoleAssignmentPolicy', $RoleAssignmentPolicy)
    }
    if (-not [System.String]::IsNullOrEmpty($RetentionPolicy))
    {
        $needToUpdate = $true
        $updateParams.Add('RetentionPolicy', $RetentionPolicy)
    }
    if (-not [System.String]::IsNullOrEmpty($SharingPolicy))
    {
        $needToUpdate = $true
        $updateParams.Add('SharingPolicy', $SharingPolicy)
    }
    if ($needToUpdate)
    {
        Write-Verbose -Message "Updating Mailbox specific properties with:`r`n$(Convert-M365DscHashtableToString -Hashtable $updateParams)"
        Set-Mailbox @updateParams
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

        [Parameter()]
        [System.String]
        $TimeZone,

        [Parameter()]
        [System.String]
        $Locale,

        [Parameter()]
        [System.String]
        $RetentionPolicy,

        [Parameter()]
        [System.String]
        $AddressBookPolicy,

        [Parameter()]
        [System.String]
        $RoleAssignmentPolicy,

        [Parameter()]
        [System.String]
        $SharingPolicy,

        [Parameter()]
        [ValidateSet('Present')]
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

    Write-Verbose -Message "Testing configuration of Office 365 Mailbox Settings for $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).Clone()

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

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
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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

    [array]$mailboxes = Get-Mailbox -ResultSize 'Unlimited'

    $i = 1
    if ($mailboxes.Length -eq 0)
    {
        Write-Host $Global:M365DSCEmojiGreenCheckMark
    }
    else
    {
        Write-Host "`r`n"-NoNewline
    }
    $dscContent = ''
    $ObjectGuid = [System.Guid]::empty
    foreach ($mailbox in $mailboxes)
    {
        $DisplayNameValue = $mailbox.Name

        if ([System.Guid]::TryParse($mailbox.Identity,[System.Management.Automation.PSReference]$ObjectGuid))
        {
            try
            {
                $user = Get-User -Identity $mailbox.Identity
                $DisplayNameValue = $user.UserPrincipalName
            }
            catch
            {
                Write-Verbose -Message "Could not retrieve user with id {$($mailbox.Identity)}"
            }
        }
        Write-Host "    |---[$i/$($mailboxes.Length)] $($DisplayNameValue)" -NoNewline

        if (-not [System.String]::IsNullOrEmpty($DisplayNameValue))
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $Params = @{
                Credential            = $Credential
                DisplayName           = $DisplayNameValue
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }
            $Results = Get-TargetResource @Params

            if ($Results -is [System.Collections.Hashtable] -and $Results.Count -gt 1)
            {
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
        }

        $i++
    }
    return $dscContent
}

Export-ModuleMember -Function *-TargetResource
