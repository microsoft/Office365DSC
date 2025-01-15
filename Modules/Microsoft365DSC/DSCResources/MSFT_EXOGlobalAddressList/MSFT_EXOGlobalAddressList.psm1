function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $ConditionalCompany,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute1,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute10,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute11,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute12,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute13,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute14,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute15,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute2,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute3,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute4,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute6,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute7,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute8,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute9,

        [Parameter()]
        [System.String[]]
        $ConditionalDepartment,

        [Parameter()]
        [System.String[]]
        $ConditionalStateOrProvince,

        [Parameter()]
        [ValidateSet('', 'AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
        [System.String[]]
        $IncludedRecipients,

        [Parameter()]
        [System.String]
        $RecipientFilter,

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
            Write-Verbose -Message "Getting Global Address List configuration for $Name"
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

            if ($null -eq (Get-Command 'Get-GlobalAddressList' -ErrorAction SilentlyContinue))
            {
                return $nullReturn
            }

            $GlobalAddressList = Get-GlobalAddressList -Identity $Name -ErrorAction Stop

            if ($null -eq $GlobalAddressList)
            {
                Write-Verbose -Message "Global Address List $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $GlobalAddressList = $Script:exportedInstance
        }

        if ($null -eq $GlobalAddressList.IncludedRecipients)
        {
            $IncludedRecipients = ''.ToString()
        }
        else
        {
            $IncludedRecipients = $GlobalAddressList.IncludedRecipients
        }

        $result = @{
            Name                         = $GlobalAddressList.Name
            ConditionalCompany           = $GlobalAddressList.ConditionalCompany
            ConditionalCustomAttribute1  = $GlobalAddressList.ConditionalCustomAttribute1
            ConditionalCustomAttribute10 = $GlobalAddressList.ConditionalCustomAttribute10
            ConditionalCustomAttribute11 = $GlobalAddressList.ConditionalCustomAttribute11
            ConditionalCustomAttribute12 = $GlobalAddressList.ConditionalCustomAttribute12
            ConditionalCustomAttribute13 = $GlobalAddressList.ConditionalCustomAttribute13
            ConditionalCustomAttribute14 = $GlobalAddressList.ConditionalCustomAttribute14
            ConditionalCustomAttribute15 = $GlobalAddressList.ConditionalCustomAttribute15
            ConditionalCustomAttribute2  = $GlobalAddressList.ConditionalCustomAttribute2
            ConditionalCustomAttribute3  = $GlobalAddressList.ConditionalCustomAttribute3
            ConditionalCustomAttribute4  = $GlobalAddressList.ConditionalCustomAttribute4
            ConditionalCustomAttribute5  = $GlobalAddressList.ConditionalCustomAttribute5
            ConditionalCustomAttribute6  = $GlobalAddressList.ConditionalCustomAttribute6
            ConditionalCustomAttribute7  = $GlobalAddressList.ConditionalCustomAttribute7
            ConditionalCustomAttribute8  = $GlobalAddressList.ConditionalCustomAttribute8
            ConditionalCustomAttribute9  = $GlobalAddressList.ConditionalCustomAttribute9
            ConditionalDepartment        = $GlobalAddressList.ConditionalDepartment
            ConditionalStateOrProvince   = $GlobalAddressList.ConditionalStateOrProvince
            IncludedRecipients           = $IncludedRecipients
            RecipientFilter              = $GlobalAddressList.RecipientFilter
            Ensure                       = 'Present'
            Credential                   = $Credential
            ApplicationId                = $ApplicationId
            CertificateThumbprint        = $CertificateThumbprint
            CertificatePath              = $CertificatePath
            CertificatePassword          = $CertificatePassword
            Managedidentity              = $ManagedIdentity.IsPresent
            TenantId                     = $TenantId
            AccessTokens                 = $AccessTokens
        }

        Write-Verbose -Message "Found Global Address List $($Name)"
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
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $ConditionalCompany,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute1,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute10,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute11,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute12,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute13,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute14,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute15,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute2,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute3,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute4,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute6,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute7,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute8,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute9,

        [Parameter()]
        [System.String[]]
        $ConditionalDepartment,

        [Parameter()]
        [System.String[]]
        $ConditionalStateOrProvince,

        [Parameter()]
        [ValidateSet('', 'AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
        [System.String[]]
        $IncludedRecipients,

        [Parameter()]
        [System.String]
        $RecipientFilter,

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

    Write-Verbose -Message "Setting Global Address List configuration for $Name"

    $currentGlobalAddressListConfig = Get-TargetResource @PSBoundParameters

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

    # RecipientFilter parameter cannot be used in combination with the IncludedRecipients parameter or any Conditional parameters (which are used to create precanned filters).
    if ($RecipientFilter)
    {
        $NewGlobalAddressListParams = @{
            Name            = $Name
            RecipientFilter = $RecipientFilter
            Confirm         = $false
        }
    }
    else
    {
        $NewGlobalAddressListParams = @{
            Name                         = $Name
            ConditionalCompany           = $ConditionalCompany
            ConditionalCustomAttribute1  = $ConditionalCustomAttribute1
            ConditionalCustomAttribute10 = $ConditionalCustomAttribute10
            ConditionalCustomAttribute11 = $ConditionalCustomAttribute11
            ConditionalCustomAttribute12 = $ConditionalCustomAttribute12
            ConditionalCustomAttribute13 = $ConditionalCustomAttribute13
            ConditionalCustomAttribute14 = $ConditionalCustomAttribute14
            ConditionalCustomAttribute15 = $ConditionalCustomAttribute15
            ConditionalCustomAttribute2  = $ConditionalCustomAttribute2
            ConditionalCustomAttribute3  = $ConditionalCustomAttribute3
            ConditionalCustomAttribute4  = $ConditionalCustomAttribute4
            ConditionalCustomAttribute5  = $ConditionalCustomAttribute5
            ConditionalCustomAttribute6  = $ConditionalCustomAttribute6
            ConditionalCustomAttribute7  = $ConditionalCustomAttribute7
            ConditionalCustomAttribute8  = $ConditionalCustomAttribute8
            ConditionalCustomAttribute9  = $ConditionalCustomAttribute9
            ConditionalDepartment        = $ConditionalDepartment
            ConditionalStateOrProvince   = $ConditionalStateOrProvince
            Confirm                      = $false
        }

        if (-not [System.String]::IsNullOrEmpty($IncludedRecipients))
        {
            $NewGlobalAddressListParams.Add('IncludedRecipients', $IncludedRecipients)
        }
    }

    $SetGlobalAddressListParams = @{
        Identity                     = $Name
        Name                         = $Name
        ConditionalCompany           = $ConditionalCompany
        ConditionalCustomAttribute1  = $ConditionalCustomAttribute1
        ConditionalCustomAttribute10 = $ConditionalCustomAttribute10
        ConditionalCustomAttribute11 = $ConditionalCustomAttribute11
        ConditionalCustomAttribute12 = $ConditionalCustomAttribute12
        ConditionalCustomAttribute13 = $ConditionalCustomAttribute13
        ConditionalCustomAttribute14 = $ConditionalCustomAttribute14
        ConditionalCustomAttribute15 = $ConditionalCustomAttribute15
        ConditionalCustomAttribute2  = $ConditionalCustomAttribute2
        ConditionalCustomAttribute3  = $ConditionalCustomAttribute3
        ConditionalCustomAttribute4  = $ConditionalCustomAttribute4
        ConditionalCustomAttribute5  = $ConditionalCustomAttribute5
        ConditionalCustomAttribute6  = $ConditionalCustomAttribute6
        ConditionalCustomAttribute7  = $ConditionalCustomAttribute7
        ConditionalCustomAttribute8  = $ConditionalCustomAttribute8
        ConditionalCustomAttribute9  = $ConditionalCustomAttribute9
        ConditionalDepartment        = $ConditionalDepartment
        ConditionalStateOrProvince   = $ConditionalStateOrProvince
        Confirm                      = $false
    }

    if (-not [System.String]::IsNullOrEmpty($IncludedRecipients))
    {
        $SetGlobalAddressListParams.Add('IncludedRecipients', $IncludedRecipients)
    }

    if (-not [System.String]::IsNullOrEmpty($RecipientFilter))
    {
        $SetGlobalAddressListParams.Add('RecipientFilter', $RecipientFilter)
    }

    # CASE: Global Address List doesn't exist but should;
    if ($Ensure -eq 'Present' -and $currentGlobalAddressListConfig.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Global Address List '$($Name)' does not exist but it should. Create and configure it."
        # Create Global Address List
        New-GlobalAddressList @NewGlobalAddressListParams

    }
    # CASE: Global Address List exists but it shouldn't;
    elseif ($Ensure -eq 'Absent' -and $currentGlobalAddressListConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Global Address List '$($Name)' exists but it shouldn't. Remove it."
        Remove-GlobalAddressList -Identity $Name -Confirm:$false
    }
    # CASE: Global Address List exists and it should, but has different values than the desired ones
    elseif ($Ensure -eq 'Present' -and $currentGlobalAddressListConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Global Address List '$($Name)' already exists, but needs updating."
        Write-Verbose -Message "Setting Global Address List $($Name) with values: $(Convert-M365DscHashtableToString -Hashtable $SetGlobalAddressListParams)"
        Set-GlobalAddressList @SetGlobalAddressListParams
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 64)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String[]]
        $ConditionalCompany,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute1,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute10,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute11,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute12,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute13,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute14,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute15,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute2,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute3,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute4,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute5,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute6,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute7,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute8,

        [Parameter()]
        [System.String[]]
        $ConditionalCustomAttribute9,

        [Parameter()]
        [System.String[]]
        $ConditionalDepartment,

        [Parameter()]
        [System.String[]]
        $ConditionalStateOrProvince,

        [Parameter()]
        [ValidateSet('', 'AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
        [System.String[]]
        $IncludedRecipients,

        [Parameter()]
        [System.String]
        $RecipientFilter,

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

    Write-Verbose -Message "Testing Global Address List configuration for $Name"

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

    if ($null -eq (Get-Command 'Get-GlobalAddressList' -ErrorAction SilentlyContinue))
    {
        Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered to allow for Global Address List"
        return ''
    }

    try
    {
        [array]$AllGlobalAddressLists = Get-GlobalAddressList -ErrorAction Stop

        $dscContent = ''
        if ($AllGlobalAddressLists.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $i = 1
        foreach ($GlobalAddressList in $AllGlobalAddressLists)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($AllGlobalAddressLists.Count)] $($GlobalAddressList.Name)" -NoNewline

            $Params = @{
                Name                  = $GlobalAddressList.Name
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }
            $Script:exportedInstance = $GlobalAddressList
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

