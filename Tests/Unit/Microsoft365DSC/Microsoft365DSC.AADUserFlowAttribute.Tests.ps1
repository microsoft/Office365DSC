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
    -DscResource 'AADUserFlowAttribute' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            $Global:PartialExportFileName = 'c:\TestPath'

            Mock -CommandName Save-M365DSCPartialExport -MockWith {
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Update-MgBetaIdentityUserFlowAttribute -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityUserFlowAttribute -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityUserFlowAttribute -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name 'The user flow attribute should exist but it does not' -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Description        = "sai test description"
                    DataType           = "string"
                    Ensure          = 'Present'
                    Credential      = $Credential
                }

                Mock -CommandName Get-MgBetaIdentityUserFlowAttribute -MockWith {
                    return $null
                }
            }

            It 'Should return values from the get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
                Should -Invoke -CommandName 'Get-MgBetaIdentityUserFlowAttribute' -Exactly 2
            }
            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should create the role definition from the set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }
        }

        Context -Name 'The user flow attribute exists but it should not' -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Description        = "sai test description"
                    DataType           = "string"
                    Ensure          = 'Absent'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgBetaIdentityUserFlowAttribute -MockWith {
                    $userFlowAttribute = New-Object PSCustomObject
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Id -Value 'testIdSai'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DisplayName -Value 'saitest'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Description -Value 'sai test description'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DataType -Value 'string'
                    return $userFlowAttribute
                }
            }

            It 'Should return values from the get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
                Should -Invoke -CommandName 'Get-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }

            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the app from the set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Remove-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }
        }
        Context -Name 'The user flow attribute exists and values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Description        = "sai test description"
                    DataType           = "string"
                    Ensure          = 'Present'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgBetaIdentityUserFlowAttribute -MockWith {
                    $userFlowAttribute = New-Object PSCustomObject
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Id -Value 'testIdSai'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DisplayName -Value 'saitest'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Description -Value 'sai test description'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DataType -Value 'string'
                    return $userFlowAttribute
                }
            }

            It 'Should return Values from the get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }

            It 'Should return true from the test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'Values are not in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                 = "testIdSai"
                    DisplayName        = "saitest"
                    Description        = "sai test description"
                    DataType           = "string"
                    Ensure          = 'Present'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgBetaIdentityUserFlowAttribute -MockWith {
                    $userFlowAttribute = New-Object PSCustomObject
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Id -Value 'testIdSai'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DisplayName -Value 'saitest'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Description -Value 'sai test description changed'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DataType -Value 'string'
                    return $userFlowAttribute
                }
            }

            It 'Should return values from the get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }

            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Update-MgBetaIdentityUserFlowAttribute' -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgBetaIdentityUserFlowAttribute -MockWith {
                    $userFlowAttribute = New-Object PSCustomObject
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Id -Value 'testIdSai'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DisplayName -Value 'saitest'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name Description -Value 'sai test description changed'
                    $userFlowAttribute | Add-Member -MemberType NoteProperty -Name DataType -Value 'string'
                    return $userFlowAttribute
                }
            }

            It 'Should reverse engineer resource from the export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
