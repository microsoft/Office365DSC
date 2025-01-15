function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Exchange', 'SharePoint', 'OneDriveForBusiness')]
        $Workload,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $AccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $ExceptIfAccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.String[]]
        $ExceptIfFrom,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromMemberOf,

        [Parameter()]
        [System.String[]]
        $ExceptIfHeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $ExceptIfRecipientDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderIPRanges,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentTo,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $HeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Low', 'Medium', 'High')]
        $ReportSeverityLevel,

        [Parameter()]
        [System.String]
        [ValidateSet('Ignore', 'RetryThenBlock', $null)]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $SenderDomainIs,

        [Parameter()]
        [System.String[]]
        $SenderIPRanges,

        [Parameter()]
        [System.String[]]
        $SentTo,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $SubjectMatchesPatterns,

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
            Write-Verbose -Message "Getting configuration of DLPCompliancePolicy for $Name"
            $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
                -InboundParameters $PSBoundParameters

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
            $PolicyRule = Get-AutoSensitivityLabelRule -Identity $Name -ErrorAction SilentlyContinue

            if ($null -eq $PolicyRule)
            {
                Write-Verbose -Message "AutoSensitivityLabelRule $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $PolicyRule = $Script:exportedInstance
        }

        Write-Verbose "Found existing AutoSensitivityLabelRule $($Name)"

        if ($null -ne $PolicyRule.AnyOfRecipientAddressContainsWords -and $PolicyRule.AnyOfRecipientAddressContainsWords.count -gt 0)
        {
            $AnyOfRecipientAddressContainsWords = $PolicyRule.AnyOfRecipientAddressContainsWords.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.AnyOfRecipientAddressMatchesPatterns -and $PolicyRule.AnyOfRecipientAddressMatchesPatterns -gt 0)
        {
            $AnyOfRecipientAddressMatchesPatterns = $PolicyRule.AnyOfRecipientAddressMatchesPatterns.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.ContentExtensionMatchesWords -and $PolicyRule.ContentExtensionMatchesWords.count -gt 0)
        {
            $ContentExtensionMatchesWords = $PolicyRule.ContentExtensionMatchesWords.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.ExceptIfContentExtensionMatchesWords -and $PolicyRule.ExceptIfContentExtensionMatchesWords.count -gt 0)
        {
            $ExceptIfContentExtensionMatchesWords = $PolicyRule.ExceptIfContentExtensionMatchesWords.Replace(' ', '').Split(',')
        }
        if ($null -ne $HeaderMatchesPatterns -and $null -ne $HeaderMatchesPatterns.Name)
        {
            $HeaderMatchesPatternsValue = @{}
            foreach ($value in $HeaderMatchesPatterns[($HeaderMatchesPatterns.Name)])
            {
                if ($HeaderMatchesPatternsValue.ContainsKey($HeaderMatchesPatterns.Name))
                {
                    $HeaderMatchesPatternsValue[$HeaderMatchesPatterns.Name] += $value
                }
                else
                {
                    $HeaderMatchesPatternsValue.Add($HeaderMatchesPatterns.Name, @($value))
                }
            }
        }
        foreach ($pattern in $PolicyRule.HeaderMatchesPatterns.Keys)
        {
            $HeaderMatchesPatternsValue += @{
                Name  = $pattern
                Value = $PolicyRule.HeaderMatchesPatterns.$pattern
            }
        }

        $result = @{
            Name                                         = $PolicyRule.Name
            Policy                                       = $PolicyRule.ParentPolicyName
            Workload                                     = $Workload
            AccessScope                                  = $PolicyRule.AccessScope
            AnyOfRecipientAddressContainsWords           = $AnyOfRecipientAddressContainsWords
            AnyOfRecipientAddressMatchesPatterns         = $AnyOfRecipientAddressMatchesPatterns
            Comment                                      = $PolicyRule.Comment
            ContentContainsSensitiveInformation          = $PolicyRule.ContentContainsSensitiveInformation
            ContentExtensionMatchesWords                 = $ContentExtensionMatchesWords
            Disabled                                     = $PolicyRule.Disabled
            DocumentIsPasswordProtected                  = $PolicyRule.DocumentIsPasswordProtected
            DocumentIsUnsupported                        = $PolicyRule.DocumentIsUnsupported
            ExceptIfAccessScope                          = $PolicyRule.ExceptIfAccessScope
            ExceptIfAnyOfRecipientAddressContainsWords   = $PolicyRule.ExceptIfAnyOfRecipientAddressContainsWords
            ExceptIfAnyOfRecipientAddressMatchesPatterns = $PolicyRule.ExceptIfAnyOfRecipientAddressMatchesPatterns
            ExceptIfContentContainsSensitiveInformation  = $PolicyRule.ExceptIfContentContainsSensitiveInformation
            ExceptIfContentExtensionMatchesWords         = $ExceptIfContentExtensionMatchesWords
            ExceptIfDocumentIsPasswordProtected          = $PolicyRule.ExceptIfDocumentIsPasswordProtected
            ExceptIfDocumentIsUnsupported                = $PolicyRule.ExceptIfDocumentIsUnsupported
            ExceptIfFrom                                 = $PolicyRule.ExceptIfFrom
            ExceptIfFromAddressContainsWords             = $PolicyRule.ExceptIfFromAddressContainsWords
            ExceptIfFromAddressMatchesPatterns           = $PolicyRule.ExceptIfFromAddressMatchesPatterns
            ExceptIfFromMemberOf                         = $PolicyRule.ExceptIfFromMemberOf
            ExceptIfHeaderMatchesPatterns                = $PolicyRule.ExceptIfHeaderMatchesPatterns
            ExceptIfProcessingLimitExceeded              = $PolicyRule.ExceptIfProcessingLimitExceeded
            ExceptIfRecipientDomainIs                    = $PolicyRule.ExceptIfRecipientDomainIs
            ExceptIfSenderDomainIs                       = $PolicyRule.ExceptIfSenderDomainIs
            ExceptIfSenderIPRanges                       = $PolicyRule.ExceptIfSenderIPRanges
            ExceptIfSentTo                               = $PolicyRule.ExceptIfSentTo
            ExceptIfSentToMemberOf                       = $PolicyRule.ExceptIfSentToMemberOf
            ExceptIfSubjectMatchesPatterns               = $PolicyRule.ExceptIfSubjectMatchesPatterns
            FromAddressContainsWords                     = $PolicyRule.FromAddressContainsWords
            FromAddressMatchesPatterns                   = $PolicyRule.FromAddressMatchesPatterns
            HeaderMatchesPatterns                        = $HeaderMatchesPatternsValue
            ProcessingLimitExceeded                      = $PolicyRule.ProcessingLimitExceeded
            RecipientDomainIs                            = $PolicyRule.RecipientDomainIs
            ReportSeverityLevel                          = $PolicyRule.ReportSeverityLevel
            RuleErrorAction                              = $PolicyRule.RuleErrorAction
            SenderDomainIs                               = $PolicyRule.SenderDomainIs
            SenderIPRanges                               = $PolicyRule.SenderIPRanges
            SentTo                                       = $PolicyRule.SentTo
            SentToMemberOf                               = $PolicyRule.SentToMemberOf
            SubjectMatchesPatterns                       = $PolicyRule.SubjectMatchesPatterns
            Ensure                                       = 'Present'
            Credential                                   = $Credential
            ApplicationId                                = $ApplicationId
            TenantId                                     = $TenantId
            CertificateThumbprint                        = $CertificateThumbprint
            CertificatePath                              = $CertificatePath
            CertificatePassword                          = $CertificatePassword
            AccessTokens                                 = $AccessTokens
        }

        $paramsToRemove = @()
        foreach ($paramName in $result.Keys)
        {
            if ($null -eq $result[$paramName] -or '' -eq $result[$paramName] -or @() -eq $result[$paramName])
            {
                $paramsToRemove += $paramName
            }
        }

        foreach ($paramName in $paramsToRemove)
        {
            $result.Remove($paramName)
        }

        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
        return $result
    }
    catch
    {
        Write-Error $_
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

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Exchange', 'SharePoint', 'OneDriveForBusiness')]
        $Workload,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $AccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $ExceptIfAccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.String[]]
        $ExceptIfFrom,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromMemberOf,

        [Parameter()]
        [System.String[]]
        $ExceptIfHeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $ExceptIfRecipientDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderIPRanges,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentTo,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $HeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Low', 'Medium', 'High')]
        $ReportSeverityLevel,

        [Parameter()]
        [System.String]
        [ValidateSet('Ignore', 'RetryThenBlock', $null)]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $SenderDomainIs,

        [Parameter()]
        [System.String[]]
        $SenderIPRanges,

        [Parameter()]
        [System.String[]]
        $SentTo,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $SubjectMatchesPatterns,

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

    Write-Verbose -Message "Setting configuration of DLPComplianceRule for $Name"

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

    $CurrentRule = Get-TargetResource @PSBoundParameters

    if ($null -ne $HeaderMatchesPatterns -and $null -ne $HeaderMatchesPatterns.Name)
    {
        $HeaderMatchesPatternsValue = @{}
        $HeaderMatchesPatternsValue.Add($HeaderMatchesPatterns.Name, $HeaderMatchesPatterns.Values)
    }
    if (('Present' -eq $Ensure) -and ('Absent' -eq $CurrentRule.Ensure))
    {
        Write-Verbose "Rule {$($CurrentRule.Name)} doesn't exists but need to. Creating Rule."
        $CreationParams = $PSBoundParameters
        if ($null -ne $CreationParams.ContentContainsSensitiveInformation)
        {
            $value = @()
            foreach ($item in $CreationParams.ContentContainsSensitiveInformation)
            {
                if ($null -ne $item.groups)
                {
                    $value += Get-SCDLPSensitiveInformationGroups $item
                }
                else
                {
                    $value += Get-SCDLPSensitiveInformation $item
                }
            }
            $CreationParams.ContentContainsSensitiveInformation = $value
        }

        if ($null -ne $CreationParams.ExceptIfContentContainsSensitiveInformation)
        {
            $value = @()
            foreach ($item in $CreationParams.ExceptIfContentContainsSensitiveInformation)
            {
                if ($null -ne $item.groups)
                {
                    $value += Get-SCDLPSensitiveInformationGroups $item
                }
                else
                {
                    $value += Get-SCDLPSensitiveInformation $item
                }
            }
            $CreationParams.ExceptIfContentContainsSensitiveInformation = $value
        }

        $CreationParams.Remove('Ensure')

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

        Write-Verbose -Message 'Flipping the parent policy to Mode = TestWithoutNotification while we create the rule'
        $parentPolicy = Get-AutoSensitivityLabelPolicy -Identity $Policy
        $currentMode = $parentPolicy.Mode
        Set-AutoSensitivityLabelPolicy -Identity $Policy -Mode 'TestWithoutNotifications'

        Write-Verbose -Message "Calling New-AutoSensitivityLabelRule with Values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        if ($null -ne $HeaderMatchesPatternsValue)
        {
            $CreationParams.HeaderMatchesPatterns = $HeaderMatchesPatternsValue
        }
        New-AutoSensitivityLabelRule @CreationParams

        Write-Verbose -Message "Flipping the parent policy to Mode back to $currentMode while we create the rule"
        Set-AutoSensitivityLabelPolicy -Identity $Policy -Mode $currentMode
    }
    elseif (('Present' -eq $Ensure) -and ('Present' -eq $CurrentRule.Ensure))
    {
        Write-Verbose "Rule {$($CurrentRule.Name)} already exists and needs to. Updating Rule."
        $UpdateParams = $PSBoundParameters

        if ($null -ne $UpdateParams.ContentContainsSensitiveInformation)
        {
            $value = @()
            foreach ($item in $UpdateParams.ContentContainsSensitiveInformation)
            {
                if ($null -ne $item.groups)
                {
                    $value += Get-SCDLPSensitiveInformationGroups $item
                }
                else
                {
                    $value += Get-SCDLPSensitiveInformation $item
                }
            }
            $UpdateParams.ContentContainsSensitiveInformation = $value
        }

        if ($null -ne $UpdateParams.ExceptIfContentContainsSensitiveInformation)
        {
            $value = @()
            foreach ($item in $UpdateParams.ExceptIfContentContainsSensitiveInformation)
            {
                if ($null -ne $item.groups)
                {
                    $value += Get-SCDLPSensitiveInformationGroups $item
                }
                else
                {
                    $value += Get-SCDLPSensitiveInformation $item
                }
            }
            $UpdateParams.ExceptIfContentContainsSensitiveInformation = $value
        }

        $UpdateParams.Remove('Ensure') | Out-Null
        $UpdateParams.Remove('Name') | Out-Null
        $UpdateParams.Remove('Policy') | Out-Null
        $UpdateParams.Add('Identity', $Name)

        # Remove authentication parameters
        $UpdateParams.Remove('Credential') | Out-Null
        $UpdateParams.Remove('ApplicationId') | Out-Null
        $UpdateParams.Remove('TenantId') | Out-Null
        $UpdateParams.Remove('CertificatePath') | Out-Null
        $UpdateParams.Remove('CertificatePassword') | Out-Null
        $UpdateParams.Remove('CertificateThumbprint') | Out-Null
        $UpdateParams.Remove('ManagedIdentity') | Out-Null
        $UpdateParams.Remove('ApplicationSecret') | Out-Null
        $UpdateParams.Remove('AccessTokens') | Out-Null

        Write-Verbose -Message 'Flipping the parent policy to Mode = TestWithoutNotification while we editing the rule'
        $parentPolicy = Get-AutoSensitivityLabelPolicy -Identity $Policy
        $currentMode = $parentPolicy.Mode
        Set-AutoSensitivityLabelPolicy -Identity $Policy -Mode 'TestWithoutNotifications'

        if ($null -ne $HeaderMatchesPatternsValue)
        {
            $UpdateParams.HeaderMatchesPatterns = $HeaderMatchesPatternsValue
        }
        Write-Verbose "Updating Rule with values: $(Convert-M365DscHashtableToString -Hashtable $UpdateParams)"
        Set-AutoSensitivityLabelRule @UpdateParams

        Write-Verbose -Message "Flipping the parent policy to Mode back to $currentMode while we create the rule"
        Set-AutoSensitivityLabelPolicy -Identity $Policy -Mode $currentMode
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentRule.Ensure))
    {
        Write-Verbose "Rule {$($CurrentRule.Name)} already exists but shouldn't. Deleting Rule."
        Remove-AutoSensitivityLabelRule -Identity $CurrentRule.Name -Confirm:$false
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

        [Parameter(Mandatory = $true)]
        [System.String]
        $Policy,

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Exchange', 'SharePoint', 'OneDriveForBusiness')]
        $Workload,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $AccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.String]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        $ExceptIfAccessScope,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.String[]]
        $ExceptIfFrom,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromMemberOf,

        [Parameter()]
        [System.String[]]
        $ExceptIfHeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $ExceptIfRecipientDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderDomainIs,

        [Parameter()]
        [System.String[]]
        $ExceptIfSenderIPRanges,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentTo,

        [Parameter()]
        [System.String[]]
        $ExceptIfSentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $HeaderMatchesPatterns,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

        [Parameter()]
        [System.String]
        [ValidateSet('None', 'Low', 'Medium', 'High')]
        $ReportSeverityLevel,

        [Parameter()]
        [System.String]
        [ValidateSet('Ignore', 'RetryThenBlock', $null)]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $SenderDomainIs,

        [Parameter()]
        [System.String[]]
        $SenderIPRanges,

        [Parameter()]
        [System.String[]]
        $SentTo,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String]
        [ValidateLength(0, 128)]
        $SubjectMatchesPatterns,

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
    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of AutoSensitivityLabelRule for $Name"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters

    #region Test Sensitive Information Type
    # For each Desired SIT check to see if there is an existing rule with the same name
    if ($null -ne $ValuesToCheck['ContentContainsSensitiveInformation'])
    {
        if ($null -ne $ValuesToCheck['ContentContainsSensitiveInformation'].groups)
        {
            $contentSITS = Get-SCDLPSensitiveInformationGroups -SensitiveInformation $ValuesToCheck['ContentContainsSensitiveInformation']
            $desiredState = Test-ContainsSensitiveInformationGroups -targetValues $contentSITS -sourceValue $CurrentValues.ContentContainsSensitiveInformation
        }
        else
        {
            $contentSITS = Get-SCDLPSensitiveInformation -SensitiveInformation $ValuesToCheck['ContentContainsSensitiveInformation']
            $desiredState = Test-ContainsSensitiveInformation -targetValues $contentSITS -sourceValue $CurrentValues.ContentContainsSensitiveInformation
        }
    }

    if ($desiredState -eq $false)
    {
        Write-Verbose -Message "Test-TargetResource returned $desiredState"
        return $false
    }

    if ($null -ne $ValuesToCheck['ExceptIfContentContainsSensitiveInformation'])
    {
        if ($null -ne $ValuesToCheck['ExceptIfContentContainsSensitiveInformation'].groups)
        {
            $contentSITS = Get-SCDLPSensitiveInformationGroups -SensitiveInformation $ValuesToCheck['ExceptIfContentContainsSensitiveInformation']
            $desiredState = Test-ContainsSensitiveInformationGroups -targetValues $contentSITS -sourceValue $CurrentValues.ExceptIfContentContainsSensitiveInformation
        }
        else
        {
            $contentSITS = Get-SCDLPSensitiveInformation -SensitiveInformation $ValuesToCheck['ExceptIfContentContainsSensitiveInformation']
            $desiredState = Test-ContainsSensitiveInformation -targetValues $contentSITS -sourceValue $CurrentValues.ExceptIfContentContainsSensitiveInformation
        }
    }

    if ($desiredState -eq $false)
    {
        Write-Verbose -Message "Test-TargetResource returned $desiredState"
        return $false
    }

    #endregion
    $ValuesToCheck.Remove('ContentContainsSensitiveInformation') | Out-Null
    $ValuesToCheck.Remove('ExceptIfContentContainsSensitiveInformation') | Out-Null

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
        [array]$rules = Get-AutoSensitivityLabelRule -ErrorAction Stop | Where-Object { $_.Mode -ne 'PendingDeletion' }

        $i = 1
        $dscContent = ''
        if ($rules.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }

        foreach ($rule in $rules)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }

            Write-Host "    |---[$i/$($rules.Length)] $($rule.Name)" -NoNewline
            $Script:exportedInstance = $rule
            $Results = Get-TargetResource @PSBoundParameters `
                -Name $rule.name `
                -Policy $rule.ParentPolicyName `
                -Workload $rule.LogicalWorkload

            $IsCIMArray = $false
            $IsSitCIMArray = $false

            if ($Results.ContentContainsSensitiveInformation.Length -gt 1)
            {
                $IsSitCIMArray = $true
            }

            if ($Results.ExceptIfContentContainsSensitiveInformation.Length -gt 1)
            {
                $IsCIMArray = $true
            }

            if ($null -ne $Results.ContentContainsSensitiveInformation)
            {
                if ($null -ne $results.ContentContainsSensitiveInformation.Groups)
                {
                    $Results.ContentContainsSensitiveInformation = ConvertTo-SCDLPSensitiveInformationStringGroup -InformationArray $Results.ContentContainsSensitiveInformation
                }
                else
                {
                    $Results.ContentContainsSensitiveInformation = ConvertTo-SCDLPSensitiveInformationString -InformationArray $Results.ContentContainsSensitiveInformation
                }
            }

            if ($null -ne $Results.ExceptIfContentContainsSensitiveInformation)
            {
                if ($null -ne $results.ExceptIfContentContainsSensitiveInformation.Groups)
                {
                    $Results.ExceptIfContentContainsSensitiveInformation = ConvertTo-SCDLPSensitiveInformationStringGroup -InformationArray $Results.ExceptIfContentContainsSensitiveInformation
                }
                else
                {
                    $Results.ExceptIfContentContainsSensitiveInformation = ConvertTo-SCDLPSensitiveInformationString -InformationArray $Results.ExceptIfContentContainsSensitiveInformation
                }
            }

            $IsHeaderPatternsCIMArray = $false
            if ($null -ne $Results.HeaderMatchesPatterns -and $null -ne $Results.HeaderMatchesPatterns.Name)
            {
                $Results.HeaderMatchesPatterns = ConvertTo-HeadersMatchesPatternString -Patterns $Results.HeaderMatchesPatterns
            }

            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($null -ne $Results.ContentContainsSensitiveInformation )
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ContentContainsSensitiveInformation' -IsCIMArray $IsSitCIMArray
            }
            if ($null -ne $Results.ExceptIfContentContainsSensitiveInformation )
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'ExceptIfContentContainsSensitiveInformation' -IsCIMArray $IsCIMArray
            }
            if ($null -ne $Results.HeaderMatchesPatterns)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName 'HeaderMatchesPatterns' -IsCIMArray $false
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
        if ($_.Exception.Message -like '*is not recognized as the name of a cmdlet*')
        {
            Write-Host "`r`n    $($Global:M365DSCEmojiYellowCircle) The current tenant is not registered for this feature."
        }
        else
        {
            Write-Host $Global:M365DSCEmojiRedX

            New-M365DSCLogEntry -Message 'Error during Export:' `
                -Exception $_ `
                -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $TenantId `
                -Credential $Credential
        }

        return ''
    }
}

function ConvertTo-HeadersMatchesPatternString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $Patterns
    )
    $result = ''

    $result = "`r`n                MSFT_SCHeaderPattern`r`n                {`r`n"
    $result += "                        Name   = '$($Patterns.Name)'`r`n"
    $result += '                        Values = @('
    foreach ($value in $Patterns.Value)
    {
        $result += "'$($value.Replace("'", "''"))',"
    }
    $result = $result.Substring(0, $result.Length - 1) + ")`r`n"
    $result += "                }`r`n"
    return $result
}
function ConvertTo-SCDLPSensitiveInformationStringGroup
{
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $InformationArray
    )
    $result = ''

    foreach ($SensitiveInformationHash in $InformationArray)
    {
        $StringContent = "MSFT_SCDLPContainsSensitiveInformation {`r`n"
        if ($null -ne $InformationArray.Groups)
        {
            $StringContent += "                operator = '$($SensitiveInformationHash.operator.Replace("'", "''"))'`r`n"
            $StringContent += "                Groups = @(`r`n"
        }
        foreach ($group in $SensitiveInformationHash.Groups)
        {
            $StringContent += "                    MSFT_SCDLPContainsSensitiveInformationGroup {`r`n"
            $StringContent += "                        operator = '$($group.operator.Replace("'", "''"))'`r`n"
            $StringContent += "                        name = '$($group.name.Replace("'", "''"))'`r`n"
            if ($null -ne $group.sensitivetypes)
            {
                $StringContent += "                        SensitiveInformation = @(`r`n"
                foreach ($sit in $group.sensitivetypes)
                {
                    $StringContent += "                            MSFT_SCDLPSensitiveInformation {`r`n"
                    $StringContent += "                                name = '$($sit.name.Replace("'", "''"))'`r`n"
                    if ($null -ne $sit.id)
                    {
                        $StringContent += "                                id = '$($sit.id)'`r`n"
                    }

                    if ($null -ne $sit.maxconfidence)
                    {
                        $StringContent += "                                maxconfidence = '$($sit.maxconfidence)'`r`n"
                    }

                    if ($null -ne $sit.minconfidence)
                    {
                        $StringContent += "                                minconfidence = '$($sit.minconfidence)'`r`n"
                    }

                    if ($null -ne $sit.classifiertype)
                    {
                        $StringContent += "                                classifiertype = '$($sit.classifiertype)'`r`n"
                    }

                    if ($null -ne $sit.mincount)
                    {
                        $StringContent += "                                mincount = '$($sit.mincount)'`r`n"
                    }

                    if ($null -ne $sit.maxcount)
                    {
                        $StringContent += "                                maxcount = '$($sit.maxcount)'`r`n"
                    }

                    $StringContent += "                            }`r`n"
                }
                $StringContent += "                        )`r`n"
                $StringContent += "                    }`r`n"
            }
            if ($null -ne $group.labels)
            {
                $StringContent += "                        labels = @(`r`n"
                foreach ($label in $group.labels)
                {
                    $StringContent += "                            MSFT_SCDLPLabel {`r`n"
                    $StringContent += "                                name = '$($label.name.Replace("'", "''"))'`r`n"
                    if ($null -ne $label.id)
                    {
                        $StringContent += "                                id = '$($label.id)'`r`n"
                    }

                    if ($null -ne $label.type)
                    {
                        $StringContent += "                                type = '$($label.type)'`r`n"
                    }

                    $StringContent += "                            }`r`n"
                }
                $StringContent += "                        )`r`n"
                $StringContent += "                    }`r`n"
            }
        }
        $StringContent += "                )`r`n"
        $StringContent += "            }`r`n"
        $result += $StringContent
    }
    return $result
}
function ConvertTo-SCDLPSensitiveInformationString
{
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $InformationArray
    )
    $result = ''
    $StringContent = "MSFT_SCDLPContainsSensitiveInformation {`r`n"
    $StringContent += '                SensitiveInformation = '
    $StringContent += "@(`r`n"
    $result += $StringContent
    foreach ($SensitiveInformationHash in $InformationArray)
    {

        $StringContent = "                    MSFT_SCDLPSensitiveInformation`r`n                    {`r`n"
        $StringContent += "                        name = '$($SensitiveInformationHash.name.Replace("'", "''"))'`r`n"

        if ($null -ne $SensitiveInformationHash.id)
        {
            $StringContent += "                        id = '$($SensitiveInformationHash.id)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.maxconfidence)
        {
            $StringContent += "                        maxconfidence = '$($SensitiveInformationHash.maxconfidence)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.minconfidence)
        {
            $StringContent += "                        minconfidence = '$($SensitiveInformationHash.minconfidence)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.classifiertype)
        {
            $StringContent += "                        classifiertype = '$($SensitiveInformationHash.classifiertype)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.mincount)
        {
            $StringContent += "                        mincount = '$($SensitiveInformationHash.mincount)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.maxcount)
        {
            $StringContent += "                        maxcount = '$($SensitiveInformationHash.maxcount)'`r`n"
        }

        $StringContent += "                    }`r`n"
        $result += $StringContent
    }
    $result += "                )`r`n"
    $result += "            }`r`n"
    return $result
}


function Get-SCDLPSensitiveInformation
{
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $SensitiveInformationItems
    )

    $returnValue = @()

    foreach ($item in $SensitiveInformationItems.SensitiveInformation)
    {
        $result = @{
            name = $item.name
        }

        if ($null -ne $item.id)
        {
            $result.Add('id', $item.id)
        }

        if ($null -ne $item.maxconfidence)
        {
            $result.Add('maxconfidence', $item.maxconfidence)
        }

        if ($null -ne $item.minconfidence)
        {
            $result.Add('minconfidence', $item.minconfidence)
        }

        if ($null -ne $item.classifiertype)
        {
            $result.Add('classifiertype', $item.classifiertype)
        }

        if ($null -ne $item.mincount)
        {
            $result.Add('mincount', $item.mincount)
        }

        if ($null -ne $item.maxcount)
        {
            $result.Add('maxcount', $item.maxcount)
        }
        $returnValue += $result
    }
    return $returnValue
}

function Get-SCHeaderPatternsAsObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $Patterns
    )
    $returnValue = @{
        $Patterns.Name = $Patterns.Value
    }
    return $returnValue
}

function Get-SCDLPSensitiveInformationGroups
{
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $SensitiveInformationGroups
    )

    $returnValue = @()
    $sits = @()
    $groups = @()

    $result = @{
        operator = $SensitiveInformationGroups.operator
    }

    foreach ($group in $SensitiveInformationGroups.groups)
    {
        $myGroup = @{
            name = $group.name
        }
        if ($null -ne $group.operator)
        {
            $myGroup.Add('operator', $group.operator)
        }
        $sits = @()
        foreach ($item in $group.SensitiveInformation)
        {
            $sit = @{
                name = $item.name
            }

            if ($null -ne $item.id)
            {
                $sit.Add('id', $item.id)
            }

            if ($null -ne $item.maxconfidence)
            {
                $sit.Add('maxconfidence', $item.maxconfidence)
            }

            if ($null -ne $item.minconfidence)
            {
                $sit.Add('minconfidence', $item.minconfidence)
            }

            if ($null -ne $item.classifiertype)
            {
                $sit.Add('classifiertype', $item.classifiertype)
            }

            if ($null -ne $item.mincount)
            {
                $sit.Add('mincount', $item.mincount)
            }

            if ($null -ne $item.maxcount)
            {
                $sit.Add('maxcount', $item.maxcount)
            }
            $sits += $sit
        }
        if ($sits.Length -gt 0)
        {
            $myGroup.Add('sensitivetypes', $sits)
        }
        $labels = @()
        foreach ($item in $group.labels)
        {
            $label = @{
                name = $item.name
            }

            if ($null -ne $item.id)
            {
                $label.Add('id', $item.id)
            }

            if ($null -ne $item.type)
            {
                $label.Add('type', $item.type)
            }
            $labels += $label
        }
        if ($labels.Length -gt 0)
        {
            $myGroup.Add('labels', $labels)
        }
        $groups += $myGroup
    }
    $result.Add('groups', $groups)
    $returnValue += $result
    return $returnValue
}

function Test-ContainsSensitiveInformation
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $targetValues,

        [Parameter()]
        [System.Object[]]
        $sourceValues
    )

    foreach ($sit in $targetValues)
    {
        Write-Verbose -Message "Trying to find existing Sensitive Information Action matching name {$($sit.name)}"
        $matchingExistingRule = $sourceValues | Where-Object -FilterScript { $_.name -eq $sit.name }

        if ($null -ne $matchingExistingRule)
        {
            Write-Verbose -Message "Sensitive Information Action {$($sit.name)} was found"
            $propertiesTocheck = @('id', 'maxconfidence', 'minconfidence', 'classifiertype', 'mincount', 'maxcount')

            foreach ($property in $propertiesToCheck)
            {
                Write-Verbose -Message "Checking property {$property} for Sensitive Information Action {$($sit.name)}"
                if ($sit.$property -ne $matchingExistingRule.$property)
                {
                    Write-Verbose -Message "Property {$property} is set to {$($matchingExistingRule.$property)} and is expected to be {$($sit.$property)}."
                    $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                        "Sensitive Information Action {$($sit.name)} has invalid value for property {$property}. " + `
                        "Current value is {$($matchingExistingRule.$property)} and is expected to be {$($sit.$property)}."
                    Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                        -EventID 1 -Source $($MyInvocation.MyCommand.Source)
                    return $false
                }
            }
        }
        else
        {
            Write-Verbose -Message "Sensitive Information Action {$($sit.name)} was not found"
            $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                "An action on {$($sit.name)} Sensitive Information Type is missing."
            Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source)
            return $false
        }
    }
}

function Test-ContainsSensitiveInformationLabels
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $targetValues,

        [Parameter()]
        [System.Object[]]
        $sourceValues
    )

    foreach ($sit in $targetValues)
    {
        Write-Verbose -Message "Trying to find existing Sensitive Information labels matching name {$($sit.name)}"
        $matchingExistingRule = $sourceValues | Where-Object -FilterScript { $_.name -eq $sit.name }

        if ($null -ne $matchingExistingRule)
        {
            Write-Verbose -Message "Sensitive Information label {$($sit.name)} was found"
            $propertiesTocheck = @('id', 'type')

            foreach ($property in $propertiesToCheck)
            {
                Write-Verbose -Message "Checking property {$property} for Sensitive Information label {$($sit.name)}"
                if ($sit.$property -ne $matchingExistingRule.$property)
                {
                    Write-Verbose -Message "Property {$property} is set to {$($matchingExistingRule.$property)} and is expected to be {$($sit.$property)}."
                    $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                        "Sensitive Information Action {$($sit.name)} has invalid value for property {$property}. " + `
                        "Current value is {$($matchingExistingRule.$property)} and is expected to be {$($sit.$property)}."
                    Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                        -EventID 1 -Source $($MyInvocation.MyCommand.Source)
                    return $false
                }
            }
        }
        else
        {
            Write-Verbose -Message "Sensitive Information label {$($sit.name)} was not found"
            $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                "An action on {$($sit.name)} Sensitive Information label is missing."
            Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source)
            return $false
        }
    }
}

function Test-ContainsSensitiveInformationGroups
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Object[]]
        $targetValues,

        [Parameter()]
        [System.Object[]]
        $sourceValues
    )

    if ($targetValues.operator -ne $sourceValues.operator)
    {
        $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
            "DLP Compliance Rule {$Name} has invalid value for property operator. " + `
            "Current value is {$($targetValues.$operator)} and is expected to be {$($sourceValues.$operator)}."
        Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
            -EventID 1 -Source $($MyInvocation.MyCommand.Source)
        return $false
    }

    foreach ($group in $targetValues.groups)
    {
        $matchingExistingGroup = $sourceValues.groups | Where-Object -FilterScript { $_.name -eq $group.name }

        if ($null -ne $matchingExistingGroup)
        {
            Write-Verbose -Message "ContainsSensitiveInformationGroup {$($group.name)} was found"
            if ($group.operator -ne $matchingExistingGroup.operator)
            {
                $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                    "Group {$($group.name)} has invalid value for property operator. " + `
                    "Current value is {$($matchingExistingRule.$operator)} and is expected to be {$($group.$operator)}."
                Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                    -EventID 1 -Source $($MyInvocation.MyCommand.Source)
                return $false
            }
        }
        else
        {
            Write-Verbose -Message "Sensitive Information Action {$($group.name)} was not found"
            $EventMessage = "DLP Compliance Rule {$Name} was not in the desired state.`r`n" + `
                "An action on {$($sit.name)} Sensitive Information Type is missing."
            Add-M365DSCEvent -Message $EventMessage -EntryType 'Warning' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source)
            return $false
        }

        if ($null -ne $group.sensitivetypes)
        {
            $desiredState = Test-ContainsSensitiveInformation -targetValues $group.sensitivetypes `
                -sourceValues $matchingExistingGroup.sensitivetypes
            if ($desiredState -eq $false)
            {
                return $false
            }
        }

        if ($null -ne $group.labels)
        {
            $desiredState = Test-ContainsSensitiveInformationLabels -targetValues $group.labels `
                -sourceValues $matchingExistingGroup.labels
            if ($desiredState -eq $false)
            {
                return $false
            }
        }
    }
}

Export-ModuleMember -Function *-TargetResource
