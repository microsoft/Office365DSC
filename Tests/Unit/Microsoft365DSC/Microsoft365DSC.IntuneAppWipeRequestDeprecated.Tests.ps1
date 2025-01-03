[CmdletBinding()]
param ()

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

$CurrentScriptPath = $PSCommandPath.Split('\')
$CurrentScriptName = $CurrentScriptPath[$CurrentScriptPath.Length -1]
$ResourceName      = $CurrentScriptName.Split('.')[1]
$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource $ResourceName -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith { }
            Mock -CommandName New-M365DSCConnection -MockWith { return "Credentials" }

            # Mock Write-Host, Write-Verbose, and Write-Output to capture output during tests
            Mock -CommandName Write-Host -MockWith { }
            Mock -CommandName Write-Verbose -MockWith { }
            Mock -CommandName Write-Output -MockWith { }
            $Script:exportedInstances = $null
            $Script:ExportMode = $false
        }

        # Test contexts
        # Context 1: Instance should exist but does not
    Context 'Instance should exist but does not' {
        It '1.1 Should return Values from the Get method' {
            # Mock Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction to return no actions
            Mock -CommandName 'Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction' -MockWith { @() }

            $params = @{ Id = 'non-existent-id'; Ensure = 'Present' }
            $result = Get-TargetResource @params

            $result | Should -BeOfType 'hashtable'
            $result.Ensure | Should -Be 'Absent'
        }

        It '1.2 Should return false from the Test method' {
            Mock -CommandName 'Get-TargetResource' -MockWith { @{ Ensure = 'Absent' } }

            $params = @{ Id = 'non-existent-id'; Ensure = 'Present' }
            $result = Test-TargetResource @params

            $result | Should -Be $false
        }
    }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Status                       = 'status'
                    TargetedUserId               = 'targetUserId'
                    TargetedDeviceRegistrationId = 'deviceRegistrationId'
                    TargetedDeviceName           = 'deviceName'
                    TargetedDeviceMacAddress     = 'macAddress'
                    Ensure              = 'Absent'
                    Credential          = $Credential;
                    Id                  = 'testId'
                }

                # Mock Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction to return a 'Present' state
                Mock -CommandName Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
                    return @{
                        Id                           = 'testId'
                        Status                       = 'status'
                        TargetedUserId               = 'targetUserId'
                        TargetedDeviceRegistrationId = 'deviceRegistrationId'
                        TargetedDeviceName           = 'deviceName'
                        TargetedDeviceMacAddress     = 'macAddress'
                        Ensure                       = 'Present'
                    }
                }

                # Mock Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction to verify it's called
                Mock -CommandName Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
                    Write-Output "Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction called"
                }
            }

            It 'Should return Values from the Get method as Present' {
                # Confirm Get-TargetResource reflects the current state as 'Present'
                $getResult = Get-TargetResource @testParams
                $getResult.Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                # Verify Test-TargetResource returns false as current state is 'Present' but desired state is 'Absent'
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should invoke the Remove cmdlet in Set method when Ensure is Absent' {
                # Run Set-TargetResource to trigger the removal logic
                Set-TargetResource @testParams

                # Check that Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction was called
                Should -Invoke -CommandName Remove-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -Exactly 1
            }
        }



        # Context -Name "The instance exists and values are already in the desired state" -Fixture {
        #     BeforeAll {
        #         $testParams = @{
        #             Ensure              = 'Present'
        #             Credential          = $Credential;
        #             Id                  = 'testId'
        #         }

        #         Mock -CommandName Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
        #             return @{
        #                 Id = 'testId'
        #                 Status = 'status'
        #             }
        #         }
        #     }

        #     It 'Should return true from the Test method' {
        #         Test-TargetResource @testParams | Should -Be $true
        #     }
        # }

        # Context -Name "The instance exists and values are NOT in the desired state" -Fixture {
        #     BeforeAll {
        #         $testParams = @{
        #             Ensure              = 'Present'
        #             Credential          = $Credential;
        #             Id                  = 'testId'
        #             Status              = 'desiredStatus'
        #         }

        #         Mock -CommandName Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
        #             return @{
        #                 Id = 'testId'
        #                 Status = 'differentStatus'
        #             }
        #         }

        #         # Simulate 400 error for New cmdlet to test fallback
        #         Mock -CommandName New-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
        #             throw [System.Net.WebException]::new("No OData route exists that match template", [System.Net.HttpStatusCode]::BadRequest)
        #         }
        #     }

        #     It 'Should return Values from the Get method' {
        #         (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
        #     }

        #     It 'Should return false from the Test method' {
        #         Test-TargetResource @testParams | Should -Be $false
        #     }

        #     It 'Should handle unsupported New cmdlet gracefully in Set method' {
        #         Set-TargetResource @testParams
        #         Should -Invoke -CommandName Write-Output -Exactly 1
        #     }
        # }

        # Context -Name 'ReverseDSC Tests' -Fixture {
        #     BeforeAll {
        #         $Global:CurrentModeIsExport = $true
        #         $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
        #         $testParams = @{
        #             Credential  = $Credential;
        #         }

        #         Mock -CommandName Get-MgBetaDeviceAppManagementWindowsInformationProtectionWipeAction -MockWith {
        #             return @{
        #                 Id = 'testId'
        #             }
        #         }
        #     }

        #     It 'Should Reverse Engineer resource from the Export method' {
        #         $result = Export-TargetResource @testParams
        #         $result | Should -Not -BeNullOrEmpty
        #     }
        # }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
