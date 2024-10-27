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
    -DscResource "AADHomeRealmDiscoveryPolicy" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
            }

            Mock -CommandName New-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
            }

            Mock -CommandName Remove-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
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
        # Test contexts
        Context -Name "The AADHomeRealmDiscoveryPolicy should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinition -Property @{
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $False
                            AlternateIdLogin      = New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin -Property @{
                                    Enabled = $True
                                } -ClientOnly
                        } -ClientOnly )
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
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
                Should -Invoke -CommandName New-MgBetaPolicyHomeRealmDiscoveryPolicy -Exactly 1
            }
        }

        Context -Name "The AADHomeRealmDiscoveryPolicy exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinition -Property @{
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $False
                            AlternateIdLogin      = New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin -Property @{
                                    Enabled = $True
                                } -ClientOnly
                        } -ClientOnly )
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = 'Absent'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
                    return @{
                        id         = "randomguid"
                        definition  = @(
                            '{"HomeRealmDiscoveryPolicy":{"PreferredDomain":"federated.example.edu","AlternateIdLogin":{"Enabled":true},"AccelerateToFederatedDomain":false}}'
                        )
                        displayName = "FakeStringValue"
                        description = "FakeStringValue"
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaPolicyHomeRealmDiscoveryPolicy -Exactly 1
            }
        }
        Context -Name "The AADHomeRealmDiscoveryPolicy Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinition -Property @{
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $False
                            AlternateIdLogin      = New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin -Property @{
                                    Enabled = $True
                                } -ClientOnly
                        } -ClientOnly )
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
                    return @{
                        id         = "randomguid"
                        definition  = @(
                            '{"HomeRealmDiscoveryPolicy":{"PreferredDomain":"federated.example.edu","AlternateIdLogin":{"Enabled":true},"AccelerateToFederatedDomain":false}}'
                        )
                        displayName = "FakeStringValue"
                        description = "FakeStringValue"
                        isOrganizationDefault = $True
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADHomeRealmDiscoveryPolicy exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinition -Property @{
                            PreferredDomain       = 'federated.example.edu'
                            AccelerateToFederatedDomain         = $False
                            AlternateIdLogin      = New-CimInstance -ClassName MSFT_AADHomeRealDiscoveryPolicyDefinitionAlternateIdLogin -Property @{
                                    Enabled = $True
                                } -ClientOnly
                        } -ClientOnly )
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
                    return @{
                        id         = "randomguid"
                        definition  = @(
                            '{"HomeRealmDiscoveryPolicy":{"PreferredDomain":"federated.example.edu","AlternateIdLogin":{"Enabled":true},"AccelerateToFederatedDomain":false}}'
                        )
                        displayName = "FakeStringValue"
                        description = "FakeStringValue New"
                        isOrganizationDefault = $False
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
                Should -Invoke -CommandName Update-MgBetaPolicyHomeRealmDiscoveryPolicy -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaPolicyHomeRealmDiscoveryPolicy -MockWith {
                    return @{
                        id         = "randomguid"
                        definition  = @(
                            '{"HomeRealmDiscoveryPolicy":{"PreferredDomain":"federated.example.edu","AlternateIdLogin":{"Enabled":true},"AccelerateToFederatedDomain":false}}'
                        )
                        displayName = "FakeStringValue"
                        description = "FakeStringValue"
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
