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
    -DscResource "IntuneEndpointDetectionAndResponsePolicyLinux" -GenericStubModule $GenericStubPath
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
                return @{
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                }
            }

            Mock -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-IntuneSettingCatalogPolicySetting -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicySetting -MockWith {
                return @{
                    Id                   = 0
                    SettingDefinitions   = @(
                        @{
                            Id = 'linux_mdatp_managed_edr_tags'
                            Name = 'tags'
                            OffsetUri = 'tags'
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                childIds = @(
                                    'linux_mdatp_managed_edr_tags_item_key',
                                    'linux_mdatp_managed_edr_tags_item_value'
                                )
                                minimumCount = 0
                                maximumCount = 1
                            }
                        },
                        @{
                            Id = 'linux_mdatp_managed_edr_tags_item_value'
                            Name = 'tags_item_value'
                            OffsetUri = 'tags/[{0}]/value'
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                            }
                        },
                        @{
                            Id = 'linux_mdatp_managed_edr_tags_item_key'
                            Name = 'tags_item_key'
                            OffsetUri = 'tags/[{0}]/key'
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                            }
                        }
                    )
                    SettingInstance      = @{
                        SettingDefinitionId              = 'linux_mdatp_managed_edr_tags'
                        SettingInstanceTemplateReference = @{
                            SettingInstanceTemplateId = 'd0eb0a92-3807-4d9d-8432-6edd1aa108ce'
                        }
                        AdditionalProperties             = @{
                            '@odata.type'      = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                            groupSettingCollectionValue = @(
                                @{
                                    settingValueTemplateReference = $null
                                    children                   = @(
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                            choiceSettingValue = @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingInstance'
                                                children = @()
                                                value = 'linux_mdatp_managed_edr_tags_item_key_0'
                                            }
                                            settingDefinitionId = 'linux_mdatp_managed_edr_tags_item_key'
                                        },
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                            simpleSettingValue = @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                value = 'tag'
                                            }
                                            settingDefinitionId = 'linux_mdatp_managed_edr_tags_item_value'
                                        }
                                    )
                                }
                            )
                        }
                    }
                }
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id                = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    Description       = 'My Test Description'
                    Name              = 'My Test'
                    TemplateReference = @{
                        TemplateId     = '3514388a-d4d1-4aa8-bd64-c317776008f5_1'
                        TemplateFamily = 'endpointSecurityEndpointDetectionAndResponse'
                    }
                    RoleScopeTagIds   = @("FakeStringValue")
                }
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
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
        Context -Name "The IntuneEndpointDetectionAndResponsePolicyLinux should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Description = 'My Test Description'
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    DisplayName = 'My Test'
                    tags_item_key = '0'
                    tags_item_value = 'tag'
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

        Context -Name "The IntuneEndpointDetectionAndResponsePolicyLinux exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Description = 'My Test Description'
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    DisplayName = 'My Test'
                    tags_item_key = '0'
                    tags_item_value = 'tag'
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
        Context -Name "The IntuneEndpointDetectionAndResponsePolicyLinux Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Description = 'My Test Description'
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    DisplayName = 'My Test'
                    tags_item_key = '0'
                    tags_item_value = 'tag'
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential;
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneEndpointDetectionAndResponsePolicyLinux exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                        } -ClientOnly)
                    )
                    Description = 'My Test Description'
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                    DisplayName = 'My Test'
                    tags_item_key = '0'
                    tags_item_value = 'tag'
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicySetting -MockWith {
                    return @{
                        Id                   = 0
                        SettingDefinitions   = @(
                            @{
                                Id = 'linux_mdatp_managed_edr_tags'
                                Name = 'tags'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                }
                            },
                            @{
                                Id = 'linux_mdatp_managed_edr_tags_item_value'
                                Name = 'tags_item_value'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                }
                            },
                            @{
                                Id = 'linux_mdatp_managed_edr_tags_item_key'
                                Name = 'tags_item_key'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                }
                            }
                        )
                        SettingInstance      = @{
                            SettingDefinitionId              = 'linux_mdatp_managed_edr_tags'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'd0eb0a92-3807-4d9d-8432-6edd1aa108ce'
                            }
                            AdditionalProperties             = @{
                                '@odata.type'      = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                groupSettingCollectionValue = @(
                                    @{
                                        settingValueTemplateReference = $null
                                        children                   = @(
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                choiceSettingValue = @{
                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingInstance'
                                                    children = @()
                                                    value = 'linux_mdatp_managed_edr_tags_item_key_0'
                                                }
                                                settingDefinitionId = 'linux_mdatp_managed_edr_tags_item_key'
                                            },
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                simpleSettingValue = @{
                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                    value = 'tag1234' #drift
                                                }
                                                settingDefinitionId = 'linux_mdatp_managed_edr_tags_item_value'
                                            }
                                        )
                                    }
                                )
                            }
                        }
                    }
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
