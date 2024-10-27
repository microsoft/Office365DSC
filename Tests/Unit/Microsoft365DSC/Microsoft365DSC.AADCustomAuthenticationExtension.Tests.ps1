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
    -DscResource "AADCustomAuthenticationExtension" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaIdentityCustomAuthenticationExtension -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityCustomAuthenticationExtension -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityCustomAuthenticationExtension -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $False
        }

        # Test Contexts
        Context -Name "The AADCustomAuthenticationExtension should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = "testcustomextension"
                    Description = "test description"
                    Ensure = "Present"
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaIdentityCustomAuthenticationExtension -MockWith {
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
                Should -Invoke -CommandName New-MgBetaIdentityCustomAuthenticationExtension -Exactly 1
            }
        }

        Context -Name 'The AADCustomAuthenticationExtension exists but it should not' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = "testcustomextension"
                    Description = "test description"
                    Ensure = "Absent"
                    Credential = $Credential
                    CustomAuthenticationExtensionType = "#microsoft.graph.onTokenIssuanceStartCustomExtension"
                    AuthenticationConfigurationType = "#microsoft.graph.azureAdTokenAuthentication"
                    AuthenticationConfigurationResourceId = "api://microsoft365dsc.com/a5352e69-55c0-4160-b4b5-03d034d842f"
                    ClientConfigurationTimeoutMilliseconds = 2000
                    ClientConfigurationMaximumRetries = 1
                    Id = "1f0c894f-d068-4f9c-af71-81d602569ad1"
                    ClaimsForTokenConfiguration = @()
                }

                Mock -CommandName Get-MgBetaIdentityCustomAuthenticationExtension -MockWith {
                    $customextension = New-Object PSCustomObject
                    $customextension | Add-Member -MemberType NoteProperty -Name DisplayName -Value "testcustomextension"
                    $customextension | Add-Member -MemberType NoteProperty -Name Description -Value "test description"
                    $customextension | Add-Member -MemberType NoteProperty -Name Id -Value "1f0c894f-d068-4f9c-af71-81d602569ad1"

                    return $customextension
                }
            }

            It 'Should return values from the get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
                Should -Invoke -CommandName 'Get-MgBetaIdentityCustomAuthenticationExtension' -Exactly 1
            }

            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the app from the set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Remove-MgBetaIdentityCustomAuthenticationExtension' -Exactly 1
            }
        }

        Context -Name 'The AADCustomAuthenticationExtension exists and values are in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = "testcustomextension"
                    Description = "test description"
                    Ensure = "Present"
                    Id = "1f0c894f-d068-4f9c-af71-81d602569ad1"
                }

                Mock -CommandName Get-MgBetaIdentityCustomAuthenticationExtension -MockWith {
                    $customextension = New-Object PSCustomObject
                    $customextension | Add-Member -MemberType NoteProperty -Name DisplayName -Value "testcustomextension"
                    $customextension | Add-Member -MemberType NoteProperty -Name Description -Value "test description"
                    $customextension | Add-Member -MemberType NoteProperty -Name Id -Value "1f0c894f-d068-4f9c-af71-81d602569ad1"

                    return $customextension
                }
            }

            It 'Should return values from the get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
                Should -Invoke -CommandName 'Get-MgBetaIdentityCustomAuthenticationExtension' -Exactly 1
            }

            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The AADCustomAuthenticationExtension exists and values are not in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = "testcustomextension"
                    Description = "test description modified"
                    Ensure = "Present"
                    Id = "1f0c894f-d068-4f9c-af71-81d602569ad1"
                }

                Mock -CommandName Get-MgBetaIdentityCustomAuthenticationExtension -MockWith {
                    $customextension = New-Object PSCustomObject
                    $customextension | Add-Member -MemberType NoteProperty -Name DisplayName -Value "testcustomextension"
                    $customextension | Add-Member -MemberType NoteProperty -Name Description -Value "test description"
                    $customextension | Add-Member -MemberType NoteProperty -Name Id -Value "1f0c894f-d068-4f9c-af71-81d602569ad1"

                    return $customextension
                }
            }

            It 'Should return values from the get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgBetaIdentityCustomAuthenticationExtension' -Exactly 1
            }

            It 'Should return false from the test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Update-MgBetaIdentityCustomAuthenticationExtension' -Exactly 1
            }
        }
    }
}
