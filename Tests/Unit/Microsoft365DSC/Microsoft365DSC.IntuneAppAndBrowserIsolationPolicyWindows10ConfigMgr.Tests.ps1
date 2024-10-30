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

$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource "IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr" -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Update-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Update-IntuneDeviceConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id              = '12345-12345-12345-12345-12345'
                    Description     = 'My Test'
                    Name            = 'Test'
                    RoleScopeTagIds = @("FakeStringValue")
                    TemplateReference = @{
                        TemplateId = 'e373ebb7-c1c5-4ffb-9ce0-698f1834fd9d_1'
                    }
                }
            }

            Mock -CommandName Get-IntuneSettingCatalogPolicySetting -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicySetting -MockWith {
                return @(
                    @{
                        Id = '0'
                        SettingDefinitions = @(
                            @{
                                Id = 'device_vendor_msft_windowsdefenderapplicationguard_installwindowsdefenderapplicationguard'
                                Name = 'InstallWindowsDefenderApplicationGuard'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowwindowsdefenderapplicationguard'
                                Name = 'AllowWindowsDefenderApplicationGuard'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowpersistence'
                                Name = 'AllowPersistence'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowvirtualgpu'
                                Name = 'AllowVirtualGPU'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowcameramicrophoneredirection'
                                Name = 'AllowCameraMicrophoneRedirection'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            }
                        )
                        Settinginstance = @{
                            SettingDefinitionId = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowwindowsdefenderapplicationguard'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '1f2529c7-4b06-4ae6-bebc-210f7135676f'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                choiceSettingValue = @{
                                    children = @(
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                            settingDefinitionId = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowpersistence'
                                            choiceSettingValue = @{
                                                children = @()
                                                value = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowpersistence_0'
                                            }
                                        },
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                            settingDefinitionId = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowvirtualgpu'
                                            choiceSettingValue = @{
                                                children = @()
                                                value = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowvirtualgpu_0'
                                            }
                                        },
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                            settingDefinitionId = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowcameramicrophoneredirection'
                                            choiceSettingValue = @{
                                                children = @()
                                                value = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowcameramicrophoneredirection_1'
                                            }
                                        },
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                            settingDefinitionId = 'device_vendor_msft_windowsdefenderapplicationguard_installwindowsdefenderapplicationguard'
                                            choiceSettingValue = @{
                                                children = @()
                                                value = 'device_vendor_msft_windowsdefenderapplicationguard_installwindowsdefenderapplicationguard_install'
                                            }
                                        }
                                    )
                                    value = 'device_vendor_msft_windowsdefenderapplicationguard_settings_allowwindowsdefenderapplicationguard_1'
                                }
                            }
                        }
                    }
                )
            }

            Mock -CommandName Update-DeviceConfigurationPolicyAssignment -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicyAssignment -MockWith {
                return @(@{
                    Id       = '12345-12345-12345-12345-12345'
                    Source   = 'direct'
                    SourceId = '12345-12345-12345-12345-12345'
                    Target   = @{
                        DeviceAndAppManagementAssignmentFilterId   = '12345-12345-12345-12345-12345'
                        DeviceAndAppManagementAssignmentFilterType = 'none'
                        AdditionalProperties                       = @(
                            @{
                                '@odata.type' = '#microsoft.graph.exclusionGroupAssignmentTarget'
                                groupId       = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            }
                        )
                    }
                })
            }

        }
        # Test contexts
        Context -Name "The IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    AllowCameraMicrophoneRedirection       = "1";
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    InstallWindowsDefenderApplicationGuard = "install";
                    Description = "My Test"
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaDeviceManagementConfigurationPolicy -Exactly 1
            }
        }

        Context -Name "The IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    AllowCameraMicrophoneRedirection       = "1";
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    InstallWindowsDefenderApplicationGuard = "install";
                    Description = "My Test"
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Absent'
                    Credential = $Credential;
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -Exactly 1
            }
        }
        Context -Name "The IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    AllowCameraMicrophoneRedirection       = "1";
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    InstallWindowsDefenderApplicationGuard = "install";
                    Description = "My Test"
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential;
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    AllowCameraMicrophoneRedirection       = "0"; # Updated property
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    InstallWindowsDefenderApplicationGuard = "install";
                    Description = "My Test"
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential;
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
                Should -Invoke -CommandName Update-IntuneDeviceConfigurationPolicy -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
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
