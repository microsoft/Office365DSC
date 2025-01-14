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
    -DscResource 'SCDeviceTenantPolicy' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)


            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Import-PSSession -MockWith {
            }

            Mock -CommandName New-PSSession -MockWith {
            }

            Mock -CommandName Remove-DeviceTenantPolicy -MockWith {
                # This mock should not return anything. Remove-* are normally void methods without any return types
            }

            Mock -CommandName Set-DeviceTenantPolicy -MockWith {
            }

            Mock -CommandName New-DeviceTenantPolicy -MockWith {
                return @{
                    # This mock can simply return an empty object for the purpose of these tests.
                }
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "The Device Tenant Policy doesn't already exist" -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Present'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return $null # Policy Not found, therefore return null
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Absent from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams

                # Because the policy was not found, the set method should attempt to create it
                # Therefore we want to assess that the New-* method was called exactly once
                Should -Invoke -CommandName 'New-DeviceTenantPolicy' -Exactly 1
            }
        }

        Context -Name 'The Device tenant Policy already exists and it is already in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Present'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $true
                        Mode = "Enforce"
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
        }

        Context -Name 'The Device tenant Policy already exists and it is NOT in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Present'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $false
                        Mode = "Enforce"
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It 'Should update the policy in the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Set-DeviceTenantPolicy' -Exactly 1
            }
        }

        Context -Name 'The Device tenant Policy Exists but it Should NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Absent'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $false
                        Mode = "Enforce"
                    }
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should Delete from the Set method' {
                Set-TargetResource @testParams

                # Because the policy was not found, the set method should attempt to delete it
                # Therefore we want to assess that the Remove-* method was called exactly once
                Should -Invoke -CommandName 'Remove-DeviceTenantPolicy' -Exactly 1
            }
        }

        Context -Name 'The Device tenant Policy Exists but it Should NOT and is pending deletion so no action is needed.' -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Absent'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $false
                        Mode = "PendingDeletion"
                    }
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should Delete from the Set method' {
                Set-TargetResource @testParams

                # Because the policy was not found, the set method should attempt to delete it
                # Therefore we want to assess that the Remove-* method was called exactly once
                Should -Invoke -CommandName 'Remove-DeviceTenantPolicy' -Exactly 0
            }
        }

        Context -Name 'The Device tenant Policy already exists and it is NOT in the Desired State but is pending deletion so no action should be taken.' -Fixture {
            BeforeAll {
                $testParams = @{
                    Ensure     = 'Present'
                    Enabled    = $true
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $false
                        Mode = "PendingDeletion"
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It 'Should not update the policy in the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Set-DeviceTenantPolicy' -Exactly 0
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-DeviceTenantPolicy -MockWith {
                    return @{
                        Enabled = $false
                        Mode = "Enforce"
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
