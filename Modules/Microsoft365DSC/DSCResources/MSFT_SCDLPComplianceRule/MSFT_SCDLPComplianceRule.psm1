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

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        [System.String]
        $AccessScope,

        [Parameter()]
        [System.Boolean]
        $BlockAccess,

        [Parameter()]
        [ValidateSet('All', 'PerUser', 'None')]
        [System.String]
        $BlockAccessScope,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String]
        $AdvancedRule,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentPropertyContainsWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String[]]
        $GenerateAlert,

        [Parameter()]
        [System.String[]]
        $GenerateIncidentReport,

        [Parameter()]
        [ValidateSet('All', 'Default', 'DetectionDetails', 'Detections', 'DocumentAuthor', 'DocumentLastModifier', 'MatchedItem', 'OriginalContent', 'RulesMatched', 'Service', 'Severity', 'Title', 'RetentionLabel', 'SensitivityLabel')]
        [System.String[]]
        $IncidentReportContent,

        [Parameter()]
        [ValidateSet('FalsePositive', 'WithoutJustification', 'WithJustification')]
        [System.String[]]
        $NotifyAllowOverride,

        [Parameter()]
        [System.String]
        $NotifyEmailCustomText,

        [Parameter()]
        [System.String]
        $NotifyPolicyTipCustomText,

        [Parameter()]
        [System.String[]]
        $NotifyUser,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'None')]
        [System.String]
        $ReportSeverityLevel,

        [Parameter()]
        [ValidateSet('Ignore', 'RetryThenBlock')]
        [System.String]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $RemoveRMSTemplate,

        [Parameter()]
        [System.Boolean]
        $StopPolicyProcessing,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $HasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ExceptIfHasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.String[]]
        $MessageTypeMatches,

        [Parameter()]
        [System.String[]]
        $ExceptIfMessageTypeMatches,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $FromScope,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $ExceptIfFromScope,

        [Parameter()]
        [System.String[]]
        $SubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentPropertyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

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
        $ExceptIfSubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String[]]
        $DocumentContainsWords,

        [Parameter()]
        [System.String[]]
        $SetHeader,

        [Parameter()]
        [System.Boolean]
        $ContentIsNotLabeled,

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

            $PolicyRule = Get-DlpComplianceRule -Identity $Name -ErrorAction SilentlyContinue

            if ($null -eq $PolicyRule)
            {
                Write-Verbose -Message "DLPComplianceRule $($Name) does not exist."
                return $nullReturn
            }
        }
        else
        {
            $PolicyRule = $Script:exportedInstance
        }

        Write-Verbose "Found existing DLPComplianceRule $($Name)"

        # Cmdlet returns a string, but in order to properly validate valid values, we need to convert
        # to a String array
        $ArrayIncidentReportContent = @()

        if ($null -ne $PolicyRule.IncidentReportContent)
        {
            $ArrayIncidentReportContent = $PolicyRule.IncidentReportContent.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.NotifyAllowOverride)
        {
            $NotifyAllowOverrideValue = $PolicyRule.NotifyAllowOverride.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.AnyOfRecipientAddressContainsWords -and $PolicyRule.AnyOfRecipientAddressContainsWords.count -gt 0)
        {
            $AnyOfRecipientAddressContainsWords = $PolicyRule.AnyOfRecipientAddressContainsWords.Replace(' ', '').Split(',')
        }

        if ($null -ne $PolicyRule.ExceptIfAnyOfRecipientAddressContainsWords -and $PolicyRule.ExceptIfAnyOfRecipientAddressContainsWords.count -gt 0)
        {
            $ExceptIfAnyOfRecipientAddressContainsWords = $PolicyRule.ExceptIfAnyOfRecipientAddressContainsWords.Replace(' ', '').Split(',')
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

        if ($null -ne $PolicyRule.AdvancedRule -and $PolicyRule.AdvancedRule.Count -gt 0)
        {
            $ruleobject = $PolicyRule.AdvancedRule | ConvertFrom-Json
            $index = $ruleobject.Condition.SubConditions.ConditionName.IndexOf('ContentContainsSensitiveInformation')
            if ($index -ne -1)
            {
                if ($null -eq $ruleobject.Condition.SubConditions[$index].value.groups)
                {
                    $ruleobject.Condition.SubConditions[$index].Value = $ruleobject.Condition.SubConditions[$index].Value | Select-Object * -ExcludeProperty Id
                }
                elseif ($null -ne $ruleObject.Condition.SubConditions[$index].Value.Groups.Sensitivetypes)
                {
                    $ruleobject.Condition.SubConditions[$index].Value.Groups.Sensitivetypes = @($ruleobject.Condition.SubConditions[$index].Value.Groups.Sensitivetypes | Select-Object * -ExcludeProperty Id)
                }
            }

            $newAdvancedRule = $ruleobject | ConvertTo-Json -Depth 32 | Format-Json
            $newAdvancedRule = $newAdvancedRule | ConvertTo-Json -Compress
        }
        else
        {
            $newAdvancedRule = $null
        }

        $fancyDoubleQuotes = '[\u201C\u201D]'
        $result = @{
            Ensure                                       = 'Present'
            Name                                         = $PolicyRule.Name
            Policy                                       = $PolicyRule.ParentPolicyName
            AccessScope                                  = $PolicyRule.AccessScope
            BlockAccess                                  = $PolicyRule.BlockAccess
            BlockAccessScope                             = $PolicyRule.BlockAccessScope
            Comment                                      = $PolicyRule.Comment
            AdvancedRule                                 = $newAdvancedRule
            ContentContainsSensitiveInformation          = $PolicyRule.ContentContainsSensitiveInformation
            ExceptIfContentContainsSensitiveInformation  = $PolicyRule.ExceptIfContentContainsSensitiveInformation
            ContentPropertyContainsWords                 = $PolicyRule.ContentPropertyContainsWords
            Disabled                                     = $PolicyRule.Disabled
            GenerateAlert                                = $PolicyRule.GenerateAlert
            GenerateIncidentReport                       = $PolicyRule.GenerateIncidentReport
            IncidentReportContent                        = $ArrayIncidentReportContent
            NotifyAllowOverride                          = $NotifyAllowOverrideValue
            NotifyEmailCustomText                        = [regex]::Replace($PolicyRule.NotifyEmailCustomText, $fancyDoubleQuotes, "`"")
            NotifyPolicyTipCustomText                    = [regex]::Replace($PolicyRule.NotifyPolicyTipCustomText, $fancyDoubleQuotes, "`"")
            NotifyUser                                   = $PolicyRule.NotifyUser
            ReportSeverityLevel                          = $PolicyRule.ReportSeverityLevel
            RuleErrorAction                              = $PolicyRule.RuleErrorAction
            RemoveRMSTemplate                            = $PolicyRule.RemoveRMSTemplate
            StopPolicyProcessing                         = $PolicyRule.StopPolicyProcessing
            DocumentIsUnsupported                        = $PolicyRule.DocumentIsUnsupported
            ExceptIfDocumentIsUnsupported                = $PolicyRule.ExceptIfDocumentIsUnsupported
            HasSenderOverride                            = $PolicyRule.HasSenderOverride
            ExceptIfHasSenderOverride                    = $PolicyRule.ExceptIfHasSenderOverride
            ProcessingLimitExceeded                      = $PolicyRule.ProcessingLimitExceeded
            ExceptIfProcessingLimitExceeded              = $PolicyRule.ExceptIfProcessingLimitExceeded
            DocumentIsPasswordProtected                  = $PolicyRule.DocumentIsPasswordProtected
            ExceptIfDocumentIsPasswordProtected          = $PolicyRule.ExceptIfDocumentIsPasswordProtected
            MessageTypeMatches                           = $PolicyRule.MessageTypeMatches
            ExceptIfMessageTypeMatches                   = $PolicyRule.ExceptIfMessageTypeMatches
            FromScope                                    = $PolicyRule.FromScope
            ExceptIfFromScope                            = $PolicyRule.ExceptIfFromScope
            SubjectContainsWords                         = $PolicyRule.SubjectContainsWords
            SubjectMatchesPatterns                       = $PolicyRule.SubjectMatchesPatterns
            SubjectOrBodyContainsWords                   = $PolicyRule.SubjectOrBodyContainsWords
            SubjectOrBodyMatchesPatterns                 = $PolicyRule.SubjectOrBodyMatchesPatterns
            ContentCharacterSetContainsWords             = $PolicyRule.ContentCharacterSetContainsWords
            DocumentNameMatchesPatterns                  = $PolicyRule.DocumentNameMatchesPatterns
            DocumentNameMatchesWords                     = $PolicyRule.DocumentNameMatchesWords
            ExceptIfAnyOfRecipientAddressMatchesPatterns = $PolicyRule.ExceptIfAnyOfRecipientAddressMatchesPatterns
            ExceptIfContentCharacterSetContainsWords     = $PolicyRule.ExceptIfContentCharacterSetContainsWords
            ExceptIfContentPropertyContainsWords         = $PolicyRule.ExceptIfContentPropertyContainsWords
            ExceptIfDocumentNameMatchesPatterns          = $PolicyRule.ExceptIfDocumentNameMatchesPatterns
            ExceptIfDocumentNameMatchesWords             = $PolicyRule.ExceptIfDocumentNameMatchesWords
            RecipientDomainIs                            = $PolicyRule.RecipientDomainIs
            ExceptIfRecipientDomainIs                    = $PolicyRule.ExceptIfRecipientDomainIs
            ExceptIfSenderDomainIs                       = $PolicyRule.ExceptIfSenderDomainIs
            ExceptIfSenderIPRanges                       = $PolicyRule.ExceptIfSenderIPRanges
            ExceptIfSentTo                               = $PolicyRule.ExceptIfSentTo
            ExceptIfSubjectContainsWords                 = $PolicyRule.ExceptIfSubjectContainsWords
            ExceptIfSubjectMatchesPatterns               = $PolicyRule.ExceptIfSubjectMatchesPatterns
            ExceptIfSubjectOrBodyContainsWords           = $PolicyRule.ExceptIfSubjectOrBodyContainsWords
            ExceptIfSubjectOrBodyMatchesPatterns         = $PolicyRule.ExceptIfSubjectOrBodyMatchesPatterns
            FromAddressMatchesPatterns                   = $PolicyRule.FromAddressMatchesPatterns
            SentToMemberOf                               = $PolicyRule.FromAddressMatchesPatterns
            DocumentContainsWords                        = $PolicyRule.DocumentContainsWords
            ContentIsNotLabeled                          = $PolicyRule.ContentIsNotLabeled
            SetHeader                                    = $PolicyRule.SetHeader
            AnyOfRecipientAddressContainsWords           = $AnyOfRecipientAddressContainsWords
            AnyOfRecipientAddressMatchesPatterns         = $AnyOfRecipientAddressMatchesPatterns
            ContentExtensionMatchesWords                 = $ContentExtensionMatchesWords
            ExceptIfContentExtensionMatchesWords         = $ExceptIfContentExtensionMatchesWords
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

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        [System.String]
        $AccessScope,

        [Parameter()]
        [System.Boolean]
        $BlockAccess,

        [Parameter()]
        [ValidateSet('All', 'PerUser', 'None')]
        [System.String]
        $BlockAccessScope,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String]
        $AdvancedRule,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentPropertyContainsWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String[]]
        $GenerateAlert,

        [Parameter()]
        [System.String[]]
        $GenerateIncidentReport,

        [Parameter()]
        [ValidateSet('All', 'Default', 'DetectionDetails', 'Detections', 'DocumentAuthor', 'DocumentLastModifier', 'MatchedItem', 'OriginalContent', 'RulesMatched', 'Service', 'Severity', 'Title', 'RetentionLabel', 'SensitivityLabel')]
        [System.String[]]
        $IncidentReportContent,

        [Parameter()]
        [ValidateSet('FalsePositive', 'WithoutJustification', 'WithJustification')]
        [System.String[]]
        $NotifyAllowOverride,

        [Parameter()]
        [System.String]
        $NotifyEmailCustomText,

        [Parameter()]
        [System.String]
        $NotifyPolicyTipCustomText,

        [Parameter()]
        [System.String[]]
        $NotifyUser,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'None')]
        [System.String]
        $ReportSeverityLevel,

        [Parameter()]
        [ValidateSet('Ignore', 'RetryThenBlock')]
        [System.String]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $RemoveRMSTemplate,

        [Parameter()]
        [System.Boolean]
        $StopPolicyProcessing,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $HasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ExceptIfHasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.String[]]
        $MessageTypeMatches,

        [Parameter()]
        [System.String[]]
        $ExceptIfMessageTypeMatches,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $FromScope,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $ExceptIfFromScope,

        [Parameter()]
        [System.String[]]
        $SubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentPropertyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

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
        $ExceptIfSubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String[]]
        $DocumentContainsWords,

        [Parameter()]
        [System.String[]]
        $SetHeader,

        [Parameter()]
        [System.Boolean]
        $ContentIsNotLabeled,

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

    $CurrentRule = Get-TargetResource @PSBoundParameters

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

        if ($null -eq $CreationParams.ContentContainsSensitiveInformation -and $null -ne $CreationParams.AdvancedRule)
        {
            $CreationParams.AdvancedRule = $CreationParams.AdvancedRule | ConvertFrom-Json
        }
        elseif ($null -ne $CreationParams.ContentContainsSensitiveInformation)
        {
            $CreationParams.Remove('AdvancedRule')
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

        $NewruleParam = @{
            Name         = $CreationParams.Name
            Policy       = $CreationParams.Policy
            AdvancedRule = $CreationParams.AdvancedRule
        }
        Write-Verbose -Message "Calling New-DLPComplianceRule with Values: $(Convert-M365DscHashtableToString -Hashtable $CreationParams)"
        New-DLPComplianceRule @NewruleParam
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

        if ($null -eq $UpdateParams.ContentContainsSensitiveInformation -and $null -ne $UpdateParams.AdvancedRule)
        {
            $UpdateParams.AdvancedRule = $UpdateParams.AdvancedRule | ConvertFrom-Json
        }
        elseif ($null -ne $UpdateParams.ContentContainsSensitiveInformation)
        {
            $UpdateParams.Remove('AdvancedRule')
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

        Write-Verbose "Updating Rule with values: $(Convert-M365DscHashtableToString -Hashtable $UpdateParams)"
        Set-DLPComplianceRule @UpdateParams
    }
    elseif (('Absent' -eq $Ensure) -and ('Present' -eq $CurrentRule.Ensure))
    {
        Write-Verbose "Rule {$($CurrentRule.Name)} already exists but shouldn't. Deleting Rule."
        Remove-DLPComplianceRule -Identity $CurrentRule.Name -Confirm:$false
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

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization', 'None')]
        [System.String]
        $AccessScope,

        [Parameter()]
        [System.Boolean]
        $BlockAccess,

        [Parameter()]
        [ValidateSet('All', 'PerUser', 'None')]
        [System.String]
        $BlockAccessScope,

        [Parameter()]
        [System.String]
        $Comment,

        [Parameter()]
        [System.String]
        $AdvancedRule,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ContentContainsSensitiveInformation,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ExceptIfContentContainsSensitiveInformation,

        [Parameter()]
        [System.String[]]
        $ContentPropertyContainsWords,

        [Parameter()]
        [System.Boolean]
        $Disabled,

        [Parameter()]
        [System.String[]]
        $GenerateAlert,

        [Parameter()]
        [System.String[]]
        $GenerateIncidentReport,

        [Parameter()]
        [ValidateSet('All', 'Default', 'DetectionDetails', 'Detections', 'DocumentAuthor', 'DocumentLastModifier', 'MatchedItem', 'OriginalContent', 'RulesMatched', 'Service', 'Severity', 'Title', 'RetentionLabel', 'SensitivityLabel')]
        [System.String[]]
        $IncidentReportContent,

        [Parameter()]
        [ValidateSet('FalsePositive', 'WithoutJustification', 'WithJustification')]
        [System.String[]]
        $NotifyAllowOverride,

        [Parameter()]
        [System.String]
        $NotifyEmailCustomText,

        [Parameter()]
        [System.String]
        $NotifyPolicyTipCustomText,

        [Parameter()]
        [System.String[]]
        $NotifyUser,

        [Parameter()]
        [ValidateSet('Low', 'Medium', 'High', 'None')]
        [System.String]
        $ReportSeverityLevel,

        [Parameter()]
        [ValidateSet('Ignore', 'RetryThenBlock')]
        [System.String]
        $RuleErrorAction,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $AnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentExtensionMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentExtensionMatchesWords,

        [Parameter()]
        [System.Boolean]
        $RemoveRMSTemplate,

        [Parameter()]
        [System.Boolean]
        $StopPolicyProcessing,

        [Parameter()]
        [System.Boolean]
        $DocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsUnsupported,

        [Parameter()]
        [System.Boolean]
        $HasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ExceptIfHasSenderOverride,

        [Parameter()]
        [System.Boolean]
        $ProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $ExceptIfProcessingLimitExceeded,

        [Parameter()]
        [System.Boolean]
        $DocumentIsPasswordProtected,

        [Parameter()]
        [System.Boolean]
        $ExceptIfDocumentIsPasswordProtected,

        [Parameter()]
        [System.String[]]
        $MessageTypeMatches,

        [Parameter()]
        [System.String[]]
        $ExceptIfMessageTypeMatches,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $FromScope,

        [Parameter()]
        [ValidateSet('InOrganization', 'NotInOrganization')]
        [System.String[]]
        $ExceptIfFromScope,

        [Parameter()]
        [System.String[]]
        $SubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $SubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $DocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfAnyOfRecipientAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentCharacterSetContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfContentPropertyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfDocumentNameMatchesWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfFromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $FromAddressContainsWords,

        [Parameter()]
        [System.String[]]
        $FromAddressMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $RecipientDomainIs,

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
        $ExceptIfSubjectContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyContainsWords,

        [Parameter()]
        [System.String[]]
        $ExceptIfSubjectOrBodyMatchesPatterns,

        [Parameter()]
        [System.String[]]
        $SentToMemberOf,

        [Parameter()]
        [System.String[]]
        $DocumentContainsWords,

        [Parameter()]
        [System.String[]]
        $SetHeader,

        [Parameter()]
        [System.Boolean]
        $ContentIsNotLabeled,

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

    Write-Verbose -Message "Testing configuration of DLPComplianceRule for $Name"

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
        [array]$rules = Get-DLPComplianceRule -ErrorAction Stop | Where-Object { $_.Mode -ne 'PendingDeletion' }

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
                -Policy $rule.ParentPolicyName

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
        $StringContent = "MSFT_SCDLPContainsSensitiveInformation`r`n            {`r`n"
        if ($null -ne $InformationArray.Groups)
        {
            $StringContent += "                        operator = '$($SensitiveInformationHash.operator.Replace("'", "''"))'`r`n"
            $StringContent += "                         Groups =  `r`n@("
        }
        foreach ($group in $SensitiveInformationHash.Groups)
        {
            $StringContent += "MSFT_SCDLPContainsSensitiveInformationGroup`r`n            {`r`n"
            $StringContent += "                operator = '$($group.operator.Replace("'", "''"))'`r`n"
            $StringContent += "                name = '$($group.name.Replace("'", "''"))'`r`n"
            if ($null -ne $group.sensitivetypes)
            {
                $StringContent += '                SensitiveInformation = @('
                foreach ($sit in $group.sensitivetypes)
                {
                    $StringContent += "            MSFT_SCDLPSensitiveInformation`r`n            {`r`n"
                    $StringContent += "                    name = '$($sit.name.Replace("'", "''"))'`r`n"
                    if ($null -ne $sit.id)
                    {
                        $StringContent += "                id = '$($sit.id)'`r`n"
                    }

                    if ($null -ne $sit.maxconfidence)
                    {
                        $StringContent += "                maxconfidence = '$($sit.maxconfidence)'`r`n"
                    }

                    if ($null -ne $sit.minconfidence)
                    {
                        $StringContent += "                minconfidence = '$($sit.minconfidence)'`r`n"
                    }

                    if ($null -ne $sit.classifiertype)
                    {
                        $StringContent += "                classifiertype = '$($sit.classifiertype)'`r`n"
                    }

                    if ($null -ne $sit.mincount)
                    {
                        $StringContent += "                mincount = '$($sit.mincount)'`r`n"
                    }

                    if ($null -ne $sit.maxcount)
                    {
                        $StringContent += "                maxcount = '$($sit.maxcount)'`r`n"
                    }

                    $StringContent += "            }`r`n"
                }
                $StringContent += "            )}`r`n"
            }
            if ($null -ne $group.labels)
            {
                $StringContent += '                labels = @('
                foreach ($label in $group.labels)
                {
                    $StringContent += "            MSFT_SCDLPLabel`r`n            {`r`n"
                    $StringContent += "                    name = '$($label.name.Replace("'", "''"))'`r`n"
                    if ($null -ne $label.id)
                    {
                        $StringContent += "                id = '$($label.id)'`r`n"
                    }

                    if ($null -ne $label.type)
                    {
                        $StringContent += "                type = '$($label.type)'`r`n"
                    }

                    $StringContent += "            }`r`n"
                }
                $StringContent += "            )}`r`n"
            }
        }
        $StringContent += "            )}`r`n"
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
    $StringContent = "MSFT_SCDLPContainsSensitiveInformation`r`n            {`r`n"
    $StringContent += '                SensitiveInformation = '
    $StringContent += "@(`r`n"
    $result += $StringContent
    foreach ($SensitiveInformationHash in $InformationArray)
    {

        $StringContent = "MSFT_SCDLPSensitiveInformation`r`n            {`r`n"
        $StringContent += "                name = '$($SensitiveInformationHash.name.Replace("'", "''"))'`r`n"

        if ($null -ne $SensitiveInformationHash.id)
        {
            $StringContent += "                id = '$($SensitiveInformationHash.id)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.maxconfidence)
        {
            $StringContent += "                maxconfidence = '$($SensitiveInformationHash.maxconfidence)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.minconfidence)
        {
            $StringContent += "                minconfidence = '$($SensitiveInformationHash.minconfidence)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.classifiertype)
        {
            $StringContent += "                classifiertype = '$($SensitiveInformationHash.classifiertype)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.mincount)
        {
            $StringContent += "                mincount = '$($SensitiveInformationHash.mincount)'`r`n"
        }

        if ($null -ne $SensitiveInformationHash.maxcount)
        {
            $StringContent += "                maxcount = '$($SensitiveInformationHash.maxcount)'`r`n"
        }

        $StringContent += "            }`r`n"
        $result += $StringContent
    }
    $result += '            )'
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
        foreach ($item in $group.SensitiveTypes)
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

function Format-Json([Parameter(Mandatory, ValueFromPipeline)][String] $json)
{
    $indent = 0
    ($json -Split "`n" | ForEach-Object {
        if ($_ -match '[\}\]]\s*,?\s*$')
        {
            # This line ends with ] or }, decrement the indentation level
            $indent--
        }
        $line = ('  ' * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ')
        if ($_ -match '[\{\[]\s*$')
        {
            # This line ends with [ or {, increment the indentation level
            $indent++
        }
        $line
    }) -Join "`n"
}

Export-ModuleMember -Function *-TargetResource
