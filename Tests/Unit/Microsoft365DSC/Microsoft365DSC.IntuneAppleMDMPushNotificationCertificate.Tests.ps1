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

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

             # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
            }

            Mock -CommandName Update-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
            }

            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        #Test contexts

        Context -Name '1. The instance should exist but it DOES NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    AppleIdentifier         = "patched cert";
                    Certificate 	        = "Fake cert";
                    CertificateSerialNumber = "315224E2A4374274";
                    Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                    TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                    ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                    LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                    CertificateUploadStatus = "Success";
                    CertificateUploadFailureReason = "None";

                    Ensure                  = 'Present';
                    Credential              = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
                    return $null
                }
            }

            It '1.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It '1.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It '1.3 Should create a new instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementApplePushNotificationCertificate -Exactly 1
            }
        }

        Context -Name '2. The instance exists but it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    AppleIdentifier         = "patched cert";
                    Certificate 	        = "Fake cert";
                    CertificateSerialNumber = "315224E2A4374274";
                    Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                    TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                    ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                    LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                    CertificateUploadStatus = "Success";
                    CertificateUploadFailureReason = "None";

                    Ensure              = 'Absent'
                    Credential          = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
                    return @{
                        AppleIdentifier         = "patched cert";
                        Certificate 	        = "Fake cert";
                        CertificateSerialNumber = "315224E2A4374274";
                        Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                        TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                        ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                        LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                        CertificateUploadStatus = "Success";
                        CertificateUploadFailureReason = "None";
                    }
                }
            }

            It '2.1 Should return values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It '2.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It '2.3 Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementApplePushNotificationCertificate -Exactly 1
            }
        }

        Context -Name '3. The instance exists and values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    AppleIdentifier         = "Apple ID";
                    Certificate 	        = "Fake cert";
                    CertificateSerialNumber = "315224E2A4374274";
                    Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                    TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                    ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                    LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                    CertificateUploadStatus = "Success";
                    CertificateUploadFailureReason = "None";

                    Ensure                  = 'Present'
                    Credential              = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
                    return @{
                        AppleIdentifier         = "Apple ID";
                        Certificate 	        = "Fake cert";
                        CertificateSerialNumber = "315224E2A4374274";
                        Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                        TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                        ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                        LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                        CertificateUploadStatus = "Success";
                        CertificateUploadFailureReason = "None";
                    }
                }
            }

            It '3.0 Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name '4. The instance exists and values are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    AppleIdentifier         = "Apple ID";
                    Certificate 	        = "Fake cert";
                    CertificateSerialNumber = "315224E2A4374274";
                    Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                    TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                    ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                    LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                    CertificateUploadStatus = "Success";
                    CertificateUploadFailureReason = "None";

                    Ensure                  = 'Present'
                    Credential              = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
                    return @{
                        AppleIdentifier         = "Apple ID"; #drift
                        Certificate 	        = "Patched cert base64 string"; #drift
                        CertificateSerialNumber = "315224E2A4374274";
                        Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                        TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                        ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                        LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                        CertificateUploadStatus = "Success";
                        CertificateUploadFailureReason = "None";
                    }
                }
            }

            It '4.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It '4.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It '4.3 Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementApplePushNotificationCertificate -Exactly 1
            }
        }

        Context -Name '5. ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementApplePushNotificationCertificate -MockWith {
                    return @{
                        AppleIdentifier         = "Apple ID";
                        Certificate 	        = "Fake cert";
                        CertificateSerialNumber = "315224E2A4374274";
                        Id                      = "66f4ec83-754f-4a59-a73d-e3182cc636a5";
                        TopicIdentifier         = "com.apple.mgmt.External.0055e7e9-492b-4d46-967a-28fc5d49edb6";
                        ExpirationDateTime      = "10/25/2025 6:14:57 PM";
                        LastModifiedDateTime    = "10/27/2024 5:55:44 AM";
                        CertificateUploadStatus = "Success";
                        CertificateUploadFailureReason = "None";
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
