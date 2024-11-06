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
        $InsiderRiskScenario,

        [Parameter()]
        [System.Boolean]
        $Anonymization,

        [Parameter()]
        [System.Boolean]
        $DLPUserRiskSync,

        [Parameter()]
        [System.Boolean]
        $OptInIRMDataExport,

        [Parameter()]
        [System.Boolean]
        $RaiseAuditAlert,

        [Parameter()]
        [System.String]
        $FileVolCutoffLimits,

        [Parameter()]
        [System.String]
        $AlertVolume,

        [Parameter()]
        [System.Boolean]
        $AnomalyDetections,

        [Parameter()]
        [System.Boolean]
        $CopyToPersonalCloud,

        [Parameter()]
        [System.Boolean]
        $CopyToUSB,

        [Parameter()]
        [System.Boolean]
        $CumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $EmailExternal,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedEmployeePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedFamilyData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedHighVolumePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedNeighbourData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedRestrictedData,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToChildAbuseSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCriminalActivitySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCultSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToGamblingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHackingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHateIntoleranceSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToIllegalSoftwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToKeyloggerSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToLlmSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToMalwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPhishingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPornographySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToUnallowedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToViolenceSites,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToClipboardFromSensitiveFile,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToNetworkShare,

        [Parameter()]
        [System.Boolean]
        $EpoFileArchived,

        [Parameter()]
        [System.Boolean]
        $EpoFileCopiedToRemoteDesktopSession,

        [Parameter()]
        [System.Boolean]
        $EpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromBlacklistedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromEnterpriseDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileRenamed,

        [Parameter()]
        [System.Boolean]
        $EpoFileStagedToCentralLocation,

        [Parameter()]
        [System.Boolean]
        $EpoHiddenFileCreated,

        [Parameter()]
        [System.Boolean]
        $EpoRemovableMediaMount,

        [Parameter()]
        [System.Boolean]
        $EpoSensitiveFileRead,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppDownload,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileDelete,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileSharing,

        [Parameter()]
        [System.Boolean]
        $McasActivityFromInfrequentCountry,

        [Parameter()]
        [System.Boolean]
        $McasImpossibleTravel,

        [Parameter()]
        [System.Boolean]
        $McasMultipleFailedLogins,

        [Parameter()]
        [System.Boolean]
        $McasMultipleStorageDeletion,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMCreation,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMDeletion,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousAdminActivities,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudCreation,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudTrailLoggingChange,

        [Parameter()]
        [System.Boolean]
        $McasTerminatedEmployeeActivity,

        [Parameter()]
        [System.Boolean]
        $OdbDownload,

        [Parameter()]
        [System.Boolean]
        $OdbSyncDownload,

        [Parameter()]
        [System.Boolean]
        $PeerCumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $PhysicalAccess,

        [Parameter()]
        [System.Boolean]
        $PotentialHighImpactUser,

        [Parameter()]
        [System.Boolean]
        $Print,

        [Parameter()]
        [System.Boolean]
        $PriorityUserGroupMember,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertDefenseEvasion,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertUnwantedSoftware,

        [Parameter()]
        [System.Boolean]
        $SpoAccessRequest,

        [Parameter()]
        [System.Boolean]
        $SpoApprovedAccess,

        [Parameter()]
        [System.Boolean]
        $SpoDownload,

        [Parameter()]
        [System.Boolean]
        $SpoDownloadV2,

        [Parameter()]
        [System.Boolean]
        $SpoFileAccessed,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelDowngraded,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoFileSharing,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSiteExternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteInternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoSiteSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSyncDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChatFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsFileDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsFolderSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsSensitiveMessage,

        [Parameter()]
        [System.Boolean]
        $UserHistory,

        [Parameter()]
        [System.Boolean]
        $AWSS3BlockPublicAccessDisabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3BucketDeleted,

        [Parameter()]
        [System.Boolean]
        $AWSS3PublicAccessEnabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3ServerLoggingDisabled,

        [Parameter()]
        [System.Boolean]
        $AzureElevateAccessToAllSubscriptions,

        [Parameter()]
        [System.Boolean]
        $AzureResourceThreatProtectionSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerAuditingSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleDeleted,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureStorageAccountOrContainerDeleted,

        [Parameter()]
        [System.Boolean]
        $BoxContentAccess,

        [Parameter()]
        [System.Boolean]
        $BoxContentDelete,

        [Parameter()]
        [System.Boolean]
        $BoxContentDownload,

        [Parameter()]
        [System.Boolean]
        $BoxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $CCFinancialRegulatoryRiskyTextSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateContentSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateImagesSent,

        [Parameter()]
        [System.Boolean]
        $DropboxContentAccess,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDelete,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDownload,

        [Parameter()]
        [System.Boolean]
        $DropboxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentAccess,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentDelete,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $PowerBIDashboardsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDownloaded,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsExported,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsViewed,

        [Parameter()]
        [System.Boolean]
        $PowerBISemanticModelsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelDowngradedForArtifacts,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelRemovedFromArtifacts,

        [Parameter()]
        [System.String]
        $HistoricTimeSpan,

        [Parameter()]
        [System.String]
        $InScopeTimeSpan,

        [Parameter()]
        [System.Boolean]
        $EnableTeam,

        [Parameter()]
        [System.Boolean]
        $AnalyticsNewInsightEnabled,

        [Parameter()]
        [System.Boolean]
        $AnalyticsTurnedOffEnabled,

        [Parameter()]
        [System.Boolean]
        $HighSeverityAlertsEnabled,

        [Parameter()]
        [System.String[]]
        $HighSeverityAlertsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $PoliciesHealthEnabled,

        [Parameter()]
        [System.String[]]
        $PoliciesHealthRoleGroups,

        [Parameter()]
        [System.Boolean]
        $NotificationDetailsEnabled,

        [Parameter()]
        [System.String[]]
        $NotificationDetailsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $ClipDeletionEnabled,

        [Parameter()]
        [System.Boolean]
        $SessionRecordingEnabled,

        [Parameter()]
        [System.String]
        $RecordingTimeframePreEventInSec,

        [Parameter()]
        [System.String]
        $RecordingTimeframePostEventInSec,

        [Parameter()]
        [System.String]
        $BandwidthCapInMb,

        [Parameter()]
        [System.String]
        $OfflineRecordingStorageLimitInMb,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionEnabled,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionHighProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionHighProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionMediumProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionMediumProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionLowProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionLowProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $ProfileInscopeTimeSpan,

        [Parameter()]
        [System.UInt32]
        $LookbackTimeSpan,

        [Parameter()]
        [System.Boolean]
        $RetainSeverityAfterTriage,

        [Parameter()]
        [System.String[]]
        $MDATPTriageStatus,

        [Parameter()]
        [System.UInt32]
        $CPUUtilizationLimit,

        [Parameter()]
        [System.UInt32]
        $GPUUtilizationLimit,

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
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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
    $nullResult.Ensure = 'Absent'
    try
    {
        if ($null -ne $Script:exportedInstances -and $Script:ExportMode)
        {
            $instance = $Script:exportedInstances | Where-Object -FilterScript {$_.Name -eq $Name}
        }
        else
        {
            $instance = Get-InsiderRiskPolicy -Identity $Name
        }

        if ($null -eq $instance)
        {
            return $nullResult
        }

        $results = @{
            Name                  = $instance.Name
            InsiderRiskScenario   = $instance.InsiderRiskScenario
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            AccessTokens          = $AccessTokens
        }

        if (-not [System.String]::IsNullOrEmpty($instance.SessionRecordingSettings))
        {
            $SessionRecordingSettings = ConvertFrom-Json $instance.SessionRecordingSettings
            $forensicSettingsHash = @{
                ClipDeletionEnabled              = [Boolean]($SessionRecordingSettings.ClipDeletionEnabled)
                SessionRecordingEnabled          = [Boolean]($SessionRecordingSettings.Enabled)
                RecordingTimeframePreEventInSec  = $SessionRecordingSettings.RecordingTimeframePreEventInSec
                RecordingTimeframePostEventInSec = $SessionRecordingSettings.RecordingTimeframePostEventInSec
                BandwidthCapInMb                 = $SessionRecordingSettings.BandwidthCapInMb
                OfflineRecordingStorageLimitInMb = $SessionRecordingSettings.OfflineRecordingStorageLimitInMb
                GPUUtilizationLimit              = $SessionRecordingSettings.GPUUtilizationLimit
                CPUUtilizationLimit              = $SessionRecordingSettings.CPUUtilizationLimit
            }
            $results += $forensicSettingsHash
        }

        if (-not [System.String]::IsNullOrEmpty($instance.TenantSettings) -and $instance.TenantSettings.Length -gt 0)
        {
            $tenantSettings = ConvertFrom-Json $instance.TenantSettings[0]

            $DLPUserRiskSyncValue = $null
            if (-not [System.String]::IsNullOrEmpty($tenantSettings.FeatureSettings.DLPUserRiskSync))
            {
                $DLPUserRiskSyncValue = [Boolean]::Parse($tenantSettings.FeatureSettings.DLPUserRiskSync)
            }

            $AnonymizationValue = $null
            if (-not [System.String]::IsNullOrEmpty($tenantSettings.FeatureSettings.Anonymization))
            {
                $AnonymizationValue = [Boolean]::Parse($tenantSettings.FeatureSettings.Anonymization)
            }

            $OptInIRMDataExportValue = $null
            if (-not [System.String]::IsNullOrEmpty($tenantSettings.FeatureSettings.OptInIRMDataExport))
            {
                $OptInIRMDataExportValue = [Boolean]::Parse($tenantSettings.FeatureSettings.OptInIRMDataExport)
            }

            $RaiseAuditAlertValue = $null
            if (-not [System.String]::IsNullOrEmpty($tenantSettings.FeatureSettings.RaiseAuditAlert))
            {
                $RaiseAuditAlertValue = [Boolean]::Parse($tenantSettings.FeatureSettings.RaiseAuditAlert)
            }

            $tenantSettingsHash = @{
                Anonymization                                 = $AnonymizationValue
                DLPUserRiskSync                               = $DLPUserRiskSyncValue
                OptInIRMDataExport                            = $OptInIRMDataExportValue
                RaiseAuditAlert                               = $RaiseAuditAlertValue
                FileVolCutoffLimits                           = $tenantSettings.IntelligentDetections.FileVolCutoffLimits
                AlertVolume                                   = $tenantSettings.IntelligentDetections.AlertVolume
                MDATPTriageStatus                             = $tenantSettings.IntelligentDetections.MDATPTriageStatus
                AnomalyDetections                             = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'AnomalyDetections'}).Enabled
                CopyToPersonalCloud                           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'CopyToPersonalCloud'}).Enabled
                CopyToUSB                                     = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'CopyToUSB'}).Enabled
                CumulativeExfiltrationDetector                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'CumulativeExfiltrationDetector'}).Enabled
                EmailExternal                                 = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmailExternal'}).Enabled
                EmployeeAccessedEmployeePatientData           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmployeeAccessedEmployeePatientData'}).Enabled
                EmployeeAccessedFamilyData                    = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmployeeAccessedFamilyData'}).Enabled
                EmployeeAccessedHighVolumePatientData         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmployeeAccessedHighVolumePatientData'}).Enabled
                EmployeeAccessedNeighbourData                 = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmployeeAccessedNeighbourData'}).Enabled
                EmployeeAccessedRestrictedData                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EmployeeAccessedRestrictedData'}).Enabled
                EpoBrowseToChildAbuseSites                    = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToChildAbuseSites'}).Enabled
                EpoBrowseToCriminalActivitySites              = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToCriminalActivitySites'}).Enabled
                EpoBrowseToCultSites                          = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToCultSites'}).Enabled
                EpoBrowseToGamblingSites                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToGamblingSites'}).Enabled
                EpoBrowseToHackingSites                       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToHackingSites'}).Enabled
                EpoBrowseToHateIntoleranceSites               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToHateIntoleranceSites'}).Enabled
                EpoBrowseToIllegalSoftwareSites               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToIllegalSoftwareSites'}).Enabled
                EpoBrowseToKeyloggerSites                     = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToKeyloggerSites'}).Enabled
                EpoBrowseToLlmSites                           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToLlmSites'}).Enabled
                EpoBrowseToMalwareSites                       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToMalwareSites'}).Enabled
                EpoBrowseToPhishingSites                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToPhishingSites'}).Enabled
                EpoBrowseToPornographySites                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToPornographySites'}).Enabled
                EpoBrowseToUnallowedDomain                    = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToUnallowedDomain'}).Enabled
                EpoBrowseToViolenceSites                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoBrowseToViolenceSites'}).Enabled
                EpoCopyToClipboardFromSensitiveFile           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoCopyToClipboardFromSensitiveFile'}).Enabled
                EpoCopyToNetworkShare                         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoCopyToNetworkShare'}).Enabled
                EpoFileArchived                               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileArchived'}).Enabled
                EpoFileCopiedToRemoteDesktopSession           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileCopiedToRemoteDesktopSession'}).Enabled
                EpoFileDeleted                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileDeleted'}).Enabled
                EpoFileDownloadedFromBlacklistedDomain        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileDownloadedFromBlacklistedDomain'}).Enabled
                EpoFileDownloadedFromEnterpriseDomain         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileDownloadedFromEnterpriseDomain'}).Enabled
                EpoFileRenamed                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileRenamed'}).Enabled
                EpoFileStagedToCentralLocation                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoFileStagedToCentralLocation'}).Enabled
                EpoHiddenFileCreated                          = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoHiddenFileCreated'}).Enabled
                EpoRemovableMediaMount                        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoRemovableMediaMount'}).Enabled
                EpoSensitiveFileRead                          = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'EpoSensitiveFileRead'}).Enabled
                Mcas3rdPartyAppDownload                       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'Mcas3rdPartyAppDownload'}).Enabled
                Mcas3rdPartyAppFileDelete                     = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'Mcas3rdPartyAppFileDelete'}).Enabled
                Mcas3rdPartyAppFileSharing                    = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'Mcas3rdPartyAppFileSharing'}).Enabled
                McasActivityFromInfrequentCountry             = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasActivityFromInfrequentCountry'}).Enabled
                McasImpossibleTravel                          = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasImpossibleTravel'}).Enabled
                McasMultipleFailedLogins                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasMultipleFailedLogins'}).Enabled
                McasMultipleStorageDeletion                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasMultipleStorageDeletion'}).Enabled
                McasMultipleVMCreation                        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasMultipleVMCreation'}).Enabled
                McasMultipleVMDeletion                        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasMultipleVMDeletion'}).Enabled
                McasSuspiciousAdminActivities                 = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasSuspiciousAdminActivities'}).Enabled
                McasSuspiciousCloudCreation                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasSuspiciousCloudCreation'}).Enabled
                McasSuspiciousCloudTrailLoggingChange         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasSuspiciousCloudTrailLoggingChange'}).Enabled
                McasTerminatedEmployeeActivity                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'McasTerminatedEmployeeActivity'}).Enabled
                OdbDownload                                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'OdbDownload'}).Enabled
                OdbSyncDownload                               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'OdbSyncDownload'}).Enabled
                PeerCumulativeExfiltrationDetector            = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'PeerCumulativeExfiltrationDetector'}).Enabled
                PhysicalAccess                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'PhysicalAccess'}).Enabled
                PotentialHighImpactUser                       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'PotentialHighImpactUser'}).Enabled
                Print                                         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'Print'}).Enabled
                PriorityUserGroupMember                       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'PriorityUserGroupMember'}).Enabled
                SecurityAlertDefenseEvasion                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SecurityAlertDefenseEvasion'}).Enabled
                SecurityAlertUnwantedSoftware                 = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SecurityAlertUnwantedSoftware'}).Enabled
                SpoAccessRequest                              = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoAccessRequest'}).Enabled
                SpoApprovedAccess                             = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoApprovedAccess'}).Enabled
                SpoDownload                                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoDownload'}).Enabled
                SpoDownloadV2                                 = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoDownloadV2'}).Enabled
                SpoFileAccessed                               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileAccessed'}).Enabled
                SpoFileDeleted                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileDeleted'}).Enabled
                SpoFileDeletedFromFirstStageRecycleBin        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileDeletedFromFirstStageRecycleBin'}).Enabled
                SpoFileDeletedFromSecondStageRecycleBin       = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileDeletedFromSecondStageRecycleBin'}).Enabled
                SpoFileLabelDowngraded                        = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileLabelDowngraded'}).Enabled
                SpoFileLabelRemoved                           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileLabelRemoved'}).Enabled
                SpoFileSharing                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFileSharing'}).Enabled
                SpoFolderDeleted                              = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFolderDeleted'}).Enabled
                SpoFolderDeletedFromFirstStageRecycleBin      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFolderDeletedFromFirstStageRecycleBin'}).Enabled
                SpoFolderDeletedFromSecondStageRecycleBin     = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFolderDeletedFromSecondStageRecycleBin'}).Enabled
                SpoFolderSharing                              = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoFolderSharing'}).Enabled
                SpoSiteExternalUserAdded                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoSiteExternalUserAdded'}).Enabled
                SpoSiteInternalUserAdded                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoSiteInternalUserAdded'}).Enabled
                SpoSiteLabelRemoved                           = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoSiteLabelRemoved'}).Enabled
                SpoSiteSharing                                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoSiteSharing'}).Enabled
                SpoSyncDownload                               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'SpoSyncDownload'}).Enabled
                TeamsChannelFileSharedExternal                = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsChannelFileSharedExternal'}).Enabled
                TeamsChannelMemberAddedExternal               = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsChannelMemberAddedExternal'}).Enabled
                TeamsChatFileSharedExternal                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsChatFileSharedExternal'}).Enabled
                TeamsFileDownload                             = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsFileDownload'}).Enabled
                TeamsFolderSharedExternal                     = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsFolderSharedExternal'}).Enabled
                TeamsMemberAddedExternal                      = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsMemberAddedExternal'}).Enabled
                TeamsSensitiveMessage                         = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'TeamsSensitiveMessage'}).Enabled
                UserHistory                                   = ($tenantSettings.Indicators | Where-Object -FilterScript {$_.Name -eq 'UserHistory'}).Enabled
                AWSS3BlockPublicAccessDisabled                = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AWSS3BlockPublicAccessDisabled'}).Enabled
                AWSS3BucketDeleted                            = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AWSS3BucketDeleted'}).Enabled
                AWSS3PublicAccessEnabled                      = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AWSS3PublicAccessEnabled'}).Enabled
                AWSS3ServerLoggingDisabled                    = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AWSS3ServerLoggingDisabled'}).Enabled
                AzureElevateAccessToAllSubscriptions          = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureElevateAccessToAllSubscriptions'}).Enabled
                AzureResourceThreatProtectionSettingsUpdated  = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureResourceThreatProtectionSettingsUpdated'}).Enabled
                AzureSQLServerAuditingSettingsUpdated         = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureSQLServerAuditingSettingsUpdated'}).Enabled
                AzureSQLServerFirewallRuleDeleted             = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureSQLServerFirewallRuleDeleted'}).Enabled
                AzureSQLServerFirewallRuleUpdated             = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureSQLServerFirewallRuleUpdated'}).Enabled
                AzureStorageAccountOrContainerDeleted         = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'AzureStorageAccountOrContainerDeleted'}).Enabled
                BoxContentAccess                              = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'BoxContentAccess'}).Enabled
                BoxContentDelete                              = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'BoxContentDelete'}).Enabled
                BoxContentDownload                            = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'BoxContentDownload'}).Enabled
                BoxContentExternallyShared                    = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'BoxContentExternallyShared'}).Enabled
                CCFinancialRegulatoryRiskyTextSent            = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'CCFinancialRegulatoryRiskyTextSent'}).Enabled
                CCInappropriateContentSent                    = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'CCInappropriateContentSent'}).Enabled
                CCInappropriateImagesSent                     = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'CCInappropriateImagesSent'}).Enabled
                DropboxContentAccess                          = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'DropboxContentAccess'}).Enabled
                DropboxContentDelete                          = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'DropboxContentDelete'}).Enabled
                DropboxContentDownload                        = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'DropboxContentDownload'}).Enabled
                DropboxContentExternallyShared                = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'DropboxContentExternallyShared'}).Enabled
                GoogleDriveContentAccess                      = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'GoogleDriveContentAccess'}).Enabled
                GoogleDriveContentDelete                      = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'GoogleDriveContentDelete'}).Enabled
                GoogleDriveContentExternallyShared            = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'GoogleDriveContentExternallyShared'}).Enabled
                PowerBIDashboardsDeleted                      = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBIDashboardsDeleted'}).Enabled
                PowerBIReportsDeleted                         = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBIReportsDeleted'}).Enabled
                PowerBIReportsDownloaded                      = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBIReportsDownloaded'}).Enabled
                PowerBIReportsExported                        = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBIReportsExported'}).Enabled
                PowerBIReportsViewed                          = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBIReportsViewed'}).Enabled
                PowerBISemanticModelsDeleted                  = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBISemanticModelsDeleted'}).Enabled
                PowerBISensitivityLabelDowngradedForArtifacts = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBISensitivityLabelDowngradedForArtifacts'}).Enabled
                PowerBISensitivityLabelRemovedFromArtifacts   = ($tenantSettings.ExtensibleIndicators | Where-Object -FilterScript {$_.Name -eq 'PowerBISensitivityLabelRemovedFromArtifacts'}).Enabled
                HistoricTimeSpan                              = $tenantSettings.TimeSpan.HistoricTimeSpan
                InScopeTimeSpan                               = $tenantSettings.TimeSpan.InScopeTimeSpan
                EnableTeam                                    = [Boolean]($tenantSettings.FeatureSettings.EnableTeam)
            }

            $AnalyticsNewInsight = $tenantSettings.NotificationPreferences | Where-Object -FilterScript {$_.NotificationType -eq 'AnalyticsNewInsight'}
            if ($null -ne $AnalyticsNewInsight)
            {
                $tenantSettingsHash.Add('AnalyticsNewInsightEnabled', [Boolean]$AnalyticsNewInsight.Enabled)
            }

            $AnalyticsTurnedOff = $tenantSettings.NotificationPreferences | Where-Object -FilterScript {$_.NotificationType -eq 'AnalyticsTurnedOff'}
            if ($null -ne $AnalyticsTurnedOff)
            {
                $tenantSettingsHash.Add('AnalyticsTurnedOffEnabled', [Boolean]$AnalyticsTurnedOff.Enabled)
            }

            $highSeverityAlerts = $tenantSettings.NotificationPreferences | Where-Object -FilterScript {$_.NotificationType -eq 'HighSeverityAlerts'}
            if ($null -ne $highSeverityAlerts)
            {
                $tenantSettingsHash.Add('HighSeverityAlertsEnabled', [Boolean]$highSeverityAlerts.Enabled)
                $tenantSettingsHash.Add('HighSeverityAlertsRoleGroups', [Array]$highSeverityAlerts.RoleGroups)
            }

            $policiesHealth = $tenantSettings.NotificationPreferences | Where-Object -FilterScript {$_.NotificationType -eq 'PoliciesHealth'}
            if ($null -ne $policiesHealth)
            {
                $tenantSettingsHash.Add('PoliciesHealthEnabled', [Boolean]$policiesHealth.Enabled)
                $tenantSettingsHash.Add('PoliciesHealthRoleGroups', [Array]$policiesHealth.RoleGroups)
            }

            if ($null -ne $tenantSettings.FeatureSettings.NotificationDetails)
            {
                $tenantSettingsHash.Add('NotificationDetailsEnabled', $true)
                $tenantSettingsHash.Add('NotificationDetailsRoleGroups', [Array]$tenantSettings.FeatureSettings.NotificationDetails.RoleGroups)
            }
            else
            {
                $tenantSettingsHash.Add('NotificationDetailsEnabled', $false)
            }

            # Adaptive Protection
            $AdaptiveProtectionEnabledValue = $false
            if ($null -ne $tenantSettings.DynamicRiskPreventionSettings -and `
                $null -ne $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings)
            {
                if ($tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.ActivationStatus -eq 0)
                {
                    $AdaptiveProtectionEnabledValue = $true
                }
                else
                {
                    $AdaptiveProtectionEnabledValue = $false
                }

                # High Profile
                if ($null -ne $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.HighProfile)
                {
                    $highProfile = $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.HighProfile
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileSourceType', $highProfile.ProfileSourceType)
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileConfirmedIssueSeverity', $highProfile.ConfirmedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileGeneratedIssueSeverity', $highProfile.GeneratedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileInsightSeverity', $highProfile.InsightSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileInsightCount', $highProfile.InsightCount)
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileInsightTypes', [Array]($highProfile.InsightTypes))
                    $tenantSettingsHash.Add('AdaptiveProtectionHighProfileConfirmedIssue', $highProfile.ConfirmedIssue)
                }

                # Medium Profile
                if ($null -ne $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.MediumProfile)
                {
                    $mediumProfile = $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.MediumProfile
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileSourceType', $mediumProfile.ProfileSourceType)
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileConfirmedIssueSeverity', $mediumProfile.ConfirmedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileGeneratedIssueSeverity', $mediumProfile.GeneratedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileInsightSeverity', $mediumProfile.InsightSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileInsightCount', $mediumProfile.InsightCount)
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileInsightTypes', [Array]($mediumProfile.InsightTypes))
                    $tenantSettingsHash.Add('AdaptiveProtectionMediumProfileConfirmedIssue', $mediumProfile.ConfirmedIssue)
                }

                # Low Profile
                if ($null -ne $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.LowProfile)
                {
                    $lowProfile = $tenantSettings.DynamicRiskPreventionSettings.DynamicRiskScenarioSettings.LowProfile
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileSourceType', $lowProfile.ProfileSourceType)
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileConfirmedIssueSeverity', $lowProfile.ConfirmedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileGeneratedIssueSeverity', $lowProfile.GeneratedIssueSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileInsightSeverity', $lowProfile.InsightSeverity)
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileInsightCount', $lowProfile.InsightCount)
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileInsightTypes', [Array]($lowProfile.InsightTypes))
                    $tenantSettingsHash.Add('AdaptiveProtectionLowProfileConfirmedIssue', $lowProfile.ConfirmedIssue)
                }

                $tenantSettingsHash.Add('ProfileInScopeTimeSpan', $tenantSettings.DynamicRiskPreventionSettings.ProfileInScopeTimeSpan)
                $tenantSettingsHash.Add('LookbackTimeSpan', $tenantSettings.DynamicRiskPreventionSettings.LookbackTimeSpan)
                $tenantSettingsHash.Add('RetainSeverityAfterTriage', $tenantSettings.DynamicRiskPreventionSettings.RetainSeverityAfterTriage)
            }
            $tenantSettingsHash.Add('AdaptiveProtectionEnabled', $AdaptiveProtectionEnabledValue)

            $results += $tenantSettingsHash
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
        $Name,

        [Parameter(Mandatory = $true)]
        [System.String]
        $InsiderRiskScenario,

        [Parameter()]
        [System.Boolean]
        $Anonymization,

        [Parameter()]
        [System.Boolean]
        $DLPUserRiskSync,

        [Parameter()]
        [System.Boolean]
        $OptInIRMDataExport,

        [Parameter()]
        [System.Boolean]
        $RaiseAuditAlert,

        [Parameter()]
        [System.String]
        $FileVolCutoffLimits,

        [Parameter()]
        [System.String]
        $AlertVolume,

        [Parameter()]
        [System.Boolean]
        $AnomalyDetections,

        [Parameter()]
        [System.Boolean]
        $CopyToPersonalCloud,

        [Parameter()]
        [System.Boolean]
        $CopyToUSB,

        [Parameter()]
        [System.Boolean]
        $CumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $EmailExternal,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedEmployeePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedFamilyData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedHighVolumePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedNeighbourData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedRestrictedData,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToChildAbuseSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCriminalActivitySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCultSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToGamblingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHackingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHateIntoleranceSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToIllegalSoftwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToKeyloggerSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToLlmSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToMalwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPhishingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPornographySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToUnallowedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToViolenceSites,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToClipboardFromSensitiveFile,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToNetworkShare,

        [Parameter()]
        [System.Boolean]
        $EpoFileArchived,

        [Parameter()]
        [System.Boolean]
        $EpoFileCopiedToRemoteDesktopSession,

        [Parameter()]
        [System.Boolean]
        $EpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromBlacklistedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromEnterpriseDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileRenamed,

        [Parameter()]
        [System.Boolean]
        $EpoFileStagedToCentralLocation,

        [Parameter()]
        [System.Boolean]
        $EpoHiddenFileCreated,

        [Parameter()]
        [System.Boolean]
        $EpoRemovableMediaMount,

        [Parameter()]
        [System.Boolean]
        $EpoSensitiveFileRead,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppDownload,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileDelete,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileSharing,

        [Parameter()]
        [System.Boolean]
        $McasActivityFromInfrequentCountry,

        [Parameter()]
        [System.Boolean]
        $McasImpossibleTravel,

        [Parameter()]
        [System.Boolean]
        $McasMultipleFailedLogins,

        [Parameter()]
        [System.Boolean]
        $McasMultipleStorageDeletion,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMCreation,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMDeletion,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousAdminActivities,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudCreation,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudTrailLoggingChange,

        [Parameter()]
        [System.Boolean]
        $McasTerminatedEmployeeActivity,

        [Parameter()]
        [System.Boolean]
        $OdbDownload,

        [Parameter()]
        [System.Boolean]
        $OdbSyncDownload,

        [Parameter()]
        [System.Boolean]
        $PeerCumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $PhysicalAccess,

        [Parameter()]
        [System.Boolean]
        $PotentialHighImpactUser,

        [Parameter()]
        [System.Boolean]
        $Print,

        [Parameter()]
        [System.Boolean]
        $PriorityUserGroupMember,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertDefenseEvasion,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertUnwantedSoftware,

        [Parameter()]
        [System.Boolean]
        $SpoAccessRequest,

        [Parameter()]
        [System.Boolean]
        $SpoApprovedAccess,

        [Parameter()]
        [System.Boolean]
        $SpoDownload,

        [Parameter()]
        [System.Boolean]
        $SpoDownloadV2,

        [Parameter()]
        [System.Boolean]
        $SpoFileAccessed,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelDowngraded,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoFileSharing,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSiteExternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteInternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoSiteSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSyncDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChatFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsFileDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsFolderSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsSensitiveMessage,

        [Parameter()]
        [System.Boolean]
        $UserHistory,

        [Parameter()]
        [System.Boolean]
        $AWSS3BlockPublicAccessDisabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3BucketDeleted,

        [Parameter()]
        [System.Boolean]
        $AWSS3PublicAccessEnabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3ServerLoggingDisabled,

        [Parameter()]
        [System.Boolean]
        $AzureElevateAccessToAllSubscriptions,

        [Parameter()]
        [System.Boolean]
        $AzureResourceThreatProtectionSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerAuditingSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleDeleted,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureStorageAccountOrContainerDeleted,

        [Parameter()]
        [System.Boolean]
        $BoxContentAccess,

        [Parameter()]
        [System.Boolean]
        $BoxContentDelete,

        [Parameter()]
        [System.Boolean]
        $BoxContentDownload,

        [Parameter()]
        [System.Boolean]
        $BoxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $CCFinancialRegulatoryRiskyTextSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateContentSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateImagesSent,

        [Parameter()]
        [System.Boolean]
        $DropboxContentAccess,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDelete,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDownload,

        [Parameter()]
        [System.Boolean]
        $DropboxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentAccess,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentDelete,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $PowerBIDashboardsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDownloaded,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsExported,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsViewed,

        [Parameter()]
        [System.Boolean]
        $PowerBISemanticModelsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelDowngradedForArtifacts,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelRemovedFromArtifacts,

        [Parameter()]
        [System.String]
        $HistoricTimeSpan,

        [Parameter()]
        [System.String]
        $InScopeTimeSpan,

        [Parameter()]
        [System.Boolean]
        $EnableTeam,

        [Parameter()]
        [System.Boolean]
        $AnalyticsNewInsightEnabled,

        [Parameter()]
        [System.Boolean]
        $AnalyticsTurnedOffEnabled,

        [Parameter()]
        [System.Boolean]
        $HighSeverityAlertsEnabled,

        [Parameter()]
        [System.String[]]
        $HighSeverityAlertsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $PoliciesHealthEnabled,

        [Parameter()]
        [System.String[]]
        $PoliciesHealthRoleGroups,

        [Parameter()]
        [System.Boolean]
        $NotificationDetailsEnabled,

        [Parameter()]
        [System.String[]]
        $NotificationDetailsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $ClipDeletionEnabled,

        [Parameter()]
        [System.Boolean]
        $SessionRecordingEnabled,

        [Parameter()]
        [System.String]
        $RecordingTimeframePreEventInSec,

        [Parameter()]
        [System.String]
        $RecordingTimeframePostEventInSec,

        [Parameter()]
        [System.String]
        $BandwidthCapInMb,

        [Parameter()]
        [System.String]
        $OfflineRecordingStorageLimitInMb,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionEnabled,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionHighProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionHighProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionMediumProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionMediumProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionLowProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionLowProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $ProfileInscopeTimeSpan,

        [Parameter()]
        [System.UInt32]
        $LookbackTimeSpan,

        [Parameter()]
        [System.Boolean]
        $RetainSeverityAfterTriage,

        [Parameter()]
        [System.String[]]
        $MDATPTriageStatus,

        [Parameter()]
        [System.UInt32]
        $CPUUtilizationLimit,

        [Parameter()]
        [System.UInt32]
        $GPUUtilizationLimit,

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

    $currentInstance = Get-TargetResource @PSBoundParameters

    $setParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    $indicatorsProperties = @('AnomalyDetections','CopyToPersonalCloud','CopyToUSB','CumulativeExfiltrationDetector', `
                              'EmailExternal','EmployeeAccessedEmployeePatientData','EmployeeAccessedFamilyData', `
                              'EmployeeAccessedHighVolumePatientData','EmployeeAccessedNeighbourData', `
                              'EmployeeAccessedRestrictedData','EpoBrowseToChildAbuseSites','EpoBrowseToCriminalActivitySites', `
                              'EpoBrowseToCultSites','EpoBrowseToGamblingSites','EpoBrowseToHackingSites', `
                              'EpoBrowseToHateIntoleranceSites','EpoBrowseToIllegalSoftwareSites','EpoBrowseToKeyloggerSites', `
                              'EpoBrowseToLlmSites','EpoBrowseToMalwareSites','EpoBrowseToPhishingSites', `
                              'EpoBrowseToPornographySites','EpoBrowseToUnallowedDomain','EpoBrowseToViolenceSites', `
                              'EpoCopyToClipboardFromSensitiveFile','EpoCopyToNetworkShare','EpoFileArchived', `
                              'EpoFileCopiedToRemoteDesktopSession','EpoFileDeleted','EpoFileDownloadedFromBlacklistedDomain', `
                              'EpoFileDownloadedFromEnterpriseDomain','EpoFileRenamed','EpoFileStagedToCentralLocation', `
                              'EpoHiddenFileCreated','EpoRemovableMediaMount','EpoSensitiveFileRead','Mcas3rdPartyAppDownload', `
                              'Mcas3rdPartyAppFileDelete','Mcas3rdPartyAppFileSharing','McasActivityFromInfrequentCountry', `
                              'McasImpossibleTravel','McasMultipleFailedLogins','McasMultipleStorageDeletion', `
                              'McasMultipleVMCreation','McasMultipleVMDeletion','McasSuspiciousAdminActivities', `
                              'McasSuspiciousCloudCreation','McasSuspiciousCloudTrailLoggingChange','McasTerminatedEmployeeActivity', `
                              'OdbDownload','OdbSyncDownload','PeerCumulativeExfiltrationDetector','PhysicalAccess', `
                              'PotentialHighImpactUser','Print','PriorityUserGroupMember','SecurityAlertDefenseEvasion', `
                              'SecurityAlertUnwantedSoftware','SpoAccessRequest','SpoApprovedAccess','SpoDownload','SpoDownloadV2', `
                              'SpoFileAccessed','SpoFileDeleted','SpoFileDeletedFromFirstStageRecycleBin', `
                              'SpoFileDeletedFromSecondStageRecycleBin','SpoFileLabelDowngraded','SpoFileLabelRemoved', `
                              'SpoFileSharing','SpoFolderDeleted','SpoFolderDeletedFromFirstStageRecycleBin', `
                              'SpoFolderDeletedFromSecondStageRecycleBin','SpoFolderSharing','SpoSiteExternalUserAdded', `
                              'SpoSiteInternalUserAdded','SpoSiteLabelRemoved','SpoSiteSharing','SpoSyncDownload', `
                              'TeamsChannelFileSharedExternal','TeamsChannelMemberAddedExternal','TeamsChatFileSharedExternal', `
                              'TeamsFileDownload','TeamsFolderSharedExternal','TeamsMemberAddedExternal','TeamsSensitiveMessage', `
                              'UserHistory')

    $indicatorValues = @()
    foreach ($indicatorProperty in $indicatorsProperties)
    {
        if ($PSBoundParameters.ContainsKey($indicatorProperty))
        {
            $indicatorValues += "{`"Name`":`"$indicatorProperty`",`"Type`":`"Insight`",`"Enabled`":$(($PSBoundParameters.$indicatorProperty).ToString().ToLower()),`"UseDefault`":true,`"ThresholdMode`":`"Default`"}"
        }
    }

    $extensibleIndicatorsProperties = @('AWSS3BlockPublicAccessDisabled','AWSS3BucketDeleted','AWSS3PublicAccessEnabled',`
        'AWSS3ServerLoggingDisabled','AzureElevateAccessToAllSubscriptions','AzureResourceThreatProtectionSettingsUpdated', `
        'AzureSQLServerAuditingSettingsUpdated','AzureSQLServerFirewallRuleDeleted','AzureSQLServerFirewallRuleUpdated', `
        'AzureStorageAccountOrContainerDeleted','BoxContentAccess','BoxContentDelete','BoxContentDownload','BoxContentExternallyShared', `
        'CCFinancialRegulatoryRiskyTextSent','CCInappropriateContentSent','CCInappropriateImagesSent','DropboxContentAccess', `
        'DropboxContentDelete','DropboxContentDownload','DropboxContentExternallyShared','GoogleDriveContentAccess', `
        'GoogleDriveContentDelete','GoogleDriveContentExternallyShared','PowerBIDashboardsDeleted','PowerBIReportsDeleted', `
        'PowerBIReportsDownloaded','PowerBIReportsExported','PowerBIReportsViewed','PowerBISemanticModelsDeleted', `
        'PowerBISensitivityLabelDowngradedForArtifacts','PowerBISensitivityLabelRemovedFromArtifacts')

    $extensibleIndicatorsValues = @()
    foreach ($extensibleIndicatorsProperty in $extensibleIndicatorsProperties)
    {
        if ($PSBoundParameters.ContainsKey($extensibleIndicatorsProperty))
        {
            $extensibleIndicatorsValues += "{`"Name`":`"$extensibleIndicatorsProperty`",`"Type`":`"ExtensibleInsight`",`"Enabled`":$(($PSBoundParameters.$extensibleIndicatorsProperty).ToString().ToLower()),`"UseDefault`":true,`"ThresholdMode`":`"Default`"}"
        }
    }

    # Tenant Settings
    $featureSettingsValue = "{`"Anonymization`":$($Anonymization.ToString().ToLower()), `"DLPUserRiskSync`":$($DLPUserRiskSync.ToString().ToLower()), `"OptInIRMDataExport`":$($OptInIRMDataExport.ToString().ToLower()), `"RaiseAuditAlert`":$($RaiseAuditAlert.ToString().ToLower()), `"EnableTeam`":$($EnableTeam.ToString().ToLower())}"
    $intelligentDetectionValue = "{`"FileVolCutoffLimits`":`"$($FileVolCutoffLimits)`", `"AlertVolume`":`"$($AlertVolume)`", `"MDATPTriageStatus`": `"$($MDATPTriageStatus)`"}"


    $tenantSettingsValue = "{`"Region`":`"WW`", `"FeatureSettings`":$($featureSettingsValue), " + `
                            "`"IntelligentDetections`":$($intelligentDetectionValue)"
    if ($null -ne $AdaptiveProtectionEnabled)
    {
        Write-Verbose -Message "Adding Adaptive Protection setting to the set parameters."
        $AdaptiveProtectionActivatonStatus = 1
        if ($AdaptiveProtectionEnabled)
        {
            $AdaptiveProtectionActivatonStatus = 0
        }
        $dynamicRiskPreventionSettings = "{`"RetainSeverityAfterTriage`":$($RetainSeverityAfterTriage.ToString().ToLower()),`"ProfileInScopeTimeSpan`":$($ProfileInscopeTimeSpan), `"LookbackTimeSpan`":$($LookbackTimeSpan), `"DynamicRiskScenarioSettings`":[{`"ActivationStatus`":$AdaptiveProtectionActivatonStatus"
        $dynamicRiskPreventionSettings += ", `"HighProfile`":{`"ProfileSourceType`":$($AdaptiveProtectionHighProfileSourceType), `"ConfirmedIssueSeverity`":$($AdaptiveProtectionHighProfileConfirmedIssueSeverity), `"GeneratedIssueSeverity`":$($AdaptiveProtectionHighProfileGeneratedIssueSeverity), `"InsightSeverity`": $($AdaptiveProtectionHighProfileInsightSeverity), `"InsightCount`": $($AdaptiveProtectionHighProfileInsightCount), `"InsightTypes`": [`"$($AdaptiveProtectionHighProfileInsightTypes -join '","')`"], `"ConfirmedIssue`": $($AdaptiveProtectionHighProfileConfirmedIssue.ToString().ToLower())}"
        $dynamicRiskPreventionSettings += ", `"MediumProfile`":{`"ProfileSourceType`":$($AdaptiveProtectionMediumProfileSourceType), `"ConfirmedIssueSeverity`":$($AdaptiveProtectionMediumProfileConfirmedIssueSeverity), `"GeneratedIssueSeverity`":$($AdaptiveProtectionMediumProfileGeneratedIssueSeverity), `"InsightSeverity`": $($AdaptiveProtectionMediumProfileInsightSeverity), `"InsightCount`": $($AdaptiveProtectionMediumProfileInsightCount), `"InsightTypes`": [`"$($AdaptiveProtectionMediumProfileInsightTypes -join '","')`"], `"ConfirmedIssue`": $($AdaptiveProtectionMediumProfileConfirmedIssue.ToString().ToLower())}"
        $dynamicRiskPreventionSettings += ", `"LowProfile`":{`"ProfileSourceType`":$($AdaptiveProtectionLowProfileSourceType), `"ConfirmedIssueSeverity`":$($AdaptiveProtectionLowProfileConfirmedIssueSeverity), `"GeneratedIssueSeverity`":$($AdaptiveProtectionLowProfileGeneratedIssueSeverity), `"InsightSeverity`": $($AdaptiveProtectionLowProfileInsightSeverity), `"InsightCount`": $($AdaptiveProtectionLowProfileInsightCount), `"InsightTypes`": [`"$($AdaptiveProtectionLowProfileInsightTypes -join '","')`"], `"ConfirmedIssue`": $($AdaptiveProtectionLowProfileConfirmedIssue.ToString().ToLower())}"
        $dynamicRiskPreventionSettings += '}]}'
        $tenantSettingsValue += ", `"DynamicRiskPreventionSettings`":$dynamicRiskPreventionSettings"
    }

    $tenantSettingsValue += "}"

    # CREATE
    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating new Insider Risk Policy {$Name} with values:`r`nIndicators: $($indicatorValues)`r`n`r`nExtensibleIndicators: $($extensibleIndicatorsValues)`r`n`r`nTenantSettings: $($tenantSettingsValue)`r`n`r`nSessionRecordingSettings: $($sessionRecordingValues)"
        New-InsiderRiskPolicy -Name $Name -InsiderRiskScenario $InsiderRiskScenario `
                              -Indicators $indicatorValues `
                              -ExtensibleIndicators $extensibleIndicatorsValues `
                              -TenantSetting $tenantSettingsValue `
                              -HistoricTimeSpan $HistoricTimeSpan `
                              -InScopeTimeSpan $InScopeTimeSpan `
                              -SessionRecordingSettings $sessionRecordingValues
    }
    # UPDATE
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating existing Insider Risk Policy {$Name} with values:`r`nIndicators: $($indicatorValues)`r`n`r`nExtensibleIndicators: $($extensibleIndicatorsValues)`r`n`r`nTenantSettings: $($tenantSettingsValue)`r`n`r`nSessionRecordingSettings: $($sessionRecordingValues)"

        if ($InsiderRiskScenario -eq 'SessionRecordingSetting')
        {
            $sessionRecordingValues = "{`"RecordingMode`":`"EventDriven`", `"RecordingTimeframePreEventInSec`":$($RecordingTimeframePreEventInSec),`"RecordingTimeframePostEventInSec`":$($RecordingTimeframePostEventInSec),`"BandwidthCapInMb`":$($BandwidthCapInMb),`"OfflineRecordingStorageLimitInMb`":$($OfflineRecordingStorageLimitInMb),`"ClipDeletionEnabled`":$($ClipDeletionEnabled.ToString().ToLower()),`"Enabled`":$($SessionRecordingEnabled.ToString().ToLower()),`"FpsNumerator`":0,`"FpsDenominator`":0, `"GPUUtilizationLimit`": $($GPUUtilizationLimit), `"CPUUtilizationLimit`": $($CPUUtilizationLimit)}"
            Write-Verbose -Message 'Updating Session Recording Settings'
            Set-InsiderRiskPolicy -Identity $Name -SessionRecordingSettings $sessionRecordingValues | Out-Null
        }
        else
        {
            Set-InsiderRiskPolicy -Identity $Name -Indicators $indicatorValues `
                -ExtensibleIndicators $extensibleIndicatorsValues `
                -TenantSetting $tenantSettingsValue `
                -HistoricTimeSpan $HistoricTimeSpan `
                -InScopeTimeSpan $InScopeTimeSpan
        }
    }
    # REMOVE
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing Insider Risk Policy {$Name}"
        Remove-InsiderRiskPolicy -Identity $Name -Confirm:$false
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
        $InsiderRiskScenario,

        [Parameter()]
        [System.Boolean]
        $Anonymization,

        [Parameter()]
        [System.Boolean]
        $DLPUserRiskSync,

        [Parameter()]
        [System.Boolean]
        $OptInIRMDataExport,

        [Parameter()]
        [System.Boolean]
        $RaiseAuditAlert,

        [Parameter()]
        [System.String]
        $FileVolCutoffLimits,

        [Parameter()]
        [System.String]
        $AlertVolume,

        [Parameter()]
        [System.Boolean]
        $AnomalyDetections,

        [Parameter()]
        [System.Boolean]
        $CopyToPersonalCloud,

        [Parameter()]
        [System.Boolean]
        $CopyToUSB,

        [Parameter()]
        [System.Boolean]
        $CumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $EmailExternal,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedEmployeePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedFamilyData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedHighVolumePatientData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedNeighbourData,

        [Parameter()]
        [System.Boolean]
        $EmployeeAccessedRestrictedData,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToChildAbuseSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCriminalActivitySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToCultSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToGamblingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHackingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToHateIntoleranceSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToIllegalSoftwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToKeyloggerSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToLlmSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToMalwareSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPhishingSites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToPornographySites,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToUnallowedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoBrowseToViolenceSites,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToClipboardFromSensitiveFile,

        [Parameter()]
        [System.Boolean]
        $EpoCopyToNetworkShare,

        [Parameter()]
        [System.Boolean]
        $EpoFileArchived,

        [Parameter()]
        [System.Boolean]
        $EpoFileCopiedToRemoteDesktopSession,

        [Parameter()]
        [System.Boolean]
        $EpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromBlacklistedDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileDownloadedFromEnterpriseDomain,

        [Parameter()]
        [System.Boolean]
        $EpoFileRenamed,

        [Parameter()]
        [System.Boolean]
        $EpoFileStagedToCentralLocation,

        [Parameter()]
        [System.Boolean]
        $EpoHiddenFileCreated,

        [Parameter()]
        [System.Boolean]
        $EpoRemovableMediaMount,

        [Parameter()]
        [System.Boolean]
        $EpoSensitiveFileRead,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppDownload,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileDelete,

        [Parameter()]
        [System.Boolean]
        $Mcas3rdPartyAppFileSharing,

        [Parameter()]
        [System.Boolean]
        $McasActivityFromInfrequentCountry,

        [Parameter()]
        [System.Boolean]
        $McasImpossibleTravel,

        [Parameter()]
        [System.Boolean]
        $McasMultipleFailedLogins,

        [Parameter()]
        [System.Boolean]
        $McasMultipleStorageDeletion,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMCreation,

        [Parameter()]
        [System.Boolean]
        $McasMultipleVMDeletion,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousAdminActivities,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudCreation,

        [Parameter()]
        [System.Boolean]
        $McasSuspiciousCloudTrailLoggingChange,

        [Parameter()]
        [System.Boolean]
        $McasTerminatedEmployeeActivity,

        [Parameter()]
        [System.Boolean]
        $OdbDownload,

        [Parameter()]
        [System.Boolean]
        $OdbSyncDownload,

        [Parameter()]
        [System.Boolean]
        $PeerCumulativeExfiltrationDetector,

        [Parameter()]
        [System.Boolean]
        $PhysicalAccess,

        [Parameter()]
        [System.Boolean]
        $PotentialHighImpactUser,

        [Parameter()]
        [System.Boolean]
        $Print,

        [Parameter()]
        [System.Boolean]
        $PriorityUserGroupMember,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertDefenseEvasion,

        [Parameter()]
        [System.Boolean]
        $SecurityAlertUnwantedSoftware,

        [Parameter()]
        [System.Boolean]
        $SpoAccessRequest,

        [Parameter()]
        [System.Boolean]
        $SpoApprovedAccess,

        [Parameter()]
        [System.Boolean]
        $SpoDownload,

        [Parameter()]
        [System.Boolean]
        $SpoDownloadV2,

        [Parameter()]
        [System.Boolean]
        $SpoFileAccessed,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelDowngraded,

        [Parameter()]
        [System.Boolean]
        $SpoFileLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoFileSharing,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeleted,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromFirstStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderDeletedFromSecondStageRecycleBin,

        [Parameter()]
        [System.Boolean]
        $SpoFolderSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSiteExternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteInternalUserAdded,

        [Parameter()]
        [System.Boolean]
        $SpoSiteLabelRemoved,

        [Parameter()]
        [System.Boolean]
        $SpoSiteSharing,

        [Parameter()]
        [System.Boolean]
        $SpoSyncDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChannelMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsChatFileSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsFileDownload,

        [Parameter()]
        [System.Boolean]
        $TeamsFolderSharedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsMemberAddedExternal,

        [Parameter()]
        [System.Boolean]
        $TeamsSensitiveMessage,

        [Parameter()]
        [System.Boolean]
        $UserHistory,

        [Parameter()]
        [System.Boolean]
        $AWSS3BlockPublicAccessDisabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3BucketDeleted,

        [Parameter()]
        [System.Boolean]
        $AWSS3PublicAccessEnabled,

        [Parameter()]
        [System.Boolean]
        $AWSS3ServerLoggingDisabled,

        [Parameter()]
        [System.Boolean]
        $AzureElevateAccessToAllSubscriptions,

        [Parameter()]
        [System.Boolean]
        $AzureResourceThreatProtectionSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerAuditingSettingsUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleDeleted,

        [Parameter()]
        [System.Boolean]
        $AzureSQLServerFirewallRuleUpdated,

        [Parameter()]
        [System.Boolean]
        $AzureStorageAccountOrContainerDeleted,

        [Parameter()]
        [System.Boolean]
        $BoxContentAccess,

        [Parameter()]
        [System.Boolean]
        $BoxContentDelete,

        [Parameter()]
        [System.Boolean]
        $BoxContentDownload,

        [Parameter()]
        [System.Boolean]
        $BoxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $CCFinancialRegulatoryRiskyTextSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateContentSent,

        [Parameter()]
        [System.Boolean]
        $CCInappropriateImagesSent,

        [Parameter()]
        [System.Boolean]
        $DropboxContentAccess,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDelete,

        [Parameter()]
        [System.Boolean]
        $DropboxContentDownload,

        [Parameter()]
        [System.Boolean]
        $DropboxContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentAccess,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentDelete,

        [Parameter()]
        [System.Boolean]
        $GoogleDriveContentExternallyShared,

        [Parameter()]
        [System.Boolean]
        $PowerBIDashboardsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsDownloaded,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsExported,

        [Parameter()]
        [System.Boolean]
        $PowerBIReportsViewed,

        [Parameter()]
        [System.Boolean]
        $PowerBISemanticModelsDeleted,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelDowngradedForArtifacts,

        [Parameter()]
        [System.Boolean]
        $PowerBISensitivityLabelRemovedFromArtifacts,

        [Parameter()]
        [System.String]
        $HistoricTimeSpan,

        [Parameter()]
        [System.String]
        $InScopeTimeSpan,

        [Parameter()]
        [System.Boolean]
        $EnableTeam,

        [Parameter()]
        [System.Boolean]
        $AnalyticsNewInsightEnabled,

        [Parameter()]
        [System.Boolean]
        $AnalyticsTurnedOffEnabled,

        [Parameter()]
        [System.Boolean]
        $HighSeverityAlertsEnabled,

        [Parameter()]
        [System.String[]]
        $HighSeverityAlertsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $PoliciesHealthEnabled,

        [Parameter()]
        [System.String[]]
        $PoliciesHealthRoleGroups,

        [Parameter()]
        [System.Boolean]
        $NotificationDetailsEnabled,

        [Parameter()]
        [System.String[]]
        $NotificationDetailsRoleGroups,

        [Parameter()]
        [System.Boolean]
        $ClipDeletionEnabled,

        [Parameter()]
        [System.Boolean]
        $SessionRecordingEnabled,

        [Parameter()]
        [System.String]
        $RecordingTimeframePreEventInSec,

        [Parameter()]
        [System.String]
        $RecordingTimeframePostEventInSec,

        [Parameter()]
        [System.String]
        $BandwidthCapInMb,

        [Parameter()]
        [System.String]
        $OfflineRecordingStorageLimitInMb,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionEnabled,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionHighProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionHighProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionHighProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionMediumProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionMediumProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionMediumProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileSourceType,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileConfirmedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileGeneratedIssueSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightSeverity,

        [Parameter()]
        [System.UInt32]
        $AdaptiveProtectionLowProfileInsightCount,

        [Parameter()]
        [System.String[]]
        $AdaptiveProtectionLowProfileInsightTypes,

        [Parameter()]
        [System.Boolean]
        $AdaptiveProtectionLowProfileConfirmedIssue,

        [Parameter()]
        [System.UInt32]
        $ProfileInscopeTimeSpan,

        [Parameter()]
        [System.UInt32]
        $LookbackTimeSpan,

        [Parameter()]
        [System.Boolean]
        $RetainSeverityAfterTriage,

        [Parameter()]
        [System.String[]]
        $MDATPTriageStatus,

        [Parameter()]
        [System.UInt32]
        $CPUUtilizationLimit,

        [Parameter()]
        [System.UInt32]
        $GPUUtilizationLimit,

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

    $ConnectionMode = New-M365DSCConnection -Workload 'SecurityComplianceCenter' `
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
        [array] $Script:exportedInstances = Get-InsiderRiskPolicy -ErrorAction Stop

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
        foreach ($config in $Script:exportedInstances)
        {
            if ($null -ne $Global:M365DSCExportResourceInstancesCount)
            {
                $Global:M365DSCExportResourceInstancesCount++
            }
            $displayedKey = $config.Name
            Write-Host "    |---[$i/$($Script:exportedInstances.Count)] $displayedKey" -NoNewline
            $params = @{
                Name                  = $config.Name
                InsiderRiskScenario   = $config.InsiderRiskScenario
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity       = $ManagedIdentity.IsPresent
                AccessTokens          = $AccessTokens
            }

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
