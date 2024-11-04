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
    -DscResource "IntuneDeviceManagementComplianceManagementPartner" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
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
        Context -Name "The IntuneDeviceManagementComplianceManagementPartner should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AndroidEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    AndroidOnboarded = $True
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IosEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    IosOnboarded = $True
                    LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                    MacOsEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    MacOsOnboarded = $True
                    PartnerState = "unknown"
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
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
                Should -Invoke -CommandName New-MgBetaDeviceManagementComplianceManagementPartner -Exactly 1
            }
        }

        Context -Name "The IntuneDeviceManagementComplianceManagementPartner exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AndroidEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    AndroidOnboarded = $True
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IosEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    IosOnboarded = $True
                    LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                    MacOsEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    MacOsOnboarded = $True
                    PartnerState = "unknown"
                    Ensure = 'Absent'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.ComplianceManagementPartner"
                        }
                        AndroidEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        AndroidOnboarded = $True
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IosEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        IosOnboarded = $True
                        LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                        MacOsEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        MacOsOnboarded = $True
                        PartnerState = "unknown"

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
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementComplianceManagementPartner -Exactly 1
            }
        }
        Context -Name "The IntuneDeviceManagementComplianceManagementPartner Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AndroidEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    AndroidOnboarded = $True
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IosEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    IosOnboarded = $True
                    LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                    MacOsEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    MacOsOnboarded = $True
                    PartnerState = "unknown"
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.ComplianceManagementPartner"
                        }
                        AndroidEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        AndroidOnboarded = $True
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IosEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        IosOnboarded = $True
                        LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                        MacOsEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        MacOsOnboarded = $True
                        PartnerState = "unknown"

                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneDeviceManagementComplianceManagementPartner exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AndroidEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    AndroidOnboarded = $True
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IosEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    IosOnboarded = $True
                    LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                    MacOsEnrollmentAssignments = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_IntunecomplianceManagementPartnerAssignment -Property @{
                            Target = (New-CimInstance -ClassName MSFT_IntunedeviceAndAppManagementAssignmentTarget -Property @{
                                DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                GroupId = "FakeStringValue"
                                CollectionId = "FakeStringValue"
                                odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                                DeviceAndAppManagementAssignmentFilterType = "none"
                            } -ClientOnly)
                        } -ClientOnly)
                    )
                    MacOsOnboarded = $True
                    PartnerState = "unknown"
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
                    return @{
                        AndroidEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IosEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                        MacOsEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        PartnerState = "unknown"
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
                Should -Invoke -CommandName Update-MgBetaDeviceManagementComplianceManagementPartner -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementComplianceManagementPartner -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.ComplianceManagementPartner"
                        }
                        AndroidEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        AndroidOnboarded = $True
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IosEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        IosOnboarded = $True
                        LastHeartbeatDateTime = "2023-01-01T00:00:00.0000000+01:00"
                        MacOsEnrollmentAssignments = @(
                            @{
                                Target = @{
                                    DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                                    GroupId = "FakeStringValue"
                                    CollectionId = "FakeStringValue"
                                    '@odata.type' = "#microsoft.graph.allDevicesAssignmentTarget"
                                    DeviceAndAppManagementAssignmentFilterType = "none"
                                }
                            }
                        )
                        MacOsOnboarded = $True
                        PartnerState = "unknown"

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
