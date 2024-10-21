function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyReviewers,

        [Parameter()]
        [System.Boolean]
        $RemindersEnabled,

        [Parameter()]
        [System.UInt32]
        $RequestDurationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Reviewers,

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

    New-M365DSCConnection -Workload 'MicrosoftGraph' `
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
    try
    {
        $instance = Get-MgBetaPolicyAdminConsentRequestPolicy -ErrorAction Stop
        if ($null -eq $instance)
        {
            throw 'Could not retrieve the Admin Consent Request Policy'
        }

        $reviewersValue = @()
        foreach ($reviewer in $instance.Reviewers)
        {
            if ($reviewer.Query.Contains('/users/'))
            {
                $userId = $reviewer.Query.Split('/')[3]
                $userInfo = Get-MgUser -UserId $userId

                $entry = @{
                    ReviewerType = 'User'
                    ReviewerId   = $userInfo.UserPrincipalName
                }
            }
            elseif ($reviewer.Query.Contains('/groups/'))
            {
                $groupId = $reviewer.Query.Split('/')[3]
                $groupInfo = Get-MgGroup -GroupId $groupId
                $entry = @{
                    ReviewerType = 'Group'
                    ReviewerId   = $groupInfo.DisplayName
                }
            }
            elseif ($reviewer.Query.Contains('directory/roleAssignments?$'))
            {
                $roleId = $reviewer.Query.Replace("/beta/roleManagement/directory/roleAssignments?`$filter=roleDefinitionId eq ", "").Replace("'", '')
                $roleInfo = Get-MgBetaRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleId
                $entry = @{
                    ReviewerType = 'Role'
                    ReviewerId   = $roleInfo.DisplayName
                }
            }
            $reviewersValue += $entry
        }

        $results = @{
            IsSingleInstance      = 'Yes'
            IsEnabled             = $instance.IsEnabled
            NotifyReviewers       = $instance.NotifyReviewers
            RemindersEnabled      = $instance.RemindersEnabled
            RequestDurationInDays = $instance.RequestDurationInDays
            Reviewers             = $reviewersValue
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
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
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyReviewers,

        [Parameter()]
        [System.Boolean]
        $RemindersEnabled,

        [Parameter()]
        [System.UInt32]
        $RequestDurationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Reviewers,

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

    New-M365DSCConnection -Workload 'MicrosoftGraph' `
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

    $reviewerValues = @()
    foreach ($reviewer in $Reviewers)
    {
        if ($reviewer.ReviewerType -eq 'User')
        {
            $userInfo = Get-MgUser -Filter "UserPrincipalName eq '$($reviewer.ReviewerId)'"
            $entry = @{
                query     = "/users/$($userInfo.Id)"
                queryType = 'MicrosoftGraph'
            }
            $reviewerValues += $entry
        }
        elseif ($reviewer.ReviewerType -eq 'Group')
        {
            $groupInfo = Get-MgGroup -Filter "DisplayName eq '$($reviewer.ReviewerId)'"
            $entry = @{
                query     = "/groups/$($groupInfo.Id)/transitiveMembers/microsoft.graph.user"
                queryType = 'MicrosoftGraph'
            }
            $reviewerValues += $entry
        }
        elseif ($reviewer.ReviewerType -eq 'Role')
        {
            $roleInfo = Get-MgBetaRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$($reviewer.ReviewerId)'"
            $entry = @{
                query     = "/roleManagement/directory/roleAssignments?`$filter=roleDefinitionId eq '$($roleInfo.Id.Replace('\u0027', ''))'"
                queryType = 'MicrosoftGraph'
            }
            $reviewerValues += $entry
        }
    }

    $updateParameters = @{
        isEnabled             = $IsEnabled
        reviewers             = $reviewerValues
        notifyReviewers       = $NotifyReviewers
        remindersEnabled      = $RemindersEnabled
        requestDurationInDays = $RequestDurationInDays
    }

    $updateJSON = ConvertTo-Json $updateParameters
    Write-Verbose -Message "Updating the Entra Id Admin Consent Request Policy with values: $updateJSON"
    Invoke-MgGraphRequest -Method 'PUT' `
                          -Uri 'https://graph.microsoft.com/beta/policies/adminConsentRequestPolicy' `
                          -Body $updateJSON | Out-Null
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $IsEnabled,

        [Parameter()]
        [System.Boolean]
        $NotifyReviewers,

        [Parameter()]
        [System.Boolean]
        $RemindersEnabled,

        [Parameter()]
        [System.UInt32]
        $RequestDurationInDays,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Reviewers,

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

    $testResult = $true
    foreach ($reviewer in $Reviewers)
    {
        $currentEquivalent = $CurrentValues.Reviewers | Where-Object -FilterScript {$_.ReviewerId -eq $reviewer.ReviewerId -and $_.ReviewerType -eq $reviewer.ReviewerType}
        if ($null -eq $currentEquivalent)
        {
            $testResult = $false
            Write-Verbose -Message "Couldn't find current reviewer {$($reviewer.ReviewerId)}"
        }
    }

    if ($testResult)
    {
        $ValuesToCheck.Remove('Reviewers') | Out-Null
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

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

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
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
        [array] $Script:exportedInstances = Get-MgBetaPolicyAdminConsentRequestPolicy -ErrorAction Stop

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
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            $displayedKey = 'Policy'
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                IsSingleInstance      = 'Yes'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($Results.Reviewers.Count -gt 0)
            {
                $Results.Reviewers = Get-M365DSCAzureADAAdminConsentPolicyReviewerAsString $Results.Reviewers
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($Results.Reviewers)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Reviewers" -IsCIMArray:$true
            }
            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
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

function Get-M365DSCAzureADAAdminConsentPolicyReviewerAsString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [Array]
        $Reviewers
    )

    $result = "                @(`r`n"
    foreach ($reviewer in $reviewers)
    {
        $result += "                MSFT_AADAdminConsentRequestPolicyReviewer {`r`n"
        $result += "                     ReviewerType = '$($reviewer.ReviewerType)'`r`n"
        $result += "                     ReviewerId   = '$($reviewer.ReviewerId)'`r`n"
        $result += "                     QueryRoot    = '$($reviewer.QueryRoot)'`r`n"
        $result += "                }`r`n"
    }
    $result += '                )'
    return $result
}

Export-ModuleMember -Function *-TargetResource
