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
    -DscResource 'IntuneTrustedRootCertificateAndroidEnterprise' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {
            $secpasswd = ConvertTo-SecureString ((New-Guid).ToString()) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Update-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementDeviceCompliancePolicyAssignment -MockWith {

                return @()
            }
            Mock -CommandName Update-DeviceConfigurationPolicyAssignment -MockWith {
            }
            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "When the IntuneTrustedRootCertificateAndroidEnterprise doesn't already exist" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                    Description                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                    certFileName                                = "FakeStringValue"
                    trustedRootCertificate                      = "fakestringvalue0"
                    Ensure                                      = 'Present'
                    Credential                                  = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return $null
                }
            }

            It 'Should return absent from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create the IntuneTrustedRootCertificateAndroidEnterprise from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgBetaDeviceManagementDeviceConfiguration' -Exactly 1
            }
        }

        Context -Name 'When the IntuneTrustedRootCertificateAndroidEnterprise already exists and is NOT in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName                = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                    Description                = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                    certFileName               = "FakeStringValue"
                    trustedRootCertificate     = "fakestringvalue0"
                    Ensure                     = 'Present'
                    Credential                 = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        DisplayName                      = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                        Description                      = 'Different Value'
                        Id                               = 'e30954ac-a65e-4dcb-ab79-91d45f3c52b4'                    
                        AdditionalProperties             = @{
                            certFileName                 = "FakeStringValue"
                            trustedRootCertificate       = "fakestringvalue0"
                            '@odata.type'             = '#microsoft.graph.androidTrustedRootCertificate'
                        }
                    }
                }
            }

            It 'Should return Present from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should update the IntuneTrustedRootCertificateAndroidEnterprise from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementDeviceConfiguration -Exactly 1
               
            }
        }

        Context -Name 'When the policy already exists and IS in the Desired State' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                    Description                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                    certFileName                                = "FakeStringValue"
                    trustedRootCertificate                      = "fakestringvalue0"
                    Ensure                                      = 'Present'
                    Credential                                  = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        DisplayName                             = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                        Description                             = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                        Id                                      = 'e30954ac-a65e-4dcb-ab79-91d45f3c52b4'                   
                        AdditionalProperties                    = @{
                            certFileName                        = "FakeStringValue"
                            trustedRootCertificate              = "fakestringvalue0"
                            '@odata.type'                       = '#microsoft.graph.androidTrustedRootCertificate'
                        }
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'When the policy exists and it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                    Description                                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                    certFileName                                = "FakeStringValue"
                    trustedRootCertificate                      = "fakestringvalue0"
                    Ensure                                      = 'Absent'
                    Credential                                  = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        DisplayName                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                        Description                 = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                        Id                          = 'e30954ac-a65e-4dcb-ab79-91d45f3c52b4'
                        AdditionalProperties        = @{
                            certFileName            = "FakeStringValue"
                            trustedRootCertificate  = "fakestringvalue0"
                            '@odata.type'           = '#microsoft.graph.androidTrustedRootCertificate'
                        }
                    }
                }
            }

            It 'Should return Present from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the IntuneTrustedRootCertificateAndroidEnterprise from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementDeviceConfiguration -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        DisplayName                      = 'Test IntuneTrustedRootCertificateAndroidEnterprise'
                        Description                      = 'Test IntuneTrustedRootCertificateAndroidEnterprise Description'
                        Id                               = 'e30954ac-a65e-4dcb-ab79-91d45f3c52b4'                     
                        AdditionalProperties             = @{
                            certFileName                 = "FakeStringValue"
                            trustedRootCertificate       = "fakestringvalue0"
                            '@odata.type'                = '#microsoft.graph.androidTrustedRootCertificate'
                        }
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