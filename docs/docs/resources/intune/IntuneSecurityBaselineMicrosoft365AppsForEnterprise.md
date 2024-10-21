# IntuneSecurityBaselineMicrosoft365AppsForEnterprise

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DeviceSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise | The policy settings for the device scope | |
| **UserSettings** | Write | MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise | The policy settings for the user scope | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_DeviceManagementConfigurationPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Pol_SecGuide_A001_Block_Flash** | Write | String | Block Flash activation in Office documents (0: Disabled, 1: Enabled) | `0`, `1` |
| **Pol_SecGuide_Block_Flash** | Write | String | Block Flash player in Office (Device) - Depends on Pol_SecGuide_A001_Block_Flash (block all flash activation: Block all activation, block embedded flash activation only: Block embedding/linking, allow other activation, allow all flash activation: Allow all activation) | `block all flash activation`, `block embedded flash activation only`, `allow all flash activation` |
| **Pol_SecGuide_Legacy_JScript** | Write | String | Restrict legacy JScript execution for Office (0: Disabled, 1: Enabled) | `0`, `1` |
| **POL_SG_powerpnt** | Write | SInt32 | PowerPoint: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_onenote** | Write | SInt32 | OneNote: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_mspub** | Write | SInt32 | Publisher: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_msaccess** | Write | SInt32 | Access: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_winproj** | Write | SInt32 | Project: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_visio** | Write | SInt32 | Visio: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_outlook** | Write | SInt32 | Outlook: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_winword** | Write | SInt32 | Word: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **POL_SG_excel** | Write | SInt32 | Excel: (Device) - Depends on Pol_SecGuide_Legacy_JScript | |
| **L_PolicyEnableSIPHighSecurityMode** | Write | String | Configure SIP security mode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_PolicyDisableHttpConnect** | Write | String | Disable HTTP fallback for SIP connection (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AddonManagement** | Write | String | Add-on Management (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_powerpntexe17** | Write | String | powerpnt.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_excelexe15** | Write | String | excel.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_visioexe19** | Write | String | visio.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe26** | Write | String | onent.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_outlookexe22** | Write | String | outlook.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe18** | Write | String | pptview.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_winwordexe21** | Write | String | winword.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe24** | Write | String | exprwd.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe23** | Write | String | spDesign.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_winprojexe20** | Write | String | winproj.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_grooveexe14** | Write | String | groove.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_mspubexe16** | Write | String | mspub.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_mse7exe27** | Write | String | mse7.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe25** | Write | String | msaccess.exe (Device) - Depends on L_AddonManagement (0: False, 1: True) | `0`, `1` |
| **L_ConsistentMimeHandling** | Write | String | Consistent Mime Handling (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_excelexe43** | Write | String | excel.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe51** | Write | String | spDesign.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe54** | Write | String | onent.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_outlookexe50** | Write | String | outlook.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe46** | Write | String | pptview.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_mspubexe44** | Write | String | mspub.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_visioexe47** | Write | String | visio.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_winprojexe48** | Write | String | winproj.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe53** | Write | String | msaccess.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe45** | Write | String | powerpnt.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_grooveexe42** | Write | String | groove.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_mse7exe55** | Write | String | mse7.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_winwordexe49** | Write | String | winword.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe52** | Write | String | exprwd.exe (Device) - Depends on L_ConsistentMimeHandling (0: False, 1: True) | `0`, `1` |
| **L_Disableusernameandpassword** | Write | String | Disable user name and password (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_excelexe127** | Write | String | excel.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_grooveexe126** | Write | String | groove.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe138** | Write | String | onent.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_mse7exe139** | Write | String | mse7.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_mspubexe128** | Write | String | mspub.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_visioexe131** | Write | String | visio.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe136** | Write | String | exprwd.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe137** | Write | String | msaccess.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe135** | Write | String | spDesign.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_winwordexe133** | Write | String | winword.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe129** | Write | String | powerpnt.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_outlookexe134** | Write | String | outlook.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_winprojexe132** | Write | String | winproj.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe130** | Write | String | pptview.exe (Device) - Depends on L_Disableusernameandpassword (0: False, 1: True) | `0`, `1` |
| **L_Informationbar** | Write | String | Information Bar (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_excelexe113** | Write | String | excel.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_mspubexe114** | Write | String | mspub.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe123** | Write | String | msaccess.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe124** | Write | String | onent.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_outlookexe120** | Write | String | outlook.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_winprojexe118** | Write | String | winproj.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe115** | Write | String | powerpnt.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe121** | Write | String | spDesign.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_grooveexe112** | Write | String | groove.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_visioexe117** | Write | String | visio.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_mse7exe125** | Write | String | mse7.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_winwordexe119** | Write | String | winword.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe122** | Write | String | exprwd.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe116** | Write | String | pptview.exe (Device) - Depends on L_Informationbar (0: False, 1: True) | `0`, `1` |
| **L_LocalMachineZoneLockdownSecurity** | Write | String | Local Machine Zone Lockdown Security (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_mse7exe41** | Write | String | mse7.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe31** | Write | String | powerpnt.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_mspubexe30** | Write | String | mspub.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_outlookexe36** | Write | String | outlook.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe32** | Write | String | pptview.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_excelexe29** | Write | String | excel.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe38** | Write | String | exprwd.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_grooveexe28** | Write | String | groove.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_winwordexe35** | Write | String | winword.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe39** | Write | String | msaccess.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe37** | Write | String | spDesign.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_visioexe33** | Write | String | visio.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe40** | Write | String | onent.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_winprojexe34** | Write | String | winproj.exe (Device) - Depends on L_LocalMachineZoneLockdownSecurity (0: False, 1: True) | `0`, `1` |
| **L_MimeSniffingSafetyFature** | Write | String | Mime Sniffing Safety Feature (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_powerpntexe59** | Write | String | powerpnt.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe66** | Write | String | exprwd.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_grooveexe56** | Write | String | groove.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_visioexe61** | Write | String | visio.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_outlookexe64** | Write | String | outlook.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_mspubexe58** | Write | String | mspub.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_mse7exe69** | Write | String | mse7.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe67** | Write | String | msaccess.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe60** | Write | String | pptview.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_winprojexe62** | Write | String | winproj.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe65** | Write | String | spDesign.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe68** | Write | String | onent.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_winwordexe63** | Write | String | winword.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_excelexe57** | Write | String | excel.exe (Device) - Depends on L_MimeSniffingSafetyFature (0: False, 1: True) | `0`, `1` |
| **L_NavigateURL** | Write | String | Navigate URL (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_spdesignexe177** | Write | String | spDesign.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe180** | Write | String | onent.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe172** | Write | String | pptview.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_outlookexe176** | Write | String | outlook.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_winprojexe174** | Write | String | winproj.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe179** | Write | String | msaccess.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_winwordexe175** | Write | String | winword.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_excelexe169** | Write | String | excel.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_mspubexe170** | Write | String | mspub.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe178** | Write | String | exprwd.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe171** | Write | String | powerpnt.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_visioexe173** | Write | String | visio.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_mse7exe181** | Write | String | mse7.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_grooveexe168** | Write | String | groove.exe (Device) - Depends on L_NavigateURL (0: False, 1: True) | `0`, `1` |
| **L_ObjectCachingProtection** | Write | String | Object Caching Protection (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_winwordexe77** | Write | String | winword.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe73** | Write | String | powerpnt.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe79** | Write | String | spDesign.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_mse7exe83** | Write | String | mse7.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_mspubexe72** | Write | String | mspub.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe81** | Write | String | msaccess.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe82** | Write | String | onent.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_outlookexe78** | Write | String | outlook.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_grooveexe70** | Write | String | groove.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_excelexe71** | Write | String | excel.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_visioexe75** | Write | String | visio.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe74** | Write | String | pptview.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_winprojexe76** | Write | String | winproj.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe80** | Write | String | exprwd.exe (Device) - Depends on L_ObjectCachingProtection (0: False, 1: True) | `0`, `1` |
| **L_ProtectionFromZoneElevation** | Write | String | Protection From Zone Elevation (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_mspubexe100** | Write | String | mspub.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_visioexe103** | Write | String | visio.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe101** | Write | String | powerpnt.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_excelexe99** | Write | String | excel.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_mse7exe111** | Write | String | mse7.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_winwordexe105** | Write | String | winword.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe108** | Write | String | exprwd.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe109** | Write | String | msaccess.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe107** | Write | String | spDesign.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe110** | Write | String | onent.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe102** | Write | String | pptview.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_winprojexe104** | Write | String | winproj.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_grooveexe98** | Write | String | groove.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_outlookexe106** | Write | String | outlook.exe (Device) - Depends on L_ProtectionFromZoneElevation (0: False, 1: True) | `0`, `1` |
| **L_RestrictActiveXInstall** | Write | String | Restrict ActiveX Install (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_mse7exe** | Write | String | mse7.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe** | Write | String | powerpnt.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_spDesignexe** | Write | String | spDesign.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe** | Write | String | onent.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_excelexe** | Write | String | excel.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_mspubexe** | Write | String | mspub.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_visioexe** | Write | String | visio.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe** | Write | String | exprwd.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_outlookexe** | Write | String | outlook.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe** | Write | String | pptview.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_winprojexe** | Write | String | winproj.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_winwordexe** | Write | String | winword.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_grooveexe** | Write | String | groove.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe** | Write | String | msaccess.exe (Device) - Depends on L_RestrictActiveXInstall (0: False, 1: True) | `0`, `1` |
| **L_RestrictFileDownload** | Write | String | Restrict File Download (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_visioexe5** | Write | String | visio.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_winprojexe6** | Write | String | winproj.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe11** | Write | String | msaccess.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe9** | Write | String | spDesign.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_excelexe1** | Write | String | excel.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe3** | Write | String | powerpnt.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_mspubexe2** | Write | String | mspub.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe10** | Write | String | exprwd.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_outlookexe8** | Write | String | outlook.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe4** | Write | String | pptview.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_winwordexe7** | Write | String | winword.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe12** | Write | String | onent.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_mse7exe13** | Write | String | mse7.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_grooveexe0** | Write | String | groove.exe (Device) - Depends on L_RestrictFileDownload (0: False, 1: True) | `0`, `1` |
| **L_SavedfromURL** | Write | String | Saved from URL (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_pptviewexe158** | Write | String | pptview.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_exprwdexe164** | Write | String | exprwd.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_mse7exe167** | Write | String | mse7.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe163** | Write | String | spDesign.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_winprojexe160** | Write | String | winproj.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_mspubexe156** | Write | String | mspub.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_visioexe159** | Write | String | visio.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_winwordexe161** | Write | String | winword.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe165** | Write | String | msaccess.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe166** | Write | String | onent.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_outlookexe162** | Write | String | outlook.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_grooveexe154** | Write | String | groove.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_excelexe155** | Write | String | excel.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe157** | Write | String | powerpnt.exe (Device) - Depends on L_SavedfromURL (0: False, 1: True) | `0`, `1` |
| **L_ScriptedWindowSecurityRestrictions** | Write | String | Scripted Window Security Restrictions (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_exprwdexe94** | Write | String | exprwd.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_mse7exe97** | Write | String | mse7.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_mspubexe86** | Write | String | mspub.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_outlookexe92** | Write | String | outlook.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_msaccessexe95** | Write | String | msaccess.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_powerpntexe87** | Write | String | powerpnt.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_grooveexe84** | Write | String | groove.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_excelexe85** | Write | String | excel.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_pptviewexe88** | Write | String | pptview.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_spdesignexe93** | Write | String | spDesign.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_visioexe89** | Write | String | visio.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_onenoteexe96** | Write | String | onent.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_winprojexe90** | Write | String | winproj.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |
| **L_winwordexe91** | Write | String | winword.exe (Device) - Depends on L_ScriptedWindowSecurityRestrictions (0: False, 1: True) | `0`, `1` |

### MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **MicrosoftAccess_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftAccess_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftAccess_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftAccess_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftAccess_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftAccess_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty** | Write | String |  - Depends on MicrosoftAccess_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **L_Donotshowdataextractionoptionswhenopeningcorruptworkbooks** | Write | String | Do not show data extraction options when opening corrupt workbooks (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Asktoupdateautomaticlinks** | Write | String | Ask to update automatic links (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_LoadpicturesfromWebpagesnotcreatedinExcel** | Write | String | Load pictures from Web pages not created in Excel (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DisableAutoRepublish** | Write | String | Disable AutoRepublish (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DoNotShowAutoRepublishWarningAlert** | Write | String | Do not show AutoRepublish warning alert (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Forcefileextenstionstomatch** | Write | String | Force file extension to match file type (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Forcefileextenstionstomatch_L_Empty** | Write | String |  - Depends on L_Forcefileextenstionstomatch (0: Allow different, 1: Allow different, but warn, 2: Always match file type) | `0`, `1`, `2` |
| **L_DeterminewhethertoforceencryptedExcel** | Write | String | Scan encrypted macros in Excel Open XML workbooks (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DeterminewhethertoforceencryptedExcelDropID** | Write | String |  - Depends on L_DeterminewhethertoforceencryptedExcel (0: Scan encrypted macros (default), 1: Scan if anti-virus software available, 2: Load macros without scanning) | `0`, `1`, `2` |
| **L_BlockXLLFromInternet** | Write | String | Block Excel XLL Add-ins that come from an untrusted source (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_BlockXLLFromInternetEnum** | Write | String |  - Depends on L_BlockXLLFromInternet (1: Block, 0: Show Additional Warning, 2: Allow) | `1`, `0`, `2` |
| **MicrosoftExcel_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_EnableBlockUnsecureQueryFiles** | Write | String | Always prevent untrusted Microsoft Query files from opening (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DBaseIIIANDIVFiles** | Write | String | dBase III / IV files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DBaseIIIANDIVFilesDropID** | Write | String | File block setting: (User) - Depends on L_DBaseIIIANDIVFiles (0: Do not block, 2: Open/Save blocked, use open policy) | `0`, `2` |
| **L_DifAndSylkFiles** | Write | String | Dif and Sylk files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DifAndSylkFilesDropID** | Write | String | File block setting: (User) - Depends on L_DifAndSylkFiles (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy) | `0`, `1`, `2` |
| **L_Excel2MacrosheetsAndAddInFiles** | Write | String | Excel 2 macrosheets and add-in files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel2MacrosheetsAndAddInFilesDropID** | Write | String | File block setting: (User) - Depends on L_Excel2MacrosheetsAndAddInFiles (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel2Worksheets** | Write | String | Excel 2 worksheets (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel2WorksheetsDropID** | Write | String | File block setting: (User) - Depends on L_Excel2Worksheets (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel3MacrosheetsAndAddInFiles** | Write | String | Excel 3 macrosheets and add-in files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel3MacrosheetsAndAddInFilesDropID** | Write | String | File block setting: (User) - Depends on L_Excel3MacrosheetsAndAddInFiles (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel3Worksheets** | Write | String | Excel 3 worksheets (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel3WorksheetsDropID** | Write | String | File block setting: (User) - Depends on L_Excel3Worksheets (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel4MacrosheetsAndAddInFiles** | Write | String | Excel 4 macrosheets and add-in files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel4MacrosheetsAndAddInFilesDropID** | Write | String | File block setting: (User) - Depends on L_Excel4MacrosheetsAndAddInFiles (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel4Workbooks** | Write | String | Excel 4 workbooks (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel4WorkbooksDropID** | Write | String | File block setting: (User) - Depends on L_Excel4Workbooks (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel4Worksheets** | Write | String | Excel 4 worksheets (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel4WorksheetsDropID** | Write | String | File block setting: (User) - Depends on L_Excel4Worksheets (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel95Workbooks** | Write | String | Excel 95 workbooks (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel95WorkbooksDropID** | Write | String | File block setting: (User) - Depends on L_Excel95Workbooks (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `1`, `2`, `3`, `4`, `5` |
| **L_Excel9597WorkbooksAndTemplates** | Write | String | Excel 95-97 workbooks and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel9597WorkbooksAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Excel9597WorkbooksAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Excel972003WorkbooksAndTemplates** | Write | String | Excel 97-2003 workbooks and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Excel972003WorkbooksAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Excel972003WorkbooksAndTemplates (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `1`, `2`, `3`, `4`, `5` |
| **MicrosoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior** | Write | String | Set default file block behavior (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID** | Write | String |  - Depends on MicrosoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior (0: Blocked files are not opened, 1: Blocked files open in Protected View and can not be edited, 2: Blocked files open in Protected View and can be edited) | `0`, `1`, `2` |
| **L_WebPagesAndExcel2003XMLSpreadsheets** | Write | String | Web pages and Excel 2003 XML spreadsheets (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_WebPagesAndExcel2003XMLSpreadsheetsDropID** | Write | String | File block setting: (User) - Depends on L_WebPagesAndExcel2003XMLSpreadsheets (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `1`, `2`, `3`, `4`, `5` |
| **L_XL4KillSwitchPolicy** | Write | String | Prevent Excel from running XLM macros (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_EnableDataBaseFileProtectedView** | Write | String | Always open untrusted database files in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView** | Write | String | Do not open files from the Internet zone in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView** | Write | String | Do not open files in unsafe locations in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails** | Write | String | Set document behavior if file validation fails (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3** | Write | String | Checked: Allow edit.  Unchecked: Do not allow edit. (User) - Depends on MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: False, 1: True) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID** | Write | String |  - Depends on MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: Block files, 1: Open in Protected View) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook** | Write | String | Turn off Protected View for attachments opened from Outlook (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) - Depends on MicrosoftExcel_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftExcel_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty4** | Write | String |  - Depends on MicrosoftExcel_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable VBA macros with notification, 3: Disable VBA macros except digitally signed macros, 4: Disable VBA macros without notification, 1: Enable VBA macros (not recommended)) | `2`, `3`, `4`, `1` |
| **MicrosoftExcel_Security_L_TurnOffFileValidation** | Write | String | Turn off file validation (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_WebContentWarningLevel** | Write | String | WEBSERVICE Function Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_WebContentWarningLevelValue** | Write | String |  - Depends on L_WebContentWarningLevel (0: Enable all WEBSERVICE functions (not recommended), 1: Disable all with notification, 2: Disable all without notification) | `0`, `1`, `2` |
| **L_NoExtensibilityCustomizationFromDocumentPolicy** | Write | String | Disable UI extending from documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyWord** | Write | String | Disallow in Word (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyExcel** | Write | String | Disallow in Excel (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyVisio** | Write | String | Disallow in Visio (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyPowerPoint** | Write | String | Disallow in PowerPoint (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyPublisher** | Write | String | Disallow in Publisher (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyOutlook** | Write | String | Disallow in Outlook (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyProject** | Write | String | Disallow in Project (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyAccess** | Write | String | Disallow in Access (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_NoExtensibilityCustomizationFromDocumentPolicyInfoPath** | Write | String | Disallow in InfoPath (User) - Depends on L_NoExtensibilityCustomizationFromDocumentPolicy (0: False, 1: True) | `0`, `1` |
| **L_ActiveXControlInitialization** | Write | String | ActiveX Control Initialization (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_ActiveXControlInitializationcolon** | Write | String | ActiveX Control Initialization: (User) - Depends on L_ActiveXControlInitialization (1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6) | `1`, `2`, `3`, `4`, `5`, `6` |
| **L_BasicAuthProxyBehavior** | Write | String | Allow Basic Authentication prompts from network proxies (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AllowVbaIntranetRefs** | Write | String | Allow VBA to load typelib references by path from untrusted intranet locations (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AutomationSecurity** | Write | String | Automation Security (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_SettheAutomationSecuritylevel** | Write | String | Set the Automation Security level (User) - Depends on L_AutomationSecurity (3: Disable macros by default, 2: Use application macro security level, 1: Macros enabled (default)) | `3`, `2`, `1` |
| **L_AuthenticationFBABehavior** | Write | String | Control how Office handles form-based sign-in prompts (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AuthenticationFBAEnabledHostsID** | Write | String | Specify hosts allowed to show form-based sign-in prompts to users: (User) - Depends on L_AuthenticationFBABehavior | |
| **L_authenticationFBABehaviorEnum** | Write | String | Behavior: (User) - Depends on L_AuthenticationFBABehavior (1: Block all prompts, 2: Ask the user what to do for each new host, 3: Show prompts only from allowed hosts) | `1`, `2`, `3` |
| **L_DisableStrictVbaRefsSecurityPolicy** | Write | String | Disable additional security checks on VBA library references that may refer to unsafe locations on the local machine (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DisableallTrustBarnotificationsfor** | Write | String | Disable all Trust Bar notifications for security issues (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Encryptiontypeforirm** | Write | String | Encryption mode for Information Rights Management (IRM) (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Encryptiontypeforirmcolon** | Write | String | IRM Encryption Mode: (User) - Depends on L_Encryptiontypeforirm (1: Cipher Block Chaining (CBC), 2: Electronic Codebook (ECB)) | `1`, `2` |
| **L_Encryptiontypeforpasswordprotectedoffice972003** | Write | String | Encryption type for password protected Office 97-2003 files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_encryptiontypecolon318** | Write | String | Encryption type: (User) - Depends on L_Encryptiontypeforpasswordprotectedoffice972003 | |
| **L_Encryptiontypeforpasswordprotectedofficeopen** | Write | String | Encryption type for password protected Office Open XML files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Encryptiontypecolon** | Write | String | Encryption type: (User) - Depends on L_Encryptiontypeforpasswordprotectedofficeopen | |
| **L_LoadControlsinForms3** | Write | String | Load Controls in Forms3 (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_LoadControlsinForms3colon** | Write | String | Load Controls in Forms3: (User) - Depends on L_LoadControlsinForms3 (1: 1, 2: 2, 3: 3, 4: 4) | `1`, `2`, `3`, `4` |
| **L_MacroRuntimeScanScope** | Write | String | Macro Runtime Scan Scope (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_MacroRuntimeScanScopeEnum** | Write | String |  - Depends on L_MacroRuntimeScanScope (0: Disable for all documents, 1: Enable for low trust documents, 2: Enable for all documents) | `0`, `1`, `2` |
| **L_Protectdocumentmetadataforrightsmanaged** | Write | String | Protect document metadata for rights managed Office Open XML Files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Allowmixofpolicyanduserlocations** | Write | String | Allow mix of policy and user locations (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DisabletheOfficeclientfrompolling** | Write | String | Disable the Office client from polling the SharePoint Server for published links (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DisableSmartDocumentsuseofmanifests** | Write | String | Disable Smart Document's use of manifests (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OutlookSecurityMode** | Write | String | Outlook Security Mode (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMAddressAccess** | Write | String | Configure Outlook object model prompt when reading address information (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMAddressAccess_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_OOMMeetingTaskRequest** | Write | String | Configure Outlook object model prompt when responding to meeting and task requests (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMMeetingTaskRequest_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_OOMSend** | Write | String | Configure Outlook object model prompt when sending mail (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMSend_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_Preventusersfromcustomizingattachmentsecuritysettings** | Write | String | Prevent users from customizing attachment security settings (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_RetrievingCRLsCertificateRevocationLists** | Write | String | Retrieving CRLs (Certificate Revocation Lists) (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty31** | Write | String |  (0: Use system Default, 1: When online always retreive the CRL, 2: Never retreive the CRL) | `0`, `1`, `2` |
| **L_OOMFormula** | Write | String | Configure Outlook object model prompt When accessing the Formula property of a UserProperty object (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMFormula_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_AuthenticationwithExchangeServer** | Write | String | Authentication with Exchange Server (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_SelecttheauthenticationwithExchangeserver** | Write | String | Select the authentication with Exchange server. (User) (9: Kerberos/NTLM Password Authentication, 16: Kerberos Password Authentication, 10: NTLM Password Authentication, 2147545088: Insert a smart card) | `9`, `16`, `10`, `2147545088` |
| **L_EnableRPCEncryption** | Write | String | Enable RPC encryption (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Enablelinksinemailmessages** | Write | String | Allow hyperlinks in suspected phishing e-mail messages (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMAddressBook** | Write | String | Configure Outlook object model prompt when accessing an address book (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMAddressBook_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_OutlookSecurityPolicy** | Write | String | Outlook Security Policy: (User) - Depends on L_OutlookSecurityMode (0: Outlook Default Security, 1: Use Security Form from 'Outlook Security Settings' Public Folder, 2: Use Security Form from 'Outlook 10 Security Settings' Public Folder, 3: Use Outlook Security Group Policy) | `0`, `1`, `2`, `3` |
| **L_AllowUsersToLowerAttachments** | Write | String | Allow users to demote attachments to Level 2 (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AllowActiveXOneOffForms** | Write | String | Allow Active X One Off Forms (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty29** | Write | String | Sets which ActiveX controls to allow. (0: Load only Outlook Controls, 1: Allows only Safe Controls, 2: Allows all ActiveX Controls) | `0`, `1`, `2` |
| **L_EnableScriptsInOneOffForms** | Write | String | Allow scripts in one-off Outlook forms (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Level2RemoveFilePolicy** | Write | String | Remove file extensions blocked as Level 2 (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_removedextensions25** | Write | String | Removed Extensions: (User) | |
| **L_MSGUnicodeformatwhendraggingtofilesystem** | Write | String | Use Unicode format when dragging e-mail message to file system (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OnExecuteCustomActionOOM** | Write | String | Set Outlook object model custom actions execution prompt (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OnExecuteCustomActionOOM_Setting** | Write | String | When executing a custom action: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_DisableOutlookobjectmodelscriptsforpublicfolders** | Write | String | Do not allow Outlook object model scripts to run for public folders (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_BlockInternet** | Write | String | Include Internet in Safe Zones for Automatic Picture Download (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_SecurityLevelOutlook** | Write | String | Security setting for macros (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_SecurityLevel** | Write | String | Security Level (User) (2: Always warn, 4: Never warn, disable all, 3: Warn for signed, disable unsigned, 1: No security check) | `2`, `4`, `3`, `1` |
| **L_Level1RemoveFilePolicy** | Write | String | Remove file extensions blocked as Level 1 (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_RemovedExtensions** | Write | String | Removed Extensions: (User) | |
| **L_SignatureWarning** | Write | String | Signature Warning (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_signaturewarning30** | Write | String | Signature Warning (User) (0: Let user decide if they want to be warned, 1: Always warn about invalid signatures, 2: Never warn about invalid signatures) | `0`, `1`, `2` |
| **L_Level1Attachments** | Write | String | Display Level 1 attachments (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Minimumencryptionsettings** | Write | String | Minimum encryption settings (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Minimumkeysizeinbits** | Write | SInt32 | Minimum key size (in bits): (User) | |
| **L_DisableOutlookobjectmodelscripts** | Write | String | Do not allow Outlook object model scripts to run for shared folders (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMSaveAs** | Write | String | Configure Outlook object model prompt when executing Save As (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_OOMSaveAs_Setting** | Write | String | Guard behavior: (User) (1: Prompt User, 2: Automatically Approve, 0: Automatically Deny, 3: Prompt user based on computer security) | `1`, `2`, `0`, `3` |
| **L_JunkEmailprotectionlevel** | Write | String | Junk E-mail protection level (User) - Depends on L_OutlookSecurityMode (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Selectlevel** | Write | String | Select level: (User) (4294967295: No Protection, 6: Low (Default), 3: High, 2147483648: Trusted Lists Only) | `4294967295`, `6`, `3`, `2147483648` |
| **L_RunPrograms** | Write | String | Run Programs (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_RunPrograms_L_Empty** | Write | String |  - Depends on L_RunPrograms (0: disable (don't run any programs), 1: enable (prompt user before running), 2: enable all (run without prompting)) | `0`, `1`, `2` |
| **L_Determinewhethertoforceencryptedppt** | Write | String | Scan encrypted macros in PowerPoint Open XML presentations (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DeterminewhethertoforceencryptedpptDropID** | Write | String |  - Depends on L_Determinewhethertoforceencryptedppt (0: Scan encrypted macros (default), 1: Scan if anti-virus software available, 2: Load macros without scanning) | `0`, `1`, `2` |
| **MicrosoftPowerPoint_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_PowerPoint972003PresentationsShowsTemplatesandAddInFiles** | Write | String | PowerPoint 97-2003 presentations, shows, templates and add-in files (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_PowerPoint972003PresentationsShowsTemplatesandAddInFilesDropID** | Write | String | File block setting: (User) - Depends on L_PowerPoint972003PresentationsShowsTemplatesandAddInFiles (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `1`, `2`, `3`, `4`, `5` |
| **MicrosoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior** | Write | String | Set default file block behavior (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID** | Write | String |  - Depends on MicrosoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior (0: Blocked files are not opened, 1: Blocked files open in Protected View and can not be edited, 2: Blocked files open in Protected View and can be edited) | `0`, `1`, `2` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView** | Write | String | Do not open files from the Internet zone in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView** | Write | String | Do not open files in unsafe locations in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails** | Write | String | Set document behavior if file validation fails (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3** | Write | String | Checked: Allow edit.  Unchecked: Do not allow edit. (User) - Depends on MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: False, 1: True) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID** | Write | String |  - Depends on MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: Block files, 1: Open in Protected View) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook** | Write | String | Turn off Protected View for attachments opened from Outlook (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) - Depends on MicrosoftPowerPoint_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPowerPoint_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty3** | Write | String |  - Depends on MicrosoftPowerPoint_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **MicrosoftPowerPoint_Security_L_TurnOffFileValidation** | Write | String | Turn off file validation (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) - Depends on MicrosoftProject_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftProject_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty** | Write | String |  - Depends on MicrosoftProject_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **L_PublisherAutomationSecurityLevel** | Write | String | Publisher Automation Security Level (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_PublisherAutomationSecurityLevel_L_Empty** | Write | String |  - Depends on L_PublisherAutomationSecurityLevel (1: Low (enabled), 2: By UI (prompted), 3: High (disabled)) | `1`, `2`, `3` |
| **MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPublisherV2_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins (User) - Depends on MicrosoftPublisherV2_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftPublisherV2_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty0** | Write | String |  - Depends on MicrosoftPublisherV2_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Visio2000Files** | Write | String | Visio 2000-2002 Binary Drawings, Templates and Stencils (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Visio2000FilesDropID** | Write | String | File block setting: (User) - Depends on L_Visio2000Files (0: Do not block, 2: Open/Save blocked) | `0`, `2` |
| **L_Visio2003Files** | Write | String | Visio 2003-2010 Binary Drawings, Templates and Stencils (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Visio2003FilesDropID** | Write | String | File block setting: (User) - Depends on L_Visio2003Files (0: Do not block, 1: Save blocked, 2: Open/Save blocked) | `0`, `1`, `2` |
| **L_Visio50AndEarlierFiles** | Write | String | Visio 5.0 or earlier Binary Drawings, Templates and Stencils (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Visio50AndEarlierFilesDropID** | Write | String | File block setting: (User) - Depends on L_Visio50AndEarlierFiles (0: Do not block, 2: Open/Save blocked) | `0`, `2` |
| **MicrosoftVisio_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) - Depends on MicrosoftVisio_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty** | Write | String |  - Depends on MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **MicrosoftWord_Security_TrustCenter_L_BlockMacroExecutionFromInternet** | Write | String | Block macros from running in Office files from the Internet (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) (Deprecated) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AllowDDE** | Write | String | Dynamic Data Exchange (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_AllowDDEDropID** | Write | String | Dynamic Data Exchange setting (User) - Depends on L_AllowDDE (1: Limited Dynamic Data Exchange, 2: Allow Dynamic Data Exchange) | `1`, `2` |
| **MicrosoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior** | Write | String | Set default file block behavior (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID** | Write | String |  - Depends on MicrosoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior (0: Blocked files are not opened, 1: Blocked files open in Protected View and can not be edited, 2: Blocked files open in Protected View and can be edited) | `0`, `1`, `2` |
| **L_Word2AndEarlierBinaryDocumentsAndTemplates** | Write | String | Word 2 and earlier binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word2AndEarlierBinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word2AndEarlierBinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Word2000BinaryDocumentsAndTemplates** | Write | String | Word 2000 binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word2000BinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word2000BinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Word2003BinaryDocumentsAndTemplates** | Write | String | Word 2003 binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word2003BinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word2003BinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Word2007AndLaterBinaryDocumentsAndTemplates** | Write | String | Word 2007 and later binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word2007AndLaterBinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word2007AndLaterBinaryDocumentsAndTemplates (0: Do not block, 1: Save blocked, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `1`, `2`, `3`, `4`, `5` |
| **L_Word6Pt0BinaryDocumentsAndTemplates** | Write | String | Word 6.0 binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word6Pt0BinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word6Pt0BinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Word95BinaryDocumentsAndTemplates** | Write | String | Word 95 binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word95BinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word95BinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_Word97BinaryDocumentsAndTemplates** | Write | String | Word 97 binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_Word97BinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_Word97BinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **L_WordXPBinaryDocumentsAndTemplates** | Write | String | Word XP binary documents and templates (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_WordXPBinaryDocumentsAndTemplatesDropID** | Write | String | File block setting: (User) - Depends on L_WordXPBinaryDocumentsAndTemplates (0: Do not block, 2: Open/Save blocked, use open policy, 3: Block, 4: Open in Protected View, 5: Allow editing and open in Protected View) | `0`, `2`, `3`, `4`, `5` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView** | Write | String | Do not open files from the Internet zone in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView** | Write | String | Do not open files in unsafe locations in Protected View (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails** | Write | String | Set document behavior if file validation fails (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID** | Write | String |  - Depends on MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: Block files, 1: Open in Protected View) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3** | Write | String | Checked: Allow edit.  Unchecked: Do not allow edit. (User) - Depends on MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails (0: False, 1: True) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook** | Write | String | Turn off Protected View for attachments opened from Outlook (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned** | Write | String | Require that application add-ins are signed by Trusted Publisher (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2** | Write | String | Disable Trust Bar Notification for unsigned application add-ins and block them (User) - Depends on MicrosoftWord_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DeterminewhethertoforceencryptedWord** | Write | String | Scan encrypted macros in Word Open XML documents (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_DeterminewhethertoforceencryptedWordDropID** | Write | String |  - Depends on L_DeterminewhethertoforceencryptedWord (0: Scan encrypted macros (default), 1: Scan if anti-virus software available, 2: Load macros without scanning) | `0`, `1`, `2` |
| **MicrosoftWord_Security_TrustCenter_L_VBAWarningsPolicy** | Write | String | VBA Macro Notification Settings (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **L_empty19** | Write | String |  - Depends on MicrosoftWord_Security_TrustCenter_L_VBAWarningsPolicy (2: Disable all with notification, 3: Disable all except digitally signed macros, 4: Disable all without notification, 1: Enable all macros (not recommended)) | `2`, `3`, `4`, `1` |
| **MicrosoftWord_Security_L_TurnOffFileValidation** | Write | String | Turn off file validation (User) (0: Disabled, 1: Enabled) | `0`, `1` |
| **MicrosoftWord_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork** | Write | String | Allow Trusted Locations on the network (User) (0: Disabled, 1: Enabled) | `0`, `1` |


## Description

Intune Security Baseline Microsoft365 Apps For Enterprise

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineMicrosoft365AppsForEnterprise 'mySecurityBaselineMicrosoft365AppsForEnterprisePolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                L_ProtectionFromZoneElevation = '1'
                L_grooveexe98 = '1'
                L_excelexe99 = '1'
                L_mspubexe100 = '1'
                L_powerpntexe101 = '1'
                L_pptviewexe102 = '1'
                L_visioexe103 = '1'
                L_winprojexe104 = '1'
                L_winwordexe105 = '1'
                L_outlookexe106 = '1'
                L_spdesignexe107 = '1'
                L_exprwdexe108 = '1'
                L_msaccessexe109 = '1'
                L_onenoteexe110 = '1'
                L_mse7exe111 = '1'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty = '3'
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineMicrosoft365AppsForEnterprise 'mySecurityBaselineMicrosoft365AppsForEnterprisePolicy'
        {
            DisplayName           = 'test'
            DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                L_ProtectionFromZoneElevation = '1'
                L_grooveexe98 = '1'
                L_excelexe99 = '1'
                L_mspubexe100 = '1'
                L_powerpntexe101 = '1'
                L_pptviewexe102 = '1'
                L_visioexe103 = '1'
                L_winprojexe104 = '1'
                L_winwordexe105 = '1'
                L_outlookexe106 = '1'
                L_spdesignexe107 = '1'
                L_exprwdexe108 = '1'
                L_msaccessexe109 = '1'
                L_onenoteexe110 = '1'
                L_mse7exe111 = '1'
            }
            UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
            {
                MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy = '1'
                MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty = '2' # Updated property
            }
            Ensure                = 'Present'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        IntuneSecurityBaselineMicrosoft365AppsForEnterprise 'mySecurityBaselineMicrosoft365AppsForEnterprisePolicy'
        {
            DisplayName           = 'test'
            Ensure                = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

