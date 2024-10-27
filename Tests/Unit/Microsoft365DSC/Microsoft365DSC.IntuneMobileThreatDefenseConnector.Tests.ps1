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

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
            }

            Mock -CommandName Update-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts

        Context -Name " 1. The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AllowPartnerToCollectIosApplicationMetadata         = $False;
                    AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                    AndroidDeviceBlockedOnMissingPartnerData            = $False;
                    AndroidEnabled                                      = $False;
                    AndroidMobileApplicationManagementEnabled           = $False;
                    Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                    IosDeviceBlockedOnMissingPartnerData                = $False;
                    IosEnabled                                          = $False;
                    IosMobileApplicationManagementEnabled               = $False;
                    MicrosoftDefenderForEndpointAttachEnabled           = $False;
                    PartnerState                                        = "available";
                    PartnerUnresponsivenessThresholdInDays              = 0;
                    PartnerUnsupportedOSVersionBlocked                  = $False;
                    WindowsDeviceBlockedOnMissingPartnerData            = $False;
                    WindowsEnabled                                      = $False;
                    Ensure                                              = 'Present'
                    Credential                                          = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
                    return $null
                }
            }

            It ' 1.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It ' 1.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It ' 1.3 Should create a new instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgBetaDeviceManagementMobileThreatDefenseConnector -Exactly 1
            }
        }

        Context -Name " 2. The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AllowPartnerToCollectIosApplicationMetadata         = $False;
                    AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                    AndroidDeviceBlockedOnMissingPartnerData            = $False;
                    AndroidEnabled                                      = $False;
                    AndroidMobileApplicationManagementEnabled           = $False;
                    Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                    IosDeviceBlockedOnMissingPartnerData                = $False;
                    IosEnabled                                          = $False;
                    IosMobileApplicationManagementEnabled               = $False;
                    MicrosoftDefenderForEndpointAttachEnabled           = $False;
                    PartnerState                                        = "available";
                    PartnerUnresponsivenessThresholdInDays              = 0;
                    PartnerUnsupportedOSVersionBlocked                  = $False;
                    WindowsDeviceBlockedOnMissingPartnerData            = $False;
                    WindowsEnabled                                      = $False;
                    Ensure              = 'Absent'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
                    return @{
                        AllowPartnerToCollectIosApplicationMetadata         = $False;
                        AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                        AndroidDeviceBlockedOnMissingPartnerData            = $False;
                        AndroidEnabled                                      = $False;
                        AndroidMobileApplicationManagementEnabled           = $False;
                        Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                        IosDeviceBlockedOnMissingPartnerData                = $False;
                        IosEnabled                                          = $False;
                        IosMobileApplicationManagementEnabled               = $False;
                        MicrosoftDefenderForEndpointAttachEnabled           = $False;
                        PartnerState                                        = "available";
                        PartnerUnresponsivenessThresholdInDays              = 0;
                        PartnerUnsupportedOSVersionBlocked                  = $False;
                        WindowsDeviceBlockedOnMissingPartnerData            = $False;
                        WindowsEnabled                                      = $False;
                    }
                }
            }

            It ' 2.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It ' 2.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It ' 2.3 Should remove the instance from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementMobileThreatDefenseConnector -Exactly 1
            }
        }

        Context -Name " 3. The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AllowPartnerToCollectIosApplicationMetadata         = $False;
                    AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                    AndroidDeviceBlockedOnMissingPartnerData            = $False;
                    AndroidEnabled                                      = $False;
                    AndroidMobileApplicationManagementEnabled           = $False;
                    Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                    IosDeviceBlockedOnMissingPartnerData                = $False;
                    IosEnabled                                          = $False;
                    IosMobileApplicationManagementEnabled               = $False;
                    MicrosoftDefenderForEndpointAttachEnabled           = $False;
                    PartnerState                                        = "available";
                    PartnerUnresponsivenessThresholdInDays              = 0;
                    PartnerUnsupportedOSVersionBlocked                  = $False;
                    WindowsDeviceBlockedOnMissingPartnerData            = $False;
                    WindowsEnabled                                      = $False;
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
                    return @{
                        AllowPartnerToCollectIosApplicationMetadata         = $False;
                        AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                        AndroidDeviceBlockedOnMissingPartnerData            = $False;
                        AndroidEnabled                                      = $False;
                        AndroidMobileApplicationManagementEnabled           = $False;
                        Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                        IosDeviceBlockedOnMissingPartnerData                = $False;
                        IosEnabled                                          = $False;
                        IosMobileApplicationManagementEnabled               = $False;
                        MicrosoftDefenderForEndpointAttachEnabled           = $False;
                        PartnerState                                        = "available";
                        PartnerUnresponsivenessThresholdInDays              = 0;
                        PartnerUnsupportedOSVersionBlocked                  = $False;
                        WindowsDeviceBlockedOnMissingPartnerData            = $False;
                        WindowsEnabled                                      = $False;
                    }
                }
            }

            It ' 3.0 Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name " 4. The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AllowPartnerToCollectIosApplicationMetadata         = $False;
                    AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                    AndroidDeviceBlockedOnMissingPartnerData            = $False;
                    AndroidEnabled                                      = $False;
                    AndroidMobileApplicationManagementEnabled           = $False;
                    Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                    IosDeviceBlockedOnMissingPartnerData                = $False;
                    IosEnabled                                          = $False;
                    IosMobileApplicationManagementEnabled               = $False;
                    MicrosoftDefenderForEndpointAttachEnabled           = $False;
                    PartnerState                                        = "notSetUp"; #drift
                    PartnerUnresponsivenessThresholdInDays              = 1; #drift
                    PartnerUnsupportedOSVersionBlocked                  = $False;
                    WindowsDeviceBlockedOnMissingPartnerData            = $False;
                    WindowsEnabled                                      = $False;
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
                    return @{
                        AllowPartnerToCollectIosApplicationMetadata         = $False;
                        AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                        AndroidDeviceBlockedOnMissingPartnerData            = $False;
                        AndroidEnabled                                      = $False;
                        AndroidMobileApplicationManagementEnabled           = $False;
                        Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                        IosDeviceBlockedOnMissingPartnerData                = $False;
                        IosEnabled                                          = $False;
                        IosMobileApplicationManagementEnabled               = $False;
                        MicrosoftDefenderForEndpointAttachEnabled           = $False;
                        PartnerState                                        = "available";
                        PartnerUnresponsivenessThresholdInDays              = 0;
                        PartnerUnsupportedOSVersionBlocked                  = $False;
                        WindowsDeviceBlockedOnMissingPartnerData            = $False;
                        WindowsEnabled                                      = $False;
                    }
                }
            }

            It ' 4.1 Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It ' 4.2 Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It ' 4.3 Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementMobileThreatDefenseConnector -Exactly 1
            }
        }

        Context -Name ' 5. ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceManagementMobileThreatDefenseConnector -MockWith {
                    return @{
                        AllowPartnerToCollectIosApplicationMetadata         = $False;
                        AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                        AndroidDeviceBlockedOnMissingPartnerData            = $False;
                        AndroidEnabled                                      = $False;
                        AndroidMobileApplicationManagementEnabled           = $False;
                        Id                                                  = "2c7790de-8b02-4814-85cf-e0c59380dee8";
                        IosDeviceBlockedOnMissingPartnerData                = $False;
                        IosEnabled                                          = $False;
                        IosMobileApplicationManagementEnabled               = $False;
                        MicrosoftDefenderForEndpointAttachEnabled           = $False;
                        PartnerState                                        = "available";
                        PartnerUnresponsivenessThresholdInDays              = 0;
                        PartnerUnsupportedOSVersionBlocked                  = $False;
                        WindowsDeviceBlockedOnMissingPartnerData            = $False;
                        WindowsEnabled                                      = $False;
                        LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
                    }
                }
            }
            It ' 5.0 Should Reverse Engineer resource from the Export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
