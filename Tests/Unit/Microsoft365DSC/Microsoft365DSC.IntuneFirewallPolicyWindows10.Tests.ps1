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
    -DscResource "IntuneFirewallPolicyWindows10" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Get-MgBetaDeviceManagementConfigurationPolicy -MockWith {
                return @{
                    Description = "FakeStringValue"
                    Id = "619bd4a4-3b3b-4441-bd6f-3f4c0c444870"
                    Name = "IntuneFirewallPolicyWindows10_1"
                    Platforms = "windows10"
                    RoleScopeTagIds = @("FakeStringValue")
                    Technologies = "mdm,microsoftSense"
                    TemplateReference = @{
                        templateId = "6078910e-d808-4a9f-a51d-1b8a7bacb7c0_1"
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
                                Id = 'vendor_msft_firewall_mdmstore_global_disablestatefulftp'
                                Name = 'DisableStatefulFtp'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'vendor_msft_firewall_mdmstore_global_disablestatefulftp'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '38329af6-2670-4a71-972d-482010ca97fc'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                choiceSettingValue = @{
                                    children = @()
                                    value = 'vendor_msft_firewall_mdmstore_global_disablestatefulftp_false'
                                }
                            }
                        }
                    },
                    @{
                        Id = '1'
                        SettingDefinitions = @(
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_domainprofile_enablefirewall'
                                Name = 'EnableFirewall'
                                OffsetUri = '/MdmStore/DomainProfile/EnableFirewall'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_domainprofile_logfilepath'
                                Name = 'LogFilePath'
                                OffsetUri = '/MdmStore/DomainProfile/LogFilePath'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'vendor_msft_firewall_mdmstore_domainprofile_enablefirewall_true'
                                            parentSettingId = 'vendor_msft_firewall_mdmstore_domainprofile_enablefirewall'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_publicprofile_enablefirewall'
                                Name = 'EnableFirewall'
                                OffsetUri = '/MdmStore/PublicProfile/EnableFirewall'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_publicprofile_logfilepath'
                                Name = 'LogFilePath'
                                OffsetUri = '/MdmStore/PublicProfile/LogFilePath'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'vendor_msft_firewall_mdmstore_publicprofile_enablefirewall_true'
                                            parentSettingId = 'vendor_msft_firewall_mdmstore_publicprofile_enablefirewall'
                                        }
                                    )
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'vendor_msft_firewall_mdmstore_domainprofile_enablefirewall'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '7714c373-a19a-4b64-ba6d-2e9db04a7684'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                choiceSettingValue = @{
                                    value = 'vendor_msft_firewall_mdmstore_domainprofile_enablefirewall_true'
                                    children = @(
                                        @{
                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                            settingDefinitionId = 'vendor_msft_firewall_mdmstore_domainprofile_logfilepath'
                                            simpleSettingValue = @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                value = '%systemroot%\system32\LogFiles\Firewall\pfirewall.log'
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    },
                    @{
                        Id = '2'
                        SettingDefinitions = @(
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_domainprofile_enablefirewall'
                                Name = 'EnableFirewall'
                                OffsetUri = '/MdmStore/HyperVVMSettings/{0}/DomainProfile/EnableFirewall'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options = @(
                                        # Only option used in the tests is defined here
                                        @{
                                            name = 'Enable Firewall'
                                            itemId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_domainprofile_enablefirewall_true'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target_wsl'
                                                    parentSettingId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target'
                                                }
                                            )
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_publicprofile_enablefirewall'
                                Name = 'EnableFirewall'
                                OffsetUri = '/MdmStore/HyperVVMSettings/{0}/PublicProfile/EnableFirewall'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options = @(
                                        # Only option used in the tests is defined here
                                        @{
                                            name = 'Enable Firewall'
                                            itemId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_publicprofile_enablefirewall_true'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target_wsl'
                                                    parentSettingId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target'
                                                }
                                            )
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target'
                                Name = 'Target'
                                OffsetUri = '/MdmStore/HyperVVMSettings/{0}/Target'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options = @(
                                        @{
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}'
                                                    parentSettingId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}'
                                                }
                                            )
                                            name = 'WSL'
                                            itemId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target_wsl'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}'
                                Name = '{VMCreatorId}'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target'
                                    )
                                    maximumCount = 1
                                    minimumCount = 0
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '24805bd4-1133-4790-82ae-4caa63e16aa6'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                groupSettingCollectionValue = @(
                                    @{
                                        children = @(
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                choiceSettingValue = @{
                                                    value = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target_wsl'
                                                    children = @(
                                                        @{
                                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                            settingDefinitionId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_domainprofile_enablefirewall'
                                                            choiceSettingValue = @{
                                                                children = @()
                                                                value = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_domainprofile_enablefirewall_true'
                                                            }
                                                        }
                                                    )
                                                }
                                                settingDefinitionId = 'vendor_msft_firewall_mdmstore_hypervvmsettings_{vmcreatorid}_target'
                                            }
                                        )
                                    }
                                )
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
        Context -Name "The IntuneFirewallPolicyWindows10 should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "FakeStringValue"
                    Id = "619bd4a4-3b3b-4441-bd6f-3f4c0c444870"
                    DisplayName = "IntuneFirewallPolicyWindows10_1"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = "Present"
                    Credential = $Credential;
                    DisableStatefulFtp           = "false";
                    DomainProfile_EnableFirewall = "true"
                    DomainProfile_LogFilePath    = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
                    HyperVVMSettings_DomainProfile_EnableFirewall = "true"
                    Target = "wsl"
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

        Context -Name "The IntuneFirewallPolicyWindows10 exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "FakeStringValue"
                    Id = "619bd4a4-3b3b-4441-bd6f-3f4c0c444870"
                    DisplayName = "IntuneFirewallPolicyWindows10_1"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Absent'
                    Credential = $Credential
                    DisableStatefulFtp           = "false";
                    DomainProfile_EnableFirewall = "true"
                    DomainProfile_LogFilePath    = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
                    HyperVVMSettings_DomainProfile_EnableFirewall = "true"
                    Target = "wsl"
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementConfigurationPolicy -Exactly 1
            }
        }
        Context -Name "The IntuneFirewallPolicyWindows10 Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "FakeStringValue"
                    Id = "619bd4a4-3b3b-4441-bd6f-3f4c0c444870"
                    DisplayName = "IntuneFirewallPolicyWindows10_1"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential
                    DisableStatefulFtp           = "false";
                    DomainProfile_EnableFirewall = "true"
                    DomainProfile_LogFilePath    = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
                    HyperVVMSettings_DomainProfile_EnableFirewall = "true"
                    Target = "wsl"
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneFirewallPolicyWindows10 exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Assignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_DeviceManagementConfigurationPolicyAssignments -Property @{
                            DataType     = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '26d60dd1-fab6-47bf-8656-358194c1a49d'
                            deviceAndAppManagementAssignmentFilterType = 'none'
                        } -ClientOnly)
                    )
                    Description = "FakeStringValue"
                    Id = "619bd4a4-3b3b-4441-bd6f-3f4c0c444870"
                    DisplayName = "IntuneFirewallPolicyWindows10_1"
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = 'Present'
                    Credential = $Credential
                    DisableStatefulFtp           = "true"
                    DomainProfile_EnableFirewall = "true"
                    DomainProfile_LogFilePath    = "%systemroot%\system32\LogFiles\Firewall\pfirewall_old.log"; # Updated value
                    HyperVVMSettings_DomainProfile_EnableFirewall = "true"
                    Target = "wsl"
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
