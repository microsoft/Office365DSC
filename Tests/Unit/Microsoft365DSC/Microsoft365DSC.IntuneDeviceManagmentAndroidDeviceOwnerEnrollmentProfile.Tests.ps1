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

            Mock -CommandName New-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
            }
            Mock -CommandName Remove-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $userName = "Whatever"
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                    DisplayName             = "Android Owner Enrollment Profile"
                    Description             = "Profile for enrolling Android devices"
                    TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                    TokenValue              = "your-token-value"
                    EnrollmentMode          = "corporateOwnedWorkProfile"
                    QrCodeContent           = "your-qr-code-content"
                    WifiSsid                = "your-wifi-ssid"
                    WifiPassword            = New-Object System.Management.Automation.PSCredential ($userName, (ConvertTo-SecureString "your-wifi-password" -AsPlainText -Force))
                    WifiSecurityType        = "wpa"
                    Ensure                  = 'Present'
                    Credential              = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create a new instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -Exactly 1
            }
        }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                    DisplayName             = "Android Owner Enrollment Profile"
                    Description             = "Profile for enrolling Android devices"
                    TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                    TokenValue              = "your-token-value"
                    EnrollmentMode          = "corporateOwnedWorkProfile"
                    QrCodeContent           = "your-qr-code-content"
                    WifiSsid                = "your-wifi-ssid"
                    WifiPassword            = New-Object System.Management.Automation.PSCredential ($userName, (ConvertTo-SecureString "your-wifi-password" -AsPlainText -Force))
                    WifiSecurityType        = "wpa"
                    Ensure                  = 'Absent'
                    Credential              = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
                    return @{
                        Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                        DisplayName             = "Android Owner Enrollment Profile"
                        Description             = "Profile for enrolling Android"
                        TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                        TokenCreationDateTime   = "2024-12-31T23:59:59Z"
                        TokenValue              = "your-token-value"
                        EnrollmentMode          = "corporateOwnedWorkProfile"
                        EnrollmentTokenType     = 'TokenType'
                        QrCodeContent           = "your-qr-code-content"
                        WifiSsid                = "your-wifi-ssid"
                        WifiPassword            = "your-wifi-password"
                        WifiSecurityType        = "wpa"
                        Ensure                  = 'Present'
                    }
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -Exactly 1
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                    DisplayName             = "Android Owner Enrollment Profile"
                    Description             = "Profile for enrolling Android devices"
                    TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                    TokenValue              = "your-token-value"
                    EnrollmentMode          = "corporateOwnedWorkProfile"
                    QrCodeContent           = "your-qr-code-content"
                    WifiSsid                = "your-wifi-ssid"
                    WifiPassword            = New-Object System.Management.Automation.PSCredential ($userName, (ConvertTo-SecureString "your-wifi-password" -AsPlainText -Force))
                    WifiSecurityType        = "wpa"
                    Ensure                  = 'Present'
                    Credential              = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
                    return @{
                        Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                        DisplayName             = "Android Owner Enrollment Profile"
                        Description             = "Profile for enrolling Android devices"
                        TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                        TokenCreationDateTime   = "2024-12-31T23:59:59Z"
                        TokenValue              = "your-token-value"
                        EnrollmentMode          = "corporateOwnedWorkProfile"
                        EnrollmentTokenType     = 'TokenType'
                        QrCodeContent           = "your-qr-code-content"
                        WifiSsid                = "your-wifi-ssid"
                        WifiPassword            = "your-wifi-password"
                        WifiSecurityType        = "wpa"
                        Ensure                  = 'Present'
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                    DisplayName             = "Android Owner Enrollment Profile"
                    Description             = "Profile for enrolling Android" # Drift
                    TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                    TokenValue              = "your-token-value"
                    EnrollmentMode          = "corporateOwnedWorkProfile"
                    QrCodeContent           = "your-qr-code-content"
                    WifiSsid                = "your-wifi-ssid"
                    WifiPassword            = New-Object System.Management.Automation.PSCredential ($userName, (ConvertTo-SecureString "your-wifi-password" -AsPlainText -Force))
                    WifiSecurityType        = "wpa"
                    Ensure                  = 'Present'
                    Credential              = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
                    return @{
                        Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                        DisplayName             = "Android Owner Enrollment Profile"
                        Description             = "Profile for enrolling Android devices"
                        TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                        TokenCreationDateTime   = "2024-12-31T23:59:59Z"
                        TokenValue              = "your-token-value"
                        EnrollmentMode          = "corporateOwnedWorkProfile"
                        EnrollmentTokenType     = 'TokenType'
                        QrCodeContent           = "your-qr-code-content"
                        WifiSsid                = "your-wifi-ssid"
                        WifiPassword            = "your-wifi-password"
                        WifiSecurityType        = "wpa"
                        Ensure                  = 'Present'
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
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -Exactly 1
                Should -Invoke -CommandName New-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementAndroidDeviceOwnerEnrollmentProfile -MockWith {
                    return @{
                        Id                      = "164655f7-1232-4d56-ae8f-b095196a0309";
                        DisplayName             = "Android Owner Enrollment Profile"
                        Description             = "Profile for enrolling Android"
                        TokenExpirationDateTime = "2024-12-31T23:59:59Z"
                        TokenCreationDateTime   = "2024-12-31T23:59:59Z"
                        TokenValue              = "your-token-value"
                        EnrollmentMode          = "corporateOwnedWorkProfile"
                        EnrollmentTokenType     = 'TokenType'
                        QrCodeContent           = "your-qr-code-content"
                        WifiSsid                = "your-wifi-ssid"
                        WifiPassword            = "your-wifi-password"
                        WifiSecurityType        = "wpa"
                        Ensure                  = 'Present'
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
