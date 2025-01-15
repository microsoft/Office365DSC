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
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
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
            Write-Verbose -Message "Getting configuration of AddressList for $Name"

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

            if ($null -eq (Get-Command 'Get-AddressList' -ErrorAction SilentlyContinue))
            {
                return $nullReturn
            }

            $AddressLists = Get-AddressList -ErrorAction Stop
            $AddressList = $AddressLists | Where-Object -FilterScript { $_.Name -eq $Name }

            if ($null -eq $AddressList)
            {
                Write-Verbose -Message "Address List $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $AddressList = $Script:exportedInstance
        }

        if ($null -eq $AddressList.IncludedRecipients)
        {
            $IncludedRecipients = @()
        }
        else
        {
            $IncludedRecipients = $AddressList.IncludedRecipients
        }

        $result = @{
            Name                         = $Name
            ConditionalCompany           = $AddressList.ConditionalCompany
            ConditionalCustomAttribute1  = $AddressList.ConditionalCustomAttribute1
            ConditionalCustomAttribute10 = $AddressList.ConditionalCustomAttribute10
            ConditionalCustomAttribute11 = $AddressList.ConditionalCustomAttribute11
            ConditionalCustomAttribute12 = $AddressList.ConditionalCustomAttribute12
            ConditionalCustomAttribute13 = $AddressList.ConditionalCustomAttribute13
            ConditionalCustomAttribute14 = $AddressList.ConditionalCustomAttribute14
            ConditionalCustomAttribute15 = $AddressList.ConditionalCustomAttribute15
            ConditionalCustomAttribute2  = $AddressList.ConditionalCustomAttribute2
            ConditionalCustomAttribute3  = $AddressList.ConditionalCustomAttribute3
            ConditionalCustomAttribute4  = $AddressList.ConditionalCustomAttribute4
            ConditionalCustomAttribute5  = $AddressList.ConditionalCustomAttribute5
            ConditionalCustomAttribute6  = $AddressList.ConditionalCustomAttribute6
            ConditionalCustomAttribute7  = $AddressList.ConditionalCustomAttribute7
            ConditionalCustomAttribute8  = $AddressList.ConditionalCustomAttribute8
            ConditionalCustomAttribute9  = $AddressList.ConditionalCustomAttribute9
            ConditionalDepartment        = $AddressList.ConditionalDepartment
            ConditionalStateOrProvince   = $AddressList.ConditionalStateOrProvince
            DisplayName                  = $AddressList.DisplayName
            IncludedRecipients           = $IncludedRecipients
            RecipientFilter              = $AddressList.RecipientFilter
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

        Write-Verbose -Message "Found AddressList $($Name)"
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
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
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

    Write-Verbose -Message "Setting Address List configuration for $Name"

    $currentAddressListConfig = Get-TargetResource @PSBoundParameters

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

    #Address List doesn't exist but it should
    if ($Ensure -eq 'Present' -and $currentAddressListConfig.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "The Address List '$($Name)' does not exist but it should. Creating Address List."

        if ($RecipientFilter)
        {
            Write-Verbose -Message "You can't use RecipientFilter and precanned filters at the same time. All precanned filters will be ignored."
            $NewAddressListParams = @{
                Name            = $Name
                RecipientFilter = $RecipientFilter
                Confirm         = $false
            }
        }
        else
        {
            $NewAddressListParams = @{
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
                IncludedRecipients           = $IncludedRecipients
                Confirm                      = $false
            }

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $NewAddressListParams.Add('DisplayName', $DisplayName)
            }
        }
        New-AddressList @NewAddressListParams
    }
    #Address List exists but shouldn't
    elseif ($Ensure -eq 'Absent' -and $currentAddressListConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Address List '$($Name)' exists but shouldn't. Removing Address List."
        Remove-AddressList -Identity $Name -Confirm:$false
    }
    elseif ($Ensure -eq 'Present' -and $currentAddressListConfig.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Address List '$($Name)' already exists. Updating settings"
        if ($RecipientFilter)
        {
            Write-Verbose -Message "You can't use RecipientFilter and precanned filters at the same time. All precanned filters will be ignored."
            $SetAddressListParams = @{
                Identity        = $Name
                Name            = $Name
                RecipientFilter = $RecipientFilter
                Confirm         = $false
            }
        }
        else
        {
            $SetAddressListParams = @{
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
                IncludedRecipients           = $IncludedRecipients
                Confirm                      = $false
            }

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $SetAddressListParams.Add('DisplayName', $DisplayName)
            }

            if (-not [System.String]::IsNullOrEmpty($RecipientFilter))
            {
                $SetAddressListParams.Add('RecipientFilter', $RecipientFilter)
            }
        }
        Write-Verbose -Message "Setting Address List '$($Name)' with values: $(Convert-M365DscHashtableToString -Hashtable $SetAddressListParams)"
        Set-AddressList @SetAddressListParams
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
        [System.String]
        $DisplayName,

        [Parameter()]
        [ValidateSet('AllRecipients', 'MailboxUsers', 'MailContacts', 'MailGroups', 'MailUsers', 'Resources')]
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

    Write-Verbose -Message "Testing Address List configuration for $Name"

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
    param (
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
        if ($null -eq (Get-Command 'Get-AddressList' -ErrorAction SilentlyContinue))
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered to allow for Address Lists"
            return ''
        }
        $dscContent = ''
        $Script:ExportMode = $true
        [array] $Script:exportedInstances = Get-Addresslist -ErrorAction Stop
        if ($Script:exportedInstances.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        $i = 1

        foreach ($addressList in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $($addressList.Name)" -NoNewline
            $params = @{
                Name                  = $addressList.Name
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                CertificatePassword   = $CertificatePassword
                Managedidentity       = $ManagedIdentity.IsPresent
                CertificatePath       = $CertificatePath
                AccessTokens          = $AccessTokens
            }
            $Script:exportedInstance = $addressList
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
            $i ++
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
