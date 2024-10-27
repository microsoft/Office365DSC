[CmdletBinding()]
param()
$M365DSCTestFolder = Join-Path -Path $PSScriptRoot -ChildPath '..\..\Unit' -Resolve
$CmdletModule = (Join-Path -Path $M365DSCTestFolder -ChildPath '\Stubs\Microsoft365.psm1' -Resolve)
$GenericStubPath = (Join-Path -Path $M365DSCTestFolder -ChildPath '\Stubs\Generic.psm1' -Resolve)
Import-Module -Name (Join-Path -Path $M365DSCTestFolder -ChildPath '\UnitTestHelper.psm1' -Resolve)

$CurrentScriptPath = $PSCommandPath.Split('\')
$CurrentScriptName = $CurrentScriptPath[$CurrentScriptPath.Length -1]
$ResourceName      = $CurrentScriptName.Split('.')[1]
$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule -DscResource $ResourceName -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {}
            Mock -CommandName New-M365DSCConnection -MockWith { return "Credentials" }

            Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {}
            Mock -CommandName Invoke-MgGraphRequest -MockWith {}
            Mock -CommandName Remove-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {}

            # Hide Write-Host output during the tests
            Mock -CommandName Write-Host -MockWith {}

            $Script:exportedInstances = $null
            $Script:ExportMode = $false
        }

        # Context 1: Instance should exist but does not
        Context -Name "1. The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                                          = "androidManagedStoreAccountEnterpriseSettings"
                    BindStatus                                   = "notBound"
                    OwnerUserPrincipalName                       = "testuser@domain.com"
                    OwnerOrganizationName                        = "Test Organization"
                    EnrollmentTarget                             = "targetedAsEnrollmentRestrictions"
                    DeviceOwnerManagementEnabled                 = $False
                    AndroidDeviceOwnerFullyManagedEnrollmentEnabled = $False
                    Ensure                                       = 'Present'
                    Credential                                   = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith { return $null }
            }

            It '1.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It '1.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It '1.3 Should create a new instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Invoke-MgGraphRequest -Exactly 1
            }
        }

        # Context 2: Instance exists but should not
        Context -Name "2. The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                                          = "androidManagedStoreAccountEnterpriseSettings"
                    Ensure                                       = 'Absent'
                    Credential                                   = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {
                    return @{
                        Id                                        = "androidManagedStoreAccountEnterpriseSettings"
                        BindStatus                                = "bound"
                        OwnerUserPrincipalName                    = "existingUser@domain.com"
                        Ensure                                    = 'Present'
                    }
                }
            }

            It '2.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It '2.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It '2.3 Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -Exactly 1
            }
        }

        # Context 3: Instance exists and values are already in the desired state
        Context -Name "3. The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                                          = "androidManagedStoreAccountEnterpriseSettings"
                    BindStatus                                   = "bound"
                    OwnerUserPrincipalName                       = "existingUser@domain.com"
                    Ensure                                       = 'Present'
                    Credential                                   = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {
                    return @{
                        Id                                        = "androidManagedStoreAccountEnterpriseSettings"
                        BindStatus                                = "bound"
                        OwnerUserPrincipalName                    = "existingUser@domain.com"
                        Ensure                                    = 'Present'
                    }
                }
            }

            It '3.0 Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        # Context 4: Instance exists, but values are not in the desired state
        Context -Name "4. The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                                          = "androidManagedStoreAccountEnterpriseSettings"
                    BindStatus                                   = "notBound"
                    Ensure                                       = 'Present'
                    Credential                                   = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {
                    return @{
                        Id                                        = "androidManagedStoreAccountEnterpriseSettings"
                        BindStatus                                = "bound"
                        OwnerUserPrincipalName                    = "existingUser@domain.com"
                        Ensure                                    = 'Present'
                    }
                }
            }

            It '4.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It '4.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It '4.3 Should call the Set method to update the instance' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Invoke-MgGraphRequest -Exactly 1
            }
        }

        # Context 5: ReverseDSC Tests
        Context -Name '5. ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidManagedStoreAccountEnterpriseSetting -MockWith {
                    return @{
                        Id                                        = "androidManagedStoreAccountEnterpriseSettings"
                        BindStatus                                = "bound"
                        OwnerUserPrincipalName                    = "existingUser@domain.com"
                    }
                }
            }

            It '5.0 Should Reverse Engineer resource from the Export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope