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
    -DscResource "IntuneSecurityBaselineDefenderForEndpoint" -GenericStubModule $GenericStubPath
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
                    Id = '12345-12345-12345-12345-12345'
                }
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Id              = '12345-12345-12345-12345-12345'
                    Description     = 'My Test'
                    Name            = 'My Test'
                    RoleScopeTagIds = @("FakeStringValue")
                    TemplateReference = @{
                        TemplateId = '49b8320f-e179-472e-8e2c-2fde00289ca2_1'
                    }
                }
            }
            Mock -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -MockWith {
            }
            Mock -CommandName Update-IntuneDeviceConfigurationPolicy -MockWith {
            }

            Mock -CommandName Get-IntuneSettingCatalogPolicySetting -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicySetting -MockWith {
                return @(
                    @{
                        Id = '0'
                        SettingDefinitions = @(
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockexecutionofpotentiallyobfuscatedscripts'
                                Name = 'BlockExecutionOfPotentiallyObfuscatedScripts'
                                OffsetUri = '/Config/Defender/AttackSurfaceReductionRules'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options=@(
                                        @{
                                            name ='off'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                                    parentSettingId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                                }
                                            )
                                            itemId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockexecutionofpotentiallyobfuscatedscripts_off'
                                        }
                                    )

                                }
                            },
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                Name = 'BlockWin32APICallsFromOfficeMacros'
                                OffsetUri = '/Config/Defender/AttackSurfaceReductionRules'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options=@(
                                        @{
                                            name ='Warn'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                                    parentSettingId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                                }
                                            )
                                            itemId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_warn'
                                        }
                                    )
                                }
                            }
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                                Name = 'AttackSurfaceReductionRules'
                                OffsetUri = '/Config/Defender/AttackSurfaceReductionRules'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    maximumCount = 1
                                    minimumCount = 0
                                    childIds = @(
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockexecutionofpotentiallyobfuscatedscripts',
                                        'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                    )
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'c1d89476-ce60-45a3-bdd7-eb378e54f826'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                groupSettingCollectionValue = @(
                                    @{
                                        children = @(
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                choiceSettingValue = @{
                                                    children = @()
                                                    value = "device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockexecutionofpotentiallyobfuscatedscripts_off"
                                                }
                                                settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockexecutionofpotentiallyobfuscatedscripts'
                                            }
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                choiceSettingValue = @{
                                                    children = @()
                                                    value = "device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros_warn"
                                                }
                                                settingDefinitionId = 'device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockwin32apicallsfromofficemacros'
                                            }
                                        )
                                    }
                                )
                            }
                         }

                    },

                    @{
                        Id = '1'
                        SettingDefinitions = @(
                            @{
                                Id = 'device_vendor_msft_policy_config_defender_allowrealtimemonitoring'
                                Name = 'AllowRealtimeMonitoring'
                                OffsetUri = '/Config/Defender/AllowRealtimeMonitoring'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options=@(
                                        @{
                                            name ='Allowed. Turns on and runs the real-time monitoring service.'
                                            itemId = 'device_vendor_msft_policy_config_defender_allowrealtimemonitoring_1'
                                        }
                                    )

                                }
                            }
                        )
                        SettingInstance = @{
                            AdditionalProperties = @{
                                '@odata.type' = "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance"
                                choiceSettingValue = @{
                                    children = @()
                                    value = "device_vendor_msft_policy_config_defender_allowrealtimemonitoring_1"
                                }
                            }
                            SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowrealtimemonitoring'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '775f8729-9ce5-4b6f-8afd-1ab61891d195'
                            }
                        }
                    },
                    @{
                        Id = '2'
                        SettingDefinitions = @(
                            @{
                                Id = 'user_vendor_msft_policy_config_internetexplorer_disablebypassofsmartscreenwarningsaboutuncommonfiles'
                                Name = 'DisableSafetyFilterOverrideForAppRepUnknown'
                                OffsetUri = '/Config/InternetExplorer/DisableBypassOfSmartScreenWarningsAboutUncommonFiles'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options=@(
                                        @{
                                            name ='Enabled'
                                            itemId = 'user_vendor_msft_policy_config_internetexplorer_disablebypassofsmartscreenwarningsaboutuncommonfiles_1'
                                        }
                                    )
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'user_vendor_msft_policy_config_internetexplorer_disablebypassofsmartscreenwarningsaboutuncommonfiles'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'f935a3e0-81d6-4546-98b7-c1f653531d9c'
                            }
                            AdditionalProperties = @{
                               '@odata.type' = "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance"
                                choiceSettingValue = @{
                                    children = @()
                                    value = "user_vendor_msft_policy_config_internetexplorer_disablebypassofsmartscreenwarningsaboutuncommonfiles_1"
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
        Context -Name "The IntuneSecurityBaselineDefenderForEndpoint should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "My Test"
                    deviceSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                        BlockWin32APICallsFromOfficeMacros = 'warn'
                        AllowRealtimeMonitoring = '1'
                    } -ClientOnly)
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "My Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    userSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        DisableSafetyFilterOverrideForAppRepUnknown= '1'
                    } -ClientOnly)
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

        Context -Name "The IntuneSecurityBaselineDefenderForEndpoint exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "My Test"
                    deviceSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                        BlockWin32APICallsFromOfficeMacros = 'warn'
                        AllowRealtimeMonitoring = '1'
                    } -ClientOnly)
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "My Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    userSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        DisableSafetyFilterOverrideForAppRepUnknown= '1'
                    } -ClientOnly)
                    Ensure = "Absent"
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
        Context -Name "The IntuneSecurityBaselineDefenderForEndpoint Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "My Test"
                    deviceSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                        BlockWin32APICallsFromOfficeMacros = 'warn'
                        AllowRealtimeMonitoring = '1'
                    } -ClientOnly)
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "My Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    userSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        DisableSafetyFilterOverrideForAppRepUnknown= '1'
                    } -ClientOnly)
                    Ensure = "Present"
                    Credential = $Credential;
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneSecurityBaselineDefenderForEndpoint exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "My Test"
                    deviceSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                        BlockWin32APICallsFromOfficeMacros = 'warn'
                        AllowRealtimeMonitoring = '1'
                    } -ClientOnly)
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "My Test"
                    RoleScopeTagIds = @("FakeStringValue")
                    userSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint -Property @{
                        DisableSafetyFilterOverrideForAppRepUnknown= '0'
                    } -ClientOnly)
                    Ensure = "Present"
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
