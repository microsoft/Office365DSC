# IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **DisplayName** | Key | String | Policy display name. | |
| **AzureRightsManagementServicesAllowed** | Write | Boolean | Specifies whether to allow Azure RMS encryption for WIP | |
| **DataRecoveryCertificate** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionDataRecoveryCertificate | Specifies a recovery certificate that can be used for data recovery of encrypted files. This is the same as the data recovery agent(DRA) certificate for encrypting file system(EFS) | |
| **EnforcementLevel** | Write | String | WIP enforcement level.See the Enum definition for supported values. Possible values are: noProtection, encryptAndAuditOnly, encryptAuditAndPrompt, encryptAuditAndBlock. | `noProtection`, `encryptAndAuditOnly`, `encryptAuditAndPrompt`, `encryptAuditAndBlock` |
| **EnterpriseDomain** | Write | String | Primary enterprise domain | |
| **EnterpriseInternalProxyServers** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | This is the comma-separated list of internal proxy servers. For example, '157.54.14.28, 157.54.11.118, 10.202.14.167, 157.53.14.163, 157.69.210.59'. These proxies have been configured by the admin to connect to specific resources on the Internet. They are considered to be enterprise network locations. The proxies are only leveraged in configuring the EnterpriseProxiedDomains policy to force traffic to the matched domains through these proxies | |
| **EnterpriseIPRanges** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionIPRangeCollection[] | Sets the enterprise IP ranges that define the computers in the enterprise network. Data that comes from those computers will be considered part of the enterprise and protected. These locations will be considered a safe destination for enterprise data to be shared to | |
| **EnterpriseIPRangesAreAuthoritative** | Write | Boolean | Boolean value that tells the client to accept the configured list and not to use heuristics to attempt to find other subnets. Default is false | |
| **EnterpriseNetworkDomainNames** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | This is the list of domains that comprise the boundaries of the enterprise. Data from one of these domains that is sent to a device will be considered enterprise data and protected These locations will be considered a safe destination for enterprise data to be shared to | |
| **EnterpriseProtectedDomainNames** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | List of enterprise domains to be protected | |
| **EnterpriseProxiedDomains** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionProxiedDomainCollection[] | Contains a list of Enterprise resource domains hosted in the cloud that need to be protected. Connections to these resources are considered enterprise data. If a proxy is paired with a cloud resource, traffic to the cloud resource will be routed through the enterprise network via the denoted proxy server (on Port 80). A proxy server used for this purpose must also be configured using the EnterpriseInternalProxyServers policy | |
| **EnterpriseProxyServers** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | This is a list of proxy servers. Any server not on this list is considered non-enterprise | |
| **EnterpriseProxyServersAreAuthoritative** | Write | Boolean | Boolean value that tells the client to accept the configured list of proxies and not try to detect other work proxies. Default is false | |
| **ExemptApps** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionApp[] | Exempt applications can also access enterprise data, but the data handled by those applications are not protected. This is because some critical enterprise applications may have compatibility problems with encrypted data. | |
| **IconsVisible** | Write | Boolean | Determines whether overlays are added to icons for WIP protected files in Explorer and enterprise only app tiles in the Start menu. Starting in Windows 10, version 1703 this setting also configures the visibility of the WIP icon in the title bar of a WIP-protected app | |
| **IndexingEncryptedStoresOrItemsBlocked** | Write | Boolean | This switch is for the Windows Search Indexer, to allow or disallow indexing of items | |
| **NeutralDomainResources** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | List of domain names that can used for work or personal resource | |
| **ProtectedApps** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionApp[] | Protected applications can access enterprise data and the data handled by those applications are protected with encryption | |
| **ProtectionUnderLockConfigRequired** | Write | Boolean | Specifies whether the protection under lock feature (also known as encrypt under pin) should be configured | |
| **RevokeOnUnenrollDisabled** | Write | Boolean | This policy controls whether to revoke the WIP keys when a device unenrolls from the management service. If set to 1 (Don't revoke keys), the keys will not be revoked and the user will continue to have access to protected files after unenrollment. If the keys are not revoked, there will be no revoked file cleanup subsequently. | |
| **RightsManagementServicesTemplateId** | Write | String | TemplateID GUID to use for RMS encryption. The RMS template allows the IT admin to configure the details about who has access to RMS-protected file and how long they have access | |
| **SmbAutoEncryptedFileExtensions** | Write | MSFT_MicrosoftGraphwindowsInformationProtectionResourceCollection[] | Specifies a list of file extensions, so that files with these extensions are encrypted when copying from an SMB share within the corporate boundary | |
| **Description** | Write | String | The policy's description. | |
| **Assignments** | Write | MSFT_IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolledPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolledPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_MicrosoftGraphWindowsInformationProtectionDataRecoveryCertificate

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Certificate** | Write | String | Data recovery Certificate | |
| **Description** | Write | String | Data recovery Certificate description | |
| **ExpirationDateTime** | Write | String | Data recovery Certificate expiration datetime | |
| **SubjectName** | Write | String | Data recovery Certificate subject name | |

### MSFT_MicrosoftGraphWindowsInformationProtectionResourceCollection

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Write | String | Display name | |
| **Resources** | Write | StringArray[] | Collection of resources | |

### MSFT_MicrosoftGraphWindowsInformationProtectionIPRangeCollection

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Write | String | Display name | |
| **Ranges** | Write | MSFT_MicrosoftGraphIpRange[] | Collection of ip ranges | |

### MSFT_MicrosoftGraphIpRange

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **CidrAddress** | Write | String | IPv4 address in CIDR notation. Not nullable. | |
| **LowerAddress** | Write | String | Lower address. | |
| **UpperAddress** | Write | String | Upper address. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.iPv4CidrRange`, `#microsoft.graph.iPv6CidrRange`, `#microsoft.graph.iPv4Range`, `#microsoft.graph.iPv6Range` |

### MSFT_MicrosoftGraphWindowsInformationProtectionProxiedDomainCollection

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **DisplayName** | Write | String | Display name | |
| **ProxiedDomains** | Write | MSFT_MicrosoftGraphProxiedDomain[] | Collection of proxied domains | |

### MSFT_MicrosoftGraphProxiedDomain

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IpAddressOrFQDN** | Write | String | The IP address or FQDN | |
| **Proxy** | Write | String | Proxy IP or FQDN | |

### MSFT_MicrosoftGraphWindowsInformationProtectionApp

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Denied** | Write | Boolean | If true, app is denied protection or exemption. | |
| **Description** | Write | String | The app's description. | |
| **DisplayName** | Write | String | App display name. | |
| **ProductName** | Write | String | The product name. | |
| **PublisherName** | Write | String | The publisher name | |
| **BinaryName** | Write | String | The binary name. | |
| **BinaryVersionHigh** | Write | String | The high binary version. | |
| **BinaryVersionLow** | Write | String | The lower binary version. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.windowsInformationProtectionDesktopApp`, `#microsoft.graph.windowsInformationProtectionStoreApp` |


## Description

Intune Windows Information Protection Policy for Windows10 Mdm Enrolled

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
        IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled 'Example'
        {
            DisplayName                            = 'WIP'
            AzureRightsManagementServicesAllowed   = $False
            Description                            = 'DSC'
            EnforcementLevel                       = 'encryptAndAuditOnly'
            EnterpriseDomain                       = 'domain.co.uk'
            EnterpriseIPRanges                     = @(
                MSFT_MicrosoftGraphwindowsInformationProtectionIPRangeCollection {
                    DisplayName = 'ipv4 range'
                    Ranges      = @(
                        MSFT_MicrosoftGraphIpRange {
                            UpperAddress = '1.1.1.3'
                            LowerAddress = '1.1.1.1'
                            odataType    = '#microsoft.graph.iPv4Range'
                        }
                    )
                }
            )
            EnterpriseIPRangesAreAuthoritative     = $True
            EnterpriseProxyServersAreAuthoritative = $True
            IconsVisible                           = $False
            IndexingEncryptedStoresOrItemsBlocked  = $False
            ProtectedApps                          = @(
                MSFT_MicrosoftGraphwindowsInformationProtectionApp {
                    Description   = 'Microsoft.MicrosoftEdge'
                    odataType     = '#microsoft.graph.windowsInformationProtectionStoreApp'
                    Denied        = $False
                    PublisherName = 'CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US'
                    ProductName   = 'Microsoft.MicrosoftEdge'
                    DisplayName   = 'Microsoft Edge'
                }
            )
            ProtectionUnderLockConfigRequired      = $False
            RevokeOnUnenrollDisabled               = $False
            Ensure                                 = 'Present'
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
        IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled 'Example'
        {
            DisplayName                            = 'WIP'
            AzureRightsManagementServicesAllowed   = $False
            Description                            = 'DSC'
            EnforcementLevel                       = 'encryptAndAuditOnly'
            EnterpriseDomain                       = 'domain.com' # Updated Property
            EnterpriseIPRanges                     = @(
                MSFT_MicrosoftGraphwindowsInformationProtectionIPRangeCollection {
                    DisplayName = 'ipv4 range'
                    Ranges      = @(
                        MSFT_MicrosoftGraphIpRange {
                            UpperAddress = '1.1.1.3'
                            LowerAddress = '1.1.1.1'
                            odataType    = '#microsoft.graph.iPv4Range'
                        }
                    )
                }
            )
            EnterpriseIPRangesAreAuthoritative     = $True
            EnterpriseProxyServersAreAuthoritative = $True
            IconsVisible                           = $False
            IndexingEncryptedStoresOrItemsBlocked  = $False
            ProtectedApps                          = @(
                MSFT_MicrosoftGraphwindowsInformationProtectionApp {
                    Description   = 'Microsoft.MicrosoftEdge'
                    odataType     = '#microsoft.graph.windowsInformationProtectionStoreApp'
                    Denied        = $False
                    PublisherName = 'CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US'
                    ProductName   = 'Microsoft.MicrosoftEdge'
                    DisplayName   = 'Microsoft Edge'
                }
            )
            ProtectionUnderLockConfigRequired      = $False
            RevokeOnUnenrollDisabled               = $False
            Ensure                                 = 'Present'
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
        IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled 'Example'
        {
            DisplayName                            = 'WIP'
            Ensure                                 = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

