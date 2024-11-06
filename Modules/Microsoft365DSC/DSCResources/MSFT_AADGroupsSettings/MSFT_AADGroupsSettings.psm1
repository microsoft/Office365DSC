function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Yes')]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $EnableGroupCreation,

        [Parameter()]
        [System.Boolean]
        $EnableMIPLabels,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToBeGroupOwner,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToAccessGroups,

        [Parameter()]
        [System.String]
        $GuestUsageGuidelinesUrl,

        [Parameter()]
        [System.String]
        $GroupCreationAllowedGroupName,

        [Parameter()]
        [System.Boolean]
        $AllowToAddGuests,

        [Parameter()]
        [System.String]
        $UsageGuidelinesUrl,

        [Parameter()]
        [System.Boolean]
        $NewUnifiedGroupWritebackDefault,

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

    Write-Verbose -Message 'Getting configuration of AzureAD Groups Settings'
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
    try
    {
        $Policy = Get-MgBetaDirectorySetting | Where-Object -FilterScript { $_.DisplayName -eq 'Group.Unified' }

        if ($null -eq $Policy)
        {
            return $nullReturn
        }
        else
        {
            Write-Verbose -Message 'Found existing AzureAD DirectorySetting for Group.Unified'
            $AllowedGroupName = $null
            $GroupCreationValue = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'GroupCreationAllowedGroupId' }
            if (-not [System.String]::IsNullOrEmpty($GroupCreationValue.Value))
            {
                $groupObject = Get-MgGroup -GroupId $GroupCreationValue.Value -ErrorAction SilentlyContinue
                $AllowedGroupName = $null
                if ($groupObject)
                {
                    $AllowedGroupName = $groupObject.DisplayName
                }
            }

            $valueEnableGroupCreation = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'EnableGroupCreation' }
            $valueEnableMIPLabels = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'EnableMIPLabels' }
            $valueAllowGuestsToBeGroupOwner = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowGuestsToBeGroupOwner' }
            $valueAllowGuestsToAccessGroups = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowGuestsToAccessGroups' }
            $valueGuestUsageGuidelinesUrl = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'GuestUsageGuidelinesUrl' }
            $valueAllowToAddGuests = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowToAddGuests' }
            $valueUsageGuidelinesUrl = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'UsageGuidelinesUrl' }
            $valueNewUnifiedGroupWritebackDefault = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'NewUnifiedGroupWritebackDefault' }

            $result = @{
                IsSingleInstance                = 'Yes'
                EnableGroupCreation             = [Boolean]::Parse($valueEnableGroupCreation.Value)
                EnableMIPLabels                 = [Boolean]::Parse($valueEnableMIPLabels.Value)
                AllowGuestsToBeGroupOwner       = [Boolean]::Parse($valueAllowGuestsToBeGroupOwner.Value)
                AllowGuestsToAccessGroups       = [Boolean]::Parse($valueAllowGuestsToAccessGroups.Value)
                GuestUsageGuidelinesUrl         = $valueGuestUsageGuidelinesUrl.Value
                AllowToAddGuests                = [Boolean]::Parse($valueAllowToAddGuests.Value)
                UsageGuidelinesUrl              = $valueUsageGuidelinesUrl.Value
                Ensure                          = 'Present'
                ApplicationId                   = $ApplicationId
                TenantId                        = $TenantId
                ApplicationSecret               = $ApplicationSecret
                CertificateThumbprint           = $CertificateThumbprint
                Credential                      = $Credential
                Managedidentity                 = $ManagedIdentity.IsPresent
                AccessTokens                    = $AccessTokens
            }
            if (-not [System.String]::IsNullOrEmpty($valueNewUnifiedGroupWritebackDefault.Value))
            {
            $result.Add('NewUnifiedGroupWritebackDefault', [Boolean]::Parse($valueNewUnifiedGroupWritebackDefault.Value))
            }
            
            if (-not [System.String]::IsNullOrEmpty($AllowedGroupName))
            {
                $result.Add('GroupCreationAllowedGroupName', $AllowedGroupName)
            }

            Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
            return $result
        }
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
        [ValidateSet('Yes')]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $EnableGroupCreation,

        [Parameter()]
        [System.Boolean]
        $EnableMIPLabels,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToBeGroupOwner,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToAccessGroups,

        [Parameter()]
        [System.String]
        $GuestUsageGuidelinesUrl,

        [Parameter()]
        [System.String]
        $GroupCreationAllowedGroupName,

        [Parameter()]
        [System.Boolean]
        $AllowToAddGuests,

        [Parameter()]
        [System.String]
        $UsageGuidelinesUrl,

        [Parameter()]
        [System.Boolean]
        $NewUnifiedGroupWritebackDefault,

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

    Write-Verbose -Message 'Setting configuration of Azure AD Groups Settings'

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

    $currentPolicy = Get-TargetResource @PSBoundParameters

    # Policy should exist but it doesn't
    $needToUpdate = $false
    if ($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Absent')
    {
        $Policy = New-MgBetaDirectorySetting -TemplateId '62375ab9-6b52-47ed-826b-58e47e0e304b' | Out-Null
        $needToUpdate = $true
    }

    $Policy = Get-MgBetaDirectorySetting | Where-Object -FilterScript { $_.DisplayName -eq 'Group.Unified' }

    if (($Ensure -eq 'Present' -and $currentPolicy.Ensure -eq 'Present') -or $needToUpdate)
    {
        $groupObject = $null
        if (-not [System.String]::IsNullOrEmpty($GroupCreationAllowedGroupName))
        {
            $groupObject = Get-MgGroup -Filter "DisplayName eq '$GroupCreationAllowedGroupName'"
        }
        $groupId = $null
        if ($null -ne $groupObject)
        {
            $groupId = $groupObject.Id
        }
        $index = 0
        foreach ($property in $Policy.Values)
        {
            if ($property.Name -eq 'EnableGroupCreation')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'EnableGroupCreation' }
                $entry.Value = [System.Boolean]$EnableGroupCreation
            }
            elseif ($property.Name -eq 'EnableMIPLabels')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'EnableMIPLabels' }
                $entry.Value = [System.Boolean]$EnableMIPLabels
            }
            elseif ($property.Name -eq 'AllowGuestsToBeGroupOwner')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowGuestsToBeGroupOwner' }
                $entry.Value = [System.Boolean]$AllowGuestsToBeGroupOwner
            }
            elseif ($property.Name -eq 'AllowGuestsToAccessGroups')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowGuestsToAccessGroups' }
                $entry.Value = [System.Boolean]$AllowGuestsToAccessGroups
            }
            elseif ($property.Name -eq 'GuestUsageGuidelinesUrl')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'GuestUsageGuidelinesUrl' }
                $entry.Value = $GuestUsageGuidelinesUrl
            }
            elseif ($property.Name -eq 'GroupCreationAllowedGroupId')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'GroupCreationAllowedGroupId' }
                $entry.Value = $groupId
            }
            elseif ($property.Name -eq 'AllowToAddGuests')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'AllowToAddGuests' }
                $entry.Value = [System.Boolean]$AllowToAddGuests
            }
            elseif ($property.Name -eq 'UsageGuidelinesUrl')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'UsageGuidelinesUrl' }
                $entry.Value = $UsageGuidelinesUrl
            }
            elseif ($property.Name -eq 'NewUnifiedGroupWritebackDefault')
            {
                $entry = $Policy.Values | Where-Object -FilterScript { $_.Name -eq 'NewUnifiedGroupWritebackDefault' }
                $entry.Value = [System.Boolean]$NewUnifiedGroupWritebackDefault
            }
            $index++
        }

        Write-Verbose -Message "Updating Policy's Values with $($Policy.Values | Out-String)"
        Update-MgBetaDirectorySetting -DirectorySettingId $Policy.id -Values $Policy.Values | Out-Null
    }
    elseif ($Ensure -eq 'Absent' -and $currentPolicy.Ensure -eq 'Present')
    {
        Write-Verbose -Message "An existing Directory Setting entry exists, and we don't allow to have it removed."
        throw 'The AADGroupsSettings resource cannot delete existing Directory Setting entries. Please specify Present.'
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
        [ValidateSet('Yes')]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $EnableGroupCreation,

        [Parameter()]
        [System.Boolean]
        $EnableMIPLabels,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToBeGroupOwner,

        [Parameter()]
        [System.Boolean]
        $AllowGuestsToAccessGroups,

        [Parameter()]
        [System.String]
        $GuestUsageGuidelinesUrl,

        [Parameter()]
        [System.String]
        $GroupCreationAllowedGroupName,

        [Parameter()]
        [System.Boolean]
        $AllowToAddGuests,

        [Parameter()]
        [System.String]
        $UsageGuidelinesUrl,

        [Parameter()]
        [System.Boolean]
        $NewUnifiedGroupWritebackDefault,

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

    Write-Verbose -Message 'Testing configuration of AzureAD Groups Settings'

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
        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }

        $Params = @{
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            IsSingleInstance      = 'Yes'
            ApplicationSecret     = $ApplicationSecret
            Credential            = $Credential
            Managedidentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }
        $dscContent = ''
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
