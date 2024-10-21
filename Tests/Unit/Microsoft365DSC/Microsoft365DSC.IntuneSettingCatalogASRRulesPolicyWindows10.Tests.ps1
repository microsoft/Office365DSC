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
    -DscResource 'IntuneSettingCatalogASRRulesPolicyWindows10' -GenericStubModule $GenericStubPath

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

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id = '619bd4a4-3b3b-4441-bd6f-3f4c0c444870'
                }
            }

            Mock -CommandName Update-IntuneDeviceConfigurationPolicy -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }

            Mock -CommandName Update-IntuneDeviceConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-IntuneSettingCatalogPolicySetting -MockWith {
            }

            Mock -CommandName Update-DeviceConfigurationPolicyAssignment -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicySetting -MockWith {
                return @(
                    @{
                        Id                   = '0'
                        SettingDefinitions   = @(
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                Name = 'AttackSurfaceReductionRules'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses',
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros',
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockcredentialstealingfromwindowslocalsecurityauthoritysubsystem',
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockallofficeapplicationsfromcreatingchildprocesses'
                                    )
                                    maximumCount = 1
                                    minimumCount = 0
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses'
                                Name = 'BlockAdobeReaderFromCreatingChildProcesses'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses_perruleexclusions'
                                Name = 'ASROnlyPerRuleExclusions'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionDefinition'
                                    maximumCount = 600
                                    minimumCount = 0
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses_block'
                                            parentSettingId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses'
                                        }
                                    )
                                }
                                OffsetUri = '/Configuration/ASROnlyPerRuleExclusions'
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                Name = 'BlockWin32APICallsFromOfficeMacros'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_perruleexclusions'
                                Name = 'ASROnlyPerRuleExclusions'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionDefinition'
                                    maximumCount = 600
                                    minimumCount = 0
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_block'
                                            parentSettingId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                        }
                                    )
                                }
                                OffsetUri = '/Configuration/ASROnlyPerRuleExclusions'
                            }
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockcredentialstealingfromwindowslocalsecurityauthoritysubsystem'
                                Name = 'BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockallofficeapplicationsfromcreatingchildprocesses'
                                Name = 'BlockAllOfficeApplicationsFromCreatingChildProcesses'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            }
                        )
                        SettingInstance      = @{
                            SettingDefinitionId              = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '19600663-e264-4c02-8f55-f2983216d6d7'
                            }
                            AdditionalProperties             = @(
                                @{
                                    '@odata.type'               = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                    groupSettingCollectionValue = @(
                                        @{
                                            children = @(
                                                @{
                                                    '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                    settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses'
                                                    choiceSettingValue  = @{
                                                        children = @(
                                                            @{
                                                                '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance'
                                                                settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses_perruleexclusions'
                                                                simpleSettingCollectionValue = @(
                                                                    @{
                                                                        '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                        value = 'Adobe Reader Exclusion'
                                                                    }
                                                                )
                                                            }
                                                        )
                                                        value = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockadobereaderfromcreatingchildprocesses_audit'
                                                    }
                                                },
                                                @{
                                                    '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                    settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                                    choiceSettingValue  = @{
                                                        children = @(
                                                            @{
                                                                '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance'
                                                                settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_perruleexclusions'
                                                                simpleSettingCollectionValue = @(
                                                                    @{
                                                                        '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                        value = 'Win32 API Calls Exclusion'
                                                                    }
                                                                )
                                                            }
                                                        )
                                                        value = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_block'
                                                    }
                                                },
                                                @{
                                                    '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                    settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockcredentialstealingfromwindowslocalsecurityauthoritysubsystem'
                                                    choiceSettingValue  = @{
                                                        children = @()
                                                        value = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockcredentialstealingfromwindowslocalsecurityauthoritysubsystem_warn'
                                                    }
                                                },
                                                @{
                                                    '@odata.type'       = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                    settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockallofficeapplicationsfromcreatingchildprocesses'
                                                    choiceSettingValue  = @{
                                                        children = @()
                                                        value = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockallofficeapplicationsfromcreatingchildprocesses_warn'
                                                    }
                                                }
                                            )
                                        }
                                    )
                                }
                            )
                        }
                        AdditionalProperties = @{}
                    }
                )
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id          = '12345-12345-12345-12345-12345'
                    Description = 'My Test'
                    Name        = 'asdfads'
                }
            }

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
            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "When the policy doesn't already exist" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    BlockAdobeReaderFromCreatingChildProcesses                          = 'audit'
                    BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions = @('Adobe Reader Exclusion')
                    BlockAllOfficeApplicationsFromCreatingChildProcesses                = 'warn'
                    BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem   = 'warn'
                    BlockWin32APICallsFromOfficeMacros                                  = 'block'
                    BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions         = @('Win32 API Calls Exclusion')
                    Credential                                                          = $Credential
                    Description                                                         = 'My Test'
                    DisplayName                                                         = 'asdfads'
                    Ensure                                                              = 'Present'
                    Identity                                                           = '12345-12345-12345-12345-12345'
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

            It 'Should create the policy from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaDeviceManagementConfigurationPolicy -Exactly 1
            }
        }

        Context -Name 'When the policy already exists and is NOT in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    BlockAdobeReaderFromCreatingChildProcesses                          = 'audit'
                    BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions = @('Adobe Reader Exclusion')
                    BlockAllOfficeApplicationsFromCreatingChildProcesses                = 'warn'
                    BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem   = 'block' # Drift
                    BlockWin32APICallsFromOfficeMacros                                  = 'block'
                    BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions         = @('Win32 API Calls Exclusion')
                    Credential                                                          = $Credential
                    Description                                                         = 'My Test'
                    DisplayName                                                         = 'asdfads'
                    Ensure                                                              = 'Present'
                    Identity                                                            = '12345-12345-12345-12345-12345'
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should update the policy from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-IntuneDeviceConfigurationPolicy -Exactly 1
            }
        }

        Context -Name 'When the policy already exists and IS in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    BlockAdobeReaderFromCreatingChildProcesses                          = 'audit'
                    BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions = @('Adobe Reader Exclusion')
                    BlockAllOfficeApplicationsFromCreatingChildProcesses                = 'warn'
                    BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem   = 'warn'
                    BlockWin32APICallsFromOfficeMacros                                  = 'block'
                    BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions         = @('Win32 API Calls Exclusion')
                    Credential                                                          = $Credential
                    Description                                                         = 'My Test'
                    DisplayName                                                         = 'asdfads'
                    Ensure                                                              = 'Present'
                    Identity                                                            = '12345-12345-12345-12345-12345'
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'When the policy exists and it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    BlockAdobeReaderFromCreatingChildProcesses                          = 'audit'
                    BlockAdobeReaderFromCreatingChildProcesses_ASROnlyPerRuleExclusions = @('Adobe Reader Exclusion')
                    BlockAllOfficeApplicationsFromCreatingChildProcesses                = 'warn'
                    BlockCredentialStealingFromWindowsLocalSecurityAuthoritySubsystem   = 'warn'
                    BlockWin32APICallsFromOfficeMacros                                  = 'block'
                    BlockWin32APICallsFromOfficeMacros_ASROnlyPerRuleExclusions         = @('Win32 API Calls Exclusion')
                    Credential                                                          = $Credential
                    Description                                                         = 'My Test'
                    DisplayName                                                         = 'asdfads'
                    Ensure                                                              = 'Absent'
                    Identity                                                            = '12345-12345-12345-12345-12345'
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the policy from the Set method' {
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

                Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                    return @{
                        Id                = '12345-12345-12345-12345-12345'
                        Description       = 'My Test'
                        Name              = 'asdfads'
                        TemplateReference = @{
                            TemplateId = 'e8c053d6-9f95-42b1-a7f1-ebfd71c67a4b_1'
                        }
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
