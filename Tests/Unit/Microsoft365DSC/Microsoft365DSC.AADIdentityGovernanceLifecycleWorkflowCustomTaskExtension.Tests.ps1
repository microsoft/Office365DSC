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

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            Mock -CommandName Remove-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
            }
            Mock -CommandName New-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
            }
            Mock -CommandName Update-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
            }
            Mock -CommandName Get-MgApplication -MockWith {
                return @{
                    id = '12345-12345-12345-12345-12345'
                    DisplayName = 'M365DSC'
                }
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
                    CallbackConfiguration = (New-CIMInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration -Property @{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    } -ClientOnly)
                    ClientConfiguration   = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration -Property @{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    } -ClientOnly)
                    Description           = "My Description";
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration -Property @{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    } -ClientOnly)
                    Ensure                = "Present";
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
                    return $null
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
                Should -Invoke -CommandName New-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -Exactly 1
            }
        }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    CallbackConfiguration = (New-CIMInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration -Property @{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    } -ClientOnly)
                    ClientConfiguration   = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration -Property @{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    } -ClientOnly)
                    Description           = "My Description";
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration -Property @{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    } -ClientOnly)
                    Ensure                = "Absent";
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
                    return @{                    
                        id = '12345-12345-12345-12345-12345'
                        authenticationConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
                            }
                        }
                        CallbackConfiguration = @{
                            TimeoutDuration = @{
                                Minutes = '34'
                            }
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
                                authorizedApps = @(
                                    @{
                                        id = '12345-12345-12345-12345-12345'
                                    }
                                )
                            }
                        }
                        ClientConfiguration   = @{
                            MaximumRetries = 1
                            TimeoutInMilliseconds = 1000
                        }
                        Description           = "My Description";
                        DisplayName           = "My Custom Extension";
                        EndpointConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type"         = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
                                subscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                                logicAppWorkflowName = 'MyTestApp'
                                resourceGroupName =    'TestRG'
                                url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
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

            It 'Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -Exactly 1
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    CallbackConfiguration = (New-CIMInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration -Property @{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    } -ClientOnly)
                    ClientConfiguration   = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration -Property @{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    } -ClientOnly)
                    Description           = "My Description";
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration -Property @{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    } -ClientOnly)
                    Ensure                = "Present";
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
                    return @{                    
                        id = '12345-12345-12345-12345-12345'
                        authenticationConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
                            }
                        }
                        CallbackConfiguration = @{
                            TimeoutDuration = @{
                                Minutes = '34'
                            }
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
                                authorizedApps = @(
                                    @{
                                        id = '12345-12345-12345-12345-12345'
                                    }
                                )
                            }
                        }
                        ClientConfiguration   = @{
                            MaximumRetries = 1
                            TimeoutInMilliseconds = 1000
                        }
                        Description           = "My Description";
                        DisplayName           = "My Custom Extension";
                        EndpointConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type"         = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
                                subscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                                logicAppWorkflowName = 'MyTestApp'
                                resourceGroupName =    'TestRG'
                                url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                            }
                        }
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    CallbackConfiguration = (New-CIMInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionCallbackConfiguration -Property @{
                        TimeoutDuration = 'PT34M'
                        AuthorizedApps = @('M365DSC')
                    } -ClientOnly)
                    ClientConfiguration   = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionClientConfiguration -Property @{
                        MaximumRetries = 1
                        TimeoutInMilliseconds = 1000
                    } -ClientOnly)
                    Description           = "My Description";
                    DisplayName           = "My Custom Extension";
                    EndpointConfiguration = (New-CimInstance -ClassName MSFT_AADIdentityGovernanceLifecycleWorkflowCustomTaskExtensionEndpointConfiguration -Property @{
                        SubscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                        logicAppWorkflowName = 'MyTestApp'
                        resourceGroupName =    'TestRG'
                        url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                    } -ClientOnly)
                    Ensure                = "Present";
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
                    return @{                    
                        id = '12345-12345-12345-12345-12345'
                        authenticationConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
                            }
                        }
                        CallbackConfiguration = @{
                            TimeoutDuration = @{
                                Minutes = '34'
                            }
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
                                authorizedApps = @(
                                    @{
                                        id = '12345-12345-12345-12345-12345'
                                    }
                                )
                            }
                        }
                        ClientConfiguration   = @{
                            MaximumRetries = 2 #drift
                            TimeoutInMilliseconds = 1000
                        }
                        Description           = "My Description";
                        DisplayName           = "My Custom Extension";
                        EndpointConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type"         = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
                                subscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                                logicAppWorkflowName = 'MyTestApp'
                                resourceGroupName =    'TestRG'
                                url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
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
                Should -Invoke -CommandName Update-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityGovernanceLifecycleWorkflowCustomTaskExtension -MockWith {
                    return @{
                        id = '12345-12345-12345-12345-12345'
                        authenticationConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
                            }
                        }
                        CallbackConfiguration = @{
                            TimeoutDuration = @{
                                Minutes = '34'
                            }
                            AdditionalProperties = @{
                                "@odata.type" = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
                                authorizedApps = @(
                                    @{
                                        id = '12345-12345-12345-12345-12345'
                                    }
                                )
                            }
                        }
                        ClientConfiguration   = @{
                            MaximumRetries = 1
                            TimeoutInMilliseconds = 1000
                        }
                        Description           = "My Description";
                        DisplayName           = "My Custom Extension";
                        EndpointConfiguration = @{
                            AdditionalProperties = @{
                                "@odata.type"         = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
                                subscriptionId =       '63e62ab2-fd92-46ce-a393-2cb338039cc7'
                                logicAppWorkflowName = 'MyTestApp'
                                resourceGroupName =    'TestRG'
                                url = 'https://prod-35.eastus.logic.azure.com:443/workflows/xxxxxxxxxxx/triggers/manual/paths/invoke?api-version=2016-10-01'
                            }
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
