# Change log for Microsoft365DSC

# UNRELEASED

* AADAccessReviewDefinition
  * Initial release.
* AADCustomSecurityAttributeDefinition
  * Fixed missing permissions in settings.json
* AADIdentityB2XUserFlow
  * Initial release.
* AADIdentityGovernanceProgram
  * Initial release.
* AADSocialIdentityProvider
  * Fixed missing permissions in settings.json
* Intune workload
  * Fixed missing permissions in settings.json
* SPOTenantSettings
  * Added support for AllowSelectSGsInODBListInTenant,
    DenySelectSGsInODBListInTenant, DenySelectSecurityGroupsInSPSitesList,
    AllowSelectSecurityGroupsInSPSitesList,
    ExemptNativeUsersFromTenantLevelRestricedAccessControl properties.
  * TenantDefaultTimezone changed to String instead of Array.
* M365DSCDRGUtil
  * Fixes an issue where non-unique properties were not combined
    properly with their respective parent setting.

# 1.24.1016.1

* AADAdminConsentRequestPolicy
  * Initial release.
* AADApplication
  * Fixed an issue trying to retrieve the beta instance.
  * Added support for OnPremisesPublishing.
  * Added support for ApplicationTemplate.
  * Fixes an issue where trying to apply permissions complained about
    duplicate entries.
* AADAuthenticationRequirement
  * Initial release.
* AADConnectorGroupApplicationProxy
  * Initial release.
* AADCustomSecurityAttributeDefinition
  * Initial release.
* AADDeviceRegistrationPolicy
  * Initial release.
* AADEntitlementManagementSettings
  * Added support for ApplicationSecret
* AADIdentityGovernanceLifecycleWorkflow
  * Initial release.
* AADLifecycleWorkflowSettings
  * Initial release.
* AADServicePrincipal
  * Adding Delegated Permission Classification Property
* ADOPermissionGroupSettings
  * Initial release.
* EXOATPBuiltInProtectionRule
  * Initial release.
* EXOMigrationEndpoint
  * Initial Release
* IntuneAccountProtectionPolicy
  * Added deprecation notice.
* IntuneAccountProtectionPolicyWindows10
  * Initial Release
    FIXES [#5073](https://github.com/microsoft/Microsoft365DSC/issues/5073)
* IntuneAppAndBrowserIsolationPolicyWindows10
  * Initial release.
    FIXES [#3028](https://github.com/microsoft/Microsoft365DSC/issues/3028)
* IntuneDerivedCredential
  * Initial release.
* IntuneDeviceConfigurationIdentityProtectionPolicyWindows10
  * Added deprecation notice.
* IntuneEndpointDetectionAndResponsePolicyWindows10
  * Migrate to new Settings Catalog cmdlets.
* IntuneMobileAppsMacOSLobApp
  * Initial release
* IntuneMobileAppsWindowsOfficeSuiteApp
  * Initial release
* IntuneSecurityBaselineMicrosoft365AppsForEnterprise
  * Initial release
* IntuneSecurityBaselineMicrosoftEdge
  * Initial release
* PPAdminDLPPolicy
  * Initial release.
* PPDLPPolicyConnectorConfigurations
  * Initial release.
* PPPowerAppPolicyUrlPatterns
  * Initial release.
* TeamsClientConfiguration
  * Fixed bug where RestrictedSenderList was always empty in the MSFT_TeamsClientConfiguration resource
    FIXES [#5190](https://github.com/microsoft/Microsoft365DSC/issues/5190)
  * Changed Set-TargetResource to always use semicolon as separator as mentioned in the MS documentation
* TeamsUpgradePolicy
  * Added support for tenant wide changes using the * value for users.
    FIXES [#5174](https://github.com/microsoft/Microsoft365DSC/issues/5174)
* TeamsGroupPolicyAssignments
  * FIXES [#5179](https://github.com/microsoft/Microsoft365DSC/issues/5179)
* M365DSCDRGUtil
  * Fixes an issue for the handling of skipped one-property elements in the
    Settings Catalog. FIXES [#5086](https://github.com/microsoft/Microsoft365DSC/issues/5086)
  * Add Set support for secret Settings Catalog values
  * Removed unused functions
  * Add support for device / user scoped settings.
* ResourceGenerator
  * Add support for device / user scoped settings.
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.11
  * Updated ReverseDSC to version 2.0.0.21

# 1.24.1002.1

* AADAdministrativeUnit
  * Added support for property IsMemberManagementRestricted.
* AADApplication
  * Added AppRoles
  * Added AuthenticationBehavior
  * Added KeyCredentials
  * Added OptionalClaims
  * Added PasswordCredentials
  * Added PreAuthorizationApplications
* AADAuthenticationMethodPolicy
  * Added ReportSuspiciousActivitySettings
* AADAuthenticationMethodPolicyHardware
  * Initial release.
* AADEntitlementManagementSettings
  * Initial release.
* AADFeatureRolloutPolicy
  * Initial release
* AADGroup
  * Fixes issue with incorrect removal of assigned license(s)
    FIXES [#5128](https://github.com/microsoft/Microsoft365DSC/issues/5128)
  * Fixes logic to evaluate license assignments and disabled plans.
    FIXES [#5101](https://github.com/microsoft/Microsoft365DSC/issues/5101)
  * Fixes issue with code that is never executed
    FIXES [#5001](https://github.com/microsoft/Microsoft365DSC/issues/5001)
  * Adds support to assign Service Principal as members or owners.
    FIXES [#4972](https://github.com/microsoft/Microsoft365DSC/issues/4972)
* AADPasswordRuleSettings
  * Initial release
* ADOOrganizationOwner
  * Initial release.
* ADOPermissionGroup
  * Initial release.
* ADOSecurityPolicy
  * Initial release.
* AzureSubscription
  * Initial Release.
* DefenderSubscriptionDefenderPlan
  * Initial release.
* EXOAntiPhishPolicy
  * Use correct type integer for variable `PhishThresholdLevel`
* EXOArcConfig
  * Initial Release.
* EXOAuthenticationPolicy
  * If policy needs changes then recreate it to avoid issue with
    `Set-AuthenticationPolicy` cmdlet
    FIXES [#4819](https://github.com/microsoft/Microsoft365DSC/issues/4819)
* EXODnssecForVerifiedDomain
  * Initial Release.
* EXOEmailTenantSettings
  * Initial Release.
* EXOFocusedInbox
  * Initial Release.
* EXOMailboxCalendarConfiguration
  * Initial Release.
* EXOMailboxIRMAccess
  * Initial Release.
* EXOMailboxFolderPermission
  * Initial Release.
* EXOMailboxIRMAccess
  * Initial Release.
* EXOMailTips
  * Remove property `Ensure` since this resource is of type `IsSingleInstance`
* EXOManagementScope
  * Initial Release.
* EXORetentionPolicy
  * Initial Release.
* EXOPhishSimOverrideRule
  * Initial Release.
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Fixes an issue with invalid parameter definition.
    FIXES [#5015](https://github.com/microsoft/Microsoft365DSC/issues/5015)
  * Fixes an issue where the `AccessTokens` parameter was not available.
    FIXES [#5121](https://github.com/microsoft/Microsoft365DSC/issues/5121)
* IntuneAppCategory
  * Initial release.
* IntuneAppProtectionPolicyiOS
  * Improve `TargetedAppManagementLevels` property to specify multiple values.
    FIXES [#5032](https://github.com/microsoft/Microsoft365DSC/issues/5032)
* IntuneDeviceCompliancePolicyWindows10
  * Fixes an issue where the property `ValidOperatingSystemBuildRanges` was
    not exported properly.
    FIXES [#5030](https://github.com/microsoft/Microsoft365DSC/issues/5030)
* IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10
  * Add missing `AccessTokens` parameter to `Export-TargetResource`
    FIXES [#5034](https://github.com/microsoft/Microsoft365DSC/issues/5034)
* IntuneFirewallPolicyWindows10
  * Initial release
    FIXES [#3033](https://github.com/microsoft/Microsoft365DSC/issues/3033)
* IntuneSettingCatalogCustomPolicyWindows10
  * Update export logic to target more specific policy types.
  * Prevent thrown exception to be caught by exception handler.
    FIXES [#5088](https://github.com/microsoft/Microsoft365DSC/issues/5088)
* M365DSCDRGUtil
  * Add support for more complex Intune Settings Catalog properties
  * Update handling of `Update-IntuneDeviceConfigurationPolicy` to throw on error
    FIXES [#5055](https://github.com/microsoft/Microsoft365DSC/issues/5055)
* M365DSCResourceGenerator
  * Update Intune resource generation for the Settings Catalog.
* O365ExternalConnection
  * Initial release.
* SCDeviceConditionalAccessRule
  * Initial release.
* SCDeviceConfigurationRule
  * Initial release.
* SCInsiderRiskEntityList
  * Initial release.
* SCInsiderRiskPolicy
  * Initial release.
* SCRecordReviewNotificationTemplateConfig
  * Initial release.
* SCRoleGroup
  * Fixes an issue with creation without specifying Displayname
  * Fixes an issue with Drifts because of returned Role format
    FIXES [#5036](https://github.com/microsoft/Microsoft365DSC/issues/5036)
* SCAutoSensitivityLabelRule
  * Fixed issue with incorrectly applying HeaderMatchesPatterns, even when
    parameter wasn't specified.
    FIXES [#4641](https://github.com/microsoft/Microsoft365DSC/issues/4641)
* SCSensitivityLabel
  * Added support for Auto Labeling settings
    FIXES [#3784](https://github.com/microsoft/Microsoft365DSC/issues/3784)
* SentinelSetting
  * Initial release.
* SentinelWatchlist
  * Initial release.
* SPOAccessControlSettings
  * Added support for property EnableRestrictedAccessControl.
* M365DSCUtil
  * Fixes an issue where the O365Group workload was not properly detected.
    FIXES [#5095](https://github.com/microsoft/Microsoft365DSC/issues/5095)
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.10.
  * Updated Microsoft.Graph to version 2.23.0.
  * Added dependencies on Az.Accounts, Az.Resources, Az.ResourceGraph
    and Az.SecurityInsights.
  * Updated DSCParser to version 2.0.0.9.
  * Updated MSCloudLoginAssistant to version 1.1.25.
  * Added dependency on Microsoft.Graph.Beta.Search.
  * Removed unnecessary dependency PSDesiredStateConfiguration v1.1

# 1.24.904.1

* EXOOwaMailboxPolicy
  * Add support for AccountTransferEnabled parameter

# 1.24.904.1

* EXOSweepRule
  * Initial Release.
* FabricAdminTenantSettings
  * Initial Release.
* IntuneDeviceControlPolicyWindows10
  * Initial Release
* M365DSCDRGUtil
  * Fixes an issue where a Intune settings catalog DSC param was not handled
    correctly when it was not specified.
    FIXES [#5000](https://github.com/microsoft/Microsoft365DSC/issues/5000)
  * Fixes an issue where the exported nested CIM instances had too many line breaks.
  * Fixes an issue where Settings Catalog properties were not correctly handled.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.1.20.

# 1.24.828.1

* AADAdministrativeUnit
  * Fix Properties for Dynamic Administrative Units in Graph have moved
* AADConditionalAccessPolicy
  * Fixing issue where the resource crashed when trying to retrieve groups
    and users from Entra ID which no longer existed
  * Fixes an issue where the `AuthenticationFlows` property changed in Graph
    and updates on the documentation for the possible values of `TransferMethods`.
    FIXES [#4961](https://github.com/microsoft/Microsoft365DSC/issues/4961)
    FIXES [#4960](https://github.com/microsoft/Microsoft365DSC/issues/4960)
    FIXES [#4734](https://github.com/microsoft/Microsoft365DSC/issues/4734)
    FIXES [#4725](https://github.com/microsoft/Microsoft365DSC/issues/4725)
* AADGroup
  * FIXES [#4994](https://github.com/microsoft/Microsoft365DSC/issues/4994)
* EXOAuthenticationPolicyAssignment
  * Removes the 1000 user limit when exporting authentication policy assignments
    FIXES [#4956](https://github.com/microsoft/Microsoft365DSC/issues/4956)
* EXOHostedContentFilterRule
  * Don't check if associated `EXOHostedContentFilterPolicy` is present
    while removing resource since it's not required
 * EXORoleGroup
    * Fix an issue where roles that have empty members cannot be compared
   FIXES [#4977] (https://github.com/microsoft/Microsoft365DSC/issues/4977)
* IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy
  * Fixed issue if `PasswordComplexity` was set to 5 by allowing that value
    FIXES [#4963](https://github.com/microsoft/Microsoft365DSC/issues/4963)
* IntuneDeviceCompliancePolicyWindows10
  * Fix extraction of property `TpmRequired`
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Change app and delegated permissions for reading to
    DeviceManagementConfiguration.ReadWrite.All to cope with
    getOmaSettingPlainTextValue which is only working if RW is granted
    FIXES [#4412](https://github.com/microsoft/Microsoft365DSC/issues/4412)
* IntuneDeviceRemediation
  * Add export of global remediation scripts.
* O365OrgSettings
  * FIXES [#4741](https://github.com/microsoft/Microsoft365DSC/issues/4741)
* SCAutoSensitivityLabelPolicy
  * Fixes issue where Mode=Enabled is not supported for SP and OD. Changing
    property to TestWithoutNotifications in those instances.
    FIXES [#4990](https://github.com/microsoft/Microsoft365DSC/issues/4990)
* SCAutoSensitivityLabelRule
  * Fixes issue where the export was looping through all possible workloads
    instead of the actually targeted workload
    FIXES [#4989](https://github.com/microsoft/Microsoft365DSC/issues/4989)
* SCSensitivityLabel
  * Corrected issue where ExternalAccess properties were configured inverted
    FIXES [#3782](https://github.com/microsoft/Microsoft365DSC/issues/3782)
* M365DSCDRGUtil
  * Update Intune Settings Catalog Handling.
  * Fixes an issue where the `MSFT_IntuneDeviceRemediationPolicyAssignments`
    type would trigger an incorrect comparison in `Compare-M365DSCComplexObject`.
* M365DSCResourceGenerator
  * Update Intune resource generation for the Settings Catalog.
* M365DSCUtil
  * Fix `Compare-PSCustomObjectArrays` by allowing empty arrays as input
    FIXES [#4952](https://github.com/microsoft/Microsoft365DSC/issues/4952)
* MISC
  * Improve module updates and PowerShell Core support across the DSC
    resources.
    FIXES [#4941](https://github.com/microsoft/Microsoft365DSC/issues/4941)
  * Replace some `Write-Host` occurrences in core engine with
    appropriate alternatives.
    FIXES [#4943](https://github.com/microsoft/Microsoft365DSC/issues/4943)
  * Fixed a typo within M365DSCReport.psm1 related to a .png file
    FIXES [#4983](https://github.com/microsoft/Microsoft365DSC/pull/4983)
* DEPENDENCIES
  * Updated MicrosoftTeams to version 6.5.0.
  * Updated MSCloudLoginAssistant to version 1.1.19.

# 1.24.731.1

* AADAuthenticationMethodPolicyFido2
  * Add missing class identifier to schema.
    FIXES [#4900](https://github.com/microsoft/Microsoft365DSC/issues/4900)
    FIXES [#4079](https://github.com/microsoft/Microsoft365DSC/issues/4079)
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Fixes an issue where the template reference is not set correctly.
    FIXES [#4925](https://github.com/microsoft/Microsoft365DSC/issues/4925)
* IntuneDeviceConfigurationEndpointProtectionPolicyWindows10
  * Fix compiling if `ProfileTypes` (in `FirewallRules`) is present and contains
    more than one value
    FIXES [#4936](https://github.com/microsoft/Microsoft365DSC/issues/4936)
* IntuneDeviceConfigurationPolicyiOS
  * Fix export of property NetworkUsageRules
    FIXES [#4934](https://github.com/microsoft/Microsoft365DSC/issues/4934)
* MISC
  * M365DSCReport
    * Update key properties for delta report in `AADGroup` resource.
      FIXES [#4921](https://github.com/microsoft/Microsoft365DSC/issues/4921)

# 1.24.724.1

* IntuneAntivirusPolicyWindows10SettingCatalog
  * Migrate to new settings catalog cmdlets.
* IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager
  * Migrate to new settings catalog cmdlets.
    FIXES [#3966](https://github.com/microsoft/Microsoft365DSC/issues/3966)
* IntuneEndpointDetectionAndResponsePolicyLinux
  * Initial release.
* IntuneEndpointDetectionAndResponsePolicyMacOS
  * Initial release.
* IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10
  * Introduces new properties and updates the handling of the
    start and end dates.
    FIXES [#4614](https://github.com/microsoft/Microsoft365DSC/issues/4614)
    FIXES [#3438](https://github.com/microsoft/Microsoft365DSC/issues/3438)
* M365DSCDRGUtil
  * Fixes an issue where only 25 settings catalog templates were fetched with one call.
* SPOSharingSettings
  * Changed approach to MySite filtering.
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.8.

# 1.24.717.1

* AADConditionalAccessPolicy
  * Made failures write to the error output instead of just verbose.
* EXOHostedOutboundSpamFilterPolicy
  * Changed the RecipientLimitInternalPerHour, RecipientLimitPerDay, and
    RecipientLimitExternalPerHour parameters to UInt32.
* EXOMessageClassification
  * Fix issue while creating policy for first time
    FIXES [#4877](https://github.com/microsoft/Microsoft365DSC/issues/4877)
* IntuneDeviceConfigurationEmailProfilePolicyWindows10
  * Fix export by fixing some typos and from where values are extracted
    FIXES [#3960](https://github.com/microsoft/Microsoft365DSC/issues/3960)
* IntuneDiskEncryptionWindows10
  * Initial Release
    FIXES [#4050](https://github.com/microsoft/Microsoft365DSC/issues/4050)
* IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10
  * Initial release.
    FIXES [#2659](https://github.com/microsoft/Microsoft365DSC/issues/2659)
* SPOSharingSettings
  * Improved performance by using -Filter on Get-PnPTenantSite calls.
* M365DSCDRGUtil
  * Fixes an issue with nested and duplicate settings in the settings catalog
  * Add support for converting Intune assignments directly from Graph.
    FIXES [#4875](https://github.com/microsoft/Microsoft365DSC/issues/4875)
* M365DSCResourceGenerator
  * Update Intune resource generation.
* M365DSCReport
  * Changes behaviour to not throw on empty configuration during report generation.
    FIXES [#4559](https://github.com/microsoft/Microsoft365DSC/issues/4559)
    FIXES [#4505](https://github.com/microsoft/Microsoft365DSC/issues/4505)
  * Fixes an issue where the comparison treats empty arrays as an empty string.
    FIXES [#4796](https://github.com/microsoft/Microsoft365DSC/issues/4796)
* Telemetry
  * Added info about operation total execution time.

# 1.24.710.3

* MISC
  * Fixes issue with App Secret Authentication flow.

# 1.24.710.2

* Telemetry
  * Fixed error handling on getting roles.

# 1.24.710.1

* AADApplication
  * Fixes an error where the duplicate error was being trapped,
    which could cause extra instances to be created.
* AADGroup
  * Fixes an error where the duplicate error was being trapped,
    which could cause extra instances to be created.
* EXOAntiPhishRule
  * Don't check if associated `EXOAntiPhishPolicy` is present while removing
    resource since it's not required
    FIXES [#4846](https://github.com/microsoft/Microsoft365DSC/issues/4846)
* EXOHostedOutboundSpamFilterRule
  * Don't check if associated `EXOHostedOutboundSpamFilterPolicy` is present
    while removing resource since it's not required
    FIXES [#4847](https://github.com/microsoft/Microsoft365DSC/issues/4847)
* IntuneDeviceConfigurationPlatformScriptMacOS
  * Fixes an issue where the assignments are missing if filtered by display name.
* M365DSCDRGUtil
  * Fixes an issue where the return value was changed to a single object
    instead of an array.
    FIXES [#4844](https://github.com/microsoft/Microsoft365DSC/issues/4844)
  * Fixes an issue where Graph models were not treated properly as a complex object.
* TELEMETRY
  * Added instance count.
  * Added roles scopes info.
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.7.
  * Updated Microsoft.Graph to version 2.20.0
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.191

# 1.24.703.1

* EXOCASMailboxPlan
  * Remove `DisplayName` from set parameters
    FIXES [#4814](https://github.com/microsoft/Microsoft365DSC/issues/4814)
* EXODkimSigningConfig
  * Add support for 2048 key size;
  * Remove authentication parameters before changing the resources
    FIXES [#4821](https://github.com/microsoft/Microsoft365DSC/issues/4821)
  FIXES [#4805](https://github.com/microsoft/Microsoft365DSC/issues/4805)
* EXOGroupSettings
  * Export unlimited number of groups
    FIXES [#4800](https://github.com/microsoft/Microsoft365DSC/issues/4800)
* EXOHostedContentFilterRule
  * When updating the resource assign property `Identity` to the correct value
    FIXES [#4836](https://github.com/microsoft/Microsoft365DSC/issues/4836)
* EXOMailboxPlan
  * Remove `DisplayName` from set parameters
    FIXES [#4817](https://github.com/microsoft/Microsoft365DSC/issues/4817)
* EXOHostedOutboundSpamFilterRule
  * Fix `if` clause on update scenario, remove property `Enabled` from being set
    while updating the resource and ensure that also while updating the resource
    the property `HostedOutboundSpamFilterPolicy` is only sent if it differs
    from what the resource already has currently assigned
    FIXES [#4838](https://github.com/microsoft/Microsoft365DSC/issues/4838)
* IntuneExploitProtectionPolicyWindows10SettingCatalog
  * Migrate to new settings catalog cmdlets.
* IntuneSettingCatalogASRRulesPolicyWindows10
  * Migrate to new settings catalog cmdlets.
* TeamsFederationConfiguration
  * Add missing property `ExternalAccessWithTrialTenants`
    FIXES [#4829](https://github.com/microsoft/Microsoft365DSC/issues/4829)
* M365DSCDRGUtil
  * Added Microsoft Graph filter functions.
  * Force array as parameter in `Compare-M365DSCIntunePolicyAssignment`.
  * Fixed an issue when comparing Intune policy assignments.
    FIXES [#4830](https://github.com/microsoft/Microsoft365DSC/issues/4830)
  * Fixed an issue when comparing complex objects where the key to compare is available as a
    instance property on the class.
* MISC
  * Added support for `startswith`, `endswith` and `contains` filter methods to Intune resources
    that did not support it previously.
    FIXES [#4597](https://github.com/microsoft/Microsoft365DSC/issues/4597)
  * Fixes issues with values of type `groupSettingCollection` and `choiceSetting`
    when creating the settings catalog policy settings body.
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.6

# 1.24.626.1

* AADGroup
  * FIXES [#4782](https://github.com/microsoft/Microsoft365DSC/issues/4782)
* IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy
  * Migrate to new settings catalog cmdlets.
* M365DSCDRGUtil
  * Fixes an issue with the settings catalog property generation.
  * Add `collectionId` export to `ConvertFrom-IntunePolicyAssignment`
  * Add handling for Intune assignments in `Compare-M365DSCComplexObject`
  * Fix issue with target handling in `Update-DeviceConfigurationPolicyAssignment`
* M365DSCUtil
  * Fixes an issue where the comparison with null-valued desired value throws an error.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.1.18
* M365DSCResourceGenerator
  * Update CimInstance comparison template
* MISC
  * Add group display name export and update assignment comparison across Intune
    resources.

# 1.24.619.1

* SCDLPComplianceRule
  * Fix #4259 and #3845
* TeamsM365App
  * Initial release.
* DEPENDENCIES
  * Updated MicrosoftTeams to version 6.4.0.
* MISC
  * Improved telemetry around Export sizes.

# 1.24.612.1

* IntuneAppConfigurationDevicePolicy
  * Add conversion from `payloadJson` to actual JSON.
* SPOTenantSettings
  * Connect to Graph before Sharepoint Online.
    FIXES [#4746](https://github.com/microsoft/Microsoft365DSC/issues/4746)
* TeamsMeetingPolicy
  * Updated the allowed values for the TeamsCameraFarEndTPTXZmode property.
* M365DSCResourceGenerator
  * Fix formatting and missing escape character in Resource Generator.

# 1.24.605.1

* AADAuthenticationFlowPolicy
  * Initial Release.
* AADEntitlementManagementRoleAssignment
  * Initial Release.
* IntuneAppConfigurationDevicePolicy
  * Add assignment group display name and fix compilation
    FIXES [#4724](https://github.com/microsoft/Microsoft365DSC/issues/4724)
* M365DSCResourceGenerator
  * Add support for generating Intune settings catalog policies.
* M365DSCDRGUtil
  * Add multiple commands for Intune policies that use the settings catalog.
  * Improve comparison of Intune assignments in `Compare-M365DSCIntunePolicyAssignment`
* TeamsMeetingPolicy
  * Updated the allowed values for the TeamsCameraFarEndTPTXZmode property.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.1.17.
  * Updated ReverseDSC to version 2.0.0.20.

# 1.24.529.1

* AADAdministrativeUnit
  * Implemented advanced query based on
    https://learn.microsoft.com/en-us/graph/aad-advanced-queries?tabs=http#administrative-unit-properties
* AADAuthenticationMethodPolicy
  * Add support for disabled policies
* AADConditionalAccessPolicy
  * Fix get method if value is null instead of false
* IntuneAppConfigurationDevicePolicy
  * Initial release
* IntuneDeviceRemediation
  * Added support for Access Tokens
* IntuneDiskEncryptionMacOS
  * Initial Release
* IntuneSettingCatalogASRRulesPolicyWindows10
  * Add missing properties
    FIXES [#4713](https://github.com/microsoft/Microsoft365DSC/issues/4713)
* O365AdminAuditLogConfig
  * Fix logging of exception if Set-AdminAuditLogConfig fails
    FIXES [#4645](https://github.com/microsoft/Microsoft365DSC/issues/4645)
* ResourceGenerator
  * Added `AccessTokens` parameter to PS1 and MOF template
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.5.
  * Rolling back ExchangeOnlineManagement to version 3.4.0.

# 1.24.522.1

* IntuneDeviceConfigurationPlatformScriptWindows
  * Initial Release
    FIXES [#4157](https://github.com/microsoft/Microsoft365DSC/issues/4157)
* IntuneDeviceConfigurationPlatformScriptMacOS
  * Initial Release
    FIXES [#4157](https://github.com/microsoft/Microsoft365DSC/issues/4157)
* IntuneDeviceEnrollmentPlatformRestriction
  * Fix missing export of the default policy
    FIXES [#4694](https://github.com/microsoft/Microsoft365DSC/issues/4694)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Return all authentication methods when retrieving the policies otherwise
    it may fail deducing the OrganizationName via TenantId
* IntuneDeviceRemediation
  * Initial Release
    FIXES [#4159](https://github.com/microsoft/Microsoft365DSC/issues/4159)
* IntuneWindowsUpdateForBusinessDriverUpdateProfileWindows10
  * Initial Release
    FIXES [#3747](https://github.com/microsoft/Microsoft365DSC/issues/3747)
* SPOTenantCdnPolicy
  * If properties in the tenant are empty then export them as empty arrays
    instead of null strings, missed while fixing #4658
* SPOTenantSettings
  * Remove property UserVoiceForFeedbackEnabled when setting the resource since
    it has been deprecated
* M365DSCUtil
  * Fixed an issue in `Assert-M365DSCBlueprint` where the clone and export
    of a blueprint with a GUID could lead to configuration name starting
    with a digit instead of a letter.
    Partially fixes [#4681](https://github.com/microsoft/Microsoft365DSC/issues/4681)
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 3.5.0
  * Updated MicrosoftTeams to version 6.2.0

# 1.24.515.2

* EXOManagementRoleEntry
  * Added support for the WebSite type.

# 1.24.515.1

* AADActivityBasedTimeoutPolicy
  * Initial release, set the azure portal and default Timeout.
* AADGroup
  * Fixes #4596
* AADConditionalAccessPolicy
  * Fix ExcludeGuestOrExternalUserTypes and IncludeGuestOrExternalUserTypes parameters
    FIXES [#4630]
  * Added support for Authentication Flow TransferMethod
    FIXES [#4472]
* AADGroupSettings
  * Added support for parameter NewUnifiedGroupWritebackDefault
* EXOManagementRoleEntry
  * Initial Rrelease
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Add missing properties from templates
  * Update setting handling so that the value is reverted to default when unset
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Fixed an issue where the payload of xml files was not encoded as base64.
* IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10
  * Fixed a creation and update issue when the exported policy contains a
    onboarding blob and the tenant is connected to Defender for Endpoint Service.
* SCAutoSensitivityLabelPolicy
  * Fix incorrect mandatory Credential parameter in Set and Test methods
    FIXES [#4283](https://github.com/microsoft/Microsoft365DSC/issues/4283)
* SPOSharingSettings
  * Remove properties from being tested in certain conditions
    FIXES [#4649](https://github.com/microsoft/Microsoft365DSC/issues/4649)
  * Changed logic to retrieve my site for sovereign clouds.
* SPOTenantCdnPolicy
  * Fixed an issue when both IncludeFileExtensions and
    ExcludeRestrictedSiteClassifications needed to be changed but the latter got
    the value of the former instead of the correct one
    FIXES [#4658](https://github.com/microsoft/Microsoft365DSC/issues/4658)
* TeamsAudioConferencingPolicy
  * Fix export and creation/set of this resource by converting a string array
    into a comma-separated string and a comma-separated string into a string
    array respectively
    FIXES [#4655](https://github.com/microsoft/Microsoft365DSC/issues/4655)
* TeamsMeetingPolicy
  * Fix creation and set of resource when cloud recording is set to false (off)
    FIXES [#4653](https://github.com/microsoft/Microsoft365DSC/issues/4653)
  * Fixed issue with property MeetingChatEnabledType by allowing the value
    EnabledExceptAnonymous to be selected
    FIXES [#4667](https://github.com/microsoft/Microsoft365DSC/issues/4667)
* TeamsGroupPolicyAssignment
  * Add missing policy type TeamsVerticalPackagePolicy
    FIXES [#4647](https://github.com/microsoft/Microsoft365DSC/issues/4647)
* TeamsUpdateManagementPolicy
  * Remove unnecessary parameters from PSBoundParameters such as authentication
    methods, Ensure and Verbose by calling Remove-M365DSCAuthenticationParameter
    FIXES [#4651](https://github.com/microsoft/Microsoft365DSC/issues/4651)
* M365DSCUtil
  * Fixed an issue where one could not pass empty arrays to the
    `Compare-PSCustomObjectArrays` function.
  * Fixed an issue with how the ResourceInstanceName was being assigned for
    resource SPOTenantCdnPolicy by adding its primary key CDNType to the
    heuristics
    FIXES [#4658](https://github.com/microsoft/Microsoft365DSC/issues/4658)
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.4.
  * Updated Microsoft.Graph to version 2.19.0.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.187.
* MISC
  * Added support for Access Tokens across AAD resources.
  * Added support for Access Tokens across SC resources.
  * Added support for Access Tokens across SPO resources.
  * Added support for Access Tokens across Teams resources.
  * Fixing fake passwords in Unit Tests.
  * Added ability to configure Telemetry client by ConnectionString.

# 1.24.424.1

* EXORecipientPermission
  * Ensures we only return 1 Trustee per entry.
* EXOManagementRoleAssignment
  * Removed logic to use Graph for Adminitrative Unit.
* IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10
  * Fixed a comparison issue when Defender for Endpoint is connected to Intune and the
    onboarding blob is generated by the Defender for Endpoint service.
* IntuneDeviceConfigurationPolicyMacOS
  * Fixed an issue where the update policy setting was not handled properly.
* IntuneDeviceConfigurationWiredNetworkPolicyWindows10
  * Added functionality for specifying the certificates with a display name since their
    ids in the blueprint might be from a different source tenant.
    FIXES [#4582](https://github.com/microsoft/Microsoft365DSC/issues/4582)
* MISC
  * Added support for AccessTokens in EXO resources.
  * Updated MSCloudLoginAssistant dependencies to version 1.1.16.
  * Added Filter support to Intune resources.

# 1.24.417.1

* AADAdministrativeUnit
  * Fixed an issue when assigning a directory role which is not yet enabled.
  * Fixed a potential issue if the total directory roles increases in future.
* AADConditionalAccessPolicy
  * Fixed a potential issue if the total directory roles increases in future.
* AADGroup
  * Fixed a potential issue if the total directory roles increases in future.
* AADAdministrativeUnit, AADApplication,
  AADEntitlementManagementConnectedOrganization, AADGroup, AADUser
  * Replace old cmdlet and deprecated Remove-Mg\*ByRef with equivalent
    Remove-Mg\*DirectoryObjectByRef which is available in Graph 2.17.0
* AADRoleEligibilitySecheduleRquest
  * Cleaned Export logic.
* EXOActiveSyncDeviceAccessRule
  * Retrieve instance by Identity if not found by characteristic.
* EXOMailboxSettings
  * Simplifyied the Setlogic and removed Timezone validation to remove checks
    to regstry key which caused issues in Linux.
* M365DSCRuleEvaluation
  * Changed logic to retrieve resource information.
* SCRoleGroup
  * Initial Release.
* SCRoleGroupMember
  * Initial Release.
* SPOTenantSettings
  * Add property TenantDefaultTimezone
    Implements [#4189](https://github.com/microsoft/Microsoft365DSC/issues/4189)
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 2.17.0.
  * Updated MSCloudLoginAssistant dependencies to version 1.1.15.
  * Updated MicrosoftTeams to version 6.1.0.
* MISC
  * Provided the ability to force reload the EXO or SC modules to prevent
    calling the wrong cmdlet where the same names are defined (e.g. Get-RoleGroup).
  * Telemetry
    * Get operating system using faster method to speed up telemetry calls.

# 1.24.403.1

* AADAdministrativeUnit
  * Fix issue with deploying/creating a new AU with members and/or adding members
    to an existing AU
    FIXES [#4404](https://github.com/microsoft/Microsoft365DSC/issues/4404)
  * Updated examples to include setting Visibility and ScopedRoleMembers
  * Fix issue with Set-TargetResource was failing to apply when Verbose is set
    FIXES [#4497](https://github.com/microsoft/Microsoft365DSC/issues/4497)
* All resources
  * Fix issue where Ensure cannot be left as default 'Present'
* AADAdministrativeUnit
  * Fix issue with omitted Ensure and/or Id
    FIXES [#4437](https://github.com/microsoft/Microsoft365DSC/issues/4437)
* AADConditionalAccessPolicy
  * Fixed schema file
* EXOCalendarProcessing
  * Fixed schema file
* EXOGroupSettings
  * Fixed schema file
* EXOMailTips
  * [BREAKING CHANGE] Replaced the Organization parameter with IsSingleInstance
    FIXES [#4117](https://github.com/microsoft/Microsoft365DSC/issues/4117)
* EXOMessageClassification
  * Fixed schema file
* EXOOMEConfiguration
  * Fixed schema file
* EXOTransportRule
  * [BREAKING CHANGE] Change data type of Priority from String to Int
    FIXES [[#4136](https://github.com/microsoft/Microsoft365DSC/issues/4136)]
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Add missing properties
* IntuneAppConfigurationPolicy
  * Fix comparison in Test-TargetResource
    FIXES [#4451](https://github.com/microsoft/Microsoft365DSC/issues/4451)
* IntuneDeviceCompliancePolicyWindows10
  * Fix group assignment by using the corrected function
    Update-DeviceConfigurationPolicyAssignment from module M365DSCDRGUtil
    FIXES [#4467](https://github.com/microsoft/Microsoft365DSC/issues/4467)
* IntuneDeviceEnrollmentPlatformRestriction
  * Fixed an issue where nested settings would throw a conflict
    FIXES [#4082](https://github.com/microsoft/Microsoft365DSC/issues/4082)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Added support for specifying SelectedMobileAppNames in addition to SelectedMobileAppIds,
    which are different for each tenant.
    FIXES [#4494](https://github.com/microsoft/Microsoft365DSC/issues/4494)
* M365DSCRuleEvaluation
  * Log both matching and not matching resources and in XML format
* O365OrgSettings
  * Fixed missing permissions in settings.json
* SCRoleGroupMember
  * Initial release
* SPOAccessControlSettings
  * [BREAKING CHANGE] Removed CommentsOnSitePagesDisabled parameter, because of
    duplication in SPOTenantSettings
    FIXES [#3576](https://github.com/microsoft/Microsoft365DSC/issues/3576)
  * [BREAKING CHANGE] Moved SocialBarOnSitePagesDisabled parameter to SPOTenantSettings,
    because it makes more sense there. This has nothing to do with Access Control.
* SPOTenantSettings
  * [BREAKING CHANGE] Removed ConditionalAccessPolicy parameter, because of
    duplication in SPOAccessControlSettings
    FIXES [#3576](https://github.com/microsoft/Microsoft365DSC/issues/3576)
  * Added SocialBarOnSitePagesDisabled parameter, moved from SPOAccessControlSettings.
  * Added EnableAIPIntegration.
* TeamsChannelTab
  * Fixed schema file
* TeamsComplianceRecordingPolicy
  * FIXES [[#3712](https://github.com/microsoft/Microsoft365DSC/issues/3712)]
* TeamsGroupPolicyAssignment
  * Skip assignments that have orphaned/deleted groups or without display name
    instead of throwing an error
    FIXES [#4407](https://github.com/microsoft/Microsoft365DSC/issues/4407)
* TeamsTenantDialPlan
  * Fix output of property NormalizationRules as a string to the blueprint
    FIXES [#4428](https://github.com/microsoft/Microsoft365DSC/issues/4428)
  * Fix creation, update and deletion of resource
* TeamsUpdateManagementPolicy
  * Adds support for the NewTeamsOnly value or the UseNewTeamsClient property.
    FIXES [#4496](https://github.com/microsoft/Microsoft365DSC/issues/4496)
* DEPENDENCIES
  * Updated DSCParser to version 2.0.0.3.
* MISC
  * Initial release of Get-M365DSCEvaluationRulesForConfiguration
  * M365DSCDRGUtil
    Fix Update-DeviceConfigurationPolicyAssignment so that if the group cannot
    be found by its Id it tries to search it by display name
    FIXES [#4467](https://github.com/microsoft/Microsoft365DSC/issues/4467)
  * M365DSCReport
    Fix issue when asserting resources not covered by current conditions in
    Get-M365DSCResourceKey by always returning all their mandatory parameters
    FIXES [#4502](https://github.com/microsoft/Microsoft365DSC/issues/4502)
  * Fix broken links to integration tests in README.md
  * Changing logic to retrieve DSC Resources properties not to use DSC
    specific cmdlets.

# 1.24.313.1

* AADAuthenticationStrengthPolicy
  * Removed the Id paremeter from being checked in the Test-TargetResource.
* AADGroup
  * Fixed issue when filtering groups by display name
    FIXES [#4394](https://github.com/microsoft/Microsoft365DSC/issues/4394)
  * Fixed issue where group owners were removed from existing groups when unspecified in the config
    FIXES [#4390](https://github.com/microsoft/Microsoft365DSC/issues/4390)
* EXOAcceptedDomain
  * Update regular expression to support domains with digits
    FIXES [#4446](https://github.com/microsoft/Microsoft365DSC/issues/4446)
* EXOHostedContentFilterPolicy
  * Add support for IntraOrgFilterState parameter
  FIXES [#4424](https://github.com/microsoft/Microsoft365DSC/issues/4424)
* EXOHostedContentFilterRule
  * Fixed issue in case of different names of filter rule and filter policy
  FIXES [#4401](https://github.com/microsoft/Microsoft365DSC/issues/4401)
* EXOIntraOrganizationConnector
  * Fixed issue with TargetSharingEpr
    FIXES [#4381](https://github.com/microsoft/Microsoft365DSC/issues/4381)
* IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneAccountProtectionLocalUserGroupMembershipPolicy
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneAccountProtectionPolicy
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneAppConfigurationPolicy
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneApplicationControlPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneASRRulesPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyAndroid
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyAndroidDeviceOwner
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyAndroidWorkProfile
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyiOs
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyMacOS
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceCompliancePolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationDomainJoinPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationEmailProfilePolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
* IntuneDeviceConfigurationEndpointProtectionPolicyWindows10
  * Added support for assignment GroupDisplayName and improve error handling from
    Get-TargetResource
  * Fixed an issue with the parameter InterfaceTypes from firewallrules defined
    as a string instead of string[]
* IntuneDeviceConfigurationSCEPCertificatePolicyWindows10
  * Add property RootCertificateDisplayName in order to support assigning root
    certificates by display name since their Ids in a blueprint might be from a
    different source tenant
    FIXES [#3965](https://github.com/microsoft/Microsoft365DSC/issues/3965)
* IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator
  * Fixed policy assignment retrieval when Id is from other tenant, bogus or
    null
    FIXES [#3970](https://github.com/microsoft/Microsoft365DSC/issues/3970)
* IntuneDeviceConfigurationPolicyAndroidOpenSourceProject
  * Fixed policy assignment retrieval when Id is from other tenant, bogus or
    null
    FIXES [#3971](https://github.com/microsoft/Microsoft365DSC/issues/3971)
  * Fixed compare logic for CIM instances in Test-TargetResource
* M365DSCRuleEvaluation
  * Fix issue when it didn't find any matching resources and it tried to make a
    comparison
* O365OrgSettings
  * Add read permission for extracting M365 apps installation settings instead
    of extracting them only with read/write permissions
    FIXES [#4418](https://github.com/microsoft/Microsoft365DSC/issues/4418)
* TeamsTeam
  * Add error handling for teams without displayname during export
  FIXES [#4406](https://github.com/microsoft/Microsoft365DSC/issues/4406)
* TeamsVoiceRoute
  * Fix policy removal and also comparison in Test-TargetResource
* DEPENDENCIES
  * Updated DSCParser to version 1.4.0.4.
  * Updated Microsoft.Graph to version 2.15.0.
  * Updated MicrosoftTeams to version 6.0.0.
* MISC
  * Enhancement to obfuscate password from verbose logging and avoid empty lines
    FIXES [#4392](https://github.com/microsoft/Microsoft365DSC/issues/4392)
  * Fix example in documentation for Update-M365DSCAzureAdApplication
  * Added support for groupDisplayName to all devices and all users groups

# 1.24.228.1

* AADApplication
  * Show current values of resource in Test-TargetResource
* AADAuthorizationPolicy
  * Show current values of resource in Test-TargetResource
* AADConditionalAccessPolicy
  * Improved verbose logging to show that items are being skipped.
  * Show current values of resource in Test-TargetResource
* AADExternalIdentityPolicy
  * Show current values of resource in Test-TargetResource
* AADGroup
  * Fixed issue with single quotes in the display name.
    FIXES [#4358](https://github.com/microsoft/Microsoft365DSC/issues/4358)
  * Show current values of resource in Test-TargetResource
* AADGroupLifecyclePolicy
  * Show current values of resource in Test-TargetResource
* AADGroupsNamingPolicy
  * Show current values of resource in Test-TargetResource
* AADGroupsSettings
  * Show current values of resource in Test-TargetResource
* AADNamedLocationPolicy
  * Show current values of resource in Test-TargetResource
* AADRoleDefinition
  * Show current values of resource in Test-TargetResource
* AADRoleSetting
  * Show current values of resource in Test-TargetResource
* AADSecurityDefaults
  * Show current values of resource in Test-TargetResource
* AADServicePrincipal
  * Show current values of resource in Test-TargetResource
* AADTenantDetails
  * Show current values of resource in Test-TargetResource
* AADTokenLifetimePolicy
  * Show current values of resource in Test-TargetResource
* EXOActiveSyncDeviceAccessRule
  * Remove extra property GUID that is stopping EXO integration tests from
    running
* IntuneDeviceConfigurationScepCertificatePolicyWindows10
  * Fixes an issue where the keyUsage property format was not correctly handled
* IntuneExploitProtectionPolicyWindows10SettingCatalog
  * Fix update and removal of resource when Identity is from another tenant
    FIXES [#3962](https://github.com/microsoft/Microsoft365DSC/issues/3962)
* SPOAccessControlSettings
  * Added support for the ConditionalAccessPolicy parameter based on the PNP Module
* Teams resources
  * Updated required application permissions to support [Application Based Authentication](https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-application-authentication)
* TeamsCallQueue
  * Reduce the number of Calls for Export using new cache pattern
    FIXES [[#4191](https://github.com/microsoft/Microsoft365DSC/issues/4192)]
* TeamsGuestMeetingConfiguration
  * Added the missing parameter AllowTranscription.
    FIXES [#4363](https://github.com/microsoft/Microsoft365DSC/issues/4363)
* TeamsTeam
  * Corrected Parameters for Graph Commands when creating a new Team
    FIXES [#4383](https://github.com/microsoft/Microsoft365DSC/issues/4383)
* MISC
  * M365DSCDRGUtil
    Add new parameter for customizable assignment identifier
  * M365DSCUtil
    Change heuristics on how to find the mandatory key of the resources to
    include them as part of the ResourceInstanceName during their export
    FIXES [#4333](https://github.com/microsoft/Microsoft365DSC/issues/4333)

# 1.24.221.1

* AADApplication
  * Expose the description field in the resource.
* AADConditionalAccessPolicy
  * Fixing issue where Membership kinds no longer accepted empty values.
    ROLLING BACK [#4344](https://github.com/microsoft/Microsoft365DSC/issues/4344)
    FIXES [#4347](https://github.com/microsoft/Microsoft365DSC/issues/4347)
  * Throws an error if role, user or group was not found in the Set method.
    FIXES [#4342](https://github.com/microsoft/Microsoft365DSC/issues/4342)
* EXOAuthenticationPolicyAssignment
  * Improved performance by using a filter to retrieve assignments.
  * Export now retrieves the user principal name instead of the user id.
* EXOAvailabilityConfig
  * Export now retrieves the user principal name instead of the user id.
* EXOCASMailboxPlan
  * Added the DisplayName property.
* EXODataClassification
  * Added logic to retrieve by name in the GET method if no match found by id.
* EXOMailboxAutoReplyConfiguration
  * Added the owner property.
* EXOMailboxPlan
  * Added the DisplayName property.
* EXOMailboxSettings
  * Export now retrieves instances by User Principal Name instead of GUID.
* EXOPlace
  * Added the DisplayName property.
* EXORecipientPermission
  * Export now retrieves instances by User Principal Name instead of GUID.
* EXOSharedMailbox
  * Added the Identity parameter.
* MISC
  * Uninstall-M365DSCOutdatedDependencies
    * Outdated Microsoft365DSC-modules are now removed in their entirety

# 1.24.214.3

* AADAuthenticationMethodPolicy
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyAuthenticator
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyEmail
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyFido2
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicySms
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicySoftware
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyTemporary
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyVoice
  * Fixed an error where the Export method would loop through the response header.
* AADAuthenticationMethodPolicyX509
  * Fixed an error where the Export method would loop through the response header.
* IntuneAppConfigurationPolicy
  * Fixed an error in the export on the Settings property.
* IntuneDeviceEnrollmentStatusPageWindows10
  * Fixed an error where the Export method would loop through the response header.
* IntuneWindowsAutopilotDeploymentProfileAzureADJoined
  * Fixed an error where the Export method would loop through the response header.
* SCDLPComplianceRule
  * Fixed the NotifyEmailCustomText and NotifyPolicyTipCustomText to escape fancy
    quotes.
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.14.1.

# 1.24.214.2
* AADConditionalAccessPolicy
  * Removed invalid empty string value that was added to the validate set
    of two parameters.
  * Updated permission reference for app-only authentication.
    FIXES [#3329](https://github.com/microsoft/Microsoft365DSC/issues/3329)
* AADRoleEligibilityScheduleRequest
  * Fixed an issue where an error was thrown if no requests were found instead
    of simply returning the Null object.
* AADRoleSetting
  * Fix handling of DisplayName property in comparison
    FIXES [#4019](https://github.com/microsoft/Microsoft365DSC/issues/4019)
* AADUser
  * Fixed and issue where an user would be created even if the resource was set
    to absent.
    FIXES [#4265](https://github.com/microsoft/Microsoft365DSC/issues/4265)
* EXOMobileDeviceMailboxPolicy
  * Fixes an issue where an empty MinPasswordLength value was always passed down
    to the update logic flow.
* IntuneAppConfigurationPolicy
  * Added parameter Id to avoid having to retrieve the same policy multiple
    times
  * Fixed tests in Test-TargetResource to ensure the resource reports its
    correct state
    FIXES [#3542](https://github.com/microsoft/Microsoft365DSC/issues/3542)
* IntuneDeviceAndAppManagementAssignmentFilter
  * Fixed Test-TargetResource to ensure that resource reports its correct state
    FIXES [#3959](https://github.com/microsoft/Microsoft365DSC/issues/3959)
* IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10
  * Fixed Test-TargetResource by removing Id from being tested and also used
    correct filter while retrieving the policy otherwise it could not be found
    FIXES [#3964](https://github.com/microsoft/Microsoft365DSC/issues/3964)
* IntuneDeviceConfigurationPolicyAndroidWorkProfile
  * Fix typo in variable which made it export incorrectly and report that
    resource was not in correct state due to testing an incorrect value
    FIXES [#3972](https://github.com/microsoft/Microsoft365DSC/issues/3972)
* IntuneSettingCatalogASRRulesPolicyWindows10
  * Fix removal of resource if Identity comes from another tenant or is not
    present in blueprint
  * Fix Test-TargetResource by not comparing Identity since it might be from
    another tenant or not present in blueprint
  FIXES [#4302](https://github.com/microsoft/Microsoft365DSC/issues/4302)
* SCDPLPCompianceRule
  * Added support for multiple additional parameters.
* SPOSharingSettings
  * Fixed an issue where the resource would return multiple sites.
    FIXES [#2759](https://github.com/microsoft/Microsoft365DSC/issues/2759)
* DEPENDENCIES
  * Updated DSCParser to version 1.4.0.2.
  * Updated Microsoft.Graph dependencies to version 2.13.1.
  * Updated MSCloudLoginAssistant to version 1.1.13.
* MISC
  * M365DSCReport
    * Fix nested change detection for CIMInstances
    * Fix IntuneDeviceEnrolllmentPlatformRestriction comparison in report
      FIXES [#4291](https://github.com/microsoft/Microsoft365DSC/issues/4291)
  * Added new QA test to check for missing description in resource schema
  * Added new QA test to check for falsely assigned write-premissions in settings.json

# 1.24.207.2

* TeamsAppSetupPolicy
  * Changed the logic to retrieve arrays of Ids in the Get method.
* MISC
  * Drift Logging
    * Now includes the full list of parameters for the current values.
  * Telemetry
    * Added a new M365DSCTelemetryEventId parameter to track duplication of events.

# 1.24.207.1

* IntuneDeviceEnrollmentPlatformRestriction
  * Added Priority parameter
    FIXES [#4081](https://github.com/microsoft/Microsoft365DSC/issues/4081)
* SCDLPComplianceRule
  * Properly escapes fancy quotes in the Get method.
* TeamsMeetingPolicy
  * Ignore the AllowUserToJoinExternalMeeting  parameter for drift evaluation
    since it doesn't do anything based on official documentation.
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.180.
  * Updated MSCloudLoginAssistant to version 1.1.11
  * Updated ReverseDSC to version 2.0.0.19

# 1.24.131.2

* TeamsMeetingPolicy
  * Fixed issue with missing ManagedIdentity parameter in Test signature.
* TeamsUpdateManagementPolicy
  * Fixed issue with missing ManagedIdentity parameter in Set signature.

# 1.24.131.1

* EXOAvailabilityAddressSpace
  * Added support for the TargetServiceEpr and TargetTenantId parameters.
  * Fixed the logic to retrieve existing instance by Forest Name.
* EXODistributionGroup
  * The Get function now retrieves the ModeratedBy and ManagedBy properties
    by the users' UPN instead of their GUID.
* EXOHostedContentFilterRule
  * Changed logic to retrieve the Rules by name. Using the Policy's name instead.
* EXOIntraOrganizationConnector
  * Fixes the DiscoveryEndpoint value from the Get method to include trailing
    forward slash.
* EXOMalwareFilterRule
  * Fixed an issue retrieving the right value for the Enabled property
* EXOOMEConfiguration
  * Fixes an error in the Get method where the ExternalMailExpiryInDays property
    wasn't properly returned.
* EXOSafeLinksPolicy
  * Deprecated the UseTranslatedNotificationText property
* IntuneDeviceConfigurationPolicyAndroidOpenSourceProject,
  IntuneExploitProtectionPolicyWindows10SettingCatalog, IntuneRoleAssignment,
  IntuneRoleDefinition, IntuneSettingCatalogASRRulesPolicyWindows10,
  IntuneWiFiConfigurationPolicyAndroidDeviceAdministrator,
  IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner,
  IntuneWifiConfigurationPolicyAndroidEnterpriseWorkProfile,
  IntuneWifiConfigurationPolicyAndroidForWork,
  IntuneWifiConfigurationPolicyAndroidOpenSourceProject,
  IntuneWifiConfigurationPolicyIOS, IntuneWifiConfigurationPolicyMacOS,
  IntuneWifiConfigurationPolicyWindows10, TeamsCallParkPolicy
  * Fix condition in Test-TargetResource when resource is absent
    FIXES [#3897](https://github.com/microsoft/Microsoft365DSC/issues/3897)
    FIXES [#4256](https://github.com/microsoft/Microsoft365DSC/issues/4256)
* TeamsFilesPolicy
  * Add default value ('Present') to parameter Ensure
* TeamsEmergencyCallRoutingPolicy
  * Fix deletion of resource
    FIXES [#4261](https://github.com/microsoft/Microsoft365DSC/issues/4261)
* TeamsUserCallingSettings
  * Added support for Certificate Authentication
    FIXES [#3180](https://github.com/microsoft/Microsoft365DSC/issues/3180)
* TEAMS
  * Added support for ManagedIdentity Authentication across Teams resources.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant dependencies to version 1.1.10.
* MISC
  * Change the way to Export encoding is done so that it no longer relies
    on the Get-DSCResource function.

# 1.24.124.1

* AADAuthenticationMethodPolicyAuthenticator
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicyEmail
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicyFido2
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicySms
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicySoftware
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicyTemporary
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicyVoice
  * Remove the logic path to create a new instance in favor of the update flow.
* AADAuthenticationMethodPolicyX509
  * Remove the logic path to create a new instance in favor of the update flow.
* AADConditionalAccessPolicy
  * Fix issue when not all parameters are specified
    FIXES [#4202](https://github.com/microsoft/Microsoft365DSC/issues/4202)
* AADCrossTenantAccessPolicy
  * Removed the ability to specify a value of Absent for the Ensure property.
* AADCrossTenantAccessPolicyCOnfigurationDefault
  * Removed the ability to specify a value of Absent for the Ensure property.
* AADGroup
  * Changed Set logic to restore groups from the deleted list if a match by
    DisplayName is found.
* EXOActiveSyncDeviceAccessRule
  * Changed the way Identity is determined by using a combination of the
    QueryString and Characteristic parameters.
* EXOAddressList
  * Fixed an issue trying to create a new instance when DisplayName is empty.
* EXOApplicationAccessPolicy
  * Changed the logic to retrieve existing instances based on Scope.
* EXODataClassification
  * DEPRECATED Resource.
* SCAutoSensitivityLabelRule
  * Correct export indentation, which caused an issue with report conversion to JSON.
    FIXES [#4240](https://github.com/microsoft/Microsoft365DSC/issues/4240)
* SPOSharingSettings
  * Fixed an Issue where the MySiteSharingCapability could be returned as an
    empty string instead of a null value from the Get method.
* TeamsAppPermissionPolicy, TeamsAppSetupPolicy, TeamsCallHoldPolicy,
  TeamsIPPhonePolicy, TeamsMobilityPolicy, TeamsNetworkRoamingPolicy,
  TeamsShiftsPolicy, TeamsTenantNetworkRegion, TeamsTenantNetworkSite,
  TeamsTenantNetworkSubnet, TeamsTenantTrustedIPAddress, TeamsTranslationRule,
  TeamsUnassignedNumberTreatment, TeamsVdiPolicy, TeamsWorkloadPolicy
  * Fix condition when resource is absent
    FIXES [#4227](https://github.com/microsoft/Microsoft365DSC/issues/4227)
* TeamsAudioConferencingPolicy
  * Fix condition in Test-TargetResource when resource is absent
    FIXES [#4215](https://github.com/microsoft/Microsoft365DSC/issues/4215)
* TeamsCallParkPolicy
  * Fix condition in Test-TargetResource when resource is absent
    FIXES [#4210](https://github.com/microsoft/Microsoft365DSC/issues/4210)
* TeamsCallQueue
  * Optimize performances by doing 1 request instead of n+1
  FIXES [[#4192](https://github.com/microsoft/Microsoft365DSC/issues/4192)]
* TeamsComplianceRecordingPolicy
  * Fix condition in Test-TargetResource when resource is absent
    FIXES [#4212](https://github.com/microsoft/Microsoft365DSC/issues/4212)
* TeamsCortanaPolicy
  * Fix condition in Test-TargetResource when resource is absent
    FIXES [#4208](https://github.com/microsoft/Microsoft365DSC/issues/4208)
* TeamsEnhancedEncryptionPolicy
  * Fix condition when resource is absent
    FIXES [#4221](https://github.com/microsoft/Microsoft365DSC/issues/4221)
* TeamsEventsPolicy
  * Add missing attributes
    FIXES [#4242](https://github.com/microsoft/Microsoft365DSC/issues/4242)
* TeamsFeedbackPolicy
  * Fix condition when resource is absent
    FIXES [#4223](https://github.com/microsoft/Microsoft365DSC/issues/4223)
* TeamsFilesPolicy
  * Fix condition when resource is absent
    FIXES [#4225](https://github.com/microsoft/Microsoft365DSC/issues/4225)
* TeamsGroupPolicyAssignment
  * Ensure assignment can still be created if GroupId is not found by trying to
    search by DisplayName afterwards
    FIXES [#4248](https://github.com/microsoft/Microsoft365DSC/issues/4248)
* TeamsMeetingBroadcastPolicy
  * Fix deletion of resource
    FIXES [#4231](https://github.com/microsoft/Microsoft365DSC/issues/4231)
* TeamsMobilityPolicy
  * Validate string set on parameter MobileDialerPreference
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 2.12.0.
  * Updated MicrosoftTeams dependencies to version 5.9.0.

# 1.24.117.1

* AADAdministrativeUnit
  * Used generic Graph API URL from MSCloudLoginConnectionProfile.
* AADApplication
  * Ignore Permissions in tests if not passed. Preventing null comparison errors.
* AADAttributeSet
  * Removed the ability to specify a value of Absent for the Ensure property.
* AADConditionalAccessPolicy
  * Fixes an error where the ApplicationEnforcedRestrictionsIsEnabled parameter
    was always set to false in scenarios where it should have been null.
* AADAuthenticationMethodPolicy
  * Removed the ability to specify a value of Absent for the Ensure property.
* AADAuthenticationMethodPolicyX509
  * Fix the way we returned an empty rule set from the Get method. This caused
    the Test-TargetResource method to return true even when instances matched.
* AADRoleSetting
  * Removed the ability to specify a value of Absent for the Ensure property.
* EXOAntiPhishPolicy
  * Add support for HonorDmarcPolicy parameter
    FIXES [#4138](https://github.com/microsoft/Microsoft365DSC/issues/4138)
* IntuneDeviceConfigurationPolicyMacOS
  * Fix CIM instances comparison in Test-TargetResource and export
    CompliantAppsList with the correct type
    FIXES [#4144](https://github.com/microsoft/Microsoft365DSC/issues/4144)
* TeamsEmergencyCallRoutingPolicy
  * Fix deletion of resource
    FIXES [#4219](https://github.com/microsoft/Microsoft365DSC/issues/4219)
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.178.
  * Updated MSCloudLoginAssistant to version 1.1.7.

# 1.24.110.1

* AADAdministrativeUnit
  * Fix the Update logic flow to get around a bug in Microsoft.Graph 2.11.1.
* AADAuthenticationMethodPolicyX509
  * Added support for the  property for include targets
* AADConditionalAccessPolicy
  * Added support for application filters in the conditions.
  * Implement Fix #3885. Manage Exclude Application.
    FIXES [#3885](https://github.com/microsoft/Microsoft365DSC/issues/3885)
* EXOHostedContentFilterPolicy
  * Fix issue on parameters AllowedSenders, AllowedSenderDomains, BlockedSenders,
    BlockSenderDomains if desired state is empty but current state is not empty.
    FIXES [#4124](https://github.com/microsoft/Microsoft365DSC/issues/4124)
* EXOMailContact
  * Added support for Custom Attributes and Extension Custom Attributes.
* IntuneDeviceConfigurationPolicyMacOS
  * Fix workaround added on PR #4099 in order to be able to use this resource
    for deployments
    FIXES [#4105](https://github.com/microsoft/Microsoft365DSC/issues/4105)
* SCDLPComplianceRule
  * Fix type of AccessScope
    FIXES [#3463](https://github.com/microsoft/Microsoft365DSC/issues/3463)
* TeamsTenantDialPlan
  * FIXES [#3767](https://github.com/microsoft/Microsoft365DSC/issues/3767)

# 1.24.103.1

* AADConditionalAccessPolicy
  * Fix Get-TargetResource when the parameter Id is not present
    FIXES [#4029](https://github.com/microsoft/Microsoft365DSC/issues/4003)
* EXOInboundConnector
  * Corrected parameter descriptions, so the documentation on microsoft365dsc.com is generated correctly.
* EXOMailTips
  * Added parameter descriptions for better documentation
* EXOOutboundConnector
  * Corrected parameter descriptions, so the documentation on microsoft365dsc.com is generated correctly.
* EXOReportSubmissionPolicy
  * Initial release
    FIXES [#3690](https://github.com/microsoft/Microsoft365DSC/issues/3690)
* EXOReportSubmissionRule
  * Initial release
    FIXES [#3690](https://github.com/microsoft/Microsoft365DSC/issues/3690)
* EXOTransportRule
  * Stop supporting DLP-related rules, conditions, and actions (https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-mail-flow-rules-to-stop-supporting-dlp-related/ba-p/3959870)
    FIXES [#3929](https://github.com/microsoft/Microsoft365DSC/issues/3929)
* IntuneDeviceConfigurationPolicyMacOS
  * Added parameter descriptions for better documentation
* IntuneSettingCatalogCustomPolicyWindows10
  * Fix Get-TargetResource when the parameter Id is not present
    FIXES [#4029](https://github.com/microsoft/Microsoft365DSC/issues/4003)
* SPOTenantSettings
  * Added parameter descriptions for better documentation
* TeamsChannel
  * Add error handling if GroupId of a team is null
    FIXES [#3943](https://github.com/microsoft/Microsoft365DSC/issues/3943)
* TeamsFeedbackPolicy
  * Added parameter descriptions for better documentation
* TeamsMobilityPolicy
  * Added parameter descriptions for better documentation
* TeamsNetworkRoamingPolicy
  * Added parameter descriptions for better documentation

# 1.23.1227.1

* EXOAntiPhishPolicy
  * Add support for TargetedDomainProtectionAction
    FIXES [#3910](https://github.com/microsoft/Microsoft365DSC/issues/3910)
* EXOMailboxCalendarFolder
  * Add support for non-English calendar folder names during export
    FIXES [#4056](https://github.com/microsoft/Microsoft365DSC/issues/4056)
* EXOMailboxPermission
  * Ignore SendAs permissions during export
    FIXES [#3942](https://github.com/microsoft/Microsoft365DSC/issues/3942)
* EXOTransportRule
  * Fix export of enabled state
    FIXES [#3932](https://github.com/microsoft/Microsoft365DSC/issues/3932)
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Fix issue deploying decrypted OmaSettings to another tenant
    FIXES [#4083](https://github.com/microsoft/Microsoft365DSC/issues/4083)
* IntuneDeviceConfigurationPolicyMacOS
  * Fix resource deployment
    FIXES [#3539](https://github.com/microsoft/Microsoft365DSC/issues/3539)
  * Ensure resource can cope with Id being empty since it's not mandatory
* O365OrgSettings
  * Deprecated the MicrosoftVivaBriefingEmail property
    FIXES [#4097](https://github.com/microsoft/Microsoft365DSC/issues/4097)
    FIXES [#4080](https://github.com/microsoft/Microsoft365DSC/issues/4080)
* SPOTenantSettings
  * Fix bug for DisabledWebPartIds type, should be an array instead of a string
    FIXES [#4086](https://github.com/microsoft/Microsoft365DSC/issues/4086)
* TeamsMeetingPolicy
  * Allow -1 for NewMeetingRecordingExpirationDays parameter (never expire)
    FIXES [#4090](https://github.com/microsoft/Microsoft365DSC/issues/4090)
* TeamsMessagingPolicy
  * Added support for property 'AllowVideoMessages'
    FIXES [#4021](https://github.com/microsoft/Microsoft365DSC/issues/4021)

# 1.23.1220.1

* AADEntitlementManagementAccessPackage
  * Retrieve catalog by name instead of id.
* IntuneDeviceAndAppManagementAssignmentFilter
  * Add support for remaining platforms supported by this policy
    FIXES [#4065](https://github.com/microsoft/Microsoft365DSC/issues/4065)
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Add support to decrypt encrypted OmaSettings and export them in plaintext
    FIXES [#3655](https://github.com/microsoft/Microsoft365DSC/issues/3655)
* IntuneDeviceEnrollmentPlatformRestriction
  * Fix Set-TargetResource due to an issue were the bodyparameter not cast correctly
    FIXES [#3730](https://github.com/microsoft/Microsoft365DSC/issues/3730)
* IntuneEndpointDetectionAndResponsePolicyWindows10
  * Fix issue when trying to remove policy and Identity is set to a random GUID
    or from another tenant
    FIXES [#4041](https://github.com/microsoft/Microsoft365DSC/issues/4041)
* IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled
  * Added Assignments
    FIXES [#2932](https://github.com/microsoft/Microsoft365DSC/issues/2932)
* SCAutoSensitivieyLabelPolicy
    FIXES [#4036] Don't see any limits on our docs for priority
* M365DSCDRGUtil
  * Fix empty BaseUrl since MSCloudLoginAssistant removed Intune workload
    FIXES [#4057](https://github.com/microsoft/Microsoft365DSC/issues/4057)
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.1.4.

# 1.23.1213.1

* IntuneEndpointDetectionAndResponsePolicyWindows10
  * Fix issue with assignments
    FIXES [#3904](https://github.com/microsoft/Microsoft365DSC/issues/3904)
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Fix issue with Set-TargetResource when retrieving a policy from displayName
    FIXES [#4003](https://github.com/microsoft/Microsoft365DSC/issues/4003)
* IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10
  * Fix parameter name in assignment cmdlet
    FIXES [#4007](https://github.com/microsoft/Microsoft365DSC/issues/4007)
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.11.1.
  * Updated MSCloudLoginAssistant to version 1.1.3.

# 1.23.1206.1

* IntuneAntivirusPolicyWindows10SettingCatalog
  * Fix condition in Test-TargetResource to check if resource was removed or not
    FIXES [#3958](https://github.com/microsoft/Microsoft365DSC/issues/3958)
* IntuneSettingCatalogASRRulesPolicyWindows10
  * Fixed Schema Validation
  * Fixed Import with unknown ID of Policy and Assignments by using DisplayName
  FIXES [#3961](https://github.com/microsoft/Microsoft365DSC/issues/3961)
* IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10
  * Fix typo in assignment cmdlet
    FIXES [#3996](https://github.com/microsoft/Microsoft365DSC/issues/3996)
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.1.2.
* MISC
  * Fix Compare-M365DSCConfigurations to exclude resources correctly
    FIXES [#4000](https://github.com/microsoft/Microsoft365DSC/issues/4000)

# 1.23.1129.1

* AADRoleSetting
  * Export sorted by DisplayName for better comparison
  * Enable Filter property to be used on export
    FIXES [#3919](https://github.com/microsoft/Microsoft365DSC/issues/3919)
* AADUser
  * Added the MemberOf Property.
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Skipped settingValueTemplateReference and settingInstanceTemplateReference
    for severethreats, highseveritythreats, moderateseveritythreats,
    lowseveritythreats as per API requirements observed in the Intune portal.
    FIXES [#3818](https://github.com/microsoft/Microsoft365DSC/issues/3818)
    FIXES [#3955](https://github.com/microsoft/Microsoft365DSC/issues/3955)
* IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy,
  IntuneAccountProtectionLocalUserGroupMembershipPolicy,
  IntuneAccountProtectionPolicy,
  * Fixes export if Assignments is set on existing policies
    FIXES [3913](https://github.com/microsoft/Microsoft365DSC/issues/3913)
  * Add groupDisplayName to Assignments embedded instance
* IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10,
  IntuneDeviceConfigurationHealthMonitoringConfigurationPolicyWindows10,
  IntuneDeviceConfigurationIdentityProtectionPolicyWindows10,
  IntuneDeviceConfigurationEndpointProtectionPolicyWindows10,
  IntuneDeviceEnrollmentStatusPageWindows10,
  IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined,
  IntuneWindowsAutopilotDeploymentProfileAzureADJoined
  * Removed Id and all authentication parameters from PSBoundParameters in Test-TargetResource
    FIXES [#3888](https://github.com/microsoft/Microsoft365DSC/issues/3888)
* IntuneWindowsAutopilotDeploymentProfileAzureADJoined
  * Modified assigned to use sdk instead of API call and added logic to use groupDisplayName in assignment
    FIXES [#3921](https://github.com/microsoft/Microsoft365DSC/issues/3921)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Fixed assignments using API call
    FIXES [#3921](https://github.com/microsoft/Microsoft365DSC/issues/3921)
* IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined
  * Modified assigned to use sdk instead of API call and added logic to use groupDisplayName in assignment
    FIXES [#3892](https://github.com/microsoft/Microsoft365DSC/issues/3892)
* IntuneWindowsAutopilotDeploymentProfileAzureADJoined
  * Modified assigned to use sdk instead of API call and added logic to use groupDisplayName in assignment
    FIXES [#3892](https://github.com/microsoft/Microsoft365DSC/issues/3892)
* IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10
  * Modified assigned to use sdk instead of API call and added logic to use groupDisplayName in assignment
* IntuneDeviceConfigurationPolicyWindows10
    FIXES [#3921](https://github.com/microsoft/Microsoft365DSC/issues/3921)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Fixed assignments using API call
    FIXES [#3921](https://github.com/microsoft/Microsoft365DSC/issues/3921)
* TeamsMessagingPolicy
  * Added support for properties AllowCommunicationComplianceEndUserReporting,
    AllowFluidCollaborate and AllowSecurityEndUserReporting.
    FIXES [#3968](https://github.com/microsoft/Microsoft365DSC/issues/3968)
* TeamsTeam
  * Fixes incompatible type for ComplianceRecordingApplications, expected string[] but receive object[]
    FIXES: [#3890](https://github.com/microsoft/Microsoft365DSC/issues/3890)
* DEPENDENCIES
  * Updated DSCParser to version 1.4.0.1.
  * Updated Microsoft.Graph to version 2.10.0.
  * Updated MSCloudLoginAssistant to version 1.1.0.
* MISC
  * M365DSCDRGUtil
    * Added ConvertFrom-IntunePolicyAssignment and ConvertTo-IntunePolicyAssignment
      FIXES [#3892](https://github.com/microsoft/Microsoft365DSC/issues/3892)
  * Support for Multi-Tenancy (Credentials + TenantId).

# 1.23.1122.1

* SPOSharingSettings
  * Fixes typo to re-enable export of ExternalUserExpireInDays and
    ExternalUserExpirationRequired.
* DEPENDENCIES
  * Updated DSCParser to version 1.4.0.0.
  * Updated Microsoft.Graph to version 2.9.1.
  * Updated MicrosoftTeams to version 5.8.0.

# 1.23.1115.1

* AADApplication
  * Added support for the IsFallbackPublicClient property.
    FIXES [#3906](https://github.com/microsoft/Microsoft365DSC/issues/3906)
* AADServicePrincipal
  * Added support to define members.
    FIXES [#3902](https://github.com/microsoft/Microsoft365DSC/issues/3902)
* EXOCASMailboxPlan
  * Fixes an issue where we are not able to set the settings of a CAS
    Mailbox Plan by specifying the Identity without the GUID in the name.
    FIXES [#3900](https://github.com/microsoft/Microsoft365DSC/issues/3900)

# 1.23.1108.3

* AADRoleEligibilityScheduleRequest
  * Fixed incorrect subclass MSFT_AADRoleEligibilityScheduleRequestScheduleRecurrenceRange
    for range property
    FIXES [#3847](https://github.com/microsoft/Microsoft365DSC/issues/3847)
  * Fixes issue where creating an entry that was previously removed threw an error
    complaining that the role eligibility already existed.
* IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy
  * Initial release
    FIXES [#3034](https://github.com/microsoft/Microsoft365DSC/issues/3034) 3/3
* IntuneAccountProtectionLocalUserGroupMembershipPolicy
  * Initial release
    FIXES [#3034](https://github.com/microsoft/Microsoft365DSC/issues/3034) 2/3
* IntuneAccountProtectionPolicy
  * Initial release
    FIXES [#3034](https://github.com/microsoft/Microsoft365DSC/issues/3034) 1/3
* IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10
  * Fixes typo in Get-TargetResource
    FIXES [#3869](https://github.com/microsoft/Microsoft365DSC/issues/3869)
* IntuneDeviceConfigurationEndpointProtectionPolicyWindows10
  * Fix an issue where the firewall settings were not populate correctly
  FIXES [#3851](https://github.com/microsoft/Microsoft365DSC/issues/3851)
* IntuneDeviceEnrollmentStatusPageWindows10
  * Fix typo in the catch of Update-DeviceEnrollmentConfigurationPriority
    FIXES [#3442](https://github.com/microsoft/Microsoft365DSC/issues/3442)
* M365DSCDRGUTIL
  * Fix an issue where temporary parameters were not renamed during recursive call causing a Model Validation
    error during creation or update of a Graph resource
    FIXES [#3582](https://github.com/microsoft/Microsoft365DSC/issues/3582)
* MISC
  * Added a QA check to test if all used subclasses actually exist in the MOF schema.
* DEPENDENCIES
  * Updated Microsoft. Graph dependencies to version 2.9.0.

# 1.23.1108.1

* AADExternalIdentityPolicy
  * Initial release.
* O365OrgSettings
  * Force register the Office on the Web ServicePrincipal is it is not present.
    FIXES [#3842](https://github.com/microsoft/Microsoft365DSC/issues/3842)
* TeamsTeam
  * Fixes incomplete import due to error "Cannot index into a null array"
    FIXES: [#3759](https://github.com/microsoft/Microsoft365DSC/issues/3759)

# 1.23.1101.1

* AADRoleEligibilityScheduleRequest
  * Fixes how the Get method retrieves existing instances for Groups.
    FIXES [#3787](https://github.com/microsoft/Microsoft365DSC/issues/3787)
* SCSecurityFilter
  * Fixes an issue because Region could be empty
  FIXES: [#3854](https://github.com/microsoft/Microsoft365DSC/issues/3854)
* SPOSharingSettings
  * Fixes parameter validation of ExternalUserExpireInDays and ExternalUserExpirationRequired.
    FIXES [#3856](https://github.com/microsoft/Microsoft365DSC/issues/3856)
* TeamsComplianceRecordingPolicy
  * Fix an issue where the Compliance Application ID wasn't properly retrieved.
  FIXES [#3848](https://github.com/microsoft/Microsoft365DSC/issues/3848)

# 1.23.1025.1

* AADEntitlementManagementAccessPackageAssignmentPolicy
  * Fixes an issue where reviewers were not properly exported
* M365DSCDRGUTIL
  * Fixes an issue with Get-M365DSCDRGComplexTypeToHashtable where Beta cmdlet were not recognized for recursive calls
  FIXES [#3448](https://github.com/microsoft/Microsoft365DSC/issues/3448)
* AADApplication
  * Changes to how permissions drifts are logged.
    FIXES [#3830](https://github.com/microsoft/Microsoft365DSC/issues/3830)
* AADAttributeSet
  * Initial Release.
* AADAuthenticationContext
  * Initial Release.
* AADConditionalAccessPolicy
  * Adds support for Authentication Context.
    FIXES [#3813](https://github.com/microsoft/Microsoft365DSC/issues/3813)
* AADSocialIdentityProvider
  * Initial release.
* TeamsComplianceRecordingPolicy
  * Fixes an issue where the Compliance Application ID wasn't properly retrieved.
    FIXES [#3712](https://github.com/microsoft/Microsoft365DSC/issues/3712)
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 2.8.0.
  * Updated MicrosoftTeams dependency to version 5.7.1.

# 1.23.1018.1

* AADAuthenticationMethodPolicyAuthenticator
  * Fixes an issue with the Get method when an assigned group
    was deleted.
* AADConditionalAccessPolicy
  * Added support for the SigninFrequencyInterval parameter.
* EXODistributionGroup
  * Changes the export logic to use PrimarySMTPAddress if provided.
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Added "-All" parameter to retrieve all settings from a template.
  FIXES [#3722](https://github.com/microsoft/Microsoft365DSC/issues/3722)
* IntuneDeviceCleanupRule
  * Initial release.
    FIXES [#3599](https://github.com/microsoft/Microsoft365DSC/issues/3599)
* TeamsGroupPolicyAssignment
  * Fixes the export of CsGroup, when the display name of a group is included in
    another display name.
  FIXES [#3736](https://github.com/microsoft/Microsoft365DSC/issues/3736)
* TeamsUserPolicyAssignment
  * Initial release.
  FIXES [#3777](https://github.com/microsoft/Microsoft365DSC/issues/3777)
* MISC
  * Fixes fancy quotes in complex objects for extraction.
* SCSecurityFilter
  * Initial release
  FIXES: [#3796](https://github.com/microsoft/Microsoft365DSC/issues/3796)

# 1.23.1011.1

* AADRoleEligibilityScheduleRequest
  * Added support for groups assignment.
    FIXES [#3744](https://github.com/microsoft/Microsoft365DSC/issues/3744)
* EXOCalendarProcessing
  * Added support for retrieved groups as calendar delegates.
* EXODistributionGroup
  * Fixes the export of group membership to use Identity.
* IntuneDeviceConfigurationPolicyWindows10
  * Support setting assignment groups by display name
* TeamsUpdateManagementPolicy
  * Add support for the new acceptable value for UseNewTeamsClient
    (NewTeamsAsDefault).
* MISC
  * M365DSCReport: Also define property dataType, if present, as being primary
     key on CIM instances.
* TeamsUpgradeConfiguration
  * Fixes an issue where the SfBMeetingJoinUx property wasn't properly updated.
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 3.4.0.
  * Updated Microsoft.Graph dependencies to version 2.7.0.

# 1.23.1004.1

* AADEntitlementManagementAccessPackageAssignmentPolicy
  * [BREAKING CHANGE] Fixes customExtension property where the schema and assignement
    were not managed correctly.
    FIXES [#3639](https://github.com/microsoft/Microsoft365DSC/issues/3639)
* AADEntitlementManagementConnectedOrganization
  * FIXES [[#3738](https://github.com/microsoft/Microsoft365DSC/issues/3738)]
* EXOCalendarProcessing
  * Initial release.
* EXODistributionGroup
  * [BREAKING CHANGE] Identity is now a primary key.
    FIXES [#3741](https://github.com/microsoft/Microsoft365DSC/issues/3741)
  * Added support for multiple new properties to align with supporting cmdlet.
* EXOMailboxAutoReplyConfiguration
  * Initial release.
* EXOMailboxCalendarFolder
  * Initial release.
* EXOMailboxPermission
  * Initial release.
* EXOPlace
  * Initial release.
* IntunePolicySets
  * New Configuration for Intune Policy Sets
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.121.
* MISC
  * TestHarness.psm1
    * Added code around DscTestsPath parameter to target a single test file
      during development

# 1.23.927.1

* AADApplication
  * Added support for restoring soft deleted instances.
* AADRoleSetting
  * Fixed issue with export where ApplicationSecret was not returned.
    FIXES [#3695](https://github.com/microsoft/Microsoft365DSC/issues/3695)
* M365DSCRuleEvaluation
  * Improvements to how rules are evaluated and how drifts are logged.
* O365OrgSettings
  * Changes to how ToDo discrepencies are being fixed in the SET method.
* M365DSCDRGUtil
  * Added support for Intune URIs to be dynamic based on target
    cloud instance (Commercial, GCC-H..etc)
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.6.1.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.117.
* MISC
  * Fixed handling of Graph connection in Update-M365DSCAllowedGraphScopes

# 1.23.920.2

* DEPENDENCIES
  * Rolled back Microsoft.Graph to version 2.5.0.
* MISC
  * M365DSCDRGUtil: Write properties properly indented and in new line
    FIXES [#3634](https://github.com/microsoft/Microsoft365DSC/issues/3634)

# 1.23.920.1

* O365OrgSettings
  * Fixes and issue where a the wrong url was being used in some of the API
    calls, resulting in null returns for some properties in the Get method.
* SPOSharingSettings
  * Changes verbose prompts to warnings.
* TeamsGroupPolicyAssignment
  * Changes to how Group IDs are retrieved and evaluated.
* TeamsAppPermissionPolicy
  * Fixes to the Test-TargetResource evaluation of empty arrays.
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.6.0.
  * Updated MicrosoftTeams to version 5.6.0.
    FIXES [#3671](https://github.com/microsoft/Microsoft365DSC/issues/3671)
* MISC
  * M365DSCUtil: Fix problem naming similar resources
    FIXES [#3700](https://github.com/microsoft/Microsoft365DSC/issues/3700)

# 1.23.913.2

* MISC
  * Fixed a merge conflict in the Uninstall-M365DSCOutdatedDependencies
    function.
    FIXES [#3685](https://github.com/microsoft/Microsoft365DSC/issues/3685)

# 1.23.913.1

* AADNamedLocationPolicy
  * Set default value for CountryLookupMethod and removed unwanted properties
    FIXES [#3656](https://github.com/microsoft/Microsoft365DSC/issues/3656)
  * Added support for compliantNetworkNamedLocation.
    FIXES [#3422](https://github.com/microsoft/Microsoft365DSC/issues/3422)
* IntuneAppProtectionPolicyAndroid
  * Added support for 'RequireClass3Biometrics' parameter
  * Added support for 'RequirePinAfterBiometricChange' parameter
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Added support for 'engineupdateschannel' parameter
  * Added support for 'platformupdateschannel' parameter
  * Added support for 'securityintelligenceupdateschannel' parameter
* M365DSCRuleEvaluation
  * Initial Release.
* O365OrgSettings
  * Fixes an issue where the wrong Graph URLs were being called for sovereign
    clouds.
    FIXES [#3673](https://github.com/microsoft/Microsoft365DSC/issues/3673)
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 3.3.0.
  * Updated Microsoft.Graph modules to version 2.5.0.
  * Added dependency on Microsoft.Graph.Beta.Reports.
* MISC
  * Improved error logging for methods installing or updating modules.
    FIXES [#3660](https://github.com/microsoft/Microsoft365DSC/issues/3660)
  * Removed Id as a mandatory parameter for most AAD resources.
    FIXES [#3344](https://github.com/microsoft/Microsoft365DSC/issues/3344)
  * Single quotes handling in Export for complex CIMInstances
    FIXES [#3479](https://github.com/microsoft/Microsoft365DSC/issues/3479)

# 1.23.906.1

* AADAuthenticationMethodPolicyAuthenticator
  * Fixes issues with the export missing a line return.
    FIXES [#3645](https://github.com/microsoft/Microsoft365DSC/issues/3645)
* AADAuthorizationPolicy
  * Fix issues with the Set method, which did not check an array properly.
* AADGroup
  * Fixed Get-TargetResource not to use the parameters that should be set,
    preventing an empty delta on Set-TargetResource
    FIXES [#3629](https://github.com/microsoft/Microsoft365DSC/issues/3629)
* AADRoleEligibilityScheduleRequest
  * Initial Release.
* EXOIRMConfiguration
  * Corrected type in schema for parameter TransportDecryptionSetting
* EXORemoteDomain
  * Implemented a wait/retry mecanism between the New-RemoteDomain and
    Set-RemoteDomain to avoid timeout.
    FIXES [#3628](https://github.com/microsoft/Microsoft365DSC/issues/3628)
* IntuneSettingCatalogASRRulesPolicyWindows10
  * Added support for ASR rule BlockWebShellCreationForServers.
* DEPENDENCIES
  * Updated Install-M365DSCDevBranch, Update-M365DSCDependencies and
    Update-M365DSCModule to be usable with -Scope, allowing
    the user to install/update the module dependencies without admin rights,
    using current user scope. Confirm-M365DSCDependencies
    error message changed to reflect this change.
    FIXES [#3621](https://github.com/microsoft/Microsoft365DSC/issues/3621)
  * Updated MSCloudLoginAssitant to version 1.0.120
* MISC
  * Fix in Update-M365DSCAzureAdApplication to prevent issue with uploading certificate.
    EndDate parameter was incorrect and not necessary.
  * Fixed issue in documentation generation
    FIXES [#3635](https://github.com/microsoft/Microsoft365DSC/issues/3635)
  * M365DscReport: Fix typo in var name in Compare-M365DSCConfigurations cmdlet
    FIXES [#3632](https://github.com/microsoft/Microsoft365DSC/issues/3632)

# 1.23.830.1

* O365SearchAndintelligenceConfigurations
  * Removed support for Service Principal Auth, which the cmdlet never supported.
* SPOHomeSite
  * Fixes an issue if no home site exists
    FIXES [#3577](https://github.com/microsoft/Microsoft365DSC/issues/3577)
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.4.0.
  * Updated ReverseDSC to version 2.0.0.18
* MISC
  * Fixes an issue with the generic export CIM Instance logic.
    FIXES [#3610](https://github.com/microsoft/Microsoft365DSC/issues/3610)

# 1.23.823.1

* AADAuthorizationPolicy
  * Fix issue with property PermissionGrantPolicyIdsAssignedToDefaultUserRole
    FIXES [#3594](https://github.com/microsoft/Microsoft365DSC/issues/3594)
* AADGroupsSettings
  * Add support for enabling sensitivity labels in M365-groups
* EXOSafeAttachmentPolicy
  * Deprecated ActionOnError Parameter
    FIXES [#3579](https://github.com/microsoft/Microsoft365DSC/issues/3579)
* IntuneEndpointDetectionAndResponsePolicyWindows10
  * Initial release
    FIXES [#3349](https://github.com/microsoft/Microsoft365DSC/issues/3349)
* O365OrgSettings
  * Updated logic of the Get to return null if permissions are not granted for
    a given API.
  * Updated the list of required permissions.
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 2.3.0
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.174.

# 1.23.830.1

* O365SearchAndintelligenceConfigurations
  * Removed support for Service Principal Auth, which the cmdlet never supported.
* SPOHomeSite
  * Fixes an issue if no home site exists
    FIXES [#3577](https://github.com/microsoft/Microsoft365DSC/issues/3577)
* DEPENDENCIES
  * Updated Microsoft.Graph to version 2.4.0.
  * Updated ReverseDSC to version 2.0.0.18
* MISC
  * Fixes an issue with the generic export CIM Instance logic.
    FIXES [#3610](https://github.com/microsoft/Microsoft365DSC/issues/3610)

# 1.23.823.1

* AADAuthorizationPolicy
  * Fix issue with property PermissionGrantPolicyIdsAssignedToDefaultUserRole
    FIXES [#3594](https://github.com/microsoft/Microsoft365DSC/issues/3594)
* AADGroupsSettings
  * Add support for enabling sensitivity labels in M365-groups
* EXOSafeAttachmentPolicy
  * Deprecated ActionOnError Parameter
    FIXES [#3579](https://github.com/microsoft/Microsoft365DSC/issues/3579)
* IntuneEndpointDetectionAndResponsePolicyWindows10
  * Initial release
    FIXES [#3349](https://github.com/microsoft/Microsoft365DSC/issues/3349)
* O365OrgSettings
  * Updated logic of the Get to return null if permissions are not granted for
    a given API.
  * Updated the list of required permissions.
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 2.3.0
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.174.

# 1.23.809.1

* AADAuthorizationPolicy
  * Added support for the AllowedToCreateTenants &
    AllowedToReadBitlockerKeysForOwnedDevice properties.
    FIXES [#3492](https://github.com/microsoft/Microsoft365DSC/issues/3492)
* AADGroup, AADUser and O365Group
  * Add support to use function endsWith as filter
    FIXES [#3518](https://github.com/microsoft/Microsoft365DSC/issues/3518)
* O365OrgSettings
  * Added error handling for the Viva settings to handle task cancellation errors.
  * Added improvements for the set to only call into APIs that need a PATCH request.
* SCComplianceSearch
  * Fixed an issue with the export when using CertificateThumbprint.
    FIXES [#3499](https://github.com/microsoft/Microsoft365DSC/issues/3499)
* SCComplianceSearchAction
  * Adds support for the Preview action type.
    FIXES [#3498](https://github.com/microsoft/Microsoft365DSC/issues/3498)
* SCRetentionCompliancePolicy
  * Fixes an issue where SPN auth parameters weren't returned from the Get-TargetResource
    function.
    FIXES [#3500](https://github.com/microsoft/Microsoft365DSC/issues/3500)
* SPOTenantSettings
  * Add support for new parameter HideSyncButtonOnTeamSite
* TeamsGroupPolicyAssignment
  * FIXES [#3559](https://github.com/microsoft/Microsoft365DSC/issues/3559)
* TeamsShiftPolicy
  * Deprecated the EnableShiftPresence parameter.
* TeamsTemplatesPolicy
  * Initial release.
* MISC
  * M365DscReverse: Fix exporting when $Filter var exists locally
    FIXES [#3515](https://github.com/microsoft/Microsoft365DSC/issues/3515)
  * Fix for the delta report function to handle deep nested CIM Instances.
    FIXES [#3478](https://github.com/microsoft/Microsoft365DSC/issues/3478)
* DEPENDENCIES
  * Updated Microsoft.Graph.* dependencies to version 2.2.0.
  * Updated MSCloudLoginAssistant to version 1.0.119.
  * Updated dependency Microsoft.PowerApps.Administration.PowerShell to version 2.0.170.

# 1.23.726.1

* AADGroup
  * Fix issue setting MemberOf property.
    FIXES [#3496](https://github.com/microsoft/Microsoft365DSC/issues/3496)
* TeamsOrgWideAppSettings
  * Removed support for app authentication since the underlying cmdlets aren't
    supporting it yet.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.118.
* MISC
  * Improved Update-M365DSCDependencies function to properly install all Microsoft.Graph.* modules.
    FIXES [#3454](https://github.com/microsoft/Microsoft365DSC/issues/3454)

# 1.23.719.1
* AADCrossTenant
  * Added Automatic Consent for inbound and Outbound trust settings
* EXOSharedMailbox
  * Added capability to change the PrimarySMTPAddress of a Shared Mailbox
* SPOExternalUserExpireInDays
  * Added the External User Expiration setting in the config.
* MISC
  * Updated AAD, EXO and Teams settings file to describe required roles.
  * Added a new personas documentation page to describe the targeted personas
    for the project.
  * Added a more meaningful exception message to Update-M365DSCDependencies if
    the module is not installed or imported successfully
  * Fixes an issue with the reporting where the wrong key parameter was sometimes
    used when a component was missing in the source tenant.
* DEPENDENCIES
  * Updated the Microsoft.Graph.* dependencies to version 2.1.0.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.168.
  * Updated MicrosoftTeams to version 5.4.0.
  * Updated MSCloudLoginAssistant to version 1.0.117.

# 1.23.712.1

* IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator
  * Fixes an issue where the Get-TargetResource function was defining the parameter as Identity and all othe methods and schema had it defined to Id.
* O365OrgSettings
  * Introduced a workaround to fix an issue with the ExchangeOnlineManagement module where if connected to Security and Compliance center
    an error about an invalid token would get thrown when calling the Get-DefaultTenantMyAnalyticsFeatureConfig cmdlet.
* SPOApp
  * Fixes an issue where the extraction was complaining about op_addition failing.
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.167.
* DRG
  * General cleanup from generated resources from DRG
    * Added module M365DSCDRGUtil.psm1
    * Fix issues on several resources
    * Fix assignment from several resources
    * Fix unit test on several resources
    * Removed helper resources centralized in M365DSCDRGUtil from all resources
      FIXES [#3309](https://github.com/microsoft/Microsoft365DSC/issues/3309)
* MISC
  * Fixes cmdlet to use Get-MgBetaOrganization in the Get-M365DSCTenantDomain function.
    FIXES [#3449](https://github.com/microsoft/Microsoft365DSC/issues/3449)

# 1.23.705.1

* EXOAddressList
  * Improved export performance.
* EXOCASMailboxSettings
  * Improved export performance.
* EXODataClassification
  * Improved export performance.
* EXODistributionGroup
  * Improved export performance.
* EXOGroupSettings
  * Improved export performance.
* EXOMailboxPlan
  * Support comparing instances without the GUID in the name.
    FIXES [#3314](https://github.com/microsoft/Microsoft365DSC/issues/3314)
* EXOManagementRole
  * Improved export performance.
* EXOManagementRoleAssignment
  * Improved export performance.
* EXORoleGroup
  * Improved export performance.
* DEPENDENCIES
  * Updated all Microsoft.Graph modules to version 2.0.0.
  * Updated all MSCloudLoginAssistant modules to version 1.0.116.
* MISC
  * Updated QA tests to dynamically retrieve the permission list.
* IntuneASRRulesPolicyWindows10
  * Fix possible values for several properties both in the module and its schema
    FIXES [#3434](https://github.com/microsoft/Microsoft365DSC/issues/3434)

# 1.23.628.1

* AADAdministrativeUnit
  * Improved export performance.
* AADApplication
  * Updated the Set and Test function to ignore the AppId parameter.
    FIXES [#3390](https://github.com/microsoft/Microsoft365DSC/issues/3390)
  * Improved export performance.
* AADAuthenticationMethodPolicyAuthenticator
  * Deprecated the NumberMatchingRequiredState Feature Setting.
    FIXES [#3406](https://github.com/microsoft/Microsoft365DSC/issues/3406)
* AADRoleDefinition
  * Improved export performance.
* AADRoleSetting
  * Improved export performance.
* AADServicePrincipal
  * Updated the Set and Test function to ignore the AppId parameter.
    FIXES [#3390](https://github.com/microsoft/Microsoft365DSC/issues/3390)
  * Improved export performance.
* EXOAvailabilityConfig
  * Fixes an error where an error was thrown when the OrgWideAccount wasn't set.
    FIXES [#3402](https://github.com/microsoft/Microsoft365DSC/issues/3402)
* IntuneDeviceEnrollmentPlatformRestriction
  * Fixes an error where the WindowsMobileRestriction property was still being assessed dispite it being deprecated.
    FIXES [#3407](https://github.com/microsoft/Microsoft365DSC/issues/3407)
* O365OrgSettings
  * Added support for Forms, Dynamics Customer Voice, To Do and Apps & Services settings.
* TeamsCallQueue
  * Initial release.
* Teams resources
  * Added required application permissions to support [Application Based Authentication](https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-application-authentication)
* MISC
  * Added API to the Organization.Read.All permission in the Get-M365DSCCompiledPermisisonList cmdlet
  * Fixes an issue with Update-M365DSCAzureAdApplication where it was throwing an error complaining about duplicate keys.
    FIXES #3417
  * Update-M365DSCModule now forces a reload of the latest version of the Microsoft365DSC module.
    FIXES [#3326](https://github.com/microsoft/Microsoft365DSC/issues/3326)
  * Update-M365DSCAzureADApplication
    Added retry logic to catch the "Key credential end date is invalid" error when updating the application certificate.
    FIXES [#3426](https://github.com/microsoft/Microsoft365DSC/issues/3426)
* DEPENDENCIES
  * Updated ReverseDSC to version 2.0.0.16.

# 1.23.621.1

* AADAdministrativeUnit
  * Fixes an issue where the domain part of the user name was handled as a string when using credentials to authenticate.
* EXORoleGroup
  * Fixes an issue where the role group wasn't getting created when members were null.
    FIXES [#3217](https://github.com/microsoft/Microsoft365DSC/issues/3217)
* O365OrgSettings
  * Added support for the PlannerAllowCalendarSharing property for Planner.
  * Added support for the Microsoft 365 installation options.
  * Added support for the Viva Insights and Briefing email settings.
* PPTenantIsolationSettings & PPTenantSettings
  * Handles the case where required permissions are not provided when using SPN authentication.
    FIXES [#3179](https://github.com/microsoft/Microsoft365DSC/issues/3179)
* SCProtectionAlert
  * Prevents extracting system rules.
    FIXES [#3224](https://github.com/microsoft/Microsoft365DSC/issues/3224)
* MISC
  * Fixes the display of arrays as property values for Excel based reports from New-M365DSCReportFromConfiguration.
    FIXES [#3173](https://github.com/microsoft/Microsoft365DSC/issues/3173)
  * Added the Organization.Read.All permission by default in the Get-M365DSCCompiledPermisisonList cmdlet return values.
    FIXES [#3292](https://github.com/microsoft/Microsoft365DSC/issues/3292)
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 3.2.0.
  * Updated MicrosoftTeams to version 5.3.0.
  * Updated MSCloudLoginAssistant to version 1.0.114.

# 1.23.614.1

* AADApplication
  * Adds support for specifying permissions by names or GUID.
* AADNamedLocationPolicy
  * Added support forthe CountryLookupMethod property
    FIXES [#3345](https://github.com/microsoft/Microsoft365DSC/issues/3345)
* IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10
  * Fixes an issue with Set-TargetResource when an array is empty
  * Fixes presentationValue updates
    FIXES [#3355](https://github.com/microsoft/Microsoft365DSC/issues/3355)
* TeamsAppPermissionPolicy
  * Fixes an issue where the wrong app types were trying to get assigned.
    FIXES [#3373](https://github.com/microsoft/Microsoft365DSC/issues/3373)
* MISC
  * Removed dependency on the Az.Accounts module from the Update-M365DSCAzureAdApplication function.
* DEPENDENCIES
  * Updated DSCParser to version 1.3.0.10.
  * Updated Microsoft.Graph dependencies to version 1.28.0.
  * Updated MSCloudLoginAssistant to version 1.0.112.

# 1.23.607.1

* AADAuthenticationStrengthPolicy
  * Removed the validateset from the AllowedCombinations property due to incomplete full list of possible values.
* EXOQuarantinePolicy
  * Fixes an issue where GlobalQurantinePolicy properties can't be updated.
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Fixes an issue for policies with template endpointSecurityAntivirus that had a templateId not expected by the code
    FIXES [#3360](https://github.com/microsoft/Microsoft365DSC/issues/3360)
* IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10
  * Fixes an issue with Set-TargetResource when an array is empty
    FIXES [#3355](https://github.com/microsoft/Microsoft365DSC/issues/3355)
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.166.

# 1.23.524.1

* AADGroup
  * Performance Improvements for export.
* AADUser
  * Performance improvements for export.
* O365OrgSettings
  * Added support for the AdminCenterReportDisplayConcealedNames property.
* SCAutoSensitivityLabelRule
  * Fixes an issue with the HeaderMatchesPatterns property not compiling when empty.
* TeamsOrgWideAppSettings
  * Initial release.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.111
  * Updated ReverseDSC to version 2.0.0.15

# 1.23.517.1

* AADEntitlementManagementAccessPackageAssignmentPolicy
  * Fixes an issue where Reviewers and requestors weren't properly extracted.
    FIXES [#3255](https://github.com/microsoft/Microsoft365DSC/issues/3255)
* IntuneDeviceEnrollmentPlatformRestriction
  * Ensure that Windows Mobile platform cannot be unblocked
    FIXES [#3303](https://github.com/microsoft/Microsoft365DSC/issues/3303)
* IntuneSettingCatalogCustomPolicyWindows10
  * Add missing properties to schema
    FIXES [#3300](https://github.com/microsoft/Microsoft365DSC/issues/3300)
* SCAutoSensitivityLabelRule
  * Fixes an issue with the HeaderMatchesPatterns property not working as expected.
    FIXES [#3315](https://github.com/microsoft/Microsoft365DSC/issues/3315)
* SPOUserProfileProperty
  * Fixes and issue where the properties weren't properly set.
    FIXES [#3226](https://github.com/microsoft/Microsoft365DSC/issues/3226)
* TeamsAppPermissionPolicy
  * Initial release
* TeamsAppSetupPolicy
  * Initial release.
* EXOQuarantinePolicy
  * Support exporting and importing global quarantine policy
    FIXES [#3285](https://github.com/microsoft/Microsoft365DSC/issues/3285)
* DEPENDENCIES
  * Updated MicrosoftTeams to version 5.2.0
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.165
* MISC
  * Major performance improvements for the New-M365DSCDeltaReport cmdlet.
    FIXES [#3016](https://github.com/microsoft/Microsoft365DSC/issues/3016)
  * M365DSCUtil: Fix typo in order to obfuscate cert thumbprint

# 1.23.510.1

* AADAuthenticationStrengthPolicy
  * Initial release
* AADConditionalAccessPolicy
  * Added support for the AuthenticationStrength parameter.
* AADCrossTenantAccessPolicy
  * Initial release
    FIXES [#3251](https://github.com/microsoft/Microsoft365DSC/issues/3251)
* AADCrossTenantAccessPolicyConfigurationDefault
  * Initial release
    FIXES [#3252](https://github.com/microsoft/Microsoft365DSC/issues/3252)
* AADCrossTenantAccessPolicyConfigurationPartner
  * Initial release
    FIXES [#3253](https://github.com/microsoft/Microsoft365DSC/issues/3253)
* IntuneSettingCatalogCustomPolicyWindows10
  * Initial release
  FIXES [#2692](https://github.com/microsoft/Microsoft365DSC/issues/2692),
  FIXES [#2976](https://github.com/microsoft/Microsoft365DSC/issues/2976),
  FIXES [#3070](https://github.com/microsoft/Microsoft365DSC/issues/3070),
  FIXES [#3071](https://github.com/microsoft/Microsoft365DSC/issues/3071),
  FIXES [#3156](https://github.com/microsoft/Microsoft365DSC/issues/3156)
* TeamsMessagingPolicy
  * Add support for new parameters: AllowSmartCompose, AllowSmartReply, AllowUserDeleteChat
* TeamsGuestMessagingConfiguration
  * Add support for AllowUserDeleteChat parameter
* TeamsGuestMeetingConfiguration
  * Add support for LiveCaptionsEnabledType parameter
* TeamsTeam
  * Fix group creation
* DEPENDENCIES
  * Updated DSCParser to version 1.0.9.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.1623.
  * Updated MSCloudLoginAssistant to version 1.0.110.
* MISC
  * Added a new Get-M365DSCConfigurationConflict cmdlet to help validate configurations and added
    the -Validate switch to the Export-M365DSCConfiguration cmdlet.

# 1.23.503.1

* IntuneDeviceConfigurationImportedPfxCertificatePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationPkcsCertificatePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationScepCertificatePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationSecureAssessmentPolicyWindows10
  * Initial release
* IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationTrustedCertificatePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationVpnPolicyWindows10
  * Initial release
* IntuneDeviceConfigurationWiredNetworkPolicyWindows10
  * Initial release
* DRG
  * Fix issue with abstract type and additionalProperties
* MISC
  * Intune: changed the display or instances to show the display name instead of Id during extraction.
  * M365DSCUtil: Fixed an issue on function Get-M365DSCExportContentForResource if ConnectionMode was set to anything but "Credentials*"
  * Assert-M365DSCBlueprint, New-M365DSCDeltaReport, Compare-M365DSCConfigurations: Add support to exclude resources from being compared
  * EXPORT: Multiple fixes for display and handling of invalid licenses.
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.109.

# 1.23.426.3

* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.108.
  * Updated Microsoft.Graph dependencies to version 1.27.0.
* MISC
  * If an error occurs during the export process, we now throw an error instead of simply writing the error
    back to the host via Write-Host.

# 1.23.426.2

* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.107.
    FIXES #3231

# 1.23.426.1

* AADConditionalAccessPolicy
  * Fix Couldn't find Location 00000000-0000-0000-0000-000000000000
    FIXES[#2974](https://github.com/microsoft/Microsoft365DSC/issues/2974)
* AADAuthenticationMethodPolicy
  * Initial release. Configure Authentication policy settings
* AADAuthenticationMethodPolicyAuthenticator
  * Initial release. Configure Authentication settings related to MicrosoftAuthenticator
* AADAuthenticationMethodPolicyEmail
  * Initial release. Configure Authentication settings related to Email
* AADAuthenticationMethodPolicyFido2
  * Initial release. Configure Authentication settings related to Fido2
* AADAuthenticationMethodPolicySms
  * Initial release. Configure Authentication settings related to Sms
* AADAuthenticationMethodPolicySoftware
  * Initial release. Configure Authentication settings related to SoftwareOath
* AADAuthenticationMethodPolicyTemporary
  * Initial release. Configure Authentication settings related to TemporaryAccessPass
* AADAuthenticationMethodPolicyVoice
  * Initial release. Configure Authentication settings related to Voice
* AADAuthenticationMethodPolicyX509
  * Initial release. Configure Authentication settings related to X509Certificate
* AADAdministrativeUnit
  * Fix issue incorrectly removing existing Members and ScopedRoleMembers
    FIXES [#3194](https://github.com/microsoft/Microsoft365DSC/issues/3194)
  * Fix issue creating ScopedRoleMembers of Type Group or ServicePrincipal
    FIXES [#3189](https://github.com/microsoft/Microsoft365DSC/issues/3189)
* SCLabelPolicy
  * Fixed issue where the Labels parameter isn't handled properly for existing
    policies
    FIXES [#3216](https://github.com/microsoft/Microsoft365DSC/issues/3216)
* SCSensitivityLabel
  * Remove property Disabled from schema
    FIXES [#3193](https://github.com/microsoft/Microsoft365DSC/issues/3193)
  * Corrected issue where SiteAndGroupExternalSharingControlType wasn't
    applied correctly with existing labels
    FIXES [#3210](https://github.com/microsoft/Microsoft365DSC/issues/3210)
* TeamsTeam
  * Fixes an error when trying to extract teams using a Service Principal.
    FIXES [#3183](https://github.com/microsoft/Microsoft365DSC/issues/3183)
* DEPENDENCIES
  * Updated DSCParser dependencies to version 1.3.0.7.
  * Updated Microsoft.Graph dependencies to version 1.26.0.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.160.
  * Updated MSCloudLoginAssistant to version 1.0.106.

# 1.23.419.1

* IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10
  * Initial release
* IntuneDeviceConfigurationEmailProfilePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationKioskPolicyWindows10
  * Initial release
* EXOManagementRoleAssignment
  * Fixed issue with incorrect Microsoft Graph cmdlets used to retrieve Administrative Units.
    FIXES [#3185](https://github.com/microsoft/Microsoft365DSC/issues/3185)
* SCLabelPolicy
  * If label policy is set to None don't get its label display name since it's not required
    FIXES [#3104](https://github.com/microsoft/Microsoft365DSC/issues/3104)
* DRG
  * Fixed issue retrieving the cmdlet definition when the resource type is derived from an abstract type
  * Fixed issue with UnitTest and complex properties with AdditionalProperties
  * Fixed issue with Complex constructor and complex properties with AdditionalProperties
* MISC
  * Reports will now exclude the authentication parameters (e.g., CertificateThumbprint, Credential, etc.).
  * Changed the Encoding helper's logic to ensure titled quotes and apostrophes are correctly evaluated.
    FIXES [#3165](https://github.com/microsoft/Microsoft365DSC/issues/3165)
  * Fixes an issue where the new resource name extraction could still have duplicates.

# 1.23.412.1

* AADUser
  * Password property will only used with New-MgUser and ignored for updates
    FIXES [#3093](https://github.com/microsoft/Microsoft365DSC/issues/3093)
* IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10
   * Initial release
     FIXES [#2833](https://github.com/microsoft/Microsoft365DSC/issues/2833)
* IntuneDeviceConfigurationCustomPolicyWindows10
  * Initial Release
      FIXES [#3068](https://github.com/microsoft/Microsoft365DSC/issues/3068)
* IntuneDeviceConfigurationDomainJoinPolicyWindows10
  * Initial release
* IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10
  * Initial release
* IntuneDeviceConfigurationWindowsTeamPolicyWindows10
  * Initial release
* O365SearchAndIntelligenceConfigurations
  * Initial release.
* TeamsUpdateManagementPolicy
  * Added support for the Forced value for the AllowPublicPreview property.
* DRG
  * Fixed layout and display issues in module file
* MISC
  * Changed Get-MgDeviceManagementDeviceConfiguration to use the cmdlet switches rather than filtering output once returned.
    Fixes #3082
  * M365DSCUtil: Fixed an issue when calling Assert-M365DSCBlueprint with App credentials
    FIXES [#3153](https://github.com/microsoft/Microsoft365DSC/issues/3153)
  * Added check to validate that the Release Notes in the module manifest are not longer than
    10,000 characters, which will prevent publishing the module to the PowerShell Gallery
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell dependencies to version 2.0.159.

# 1.23.405.1

* AADAdministrativeUnit
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * Fixes extraction of the Members property.
  * Fixes extraction of the ScopedRoleMembers property.
* AADApplication
  * [BREAKING CHANGE] Remove deprecated parameter Oauth2RequirePostResponse
* AADAuthorizationPolicy
  * Fixes an error where the authentication method wasn't recognized when doing an export using app secret.
    FIXES [#3056](https://github.com/microsoft/Microsoft365DSC/issues/3056)
* AADConditionalAccessPolicy
  * Add condition for empty External Guest/User include/exclude
    FIXES [#3108](https://github.com/microsoft/Microsoft365DSC/issues/3108)
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * [BREAKING CHANGE] Remove deprecated parameters IncludeDevices and ExcludeDevices
* AADEntitlementManagementAccessPackage, AADEntitlementManagementAccessPackageAssignmentPolicy,
  AADEntitlementManagementAccessPackageCatalog, AADEntitlementManagementAccessPackageCatalogResource,
  AADEntitlementManagementAccessPackageCatalogResource, AADEntitlementManagementConnectedOrganization,
  AADRoleSetting
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
* AADGroup
  * Changed the SecurityEnabled and MailEnabled parameters to become mandatory.
    FIXES [#3072](https://github.com/microsoft/Microsoft365DSC/issues/3072)
  * Stopped GroupTypes defaulting to 'Unified' to allow creation of Security groups.
    FIXES [#3073](https://github.com/microsoft/Microsoft365DSC/issues/3073)
* AADUser
  * [BREAKING CHANGE] Remove deprecated parameter PreferredDataLocation* EXOAntiPhishPolicy
  * [BREAKING CHANGE] Remove deprecated parameters EnableAntispoofEnforcement and
    TargetedDomainProtectionAction
* EXOGroupSettings
  * Initial Release
    FIXES [#3089](https://github.com/microsoft/Microsoft365DSC/issues/3089)
* EXOHostedContentFilterPolicy
  * [BREAKING CHANGE] Remove deprecated parameters EndUserSpamNotificationCustomFromAddress
    and EndUserSpamNotificationCustomFromName
* EXOIRMConfiguration
  * [BREAKING CHANGE] Renamed unused Identity parameter to IsSingleInstance
    FIXES [#2969](https://github.com/microsoft/Microsoft365DSC/issues/2969)
* EXOMalwareFilterPolicy
  * [BREAKING CHANGE] Remove deprecated parameters Action, CustomAlertText,
    EnableExternalSenderNotifications and EnableInternalSenderNotifications
* EXOManagementRoleAssignment
  * Use Microsoft Graph to retrieve administrative units. This fixes the issue where a soft
    deleted AU was present while a new one got created with the same name.
    FIXES [#3064](https://github.com/microsoft/Microsoft365DSC/issues/3064)
* EXOOrganizationConfig
  * [BREAKING CHANGE] Remove deprecated parameters AllowPlusAddressInRecipients
  * [BREAKING CHANGE] Renamed unused Identity parameter to IsSingleInstance
    FIXES [#2969](https://github.com/microsoft/Microsoft365DSC/issues/2969)
* EXOPerimeterConfiguration
  * [BREAKING CHANGE] Renamed unused Identity parameter to IsSingleInstance
    FIXES [#2969](https://github.com/microsoft/Microsoft365DSC/issues/2969)
* EXOResourceConfiguration
  * [BREAKING CHANGE] Renamed unused Identity parameter to IsSingleInstance
    FIXES [#2969](https://github.com/microsoft/Microsoft365DSC/issues/2969)
* EXOSaveLinksPolicy
  * [BREAKING CHANGE] Remove deprecated parameters DoNotAllowClickThrough,
    DoNotTrackUserClicks and IsEnabled
* EXOSharedMailbox
  * [BREAKING CHANGE] Remove deprecated parameter Aliases
* EXOTransportRule
  * [BREAKING CHANGE] Remove deprecated parameter ExceptIfMessageContainsAllDataClassifications,
    IncidentReportOriginalMail and MessageContainsAllDataClassifications
* IntuneAntivirusPolicyWindows10SettingCatalog, IntuneASRRulesPolicyWindows10,
  IntuneAppProtectionPolicyiOS, IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager,
  IntuneSettingCatalogASRRulesPolicyWindows10
  * [BREAKING CHANGE] Setting Identity as Key parameter and DisplayName as Required
* IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager
  * [BREAKING CHANGE] Fix resource
* IntuneDeviceConfigurationHealthMonitoringConfigurationPolicyWindows10
  * Initial Release
    FIXES [#2830](https://github.com/microsoft/Microsoft365DSC/issues/2830)
* IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10
  * Initial release
* IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator, IntuneDeviceConfigurationPolicyAndroidDeviceOwner,
  IntuneDeviceConfigurationPolicyAndroidOpenSourceProject, IntuneDeviceConfigurationPolicyMacOS,
  IntuneDeviceConfigurationPolicyiOS, IntuneExploitProtectionPolicyWindows10SettingCatalog,
  IntuneWifiConfigurationPolicyAndroidDeviceAdministrator, IntuneWifiConfigurationPolicyAndroidForWork,
  IntuneWifiConfigurationPolicyAndroidOpenSourceProject, IntuneWifiConfigurationPolicyIOS,
  IntuneWifiConfigurationPolicyMacOS, IntuneWifiConfigurationPolicyWindows10,
  IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled, IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * Properly escapes single quotes from CIMInstances string values.
    FIXES [#3117](https://github.com/microsoft/Microsoft365DSC/issues/3117)
* IntuneDeviceConfigurationPolicyWindows10
  * [BREAKING CHANGE] Added complex parameters as embedded CIM (DefenderDetectedMalwareActions, EdgeHomeButtonConfiguration, EdgeSearchEngine, NetworkProxyServer, Windows10AppsForceUpdateSchedule)
  * Resource regenerated with DRG
    FIXES[#2867](https://github.com/microsoft/Microsoft365DSC/issues/2867)
    FIXES[#2868](https://github.com/microsoft/Microsoft365DSC/issues/2868)
* IntuneDeviceEnrollmentPlatformRestriction
  * [BREAKING CHANGE] Updated resource to manage single and default platform restriction policies
    FIXES [#2347](https://github.com/microsoft/Microsoft365DSC/issues/2347)
* IntuneDeviceEnrollmentStatusPageWindows10
  * [BREAKING CHANGE] Renamed resource IntuneDeviceEnrollmentConfigurationWindows10 to IntuneDeviceEnrollmentStatusPageWindows10
  * Added support for property Assignments.
  * Added support for property Priority
    FIXES [#2933](https://github.com/microsoft/Microsoft365DSC/issues/2933)
* IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * [BREAKING CHANGE] Corrected typo in resource name (Entreprise to Enterprise)
    FIXES [#3024](https://github.com/microsoft/Microsoft365DSC/issues/3024)
* IntuneWifiConfigurationPolicyAndroidEnterpriseWorkProfile
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * [BREAKING CHANGE] Corrected typo in resource name (Entreprise to Enterprise)
    FIXES [#3024](https://github.com/microsoft/Microsoft365DSC/issues/3024)
* IntuneWindowsAutopilotDeploymentProfileAzureADJoined
  * Initial release
    FIXES [#2605](https://github.com/microsoft/Microsoft365DSC/issues/2605)
* IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined
  * Initial release
    FIXES [#2605](https://github.com/microsoft/Microsoft365DSC/issues/2605)
* IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10
  * [BREAKING CHANGE] Setting Id as Key parameter and DisplayName as Required
  * [BREAKING CHANGE] Corrected typo in resource name (Window to Windows)
    FIXES [#3024](https://github.com/microsoft/Microsoft365DSC/issues/3024)
* SCAuditConfigurationPolicy, SCAutoSensitivityLabelPolicy, SCCaseHoldPolicy, SCCaseHoldRule,
  SCComplianceCase, SCComplianceSearch, SCComplianceSearchAction, SCComplianceTag,
  SCDeviceConditionalAccessPolicy, SCDeviceConfigurationPolicy, SCDLPComplianceRule,
  SCFilePlanPropertyAuthority, SCFilePlanPropertyCategory, SCFilePlanPropertyCitation,
  SCFilePlanPropertyDepartment, SCFilePlanPropertyReferenceId, SCFilePlanPropertySubCategory,
  SCLabelPolicy, SCProtectionAlert, SCRetentionCompliancePolicy, SCRetentionComplianceRule,
  SCRetentionEventType, SCSupervisoryReviewPolicy, SCSupervisoryReviewRule
  * Fixed the collection of new and set parameters to ensure the correct values are passed to the New/Set cmdlets.
    FIXES [#3075](https://github.com/microsoft/Microsoft365DSC/issues/3075)
* SCSensitivityLabel
  * [BREAKING CHANGE] Remove deprecated parameters Disabled, ApplyContentMarkingFooterFontName,
    ApplyContentMarkingHeaderFontName, ApplyWaterMarkingFontName and EncryptionAipTemplateScopes
* SPOApp
  * Fixed issue in the Export where an error was displayed in Verbose mode when Credentials were specified
    and the apps were not exported.
* SPOTenantSettings
  * Fixes how we are extracting the DisabledWebPartIds parameter.
    FIXES [#3066](https://github.com/microsoft/Microsoft365DSC/issues/3066)
  * [BREAKING CHANGE] Remove deprecated parameter RequireAcceptingAccountMatchInvitedAccount
* TeamsMeetingPolicy
  * [BREAKING CHANGE] Remove deprecated parameter RecordingStorageMode
* TeamsUpdateManagementPolicy
  * Added support for the new UseNewTeamsClient parameter.
    FIXES [#3062](https://github.com/microsoft/Microsoft365DSC/issues/3062)
* DRG
  * Various fixes
    * Cleanup generated code
    * Fix AdditionalProperties complex constructor
    * Fix Read privileges in settings file
* MISC
  * Fixed an issue `New-M365DSCReportFromConfiguration` where a non existing parameter was used to retrieve the configuration.
  * Improved unit test performance
  * Added a QA check to test for the presence of a Key parameter and fixes
    resources where this was not the case.
    FIXES [#2925](https://github.com/microsoft/Microsoft365DSC/issues/2925)
  * Major changes to the export process where resource instances will now be assigned a meaningful name
    that will follow the ResourceName-PrimaryKey convention.
  * Added a fix making sure that the progress bar "Scanning dependencies" is no longer displayed after the operation is completed.
  * Added a new Set-M365DSCLoggingOption function to enable logging information about non-drifted resources in Event Viewer.
    FIXES [#2981](https://github.com/microsoft/Microsoft365DSC/issues/2981)
  * Updated the Update-M365DSCModule to unload dependencies before updating them and then to reload the new versions.
    FIXES [#3097](https://github.com/microsoft/Microsoft365DSC/issues/3097)
  * Added a new internal function to remove the authentication parameters from the bound paramters. `Remove-M365DSCAuthenticationParameter`
  * Enforcing tenant ID to be in the tenant.onmicrosoft.com form.
    FIXES [#3046](https://github.com/microsoft/Microsoft365DSC/issues/3046)
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 1.25.0.
  * Updated MicrosoftTeams dependency to version 5.1.0.

# 1.23.322.1

* AADRoleSetting
  * Added CertificateThumbPrint and ApplicationId to the output of the Get method
* EXODistributionGroup
  * Fixed an error where the name wasn't properly escaped in the Filter
  FIXES [#3044](https://github.com/microsoft/Microsoft365DSC/issues/3044)
* EXORoleAssignmentPolicy
  * Fix issue with IsDefault parameter
    FIXES [#2977](https://github.com/microsoft/Microsoft365DSC/issues/2977)
* IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10
  * Initial Release
    FIXES [#2832](https://github.com/microsoft/Microsoft365DSC/issues/2832)
* IntuneDeviceConfigurationEndpointProtectionPolicyWindows10
  * Initial release
    FIXES [#2834](https://github.com/microsoft/Microsoft365DSC/issues/2834)
* IntuneDeviceConfigurationIdentityProtectionPolicyWindows10
  * Initial release
    FIXES [#2831](https://github.com/microsoft/Microsoft365DSC/issues/2831)
* SCDLPCompliancePolicy
  * Added support or Endpoint, On-Premises, PowerBI and ThirdPartyApps locations and exceptions.
    FIXES [#3023](https://github.com/microsoft/Microsoft365DSC/issues/3023)
* SCSensitivityLabel
  * Added ContentType parameter, so you can specify where to apply the label.
    FIXES [#2992](https://github.com/microsoft/Microsoft365DSC/issues/2992)
  * Updated the resource to use and apply the correct parameters from the LabelActions
    property.
    FIXES [#3035](https://github.com/microsoft/Microsoft365DSC/issues/3035)
  * Deprecated all FontName properties, since these are no longer configurable.
    FIXES [#3035](https://github.com/microsoft/Microsoft365DSC/issues/3035)
  * Fixed the collection of new and set parameters to ensure the correct values are passed to the New/Set cmdlets.
    FIXES [#3050](https://github.com/microsoft/Microsoft365DSC/issues/3050)
* MISC
  * Added QA test that checks for existence of an example for each resource.
  * Amended output for Convert-M365DscHashtableToString to show each value on a new line
    Fixes[#2980](https://github.com/microsoft/Microsoft365DSC/issues/2980)
* DRG
  * Various fixes:
    * Remove invalid character from description in schema.mof
    * Add Id as key in schema.mof
    * Add DisplayName as Required in schema.mof
    * Fix issue with nested CIM array from test unit
    * Remove Select-MgProfile from module
    * Add DisplayName as Mandatory in module
    * Fix issue with AdditionalProperties for nested objects from module
    * Fix Ensure default value

# 1.23.315.2

* EXORoleGroup
  * Fixes an issue with the Export process where the name of the role wasn't properly set causing errors.

# 1.23.315.1

* AADConditionalAccessPolicy
  * Handle Named Location "Multifactor authentication trusted IPs"
    Fixed [#2974](https://github.com/microsoft/Microsoft365DSC/issues/2974)
  * Export and handle guest and external users.
    Fixed [#2965](https://github.com/microsoft/Microsoft365DSC/issues/2965)
* AADEntitlementManagementConnectedOrganization
  * Initial release
* EXOOrganizationConfig
  * Add support for the MessageRecallEnabled parameter.
    FIXES [#2978](https://github.com/microsoft/Microsoft365DSC/issues/2978)
* EXORoleAssignmentPolicy
  * Allow description and role change at the same time.
    FIXES [#2977](https://github.com/microsoft/Microsoft365DSC/issues/2977)
* EXORoleGroup
  * Initial release
* EXOTransportConfig
  * Ensures the ExternalDsnDefaultLanguage property is correctly escaped.
    FIXES [#2970](https://github.com/microsoft/Microsoft365DSC/issues/2970)
* IntuneAppProtectionPolicyiOS
  * Amended MinimumWipeOSVersion case
    FIXES [#3000](https://github.com/microsoft/Microsoft365DSC/issues/3000)
* PPTenantIsolationSettings
  * Fixes the export of the Rules block which wasn't properly formatted.
    FIXES [#2979](https://github.com/microsoft/Microsoft365DSC/issues/2979)
* SPOTenantSettings
  * Add support for the CommentsOnSitePagesDisabled parameter.
* MISC
  * Added checks in New-M365DSCConnection to ensure beta MSGraph profile is correctly set when requested
    FIXES [#2942](https://github.com/microsoft/Microsoft365DSC/issues/2942)
  * Added all Certificate related property to the returned values of the Get-TargetResource function
    across all Security & Compliance resources.
    FIXES [#2989](https://github.com/microsoft/Microsoft365DSC/issues/2989)
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 1.23.0.
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.156.

# 1.23.308.1

* AADAdministrativeUnit
  * Fixed general issues caused by improper handling of nested CIMInstances
    FIXES #2775, #2776, #2786
  * Updated validation of properties in schema to assist usage
* AADServicePrincipal
  * Change Write-Error to Write-Verbose to make sure the Test method will continue
    FIXES [#2961](https://github.com/microsoft/Microsoft365DSC/issues/2961)
* EXOManagementRoleAssignment
  * Added delays before disconnecting from EXO to ensure new permissions are applied.
    FIXES [#2523](https://github.com/microsoft/Microsoft365DSC/issues/2523)
* O365AdminAuditLogConfig
  * Added support for ManagedIdentity.
  * Fixed the Get-TargetResource method to return all authentication parameters.
* DRG
  * Fixed the default settings for the Ensure parameter.
* MISC
  * Updated logic for drift detection to be case insensitive.
    FIXES [#2873](https://github.com/microsoft/Microsoft365DSC/issues/2873)
  * Changed the -Platform parameter for Connect-M365Tenant to -Workload in 2 remaining places.
    FIXES [#2921](https://github.com/microsoft/Microsoft365DSC/issues/2921)
  * Added QA test to validate if used permissions in Settings.json files
    actually exist.
  * Added application credential support to Assert-M365DSCBlueprint
    FIXES [#1792](https://github.com/microsoft/Microsoft365DSC/pull/1792)
  * Updated/added various examples
* DEPENDENCIES
  * Updated MicrosoftTeams to version 5.0.0

# 1.23.301.1

* IntuneDeviceEnrollmentConfigurationWindows10
  * Fix settings.json
    FIXES [#2930](https://github.com/microsoft/Microsoft365DSC/issues/2930)
* O365OrgSettings
  * Adds support for Cortana enabling.
* SCLabelPolicy
  * Added more detailed logging
  * Converting the GUIDs of all defaultlabel settings in the AdvancedSettings
    parameters to the actual label name, since the GUID is different per
    environment
    FIXES [#2840](https://github.com/microsoft/Microsoft365DSC/issues/2840)
  * Fixed issue where the Test method resulted in False on any existing policy
    FIXES [#2948](https://github.com/microsoft/Microsoft365DSC/issues/2948)
* SCSensitivityLabel
  * Added more detailed logging
  * Fixed issue where the Test method always tested false when the LocaleSettings
    property was used
    FIXES [#2949](https://github.com/microsoft/Microsoft365DSC/issues/2949)
  * Fixes issues around Test-TargetResource always returning False when encryption parameters are used.
    FIXES [#2683](https://github.com/microsoft/Microsoft365DSC/issues/2683)
* SPOUserProfileProperty
  * Fixes the required API permissions in the documentation.
    FIXES [#2798](https://github.com/microsoft/Microsoft365DSC/issues/2798)
* TeamsOnlineVoiceUser
  * Fix issue where the cmdlet Get-CsOnlineVoiceUser is now deprecated.
* MISC
  * Updated unit tests
  * Added quality check tests
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.22.0
  * Updated MSCloudLoginAssistant to version 1.0.105
  * Updated ReverseDSC to version 2.0.0.14

# 1.23.222.1

* TeamsOnlineVoiceUser
  * Fix issue where the cmdlet Get-CsOnlineVoiceUser is now deprecated.

# 1.23.222.1

* AADEntitlementManagementAccessPackageAssignmentPolicy
  * Initial release
* IntuneDeviceEnrollmentConfigurationWindows10
  * Initial release
    FIXES [#2829](https://github.com/microsoft/Microsoft365DSC/issues/2829)
* IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10
  * Initial release.
    FIXES [#2658](https://github.com/microsoft/Microsoft365DSC/issues/2658)
* IntuneWindowUpdateForBusinessRingUpdateProfileWindows10
  * Initial release.
    FIXES [#2657](https://github.com/microsoft/Microsoft365DSC/issues/2657)
* PPPowerAppsEnvironment
  * Added all the latest location return from Get-AdminPowerAppEnvironmentLocations
* TeamsChannelTab
  * Updated key parameters to prevent detected duplicates
    FIXES [#2897](https://github.com/microsoft/Microsoft365DSC/issues/2897)
* DRG
  * Various fixes
* MISC
  * Updated Tasks.Read and Tasks.ReadWrite Permissions for Planner Plans and Planner Buckets
    FIXES [#2866](https://github.com/microsoft/Microsoft365DSC/issues/2866)
  * Fixed Permissions Scopes for AADAuthorizationPolicy and AADSecurityDefaults

# 1.23.215.1

* EXOIRMConfiguration
  * Fixed issue where the export did not the correct type for RMSOnlineKeySharingLocation
    FIXES [#2890](https://github.com/microsoft/Microsoft365DSC/issues/2890)
* IntuneRoleAssignment
  * Fixed issue where the export did not the correct type for ScopeType
    FIXES [#2889](https://github.com/microsoft/Microsoft365DSC/issues/2889)
* O365OrgSettings
  * Initial Release.
* TeamsChannelTab
  * Updated key parameters to prevent detected duplicates
    FIXES [#2897](https://github.com/microsoft/Microsoft365DSC/issues/2897)
* MISC
  * Updated required permissions of several resources
    FIXES [#2866](https://github.com/microsoft/Microsoft365DSC/issues/2866)
  * Added filter to Update-M365DSCAzureAdApplication to be more specific.
    FIXES [2565](https://github.com/microsoft/Microsoft365DSC/issues/2565)
  * Fixed the JSON conversion depth for the New-M365DSCConfigurationToJSON cmdlet.
    FIXES [#2891](https://github.com/microsoft/Microsoft365DSC/issues/2891)
  * Added new ParameterSet for Export-M365DSConfiguration
    FIXES [[#2802](https://github.com/microsoft/Microsoft365DSC/issues/2802)]

# 1.23.208.1

* TeamsTenantTrustedIPAddress
  * Initial Release.

# 1.23.201.1

* IntuneDeviceCompliancePolicyWindows10
  * Updated example
* IntuneDeviceConfigurationPolicyWindows10
  * Updated example
* PlannerTask
  * Fixed issue where Attachments Uri weren't properly exiting single quotes.
    FIXES [#2822](https://github.com/microsoft/Microsoft365DSC/issues/2822)
* PPPowerAppsEnvironment
  * Adds support for Developer SKU and fix for Teams SKU
    FIXES [#2821](https://github.com/microsoft/Microsoft365DSC/issues/2821)
* SCProtectionAlert
  * Support for certificate based auth
  * Fix removal of alert
  * Added additional supported values for ThreatType, Severity & AggregationType
    FIXES [#2793](https://github.com/microsoft/Microsoft365DSC/issues/2793)
* TeamsTenantNetworkRegion
  * Initial Release.
* TeamsTenantNetworkSite
  * Initial Release.
* TeamsTenantNetworkSubnet
  * Initial Release.
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.21.0
  * Updated MicrosoftTeams to version 4.9.3
* MISC
  * Corrected Ensure parameter logic for many resources.
    Removed requirement for Ensure=Present only.
    FIXES [#2718](https://github.com/microsoft/Microsoft365DSC/issues/2718)
  * Updated documentation to reflect new authentication possibilities
    FIXES [#2863](https://github.com/microsoft/Microsoft365DSC/issues/2863)

# 1.23.125.1

* TeamsAudioConferencingPolicy
  * Initial Release.
* TeamsCallHoldPolicy
  * Initial Release.
* TeamsCallParkPolicy
  * Initial Release.
* TeamsComplianceRecordingPolicy
  * Initial Release.
* TeamsCortanaPolicy
  * Initial Release.
* TeamsEnhancedEncryptionPolicy
  * Initial Release.
* TeamsMobilityPolicy
  * Initial Release.
* TeamsNetworkRoamingPolicy
  * Initial Release.
* TeamsTranslationRule
  * Initial Release.
* TeamsUnassignedNumberTreatment
  * Initial Release.
* TeamsVDIPolicy
  * Initial Release.
* TeamsWorkloadPolicy
  * Initial Release.
* DRG
  * Added CIM constructor in Get-TargetResource
  * Improved management of AdditionalProperties
  * Improved datetime and dateoffset management
  * Fixed UnitTest
  * Generate Stubs if required
  * Fixes #2819
* IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled
  * Initial Release
  * Fixes #2604
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.155.
* Planner
  * Fixed api-permissions on PlannerBucket and PlannerPlan.
    FIXES [#2843](https://github.com/microsoft/Microsoft365DSC/issues/2843)

# 1.23.118.1

* IntuneAppConfigurationPolicy
  * Fixes issue where the Test method fails when the policy does not exist yet
    and the Assignments parameter is used.
    FIXES [#2768](https://github.com/microsoft/Microsoft365DSC/issues/2768)
* IntuneDeviceAndAppManagementAssignmentFilter
  * Fixes issue where the code did not check for the DisplayName when the ID could not
    be found.
    FIXES [#2788](https://github.com/microsoft/Microsoft365DSC/issues/2788)
* IntuneDeviceConfigurationPolicyMacOS
  * Corrected copy/paste issue while implementing previous fix.
    FIXES [#2731](https://github.com/microsoft/Microsoft365DSC/issues/2731)
* IntuneRoleDefinition
  * Fixes issue where the code did not check for the DisplayName when the ID could not
    be found.
    FIXES [#2771](https://github.com/microsoft/Microsoft365DSC/issues/2771)
  * Updated logging logic to include more details and add Current/Target values in the
    Test method.
* PlannerTask
  * Refactored to leverage the official cmdlets instead of using the legacy GraphHandlers.
    FIXES [#2767](https://github.com/microsoft/Microsoft365DSC/issues/2767)
  * Changed Export-TargetResource to call Get-M365DSCExportContentForResource
    to simplify/conform + variables for authentication are added correctly
    FIXES [#2784](https://github.com/microsoft/Microsoft365DSC/issues/2784)
* SCRetentionCompliancePolicy
  * Fixes an issue where the SkypeLocation was trying to be converted to a string when it was an array.
    FIXES [#2789](https://github.com/microsoft/Microsoft365DSC/issues/2789)
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.20.0
  * Updated MSCloudLoginAssistant to version 1.0.103

# 1.23.111.1

* AADAdministrativeUnit
  * Marks DisplayName as a mandatory key and removed the visibility parameter from being evaluated since it is always returned as null.
  FIXES [#2704](https://github.com/microsoft/Microsoft365DSC/issues/2704)
* AADConditionalAccessPolicy
  * Removed the extra Microsoft Graph profile switching call which was causing performance issue.
    FIXES [#2688](https://github.com/microsoft/Microsoft365DSC/issues/2688)
* TeamsFederationConfiguration
  * Add parameters: TreatDiscoveredPartnersAsUnverified, SharedSipAddressSpace, RestrictTeamsConsumerToExternalUserProfiles.
* TeamsFeedbackPolicy
  * Initial Release
* TeamsGroupPolicyAssignment
  * Initial Release
* MISC
  * Adds Service Principal (Thumbprint and Secret) support to the Power Apps workload.
  * Refactored the way we are switching Microsoft Graph Profiles across all resources.
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 3.1.0
  * Updated MSCloudLoginAssistant to version 1.0.102

# 1.23.104.1

* EXODistributionGroup
  * Changed the logic retrieving the group Type in the Get-TargetResource.
    FIXES [#2709](https://github.com/microsoft/Microsoft365DSC/issues/2709)
* EXOManagementRoleAssignment
  * Modified logic to handle the RecipientOrganizationUnitScope parameter by display name.
    FIXES [#2708](https://github.com/microsoft/Microsoft365DSC/issues/2708)
* IntuneASRRulesPolicyWindows10
  * Corrects possible values for parameter OfficeCommunicationAppsLaunchChildProcess
    FIXES [#2730](https://github.com/microsoft/Microsoft365DSC/issues/2730)
* IntuneDeviceConfigurationPolicyMacOS
  * Fixes issue where parameter UpdateDelayPolicy wasn't handled as an array
    FIXES [#2731](https://github.com/microsoft/Microsoft365DSC/issues/2731)
* IntuneDeviceConfigurationPolicyWindows10
  * Fixed incorrect type of EdgeEnterpriseModeSiteListLocation parameter in the
    resource schema definition
    FIXES [#2732](https://github.com/microsoft/Microsoft365DSC/issues/2732)
* SCRetentionCompliancePolicy
  * Forces changes to existing policies to be applied.
    FIXES [#2719](https://github.com/microsoft/Microsoft365DSC/issues/2719)
  * Handles wait when the associated policy has pending changes.
    FIXES [#2728](https://github.com/microsoft/Microsoft365DSC/issues/2728)
* SCRetentionComplianceRule
  * Handles wait when the associated policy has pending changes.
    FIXES [#2728](https://github.com/microsoft/Microsoft365DSC/issues/2728)
* TeamsEmergencyCallingPolicy
  * Fixes issue where CertificateThumbprint wasn't working because Credential was set to mandatory by the Test-TargetResource function.
    FIXES [#2710](https://github.com/microsoft/Microsoft365DSC/issues/2710)
* TeamsEmergencyCallingRoutingPolicy
  * Fixes issue where CertificateThumbprint wasn't working because Credential was set to mandatory by the Test-TargetResource function.
    FIXES [#2710](https://github.com/microsoft/Microsoft365DSC/issues/2710)
* TeamsIPPhonePolicy
  * Added descriptions to the resource parameters
  * Limited possible parameter values where required
    FIXES [#2722](https://github.com/microsoft/Microsoft365DSC/issues/2722)
* TeamsMeetingPolicy
  * Deprecating RecordingStorageMode parameter, which is no longer available.
    FIXES [#2723](https://github.com/microsoft/Microsoft365DSC/issues/2723)
* TeamsShiftsPolicy
  * Added descriptions to the resource parameters
  * Limited possible parameter values where required
    FIXES [#2722](https://github.com/microsoft/Microsoft365DSC/issues/2722)
* TeamsFilesPolicy
  * Added descriptions to the resource parameters
  * Limited possible parameter values where required
    FIXES [#2722](https://github.com/microsoft/Microsoft365DSC/issues/2722)
* DRG
  * Various fixes for Graph and Intune resources automation
  * Migrated to new schema including description
  * Added support to generate parameter descriptions automatically from schema
    FIXES [#2720](https://github.com/microsoft/Microsoft365DSC/issues/2720)
* MISC
  * Fixes an issue where OrderedDictionary values weren't properly expanded in a delta report
    FIXES [#2715](https://github.com/microsoft/Microsoft365DSC/issues/2715)
  * Updated website generation code to checkout correct commit

# 1.22.1221.1

* AADGroup
  * Extraction no longer exports Distribution List or mail enabled security list since these are not supported by the Microsoft Graph API.
    FIXES [#2587](https://github.com/microsoft/Microsoft365DSC/issues/2587)
* EXOMailContact
  * Ensures all results are returned from the Export scenario. Currently limited at 1,000 results.
    FIXES [#2672](https://github.com/microsoft/Microsoft365DSC/issues/2672)
    FIXES [#2673](https://github.com/microsoft/Microsoft365DSC/issues/2672)
* EXOManagementRoleAssignment
  * Force refresh permissions after the Set-TargetResource is called to ensure the correct cmdlets are loaded in the session.
    FIXES [#2523](https://github.com/microsoft/Microsoft365DSC/issues/2523)
* SCSensitivityLabel
  * Removed the EncryptionAipTemplateScopes parameter from being evaluated in the Test and removed it from the update scenario in the Set.
    FIXES [#2205](https://github.com/microsoft/Microsoft365DSC/issues/2205)
* SCProtectionAlert
  * Initial Release
* TeamsFilesPolicy
  * Initial Release
* TeamsIPPhonePolicy
  * Initial Release
* TeamsShiftsPolicy
  * Initial Release
* MISC
  * Fixed a typo in the reporting logic that caused issue evaluating certain resources in the NEw-M365DSCDelaaReport function
    FIXES [#2685](https://github.com/microsoft/Microsoft365DSC/issues/2685)
  * Added support for the ExcludedProperties parameter in the Assert-M365DSCBlueprint function.
    FIXES [#2671](https://github.com/microsoft/Microsoft365DSC/issues/2671)
  * Updated Get-M365DSCCompiledPermissionList to output all permissions consistently.
    It can now also be used as input for Update-M365DscAzureAdApplication.
  * Fixes issue where the wrong parameter is being passed to the Erro log function.
    FIXES [#2682](https://github.com/microsoft/Microsoft365DSC/issues/2682)
  * Updated automatic website documentation generation
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.19.0;
  * Updated MSCloudLoginAssistant to version 1.0.101;

# 1.22.1214.1

* AADEntitlementManagementAccessPackageCatalogResource
  * Fixes an issue where if no access resource were defined, an error was thrown trying to save the partial content.
    FIXES [#2654](https://github.com/microsoft/Microsoft365DSC/issues/2654)
* AADGroup
  * Fixes an issue where licenses aren't properly assigned when no existing licenses exist.
    FIXES [#2597](https://github.com/microsoft/Microsoft365DSC/issues/2597)
  * Fixes an issue where if a dirft is detected and the Members parameter was omitted, all existing members were removed.
    FIXES [#2481](https://github.com/microsoft/Microsoft365DSC/issues/2481)
* AADServicePrincipal
  * Fixes an issue where the service principals weren't created or updated when using ApplicationSecret to authenticate.
    FIXES [#2615](https://github.com/microsoft/Microsoft365DSC/issues/2615)
* AADUser
  * Fixes an issue where provided password wa never honored.
    FIXES [#2599](https://github.com/microsoft/Microsoft365DSC/issues/2599)
  * Added support for the PasswordPolicies property.
    FIXES [#2598](https://github.com/microsoft/Microsoft365DSC/issues/2598)
* PlannerBucket & PlannerPlan
  * Changed invalid permissions in the setting.json files.
    FIXES [#2629](https://github.com/microsoft/Microsoft365DSC/issues/2629)
* SCRetentionComplianceRule
  * Fixed an Issue where properties weren't properly set at creation, causing drifts to be detected.
    FIXES [#2471](https://github.com/microsoft/Microsoft365DSC/issues/2471)
* SCSensitivityLabel
  * Adds the -IncludeDetailed LAbelActions switch when retrieving instances to get all advanced parameters from the Get-TargetResource function.
* SPOTenantCdnEnabled
  * Fixed an issue where the export wasn't returning anything if the CDN was not enabled.
    FIXES [#2466](https://github.com/microsoft/Microsoft365DSC/issues/2466)
* SPOUserProfileProperty
  * Removed multi-threading to align with other resources.
  * Fixed an issue where we were contacting Microsoft Graph to retrieve users without authenticating to it.
    FIXES [#2643](https://github.com/microsoft/Microsoft365DSC/issues/2643)
* TeamsChannel
  * Fixes an issue where channels weren't created if a non-existing GroupId was specified.
    FIXES [#2622](https://github.com/microsoft/Microsoft365DSC/issues/2622)
* TeamsUpdateManagementPolicy
  * Fixed error with the export that wasn't properly returning the UpdateTimeOfDay if not in short time string format.
    FIXES [#2639](https://github.com/microsoft/Microsoft365DSC/issues/2639)
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.100;
    FIXES [#2484](https://github.com/microsoft/Microsoft365DSC/issues/2484)
* MISC
  * Added support for the ExcludedProperties parameter in the New-M365DSCDeltaReport function.
    FIXES [#2444](https://github.com/microsoft/Microsoft365DSC/issues/2444)

# 1.22.1207.1

* IntuneRoleAssignment
  * Add support for ScopeType enabling the use of AllLicensedUser/AllDevice as Scope
* TeamsChannelsPolicy
  * Renamed the AllowPrivateTeamsDiscovery parameter to EnablePrivateTeamDiscovery.
* TeamsChannelTab
  * Added support for Credential and refactored to call into the Microsoft Graph PowerShell SDK directly.
* TeamsMeetingPolicy
  * Added support for several new properties:
    * AllowAnnotations
    * AllowAnonymousUsersToJoinMeeting
    * AllowMeetingCoach
    * AllowMeetingRegistration
    * AllowNetworkConfigurationSettingsLookup
    * AllowWatermarkForCameraVideo
    * AllowWatermarkForScreenSharing
    * NewMeetingRecordingExpirationDays
    * AllowCartCaptionsScheduling
    * AllowDocumentCollaboration
    * AllowedStreamingMediaInput
    * BlockedAnonymousJoinClientTypes
    * ChannelRecordingDownload
    * ExplicitRecordingConsent
    * ForceStreamingAttendeeMode
    * InfoShownInReportMode
    * LiveInterpretationEnabledType
    * LiveStreamingMode
    * MeetingInviteLanguages
    * QnAEngagementMode
    * RoomPeopleNameUserOverride
* SPOBrowserIdleSignout
  * Fixed incorrect Ensure parameter being added to the Export
    FIXES [#2619](https://github.com/microsoft/Microsoft365DSC/issues/2619)
* SPOSiteAuditSettings
  * Fixed incorrect Ensure parameter being added to the Export
    FIXES [#2619](https://github.com/microsoft/Microsoft365DSC/issues/2619)
* MISC
  * Standardized and improved logging across all resources.
  * Improved error handling in creating output when permissions are not correct.
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.18.0;

# 1.22.1130.1

* SCRetentionCompliancePolicy
  * Fixed an issue with the Update logic in the Set-TargetResource
    FIXES [#2600](https://github.com/microsoft/Microsoft365DSC/issues/2600)

# 1.22.1123.1

* IntuneDeviceConfigurationPolicyWindows10
  * Fixed issue when creating this resource if property DefenderDetectedMalwareActions was not present, it'd still be created but with errors.
    FIXES [#2581](https://github.com/microsoft/Microsoft365DSC/issues/2581)
* AADUser
  * Fixed issue with license assignment
    FIXES [#2556](https://github.com/microsoft/Microsoft365DSC/issues/2556)
* EXOOrganizationRelationship
  * Add 'None' as supported value for MailboxMoveCapability
    FIXES [#2570](https://github.com/microsoft/Microsoft365DSC/issues/2570)
* IntuneRoleDefinition
  * Initial Release
  * Manage Intune Role definition
* IntuneRoleAssignment
  * Initial Release
  * Manage Intune Role assignment
* O365AdminAuditLogConfig
  * Updated settings.json to include permissions.
    FIXES [#2517](https://github.com/microsoft/Microsoft365DSC/issues/2517)
* O365OrgCustomizationSetting
  * Updated settings.json to include permissions.
    FIXES [#2517](https://github.com/microsoft/Microsoft365DSC/issues/2517)
* SCDLPCompliancePolicy
  * Fixes an issue where the Exchange Location and Exception where not sent back in a correct format during Export.
    FIXES [#2545](https://github.com/microsoft/Microsoft365DSC/issues/2545)
* SCRetentionCompliancePolicy
  * Fixes issue with the TeamsChannelLocation and TeamsChatsLocation parameters that were improperly returned by the Get- function.
    FIXES [#2472](https://github.com/microsoft/Microsoft365DSC/issues/2472)
* SCRetentionComplianceRule
  * Fixes issue with Teams Policy where the RetentionDurationDisplayHint and ExpirationDateOption parameters weren't returned by the Get- function.
    FIXES [#2472](https://github.com/microsoft/Microsoft365DSC/issues/2472)
* TeamsFederationConfiguration
  * Fixes an issue where the extraction of allowed domain and blocked domain wasn't in the proper format.
    FIXES [#2576](https://github.com/microsoft/Microsoft365DSC/issues/2576)
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.17.0;
  * Updated MSCloudLoginAssistant to version 1.0.98;
* MISC
  * Removed Test-M365DSCDependenciesForNewVersions from export functions. This will improve export speed.
  * New Parameter `ValidateOnly` for Update-M365DSCDependencies to check if all dependencies are installed.
    FIXES [2519](https://github.com/microsoft/Microsoft365DSC/issues/2519)
  * Fixed incorrect usage of Write-Information cmdLet
  * Fixed typos for permissions in settings.json
    FIXES [2553](https://github.com/microsoft/Microsoft365DSC/issues/2553)

# 1.22.1116.1

* AADApplication
  * Deprecated the Oauth2RequirePostResponse parameter as it was causing issues for the New function.
    FIXES [#2276](https://github.com/microsoft/Microsoft365DSC/issues/2276)
* AADEntitlementManagementAccessPackage
  * Initial Release.
* EXOManagementRoleAssignment
  * Added support for RoleGroup Role Assignees
    Fixes [#2524](https://github.com/microsoft/Microsoft365DSC/issues/2524)
* SCRetentionCompliancePolicy
  * Fixes the Location parameters to be a string array instead of an object array.
    FIXES [#2503](https://github.com/microsoft/Microsoft365DSC/issues/2503)
* MISC
  * Added Application based authentication to Microsoft Teams resources;
  * Added support for Service Principal Auth for the Planner resources;
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.16.0;
  * Updated Microsoft.Teams to version 4.9.1;
  * Updated PnP.PowerShell to version 1.12.0;

# 1.22.1109.1

* EXODataClassification
  * FIXES [#2487](https://github.com/microsoft/Microsoft365DSC/issues/2487)
* EXOHostedOutboundSpamFilterPolicy
  * Add support to create and remove Hosted Outbound Spam Filter Policies
  * FIXES [#2492](https://github.com/microsoft/Microsoft365DSC/issues/2492)
* IntuneAntivirusPolicyWindows10SettingCatalog
  * FIXES [#2463](https://github.com/microsoft/Microsoft365DSC/issues/2463)
  * Returns all type of policies from the template family: endpointSecurityAntivirus
* MISC
  * Fixes and issue with ManagedIdentity Parameter not being not removed correctly in a parameterset.
    * FIXES [#2464](https://github.com/microsoft/Microsoft365DSC/issues/2464)
* DEPENDENCIES
  * Updated Microsoft.Graph.* to version 1.15.0;

# 1.22.1102.1

* AADAdministrativeUnit
  * Initial Release.
* AADEntitlementManagementAccessPackageCatalogResource
  * Initial release;
* DEPENDENCIES
  * Updated MicrosoftTeams to version 4.9.0;
  * Updated MSCloudLoginAssistant to version 1.0.97;

# 1.22.1026.2

* MISC
  * Fixes an issue with the export where the ApplicationSecret was throwing an empty string error when trying to authenticate with Certificate thumbprint.
    * FIXES [#2455](https://github.com/microsoft/Microsoft365DSC/issues/2455)

# 1.22.1026.1

* AADEntitlementManagementAccessPackageCatalog
  * Initial release;
* EXOIntraOrganizationConnector
  * Add TargetSharingEpr parameter
* EXOOwaMailboxPolicy
  * Add 10 new parameters
* EXOTransportRule
  * Add new parmeters: ApplyRightsProtectionCustomizationTemplate, Quarantine, RecipientAddressType, RemoveRMSAttachmentEncryption
  * Deprecated parameters: ExceptIfMessageContainsAllDataClassifications, IncidentReportOriginalMail,MessageContainsAllDataClassifications
* TeamsDialInConferencingTenantSettings
  * Initial release;
    Fixes [#2426](https://github.com/microsoft/Microsoft365DSC/issues/2426)
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.96;
* MISC
  * Add support for ManagedIdentity to the SPO and OD resources.
  * Fixed and issue with Export and ApplicationSecret where it wasn't properly converting to a PSCredential.
    * FIXES [#2447](https://github.com/microsoft/Microsoft365DSC/issues/2447)

# 1.22.1019.1

* AADConditionalAccessPolicy
  * Fixed issue where if ExcludePlatforms was specified and the IncludePlatforms is empty, we need to set the latest to 'all';
  FIXES [#2337](https://github.com/microsoft/Microsoft365DSC/issues/2337)
* EXOAntiPhishPolicy
  * Add new parameters: MailboxIntelligenceQuarantineTag, SpoofQuarantineTag, TargetedDomainQuarantineTag, TargetedUserQuarantine
* EXOHostedContentFilterPolicy
  * Add support for quarantine tags
* EXOOrganizationRelationship
  * Add support for new cross-tenant mailbox migration parameters: MailboxMoveCapability, MailboxMovePublishedScopes, OauthApplicationId
* EXOOutboundConnector
  * Add support for SenderRewritingEnabled parameter
* EXORemoteDomain
  * Add NDREnabled parameter
* EXOSafeAttachmentPolicy
  * Add support for QuarantineTag
* EXOSafeLinksPolicy
  * Add new parameters: AllowClickThrough, EnableSafeLinksForOffice, TrackClicks
* TeamsCallingPolicy
  * Add new parameters: AllowCallRedirect, AllowSIPDevicesCalling, CallRecordingExpirationDays
* TeamsEmergencyCallingPolicy
  * Add new parameters: EnhancedEmergencyServiceDisclaimer, ExternalLocationLookupMode
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.154.
* MISC
  * Added support to register, list and remove custom notification endpoints.
  * Fixes issue with delta report where wrong primary key was detected.
    FIXES [#2008](https://github.com/microsoft/Microsoft365DSC/issues/2008)
  * Fixed an issue where the log engine was throwing an error when trying to write to the event log from an Azure runbook.
    FIXES [#2236](https://github.com/microsoft/Microsoft365DSC/issues/2236)
  * Standardizing the functions to test versions of the module and dependencies.
    FIXES [#2232](https://github.com/microsoft/Microsoft365DSC/issues/2232)
  * Remove the Assert-M365DSCTemplate cmdlet that has been deprecated for several releases.
  * Added support to generate report in JSON format for the New-M365DSCDeltaReport and Assert-M365DSCBlueprint cmdlets.
    FIXES [#2345](https://github.com/microsoft/Microsoft365DSC/issues/2345)
  * Changed the default behavior of the New-M365DSCDeltaReport cmdlet not to automatically open the file when OutputPath is provided

# 1.22.1012.1

* EXOManagementRoleAssignment
  * Initial Release
  FIXES [#2355](https://github.com/microsoft/Microsoft365DSC/issues/2355)
  FIXES [#2356](https://github.com/microsoft/Microsoft365DSC/issues/2356)
* SCRetentionCompliancePolicy
  * Fixed issue where the locations weren't properly returned.
  FIXES [#2338](https://github.com/microsoft/Microsoft365DSC/issues/2338)
  FIXES [#2339](https://github.com/microsoft/Microsoft365DSC/issues/2339)
* TeamsOnlineVoicemailPolicy
  * Initial Release
* TeamsOnlineVoicemailUserSettings
  * Initial Release
* TeamsOnlineVoiceUser
  * Initial Release
* TeamsUserCallingSettings
  * InitialRelease
* EXOOrganizationConfig
  * Added 35 new parameters.
  * Set AllowPlusAddressInRecipients parameter to deprecated. Use DisablePlusAddressInRecipients instead.
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 1.13.0.
  * Updates MicrosoftTeams to version 4.8.0;
  * Updated ReverseDSC to version 2.0.0.13;
  FIXES [#2270](https://github.com/microsoft/Microsoft365DSC/issues/2270)
* MISC
  * EXO Workload
    * Add support for Managed Identity authentication
  * Fixed an issue in in Export-M365DSCConfiguration when used with Service Principal
    FIXES [2374](https://github.com/microsoft/Microsoft365DSC/issues/2374)
    FIXES [2379](https://github.com/microsoft/Microsoft365DSC/issues/2379)
  * Added support for Exchange to the Update-M365DSCAzureAdApplication cmdlet
  * Fixes an issue where filters were ignored on export when specifying the Workloads parameter.

# 1.22.1005.1

* AADUser
  * Renamed from O365User
  * Added support for Roles.
    FIXES [#2288](https://github.com/microsoft/Microsoft365DSC/issues/2288)
* AADGroup
  * Added properties MemberOf and AssignedToRole
    Implements [#2301](https://github.com/microsoft/Microsoft365DSC/issues/2301)
* AADTenantDetails
  * Fixed an issue where ApplicationSecret was send to Update-MgOrganization
  * FIXES [[#2340](https://github.com/microsoft/Microsoft365DSC/issues/2340)]
* EXOATPPolicyForO365
  * [BREAKING] Removed the deprecated BlockURLs, AllowClickThrough, EnableSafeLinksForO365Clients and TrackClicks parameters.
* EXOMailContact
  * Initial Release.
* EXOMailTips
  * Fixes an issue where MailTips weren't extracted when using CertificateThumbprint to authenticate.
    FIXES [#2235](https://github.com/microsoft/Microsoft365DSC/issues/2235)
* O365User
  * [BREAKING] Resource was renamed to AADUser.
    FIXES [#2204](https://github.com/microsoft/Microsoft365DSC/issues/2204)
* IntuneDeviceConfigurationPolicyiOS
  * [Breaking] Changed all the MediaContentRating properties to be CIMInstances.
    FIXES [#1871](https://github.com/microsoft/Microsoft365DSC/issues/1871)
* SCSensitivityLabel
  [BREAKING] Changed Setting attribute in MSFT_SCLabelLocaleSettings to LabelSetting since its resevered word and breaking reporting.
    FIXES #2314
* MISC
  * [BREAKING] Authentication property ApplicationSecret has been changed across all resources to be of type
    PSCredential instead of string. This will ensure that the secrets get encrypted in MOF files
    when compiling with an encryption certificated instead of being exposed as plaintext.
    FIXES [#1714](https://github.com/microsoft/Microsoft365DSC/issues/1714)
  * Fixes issue with DSCParser non-existing resources on one tenant weren't properly captured.
* DEPENDENCIES
  * Updated Microsoft.Graph dependencies to version 1.12.3.
  * Updated MSCloudLoginAssistant dependency to version 1.0.94.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.153.
  * Added new dependency on Microsoft.Graph.Users.Actions.

# 1.22.921.1

* AADRoleSetting
  * Fixed an issue if the P2 License is not present on the tenant the Export stop working
    FIXES [#2227](https://github.com/microsoft/Microsoft365DSC/issues/2227)
  * Fixed an issue with approver can be a group
    FIXES [#2283](https://github.com/microsoft/Microsoft365DSC/issues/2283)
* AADConditionalAccessPolicy
  * Added support for the CustomAuthenticationFactors parameter.
  FIXES [#2292](https://github.com/microsoft/Microsoft365DSC/issues/2292)
* O365User
  * Improved extraction performance by leveraging StringBuilder instead of re-assigning string.
* SCAutoSensitivityLabelPolicy
  * Initial Release.
* SCAutoSensitivityLabelRule
  * Initial Release.
* DEPENDENCIES
  * Updated the ExchangeOnlineManagement dependency to version 3.0.0.
  * Updated the MSCloudLoginAssistant dependency to version 1.0.89.

# 1.22.914.1

* AADGroup
  * Changed behavior where if a group has a dynamic membership rule that is active,
    we no longer process members from the export, Get and Set functions.
    FIXES [#2190](https://github.com/microsoft/Microsoft365DSC/issues/2190)
  * Fixed an issue where if the licenses parameter was omitted and another parameter caused
    a drift, that the licenses would get stripped from the group.
    FIXES [#2191](https://github.com/microsoft/Microsoft365DSC/issues/2191)
* AADRoleSetting
  * Fixed an issue where the export wasn't properly passing credential to the Get function.
* TeamsCallingPolicy
  * Added UserOverride as an accepted value for the BusyOnBusyEnabledType parameter.
  FIXES [#2271](https://github.com/microsoft/Microsoft365DSC/issues/2271)

# 1.22.907.1

* EXODistributionGroup
  * Fixes warning issue regarding OrganizationalUnit property
    FIXES [#2252]
* SCRetentionCompliancePolicy
  * Fixes an issue where the TeamsChatLocation, TeamsChatLocationException, TeamsChannelLocation
    and TeamsChannelLocationException properties were not properly set on Update.
    FIXES #2173
* SCRetentionComplianceRule
  * Fixes an issue when trying to create new compliance rule for Teams based policies where invalid
    parameters were passed.
    FIXES #2181
* DEPENDENCIES
  * Updated MicrosoftTeams dependency to version 4.7.0.
* MISC
  * Update settings.json for all SharePoint resources to add SharePoint specific permissions
    FIXES [#2240]
  * Updated website pages with new information (cmdlet and resource documentation)

# 1.22.831.1

* EXOAddressList
  * Ignore precanned filters if recipient filter is used. Precanned filters and recipient filter cannot be used at the same time.
    FIXES [#2194](https://github.com/microsoft/Microsoft365DSC/issues/2194)
* EXOSafeLinksPolicy
  * Add Support for EnableSafeLinksForEmail and DisableUrlRewrite
* EXOInboundConnector
  * Add support for different syntax of SenderDomains parameter
  FIXES [#2180](https://github.com/microsoft/Microsoft365DSC/issues/2180)
* IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator
  * Don't export all policies if none match the type
* IntuneDeviceConfigurationPolicyAndroidOpenSourceProject
  * Don't export all policies if none match the type
  FIXES [#2228](https://github.com/microsoft/Microsoft365DSC/issues/2228)
* PlannerBucket
  * Changed authentication method to Credentials only, since the Planner Graph API
    does not support anything else
  FIXES [#1979](https://github.com/microsoft/Microsoft365DSC/issues/1979)
  * Fixes issue with generating Export output
  FIXES [#2032](https://github.com/microsoft/Microsoft365DSC/issues/2032)
* PlannerPlan
  * Fix export issue where the export wasn't created correctly because of the
    use of an incorrect property name.
  * Changed authentication method to Credentials only, since the Planner Graph API
    does not support anything else
  FIXES [#1979](https://github.com/microsoft/Microsoft365DSC/issues/1979)
* PlannerTask
  * Changed authentication method to Credentials only, since the Planner Graph API
    does not support anything else
  FIXES [#1979](https://github.com/microsoft/Microsoft365DSC/issues/1979)
* TeamsMeetingBroadcastConfiguration
  * Fixing export issue where SdnApiToken is exported as a string instead of
    a variable
  FIXES [#2056](https://github.com/microsoft/Microsoft365DSC/issues/2056)
* MISC
  * Updated Export functionality to only export the LCM settings when the
    executed as Administrator
  FIXES [#2037](https://github.com/microsoft/Microsoft365DSC/issues/2037)
  * Added support for multiple authentication methods to the Export functionality.
    The code now uses the most secure method that is provided in the command line
    and that supported by the specified resources in the following order:
    Certificate Thumbprint, Certificate Path, Application Secret, Credential
  FIXES [#1759](https://github.com/microsoft/Microsoft365DSC/issues/1759)
* MISC
  * Fix issue of running Export-M365DSCConfiguration within Azure Run Book. FIXES [#2233](https://github.com/microsoft/Microsoft365DSC/issues/2233)
  * Fix issue within M365DSCTelemetryEngine when used with ApplicationId. FIXES [#2237](https://github.com/microsoft/Microsoft365DSC/issues/2237)

# 1.22.824.1

* AADApplication
  * Fixed issue where Update-MgApplication could be called with parameter ReplyURLs which is invalid.
  * Added support to export/import app owners.
* EXOTransportRule
  * Fix issue setting IncidentReportContent
  FIXES [#2196](https://github.com/microsoft/Microsoft365DSC/issues/2196)
* O365User
  * Optimize, call Get-MgSubscribedSku only once instead of inside of two loops per each user/license.
* SPOSiteGroup
  * Avoid redefining SiteGroupSettings always to the same value, just define it once, and call it as is on Set-PnPGroup.
  * To keep the same order of updating the group and then its permissions check on which conditions it needs to be updated and at the end call Set-PnPGroup then Set-PnPGroupPermissions.
  * Fix typo in variable, not an issue right now but the group would always be updated even if name and owner were already correct.
* DEPENDENCIES
  * Updated DSCParser dependency to version 1.3.0.6.
  * Updated Microsoft.Graph dependencies to version 1.11.1.
  * Updated ReverseDSC dependency to version 2.0.0.12.
* MISC
  * Fixed issue with Export-M365DSCConfiguration if all components were invalid or if resource files were not found.
  * Updated MicrosoftTeams to version 4.6.0.
* AADRoleSetting
  * New Resource, configure Azure PIM Role like in the UI

# 1.22.727.1

* AADConditionalAccessPolicy
  * DEPRECATED then IncludeDevices and ExcludeDevices parameters.
  * Fixed issue extracting a policy that had invalid users or groups (deleted from AAD).
  FIXES [#2151](https://github.com/microsoft/Microsoft365DSC/issues/2151)
* EXOTransportRule
  * Fixed issue where the MessageContainsDataClassifications property was not properly extracted due to single quote exiting.
  FIXES [#1820](https://github.com/microsoft/Microsoft365DSC/issues/1820)
* IntuneAppProtectionPolicyAndroid
  * Added Configuration Parameters:
    ManagedBrowser
    MinimumRequiredAppVersion
    MinimumRequiredOSVersion
    MinimumRequiredPatchVersion
    MinimumWarningAppVersion
    MinimumWarningOSVersion
    MinimumWarningPatchVersion
    AppGroupType
    IsAssigned
    FIXES [#1955](https://github.com/microsoft/Microsoft365DSC/issues/1955)
* IntuneDeviceConfigurationPolicyWindows10
  * Fixed issue where the edgeSearchEngine value was not properly retrieved.
  FIXES [#1783](https://github.com/microsoft/Microsoft365DSC/issues/1783)
* SCSensitivityLabel
  * Fixed an issue where '$' in the custom wordmark test would cause issue.
  FIXES [#2067](https://github.com/microsoft/Microsoft365DSC/issues/2067)
* SPOSite
  * Fixed owner value for root site.
  FIXES [#2035](https://github.com/microsoft/Microsoft365DSC/issues/2035)
* TeamsEventsPolicy
  * Initial release.
* TeamsUser
  * Fixed the extraction process and removed the multi-threading from the resource.
  FIXES #1883
* DEPENDENCIES
  * Updated MicrosoftTeams to version 4.6.0.
* MISC
  * Added support for filtering resources instances at extraction time.
  FIXES [#1691](https://github.com/microsoft/Microsoft365DSC/issues/1691)
  * REPORT: Fixed an issue where if the ModuleVersion was not specified, that the file would fail to properly get parsed.
  FIXES [#1970](https://github.com/microsoft/Microsoft365DSC/issues/1970)
  * Resources implementing the Ensure parameter now defaults its value to $true.
  FIXES [#1738](https://github.com/microsoft/Microsoft365DSC/issues/1738)

# 1.22.720.1

* EXOTransportRule
  * Fixed issue where the MessageContainsDataClassifications property was not properly extracted due to single quote exiting.
  FIXES [#1820](https://github.com/microsoft/Microsoft365DSC/issues/1820)
* IntuneDeviceConfigurationPolicyWindows10
  * Fixed issue where the edgeSearchEngine value was not properly retrieved.
  FIXES [#1783](https://github.com/microsoft/Microsoft365DSC/issues/1783)
* SCSensitivityLabel
  * Fixed an issue where '$' in the custom wordmark test would cause issue.
  FIXES [#2067](https://github.com/microsoft/Microsoft365DSC/issues/2067)
* SPOSite
  * Fixed owner value for root site.
  FIXES [#2035](https://github.com/microsoft/Microsoft365DSC/issues/2035)
* TeamsUser
  * Fixed the extraction process and removed the multi-threading from the resource.
  FIXES #1883
* MISC
  * Added support for filtering resources instances at extraction time.
  FIXES [#1691](https://github.com/microsoft/Microsoft365DSC/issues/1691)
  * REPORT: Fixed an issue where if the ModuleVersion was not specified, that the file would fail to properly get parsed.
  FIXES [#1970](https://github.com/microsoft/Microsoft365DSC/issues/1970)
  * Resources implementing the Ensure parameter now defaults its value to $true.
  FIXES [#1738](https://github.com/microsoft/Microsoft365DSC/issues/1738)

# 1.22.720.1

* AADAuthorizationPolicy
  * Fixed issue with the DefaultUserRolePermissionGrantPoliciesAssigned property.
* AADGroup
  * Added support for Group Licensing by adding the AssignedLicenses property.
  * Added support for members and owners.
  FIXES [#1066](https://github.com/microsoft/Microsoft365DSC/issues/1066)
* EXOCASMailboxSettings
  * Fixed issue if there are mailboxes with the same name
  FIXES [#2117](https://github.com/microsoft/Microsoft365DSC/issues/2117)
* EXODistributionGroup
  * Initial release.
  FIXES [#1802](https://github.com/microsoft/Microsoft365DSC/issues/1802)
* EXOMalwareFilterPolicy
  * DEPRECATED parameter CustomAlertText.
* IntuneAntivirusPolicyWindows10SettingCatalog
  * Initial release.
* IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager
  * Initial release.
* IntuneDeviceCompliancePolicyWindows10
  * Switched to using the beta profile in order to aapture all parameters.
  FIXES [#1998](https://github.com/microsoft/Microsoft365DSC/issues/1998)
* IntuneDeviceConfigurationPolicyWindows10
  * Fixed issue where the value for the DefenderDetectedMalwareActions property wasn't properly handled.
  FIXES [#1479](https://github.com/microsoft/Microsoft365DSC/issues/1479)
* IntuneExploitProtectionPolicyWindows10SettingCatalog
  * Initial release.
* O365OrgCustomizationSetting
  * Added a warning to let users know the changes can take up to 24 hours to be reflected
  FIXES [#1599](https://github.com/microsoft/Microsoft365DSC/issues/1599)
* PPTenantSettings
  * Fixed the way parameters are passed to the Set-TenantSettings cmdlet.
  FIXES [#1914](https://github.com/microsoft/Microsoft365DSC/issues/1914)
* TeamsTenantDialPlan
  * Fixed an issue where the Normalization Rules strings were not properly exited.
    FIXES [#2096](https://github.com/microsoft/Microsoft365DSC/issues/2096)
* TeamsUpdateManagementPolicy
  * Changed the format of the UpdateTimeOfDay parameter to not include date as part of an export.
    FIXES [#2062](https://github.com/microsoft/Microsoft365DSC/issues/2062)
* MISC
  * PowerPlatform: Standardized authentication on Credential and dropped support for Service Principal across resources.
  FIXES [#1979](https://github.com/microsoft/Microsoft365DSC/issues/1979)
  * EXPORT: Changed the way resources' modules are imported to improve startup performance.
  FIXES [#1745](https://github.com/microsoft/Microsoft365DSC/issues/1745)
  * Added a new Test-M365DSCModuleValidity cmdlet.
  * Updated the Uninstall-M365DSCOutdatedDependencies cmdlet to delete module files.

# 1.22.713.1

* AADAuthorizationPolicy
  * Initial release.
* AADConditionalAccessPolicy
  * Fixed issue for Included and Excluded properties where the last instance couldn't be removed.
    FIXES [#2058](https://github.com/microsoft/Microsoft365DSC/issues/2058) & [#2079](https://github.com/microsoft/Microsoft365DSC/issues/2079)
* EXOATPPolicyForO365
  * Deprecated properties AllowClickThrough, EnableSafeLinksForO365Clients & TrackClicks.
* EXOAuthenticationPolicyAssignment
  * Initial release.
* EXOCASMailboxSettings
  * New resource to configure Exchange Online CAS Mailbox settings.
* EXOSafeLinksPolicy
  * Deprecated properties DoNotAllowClickThrough, DoNotTrackUserClicks & IsEnabled.
* IntuneAppProtectionPolicyiOS
  * Fixed issue with creation a new policies where it was complaining about invalid minimum versions.
  * Fixed issues where creating new policies threw an error complaining about an invalid duration format.
     FIXES [#2019](https://github.com/microsoft/Microsoft365DSC/issues/2019)
  * Added the CustomBrowserProtocol parameters.
     FIXES [#2009](https://github.com/microsoft/Microsoft365DSC/issues/2009)
* IntuneDeviceAndAppManagementAssignmentFilter
  * Initial release.
* SCComplianceTag
  * Fixed issue where FilePlanProperty was not properly applied unless another child property was also modified.
* SPOSharingSettings
  * Updated code to remove None as valid value for DefaultLinkPermission. If value is set to None default to Edit.
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.150.
  * Updated MSCloudLoginAssistant to version 1.0.87.
* MISC
  * Made the Compare-M365DSCConfigurations cmdlet public.

# 1.22.706.1

* AADSecurityDefaults
  * Initial release.
* TeamsFederationConfiguration
  * Added support for the AllowedDomains and BlockedDomains properties.
* TeamsVoiceRoutingPolicy
  * Remove unsupported Confirm parameter from Remove-CsOnlineVoiceRoutingPolicy cmdlet (Confirm parameter is no longer available for MicrosoftTeams PowerShell module 4.4.1+).
    FIXES #2055
* DEPENDENCIES
  * Updated MicrosoftTeams to version 4.5.0.
  * Updated Pnp.PowerShell to version 1.11.0.

# 1.22.629.1

* EXOMalwareFilterPolicy
  * Parameters Action, EnableExternalSenderNotifications and EnableInternalSenderNotifications are deprecated and will be removed in future. These parameters are no longer available in EXO, only in onprem Exchange. Please remove these parameters from your configuration.
  FIXES #2025
  * Added support for FileTypeAction parameter.
* EXOSharedMailbox
  * Fix using umlauts in displayname by allowing to set alias.
    FIXES #1921
  * Rename parameter Aliases to EmailAddresses. Aliases is now deprecated.
* DEPENDENCIES
  * Updated DSCParser to version 1.3.0.5
  * Updated Microsoft.Graph.* modules to version 1.10.0.
  * Updated MSCloudLoginAssistant to version 1.0.86.
    Fixes two authentication issues: #2000 and #2007
* MISC
  * New Delta Report: removed mandatory restrictions on the OutputPath parameter.
    FIXES #2029

# 1.22.622.1

* TeamsMessagingPolicy
  * Removed the -force deprecated parameter on New/Set/Remove
* MISC
  * Modified the dependency installation functions to for the AllUsers scope.

# 1.22.615.1

* EXODataClassification
  * Added example
* EXODataEncryptionPolicy
  * Added example
* MISC
  * Added cmdlet (Update-M365DSCAzureAdApplication) to create and manage a
    custom service principal which can be used within Microsoft365DSC
    configurations
  * Extended the permissions in the settings.json file to include delegated,
    application and Exchange permissions
  * Updated Get-M365DSCCompiledPermissionList to include the new permissions in the
    settings.json file
  * Added cmdlet to generate the resource pages on the microsoft365dsc.com website
  * Checked and updated the readme.md files of all resources to make them consistent
    and usable by the new documentation cmdlet
  * Corrected documentation issues on the microsoft365dsc.com website
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.148;

# 1.22.608.1

* AADConditionalAccessPolicy
  * Updated settings.json with missing permissions
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to 1.0.85;
* MISC
  * Updated permissions for SharePoint and OneDrive in settings.json files.

# 1.22.601.1

* DEPENDENCIES
  * Updated MicrosoftTeams to version 4.4.1

# 1.22.525.1

* IntuneASRRulesPolicyWindows10
  * Initial release;
* PPowerAppsEnvironment
  * Fixed issue on export to exclude EnvironmentTypes of Notspecified and Developer
  * Updated validation set of EnvironmentTypes to latest values
* DEPENDENCIES
  * Updated MSCloudLoginAssistant module to version 1.0.84.
* MISC
  * Fixed issue in generating a Delta report, where the Resource names were also
    compared, which in case of an export are generated GUIDs.
  * Fixed issue where empty strings or arrays would result in a Delta reports
    with drifted parameters, even though both configs are empty.
  * Added logic to New-M365DSCDeltaReport to check if the files specified in the
    Source, Destination and HeaderFilePath parameters actually exist.
  * Fixed issue where Excel wasn't closed after creating the report.

# 1.22.518.1

* AADConditionalAccessPolicy
  * Fixed export to remove the DeviceFilterMode property
    when empty.
* EXODataClassification
  * Initial release
* EXODataEncryptionPolicy
  * Initial release
* PPTenantIsolationSettings
  * Fixed an issue where credentials weren't passed properly
    during the export.
* SPOSharingSettings
  * Decoupling from SPOSharingSettings: add SharingCapability for "-my sites" aka: OneDrive

# 1.22.511.1

* AADNamedLocationPolicy
  * Added error handling in the Get-TargetResource function.
* EXOIRMConfiguration
  * Initial release.
* EXOMessageClassification
  * Initial release.
* EXOOMEConfiguration
  * Initial release.
* EXOOwaMailboxPolicy
  * Fix where the update scenario was not setting the proper
    values. (FIXES #1868)
* EXOPerimeterConfiguration
  * Initial release.
* EXOResourceConfiguration
  * Initial release.
* IntuneApplicationControlPolicyWindows10
  * Initial release.
* TeamsUpdateManagementPolicy
  * Initial release.
* DEPENDENCIES
  * Updated Microsoft.Graph.* modules to version 1.9.6.
  * Updated ReverseDSC to version 2.0.0.11.
* MISC
  * Updated permissions for SharePoint in settings.json files.
  * Added links to documentation to Teams Readme files
  * Added and corrected some Exchange examples
  * Added progress indicator to the Report generation

# 1.22.504.1

* EXOInboundConnector
  * Added support for EFSkipIPs, EFSkipLastIP and EFUsers properties. (FIXES #1917)
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.147.
  * Updated MicrosoftTeams to version 4.3.0.

# 1.22.427.1

* AADApplication
  * Fix for Permissions with 'Role,Scope' types.
* EXOAuthenticationPolicy
  * Fix schema.mof file (FIXES #1896)
* IntuneAppProtectionPolicyAndroid
  * New resource - (fixes issue #1900 and #1432)
* IntuneAppProtectionPolicyiOS
  * Fixes #1877
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.146.
* MISC
  * Performance updates when doing exports (using StringBuilder over
    appending to string).

# 1.22.420.1

* EXOOutboundConnector
  * Added support for test mode connectors.

# 1.22.413.1

* EXOAuthenticationPolicy
  * Fix typo in AllowBasicAuthOfflineAddressBook (FIXES #1876)
* EXOQuarantinePolicy
  * New resource
* O365Groups
  * Fixed issue on export of O365Groups resource.
* DEPENDENCIES
  * Updated Microsoft.Graph.* to 1.9.5.
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.145.
  * Updated MicrosoftTeams to 4.2.0.

# 1.22.406.1

* EXOMalwareFilterPolicy
  * Add support for property QuarantineTag
* PPTenantIsolationSettings
  * New resource
* MISC
  * Updated Convert-M365DscHashtableToString function to also convert
    Arrays and CimInstances to string.
  * Updated permissions in settings.json files.
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.144.
  * Updated MicrosoftTeams to 4.1.0.
  * Updated PnP.PowerShell to 1.10.0.

# 1.22.323.1

* EXOAuthenticationPolicy
  * Initial release;
* EXOOrganizationConfig
  * Added support for CustomerLockboxEnabled and DisablePlusAddressInRecipients parameters.
    FIXES #1831

# 1.22.316.1

* EXOCASMailboxPlan
  * Add support for DisplayName as identifier for CAS mailbox plan.
* EXOTransportSettings
  * New resource for Exchange Online transport configuration.
* IntuneAppProtectionPolicyiOS
  * Add 7 additional parameters to the resource and added parameter
    descriptions.
* DEPENDENCIES
  * Updated DSCParser to 1.3.0.4.
  * Updated Microsoft.Graph.* to 1.9.3.

# 1.22.309.1

* EXOAcceptedDomain
  * Fixes an issue where True was never accepted as a value for parameters
    MatchSubDomains or OutboundOnly.
    FIXES #1779
* EXOMailboxPlan
  * New resource for Exchange Online Mailbox Plans.
* EXOOrganizationConfig
  * Fixes an issue where AutoExpandingArchiveEnabled returned always False.
    FIXES #1789
* IntuneDeviceConfigurationPolicyAndroidDeviceOwner
  * Initial release.
* O365Group
  * Revamped to use Microsoft Graph in the Set;
* TeamsChannel
  * Fix to retrieve the team name without URL encoding.
* TeamsFederationConfiguration
  * New resource for Teams Federation Configuration.
* TeamsTeam
  * Fixed issue where teams were not created when no owners were specified.
    If credentials are used, then the user will be used as owner.
* DEPENDENCIES
  * Updated DSCParser to version 1.3.0.3.
  * Updated MicrosoftTeams to version 4.0.0.
* MISC
  * Added a function to uninstall all outdated dependencies
    and older versions of Microsoft365DSC;
  * M365DSCReport: Adds JSON as an export option.

# 1.22.216.1

* DEPENDENCIES
  * Updated ReverseDSC to version 2.0.0.10.
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.142.

# 1.22.209.1

* TeamsChannel
  * Fix to allow channels to be extracted properly when two Teams
    have the same name.
    FIXES #1746
* DEPENDENCIES
  * Updated MicrosoftTeams to version 3.1.1;
* MISC
  * Fixed an issue with the Export where the Configuration Data file
    always referenced a certificate file even when none were configured.
    FIXES #1724

# 1.22.202.1

* IntuneAppProtectionPolicyiOS
  * Fixes an issue where an error was thrown when no ExcludedGroups
    were specified.
    FIXES #1719
* MISC
  * Documentation updates

# 1.22.126.1

* TeamsTenantDialPlan
  * Fixed an issue where the Export only extracted the first
    normalization rule.
    FIXES #1695
* DEPENDENCIES
  * Updated all Microsoft.Graph * to 1.9.2;
  * Updated Microsoft.Teams to version 3.1.0;
* MISC
  * Update automatic cmdlet documentation generation functions and prereqs.
  * Adding cmdlet documentation to website
  * Fixed an issue with the Export-M365DSCConfiguration cmdlet where it
    would throw an error if no parameters were passed.

# 1.22.119.2

* EXOOrganizationConfig
  * Fixed issue where the name of the parameter in the module and
    in the schema differed;
    FIXES #1689

# 1.22.119.1

* EXOOrganizationConfig
  * Added support for the new SendFromAliasEnabled parameter;
* EXORoleAssignmentPolicy
  * Fixed logic to update roles assigned to an existing policy;
    FIXES #1538
MISC
  * Updated logic for Report generation so that it no longer requires the
    same module version as defined in the configuration installed on the
    system where the report is being generated from.

# 1.22.112.1

* TeamsMeetingPolicy
  * Added support for property WhoCanRegister;
    FIXES #1483
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to 1.0.83;

# 1.22.105.1

* AADNamedLocationPolicy
  * Throw meaningful error if multiple policies with the same name were retrieved.
* EXOMalwareFilterPolicy
  * Fix for the MakeDefault property where it wasn't properly setting existing
    policies to default.
    FIXES #1648
* IntuneDeviceConfigurationPolicyWindows10
  * Fixed mismatch in property types between the PasswordBlockSimple and
    PasswordSignInFailureCountBeforeFactoryReset properties.
    FIXES #1525
* O365Group
  * Removed support for invalid CertificatePassword and CertificatePath parameters
    and added support for ApplicationSecret;
* O365User
  * Removed support for invalid CertificatePassword and CertificatePath parameters
    and added support for ApplicationSecret;
* TeamsChannel
  * Fixed an issue where special symbols in Teams names would cause the
    Get-TeamByName cmdlet to fail.
    ISSUE #1578
* MISC
  * Error Handling in Delta Report and removal of Authentication mechanism comparison;
    FIXES #1548, #1541
  * Added automatic cmdlet documentation generation functions and prereqs.

# 1.21.1229.1

* DEPENDENCIES
  * Updated all PnP.PowerShell dependencies to version 1.9.0;

# 1.21.1222.1

* AADGroup
  * Default to Unified type if no GroupTypes are provided;
    FIXES #850
* EXOAntiPhishPolicy
  * Deprecated the EnableAntispoofEnforcement and TargetDomainProtectionAction parameters;
    FIXES #1018
* EXOHostedCOntentFilterPolicy
  * Fix for the MakeDefault property where it wasn't properly setting existing
    policies to default.
    FIXES #1635
* SPOSearchManagedProperty
  * Fixed an issue with the Aliases retrieval;
* SPOUserProfileProperty
  * Removed the Required key from the schema.mof file for Credential;
    ISSUE #1632
* DEPENDENCIES
  * Updated all Microsoft.Graph.* dependencies to version 1.9.1;
* MISC
  * Fixed issue where running Export-M365DSCConfiguration with the -LaunchWebUI
    parameter would prompt for credentials;
  * Added warning message when ApplicationSecret is used while attempting
    to export resources for Exchange Online;
    Fixes #1629

# 1.21.1215.1

* AADConditionalAccessPolicy
  * Switched to the beta endpoint to allow the export to capture policies
    with device compliance conditions configured;
* EXOAntiphishPolicy
  * Fixed an issue where trying to create a new policy would result in its
    Identity being set to System.Collections.Hashtable;
    FIXES #1620
  * Fix for the MakeDefault property where it wasn't properly setting existing
    policies to default.
    FIXES #1582
* O365User
  * Fixed issue where the extraction wasn't properly formatting the temporary
    password for a user;
* TeamsChannelPolicy
  * Added support for Shared Channels;
* TeamsMeetingPolicy
  * Added support for value 'EveryoneInCompanyExcludingGuests' for the
    AutoAdmittedUsers property;
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to 1.0.82;

# 1.21.1208.1

* AADConditionalAccessPolicy
  * Added support for Terms of Use;
* AADGroup
  * Fixed issue where not all groups were exported;
* TeamsTeam
  * Fix issue where Credentials weren't extracted as a variable;
* TeamChannel
  * Fixed issue where the exported Team Channel content was empty if
    Credentials were used to authenticate;
* MISC
  * Removed RequiredModules in favor of a new custom dependency manifest;
* DEPENDENCIES
  * Updated MicrosoftTeams to 3.0.0;
  * Updated MSCloudLoginAssistant to 1.0.80;

# 1.21.1124.2

* DEPENDENCIES
  * Updated ReverseDSC to 2.0.0.9;

# 1.21.1124.1

* IntuneAppProtectionPolicyiOS
  * Fixes to the Invoke-MgGraphRequest cmdlets parameters;
* MISC
  * Removed the Quiet switch from the Assert Blueprint cmdlet;
    ISSUE #1563
* DEPENDENCIES
  * Updated Microsoft.Graph.Applications to 1.9.0;
  * Updated Microsoft.Graph.Authentication to 1.9.0;
  * Updated Microsoft.Graph.DeviceManagement to 1.9.0;
  * Updated Microsoft.Graph.DeviceManagement.Administration to 1.9.0;
  * Updated Microsoft.Graph.DeviceManagement.Enrolment to 1.9.0;
  * Updated Microsoft.Graph.Devices.CorporateManagement to 1.9.0;
  * Updated Microsoft.Graph.Groups to 1.9.0;
  * Updated Microsoft.Graph.Identity.DirectoryManagement to 1.9.0;
  * Updated Microsoft.Graph.Identity.SignIns to 1.9.0;
  * Updated Microsoft.Graph.Planner to 1.9.0;
  * Updated Microsoft.Graph.Teams to 1.9.0;
  * Updated Microsoft.Graph.Users to 1.9.0;
  * Updated MSCloudLoginAssistant to 1.0.79;
  * Updated ReverseDSC to 2.0.0.8;

# 1.21.1117.2

* MISC
  * Fixes old Intune Graph Request cmdlet name;

# 1.21.1117.1

* EXOTransportRule
  * Fixed issues with invalid State property and missing Enabled one;
    ISSUE #1554;
* IntuneDeviceCompliancePolicyAndroidDeviceOwner
  * Initial release;
* DEPENDENCIES
  * Updated DSCParser to version 1.3.0.2;
  * Updated MSCloudLoginAssistant to version 1.0.78;

# 1.21.1110.1

* MISC
  * Standardized examples
  * Added missing examples
  * Added settings.json generator cmdlet (Update-M365DSCResourcesSettingsJSON)
  * Added cmdlet to configure delegated permissions to Graph app based on
    settings.json file (Update-M365DSCAllowedGraphScopes)
  * Preparation to run integration tests dynamically using the resource examples
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.76;

# 1.21.1103.1

* TeamsCallingPolicy
  * Added support for value 'Unanswered' for property
    BudyOnBusyEnabledType.
    Fix Issue #1514
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to
    2.0.139;
  * Updated MSCloudLoginAssistant to version 1.0.75;

# 1.21.1027.1

* DEPENDENCIES
  * Updated Microsoft.Graph.Applications to 1.8.0;
  * Updated Microsoft.Graph.Authentication to 1.8.0;
  * Updated Microsoft.Graph.DeviceManagement to 1.8.0;
  * Updated Microsoft.Graph.DeviceManagement.Administration to 1.8.0;
  * Updated Microsoft.Graph.DeviceManagement.Enrolment to 1.8.0;
  * Updated Microsoft.Graph.Devices.CorporateManagement to 1.8.0;
  * Updated Microsoft.Graph.Groups to 1.8.0;
  * Updated Microsoft.Graph.Identity.DirectoryManagement to 1.8.0;
  * Updated Microsoft.Graph.Identity.SignIns to 1.8.0;
  * Updated Microsoft.Graph.Planner to 1.8.0;
  * Updated Microsoft.Graph.Teams to 1.8.0;
  * Updated Microsoft.Graph.Users to 1.8.0;
  * Updated MSCloudLoginAssistant to version 1.0.74;
* MISC
  * Fixed issue generating delta report containing EXOAvailabilityConfig
    resources;

# 1.21.1013.1

* Obfuscating Authentication Secrets from the Verbose output;

# 1.21.1006.3

* BREAKING CHANGES

* AADApplication
  * Removed support for the Oauth2AllowImplicitFlow, SamlMetadataUrl and
    Oauth2AllowUrlPathMatching properties;
* AADMSGroup
  * Renamed resource to AADGroup;
* AADMSGroupLifecyclePolicy
  * Renamed resource to AADGroupLifecyclePolicy;
* AADPolicy
  * Replaced resource by the new AADTokenLifetimePolicy one;
* DEPENDENCIES
  * Added dependency on Microsoft.Graph.Applications;
  * Added dependency on Microsoft.Graph.Groups;
  * Added dependency on Microsoft.Graph.Identity.DirectoryManagement;
  * Added dependency on Microsoft.Graph.Identity.SignIns;
  * Removing dependency on AzureADPreview;
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.137;
  * Updated MicrosoftTeams to version 2.6.0;
  * Updated MSCloudLoginAssistant to version 1.0.72;
* MISC
  * Renamed the GlobalAdminAccount parameter to Credential across all resources;
  * Revamped entire Azure AD Workload to leverage Microsoft Graph;
  * New -LaunchWebUI switch for Export-M365DSCConfiguration will launch the
    new web-based UI. The old GUI has been removed.
  * Removal of the -Quiet switch for the Export-M365DSCConfiguration cmdlet;
  * Renaming the ComponentsToExtract property from the Export-M365DSCConfiguration
    cmdlet to Components;

# 1.21.922.1

* AADApplication
  * Fix issue where export will only export 100 apps

* EXOSafeLinksPolicy
  * Added support for CustomNotificationText, EnableOrganizationBranding, and
    UseTranslatedNotificationText properties;
* SPOSite
  * Fixed issue when deleting site and confirm parameter
* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.68;

# 1.21.915.1

* EXOAntiPhishPolicy
  * Added support for EnableFirstContactSafetyTips & EnableViaTag;
* EXOAtpPolicyForO365
  * Added support for AllowSafeDocsOpen;
* EXOHostedContentFilterPolicy
  * Added support for HighConfidencePhishAction;
* EXOHostedOutboundSpamFilterPolicy
  Added support for RecipientLimitInternalPerHour, RecipientLimitPerDay,
  RecipientLimitExternalPerHour, ActionWhenThresholdReached & AutoForwardingMode;
* EXOHostedOutboundSpamFilterRule
  Initial release;
* IntuneAppConfigurationPolicy
  * Added support for the CustomSettings property;
* IntuneDeviceCompliancePolicyWindows10
  * Removed the App Secret and Application ID from the output;
  * Added DefenderEnabled to the Resource;
* IntuneDeviceConfigurationWindows10
  * Initial release;
* DEPENDENCIES;
  * Updated Microsoft.Graph.Authentication to version 1.7.0;
  * Added dependency on Microsoft.Graph.DeviceManagement;
  * Added dependency on Microsoft.Graph.DeviceManagement.Administration;
  * Added dependency on Microsoft.Graph.DeviceManagement.Enrolment;
  * Added dependency on Microsoft.Graph.Devices.CorporateManagement;
  * Updated Microsoft.Graph.Planner to version 1.7.0;
  * Updated Microsoft.Graph.Teams to version 1.7.0;
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.136;
  * Updated MSCloudLoginAssistant to version 1.0.67;

# 1.21.908.1

* PPTenantSettings
  * Initial Release;
* DEPENDENCIES;
  * Updated MSCloudLoginAssistant to version 1.0.64;
* MISC
  * Fixing duplicate teams names in reports;

# 1.21.901.1

* DEPENDENCIES;
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.133;
  * Updated MicrosoftTeams to version 2.5.1;
* MISC
  * Additional display alignment fixes for Export;

# 1.21.825.1

* SPOTenantSettings
  * Added the DisabledWebpartIds & ConditionalAccessPolicy properties;
* DEPENDENCIES;
  * Updated AzureADPreview to version 2.0.2.138;
  * Updated Microsoft.PowerApps.Administration.PowerShell to version 2.0.131;
  * Updated Microsoft.Teams to version 2.5.0;
* MISC
  * Additional display alignment fixes for Export;

# 1.21.804.1

* SCDLPComplianceRule
  * Fixed issue where SCDLPCompliance rule failed when using sensitivity labels;
* DEPENDENCIES;
  * Updated MSCloudLoginAssistant to version 1.0.62;
* MISC
  * Added support for ApplicationSecret in SPO resources;
  * Revamped the entire display from an Export;

# 1.21.728.1

* DEPENDENCIES;
  * Updated MSCloudLoginAssistant to version 1.0.59;
  * Updated PnP.PowerShell to version 1.7.0;
* MISC
  * Added support for Service Principal Authentication for all Intune resources;
  * Deprecated GUI and added reference to new Web based GUI;

# 1.21.721.1

* AADMSGroup
  * Fixed an issue where the Visibility parameter was never properly returned
    which always threw a detected drift when used.
* EXOJournalRule
  * Initial Release.
* SPOSite
  * Fixed the StorageQuotaWarningLevel value returned by the Get-TargetResource
    function.

# 1.21.714.1

* EXOHostedContentFilterPolicy
  * Fixed issues with null values falsely detected as drifts;
    ISSUE #1165
* DEPENDENCIES
  * Removed dependency on Microsoft.Graph.Groups.Planner;
  * Updated Microsoft.Graph.Teams to version 1.6.1;
  * Updated MSCloudLoginAssistant to version 1.0.54;
* MISC
  * Allowed for Desired and Current values to be captured by the Telemetry engine
    if an organization is using a custom App Insights account;
    ISSUE #1222

# 1.21.707.1

* EXODkimSigningConfig
  * Change the logic to remove an entry to disable it instead since the
    cmdlet didn't exist to remove it.
    ISSUE #1253
* EXOHostedContentFilterPolicy
  * Fixed the value type for the senders addresses, regions and domains;
    ISSUE #1165
* EXOOutboundConnector
  * Fixed the creation logic to include ValidationRecipients;
    ISSUE #1165
* EXOSharedMailbox
  * Improved speed of extraction and removed warning about maximum 1,000
    items retrieved;
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.127;
* MISC
  * Delta Report - Fixes to compare null arrays properly and report as
    a discrepancy.
    ISSUES #1178 & #1249

# 1.21.630.1

* O365User
  * Fix where export was throwing an error about an empty DSCBlock
    ISSUE #1275;
* SPOTenantSettings
  * Added support for specifying MarkNewFilesSensitiveByDefault

# 1.21.616.1

* SPOSiteAuditSettings
  * Fixed issue with Export where property Ensure was added
    when an access forbidden error was encountered;
* DEPENDENCIES
  * Updated Microsoft.Graph.Authentication to version 1.6.0;
  * Updated Microsoft.Graph.Planner to version 1.6.0;
  * Updated Microsoft.Graph.Teams to version 1.6.0;

# 1.21.609.2

* Fixed dependency on Microsoft.Graph.Authentication for
  version 1.5.0.

# 1.21.609.1

* TeamsUpgradePolicy
  * Fixes to how we are retrieving users assigned to the
    Global Upgrade Policy.
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to version 2.0.5;
  * Updated Microsoft.Graph.Planner to version 1.5.0;
  * Updated Microsoft.Graph.Teams to version 1.5.0;
  * Updated Microsoft.PowerApps.Administration.PowerShell
    to version 2.0.126;
  * Updated PnP.PowerShell to version 1.6.0;

# 1.21.602.1

* AADMSGroups
  * Fix for the export where the MailNickName was being prompted;
* EXOManagementRole
  * BREAKING: Now requires the Parent property as Mandatory;
* TeamsChannel
  * Fixed an issue where content was dedup and boolean
    values were appended to the exported content;
* TeamsUpgradePolicy
  * Improved performance retrieving users assigned to policy;
* MISC
  * Fix for Teams authentication. Improvements on session
    reuse.

# 1.21.526.2

* EXOSafeAttachmentRule
  * Fixed issue #1213 Policy X already has rule Y associated with it
    if rule exists already
* MSFT_IntuneDeviceCompliancePolicyAndroid
  * New resource
* MSFT_IntuneDeviceCompliancePolicyAndroidWorkProfile
  * New resource
* MSFT_IntuneDeviceCompliancePolicyMacOS
  * New resource
* MSFT_IntuneDeviceCompliancePolicyiOs
  * New resource
* EXOTransportRule
  * Fix #1230 Changed ExceptIfSenderInRecipientList to array

# 1.21.519.2

* AzureADRoleDefinition
  * Fix an issue where deprecated roles were not increasing
    the index which resulted in an incorrect count being
    displayed during the extraction.
* EXORoleAssignmentPolicy
  * Added missing ErrorAction value in the Export;
* TeamsTenantDialPlan
  * Fixed issue around normalization rules export;
* SPOTenantSettings
  * Fix issue with typo and dup property issue #1219
* MISC
  * Forces a Global load of the new MicrosoftTeams module for
    Teams resources;

# 1.21.519.1

* TeamsClientConfiguration
  * Fixed an issue where the RestrictedSenderList was not properly
    being converted to a comma separated string.
    Issue #1191
* DEPENDENCIES
  * Updated AzureADPreview to version 2.0.2.136;

# 1.21.512.1

* EXOOfflineAddressBook
  * Fixed issue in Set-TargetResource where ConfiguredAttributes
    was passed and resulted in an error.
* SCDLPComplianceRule
  * Added several new parameters
  * Fixed several bugs on extract

# 1.21.505.1

* EXOTransportRule
  * Adding ExceptIfSCLOver and SCLOver.
  * Fixes SubjectOrBodyContainsWords parameter not being an array.
  * Fixes DateTime formatting on ExpiryDate and ActivationDate

# 1.21.428.2

* EXOTransportRule
  * Fixed typo in accepted value for ApplyHtmlDisclaimerLocation;
* IntuneAppConfigurationPolicy
  * Revamp of Telemetry;
  * Using shorter cmdlets names;
* IntuneDeviceCompliancePolicyAndroid
  * Initial Release;
* IntuneDeviceCompliancePolicyAndroidWorkProfile
  * InitialRelease
* IntuneDeviceCompliancePolicyiOs
  * Using shorter cmdlet names;
* IntuneDeviceConfigurationPolicyiOS
  * Using shorter cmdlet names;
* IntuneDeviceEnrollmentPlatformRestriction
  * Revamp of Telemetry;
  * Using Shorter cmdlet names;

# 1.21.421.2

* MISC
  * Updated the SkipModuleReload logic for a dozen of EXO modules
    which were failing authentication;

# 1.21.421.1

* AADConditionalAccessPolicy
  * Fix to allow 'undefined' as a value for multiple parameters;
* EXOTransportRule
  * Fixed schema to support Service Principal Auth;
* TeamsChannelTab
  * Fixed typo in parameter 'TeamId';
* MISC
  * Refactor of all EXO resources to fixes for Set-TargetResource
    functions where Service Principal was used to authenticate;
  * Refactored connections across all resources to help with
    Telemetry regarding what auth method users are leveraging.

# 1.21.414.2

* AADConditionalAccessPolicy
  * Fixed an issue with the default values for device states;
* EXOHostedContentFilterPolicy
  * Fixed issue where EndUserSpamNotificationCustomFromName was
    not properly returned from the Get-TargetResource function;
* EXOTransportRule
  * New resource;
* O365AdminAuditLogConfig
  * Fixed issue where the Set-TargetResource stopped being
    executed if an error was encountered;
* TeamsTeam
  * Fix format issue with owner issue # 1143
* DEPENDENCIES
  * Updated AzureADPreview to version 2.0.2.134;
  * Updated Microsoft.Graph.Authentication to version 1.4.2;
  * Updated Microsoft.Graph.Planner to version 1.4.2;
  * Updated Microsoft.Graph.Teams to version 1.4.2;
  * Updated Microsoft.PowerApps.Administration.PowerShell to version
    2.0.112;
  * Updated MSCloudLoginAssistant to version 1.0.51;
  * Updated PnP.PowerShell to version 1.5.0;

# 1.21.407.1

* AADConditionalAccessPolicy
  * BREAKING: Renamed the 'includeDeviceStates' and 'excludeDeviceStates'
    parameters to 'includeDevices' and 'excludeDevices';
* TeamsMeetingPolicy
  * The Set-CsTeamsMeetingPolicy would fail if recording settings are
    changed while the AllowCloudRecording is set to false;
* MISC
  * Fixed issue in most EXO resources where AzureAD App information
    was not returned by the Get-TargetResource function;

# 1.21.331.1

* AADApplication
  * Added support for API Permissions;
* EXOSharedMailbox
  * Improved how we are retrieving all shared mailboxes in the
    Export-TargetResource function.
* ODSettings
  * Fixed and issue with ExcludedFileExtensions;
* SCDLPComplianceRule
  * Fixed issue where only the first SIT Action was exported;
* SPOSiteDesign
  * Added support for GrouplessTeamSite web template.
* SPOSiteScript
  * Fixed issue where an existing site script could not be updated.
  * Made parameter GlobalAdminAccount in Get-TargetResource
    optional.
* SPOTheme
  * Fixed issue where removal of a theme would throw an error.
  * Corrected variable name to properly show the theme name in verbose message
    when removing a theme.
* MISC
  * Fixed issue with ODSettings and ExcludedFileExtensions

# 1.21.317.1

* DEPENDENCIES
  * Updated Exchange Management to version 2.0.4 (REDO);
  * Updated MSCloudLoginAssistant to version 1.0.50;
* MISC
  * Fixed issue when using CertificatePath and CertificatePassword
    for SPO resource;

# 1.21.224.1

* DEPENDENCIES
  * Rolled-back ExchangeOnlineManagement to 2.0.3;

# 1.21.217.1

* SPOSite
  * Fixed an issue related to new cmdlets in PnP.PowerShell;
* DEPENDENCIES
  * Updated ExchangeOnlineManagement to 2.0.4;
  * Updated PNP.PowerShell to 1.3.0;

# 1.21.203.1

* SPOSiteDesignRights
  * Fixed an issue that was preventing this resource from
    being exported;
* SPOBrowserIdleSignout
  * Initial Release;
* TeamsTenantDialPlan
  * Fixed an issue with the way Voice Normalization Rules were handled;
* MISC
  * Fix to the Delta Report Generator to properly handle TeamsPSTNUsage;
  * Fixed various Export Verbose format issues;
* DEPENDENCIES
  * Updated Microsoft.Graph.Authentication to version 1.3.1;
  * Updated Microsoft.Graph.Planner to version 1.3.1;
  * Updated Microsoft.Graph.Teams to version 1.3.1;
  * Updated MSCloudLoginAssistant to version 1.0.48;

# 1.21.127.1

* AADNamedLocation
  * Initial Release;
* DEPENDENCIES
  * Updated PnP.PowerShell to version 1.2.0;
  * Updated Microsoft.PowerApps.Administration.PowerShell to
    1.0.208;

# 1.21.120.1

* DEPENDENCIES
  * Updated MSCloudLoginAssistant to version 1.0.45;
  * Replaced the SharePointPnPPowerShellOnline dependency by the new
    PnP.PowerShell core module;

# 1.21.113.1

* AADTenantDetails
  * Fixes an issue where the Set would fail if Service Principal
   was used.
   (Issue [#1002](https://github.com/microsoft/Microsoft365DSC/issues/1002))
* AADRoleDefinition
  * Filters out role definitions without any assigned permissions.
    Fixes Issue #1007;
* DEPENDENCIES
  * Updated Microsoft.PowerApps.Administration.PowerShell
    to 2.0.104;

# 1.20.1223.1

* SPOHubSite
  * Changed Export logic to make the url parameterized
  * Updated Get method to prevent throwing an exception
    when the specified site doesn't exist
* SPOSite
  * Updated logic to not process the HubUrl parameter
    when this is equal to the Url parameter.
  * Updated export logic to not export the HubUrl
    parameter when this is equal to the Url parameter.
  * Fixed issue with incorrectly applying the LocaleId
* SPOSiteAuditSettings
  * Changed Export logic to make the url parameterized
* SPOSiteGroup
  * Changed Export logic to make the url parameterized
  * Updated logic to output more explainable troubleshooting
    messages
* M365DscReverse
  * Added the GlobalAccount Parameter to the example
    that is outputted after using the Export GUI

# 1.20.1216.1

* AADConditionalAccessPolicy
  * Initial Release;
* EXOSafeLinksRule
  * Fixed typo in a try/catch clause;
* O365User
  * Added support for removing existing users with
    Ensure = 'Absent';
* TeamsChannelTab
  * Initial Release;

# 1.20.1209.1

* IntuneAppProtectionPolicyiOS
  * Initial Release;
* IntuneDeviceCompliancePolicyiOS
  * Initial Release;
* IntuneDeviceConfigurationPolicyiOS
  * Initial Release;
* IntuneDeviceEnrollmentPlatformRestriction
  * Initial Release;
* IntuneDeviceEnrollmentLimitRestriction
  * Initial Release;
* TeamsTenantDialPlan
  * Performance Improvements: retrieve all Voice Normalization
    Rule at once and then iterated through them instead of
    retrieving them for every instance.
* DEPENDENCIES
  * Upgraded ExchangeOnlineManagement to version 2.0.3;
  * Upgraded Microsoft.Graph.Authentication to version 1.2.0;
  * Upgraded Microsoft.Graph.Planner to version 1.2.0;
  * Upgraded SharePointPnPPowerShellOnline to version
    3.28.2012.0;

## 1.20.1202.1

* EXOOwaMailboxPolicy
  * Fixed an issue trying to remove a policy;
* TeamsMessagingPolicy
  * Added AllowUserEditMessage property.
* TeamsMeetingPolicy
  * Added 'OrganizerOnly' as a support value for property
    AutoAdmittedUsers.
  * Temporarily removed the use of AllowAnonymousUsersToDialOut
    since it is currently disabled on the API side.
* EXPORT
  * Fixed an issue where an Export using the -Workloads
    parameter with a Service Principal did not export
    any resource;
* DEPENDENCIES
  * Upgrade AzureADPreview to version 2.0.2.129;

## 1.20.1125.1

* AADRoleDefinition
  * Initial Release;
* O365User
  * Fixes an issue where only the first O365User instance
    extracted had the PSCredential Password property set
    correctly;
* TeamsMeetingPolicy
  * Added the AllowBreakoutRooms, TeamsCameraFarEndPTZMode
    & AllowMeetingReactions parameters;
* DEPENDENCIES
  * MSCloudLoginAssistant Updated to 1.0.42;
  * Microsoft.PowerApps.Administration.PowerShell Updated
    to 2.0.99;
* MISC
  * Moved the check for new version of module into the
    Export-M365DSCConfiguration function for performance
    improvements;

## 1.20.1118.1

* EXOMalwareFilterPolicy
  * Fix an issue when the CustomFromAddress is empty;
    (Issue #901)
* EXORemoteDomain
  * Fixed an issue where only non-null parameters are
    used in the Set-TargetResource resource;
    (Issue #898)
* SCRetentionEventType
  * Initial Release;
* SPOSiteScript
  * BREAKING CHANGE: Title is now the primary key for the
    resource and Service Principal is now supported for
    authentication.
* MODULES
  * M365DSCStringEncoding
    New resource to handle encoding issues in exported content;
    (Issue #904)
  * M365DSCLogEngine
    Added Export-M365DiagnosticData function to export diagnostic
    information to a Zip file.

## 1.20.1111.1

* AADPolicy
  Initial Release;
* Fixes an issue with SCRetentionCompliancePolicy where
  the wrong parameter sets was being passed for creation.
  (Issue #890)

## 1.20.1104.1

* AADMSGroup
  * Added parameter IsAssignableToRole Issue #879
  * Fixed issue on Set Issue #863
* EXOHostedContentFilterPolicy
  * Deprecated ZapEnabled property and added PhishZapEnabled
    and SpamZapEnabled instead.
* MISC
  * Added checks for mandatory Authentication parameters before
    attempting an Export.
  * Deprecated the Assert-M365DSCTemplate cmdlet;
  * Added Telemetry for version of PowerShell used;
  * Added a timeout on new version check from the
    PowerShell Gallery;
  * Fixed Unit Test stubs;

## 1.20.1028.1

* EXOOutboundConnector
  * Fixed issue #821;
* O365OrgCustomizationSetting
  * Fixes an issue where the resource was not being exported;
* O365User
  * Added additional information in the error log for when
    we try to set an invalid license
* ODSettings
  * Removed AD group guid dependency issue # 862
* SPOTenantSettings
  * Parameter RequireAcceptingAccountMatchInvitedAccount
    is now deprecated (Issue #864)
* SPOSharingSettings
  * Fixed issue # 855
  * Fixed issue # 866 changed domains to array
  * Fixed issue where trying to set anonymous link types if
    sharing not properly configured issue #865
* SPOTheme
  * Fixed issue where Palette was not being properly extracted as
    an array of CIMInstances.
* TeamsTeam
  * Added support for visibility HiddenMembership
* MODULES
  * M365DSCUtil
    * Fixed an issue where function Test-M365DSCObjectHasProperty was missing
    (Issue #861)
  * M365DSCReverse
    * Fixed an issue where passing in the file name and using the GUI for
      extraction did not store the file at the specified location (Issue #810)
    * Fixed and issue where the -GenerateInfo parameter would always generate
      a link to the same resource.
    * Added current version module in the Export file.
* MISC
  * Added Authentication Type used to the Telemetry Engine.
* DEPENDENCIES
  * AzureADPreview Updated to 2.0.2.119
  * DSCParser Updated to 1.3.0.0
  * Microsoft.Graph.Authentication Updated to 1.1.0
  * Microsoft.Graph.Planner Updated to 1.1.0
  * Microsoft.PowerApps.Administration.PowerShell Updated
    to 2.0.96;

## 1.20.1021.1

* AADTenantDetails
  * Fixed issue where IsSingleInstance was not returned from
    the Get-TargetResource method;
* MISC
  * Fix to how Telemetry is retrieving module version;
  * Added additional error troubleshooting information
    to telemetry (dependencies version).

## 1.20.1016.1

* Fixed a permissions issue with the
  Install-M365DSCDevBranch cmdlet (Issue #699 & #826)
* DEPENDENCIES
  * MSCloudLoginAssistant Updated to 1.0.41;
  * SharePointPnPPowerShellOnline Updated to 3.26.2010.0;
* MISC
  * Improved Error log to include StackTrace for additional
    info to help troubleshooting errors.

## 1.20.1014.1

* TeamsVoiceRoute
  * Initial Release

## 1.20.1007.1

* TeamsCallingPolicy
  * Added new supported properties;
* TeamsMeetingPolicy
  * Added new supported properties;
* TeamsTeam
  * Added new supported properties;

## 1.20.930.1

* IntuneAppConfigurationPolicy
  * Initial Release;
* DEPENDENCIES
  * Rolled back ExchangeOnlineManagement to 2.0.1
  * Microsoft.PowerApps.Administration.PowerShell updated
    to 2.0.85;
  * Microsoft.Graph.Authentication updated to 1.0.1;
  * Microsoft.Graph.Groups.Planner updated to 1.0.1;
* MISC
  * Refactored error handling to various EXO resources;
  * Renamed method Test-Microsoft365DSCParameterState to
    Test-M365DSCParameterState to align with naming standard;
  * Fixed issue #777 with export of SCDLPComplianceRule;

## 1.20.923.1

* IntuneDeviceCategory
  * Initial Release;
* SPOSite
  * Fixed an issue where updating a site's properties
    would throw an error complaining about the object
    not being in a correct state.
* DEPENDENCIES
  * AADPreview Updated to 2.0.2.117;
  * ExchangeOnlineManagement Updated to 2.0.3;
  * MSCloudLoginAssistant Updated to 1.0.40;
  * ReverseDSC Updated to 2.0.0.7;
* Misc
  * Removed EncryptionTemplateID from SCSensitivityLabel (Issue #758)
  * Added AzureAD app support SPOSiteDesign
  * Added possibility to provide a custom header to Blueprint
    assessment and delta reports.

## 1.20.916.1

* AADServicePrincipal
  * Initial Release (Issue #492)
* EXOAvailabilityAddressSpace
  * Fixed an issue where if the user didn't have proper permissions
    the entire Export process would stop;
* EXOAvailabilityConfig
  * Fixed an issue where if the user didn't have proper permissions
    the entire Export process would stop;
* EXOEmailAddressPolicy
  * Fixed an issue where if the user didn't have proper permissions
    the entire Export process would stop;
* DEPENDENCIES
  * MicrosoftTeams Updated to 1.1.6;
  * MSCloudLoginAssistant Updated to 1.0.38;
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.81;
* MISC
  * Fixed issue with warning about unsupported resources in the
    Export mode based on authentication selected.
  * Fixes an issue in the Install-M365DSCDevBranch function
    where if the manifest file had a leading 0 in the version
    number (e.g. 1.20.0902.1), it would create the folder as
    a version with the '0' where the Gallery trims it.
    (Issue #685)

## 1.20.909.1

* EXOApplicationAccessPolicy
  * Added some error handling around the
    Get-ApplicationAccessPolicy cmdlet
    (Issue #702);
*EXOSharedMailbox
  * Fixed an issue where Aliases were not properly removed
    (Issue #749);
* TeamsCallingPolicy
  * Added support for the AllowWebPSTNCalling and Description
    properties;
* TeamsChannel
  * Fixed an error in the Export when trying to connect using
    only an Azure AD Application without any credentials
    (Issue #754);
* TeamsClientConfiguration
  * Added support for the AllowEgnyte property
  (Issue #744);
* TeamsUser
  * Fixed an issue where for large tenants the Export could
    failed due to a percentage of completion greater than
    100% for the Write-Progress
    (Issue #722);
* MISC
  * Fixed an issue where the OD checkbox was always disabled
    in the GUI;
  * Changed the logic of the Unselect All button in the GUI
    so that it doesn't unselect the authentication checkboxes;
  * Fixed an issue where SPOHubSite was left selected in the
    Export GUI even when unselecting the entire SPO Workload
    (Issue #735);
  * Fixed an issue where if no Destination Path was provided
    after an export, it would fail. It now defaults to the
    current location
    (Issue #698);
  * Fixed issue SCSensitivityLabel on EncryptionRightsDefinitions parameters
    format (Issue #758)
* DEPENDENCIES
  * MSCloudLoginAssistant Updated to 1.0.34;
  * Microsoft.PowerApps.Administration.PowerShell Updated to 2.0.77;
  * SharePointPnPPowerShellOnline Updated to 3.25.2009.1;

## 1.20.902.1

* O365User
  * Fixed an issue where we were trying to assign an empty
    license to a user if an empty array was passed for
    LicenseAssignment.
* SCComplianceSearchAction
  * Added 'Preview' as a supported value for Action;
* ReverseDSC
  * Fixed an issue where a newline was missing in the
    credentials section when a certificate password was
    specified;
* MISC
  * Added a new Assert-M365DSCBlueprint function to generate
    discrepancy report between export of tenant and a BluePrint;
* Metadata
  * Updated DSCParser Module to version 1.2.0.0;
  * Updated Microsoft.Graph.Authentication Module to version
    0.9.1;
  * Updated Microsoft.Graph.Groups.Planner Module to version
    0.9.1;
  * Updated Microsoft.Graph.Identity.ConditionalAccess Module
    to version 0.9.1;
  * Updated Microsoft.Graph.Planner Module to version
    0.9.1;
  * Updated Microsoft.PowerApps.Administration.PowerShell Module
    to version 0.9.1;
  * Updated SharePointPnPPowerShellOnline Module to version
    3.24.2008.1;

## 1.20.805.1

* EXOAvailabilityConfig
  * Fixed an issue with the Test-TargetResource where if a full
    username (with '@') was specified for the OrgWideAccount, it
    would always return false;
* EXOMobileDeviceMailboxPolicy
  * Fixed an error where if no MinPasswordLength was specified
    the Set-TargetResource threw n error trying to create a new
    policy;
* EXOInboundConnector
  * Fixed an issue where ResourceName was null during the export;
* EXOOutboundConnector
  * Fixed an issue where ResourceName was null during the export;
* ODSettings
  * Fixed an issue where the GrooveBlockOption setting was never
    set properly;
* SCSensitivityLabel
  * Added new parameters

## 1.20.730.2

* AADMSGroup
  * Fixed an issue where if GroupID was not passed, we could end up
    with duplicate teams.
* MISC
  * If a newer version of the module is available in the PowerShell
    Gallery, a notification will be displayed to the user;

## 1.20.730.1

* AADApplication
  * Removed the ObjectId parameter from the list of parameters
    checked in the Test-TargetResource;
* AADGroupsSettings
  * Fixed an issue where the values returned by Get-TargetResource were
    always set to true due to an invalid cast;
* O365User
  * Fixed an issue where no licenses specified resulted in an error;
* Metadata
  * Updated MSCloudLoginAssistant Module to version 1.0.32;

## 1.20.723.1

* MISC
  * Update to the Telemetry engine to capture information about tenant;

## 1.20.722.1

* AADApplication
  * Fix an issue where a new AzureAD Application was not created
    if ObjectId was specified;
* O365User
  * Fixed an issue where the PasswordNeverExpires value returned
    was incorrect;
* SPOAPP
  * Added property Path as a key for the SPOApp resource to
    prevent conflict where two solutions could have the same
    name;
* MISC
  * Renamed the event log to M365DSC to avoid journal conflicts;
* Metadata
  * Updated Microsoft.Graph.Authentication module version to 0.7.1;
  * Updated Microsoft.PowerApps.Administration.PowerShell version to
    2.0.72;
  * Updated SharePointPnPPowerShellOnline version to 3.23.2007.1;

* SPOSiteScript;
  * Initial Release;

## 1.20.716.1

* MISC
  * Added visual indicators for the Export feature;
* EXOMalwareFilterPolicy
  * Fixed an issue where the value for the for the Action
    returned by the Get included 'Text' and should not have;
* EXOOutboundConnector
  * Fixed an issue where the ConnectorSource value returned
    was empty. Now defaulting to Default.
* O365User
  * Fixed issue with PasswordNeverExpires having incorrect value
* PlannerBucket
  * Initial Release;
* PlannerPlan
  * Initial Release;
* PlannerTask
  * Initial Release;
* Metadata
  * Updated ExchangeOnline module version to 1.0.1;
  * Updated Microsoft.Graph module version to 0.7.0;
  * Updated Microsoft.Graph.Identity.ConditionalAccess
    module version to 0.7.0;
  * Updated Microsoft.PowerApps.Administration.PowerShell
    module version to 2.0.70;
  * Updated MSCloudLoginAssistant Module to version 1.0.30;
  * Updated SharePointPnPPowerShellOnline module to version 3.23.2007.0;
  * Updated ReverseDSC module version to 2.0.0.4;
  * Updated SharePointPnPPowerShellOnline module to
    version 3.22.2006.2;
  * Updated all Unit Tests to Pester 5;
  * Added support for Service Principal for PowerPlatforms,
    SPO & OneDrive, Exchange Online and Office 365 resources;

## 1.20.0603.1

* Microsoft365Dsc
  * Improved event log function
* EXOEmailAddressPolicy
  * Converted hardcoded tenant name into variables;
* EXOHostedContentFilterPolicy
  * Added 'NoAction' as a valid input for property BulkSpamAction;
* EXOInboundConnector
  * Fixed an issue where if the connector was created with a source
    of 'AdminUI', we now convert it to 'Default' in the Get function;
* EXOOutboundConnector
  * Fixed an issue where if the connector was created with a source
    of 'AdminUI', we now convert it to 'Default' in the Get function;
* TeamsTenantDialPlan
  * Fixed an issue extraction plans without any normalization rules;
* Modules
  * M365DSCUtil:
    * Fixed an issue in Test-Microsoft365DSCParameterState where
      the same array of object was always being compared;
    * Issue 612 - Fixed an extra '}' in the event log output;

* Metadata
  * Updated AzureADPreview to 2.0.2.102;
  * Updated MSCloudLoginAssistant to 1.0.23;
  * Updated Microsoft.PowerApps.Administration.PowerShell
    to 2.0.64;
  * Updated ReverseDSC to 2.0.0.3;
  * Updated SharePointPnPPowerShellOnline to 3.21.2005.2;
* Misc
  * Azure DevOPS Pipelines and AppVeyor Tests converted to GitHub
    Actions;

## 1.0.5.128

* AADGroupsNamingPolicy
  * Added support for AzureAD Application Authentication;
* AADGroupsSettings
  * Added support for AzureAD Application Authentication;
  * Fixed issue where properties were returned as string instead
    of boolean;
* AADMSGroup
  * Initial Release;
* AADMSGroupLifecyclePolicy
  * Added support for AzureAD Application Authentication;
* TeamsChannel
  * Added support for AzureAD Application Authentication;
* TeamsTeam
  * Added support for AzureAD Application Authentication;
* TeamsTenantDialPlan
  * Initial Release;
* TeamsUser
  * Added support for AzureAD Application Authentication;
* Modules
  * Added M365DSCAgent;
  * Added M365DSCReport;
* Metadata
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.57;
  * Updated MicrosoftTeams to 1.0.6;
  * Updated MSCloudLoginAssistant to 1.0.14;
  * Introduced dependency on the EXchangeOnlineManagement module;
  * Introduced dependency on the Microsoft.Graph.Authentication module;
  * Introduced dependency on the Microsoft.Graph.Identity.ConditionalAccess
    module;
  * Introduced dependency on the DSCParser module;

## 1.0.4.39

* Re-branding to Microsoft365DSC
  * All components re-branded;
* AADMSGroupLifecyclePolicy
  * Initial Release;
* AADGroupsNamingPolicy
  * Initial Release;
* AADGroupsSettings
  * Initial Release;
* AADMSGroupLifecyclePolicy
  * Initial Release;
* SCAuditConfigurationPolicy
  * Fix issue with the Remove scenario;
* SCDLPCompliancePolicy
  * Fix issue with the Remove scenario;
* SCFilePropertyAuthority
  * Fix issue with the Remove scenario;
* SCFilePlanPropertyCategory
  * Fix issue with the Remove scenario;
* SCFilePlanPropertyCitation
  * Fix issue with the Remove scenario;
* SCFilePlanPropertyDepartment
  * Fix issue with the Remove scenario;
* SCFilePlanPropertyReferenceId
  * Fix issue with the Remove scenario;
* SCFilePlanPropertySubCategory
  * Fix issue with the Remove scenario
* SCRetentionCompliancePolicy
  * Fix issue with Teams Policy in the Get;
* SPOPropertyBag
  * Fixed an issue where false positive drifts were being detected;
* SPOSiteAuditSettings
  * Generalized the URL not to capture hardcoded domains;
* SPOSiteGroup
  * Fixed an issue where now, groups with Null owners are not extracted;
  * Generalized the URL not to capture hardcoded domains;
* TeamsCallingPolicy
  * Removed the AllowCalling parameter since it is no longer supported;
  * Fixed an issue with Policies without tags in their name (e.g. Global);
* TeamsMessagingPolicy
  * Fixed and issue where the Global policy was always flagged as having
    a drift;
* TeamsUpgradePolicy
  * Initial Release;
* M365DSCUtil
  * Added the new Assert-M365DSCTemplate cmdlet to assess remote templates;
* ReverseDSC
  * Change to allow ComponentsToExtract without the 'chck' prefix;
  * Introduction of Extraction Modes and Visual Indicators;
  * Major refactoring, having UI dynamic and items displayed by
    Resources' names;
* Metadata
  * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.56;
  * Updated MicrosoftTeams dependency to 1.0.5;
  * Updated MSCloudLoginAssistant dependency to 1.0.6;
  * Updated SharePointPnPPowerShellOnline dependency to 3.20.2004.0;

## 1.0.3.1723

* EXOHostedOutboundSpamFilterPolicy
  * BREAKING CHANGE: Remove IsSingleInstance and added
    Identity as key;
* SPOSite
  * Refactor to use PnP and expose updated parameters;
* TeamsGuestMessagingConfiguration
  * Added value NoRestriction for GiphyRatingValues;
* Metadata
  * Removed dependency on MSOnline;
  * Updated MSCloudLoginAssistant dependency to 1.0.2;
  * Updated SharePointPnPPowerShellOnline dependency to 3.18.2002.0;
  * Updated Microsoft.PowerApps.Administration.PowerShell
    dependency to 2.0.42;

## 1.0.2.1583

* EXOAcceptedDomain
  * Fixed an issue where the domains were not properly extracted
    if multiple domain matches a similar pattern;
* EXOHostedOutboundSpamFilterPolicy
  * Fixed an error where the resource was not being extracted via
    the Graphical User Interface;
* SCComplianceTag
  * Fix an issue where FilePlanProperty values returned
    from Get-TargetResource where always empty;
* SCDLPComplianceRule
  * Fixed an issue with multiple SensitiveInformation objects;
  * Fixed an issue where extraction failed if the name of the
    Sensitive Information property contained apostrophes;
* SCFilePlanPropertySubCategory
  * Fixed an issue where the Sub-Categories were not properly extracted,
    whenever the parent category is custom;
* TeamsEmergencyCallingPolicy
  * Initial Release;
* TeamsEmergencyCallRoutingPolicy
  * Initial Release;
* TeamsGuestCallingConfiguration
  * Initial Release;
* TeamsGuestMeetingConfiguration
  * Initial Release;
* TeamsGuestMessagingConfiguration
  * Initial Release;
* TeamsMeetingBroadcastPolicy
  * Initial Release;
* ReverseDSC
  * Updated Graphical User Interface with new resources;
  * Streamlined the looping logic to simplify development process
    for new resources;
* Metadata
  * Updated Microsoft.Online.SharePoint.PowerShell to version
    16.0.19515.12000;
  * Updated ReverseDSC dependency to version 2.0.0.2;
  * Updated SharePointPnPPowerShellOnline to version 3.17.2001.2;
* SPOHomeSite
  * Initial Release;

## 1.0.1.1395

* EXOOrganizationConfig
  * Initial Release;
* EXOClientAccessRule
  * Fixed issue with Get-TargetResource not
    returning all values;
* O365OrgCustomizationSetting
  * Inital Release;
* PPPowerAppsEnvironment
  * Initial Release;
* SCAuditConfigurationSettings
  * Initial Release;
* SCComplianceTag
  * Changed ReviewerEmail to type String array;
* SCDLPComplianceRule
  * Fixed issue with the extraction of NotifyAllowOverride;
* SCFilePlanPropertyAuthority
  * Initial Release;
* SCFilePlanPropertyCategory
  * Initial Release;
* SCFilePlanPropertyCitation
  * Initial Release;
* SCFilePlanPropertyDepartment
  * Initial Release;
* SCFilePlanPropertyReferenceID
  * Initial Release;
* SCFilePlanPropertySubCategory
  * Initial Release;
* SPOPropertyBag
  * Added multithreading;
* SPOSiteGroup
  * Initial Release;
* SPOSharingSettings
  * Added ExistingExternalUserSharingOnly as a supported value
    for SharingCapabilities;
* SPOTheme
  * Fixed an issue with the Set-TargetResource
    still using SPO management shell cmdlets instead of PnP;
* SPOUserProfileProperty
  * Introduced Multi-Threading
* TeamsCallingPolicy
  * Initial Release;
* TeamsMeetingBroadcastConfiguration
  * Initial Release;
* TeamsMeetingConfiguration
  * Initial Release;
* TeamsMeetingPolicy
  * Initial Release;
* TeamsMessagingPolicy
  * Initial Release;
* TeamsUpgradeConfiguration
  * Initial Release;
* TeamsUser
  * Introduced Multi-Threading;
  * Fixed an issue with User's Principal Name;
* Metadata
  * Updated MicrosoftTeams dependency to version 1.0.3;
  * Updated MSCloudLoginAssistant dependency to version
    0.8.2;
  * Updated SharePointPnPPowerShellOnline dependency
    to version 3.16.1912.0;
  * Updated ReverseDSC dependency to version 2.0.0.0;
* Misc
  * Added new Telemetry Engine;
  * Added new Dynamic Stubs Generation feature;

## 1.0.0.1048

* SCCaseHoldPolicy
  * New Resource;
* SCComplianceCase
  * New Resource;
* SCComplianceSearch
  * New Resource;
* SCComplianceSearchAction
  * New Resource;
* SCDLPComplianceRule
  * New Resource;
* SPOPropertyBag
  * New Resource;
* SPOSiteAuditSettings
  * New Resource;
* SPOTenantCDNPolicy
  * New Resource;
* Reverse
  * Added workload selectors to the GUI interface;
* Metadata
  * Updated MSCloudLoginAssistant dependency
    to version 0.8.3;
  * Updated ReverseDSC dependency
    to version 1.9.4.6;
  * Updated Microsoft.Online.SharePoint.PowerShell dependency
    to version 16.0.19223.12000;
  * Updated MicrosoftTeams dependency to version 1.0.0.2;
  * Updated SharePointPnPPowerShellOnline dependency
    to version 3.14.1910.0

## 1.0.0.846

* Modules
  * ReverseDSC
    * Added all missing Security and Compliance items;
* EXOATPPolicyForO365
  * Fixed issue where we now extract any policy,
    not just default;
* SCDLPCompliancePolicy
  * New Resource;
* SCRetentionCompliancePolicy
  * Changed logic to update existing Policy;
* Metadata
  * Updated SharePointPnPPowerShellOnline dependency
    to version 3.12.1908.1;
  * Updated MSCloudLoginAssistant dependency to
    version 0.6;

## 1.0.0.776

* BREAKING CHANGES
  * ODSettings
    * IsSingleInstance is now a Mandatory parameter;
    * Removed CentralAdminUrl as a parameter;
  * SPOAccessControlSettings
    * Removed CentralAdminUrl as a parameter;
  * SPOAPP
    * Removed CentralAdminUrl as a parameter;
  * SPOHubSite
    * Removed CentralAdminUrl as a parameter;
  * SPOSearchManagedProperty
    * Removed CentralAdminUrl as a parameter;
  * SPOSearchResultSource
    * Removed CentralAdminUrl as a parameter;
  * SPOSharingSettings
    * Removed CentralAdminUrl as a parameter;
  * SPOSite
    * Removed CentralAdminUrl as a parameter;
  * SPOSiteDesign
    * Removed CentralAdminUrl as a parameter;
  * SPOSiteDesignRights
    * Removed CentralAdminUrl as a parameter;
  * SPOTenantSettings
    * Removed CentralAdminUrl as a parameter;
  * SPOTheme
    * Removed CentralAdminUrl as a parameter;
* Metadata
  * Updated version dependency for MSCloudLoginAssistant
    to 0.5.8;
* Modules
  * ReverseDSC
    * Fixed some issues with the abstraction of tenant name
      when the -Quiet switch is used;
* SPOApp
  * Change logic for detection when no App Catalog exist;

## 1.0.0.744

* GENERAL
  * Updated Dependency on SharePointPnPPowerShellOnline
    to version 3.11.1907.0
* BREAKING CHANGES
  * O365Group
    * ManagedBy is now a mandatory property;
  * SPOSite
    * Owner is now a mandatory property
* Modules
  * Added embedded Log Engine
* SCRetentionCompliancePolicy
  * Initial Release;
* SCRetentionComplianceRule
  * Initial Release
* SCSupervisoryReviewPolicy
  * Initial Release
* SCSupervisoryReviewRule
  * Initial Release
* SPOSite
  * Added default value for Storage Quota;
  * Fixed an issue with site creation that could result in infinite loops;
