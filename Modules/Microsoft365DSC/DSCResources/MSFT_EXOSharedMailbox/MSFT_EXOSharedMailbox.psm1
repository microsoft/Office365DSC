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
        $Identity,

        [Parameter()]
        [System.String]
        $PrimarySMTPAddress,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

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
            Write-Verbose -Message "Getting configuration of Office 365 Shared Mailbox $DisplayName"
            $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
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
                if (-not [System.String]::IsNullOrEmpty($Identity))
                {
                    $mailbox = $mailbox = Get-Mailbox -Identity $Identity `
                        -RecipientTypeDetails 'SharedMailbox' `
                        -ResultSize Unlimited `
                        -ErrorAction Stop
                }

                if ($null -eq $mailbox)
                {
                    $mailbox = $mailbox = Get-Mailbox -Identity $DisplayName `
                        -RecipientTypeDetails 'SharedMailbox' `
                        -ResultSize Unlimited `
                        -ErrorAction Stop
                }
            }
            catch
            {
                Write-Verbose -Message "Could not retrieve AAD roledefinition by Id: {$Id}"
            }

            if ($null -eq $mailbox)
            {
                Write-Verbose -Message "The specified Shared Mailbox doesn't already exist."
                return $nullReturn
            }
        }
        else
        {
            $mailbox = $Script:exportedInstance
        }

        #region EmailAddresses
        $CurrentEmailAddresses = @()

        foreach ($email in $mailbox.EmailAddresses)
        {
            $emailValue = $email.Split(':')[1]
            if ($emailValue -and $emailValue -ne $mailbox.PrimarySMTPAddress)
            {
                $CurrentEmailAddresses += $emailValue
            }
        }
        #endregion

        $result = @{
            DisplayName           = $DisplayName
            Identity              = $mailbox.Identity
            PrimarySMTPAddress    = $mailbox.PrimarySMTPAddress.ToString()
            Alias                 = $mailbox.Alias
            EmailAddresses        = $CurrentEmailAddresses
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            CertificateThumbprint = $CertificateThumbprint
            CertificatePath       = $CertificatePath
            CertificatePassword   = $CertificatePassword
            Managedidentity       = $ManagedIdentity.IsPresent
            TenantId              = $TenantId
            AccessTokens          = $AccessTokens
        }

        Write-Verbose -Message "Found an existing instance of Shared Mailbox '$($DisplayName)'"
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
        $DisplayName,

        [Parameter()]
        [System.String]
        $Identity,

        [Parameter()]
        [System.String]
        $PrimarySMTPAddress,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.String[]]
        $EmailAddresses = @(),

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    Write-Verbose -Message "Setting configuration of Office 365 Shared Mailbox $DisplayName"
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

    $currentMailbox = Get-TargetResource @PSBoundParameters

    #region Validation
    foreach ($secondaryAlias in $EmailAddresses)
    {
        if ($secondaryAlias.ToLower() -eq $PrimarySMTPAddress.ToLower())
        {
            throw 'You cannot have the EmailAddresses list contain the PrimarySMTPAddress'
        }
    }
    #endregion

    $CurrentParameters = $PSBoundParameters
    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
        -InboundParameters $PSBoundParameters

    # CASE: Mailbox doesn't exist but should;
    if ($Ensure -eq 'Present' -and $currentMailbox.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Shared Mailbox '$($DisplayName)' does not exist but it should. Creating it."
        $emails = ''
        foreach ($secondaryAlias in $EmailAddresses)
        {
            $emails += $secondaryAlias + ','
        }
        $emails += $PrimarySMTPAddress
        $proxyAddresses = $emails -Split ','
        $CurrentParameters.EmailAddresses = $proxyAddresses
        $NewMailBoxParameters = @{
            Name               = $DisplayName
            PrimarySMTPAddress = $PrimarySMTPAddress
            Shared             = $true
        }
        if ($Alias)
        {
            $NewMailBoxParameters.Add('Alias', $Alias)
        }
        New-MailBox @NewMailBoxParameters
        Set-Mailbox -Identity $DisplayName -EmailAddresses @{add = $EmailAddresses }
    }
    # CASE: Mailbox exists but it shouldn't;
    elseif ($Ensure -eq 'Absent' -and $currentMailbox.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Shared Mailbox '$($DisplayName)' exists but it shouldn't. Deleting it."
        Remove-Mailbox -Identity $DisplayName -Confirm:$false
    }
    # CASE: Mailbox exists and it should, but has different values than the desired ones
    elseif ($Ensure -eq 'Present' -and $currentMailbox.Ensure -eq 'Present')
    {
        # CASE: EmailAddresses need to be updated
        Write-Verbose -Message "Shared Mailbox '$($DisplayName)' already exists, but needs updating."
        $current = $currentMailbox.EmailAddresses
        $desired = $EmailAddresses
        $diff = Compare-Object -ReferenceObject $current -DifferenceObject $desired
        if ($diff)
        {
            # Add EmailAddresses
            Write-Verbose -Message "Updating the list of EmailAddresses for the Shared Mailbox '$($DisplayName)'"
            $emails = ''
            $emailAddressesToAdd = $diff | Where-Object -FilterScript { $_.SideIndicator -eq '=>' }
            if ($null -ne $emailAddressesToAdd)
            {
                $emailsToAdd = ''
                foreach ($secondaryAlias in $emailAddressesToAdd)
                {
                    $emailsToAdd += $secondaryAlias.InputObject + ','
                }
                $emailsToAdd += $PrimarySMTPAddress
                $proxyAddresses = $emailsToAdd -Split ','

                Write-Verbose -Message "Adding the following EmailAddresses: $emailsToAdd"
                Set-Mailbox -Identity $DisplayName -EmailAddresses @{add = $proxyAddresses }
            }
            # Remove EmailAddresses
            $emailAddressesToRemove = $diff | Where-Object -FilterScript { $_.SideIndicator -eq '<=' }
            if ($null -ne $emailAddressesToRemove)
            {
                $emailsToRemoved = ''
                foreach ($secondaryAlias in $emailAddressesToRemove)
                {
                    $emailsToRemoved += $secondaryAlias.InputObject + ','
                }
                $emailsToRemoved += $PrimarySMTPAddress
                $proxyAddresses = $emailsToRemoved -Split ','

                Write-Verbose -Message "Removing the following EmailAddresses: $emailsToRemoved"
                Set-Mailbox -Identity $DisplayName -EmailAddresses @{remove = $proxyAddresses }
            }
        }
        $current = $currentMailbox.Alias
        $desired = $Alias
        $diff = Compare-Object -ReferenceObject $current -DifferenceObject $desired
        if ($diff)
        {
            Write-Verbose -Message "Updating Alias for the Shared Mailbox '$($DisplayName)'"
            Set-Mailbox -Identity $DisplayName -Alias $Alias
        }
        $current = $currentMailbox.PrimarySMTPAddress
        $desired = $PrimarySMTPAddress
        $diff = Compare-Object -ReferenceObject $current -DifferenceObject $desired
        if ($diff)
        {
            Write-Verbose -Message "Updating PrimarySmtpAddress for the Shared Mailbox from $($mailbox.PrimarySMTPAddress) to $PrimarySMTPAddress"
            Set-Mailbox -Identity $mailbox.guid.guid -WindowsEmailAddress $PrimarySMTPAddress
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

        [Parameter()]
        [System.String]
        $Identity,

        [Parameter()]
        [System.String]
        $PrimarySMTPAddress,

        [Parameter()]
        [System.String]
        $Alias,

        [Parameter()]
        [System.String[]]
        $EmailAddresses,

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

    Write-Verbose -Message "Testing configuration of Office 365 Shared Mailbox $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @('Ensure', `
            'DisplayName', `
            'Alias', `
            'PrimarySMTPAddress',
        'EmailAddresses')

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

    try
    {
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-Mailbox -RecipientTypeDetails 'SharedMailbox' `
            -ResultSize Unlimited `
            -ErrorAction Stop
        $dscContent = ''
        $i = 1
        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($mailbox in $Script:exportedInstances)
        {
            Write-Host "    |---[$i/$($Script:exportedInstances.Length)] $($mailbox.Name)" -NoNewline
            $mailboxName = $mailbox.Name
            if ($mailboxName)
            {
                if ($null -ne $Global:M365DSCExportResourceInstancesCount)
                {
                    $Global:M365DSCExportResourceInstancesCount++
                }

                $params = @{
                    Identity              = $mailbox.Identity
                    Credential            = $Credential
                    DisplayName           = $mailboxName
                    Alias                 = $mailbox.Alias
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                    CertificatePassword   = $CertificatePassword
                    Managedidentity       = $ManagedIdentity.IsPresent
                    CertificatePath       = $CertificatePath
                    AccessTokens          = $AccessTokens
                }
                $Script:exportedInstance = $mailbox
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
