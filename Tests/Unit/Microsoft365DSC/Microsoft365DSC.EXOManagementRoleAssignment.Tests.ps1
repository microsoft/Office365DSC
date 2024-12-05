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
    -DscResource 'EXOManagementRoleAssignment' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            $Global:PartialExportFileName = 'c:\TestPath'

            Mock -CommandName Save-M365DSCPartialExport -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName New-ManagementRoleAssignment -MockWith {
            }

            Mock -CommandName Set-ManagementRoleAssignment -MockWith {
            }

            Mock -CommandName Remove-ManagementRoleAssignment -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Get-MgUser -MockWith {
                return @{
                    UserPrincipalName = "John.Smith"
                }
            }

            Mock -CommandName Start-Sleep -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name 'Management Role Assignment should exist, but it is not.' -Fixture {
            BeforeAll {
                $testParams = @{
                    Name       = 'Contoso Management Role'
                    Role       = 'MyRole'
                    User       = 'John.Smith'
                    Ensure     = 'Present'
                    Credential = $Credential
                }

                Mock -CommandName Get-ManagementRoleAssignment -MockWith {
                    return $null
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Assert-MockCalled -CommandName New-ManagementRoleAssignment -Exactly 1
            }

            It 'Should return Absent from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
        }

        Context -Name 'Management Role Assignment exists and is in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Name       = 'Contoso Management Role'
                    Role       = 'MyRole'
                    User       = 'John.Smith'
                    Ensure     = 'Present'
                    Credential = $Credential
                }

                Mock -CommandName Get-ManagementRoleAssignment -MockWith {
                    return @{
                        Name             = 'Contoso Management Role'
                        Role             = 'MyRole'
                        RoleAssignee     = 'John.Smith'
                        RoleAssigneeType = 'User'
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }

            It 'Should return Present from the Get Method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
        }

        Context -Name 'Management Role Assignment exists and is NOT the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Name                             = 'Contoso Management Role'
                    Role                             = 'MyRole'
                    User                             = 'Bob.Houle'
                    RecipientOrganizationalUnitScope = 'contoso.com/Legal/Users'
                    Ensure                           = 'Present'
                    Credential                       = $Credential
                }

                Mock -CommandName Get-ManagementRoleAssignment -MockWith {
                    return @{
                        Name                             = 'Contoso Management Role'
                        Role                             = 'MyRole'
                        RecipientOrganizationalUnitScope = 'contoso.com/Drift/Users'
                        RoleAssignee                     = 'Bob.Houle'
                        RoleAssigneeType                 = 'User'
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get Method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Assert-MockCalled -CommandName Remove-ManagementRoleAssignment -Exactly 1
                Assert-MockCalled -CommandName New-ManagementRoleAssignment -Exactly 1
            }
        }

        Context -Name 'Management Role Assignment exists and it SHOULD NOT.' -Fixture {
            BeforeAll {
                $testParams = @{
                    Name       = 'Contoso Management Role'
                    Role       = 'MyRole'
                    Ensure     = 'Absent'
                    Credential = $Credential
                }

                Mock -CommandName Get-ManagementRoleAssignment -MockWith {
                    return @{
                        Name             = 'Contoso Management Role'
                        Role             = 'MyRole'
                        RoleAssignee     = 'Bob.Houle'
                        RoleAssigneeType = 'User'
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should return Present from the Get Method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Assert-MockCalled -CommandName Remove-ManagementRoleAssignment -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                $ManagementRole = @{
                    Name   = 'Contoso Management Role Assignment'
                    Parent = 'MyRole'
                }

                Mock -CommandName Get-ManagementRoleAssignment -MockWith {
                    return @{
                        Name             = 'Contoso Management Role'
                        Role             = 'MyRole'
                        RoleAssignee     = 'Bob.Houle'
                        RoleAssigneeType = 'User'
                    }
                }
            }

            It 'Should Reverse Engineer resource from the Export method when single' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
