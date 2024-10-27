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

            Mock -CommandName New-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
            }

            Mock -CommandName Remove-M365DSCAzureBillingAccountsRoleAssignment -MockWith {

            }

            Mock -CommandName Get-M365DSCAzureBillingAccountsRoleDefinition -MockWith {
                return @{
                    properties = @{
                        roleName = 'Billing account owner'
                    }
                }
            }

            Mock -CommandName Get-M365DSCAzureBillingAccount -MockWith {
                return @{
                    value = @(
                        @{
                            name = "12345-12345-12345-12345-12345"
                            properties = @{
                                displayName = 'MyBillingAccount'
                            }
                        }
                    )
                }
            }

            Mock -CommandName Get-MgUser -MockWith {
                return @(
                    @{
                        id = '12345-12345-12345-12345-12345'
                        UserPrincipalName = 'John.Smith@Contoso.com'
                    }
                )
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
                    BillingAccount        = "MyBillingAccount";
                    PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
                    PrincipalType         = "User";
                    PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                    RoleDefinition        = "Billing account owner";
                    Ensure                = 'Present'
                    Credential            = $Credential;
                }

                Mock -CommandName Get-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
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
                Should -Invoke -CommandName New-M365DSCAzureBillingAccountsRoleAssignment -Exactly 1
            }
        }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    BillingAccount        = "MyBillingAccount";
                    PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
                    PrincipalType         = "User";
                    PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                    RoleDefinition        = "Billing account owner";
                    Ensure                = 'Absent'
                    Credential            = $Credential;
                }

                Mock -CommandName Get-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
                    return @{
                        value = @(
                            @{
                                id = '/assignment/22222-22222-22222-22222-22222'
                                properties = @{
                                    principalId = '12345-12345-12345-12345-12345'
                                    principalType = 'User'
                                    RoleDefinitionId = '/providers/Microsoft.Billing/billingAccounts/1e5b9e50-a1ea-581e-fb3a-778b93a06854:6487d5cf-0a7b-42e6-9549-23ca416fb8bf_2019-05-31/billingRoleDefinitions/22222-22222-22222-22222-22222'
                                    principalTenantId = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                                }
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
                Should -Invoke -CommandName Remove-M365DSCAzureBillingAccountsRoleAssignment -Exactly 1
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    BillingAccount        = "MyBillingAccount";
                    PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
                    PrincipalType         = "User";
                    PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                    RoleDefinition        = "Billing account owner";
                    Ensure                = 'Present'
                    Credential            = $Credential;
                }

                Mock -CommandName Get-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
                    return @{
                        value = @(
                            @{
                                id = '/assignment/22222-22222-22222-22222-22222'
                                properties = @{
                                    principalId = '12345-12345-12345-12345-12345'
                                    principalType = 'User'
                                    RoleDefinitionId = '/providers/Microsoft.Billing/billingAccounts/1e5b9e50-a1ea-581e-fb3a-778b93a06854:6487d5cf-0a7b-42e6-9549-23ca416fb8bf_2019-05-31/billingRoleDefinitions/22222-22222-22222-22222-22222'
                                    principalTenantId = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                                }
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
                    BillingAccount        = "MyBillingAccount";
                    PrincipalName         = "John.Smith@contoso.onmicrosoft.com";
                    PrincipalType         = "User";
                    PrincipalTenantId     = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                    RoleDefinition        = "Billing account contributor"; #drift
                    Ensure                = 'Present'
                    Credential            = $Credential;
                }

                Mock -CommandName Get-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
                    return @{
                        value = @(
                            @{
                                id = '/assignment/22222-22222-22222-22222-22222'
                                properties = @{
                                    principalId = '12345-12345-12345-12345-12345'
                                    principalType = 'User'
                                    RoleDefinitionId = '/providers/Microsoft.Billing/billingAccounts/1e5b9e50-a1ea-581e-fb3a-778b93a06854:6487d5cf-0a7b-42e6-9549-23ca416fb8bf_2019-05-31/billingRoleDefinitions/22222-22222-22222-22222-22222'
                                    principalTenantId = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                                }
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
                Should -Invoke -CommandName New-M365DSCAzureBillingAccountsRoleAssignment -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-M365DSCAzureBillingAccountsRoleAssignment -MockWith {
                    return @{
                        value = @(
                            @{
                                id = '/assignment/22222-22222-22222-22222-22222'
                                properties = @{
                                    principalId = '12345-12345-12345-12345-12345'
                                    principalType = 'User'
                                    RoleDefinitionId = '/providers/Microsoft.Billing/billingAccounts/1e5b9e50-a1ea-581e-fb3a-778b93a06854:6487d5cf-0a7b-42e6-9549-23ca416fb8bf_2019-05-31/billingRoleDefinitions/22222-22222-22222-22222-22222'
                                    principalTenantId = '9c888910-6b3b-4c17-8cff-844fefb026d4'
                                }
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
