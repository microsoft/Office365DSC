# IntuneMobileAppsWindowsOfficeSuiteApp

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The admin provided or imported title of the app. Inherited from mobileApp. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. Inherited from mobileApp object. | |
| **Description** | Write | String | The description of the app. Inherited from mobileApp. | |
| **IsFeatured** | Write | Boolean | The value indicating whether the app is marked as featured by the admin. Inherited from mobileApp. | |
| **PrivacyInformationUrl** | Write | String | The privacy statement Url. Inherited from mobileApp. | |
| **InformationUrl** | Write | String | The InformationUrl of the app. Inherited from mobileApp. | |
| **Notes** | Write | String | Notes for the app. Inherited from mobileApp. | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tag IDs for mobile app. | |
| **AutoAcceptEula** | Write | Boolean | Specifies if the EULA is accepted automatically on the end user's device. | |
| **ProductIds** | Write | StringArray[] | The Product IDs that represent the Office 365 Suite SKU, such as 'O365ProPlusRetail' or 'VisioProRetail'. | |
| **UseSharedComputerActivation** | Write | Boolean | Indicates whether shared computer activation is used for Office installations. | |
| **UpdateChannel** | Write | String | Specifies the update channel for the Office 365 app suite, such as 'Current' or 'Deferred'. | |
| **OfficeSuiteAppDefaultFileFormat** | Write | String | Specifies the default file format type for Office apps, such as 'OfficeOpenXMLFormat' or 'OfficeOpenDocumentFormat'. | |
| **OfficePlatformArchitecture** | Write | String | The architecture of the Office installation (e.g., 'X86', 'X64', or 'Arm64'). Cannot be changed after creation. | |
| **LocalesToInstall** | Write | StringArray[] | Specifies the locales to be installed when the Office 365 apps are deployed. Uses the standard RFC 5646 format (e.g., 'en-US', 'fr-FR'). | |
| **InstallProgressDisplayLevel** | Write | String | Specifies the display level of the installation progress for Office apps. Use 'Full' to display the installation UI, or 'None' for a silent installation. | |
| **ShouldUninstallOlderVersionsOfOffice** | Write | Boolean | Indicates whether older versions of Office should be uninstalled when deploying the Office 365 app suite. | |
| **TargetVersion** | Write | String | The specific target version of the Office 365 app suite to be deployed. | |
| **UpdateVersion** | Write | String | The update version in which the target version is available for the Office 365 app suite. | |
| **OfficeConfigurationXml** | Write | String | A base64-encoded XML configuration file that specifies Office ProPlus installation settings. Takes precedence over all other properties. When present, this XML file will be used to create the app. | |
| **Categories** | Write | MSFT_DeviceManagementMobileAppCategory[] | The list of categories for this app. | |
| **Assignments** | Write | MSFT_DeviceManagementMobileAppAssignment[] | The list of assignments for this app. | |
| **ExcludedApps** | Write | MSFT_DeviceManagementMobileAppExcludedApp | The property that represents the apps excluded from the selected Office 365 Product ID. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_DeviceManagementMobileAppAssignment

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.mobileAppAssignment` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are: none, include, exclude. | `none`, `include`, `exclude` |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **intent** | Write | String | Possible values for the install intent chosen by the admin. | `available`, `required`, `uninstall`, `availableWithoutEnrollment` |

### MSFT_DeviceManagementMimeContent

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Type** | Write | String | Indicates the type of content mime. | |
| **Value** | Write | String | The Base64 encoded string content. | |

### MSFT_DeviceManagementMobileAppCategory

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Key | String | The name of the app category. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |

### MSFT_DeviceManagementMobileAppExcludedApp

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Access** | Write | Boolean | Specifies whether to exclude Microsoft Office Access from the installation. | |
| **Bing** | Write | Boolean | Specifies whether to exclude Microsoft Search (Bing) as the default from the installation. | |
| **Excel** | Write | Boolean | Specifies whether to exclude Microsoft Office Excel from the installation. | |
| **Groove** | Write | Boolean | Specifies whether to exclude Microsoft Office OneDrive for Business (Groove) from the installation. | |
| **InfoPath** | Write | Boolean | Specifies whether to exclude Microsoft Office InfoPath from the installation. | |
| **Lync** | Write | Boolean | Specifies whether to exclude Microsoft Office Skype for Business (Lync) from the installation. | |
| **OneDrive** | Write | Boolean | Specifies whether to exclude Microsoft Office OneDrive from the installation. | |
| **OneNote** | Write | Boolean | Specifies whether to exclude Microsoft Office OneNote from the installation. | |
| **Outlook** | Write | Boolean | Specifies whether to exclude Microsoft Office Outlook from the installation. | |
| **PowerPoint** | Write | Boolean | Specifies whether to exclude Microsoft Office PowerPoint from the installation. | |
| **Publisher** | Write | Boolean | Specifies whether to exclude Microsoft Office Publisher from the installation. | |
| **SharePointDesigner** | Write | Boolean | Specifies whether to exclude Microsoft Office SharePoint Designer from the installation. | |
| **Teams** | Write | Boolean | Specifies whether to exclude Microsoft Office Teams from the installation. | |
| **Visio** | Write | Boolean | Specifies whether to exclude Microsoft Office Visio from the installation. | |
| **Word** | Write | Boolean | Specifies whether to exclude Microsoft Office Word from the installation. | |


## Description

This resource configures an Intune mobile app of OfficeSuiteApp type for Windows devices.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementApps.Read.All

- **Update**

    - Group.Read.All, DeviceManagementApps.ReadWrite.All

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
        IntuneMobileAppsWindowsOfficeSuiteApp "IntuneMobileAppsWindowsOfficeSuiteApp-Microsoft 365 Apps for Windows 10 and later"
        {
            Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d"
            Description           = "Microsoft 365 Apps for Windows 10 and laterr"
            DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
            Ensure                = "Present";
            InformationUrl        = "";
            IsFeatured            = $False;
            Notes                 = ""
            PrivacyInformationUrl = ""
            RoleScopeTagIds       = @()
            Assignments          = @(
                MSFT_DeviceManagementMobileAppAssignment{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '42c02b60-f28c-4eef-b3e1-973184cc4a6c'
                    intent = 'required'
                }
            );
            Categories           = @(
                MSFT_DeviceManagementMobileAppCategory {
                    Id  = '8e683524-4ec1-4813-bb3e-6256b2f293d8'
                    DisplayName = 'Productivity'
                });
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        IntuneMobileAppsWindowsOfficeSuiteApp "IntuneMobileAppsWindowsOfficeSuiteApp-Microsoft 365 Apps for Windows 10 and later"
        {
            Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d"
            Description           = "Microsoft 365 Apps for Windows 10 and laterr"
            DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
            Ensure                = "Present";
            InformationUrl        = "";
            IsFeatured            = $False;
            Notes                 = ""
            PrivacyInformationUrl = ""
            RoleScopeTagIds       = @()
            Assignments          = @(
                MSFT_DeviceManagementMobileAppAssignment{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '42c02b60-f28c-4eef-b3e1-973184cc4a6c'
                    intent = 'required'
                }
            );
            Categories           = @(
                MSFT_DeviceManagementMobileAppCategory {
                    Id  = '8e683524-4ec1-4813-bb3e-6256b2f293d8'
                    DisplayName = 'Productivity'
                });
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
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
        IntuneMobileAppsWindowsOfficeSuiteApp "IntuneMobileAppsWindowsOfficeSuiteApp-Microsoft 365 Apps for Windows 10 and later"
        {
            Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d8";
            DisplayName           = "Microsoft 365 Apps for Windows 10 and later";
            Ensure                = "Absent";
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
    }
}
```

