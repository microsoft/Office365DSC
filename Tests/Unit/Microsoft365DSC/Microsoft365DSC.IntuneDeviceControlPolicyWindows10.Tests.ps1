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
    -DscResource "IntuneDeviceControlPolicyWindows10" -GenericStubModule $GenericStubPath
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
                        TemplateId = '0f2034c6-3cd6-4ee1-bd37-f3c0693e9548_1'
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
                                Id = 'device_vendor_msft_policy_config_bluetooth_servicesallowedlist'
                                Name = 'ServicesAllowedList'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionDefinition'
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'device_vendor_msft_policy_config_bluetooth_servicesallowedlist'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = '47d9b9c4-e714-4a51-a099-33f548e4ea49'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance'
                                simpleSettingCollectionValue = @(
                                    @{
                                        '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                        value = 'abcd'
                                    }
                                )
                            }
                        }
                    },
                    @{
                        Id = '1'
                        SettingDefinitions = @(
                            @{
                                Id = 'device_vendor_msft_policy_config_connectivity_allowusbconnection'
                                Name = 'AllowUSBConnection'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'device_vendor_msft_policy_config_connectivity_allowusbconnection'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'bc92aa99-0993-4c65-a005-d5e5e6701486'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                choiceSettingValue = @{
                                    children = @()
                                    value = '1'
                                }
                            }
                        }
                    },
                    @{
                        Id = '2'
                        SettingDefinitions = @(
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                Name = 'Entry'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_id',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_options',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_sid',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_computersid'
                                    )
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                        }
                                    )
                                    maximumCount = 100
                                    minimumCount = 1
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_options'
                                Name = 'Options'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options = @(
                                        # Only option used in the tests is defined here
                                        @{
                                            name = 'Disable'
                                            itemId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_options_4'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type_allow'
                                                    parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type'
                                                },
                                                @{
                                                    dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type_deny'
                                                    parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                }
                                            )
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type'
                                Name = 'Type'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition'
                                    options = @(
                                        # Only option used in the tests is defined here
                                        @{
                                            name = 'Allow'
                                            itemId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type_allow'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                    parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                }
                                            )
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist_groupid'
                                Name = 'GroupId'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_name'
                                Name = 'Name'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}'
                                Name = 'ruleid'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                    )
                                    maximumCount = 100
                                    minimumCount = 1
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist'
                                Name = 'ExcludedIdList'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist_groupid'
                                    )
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                        }
                                    )
                                    maximumCount = 100
                                    minimumCount = 1
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_sid'
                                Name = 'Sid'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_id'
                                Name = 'Id'
                                OffsetUri = '/configuration/devicecontrol/policyrules/{0}/ruledata'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_includedidlist'
                                Name = 'IncludedIdList'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                Name = 'PolicyRule'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition'
                                    childIds = @(
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_id',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_name',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_includedidlist',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_excludedidlist',
                                        'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                    )
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}'
                                        }
                                    )
                                    maximumCount = 1
                                    minimumCount = 1
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_includedidlist_groupid'
                                Name = 'GroupId'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_includedidlist'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_includedidlist'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask'
                                Name = 'AccessMask'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionDefinition'
                                    maximumCount = 100
                                    minimumCount = 0
                                    options = @(
                                        @{
                                            name = 'WDD_READ_ACCESS'
                                            itemId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask_1'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                    parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                }
                                            )
                                        },
                                        @{
                                            name = 'WDD_WRITE_ACCESS'
                                            itemId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask_2'
                                            dependentOn = @(
                                                @{
                                                    dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                    parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                }
                                            )
                                        }
                                        # No more options for clarity
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_id'
                                Name = 'Id'
                                OffsetUri = '/configuration/devicecontrol/policyrules/{0}/ruledata'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                        }
                                    )
                                }
                            },
                            @{
                                Id = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_computersid'
                                Name = 'ComputerSid'
                                AdditionalProperties = @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingDefinition'
                                    dependentOn = @(
                                        @{
                                            dependentOn = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                            parentSettingId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                        }
                                    )
                                }
                            }
                        )
                        SettingInstance = @{
                            SettingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}'
                            SettingInstanceTemplateReference = @{
                                SettingInstanceTemplateId = 'a5c5409c-886a-4909-81c7-28156aee9419'
                            }
                            AdditionalProperties = @{
                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                groupSettingCollectionValue = @(
                                    @{
                                        children = @(
                                            @{
                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                                groupSettingCollectionValue = @(
                                                    @{
                                                        children = @(
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_id'
                                                                simpleSettingValue = @{
                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                    value = '{4fc8d684-1ff9-4525-a67e-9c8525f9fcd7}'
                                                                }
                                                            },
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_name'
                                                                simpleSettingValue = @{
                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                    value = 'asdf'
                                                                }
                                                            },
                                                            @{
                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry'
                                                                groupSettingCollectionValue = @(
                                                                    @{
                                                                        children = @(
                                                                            @{
                                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type'
                                                                                choiceSettingValue = @{
                                                                                    children = @(
                                                                                        @{
                                                                                            '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                                                                                            settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_options'
                                                                                            choiceSettingValue = @{
                                                                                                children = @()
                                                                                                value = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_options_4'
                                                                                            }
                                                                                        }
                                                                                    )
                                                                                    value = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_type_allow'
                                                                                }
                                                                            },
                                                                            @{
                                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance'
                                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask'
                                                                                choiceSettingCollectionValue = @(
                                                                                    @{
                                                                                        children = @()
                                                                                        value = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask_1'
                                                                                    },
                                                                                    @{
                                                                                        children = @()
                                                                                        value = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_accesmask_2'
                                                                                    }
                                                                                )
                                                                            },
                                                                            @{
                                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_sid'
                                                                                simpleSettingValue = @{
                                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                                    value = '1234'
                                                                                }
                                                                            },
                                                                            @{
                                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_computersid'
                                                                                simpleSettingValue = @{
                                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                                    value = '1234'
                                                                                }
                                                                            },
                                                                            @{
                                                                                '@odata.type' = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                                                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata_entry_id'
                                                                                simpleSettingValue = @{
                                                                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                                                                    value = '{51b6ad7f-7b07-493c-94c9-907a1842abd3}'
                                                                                }
                                                                            }
                                                                        )
                                                                    }
                                                                )

                                                            }
                                                        )
                                                    }
                                                )
                                                settingDefinitionId = 'device_vendor_msft_defender_configuration_devicecontrol_policyrules_{ruleid}_ruledata'
                                                settingInstanceTemplateReference = @{
                                                    settingInstanceTemplateId = '46c91d1a-89d2-4f6a-93f8-7a1dc4184024'
                                                }
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
        Context -Name "The IntuneDeviceControlPolicyWindows10 should exist but it DOES NOT" -Fixture {
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
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    AllowUSBConnection = "1"
                    PolicyRule = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule -Property @{
                            Entry = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry -Property @{
                                    AccessMask = @("1", "2")
                                    Sid = "1234"
                                    ComputerSid = "1234"
                                    Type = "allow"
                                    Options = "4"
                                } -ClientOnly)
                            )
                            Name = "asdf"
                        } -ClientOnly)
                    )
                    ServicesAllowedList = @("abcd")
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

        Context -Name "The IntuneDeviceControlPolicyWindows10 exists but it SHOULD NOT" -Fixture {
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
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    AllowUSBConnection = "1"
                    PolicyRule = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule -Property @{
                            Entry = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry -Property @{
                                    AccessMask = @("1", "2")
                                    Sid = "1234"
                                    ComputerSid = "1234"
                                    Type = "allow"
                                    Options = "4"
                                } -ClientOnly)
                            )
                            Name = "asdf"
                        } -ClientOnly)
                    )
                    ServicesAllowedList = @("abcd")
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = "Absent"
                    Credential = $Credential;
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
        Context -Name "The IntuneDeviceControlPolicyWindows10 Exists and Values are already in the desired state" -Fixture {
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
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    AllowUSBConnection = "1"
                    PolicyRule = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule -Property @{
                            Entry = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry -Property @{
                                    AccessMask = @("1", "2")
                                    Sid = "1234"
                                    ComputerSid = "1234"
                                    Type = "allow"
                                    Options = "4"
                                } -ClientOnly)
                            )
                            Name = "asdf"
                        } -ClientOnly)
                    )
                    ServicesAllowedList = @("abcd")
                    RoleScopeTagIds = @("FakeStringValue")
                    Ensure = "Present"
                    Credential = $Credential;
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneDeviceControlPolicyWindows10 exists and values are NOT in the desired state" -Fixture {
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
                    Id = "12345-12345-12345-12345-12345"
                    DisplayName = "Test"
                    AllowUSBConnection = "1"
                    PolicyRule = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule -Property @{
                            Entry = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry -Property @{
                                    AccessMask = @("1", "2")
                                    Sid = "1234"
                                    ComputerSid = "1234"
                                    Type = "deny" # Updated property
                                    Options = "4"
                                } -ClientOnly)
                            )
                            Name = "asdf"
                        } -ClientOnly)
                    )
                    ServicesAllowedList = @("abcd")
                    RoleScopeTagIds = @("FakeStringValue")
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
