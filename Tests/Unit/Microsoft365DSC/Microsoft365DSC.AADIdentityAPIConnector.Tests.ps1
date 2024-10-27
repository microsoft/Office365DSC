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
    -DscResource "AADIdentityAPIConnector" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaIdentityAPIConnector -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityAPIConnector -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityAPIConnector -MockWith {
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
        Context -Name "The AADIdentityAPIConnector should exist but it DOES NOT" -Fixture {
            BeforeAll {

                $testParams = @{
                    DisplayName = 'FakeStringValue'
                    TargetUrl = 'FakeStringValue'
                    Id = 'FakeStringValue'
                    Username = 'FakeStringValue'
                    Password = $Credential
                    Certificates = @(
                         New-CimInstance -ClassName 'MSFT_AADIdentityAPIConnectionCertificate' -Property @{
                             Thumbprint = 'FakeStringValue'
                             Pkcs12Value = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             Password = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             IsActive = $true
                         } -ClientOnly
                    )
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
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
                Should -Invoke -CommandName New-MgBetaIdentityAPIConnector -Exactly 1
            }
        }

        Context -Name "The AADIdentityAPIConnector exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = 'FakeStringValue'
                    TargetUrl = 'FakeStringValue'
                    Id = 'FakeStringValue'
                    Username = 'FakeStringValue'
                    Password = $Credential
                    Certificates = @(
                         New-CimInstance -ClassName 'MSFT_AADIdentityAPIConnectionCertificate' -Property @{
                             Thumbprint = 'FakeStringValue'
                             Pkcs12Value = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             Password = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             IsActive = $true
                         } -ClientOnly
                    )
                    Credential = $Credential
                    Ensure = 'Absent'
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
                    return @{
                        DisplayName = 'FakeStringValue'
                        TargetUrl = 'FakeStringValue'
                        Id = 'FakeStringValue'
                        AuthenticationConfiguration = @{
                            AdditionalProperties = @{
                                Username = 'FakeStringValue'
                                Password = $Cred
                            }
                        }
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
                Should -Invoke -CommandName Remove-MgBetaIdentityAPIConnector -Exactly 1
            }
        }
        Context -Name "The AADIdentityAPIConnector Exists and Values are already in the desired state" -Fixture {
            BeforeAll {

                $testParams = @{
                    DisplayName = 'FakeStringValue'
                    TargetUrl = 'FakeStringValue'
                    Id = 'FakeStringValue'
                    Username = 'FakeStringValue'
                    Password = $Credential
                    Credential = $Credential
                    Ensure = 'Present'
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
                    return @{
                        DisplayName = 'FakeStringValue'
                        TargetUrl = 'FakeStringValue'
                        Id = 'FakeStringValue'
                        AuthenticationConfiguration = @{
                            AdditionalProperties = @{
                                Username = 'FakeStringValue'
                                Password = $Cred
                            }
                        }
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADIdentityAPIConnector exists and values are NOT in the desired state" -Fixture {

            BeforeAll {
                $testParams = @{
                    DisplayName = 'FakeStringValue2' #drift
                    TargetUrl = 'FakeStringValue'
                    Id = 'FakeStringValue'
                    Username = 'FakeStringValue'
                    Password = $Credential
                    Credential = $Credential
                    Ensure = 'Present'
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
                    return @{
                        DisplayName = 'FakeStringValue'
                        TargetUrl = 'FakeStringValue'
                        Id = 'FakeStringValue'
                        AuthenticationConfiguration = @{
                            AdditionalProperties = @{
                                Username = 'FakeStringValue'
                                Password = 'FakeStringValue' 
                            }
                        }
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
                Should -Invoke -CommandName Update-MgBetaIdentityAPIConnector -Exactly 1
            }
        }


        Context -Name "The AADIdentityAPIConnector with certificates exists and values are in the desired state" -Fixture {

            BeforeAll {
                $testParams = @{
                    DisplayName = 'FakeStringValue' 
                    TargetUrl = 'FakeStringValue'
                    Id = 'FakeStringValue'
                    Certificates = @(
                         New-CimInstance -ClassName 'MSFT_AADIdentityAPIConnectionCertificate' -Property @{
                             Thumbprint = 'FakeStringValue'
                             Pkcs12Value = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             Password = (New-CimInstance -ClassName 'MSFT_Credential' -Property @{
                                 Username = 'FakeStringValue'
                                 Password = 'FakeStringValue'
                             } -ClientOnly)
                             IsActive = $true
                         } -ClientOnly
                    )
                    Credential = $Credential
                    Ensure = 'Present'
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
                    return @{
                        DisplayName = 'FakeStringValue'
                        TargetUrl = 'FakeStringValue'
                        Id = 'FakeStringValue'
                        AuthenticationConfiguration = @{
                            AdditionalProperties = @{
                                certificateList = @(
                                    @{
                                        Thumbprint = 'FakeStringValue'
                                        IsActive = $true
                                    }
                                )
                            }
                        }
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaIdentityAPIConnector -MockWith {
                    return @{
                        DisplayName = 'FakeStringValue'
                        TargetUrl = 'FakeStringValue'
                        Id = 'FakeStringValue'
                        AuthenticationConfiguration = @{
                            AdditionalProperties = @{
                                Username = 'FakeStringValue'
                                Password = 'FakeStringValue' 
                            }
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
