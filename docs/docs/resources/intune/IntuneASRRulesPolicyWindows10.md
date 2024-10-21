# IntuneASRRulesPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Identity** | Write | String | Identity of the endpoint protection attack surface protection rules policy for Windows 10. | |
| **DisplayName** | Key | String | Display name of the endpoint protection attack surface protection rules policy for Windows 10. | |
| **Description** | Write | String | Description of the endpoint protection attack surface protection rules policy for Windows 10. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Assignments of the Intune Policy. | |
| **ProcessCreationType** | Write | String | This rule blocks processes created through PsExec and WMI from running. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **AdvancedRansomewareProtectionType** | Write | String | This rule provides an extra layer of protection against ransomware. | `notConfigured`, `userDefined`, `enable`, `auditMode` |
| **BlockPersistenceThroughWmiType** | Write | String | This rule prevents malware from abusing WMI to attain persistence on a device. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **ScriptObfuscatedMacroCodeType** | Write | String | This rule detects suspicious properties within an obfuscated script. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **OfficeMacroCodeAllowWin32ImportsType** | Write | String | This rule prevents VBA macros from calling Win32 APIs. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **OfficeAppsLaunchChildProcessType** | Write | String | This rule blocks Office apps from creating child processes. Office apps include Word, Excel, PowerPoint, OneNote, and Access. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **GuardMyFoldersType** | Write | String | This rule enable Controlled folder access which protects your data by checking apps against a list of known, trusted apps. | `notConfigured`, `userDefined`, `enable`, `auditMode`, `blockDiskModification`, `auditDiskModification` |
| **UntrustedUSBProcessType** | Write | String | With this rule, admins can prevent unsigned or untrusted executable files from running from USB removable drives, including SD cards. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **AttackSurfaceReductionExcludedPaths** | Write | StringArray[] | Exclude files and paths from attack surface reduction rules | |
| **UntrustedExecutableType** | Write | String | This rule blocks executable files that don't meet a prevalence, age, or trusted list criteria, such as .exe, .dll, or .scr, from launching. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **OfficeCommunicationAppsLaunchChildProcess** | Write | String | This rule prevents Outlook from creating child processes, while still allowing legitimate Outlook functions. | `notConfigured`, `userDefined`, `enable`, `auditMode`, `warn`, `disable` |
| **EmailContentExecutionType** | Write | String | This rule blocks the following file types from launching from email opened within the Microsoft Outlook application, or Outlook.com and other popular webmail providers. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **ScriptDownloadedPayloadExecutionType** | Write | String | This rule prevents scripts from launching potentially malicious downloaded content. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **AdditionalGuardedFolders** | Write | StringArray[] | List of additional folders that need to be protected | |
| **AdobeReaderLaunchChildProcess** | Write | String | This rule prevents attacks by blocking Adobe Reader from creating processes. | `notConfigured`, `userDefined`, `enable`, `auditMode`, `warn` |
| **OfficeAppsExecutableContentCreationOrLaunchType** | Write | String | This rule prevents Office apps, including Word, Excel, and PowerPoint, from creating potentially malicious executable content, by blocking malicious code from being written to disk. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **PreventCredentialStealingType** | Write | String | This rule helps prevent credential stealing by locking down Local Security Authority Subsystem Service (LSASS). | `notConfigured`, `userDefined`, `enable`, `auditMode`, `warn` |
| **OfficeAppsOtherProcessInjectionType** | Write | String | This rule blocks code injection attempts from Office apps into other processes. | `notConfigured`, `userDefined`, `block`, `auditMode`, `warn`, `disable` |
| **GuardedFoldersAllowedAppPaths** | Write | StringArray[] | List of apps that have access to protected folders. | |
| **Ensure** | Write | String | Present ensures the site collection exists, absent ensures it is removed | `Present`, `Absent` |
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

This resource configures a Intune Endpoint Protection Attack Surface Reduction rules policy for a Windows 10 Device.
This resource returns ASR rules created using deviceConfiguration Graph settings.


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
        IntuneASRRulesPolicyWindows10 'myASRRulesPolicy'
        {
            DisplayName                                     = 'test'
            AdditionalGuardedFolders                        = @()
            AdobeReaderLaunchChildProcess                   = 'auditMode'
            AdvancedRansomewareProtectionType               = 'enable'
            Assignments                                     = @()
            AttackSurfaceReductionExcludedPaths             = @('c:\Novo')
            BlockPersistenceThroughWmiType                  = 'auditMode'
            Description                                     = ''
            EmailContentExecutionType                       = 'auditMode'
            GuardedFoldersAllowedAppPaths                   = @()
            GuardMyFoldersType                              = 'enable'
            OfficeAppsExecutableContentCreationOrLaunchType = 'block'
            OfficeAppsLaunchChildProcessType                = 'auditMode'
            OfficeAppsOtherProcessInjectionType             = 'block'
            OfficeCommunicationAppsLaunchChildProcess       = 'auditMode'
            OfficeMacroCodeAllowWin32ImportsType            = 'block'
            PreventCredentialStealingType                   = 'enable'
            ProcessCreationType                             = 'block'
            ScriptDownloadedPayloadExecutionType            = 'block'
            ScriptObfuscatedMacroCodeType                   = 'block'
            UntrustedExecutableType                         = 'block'
            UntrustedUSBProcessType                         = 'block'
            Ensure                                          = 'Present'
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
        IntuneASRRulesPolicyWindows10 'myASRRulesPolicy'
        {
            DisplayName                                     = 'test'
            AdditionalGuardedFolders                        = @()
            AdobeReaderLaunchChildProcess                   = 'auditMode'
            AdvancedRansomewareProtectionType               = 'enable'
            Assignments                                     = @()
            AttackSurfaceReductionExcludedPaths             = @('c:\Novo')
            BlockPersistenceThroughWmiType                  = 'auditMode'
            Description                                     = ''
            EmailContentExecutionType                       = 'auditMode'
            GuardedFoldersAllowedAppPaths                   = @()
            GuardMyFoldersType                              = 'enable'
            OfficeAppsExecutableContentCreationOrLaunchType = 'block'
            OfficeAppsLaunchChildProcessType                = 'auditMode'
            OfficeAppsOtherProcessInjectionType             = 'block'
            OfficeCommunicationAppsLaunchChildProcess       = 'auditMode'
            OfficeMacroCodeAllowWin32ImportsType            = 'block'
            PreventCredentialStealingType                   = 'enable'
            ProcessCreationType                             = 'userDefined' # Updated Property
            ScriptDownloadedPayloadExecutionType            = 'block'
            ScriptObfuscatedMacroCodeType                   = 'block'
            UntrustedExecutableType                         = 'block'
            UntrustedUSBProcessType                         = 'block'
            Ensure                                          = 'Present'
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
        IntuneASRRulesPolicyWindows10 'myASRRulesPolicy'
        {
            DisplayName                                     = 'test'
            Ensure                                          = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

