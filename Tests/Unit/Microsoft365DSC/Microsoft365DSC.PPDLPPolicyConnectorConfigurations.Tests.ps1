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

            Mock -commandName Remove-PowerAppDlpPolicyConnectorConfigurations -MockWith {}
            Mock -commandName New-PowerAppDlpPolicyConnectorConfigurations -MockWith {}
            Mock -commandName Get-TenantDetailsFromGraph -MockWith {
                return @{
                    TenantId = 'xxxxxxx'
                }
            }
            Mock -commandName Get-AdminDlpPolicy -MockWith {
                return @{
                    PolicyName = 'DSCPolicy'
                    DisplayName = 'DSCPolicy'
                }
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    ConnectorActionConfigurations =
                        (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsAction' -Property @{
                            actionRules = (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsActionRules' -Property @{
                                    actionId = 'CreateInvitation'
                                    behavior = 'Block'
                                } -ClientOnly)
                            connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                            defaultConnectorActionRuleBehavior = 'Allow'
                        } -ClientOnly)
                    PolicyName                    = "DSCPolicy";
                    PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
                    Ensure                        = 'Absent'
                    Credential                    = $Credential;
                }

                Mock -CommandName Get-PowerAppDlpPolicyConnectorConfigurations -MockWith {
                    return @{
                        connectorActionConfigurations = @(
                            @{
                                connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                                defaultConnectorActionRuleBehavior = 'Allow'
                                actionRules = @(
                                    @{
                                        actionId = 'CreateInvitation'
                                        behavior = 'Allow'
                                    }
                                )
                            }
                        )
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
                Should -Invoke -CommandName Remove-PowerAppDlpPolicyConnectorConfigurations -Exactly 1
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    ConnectorActionConfigurations =
                        (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsAction' -Property @{
                            actionRules = (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsActionRules' -Property @{
                                    actionId = 'CreateInvitation'
                                    behavior = 'Block'
                                } -ClientOnly)
                            connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                            defaultConnectorActionRuleBehavior = 'Allow'
                        } -ClientOnly)
                    PolicyName                    = "DSCPolicy";
                    PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
                    Ensure                        = 'Present'
                    Credential                    = $Credential;
                }

                Mock -CommandName Get-PowerAppDlpPolicyConnectorConfigurations -MockWith {
                    return @{
                        connectorActionConfigurations = @(
                            @{
                                connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                                defaultConnectorActionRuleBehavior = 'Allow'
                                actionRules = @(
                                    @{
                                        actionId = 'CreateInvitation'
                                        behavior = 'Block'
                                    }
                                )
                            }
                        )
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
                    ConnectorActionConfigurations =
                        (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsAction' -Property @{
                            actionRules = (New-CimInstance -ClassName 'MSFT_PPDLPPolicyConnectorConfigurationsActionRules' -Property @{
                                    actionId = 'CreateInvitation'
                                    behavior = 'Block'
                                } -ClientOnly)
                            connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                            defaultConnectorActionRuleBehavior = 'Allow'
                        } -ClientOnly)
                    PolicyName                    = "DSCPolicy";
                    PPTenantId                    = "e91d4e0e-d5a5-4e3a-be14-2192592a59af";
                    Ensure                        = 'Present'
                    Credential                    = $Credential;
                }

                Mock -CommandName Get-PowerAppDlpPolicyConnectorConfigurations -MockWith {
                    return @{
                        connectorActionConfigurations = @(
                            @{
                                connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                                defaultConnectorActionRuleBehavior = 'Allow'
                                actionRules = @(
                                    @{
                                        actionId = 'CreateInvitation'
                                        behavior = 'Allow' #Drift
                                    }
                                )
                            }
                        )
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
                Should -Invoke -CommandName New-PowerAppDlpPolicyConnectorConfigurations -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-PowerAppDlpPolicyConnectorConfigurations -MockWith {
                    return @{
                        connectorActionConfigurations = @(
                            @{
                                connectorId = '/providers/Microsoft.PowerApps/apis/shared_aadinvitationmanager'
                                defaultConnectorActionRuleBehavior = 'Allow'
                                actionRules = @(
                                    @{
                                        actionId = 'CreateInvitation'
                                        behavior = 'Block' #Drift
                                    }
                                )
                            }
                        )
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
