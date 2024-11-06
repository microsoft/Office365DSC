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
    -DscResource "AADRoleManagementPolicyRule" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaPolicyRoleManagementPolicyRule -MockWith {
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

        Context -Name "The AADRoleManagementPolicyRule Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    roleDisplayName = "FakeStringValue"
                    policyId = "FakeStringValue"
                    ruleType = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule"
                    expirationRule = (New-CimInstance -ClassName MSFT_AADRoleManagementPolicyExpirationRule -Property @{
                        isExpirationRequired = $true
                        maximumDuration = "FakeStringValue"
                    } -ClientOnly)
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleDefinition -MockWith {
                    return @{
                        Id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyAssignment -MockWith {
                    return @{
                        PolicyId = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyRule -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule"
                            isExpirationRequired = $true
                            maximumDuration = "FakeStringValue"
                        }
                        id = "FakeStringValue"
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADRoleManagementPolicyRule exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    roleDisplayName = "FakeStringValue"
                    policyId = "FakeStringValue"
                    ruleType = "#microsoft.graph.unifiedRoleManagementPolicyApprovalRule"
                    approvalRule = (New-CimInstance -ClassName MSFT_AADRoleManagementPolicyApprovalRule -Property @{
                        setting = (New-CimInstance -ClassName MSFT_AADRoleManagementPolicyApprovalSettings -Property @{
                            approvalMode = "FakeStringValue"
                            isApprovalRequired = $false #drift
                            isApprovalRequiredForExtension = $true
                            isRequestorJustificationRequired = $true
                            approvalStages = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_AADRoleManagementPolicyApprovalStage -Property @{
                                    approvalStageTimeOutInDays = 1
                                    escalationTimeInMinutes = 1
                                    isApproverJustificationRequired = $true
                                    isEscalationEnabled = $true
                                    escalationApprovers = [CimInstance[]]@(
                                        (New-CimInstance -ClassName MSFT_AADRoleManagementPolicySubjectSet -Property @{
                                            odataType = "FakeStringValue"
                                        } -ClientOnly)
                                    )
                                } -ClientOnly)
                            )
                        } -ClientOnly)
                    } -ClientOnly)
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleDefinition -MockWith {
                    return @{
                        Id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyAssignment -MockWith {
                    return @{
                        PolicyId = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyRule -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.unifiedRoleManagementPolicyApprovalRule"
                            setting = @{
                                approvalStages = @(
                                    @{
                                        approvalStageTimeOutInDays = 1 
                                        escalationApprovers = @(
                                            @{
                                                '@odata.type' = "FakeStringValue"
                                            }
                                        )
                                        isEscalationEnabled = $True
                                        isApproverJustificationRequired = $True
                                        escalationTimeInMinutes = 1
                                    }
                                )
                                isApprovalRequired = $True
                                isApprovalRequiredForExtension = $True
                                approvalMode = "FakeStringValue"
                                isRequestorJustificationRequired = $True
                            }
                        }
                        id = "FakeStringValue"
                    }
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaPolicyRoleManagementPolicyRule -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleDefinition -MockWith {
                    return @{
                        Id = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyAssignment -MockWith {
                    return @{
                        PolicyId = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaPolicyRoleManagementPolicyRule -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule"
                            isExpirationRequired = $true
                            maximumDuration = "FakeStringValue"
                        }
                        id = "FakeStringValue"
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
