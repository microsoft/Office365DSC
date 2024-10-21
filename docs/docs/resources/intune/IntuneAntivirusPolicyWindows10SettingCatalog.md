# IntuneAntivirusPolicyWindows10SettingCatalog

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | Display name of the endpoint protection policy for Windows 10. | |
| **Identity** | Write | String | Identity of the endpoint protection policy for Windows 10. | |
| **Description** | Write | String | Description of the endpoint protection policy for Windows 10. | |
| **tamperprotection** | Write | String | Allows or disallows scanning of archives. (0: enable feature. 1: disable feature) | `0`, `1` |
| **disableaccountprotectionui** | Write | String | Use this policy setting to specify if to display the Account protection area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disableappbrowserui** | Write | String | Use this policy setting if you want to disable the display of the app and browser protection area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disablecleartpmbutton** | Write | String | Disable the Clear TPM button in Windows Security. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disabledevicesecurityui** | Write | String | Use this policy setting if you want to disable the display of the Device security area in the Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disablefamilyui** | Write | String | Use this policy setting if you want to disable the display of the family options area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disablehealthui** | Write | String | Use this policy setting if you want to disable the display of the device performance and health area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disablenetworkui** | Write | String | Use this policy setting if you want to disable the display of the firewall and network protection area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disableenhancednotifications** | Write | String | Use this policy setting if you want to disable the display of Windows Defender Security Center notifications. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disabletpmfirmwareupdatewarning** | Write | String | Hide the recommendation to update TPM Firmware when a vulnerable firmware is detected. (0: disable feature. 1: enable feature) | `0`, `1` |
| **disablevirusui** | Write | String | Use this policy setting if you want to disable the display of the virus and threat protection area in Windows Defender Security Center.  (0: disable feature. 1: enable feature) | `0`, `1` |
| **hideransomwaredatarecovery** | Write | String | Use this policy setting to hide the Ransomware data recovery area in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **hidewindowssecuritynotificationareacontrol** | Write | String | This policy setting hides the Windows Security notification area control. (0: disable feature. 1: enable feature) | `0`, `1` |
| **enablecustomizedtoasts** | Write | String | Enable this policy to display your company name and contact options in the notifications. (0: disable feature. 1: enable feature) | `0`, `1` |
| **enableinappcustomization** | Write | String | Enable this policy to have your company name and contact options displayed in a contact card fly out in Windows Defender Security Center. (0: disable feature. 1: enable feature) | `0`, `1` |
| **companyname** | Write | String | The company name that is displayed to the users. CompanyName is required for both EnableCustomizedToasts and EnableInAppCustomization. | |
| **email** | Write | String | The email address that is displayed to users. The default mail application is used to initiate email actions. | |
| **phone** | Write | String | The phone number or Skype ID that is displayed to users. Skype is used to initiate the call. | |
| **url** | Write | String | The help portal URL that is displayed to users. The default browser is used to initiate this action. | |
| **allowarchivescanning** | Write | String | Allows or disallows scanning of archives. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowbehaviormonitoring** | Write | String | Allows or disallows Windows Defender Behavior Monitoring functionality. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowcloudprotection** | Write | String | To best protect your PC, Windows Defender will send information to Microsoft about any problems it finds. Microsoft will analyze that information, learn more about problems affecting you and other customers, and offer improved solutions. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowdatagramprocessingonwinserver** | Write | String | Allows or disallows Network Protection to enable datagram processing on Windows Server. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowemailscanning** | Write | String | Allows or disallows scanning of email. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowfullscanonmappednetworkdrives** | Write | String | Allows or disallows a full scan of mapped network drives. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowfullscanremovabledrivescanning** | Write | String | Allows or disallows a full scan of removable drives. During a quick scan, removable drives may still be scanned. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowintrusionpreventionsystem** | Write | String | https://github.com/MicrosoftDocs/memdocs/issues/2250 (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowioavprotection** | Write | String | Allows or disallows Windows Defender IOAVP Protection functionality. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allownetworkprotectiondownlevel** | Write | String | Allows or disallows Network Protection to be configured into block or audit mode on windows downlevel of RS3. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowrealtimemonitoring** | Write | String | Allows or disallows Windows Defender real-time Monitoring functionality. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowscanningnetworkfiles** | Write | String | Allows or disallows a scanning of network files. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowscriptscanning** | Write | String | Allows or disallows Windows Defender Script Scanning functionality. (0: disable feature. 1: enable feature) | `0`, `1` |
| **allowuseruiaccess** | Write | String | Allows or disallows user access to the Windows Defender UI. I disallowed, all Windows Defender notifications will also be suppressed. (0: Prevents users from accessing UI. 1: Lets users access UI) | `0`, `1` |
| **avgcpuloadfactor** | Write | SInt32 | Represents the average CPU load factor for the Windows Defender scan (in percent). | |
| **archivemaxdepth** | Write | SInt32 | Specify the maximum folder depth to extract from archive files for scanning. | |
| **archivemaxsize** | Write | SInt32 | Specify the maximum size, in KB, of archive files to be extracted and scanned. | |
| **checkforsignaturesbeforerunningscan** | Write | String | This policy setting allows you to manage whether a check for new virus and spyware definitions will occur before running a scan. (0: disable feature. 1: enable feature) | `0`, `1` |
| **cloudblocklevel** | Write | String | This policy setting determines how aggressive Microsoft Defender Antivirus will be in blocking and scanning suspicious files. Value type is integer.(0: Default windows defender blocking level, 2: High blocking level, 4:High+ blocking level, 6:Zero tolerance blocking level) | `0`, `2`, `4`, `6` |
| **cloudextendedtimeout** | Write | SInt32 | This feature allows Microsoft Defender Antivirus to block a suspicious file for up to 60 seconds, and scan it in the cloud to make sure it's safe. Value type is integer, range is 0 - 50. | |
| **daystoretaincleanedmalware** | Write | SInt32 | Time period (in days) that quarantine items will be stored on the system. | |
| **disablecatchupfullscan** | Write | String | This policy setting allows you to configure catch-up scans for scheduled full scans.  (1: disabled, 0: enabled) | `0`, `1` |
| **disablecatchupquickscan** | Write | String | This policy setting allows you to configure catch-up scans for scheduled quick scans.  (1: disabled, 0: enabled) | `0`, `1` |
| **disablednsovertcpparsing** | Write | String | Disables or enables DNS over TCP Parsing for Network Protection. (0: enable feature. 1: disable feature) | `0`, `1` |
| **disablehttpparsing** | Write | String | Disables or enables HTTP Parsing for Network Protection. (0: enable feature. 1: disable feature) | `0`, `1` |
| **DisableSshParsing** | Write | String | Disable Ssh Parsing (1: SSH parsing is disabled, 0: SSH parsing is enabled) | `1`, `0` |
| **enablelowcpupriority** | Write | String | This policy setting allows you to enable or disable low CPU priority for scheduled scans. (0: disable feature. 1: enable feature) | `0`, `1` |
| **enablenetworkprotection** | Write | String | This policy allows you to turn on network protection (block/audit) or off. (0: disabled, 1: block mode, 2: audit mode) | `0`, `1`, `2` |
| **excludedextensions** | Write | StringArray[] | Allows an administrator to specify a list of file type extensions to ignore during a scan. | |
| **excludedpaths** | Write | StringArray[] | Allows an administrator to specify a list of directory paths to ignore during a scan. | |
| **excludedprocesses** | Write | StringArray[] | Allows an administrator to specify a list of files opened by processes to ignore during a scan. | |
| **puaprotection** | Write | String | Specifies the level of detection for potentially unwanted applications (PUAs). (0: disabled, 1: block mode, 2: audit mode) | `0`, `1`, `2` |
| **engineupdateschannel** | Write | String | Enable this policy to specify when devices receive Microsoft Defender engine updates during the monthly gradual rollout. (0: Not configured, 2: Beta Channel, 3: Current Channel (Preview), 4: Current Channel (Staged), 5: Current Channel (Broad), 6: Critical) | `0`, `2`, `3`, `4`, `5`, `6` |
| **meteredconnectionupdates** | Write | String | Allow managed devices to update through metered connections. (0: disabled, 1: enabled) | |
| **platformupdateschannel** | Write | String | Enable this policy to specify when devices receive Microsoft Defender platform updates during the monthly gradual rollout. (0: Not configured, 2: Beta Channel, 3: Current Channel (Preview), 4: Current Channel (Staged), 5: Current Channel (Broad), 6: Critical) | `0`, `2`, `3`, `4`, `5`, `6` |
| **securityintelligenceupdateschannel** | Write | String | Enable this policy to specify when devices receive Microsoft Defender security intelligence updates during the daily gradual rollout. (0: Not configured, 4: Current Channel (Staged), 5: Current Channel (Broad)) | `0`, `4`, `5` |
| **realtimescandirection** | Write | String | Controls which sets of files should be monitored. (0: Monitor all files (bi-directional), 1: Monitor incoming files, 2: Monitor outgoing files) | `0`, `1`, `2` |
| **scanparameter** | Write | String | Selects whether to perform a quick scan or full scan. (1: Quick scan, 2: Full scan) | `1`, `2` |
| **schedulequickscantime** | Write | SInt32 | Selects the time of day that the Windows Defender quick scan should run. | |
| **schedulescanday** | Write | String | Selects the day that the Windows Defender scan should run. (0: Every day, 1: Sunday, 2: Monday, 3: Tuesday, 4: Wednesday, 5: Thursday, 6: Friday, 7: Saturday, 8: No scheduled scan) | `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8` |
| **schedulescantime** | Write | SInt32 | Selects the time of day that the Windows Defender scan should run. Must be between 0 and 1380 minutes. | |
| **disabletlsparsing** | Write | String | This setting disables TLS Parsing for Network Protection. (0: enabled, 1: disabled) | `0`, `1` |
| **randomizescheduletasktimes** | Write | String | Specifies if the start time of the scan is randomized. (0: no randomization, 1: randomized) | `0`, `1` |
| **schedulerrandomizationtime** | Write | SInt32 | This setting allows you to configure the scheduler randomization in hours. The randomization interval is [1 - 23] hours. | |
| **signatureupdatefallbackorder** | Write | StringArray[] | This policy setting allows you to define the order in which different definition update sources should be contacted. | |
| **signatureupdatefilesharessources** | Write | StringArray[] | This policy setting allows you to configure UNC file share sources for downloading definition updates. | |
| **signatureupdateinterval** | Write | SInt32 | Specifies the interval (in hours) that will be used to check for signatures, so instead of using the ScheduleDay and ScheduleTime the check for new signatures will be set according to the interval. Must be between 0 and 24 hours. | |
| **submitsamplesconsent** | Write | String | Checks for the user consent level in Windows Defender to send data. (0: Always prompt, 1: Send safe samples automatically, 2: Never send, 3: Send all samples automatically) | `0`, `1`, `2`, `3` |
| **disablelocaladminmerge** | Write | String | This policy setting controls whether or not complex list settings configured by a local administrator are merged with managed settings. (0: enable local admin merge, 1: disable local admin merge) | `0`, `1` |
| **allowonaccessprotection** | Write | String | Allows or disallows Windows Defender On Access Protection functionality. (0: disable feature. 1: enable feature) | `0`, `1` |
| **lowseveritythreats** | Write | String | Allows an administrator to specify low severity threats corresponding action ID to take. | `clean`, `quarantine`, `remove`, `allow`, `userdefined`, `block` |
| **moderateseveritythreats** | Write | String | Allows an administrator to specify moderate severity threats corresponding action ID to take. | `clean`, `quarantine`, `remove`, `allow`, `userdefined`, `block` |
| **severethreats** | Write | String | Allows an administrator to specify high severity threats corresponding action ID to take. | `clean`, `quarantine`, `remove`, `allow`, `userdefined`, `block` |
| **highseveritythreats** | Write | String | Allows an administrator to specify severe threats corresponding action ID to take. | `clean`, `quarantine`, `remove`, `allow`, `userdefined`, `block` |
| **templateId** | Write | String | Template Id of the policy. 0: Windows Security Experience, 1: Defender Update controls, 2: Microsoft Defender Antivirus exclusions, 3: Microsoft Defender Antivirus | `d948ff9b-99cb-4ee0-8012-1fbc09685377_1`, `e3f74c5a-a6de-411d-aef6-eb15628f3a0a_1`, `45fea5e9-280d-4da1-9792-fb5736da0ca9_1`, `804339ad-1553-4478-a742-138fb5807418_1` |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Intune Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Name of the Azure Active Directory tenant used for authentication. Format contoso.onmicrosoft.com | |
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


## Description

This resource configures an Intune Endpoint Protection Antivirus policy for a Windows 10 Device.
This policy setting enables the management of Microsoft Defender Antivirus for Windows 10 using the settings catalog.

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
        IntuneAntivirusPolicyWindows10SettingCatalog 'myAVWindows10Policy'
        {
            DisplayName        = 'av exclusions'
            Assignments        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                })
            Description        = ''
            excludedextensions = @('.exe')
            excludedpaths      = @('c:\folders\', 'c:\folders2\')
            excludedprocesses  = @('processes.exe', 'process2.exe')
            templateId         = '45fea5e9-280d-4da1-9792-fb5736da0ca9_1'
            Ensure             = 'Present'
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
        IntuneAntivirusPolicyWindows10SettingCatalog 'myAVWindows10Policy'
        {
            DisplayName        = 'av exclusions'
            Assignments        = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments {
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                })
            Description        = ''
            excludedextensions = @('.exe')
            excludedpaths      = @('c:\folders\', 'c:\folders2\')
            excludedprocesses  = @('processes.exe', 'process3.exe') # Updated Property
            templateId         = '45fea5e9-280d-4da1-9792-fb5736da0ca9_1'
            Ensure             = 'Present'
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
        IntuneAntivirusPolicyWindows10SettingCatalog 'myAVWindows10Policy'
        {
            DisplayName        = 'av exclusions'
            Ensure             = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

