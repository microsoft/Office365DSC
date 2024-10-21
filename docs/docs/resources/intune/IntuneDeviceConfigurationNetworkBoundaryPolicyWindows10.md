# IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **WindowsNetworkIsolationPolicy** | Write | MSFT_MicrosoftGraphwindowsNetworkIsolationPolicy | Windows Network Isolation Policy | |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **SupportsScopeTags** | Write | Boolean | Indicates whether or not the underlying Device Configuration supports the assignment of scope tags. Assigning to the ScopeTags property is not allowed when this value is false and entities will not be visible to scoped users. This occurs for Legacy policies created in Silverlight and can be resolved by deleting and recreating the policy in the Azure Portal. This property is read-only. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
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

### MSFT_MicrosoftGraphWindowsNetworkIsolationPolicy

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **EnterpriseCloudResources** | Write | MSFT_MicrosoftGraphProxiedDomain1[] | Contains a list of enterprise resource domains hosted in the cloud that need to be protected. Connections to these resources are considered enterprise data. If a proxy is paired with a cloud resource, traffic to the cloud resource will be routed through the enterprise network via the denoted proxy server (on Port 80). A proxy server used for this purpose must also be configured using the EnterpriseInternalProxyServers policy. This collection can contain a maximum of 500 elements. | |
| **EnterpriseInternalProxyServers** | Write | StringArray[] | This is the comma-separated list of internal proxy servers. For example, '157.54.14.28, 157.54.11.118, 10.202.14.167, 157.53.14.163, 157.69.210.59'. These proxies have been configured by the admin to connect to specific resources on the Internet. They are considered to be enterprise network locations. The proxies are only leveraged in configuring the EnterpriseCloudResources policy to force traffic to the matched cloud resources through these proxies. | |
| **EnterpriseIPRanges** | Write | MSFT_MicrosoftGraphIpRange1[] | Sets the enterprise IP ranges that define the computers in the enterprise network. Data that comes from those computers will be considered part of the enterprise and protected. These locations will be considered a safe destination for enterprise data to be shared to. This collection can contain a maximum of 500 elements. | |
| **EnterpriseIPRangesAreAuthoritative** | Write | Boolean | Boolean value that tells the client to accept the configured list and not to use heuristics to attempt to find other subnets. Default is false. | |
| **EnterpriseNetworkDomainNames** | Write | StringArray[] | This is the list of domains that comprise the boundaries of the enterprise. Data from one of these domains that is sent to a device will be considered enterprise data and protected. These locations will be considered a safe destination for enterprise data to be shared to. | |
| **EnterpriseProxyServers** | Write | StringArray[] | This is a list of proxy servers. Any server not on this list is considered non-enterprise. | |
| **EnterpriseProxyServersAreAuthoritative** | Write | Boolean | Boolean value that tells the client to accept the configured list of proxies and not try to detect other work proxies. Default is false | |
| **NeutralDomainResources** | Write | StringArray[] | List of domain names that can used for work or personal resource. | |

### MSFT_MicrosoftGraphProxiedDomain1

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IpAddressOrFQDN** | Write | String | The IP address or FQDN | |
| **Proxy** | Write | String | Proxy IP or FQDN | |

### MSFT_MicrosoftGraphIpRange1

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **CidrAddress** | Write | String | IPv4 address in CIDR notation. Not nullable. | |
| **LowerAddress** | Write | String | Lower address. | |
| **UpperAddress** | Write | String | Upper address. | |
| **odataType** | Write | String | The type of the entity. | `#microsoft.graph.iPv4CidrRange`, `#microsoft.graph.iPv6CidrRange`, `#microsoft.graph.iPv4Range`, `#microsoft.graph.iPv6Range` |


## Description

Intune Device Configuration Network Boundary Policy for Windows10

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
        IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10 'Example'
        {
            Assignments                   = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName                   = "network boundary";
            Ensure                        = "Present";
            SupportsScopeTags             = $True;
            WindowsNetworkIsolationPolicy = MSFT_MicrosoftGraphwindowsNetworkIsolationPolicy{
                EnterpriseProxyServers = @()
                EnterpriseInternalProxyServers = @()
                EnterpriseIPRangesAreAuthoritative = $True
                EnterpriseProxyServersAreAuthoritative = $True
                EnterpriseNetworkDomainNames = @('domain.com')
                EnterpriseIPRanges = @(
                    MSFT_MicrosoftGraphIpRange1{
                        UpperAddress = '1.1.1.255'
                        LowerAddress = '1.1.1.0'
                        odataType = '#microsoft.graph.iPv4Range'
                    }
                )
                NeutralDomainResources = @()
            };
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
        IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10 'Example'
        {
            Assignments                   = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                }
            );
            DisplayName                   = "network boundary";
            Ensure                        = "Present";
            SupportsScopeTags             = $False; # Updated Property
            WindowsNetworkIsolationPolicy = MSFT_MicrosoftGraphwindowsNetworkIsolationPolicy{
                EnterpriseProxyServers = @()
                EnterpriseInternalProxyServers = @()
                EnterpriseIPRangesAreAuthoritative = $True
                EnterpriseProxyServersAreAuthoritative = $True
                EnterpriseNetworkDomainNames = @('domain.com')
                EnterpriseIPRanges = @(
                    MSFT_MicrosoftGraphIpRange1{
                        UpperAddress = '1.1.1.255'
                        LowerAddress = '1.1.1.0'
                        odataType = '#microsoft.graph.iPv4Range'
                    }
                )
                NeutralDomainResources = @()
            };
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
        IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10 'Example'
        {
            DisplayName                   = "network boundary";
            Ensure                        = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

