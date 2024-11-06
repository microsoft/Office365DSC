<#
This example creates a new Device Remediation.
#>

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
        IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr 'ConfigureAppAndBrowserIsolationPolicyWindows10ConfigMgr'
        {
            Assignments              = @(
                MSFT_DeviceManagementConfigurationPolicyAssignments{
                    deviceAndAppManagementAssignmentFilterType = 'none'
                    dataType = '#microsoft.graph.groupAssignmentTarget'
                    groupId = '11111111-1111-1111-1111-111111111111'
                }
            );
            AllowCameraMicrophoneRedirection       = "1";
            AllowPersistence                       = "0";
            AllowVirtualGPU                        = "0";
            AllowWindowsDefenderApplicationGuard   = "1";
            ClipboardFileType                      = "1";
            ClipboardSettings                      = "0";
            Description                            = 'Description'
            DisplayName                            = "App and Browser Isolation";
            Ensure                                 = "Present";
            Id                                     = '00000000-0000-0000-0000-000000000000'
            InstallWindowsDefenderApplicationGuard = "install";
            SaveFilesToHost                        = "0";
            RoleScopeTagIds                        = @("0");
            ApplicationId                          = $ApplicationId;
            TenantId                               = $TenantId;
            CertificateThumbprint                  = $CertificateThumbprint;
        }
    }
}
