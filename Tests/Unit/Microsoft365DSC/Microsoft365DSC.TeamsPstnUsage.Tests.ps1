[CmdletBinding()]
param(
)
$M365DSCTestFolder = Join-Path -Path $PSScriptRoot `
                        -ChildPath "..\..\Unit" `
                        -Resolve
$CmdletModule = (Join-Path -Path $M365DSCTestFolder `
            -ChildPath "\Stubs\Microsoft365.psm1" `
            -Resolve)
$GenericStubPath = (Join-Path -Path $M365DSCTestFolder `
    -ChildPath "\Stubs\Generic.psm1" `
    -Resolve)
Import-Module -Name (Join-Path -Path $M365DSCTestFolder `
        -ChildPath "\UnitTestHelper.psm1" `
        -Resolve)

$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource 'TeamsPstnUsage' -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString 'Pass@word1' -AsPlainText -Force
            $GlobalAdminAccount = New-Object System.Management.Automation.PSCredential ('tenantadmin', $secpasswd)

            Mock -CommandName Test-MSCloudLogin -MockWith {
            }

            Mock -CommandName Set-CsOnlinePstnUsage -MockWith {
            }
        }

        # Test contexts
        Context -Name "When the policy doesn't already exist" -Fixture {
            BeforeAll {
                $testParams = @{
                    Usage               = 'Local'
                    Ensure              = 'Present'
                    GlobalAdminAccount  = $GlobalAdminAccount;
                }

                Mock -CommandName Get-CsOnlinePstnUsage -MockWith {
                    return New-Object PSObject -Property @{
                        Identity               = 'Global'
                        Usage                  = @()
                    }
                }
            }

            It "Should return absent from the Get method" {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It "Should return false from the Test method" {
                Test-TargetResource @testParams | Should -Be $false
            }

            It "Should create the policy from the Set method" {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Set-CsOnlinePstnUsage' -Exactly 1
            }
        }

        Context -Name 'When the policy already exists and IS in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Usage               = 'Local'
                    Ensure              = 'Present'
                    GlobalAdminAccount  = $GlobalAdminAccount;
                }

                Mock -CommandName Get-CsOnlinePstnUsage -MockWith {
                    return New-Object PSObject -Property @{
                        Identity               = 'Global'
                        Usage                  = @('Local')
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'When the policy already exists but it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Usage                  = 'Local'
                    Ensure                 = 'Absent'
                    GlobalAdminAccount     = $GlobalAdminAccount;
                }

                Mock -CommandName Get-CsOnlinePstnUsage -MockWith {
                    return New-Object PSObject -Property @{
                        Identity               = 'Global'
                        Usage                  = @('Local')
                    }
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the policy from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Set-CsOnlinePstnUsage -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $testParams = @{
                    GlobalAdminAccount     = $GlobalAdminAccount;
                }

                Mock -CommandName Get-CsOnlinePstnUsage -MockWith {
                    return New-Object PSObject -Property @{
                        Identity               = 'Global'
                        Usage                  = @('Local')
                    }
                }
            }

            It "Should Reverse Engineer resource from the Export method" {
                Export-TargetResource @testParams
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
