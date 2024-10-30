[CmdletBinding()]
param(
)
$M365DSCTestFolder = Join-Path -Path $PSScriptRoot `
                        -ChildPath '..\..\Unit' `
                        -Resolve
$CmdletModule = (Join-Path -Path $M365DSCTestFolder `
            -ChildPath '\Stubs\Microsoft365.psm1' `
            -Resolve)
$GenericStubPath = (Join-Path -Path $M365DSCTestFolder `
    -ChildPath '\Stubs\Generic.psm1' `
    -Resolve)
Import-Module -Name (Join-Path -Path $M365DSCTestFolder `
        -ChildPath '\UnitTestHelper.psm1' `
        -Resolve)

$CurrentScriptPath = $PSCommandPath.Split('\')
$CurrentScriptName = $CurrentScriptPath[$CurrentScriptPath.Length -1]
$ResourceName      = $CurrentScriptName.Split('.')[1]
$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource $ResourceName -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
            }

            Mock -CommandName Get-MgBetaNetworkAccessForwardingProfile -MockWith {
            }

            Mock -CommandName Remove-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
            }

            Mock -CommandName New-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
            }

            Mock -CommandName New-MgBetaNetworkAccessConnectivityRemoteNetworkDeviceLink -MockWith {
            }

            Mock -CommandName Remove-MgBetaNetworkAccessConnectivityRemoteNetworkDeviceLink -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    DeviceLinks           = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLink -Property @{
                            Name                    = 'PiyushTestadf'
                            IPAddress               = '1.1.1.1'
                            BandwidthCapacityInMbps = 'mbps500'
                            DeviceVendor            = 'ciscoMeraki'
                            BgpConfiguration        = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration  -Property @{
                                Asn                 = 123
                                LocalIPAddress      = '1.1.1.2'
                                PeerIPAddress       = '1.1.1.3'
                            } -ClientOnly
                            RedundancyConfiguration = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration  -Property @{
                                RedundancyTier      = 'zoneRedundancy'
                                ZoneLocalIPAddress  = '1.1.1.8'
                            } -ClientOnly
                            TunnelConfiguration     = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration  -Property @{
                                PreSharedKey               = 'sdf'
                                ZoneRedundancyPreSharedKey = 'asdf'
                                ODataType                   = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                            } -ClientOnly
                        } -ClientOnly
                    );
                    ForwardingProfiles    = @();
                    Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                    Name                  = "jkjk";
                    Region                = "australiaSouthEast";
                    Ensure                = "Present";
                    Credential            = $Credential;
                }

                Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
                    return $null
                }

                Mock -CommandName Get-MgBetaNetworkAccessForwardingProfile -MockWith {
                    return @()
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create a new instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaNetworkAccessConnectivityRemoteNetwork -Exactly 1
            }
        }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    DeviceLinks           = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLink -Property @{
                            Name                    = 'PiyushTestadf'
                            IPAddress               = '1.1.1.1'
                            BandwidthCapacityInMbps = 'mbps500'
                            DeviceVendor            = 'ciscoMeraki'
                            BgpConfiguration        = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration  -Property @{
                                Asn                 = 123
                                LocalIPAddress      = '1.1.1.2'
                                PeerIPAddress       = '1.1.1.3'
                            } -ClientOnly
                            RedundancyConfiguration = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration  -Property @{
                                RedundancyTier      = 'zoneRedundancy'
                                ZoneLocalIPAddress  = '1.1.1.8'
                            } -ClientOnly
                            TunnelConfiguration     = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration  -Property @{
                                PreSharedKey               = 'sdf'
                                ZoneRedundancyPreSharedKey = 'asdf'
                                ODataType                   = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                            } -ClientOnly
                        } -ClientOnly
                    );
                    ForwardingProfiles    = @();
                    Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                    Name                  = "jkjk";
                    Region                = "australiaSouthEast";
                    Ensure              = 'Absent'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
                    return @{
                            DeviceLinks           = @(
                            @{
                                Name                    = 'PiyushTestadf'
                                IPAddress               = '1.1.1.1'
                                BandwidthCapacityInMbps = 'mbps500'
                                DeviceVendor            = 'ciscoMeraki'
                                BgpConfiguration        = @{
                                    Asn                 = 123
                                    LocalIPAddress      = '1.1.1.2'
                                    PeerIPAddress       = '1.1.1.3'
                                }
                                RedundancyConfiguration = @{
                                    RedundancyTier      = 'zoneRedundancy'
                                    ZoneLocalIPAddress  = '1.1.1.8'
                                }
                                TunnelConfiguration     = @{
                                    PreSharedKey               = 'sdf'
                                    ZoneRedundancyPreSharedKey = 'asdf'
                                    AdditionalProperties       = @{
                                        "@odata.type"              = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                                    }
                                }
                            }
                        );
                        ForwardingProfiles    = @();
                        Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                        Name                  = "jkjk";
                        Region                = "australiaSouthEast";
                    }
                }

                Mock -CommandName Get-MgBetaNetworkAccessForwardingProfile -MockWith {
                    return @()
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaNetworkAccessConnectivityRemoteNetwork -Exactly 1
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DeviceLinks           = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLink -Property @{
                            Name                    = 'PiyushTestadf'
                            IPAddress               = '1.1.1.1'
                            BandwidthCapacityInMbps = 'mbps500'
                            DeviceVendor            = 'ciscoMeraki'
                            BgpConfiguration        = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration  -Property @{
                                Asn                 = 123
                                LocalIPAddress      = '1.1.1.2'
                                PeerIPAddress       = '1.1.1.3'
                            } -ClientOnly
                            RedundancyConfiguration = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration  -Property @{
                                RedundancyTier      = 'zoneRedundancy'
                                ZoneLocalIPAddress  = '1.1.1.8'
                            } -ClientOnly
                            TunnelConfiguration     = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration  -Property @{
                                PreSharedKey               = 'sdf'
                                ZoneRedundancyPreSharedKey = 'asdf'
                                ODataType                   = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                            } -ClientOnly
                        } -ClientOnly
                    );
                    ForwardingProfiles    = @();
                    Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                    Name                  = "jkjk";
                    Region                = "australiaSouthEast";
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
                    return @{
                            DeviceLinks           = @(
                            @{
                                Name                    = 'PiyushTestadf'
                                IPAddress               = '1.1.1.1'
                                BandwidthCapacityInMbps = 'mbps500'
                                DeviceVendor            = 'ciscoMeraki'
                                BgpConfiguration        = @{
                                    Asn                 = 123
                                    LocalIPAddress      = '1.1.1.2'
                                    PeerIPAddress       = '1.1.1.3'
                                }
                                RedundancyConfiguration = @{
                                    RedundancyTier      = 'zoneRedundancy'
                                    ZoneLocalIPAddress  = '1.1.1.8'
                                }
                                TunnelConfiguration     = @{
                                    PreSharedKey               = 'sdf'
                                    ZoneRedundancyPreSharedKey = 'asdf'
                                    AdditionalProperties       = @{
                                        "@odata.type"              = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                                    }
                                }
                            }
                        );
                        ForwardingProfiles    = @();
                        Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                        Name                  = "jkjk";
                        Region                = "australiaSouthEast";
                    }
                }

                Mock -CommandName Get-MgBetaNetworkAccessForwardingProfile -MockWith {
                    return @()
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DeviceLinks           = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLink -Property @{
                            Name                    = 'PiyushTestadf'
                            IPAddress               = '1.1.1.1'
                            BandwidthCapacityInMbps = 'mbps500'
                            DeviceVendor            = 'ciscoMeraki'
                            BgpConfiguration        = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkbgpConfiguration  -Property @{
                                Asn                 = 123
                                LocalIPAddress      = '1.1.1.2'
                                PeerIPAddress       = '1.1.1.3'
                            } -ClientOnly
                            RedundancyConfiguration = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkRedundancyConfiguration  -Property @{
                                RedundancyTier      = 'zoneRedundancy'
                                ZoneLocalIPAddress  = '1.1.1.8'
                            } -ClientOnly
                            TunnelConfiguration     = New-CimInstance -ClassName MSFT_AADRemoteNetworkDeviceLinkTunnelConfiguration  -Property @{
                                PreSharedKey               = 'sdf'
                                ZoneRedundancyPreSharedKey = 'asdf'
                                ODataType                   = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                            } -ClientOnly
                        } -ClientOnly
                    );
                    ForwardingProfiles    = @();
                    Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                    Name                  = "jkjk";
                    Region                = "australiaSouthEast";
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
                    return @{
                            DeviceLinks           = @(
                            @{
                                Name                    = 'PiyushTestadf'
                                IPAddress               = '1.1.1.1'
                                BandwidthCapacityInMbps = 'mbps500'
                                DeviceVendor            = 'ciscoMeraki'
                                BgpConfiguration        = @{
                                    Asn                 = 123
                                    LocalIPAddress      = '1.1.1.2'
                                    PeerIPAddress       = '1.1.1.3'
                                }
                                RedundancyConfiguration = @{
                                    RedundancyTier      = 'zoneRedundancy'
                                    ZoneLocalIPAddress  = '1.1.1.8'
                                }
                                TunnelConfiguration     = @{
                                    PreSharedKey               = 'some new value' #created drift here
                                    ZoneRedundancyPreSharedKey = 'asdf'
                                    AdditionalProperties       = @{
                                        "@odata.type"              = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                                    }
                                }
                            }
                        );
                        ForwardingProfiles    = @();
                        Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                        Name                  = "jkjk";
                        Region                = "australiaSouthEast";
                    }
                }

                Mock -CommandName Get-MgBetaNetworkAccessForwardingProfile -MockWith {
                    return @()
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaNetworkAccessConnectivityRemoteNetworkDeviceLink
                Should -Invoke -CommandName Remove-MgBetaNetworkAccessConnectivityRemoteNetworkDeviceLink
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaNetworkAccessConnectivityRemoteNetwork -MockWith {
                    return @{
                            DeviceLinks           = @(
                            @{
                                Name                    = 'PiyushTestadf'
                                IPAddress               = '1.1.1.1'
                                BandwidthCapacityInMbps = 'mbps500'
                                DeviceVendor            = 'ciscoMeraki'
                                BgpConfiguration        = @{
                                    Asn                 = 123
                                    LocalIPAddress      = '1.1.1.2'
                                    PeerIPAddress       = '1.1.1.3'
                                }
                                RedundancyConfiguration = @{
                                    RedundancyTier      = 'zoneRedundancy'
                                    ZoneLocalIPAddress  = '1.1.1.8'
                                }
                                TunnelConfiguration     = @{
                                    PreSharedKey               = 'sdf'
                                    ZoneRedundancyPreSharedKey = 'asdf'
                                    AdditionalProperties       = @{
                                        "@odata.type"              = '#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default'
                                    }
                                }
                            }
                        );
                        ForwardingProfiles    = @();
                        Id                    = "fd5ada38-fb52-4f3d-b8db-ef31f0ba27e5";
                        Name                  = "jkjk";
                        Region                = "australiaSouthEast";
                    }
                }
            }
            It 'Should Reverse Engineer resource from the Export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
