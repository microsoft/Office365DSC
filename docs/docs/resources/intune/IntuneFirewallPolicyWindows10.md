# IntuneFirewallPolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Description** | Write | String | Policy description | |
| **DisplayName** | Key | String | Policy name | |
| **RoleScopeTagIds** | Write | StringArray[] | List of Scope Tags for this Entity instance. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **CRLcheck** | Write | String | Certificate revocation list verification (0: Disables CRL checking, 1: Specifies that CRL checking is attempted and that certificate validation fails only if the certificate is revoked. Other failures that are encountered during CRL checking (such as the revocation URL being unreachable) do not cause certificate validation to fail., 2: Means that checking is required and that certificate validation fails if any error is encountered during CRL processing) | `0`, `1`, `2` |
| **DisableStatefulFtp** | Write | String | Disable Stateful Ftp (false: Stateful FTP enabled, true: Stateful FTP disabled) | `false`, `true` |
| **EnablePacketQueue** | Write | SInt32Array[] | Enable Packet Queue (0: Indicates that all queuing is to be disabled, 1: Specifies that inbound encrypted packets are to be queued, 2: Specifies that packets are to be queued after decryption is performed for forwarding) | `0`, `1`, `2` |
| **IPsecExempt** | Write | SInt32Array[] | IPsec Exceptions (0: FW_GLOBAL_CONFIG_IPSEC_EXEMPT_NONE:  No IPsec exemptions., 1: FW_GLOBAL_CONFIG_IPSEC_EXEMPT_NEIGHBOR_DISC:  Exempt neighbor discover IPv6 ICMP type-codes from IPsec., 2: FW_GLOBAL_CONFIG_IPSEC_EXEMPT_ICMP:  Exempt ICMP from IPsec., 4: FW_GLOBAL_CONFIG_IPSEC_EXEMPT_ROUTER_DISC:  Exempt router discover IPv6 ICMP type-codes from IPsec., 8: FW_GLOBAL_CONFIG_IPSEC_EXEMPT_DHCP:  Exempt both IPv4 and IPv6 DHCP traffic from IPsec.) | `0`, `1`, `2`, `4`, `8` |
| **OpportunisticallyMatchAuthSetPerKM** | Write | String | Opportunistically Match Auth Set Per KM (false: FALSE, true: TRUE) | `false`, `true` |
| **PresharedKeyEncoding** | Write | String | Preshared Key Encoding (0: FW_GLOBAL_CONFIG_PRESHARED_KEY_ENCODING_NONE:  Preshared key is not encoded. Instead, it is kept in its wide-character format. This symbolic constant has a value of 0., 1: FW_GLOBAL_CONFIG_PRESHARED_KEY_ENCODING_UTF_8:  Encode the preshared key using UTF-8. This symbolic constant has a value of 1.) | `0`, `1` |
| **SaIdleTime** | Write | SInt32 | Security association idle time | |
| **DomainProfile_EnableFirewall** | Write | String | Enable Domain Network Firewall (false: Disable Firewall, true: Enable Firewall) | `false`, `true` |
| **DomainProfile_DisableUnicastResponsesToMulticastBroadcast** | Write | String | Disable Unicast Responses To Multicast Broadcast (false: Unicast Responses Not Blocked, true: Unicast Responses Blocked) | `false`, `true` |
| **DomainProfile_EnableLogIgnoredRules** | Write | String | Enable Log Ignored Rules (false: Disable Logging Of Ignored Rules, true: Enable Logging Of Ignored Rules) | `false`, `true` |
| **DomainProfile_GlobalPortsAllowUserPrefMerge** | Write | String | Global Ports Allow User Pref Merge (false: GlobalPortsAllowUserPrefMerge Off, true: GlobalPortsAllowUserPrefMerge On) | `false`, `true` |
| **DomainProfile_DefaultInboundAction** | Write | String | Default Inbound Action for Domain Profile (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **DomainProfile_DisableStealthModeIpsecSecuredPacketExemption** | Write | String | Disable Stealth Mode Ipsec Secured Packet Exemption (false: FALSE, true: TRUE) | `false`, `true` |
| **DomainProfile_AllowLocalPolicyMerge** | Write | String | Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **DomainProfile_EnableLogSuccessConnections** | Write | String | Enable Log Success Connections (false: Disable Logging Of Successful Connections, true: Enable Logging Of Successful Connections) | `false`, `true` |
| **DomainProfile_AllowLocalIpsecPolicyMerge** | Write | String | Allow Local Ipsec Policy Merge (false: AllowLocalIpsecPolicyMerge Off, true: AllowLocalIpsecPolicyMerge On) | `false`, `true` |
| **DomainProfile_LogFilePath** | Write | String | Log File Path | |
| **DomainProfile_DisableStealthMode** | Write | String | Disable Stealth Mode (false: Use Stealth Mode, true: Disable Stealth Mode) | `false`, `true` |
| **DomainProfile_AuthAppsAllowUserPrefMerge** | Write | String | Auth Apps Allow User Pref Merge (false: AuthAppsAllowUserPrefMerge Off, true: AuthAppsAllowUserPrefMerge On) | `false`, `true` |
| **DomainProfile_EnableLogDroppedPackets** | Write | String | Enable Log Dropped Packets (false: Disable Logging Of Dropped Packets, true: Enable Logging Of Dropped Packets) | `false`, `true` |
| **DomainProfile_Shielded** | Write | String | Shielded (false: Shielding Off, true: Shielding On) | `false`, `true` |
| **DomainProfile_DefaultOutboundAction** | Write | String | Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **DomainProfile_DisableInboundNotifications** | Write | String | Disable Inbound Notifications (false: Firewall May Display Notification, true: Firewall Must Not Display Notification) | `false`, `true` |
| **DomainProfile_LogMaxFileSize** | Write | SInt32 | Log Max File Size | |
| **PrivateProfile_EnableFirewall** | Write | String | Enable Private Network Firewall (false: Disable Firewall, true: Enable Firewall) | `false`, `true` |
| **PrivateProfile_AllowLocalIpsecPolicyMerge** | Write | String | Allow Local Ipsec Policy Merge (false: AllowLocalIpsecPolicyMerge Off, true: AllowLocalIpsecPolicyMerge On) | `false`, `true` |
| **PrivateProfile_DisableStealthModeIpsecSecuredPacketExemption** | Write | String | Disable Stealth Mode Ipsec Secured Packet Exemption (false: FALSE, true: TRUE) | `false`, `true` |
| **PrivateProfile_DisableInboundNotifications** | Write | String | Disable Inbound Notifications (false: Firewall May Display Notification, true: Firewall Must Not Display Notification) | `false`, `true` |
| **PrivateProfile_Shielded** | Write | String | Shielded (false: Shielding Off, true: Shielding On) | `false`, `true` |
| **PrivateProfile_AllowLocalPolicyMerge** | Write | String | Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **PrivateProfile_DefaultOutboundAction** | Write | String | Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **PrivateProfile_AuthAppsAllowUserPrefMerge** | Write | String | Auth Apps Allow User Pref Merge (false: AuthAppsAllowUserPrefMerge Off, true: AuthAppsAllowUserPrefMerge On) | `false`, `true` |
| **PrivateProfile_EnableLogIgnoredRules** | Write | String | Enable Log Ignored Rules (false: Disable Logging Of Ignored Rules, true: Enable Logging Of Ignored Rules) | `false`, `true` |
| **PrivateProfile_LogMaxFileSize** | Write | SInt32 | Log Max File Size | |
| **PrivateProfile_DefaultInboundAction** | Write | String | Default Inbound Action for Private Profile (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **PrivateProfile_DisableUnicastResponsesToMulticastBroadcast** | Write | String | Disable Unicast Responses To Multicast Broadcast (false: Unicast Responses Not Blocked, true: Unicast Responses Blocked) | `false`, `true` |
| **PrivateProfile_LogFilePath** | Write | String | Log File Path | |
| **PrivateProfile_DisableStealthMode** | Write | String | Disable Stealth Mode (false: Use Stealth Mode, true: Disable Stealth Mode) | `false`, `true` |
| **PrivateProfile_EnableLogSuccessConnections** | Write | String | Enable Log Success Connections (false: Disable Logging Of Successful Connections, true: Enable Logging Of Successful Connections) | `false`, `true` |
| **PrivateProfile_GlobalPortsAllowUserPrefMerge** | Write | String | Global Ports Allow User Pref Merge (false: GlobalPortsAllowUserPrefMerge Off, true: GlobalPortsAllowUserPrefMerge On) | `false`, `true` |
| **PrivateProfile_EnableLogDroppedPackets** | Write | String | Enable Log Dropped Packets (false: Disable Logging Of Dropped Packets, true: Enable Logging Of Dropped Packets) | `false`, `true` |
| **PublicProfile_EnableFirewall** | Write | String | Enable Public Network Firewall (false: Disable Firewall, true: Enable Firewall) | `false`, `true` |
| **PublicProfile_DefaultOutboundAction** | Write | String | Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **PublicProfile_DisableInboundNotifications** | Write | String | Disable Inbound Notifications (false: Firewall May Display Notification, true: Firewall Must Not Display Notification) | `false`, `true` |
| **PublicProfile_DisableStealthModeIpsecSecuredPacketExemption** | Write | String | Disable Stealth Mode Ipsec Secured Packet Exemption (false: FALSE, true: TRUE) | `false`, `true` |
| **PublicProfile_Shielded** | Write | String | Shielded (false: Shielding Off, true: Shielding On) | `false`, `true` |
| **PublicProfile_AllowLocalPolicyMerge** | Write | String | Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **PublicProfile_AuthAppsAllowUserPrefMerge** | Write | String | Auth Apps Allow User Pref Merge (false: AuthAppsAllowUserPrefMerge Off, true: AuthAppsAllowUserPrefMerge On) | `false`, `true` |
| **PublicProfile_LogFilePath** | Write | String | Log File Path | |
| **PublicProfile_DefaultInboundAction** | Write | String | Default Inbound Action for Public Profile (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **PublicProfile_DisableUnicastResponsesToMulticastBroadcast** | Write | String | Disable Unicast Responses To Multicast Broadcast (false: Unicast Responses Not Blocked, true: Unicast Responses Blocked) | `false`, `true` |
| **PublicProfile_GlobalPortsAllowUserPrefMerge** | Write | String | Global Ports Allow User Pref Merge (false: GlobalPortsAllowUserPrefMerge Off, true: GlobalPortsAllowUserPrefMerge On) | `false`, `true` |
| **PublicProfile_EnableLogSuccessConnections** | Write | String | Enable Log Success Connections (false: Disable Logging Of Successful Connections, true: Enable Logging Of Successful Connections) | `false`, `true` |
| **PublicProfile_AllowLocalIpsecPolicyMerge** | Write | String | Allow Local Ipsec Policy Merge (false: AllowLocalIpsecPolicyMerge Off, true: AllowLocalIpsecPolicyMerge On) | `false`, `true` |
| **PublicProfile_EnableLogDroppedPackets** | Write | String | Enable Log Dropped Packets (false: Disable Logging Of Dropped Packets, true: Enable Logging Of Dropped Packets) | `false`, `true` |
| **PublicProfile_EnableLogIgnoredRules** | Write | String | Enable Log Ignored Rules (false: Disable Logging Of Ignored Rules, true: Enable Logging Of Ignored Rules) | `false`, `true` |
| **PublicProfile_LogMaxFileSize** | Write | SInt32 | Log Max File Size | |
| **PublicProfile_DisableStealthMode** | Write | String | Disable Stealth Mode (false: Use Stealth Mode, true: Disable Stealth Mode) | `false`, `true` |
| **ObjectAccess_AuditFilteringPlatformConnection** | Write | String | Object Access Audit Filtering Platform Connection (0: Off/None, 1: Success, 2: Failure, 3: Success+Failure) | `0`, `1`, `2`, `3` |
| **ObjectAccess_AuditFilteringPlatformPacketDrop** | Write | String | Object Access Audit Filtering Platform Packet Drop (0: Off/None, 1: Success, 2: Failure, 3: Success+Failure) | `0`, `1`, `2`, `3` |
| **AllowedTlsAuthenticationEndpoints** | Write | StringArray[] | Allowed Tls Authentication Endpoints | |
| **ConfiguredTlsAuthenticationNetworkName** | Write | String | Configured Tls Authentication Network Name | |
| **Target** | Write | String | Hyper-V: Target (wsl: WSL) | `wsl` |
| **HyperVVMSettings_DomainProfile_EnableFirewall** | Write | String | Hyper-V: Enable Domain Network Firewall (false: Disable Firewall, true: Enable Firewall) | `false`, `true` |
| **HyperVVMSettings_DomainProfile_AllowLocalPolicyMerge** | Write | String | Hyper-V: Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **HyperVVMSettings_DomainProfile_DefaultInboundAction** | Write | String | Hyper-V: Default Inbound Action (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **HyperVVMSettings_DomainProfile_DefaultOutboundAction** | Write | String | Hyper-V: Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **EnableLoopback** | Write | String | Hyper-V: Enable Loopback (false: Disable loopback, true: Enable loopback) | `false`, `true` |
| **HyperVVMSettings_PublicProfile_EnableFirewall** | Write | String | Hyper-V: Enable Public Network Firewall (false: Disable Hyper-V Firewall, true: Enable Hyper-V Firewall) | `false`, `true` |
| **HyperVVMSettings_PublicProfile_DefaultInboundAction** | Write | String | Hyper-V: Default Inbound Action (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **HyperVVMSettings_PublicProfile_DefaultOutboundAction** | Write | String | Hyper-V: Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **HyperVVMSettings_PublicProfile_AllowLocalPolicyMerge** | Write | String | Hyper-V: Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **HyperVVMSettings_PrivateProfile_EnableFirewall** | Write | String | Hyper-V: Enable Private Network Firewall (false: Disable Firewall, true: Enable Firewall) | `false`, `true` |
| **HyperVVMSettings_PrivateProfile_DefaultOutboundAction** | Write | String | Hyper-V: Default Outbound Action (0: Allow Outbound By Default, 1: Block Outbound By Default) | `0`, `1` |
| **HyperVVMSettings_PrivateProfile_DefaultInboundAction** | Write | String | Hyper-V: Default Inbound Action (0: Allow Inbound By Default, 1: Block Inbound By Default) | `0`, `1` |
| **HyperVVMSettings_PrivateProfile_AllowLocalPolicyMerge** | Write | String | Hyper-V: Allow Local Policy Merge (false: AllowLocalPolicyMerge Off, true: AllowLocalPolicyMerge On) | `false`, `true` |
| **AllowHostPolicyMerge** | Write | String | Hyper-V: Allow Host Policy Merge (false: AllowHostPolicyMerge Off, true: AllowHostPolicyMerge On) | `false`, `true` |
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


## Description

Intune Firewall Policy for Windows10

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

This example creates a new Intune Firewall Policy for Windows10.

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
        IntuneFirewallPolicyWindows10 'ConfigureIntuneFirewallPolicyWindows10'
        {
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            Description           = 'Description'
            DisplayName           = "Intune Firewall Policy Windows10";
            DisableStatefulFtp    = "false";
            DomainProfile_AllowLocalIpsecPolicyMerge      = "false";
            DomainProfile_EnableFirewall                  = "true";
            DomainProfile_LogFilePath                     = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
            DomainProfile_LogMaxFileSize                  = 1024;
            ObjectAccess_AuditFilteringPlatformPacketDrop = "1";
            PrivateProfile_EnableFirewall                 = "true";
            PublicProfile_EnableFirewall                  = "true";
            Target                                        = "wsl";
            AllowHostPolicyMerge                          = "false";
            Ensure                = "Present";
            Id                    = '00000000-0000-0000-0000-000000000000'
            RoleScopeTagIds       = @("0");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 2

This example updates a Intune Firewall Policy for Windows10.

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
        IntuneFirewallPolicyWindows10 'ConfigureIntuneFirewallPolicyWindows10'
        {
            Assignments           = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            Description           = 'Description'
            DisplayName           = "Intune Firewall Policy Windows10";
            DisableStatefulFtp    = "false";
            DomainProfile_AllowLocalIpsecPolicyMerge      = "true"; # Updated property
            DomainProfile_EnableFirewall                  = "true";
            DomainProfile_LogFilePath                     = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
            DomainProfile_LogMaxFileSize                  = 1024;
            ObjectAccess_AuditFilteringPlatformPacketDrop = "1";
            PrivateProfile_EnableFirewall                 = "true";
            PublicProfile_EnableFirewall                  = "true";
            Target                                        = "wsl";
            AllowHostPolicyMerge                          = "false";
            Ensure                = "Present";
            Id                    = '00000000-0000-0000-0000-000000000000'
            RoleScopeTagIds       = @("0");
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example removes a Device Control Policy.

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
        IntuneFirewallPolicyWindows10 'ConfigureIntuneFirewallPolicyWindows10'
        {
            Id          = '00000000-0000-0000-0000-000000000000'
            DisplayName = 'Intune Firewall Policy Windows10'
            Ensure      = 'Absent'
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

