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
    -DscResource 'IntuneAccountProtectionLocalUserGroupMembershipPolicy' -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString ((New-Guid).ToString()) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Update-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                }
            }

            Mock -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicyAssignment -MockWith {
                return @(@{
                    target = @{
                        deviceAndAppManagementAssignmentFilterType = 'none'
                        AdditionalProperties = @{
                            '@odata.type' = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId       = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        }
                    }
                })
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id    = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    Description = 'My Test Description'
                    Name        = 'My Test'
                    Settings    = @{
                        Id                   = 0
                        SettingDefinitions   = $null
                        SettingInstance      = @{
                            SettingDefinitionId              = 'device_vendor_msft_policy_config_localusersandgroups_configure'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'de06bec1-4852-48a0-9799-cf7b85992d45'
                            }
                            AdditionalProperties             = @{
                                '@odata.type'      = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                groupSettingCollectionValue = @(
                                    @{
                                        children = @(
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                                'settingDefinitionId' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup'
                                                'groupSettingCollectionValue' = @(
                                                    @{
                                                        'children' = @(
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                                'settingDefinitionId' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_userselectiontype'
                                                                'choiceSettingValue' = @{
                                                                    'value' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_userselectiontype_users'
                                                                    'children' = @(
                                                                        @{
                                                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance'
                                                                            'settingDefinitionId' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_users'
                                                                            'simpleSettingCollectionValue' = @(
                                                                                @{
                                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                                    'value' = 'S-1-12-1-1167842105-1150511762-402702254-1917434032'
                                                                                }
                                                                            )
                                                                        }
                                                                    )
                                                                }
                                                            },
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                                'settingDefinitionId' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_action'
                                                                'choiceSettingValue' = @{
                                                                    'value' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_action_add_update'
                                                                    'children' = @()
                                                                }
                                                            },
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                                'settingDefinitionId' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_desc'
                                                                'choiceSettingCollectionValue' = @(
                                                                    @{
                                                                        'value' = 'device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_desc_administrators'
                                                                        'children' = @()
                                                                    }
                                                                )
                                                            }
                                                        )
                                                    }
                                                )
                                            }
                                        )
                                    }
                                )
                            }
                        }
                        AdditionalProperties = $null
                    }
                    TemplateReference = @{
                        TemplateId = '22968f54-45fa-486c-848e-f8224aa69772_1'
                    }
                }
            }

            Mock -CommandName Update-IntuneDeviceConfigurationPolicy -MockWith {
            }

            Mock -CommandName Update-DeviceConfigurationPolicyAssignment -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false

        }

        # Test contexts
        Context -Name "When the instance doesn't already exist" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [ciminstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            DeviceAndAppManagementAssignmentFilterType = 'none'
                            GroupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Credential    = $Credential
                    Description   = 'My Test Description'
                    DisplayName   = 'My Test'
                    Ensure        = 'Present'
                    Identity      = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    LocalUserGroupCollection = [ciminstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupCollection -Property @{
                            LocalGroups = @('administrators', 'users')
                            Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                            Action = 'add_update'
                            UserSelectionType = 'users'
                        } -ClientOnly)
                    )
                }

                Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                    return $null
                }
            }

            It 'Should return absent from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgBetaDeviceManagementConfigurationPolicy' -Exactly 1
            }
        }

        Context -Name 'When the instance already exists and is NOT in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            DeviceAndAppManagementAssignmentFilterType = 'none'
                            GroupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Credential    = $Credential
                    Description   = 'My Test Description'
                    DisplayName   = 'My Test'
                    Ensure        = 'Present'
                    Identity      = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    LocalUserGroupCollection = [ciminstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupCollection -Property @{
                            LocalGroups = @('administrators')
                            Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                            Action = 'add_restrict' # Drift
                            UserSelectionType = 'users'
                        } -ClientOnly)
                    )
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should update the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-IntuneDeviceConfigurationPolicy -Exactly 1
            }
        }

        Context -Name 'When the instance already exists and IS in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Credential  = $Credential
                    Description = 'My Test Description'
                    DisplayName = 'My Test'
                    Ensure      = 'Present'
                    Identity    = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            DeviceAndAppManagementAssignmentFilterType = 'none'
                            GroupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    LocalUserGroupCollection = @(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupCollection -Property @{
                            LocalGroups = @('administrators')
                            Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                            Action = 'add_update'
                            UserSelectionType = 'users'
                        } -ClientOnly)
                    )
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'When the instance exists and it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = @(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            DeviceAndAppManagementAssignmentFilterType = 'none'
                            GroupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    LocalUserGroupCollection = @(
                        (New-CimInstance -ClassName MSFT_IntuneAccountProtectionLocalUserGroupCollection -Property @{
                            LocalGroups = @('administrators')
                            Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                            Action = 'add_update'
                            UserSelectionType = 'users'
                        } -ClientOnly)
                    )
                    Credential  = $Credential
                    Description = 'My Test Description'
                    DisplayName = 'My Test'
                    Ensure      = 'Absent'
                    Identity    = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -Exactly 1
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
