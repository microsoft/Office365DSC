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
    -DscResource 'TeamsGroupPolicyAssignment' -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString ((New-Guid).ToString()) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            $Global:PartialExportFileName = 'c:\TestPath'


            Mock -CommandName Save-M365DSCPartialExport -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Find-CsGroup -MockWith {
                return @(
                    @{
                        Displayname = 'TestGroup'
                    }
                )
            }

            Mock -CommandName get-csTeamsCallingPolicy -MockWith {
                return @(
                    @{
                        Identity = "Tag:AllowCalling"
                    }
                )
            }

            Mock -CommandName Get-csGroupPolicyAssignment -MockWith {
            }

            Mock -CommandName New-csGroupPolicyAssignment -MockWith {
            }

            Mock -CommandName Remove-csGroupPolicyAssignment -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "When Policy assignment doesn't exist but should" -Fixture {
            BeforeAll {
                $testParams = @{
                    GroupId               = '00000000-0000-0000-0000-000000000000'
                    GroupDisplayname      = 'TestGroup'
                    PolicyType            = "TeamsCallingPolicy"
                    PolicyName            = "AllowCalling"
                    Priority              = "1"
                    Ensure                = 'Present'
                    Credential            = $Credential
                }

                Mock -CommandName  Get-CsGroupPolicyAssignment -MockWith {
                    return $null
                }
            }

            It 'Should return absent from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create the policy in the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-csGroupPolicyAssignment -Exactly 1
            }
        }

        Context -Name 'Policy assignemnt exists but is not in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    GroupId               = '00000000-0000-0000-0000-000000000000'
                    GroupDisplayname      = 'TestGroup'
                    PolicyType            = "TeamsCallingPolicy"
                    PolicyName            = "AllowCalling"
                    Priority              = "1"
                    Ensure                = 'Present'
                    Credential            = $Credential
                }

                Mock -CommandName Get-CsGroupPolicyAssignment -MockWith {
                    return @{
                        GroupId               = '00000000-0000-0000-0000-000000000000'
                        GroupDisplayname      = 'TestGroup'
                        PolicyType            = "TeamsCallingPolicy"
                        PolicyName            = "DisallowCalling"
                        Priority              = "1"
                        Ensure                = 'Present'
                    }
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should update the settings from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-csGroupPolicyAssignment -Exactly 1
                Should -Invoke -CommandName New-csGroupPolicyAssignment -Exactly 1
            }
        }

        Context -Name 'Policy assignment exists and is already in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    GroupId               = '00000000-0000-0000-0000-000000000000'
                    GroupDisplayname      = 'TestGroup'
                    PolicyType            = "TeamsCallingPolicy"
                    PolicyName            = "AllowCalling"
                    Priority              = "1"
                    Ensure                = 'Present'
                    Credential            = $Credential
                }

                Mock -CommandName Get-CsGroupPolicyAssignment -MockWith {
                    return @{
                        GroupId               = '00000000-0000-0000-0000-000000000000'
                        GroupDisplayname      = 'TestGroup'
                        PolicyType            = "TeamsCallingPolicy"
                        PolicyName            = "AllowCalling"
                        Priority              = "1"
                        Ensure                = 'Present'
                    }
                }
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'Policy assignment exists but it should not' -Fixture {
            BeforeAll {
                $testParams = @{
                    GroupId               = '00000000-0000-0000-0000-000000000000'
                    GroupDisplayname      = 'TestGroup'
                    PolicyType            = "TeamsCallingPolicy"
                    PolicyName            = "AllowCalling"
                    Priority              = "1"
                    Ensure                = 'Absent'
                    Credential            = $Credential
                }

                Mock -CommandName Get-CsGroupPolicyAssignment -MockWith {
                    return @{
                        GroupId               = '00000000-0000-0000-0000-000000000000'
                        GroupDisplayname      = 'TestGroup'
                        PolicyType            = "TeamsCallingPolicy"
                        PolicyName            = "AllowCalling"
                        Priority              = "1"
                        Ensure                = 'Present'
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
                Should -Invoke -CommandName Remove-csGroupPolicyAssignment -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-CsGroupPolicyAssignment -MockWith {
                    return @{
                        GroupId               = '00000000-0000-0000-0000-000000000000'
                        GroupDisplayname      = 'TestGroup'
                        PolicyType            = "TeamsCallingPolicy"
                        PolicyName            = "AllowCalling"
                        Priority              = "1"
                        Ensure                = 'Present'
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
