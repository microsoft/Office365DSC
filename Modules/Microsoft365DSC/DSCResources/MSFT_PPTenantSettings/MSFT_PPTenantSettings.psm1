function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $WalkMeOptOut,

        [Parameter()]
        [System.Boolean]
        $DisableNPSCommentsReachout,

        [Parameter()]
        [System.Boolean]
        $DisableNewsletterSendout,

        [Parameter()]
        [System.Boolean]
        $DisableEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisablePortalsCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableTrialEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableCapacityAllocationByEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableSupportTicketsVisibleByAllUsers,

        [Parameter()]
        [System.Boolean]
        $DisableDocsSearch,

        [Parameter()]
        [System.Boolean]
        $DisableCommunitySearch,

        [Parameter()]
        [System.Boolean]
        $DisableBingVideoSearch,

        [Parameter()]
        [System.Boolean]
        $DisableShareWithEveryone,

        [Parameter()]
        [System.Boolean]
        $EnableGuestsToMake,

        [Parameter()]
        [ValidateRange(1, 10000)]
        [System.UInt32]
        $ShareWithColleaguesUserLimit,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableMakerMatch,

        [Parameter()]
        [System.Boolean]
        $DisableUnusedLicenseAssignment,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromImage,

        [Parameter()]
        [System.Boolean]
        $DisableConnectionSharingWithEveryone,

        [Parameter()]
        [System.Boolean]
        $AllowNewOrgChannelDefault,

        [Parameter()]
        [System.Boolean]
        $DisableCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotWithBing,

        [Parameter()]
        [System.Boolean]
        $DisableAdminDigest,

        [Parameter()]
        [System.Boolean]
        $DisablePreferredDataLocationForTeamsEnvironment,

        [Parameter()]
        [System.Boolean]
        $DisableDeveloperEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $EnvironmentRoutingAllMakers,

        [Parameter()]
        [System.Boolean]
        $EnableDefaultEnvironmentRouting,

        [Parameter()]
        [System.String]
        $EnableDesktopFlowDataPolicyManagement,

        [Parameter()]
        [System.Boolean]
        $EnableCanvasAppInsights,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromFigma,

        [Parameter()]
        [System.Boolean]
        $DisableBillingPolicyCreationByNonAdminUsers,

        [Parameter()]
        [System.UInt32]
        $StorageCapacityConsumptionWarningThreshold,

        [Parameter()]
        [System.Boolean]
        $EnableTenantCapacityReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $EnableTenantLicensingReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableUseOfUnassignedAIBuilderCredits,

        [Parameter()]
        [System.String]
        $EnableGenerativeAIFeaturesForSiteUsers,

        [Parameter()]
        [System.String]
        $EnableExternalAuthenticationProvidersInPowerPages,

        [Parameter()]
        [System.Boolean]
        $DisableChampionsInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $DisableSkillsMatchInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $EnableOpenAiBotPublishing,

        [Parameter()]
        [System.Boolean]
        $DisableAiPrompts,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedbackMetadata,

        [Parameter()]
        [System.Boolean]
        $EnableModelDataSharing,

        [Parameter()]
        [System.Boolean]
        $DisableDataLogging,

        [Parameter()]
        [System.String]
        $PowerCatalogAudienceSetting,

        [Parameter()]
        [System.Boolean]
        $EnableDeleteDisabledUserinAllEnvironments,

        [Parameter()]
        [System.Boolean]
        $DisableHelpSupportCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyScreenshots,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
    )

    Write-Verbose -Message 'Checking the Power Platform Tenant Settings Configuration'
    $ConnectionMode = New-M365DSCConnection -Workload 'PowerPlatforms' `
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
        IsSingleInstance = 'Yes'
    }

    try
    {
        $PPTenantSettings = Get-TenantSettings -ErrorAction Stop
        return @{
            IsSingleInstance                               = 'Yes'

            # search
            DisableDocsSearch                              = $PPTenantSettings.powerPlatform.search.disableDocsSearch
            DisableCommunitySearch                         = $PPTenantSettings.powerPlatform.search.disableCommunitySearch
            DisableBingVideoSearch                         = $PPTenantSettings.powerPlatform.search.disableBingVideoSearch

            #teamsIntegration
            ShareWithColleaguesUserLimit                   = $PPTenantSettings.powerPlatform.teamsIntegration.shareWithColleaguesUserLimit

            #powerApps
            DisableShareWithEveryone                       = $PPTenantSettings.powerPlatform.powerApps.disableShareWithEveryone
            EnableGuestsToMake                             = $PPTenantSettings.powerPlatform.powerApps.enableGuestsToMake
            DisableMakerMatch                              = $PPTenantSettings.powerPlatform.powerApps.disableMakerMatch
            DisableUnusedLicenseAssignment                 = $PPTenantSettings.powerPlatform.powerApps.disableUnusedLicenseAssignment
            DisableCreateFromImage                         = $PPTenantSettings.powerPlatform.powerApps.disableCreateFromImage
            DisableCreateFromFigma                         = $PPTenantSettings.powerPlatform.powerApps.disableCreateFromFigma
            EnableCanvasAppInsights                        = $PPTenantSettings.powerPlatform.powerApps.enableCanvasAppInsights
            DisableConnectionSharingWithEveryone           = $PPTenantSettings.powerPlatform.powerApps.disableConnectionSharingWithEveryone
            AllowNewOrgChannelDefault                      = $PPTenantSettings.powerPlatform.powerApps.allowNewOrgChannelDefault
            DisableCopilot                                 = $PPTenantSettings.powerPlatform.powerApps.disableCopilot

            #powerAutomate
            DisableCopilotWithBing                         = $PPTenantSettings.powerPlatform.powerAutomate.disableCopilotWithBing

            #environments
            DisablePreferredDataLocationForTeamsEnvironment = $PPTenantSettings.powerPlatform.environments.disablePreferredDataLocationForTeamsEnvironment

            #governance
            DisableAdminDigest                                 = $PPTenantSettings.powerPlatform.governance.disableAdminDigest
            DisableDeveloperEnvironmentCreationByNonAdminUsers = $PPTenantSettings.powerPlatform.governance.disableDeveloperEnvironmentCreationByNonAdminUsers
            EnableDefaultEnvironmentRouting                    = $PPTenantSettings.powerPlatform.governance.enableDefaultEnvironmentRouting
            EnableDesktopFlowDataPolicyManagement              = $PPTenantSettings.powerPlatform.governance.policy.enableDesktopFlowDataPolicyManagement
            EnvironmentRoutingAllMakers                        = $PPTenantSettings.powerPlatform.governance.environmentRoutingAllMakers

            #licensing
            DisableBillingPolicyCreationByNonAdminUsers     = $PPTenantSettings.powerPlatform.licensing.disableBillingPolicyCreationByNonAdminUsers
            EnableTenantCapacityReportForEnvironmentAdmins  = $PPTenantSettings.powerPlatform.licensing.enableTenantCapacityReportForEnvironmentAdmins
            StorageCapacityConsumptionWarningThreshold      = $PPTenantSettings.powerPlatform.licensing.storageCapacityConsumptionWarningThreshold
            EnableTenantLicensingReportForEnvironmentAdmins = $PPTenantSettings.powerPlatform.licensing.enableTenantLicensingReportForEnvironmentAdmins
            DisableUseOfUnassignedAIBuilderCredits          = $PPTenantSettings.powerPlatform.licensing.disableUseOfUnassignedAIBuilderCredits

            #powerPages
            EnableGenerativeAIFeaturesForSiteUsers            = $PPTenantSettings.powerPlatform.powerPages.enableGenerativeAIFeaturesForSiteUsers
            EnableExternalAuthenticationProvidersInPowerPages = $PPTenantSettings.powerPlatform.powerPages.enableExternalAuthenticationProvidersInPowerPages

            #champions
            DisableChampionsInvitationReachout   = $PPTenantSettings.powerPlatform.champions.disableChampionsInvitationReachout
            DisableSkillsMatchInvitationReachout = $PPTenantSettings.powerPlatform.champions.disableSkillsMatchInvitationReachout

            #intelligence
            DisableCopilotFeedback                         = $PPTenantSettings.powerPlatforms.intelligence.disableCopilotFeedback
            EnableOpenAiBotPublishing                      = $PPTenantSettings.powerPlatforms.intelligence.enableOpenAiBotPublishing
            DisableCopilotFeedbackMetadata                 = $PPTenantSettings.powerPlatforms.intelligence.disableCopilotFeedbackMetadata
            DisableAiPrompts                               = $PPTenantSettings.powerPlatforms.intelligence.disableAiPrompts

            #modelExperimentation
            EnableModelDataSharing                         = $PPTenantSettings.powerPlatforms.modelExperimentation.enableModelDataSharing
            DisableDataLogging                             = $PPTenantSettings.powerPlatforms.modelExperimentation.disableDataLogging

            #catalogSettings
            PowerCatalogAudienceSetting                    = $PPTenantSettings.powerPlatforms.catalogSettings.powerCatalogAudienceSetting

            #userManagementSettings
            EnableDeleteDisabledUserinAllEnvironments      = $PPTenantSettings.powerPlatforms.userManagementSettings.enableDeleteDisabledUserinAllEnvironments

            #helpSupportSettings
            DisableHelpSupportCopilot                      = $PPTenantSettings.powerPlatforms.helpSupportSettings.disableHelpSupportCopilot
            UseSupportBingSearchByAllUsers                 = $PPTenantSettings.powerPlatforms.helpSupportSettings.useSupportBingSearchByAllUsers

            #Main
            WalkMeOptOut                                   = $PPTenantSettings.walkMeOptOut
            DisableNPSCommentsReachout                     = $PPTenantSettings.disableNPSCommentsReachout
            DisableNewsletterSendout                       = $PPTenantSettings.disableNewsletterSendout
            DisableEnvironmentCreationByNonAdminUsers      = $PPTenantSettings.disableEnvironmentCreationByNonAdminUsers
            DisablePortalsCreationByNonAdminUsers          = $PPTenantSettings.disablePortalsCreationByNonAdminUsers
            DisableSurveyFeedback                          = $PPTenantSettings.disableSurveyFeedback
            DisableSurveyScreenshots                       = $PPTenantSettings.disableSurveyScreenshots
            DisableTrialEnvironmentCreationByNonAdminUsers = $PPTenantSettings.disableTrialEnvironmentCreationByNonAdminUsers
            DisableCapacityAllocationByEnvironmentAdmins   = $PPTenantSettings.disableCapacityAllocationByEnvironmentAdmins
            DisableSupportTicketsVisibleByAllUsers         = $PPTenantSettings.disableSupportTicketsVisibleByAllUsers

            Credential                                     = $Credential
            ApplicationId                                  = $ApplicationId
            TenantId                                       = $TenantId
            CertificateThumbprint                          = $CertificateThumbprint
            ApplicationSecret                              = $ApplicationSecret
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
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $WalkMeOptOut,

        [Parameter()]
        [System.Boolean]
        $DisableNPSCommentsReachout,

        [Parameter()]
        [System.Boolean]
        $DisableNewsletterSendout,

        [Parameter()]
        [System.Boolean]
        $DisableEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisablePortalsCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableTrialEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableCapacityAllocationByEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableSupportTicketsVisibleByAllUsers,

        [Parameter()]
        [System.Boolean]
        $DisableDocsSearch,

        [Parameter()]
        [System.Boolean]
        $DisableCommunitySearch,

        [Parameter()]
        [System.Boolean]
        $DisableBingVideoSearch,

        [Parameter()]
        [System.Boolean]
        $DisableShareWithEveryone,

        [Parameter()]
        [System.Boolean]
        $EnableGuestsToMake,

        [Parameter()]
        [ValidateRange(1, 10000)]
        [System.UInt32]
        $ShareWithColleaguesUserLimit,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableMakerMatch,

        [Parameter()]
        [System.Boolean]
        $DisableUnusedLicenseAssignment,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromImage,

        [Parameter()]
        [System.Boolean]
        $DisableConnectionSharingWithEveryone,

        [Parameter()]
        [System.Boolean]
        $AllowNewOrgChannelDefault,

        [Parameter()]
        [System.Boolean]
        $DisableCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotWithBing,

        [Parameter()]
        [System.Boolean]
        $DisableAdminDigest,

        [Parameter()]
        [System.Boolean]
        $DisablePreferredDataLocationForTeamsEnvironment,

        [Parameter()]
        [System.Boolean]
        $DisableDeveloperEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $EnvironmentRoutingAllMakers,

        [Parameter()]
        [System.Boolean]
        $EnableDefaultEnvironmentRouting,

        [Parameter()]
        [System.String]
        $EnableDesktopFlowDataPolicyManagement,

        [Parameter()]
        [System.Boolean]
        $EnableCanvasAppInsights,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromFigma,

        [Parameter()]
        [System.Boolean]
        $DisableBillingPolicyCreationByNonAdminUsers,

        [Parameter()]
        [System.UInt32]
        $StorageCapacityConsumptionWarningThreshold,

        [Parameter()]
        [System.Boolean]
        $EnableTenantCapacityReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $EnableTenantLicensingReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableUseOfUnassignedAIBuilderCredits,

        [Parameter()]
        [System.String]
        $EnableGenerativeAIFeaturesForSiteUsers,

        [Parameter()]
        [System.String]
        $EnableExternalAuthenticationProvidersInPowerPages,

        [Parameter()]
        [System.Boolean]
        $DisableChampionsInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $DisableSkillsMatchInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $EnableOpenAiBotPublishing,

        [Parameter()]
        [System.Boolean]
        $DisableAiPrompts,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedbackMetadata,

        [Parameter()]
        [System.Boolean]
        $EnableModelDataSharing,

        [Parameter()]
        [System.Boolean]
        $DisableDataLogging,

        [Parameter()]
        [System.String]
        $PowerCatalogAudienceSetting,

        [Parameter()]
        [System.Boolean]
        $EnableDeleteDisabledUserinAllEnvironments,

        [Parameter()]
        [System.Boolean]
        $DisableHelpSupportCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyScreenshots,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
    )

    Write-Verbose -Message 'Setting Power Platform Tenant Settings configuration'

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

    $ConnectionMode = New-M365DSCConnection -Workload 'PowerPlatforms' `
        -InboundParameters $PSBoundParameters

    $SetParameters = $PSBoundParameters
    $RequestBody = Get-M365DSCPowerPlatformTenantSettings -Parameters $SetParameters
    Set-TenantSettings -RequestBody $RequestBody | Out-Null
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [System.String]
        $IsSingleInstance,

        [Parameter()]
        [System.Boolean]
        $WalkMeOptOut,

        [Parameter()]
        [System.Boolean]
        $DisableNPSCommentsReachout,

        [Parameter()]
        [System.Boolean]
        $DisableNewsletterSendout,

        [Parameter()]
        [System.Boolean]
        $DisableEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisablePortalsCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableTrialEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $DisableCapacityAllocationByEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableSupportTicketsVisibleByAllUsers,

        [Parameter()]
        [System.Boolean]
        $DisableDocsSearch,

        [Parameter()]
        [System.Boolean]
        $DisableCommunitySearch,

        [Parameter()]
        [System.Boolean]
        $DisableBingVideoSearch,

        [Parameter()]
        [System.Boolean]
        $DisableShareWithEveryone,

        [Parameter()]
        [System.Boolean]
        $EnableGuestsToMake,

        [Parameter()]
        [ValidateRange(1, 10000)]
        [System.UInt32]
        $ShareWithColleaguesUserLimit,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedback,

        [Parameter()]
        [System.Boolean]
        $DisableMakerMatch,

        [Parameter()]
        [System.Boolean]
        $DisableUnusedLicenseAssignment,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromImage,

        [Parameter()]
        [System.Boolean]
        $DisableConnectionSharingWithEveryone,

        [Parameter()]
        [System.Boolean]
        $AllowNewOrgChannelDefault,

        [Parameter()]
        [System.Boolean]
        $DisableCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotWithBing,

        [Parameter()]
        [System.Boolean]
        $DisableAdminDigest,

        [Parameter()]
        [System.Boolean]
        $DisablePreferredDataLocationForTeamsEnvironment,

        [Parameter()]
        [System.Boolean]
        $DisableDeveloperEnvironmentCreationByNonAdminUsers,

        [Parameter()]
        [System.Boolean]
        $EnvironmentRoutingAllMakers,

        [Parameter()]
        [System.Boolean]
        $EnableDefaultEnvironmentRouting,

        [Parameter()]
        [System.String]
        $EnableDesktopFlowDataPolicyManagement,

        [Parameter()]
        [System.Boolean]
        $EnableCanvasAppInsights,

        [Parameter()]
        [System.Boolean]
        $DisableCreateFromFigma,

        [Parameter()]
        [System.Boolean]
        $DisableBillingPolicyCreationByNonAdminUsers,

        [Parameter()]
        [System.UInt32]
        $StorageCapacityConsumptionWarningThreshold,

        [Parameter()]
        [System.Boolean]
        $EnableTenantCapacityReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $EnableTenantLicensingReportForEnvironmentAdmins,

        [Parameter()]
        [System.Boolean]
        $DisableUseOfUnassignedAIBuilderCredits,

        [Parameter()]
        [System.String]
        $EnableGenerativeAIFeaturesForSiteUsers,

        [Parameter()]
        [System.String]
        $EnableExternalAuthenticationProvidersInPowerPages,

        [Parameter()]
        [System.Boolean]
        $DisableChampionsInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $DisableSkillsMatchInvitationReachout,

        [Parameter()]
        [System.Boolean]
        $EnableOpenAiBotPublishing,

        [Parameter()]
        [System.Boolean]
        $DisableAiPrompts,

        [Parameter()]
        [System.Boolean]
        $DisableCopilotFeedbackMetadata,

        [Parameter()]
        [System.Boolean]
        $EnableModelDataSharing,

        [Parameter()]
        [System.Boolean]
        $DisableDataLogging,

        [Parameter()]
        [System.String]
        $PowerCatalogAudienceSetting,

        [Parameter()]
        [System.Boolean]
        $EnableDeleteDisabledUserinAllEnvironments,

        [Parameter()]
        [System.Boolean]
        $DisableHelpSupportCopilot,

        [Parameter()]
        [System.Boolean]
        $DisableSurveyScreenshots,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
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

    Write-Verbose -Message 'Testing configuration for Power Platform Tenant Settings'
    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('Credential') | Out-Null
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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret
    )
    $ConnectionMode = New-M365DSCConnection -Workload 'PowerPlatforms' `
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
        $settings = Get-TenantSettings -ErrorAction Stop

        if ($settings.StatusCode -eq 403)
        {
            throw "Invalid permission for the application. If you are using a custom app registration to authenticate, make sure it is defined as a Power Platform admin management application. For additional information refer to https://learn.microsoft.com/en-us/power-platform/admin/powershell-create-service-principal#registering-an-admin-management-application"
        }
        $dscContent = ''

        if ($null -ne $Global:M365DSCExportResourceInstancesCount)
        {
            $Global:M365DSCExportResourceInstancesCount++
        }

        $Params = @{
            IsSingleInstance      = 'Yes'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ApplicationSecret     = $ApplicationSecret
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

function Get-M365DSCPowerPlatformTenantSettings
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $Parameters
    )

    $result = @{
        walkMeOptOut                                   = $Parameters.WalkMeOptOut
        disableNPSCommentsReachout                     = $Parameters.DisableNPSCommentsReachout
        disableNewsletterSendout                       = $Parameters.DisableNewsletterSendout
        disableEnvironmentCreationByNonAdminUsers      = $Parameters.DisableEnvironmentCreationByNonAdminUsers
        disablePortalsCreationByNonAdminUsers          = $Parameters.DisablePortalsCreationByNonAdminUsers
        disableSurveyFeedback                          = $Parameters.DisableSurveyFeedback
        disableSurveyScreenshots                       = $Parameters.DisableSurveyScreenshots
        disableTrialEnvironmentCreationByNonAdminUsers = $Parameters.DisableTrialEnvironmentCreationByNonAdminUsers
        disableCapacityAllocationByEnvironmentAdmins   = $Parameters.DisableCapacityAllocationByEnvironmentAdmins
        disableSupportTicketsVisibleByAllUsers         = $Parameters.DisableSupportTicketsVisibleByAllUsers
        powerPlatform                                  = @{
            search           = @{
                disableDocsSearch      = $Parameters.DisableDocsSearch
                disableCommunitySearch = $Parameters.DisableCommunitySearch
                disableBingVideoSearch = $Parameters.DisableBingVideoSearch
            }
            teams = @{
                shareWithColleaguesUserLimit = $Parameters.ShareWithColleaguesUserLimit
            }
            powerApps        = @{
                disableShareWithEveryone             = $Parameters.DisableShareWithEveryone
                enableGuestsToMake                   = $Parameters.EnableGuestsToMake
                disableMakerMatch                    = $Parameters.DisableMakerMatch
                disableUnusedLicenseAssignment       = $Parameters.DisableUnusedLicenseAssignment
                disableCreateFromImage               = $Parameters.DisableCreateFromImage
                disableCreateFromFigma               = $Parameters.DisableCreateFromFigma
                enableCanvasAppInsights              = $Parameters.EnableCanvasAppInsights
                disableConnectionSharingWithEveryone = $Parameters.DisableConnectionSharingWithEveryone
                allowNewOrgChannelDefault            = $Parameters.AllowNewOrgChannelDefault
                disableCopilot                       = $Parameters.DisableCopilot
            }
            environments = @{
                disablePreferredDataLocationForTeamsEnvironment = $Parameters.DisablePreferredDataLocationForTeamsEnvironment
            }
            powerAutomate = @{
                disableCopilotWithBing = $Parameters.DisableCopilotWithBing
            }
            governance = @{
                disableAdminDigest                                 = $Parameters.DisableAdminDigest
                disableDeveloperEnvironmentCreationByNonAdminUsers = $Parameters.DisableDeveloperEnvironmentCreationByNonAdminUsers
                enableDefaultEnvironmentRouting                    = $Parameters.EnableDefaultEnvironmentRouting
                policy                                             = @(
                    @{
                        enableDesktopFlowDataPolicyManagement = $Parameters.EnableDesktopFlowDataPolicyManagement
                    }
                )
                environmentRoutingAllMakers                        = $Parameters.EnvironmentRoutingAllMakers
            }
            teamsIntegration = @{
                shareWithColleaguesUserLimit = $Parameters.ShareWithColleaguesUserLimit
            }
            licensing = @{
                disableBillingPolicyCreationByNonAdminUsers     = $Parameters.DisableBillingPolicyCreationByNonAdminUsers
                enableTenantCapacityReportForEnvironmentAdmins  = $Parameters.EnableTenantCapacityReportForEnvironmentAdmins
                storageCapacityConsumptionWarningThreshold      = $Parameters.StorageCapacityConsumptionWarningThreshold
                enableTenantLicensingReportForEnvironmentAdmins = $Parameters.EnableTenantLicensingReportForEnvironmentAdmins
                disableUseOfUnassignedAIBuilderCredits          = $Parameters.DisableUseOfUnassignedAIBuilderCredits
            }
            powerPages = @{
                enableGenerativeAIFeaturesForSiteUsers            = $Parameters.EnableGenerativeAIFeaturesForSiteUsers
                enableExternalAuthenticationProvidersInPowerPages = $Parameters.EnableExternalAuthenticationProvidersInPowerPages
            }
            champions = @{
                disableChampionsInvitationReachout   = $Parameters.DisableChampionsInvitationReachout
                disableSkillsMatchInvitationReachout = $Parameters.DisableSkillsMatchInvitationReachout
            }
            intelligence = @{
                disableCopilotFeedback                         = $Parameters.disableCopilotFeedback
                enableOpenAiBotPublishing                      = $Parameters.enableOpenAiBotPublishing
                disableCopilotFeedbackMetadata                 = $Parameters.disableCopilotFeedbackMetadata
                disableAiPrompts                               = $Parameters.disableAiPrompts
            }
            modelExperimentation = @{
                enableModelDataSharing                         = $Parameters.enableModelDataSharing
                disableDataLogging                             = $Parameters.disableDataLogging
            }
            catalogSettings = @{
                powerCatalogAudienceSetting                    = $Parameters.powerCatalogAudienceSetting
            }
            userManagementSettings = @{
                enableDeleteDisabledUserinAllEnvironments      = $Parameters.enableDeleteDisabledUserinAllEnvironments
            }
            helpSupportSettings = @{
                disableHelpSupportCopilot                      = $Parameters.disableHelpSupportCopilot
                useSupportBingSearchByAllUsers                 = $Parameters.useSupportBingSearchByAllUsers
            }
        }
    }

    return $result
}

Export-ModuleMember -Function *-TargetResource
