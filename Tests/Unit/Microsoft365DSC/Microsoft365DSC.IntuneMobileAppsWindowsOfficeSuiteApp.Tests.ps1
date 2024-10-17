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

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
            }
            Mock -CommandName New-MgBetaDeviceAppManagementMobileApp -MockWith {
            }
            Mock -CommandName Update-MgBetaDeviceAppManagementMobileApp -MockWith {
            }
            Mock -CommandName Remove-MgBetaDeviceAppManagementMobileApp -MockWith {
            }

            Mock -CommandName Update-MgBetaDeviceAppManagementMobileAppAssignment -MockWith{}

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }

            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "1. The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                    Categories            = @()
                    Description           = "Microsoft 365 Apps for Windows 10 and later"
                    DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                    InformationUrl        = ""
                    IsFeatured            = $False
                    PrivacyInformationUrl = ""
                    ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                        teams = $false
                        sharePointDesigner = $true
                        powerPoint = $false
                        outlook = $false
                        groove = $true
                        word = $false
                        lync = $true
                        oneNote = $false
                        oneDrive = $false
                        publisher = $false
                        bing = $false
                        visio = $false
                        access = $false
                        infoPath = $true
                        excel = $false
                    } -ClientOnly)
                    RoleScopeTagIds       = @()
                    Notes                 = ""
                    Ensure                = 'Present'
                    Credential            = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
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
                Should -Invoke -CommandName New-MgBetaDeviceAppManagementMobileApp -Exactly 1
            }
        }

        Context -Name "2. The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                    = "ad027f94-0682-431e-97c1-827d1879fa79"
                    Categories            = @()
                    Description           = "Microsoft 365 Apps for Windows 10 and later"
                    DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                    InformationUrl        = ""
                    IsFeatured            = $False
                    ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                        teams = $false
                        sharePointDesigner = $true
                        powerPoint = $false
                        outlook = $false
                        groove = $true
                        word = $false
                        lync = $true
                        oneNote = $false
                        oneDrive = $false
                        publisher = $false
                        bing = $false
                        visio = $false
                        access = $false
                        infoPath = $true
                        excel = $false
                    } -ClientOnly)
                    Notes                 = ""
                    PrivacyInformationUrl = ""
                    RoleScopeTagIds       = @()
                    Ensure                = 'Absent'
                    Credential            = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
                    return @{
                        Id                    = "ad027f94-0682-431e-97c1-827d1879fa79"
                        Categories            = @()
                        Description           = "Microsoft 365 Apps for Windows 10 and laterr"
                        DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                        InformationUrl        = ""
                        IsFeatured            = $False
                        Notes                 = ""
                        PrivacyInformationUrl = ""
                        RoleScopeTagIds       = @()
                        ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                            teams = $false
                            sharePointDesigner = $true
                            powerPoint = $false
                            outlook = $false
                            groove = $true
                            word = $false
                            lync = $true
                            oneNote = $false
                            oneDrive = $false
                            publisher = $false
                            bing = $false
                            visio = $false
                            access = $false
                            infoPath = $true
                            excel = $false
                        } -ClientOnly)
                        Ensure                = 'Present'
                    }
                }

                Mock -CommandName Get-MgBetaDeviceAppManagementMobileAppAssignment -MockWith{
                    return $null
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
                Should -Invoke -CommandName Remove-MgBetaDeviceAppManagementMobileApp -Exactly 1
            }
        }

        Context -Name "3. The instance exists and values are already in the desired state" -Fixture {
        BeforeAll {
            $testParams = @{
                Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                Categories            = @()
                Description           = "Microsoft 365 Apps for Windows 10 and later"
                DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                InformationUrl        = ""
                IsFeatured            = $False
                Notes                 = ""
                PrivacyInformationUrl = ""
                RoleScopeTagIds       = @()
                Ensure                = 'Present'
                Credential            = $Credential
            }

            Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
                return @{
                    Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                    Categories            = @()
                    Description           = "Microsoft 365 Apps for Windows 10 and later"
                    DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                    InformationUrl        = ""
                    IsFeatured            = $False
                    Notes                 = ""
                    PrivacyInformationUrl = ""
                    RoleScopeTagIds       = @()
                    AdditionalProperties   = @{
                        '@odata.type' = '#microsoft.graph.officeSuiteApp'
                        minimumSupportedOperatingSystem = @{
                            v11_0 = $true
                        }
                    }
                    Ensure                = 'Present'
                }
            }

            # Remove Assignments logic for now as we debug this part
            Mock -CommandName Get-MgBetaDeviceAppManagementMobileAppAssignment -MockWith{
                return $null
            }
        }

        It '3.0 Should return true from the Test method' {
            Test-TargetResource @testParams | Should -Be $true
        }
    }

        Context -Name "4. The instance exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                    Categories            = @()
                    Description           = "Microsoft 365 Apps for Windows 10 and later"
                    DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                    InformationUrl        = ""
                    IsFeatured            = $False
                    ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                        teams = $false
                        sharePointDesigner = $true
                        powerPoint = $false
                        outlook = $false
                        groove = $true
                        word = $false
                        lync = $true
                        oneNote = $false
                        oneDrive = $false
                        publisher = $false
                        bing = $false
                        visio = $false
                        access = $false
                        infoPath = $true
                        excel = $false
                    } -ClientOnly)
                    Notes                 = ""
                    PrivacyInformationUrl = ""
                    RoleScopeTagIds       = @()
                    Ensure                = 'Present'
                    Credential            = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
                    return @{
                        Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                        Categories            = @()
                        Description           = "Microsoft 365 Apps for Windows 10 and later"
                        DisplayName           = "Microsoft 365 Apps for Windows 10 and later drift"
                        InformationUrl        = ""
                        IsFeatured            = $False
                        Notes                 = ""
                        PrivacyInformationUrl = ""
                        ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                            teams = $false
                            sharePointDesigner = $true
                            powerPoint = $false
                            outlook = $false
                            groove = $true
                            word = $false
                            lync = $true
                            oneNote = $false
                            oneDrive = $false
                            publisher = $false
                            bing = $false
                            visio = $false
                            access = $false
                            infoPath = $true
                            excel = $false
                        } -ClientOnly)
                        AdditionalProperties   = @{
                            '@odata.type' = '#microsoft.graph.officeSuiteApp'
                            minimumSupportedOperatingSystem = @{
                                v11_0 = $true
                            }
                        }
                    }
                }
                Mock -CommandName Get-MgBetaDeviceAppManagementMobileAppAssignment -MockWith{
                    return $null
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
                Should -Invoke -CommandName Update-MgBetaDeviceAppManagementMobileApp -Exactly 1
            }
        }

        Context -Name '5. ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Get-MgBetaDeviceAppManagementMobileApp -MockWith {
                    return @{
                        Id                    = "8d027f94-0682-431e-97c1-827d1879fa79"
                        Categories            = @()
                        Description           = "Microsoft 365 Apps for Windows 10 and later"
                        DisplayName           = "Microsoft 365 Apps for Windows 10 and later drift"
                        InformationUrl        = ""
                        IsFeatured            = $False
                        Notes                 = ""
                        PrivacyInformationUrl = ""
                        RoleScopeTagIds       = @()
                        ExcludedApps          = (New-CimInstance -ClassName MSFT_DeviceManagementMobileAppExcludedApp -Property @{
                            teams = $false
                            sharePointDesigner = $true
                            powerPoint = $false
                            outlook = $false
                            groove = $true
                            word = $false
                            lync = $true
                            oneNote = $false
                            oneDrive = $false
                            publisher = $false
                            bing = $false
                            visio = $false
                            access = $false
                            infoPath = $true
                            excel = $false
                        } -ClientOnly)
                        AdditionalProperties   = @{
                            '@odata.type' = '#microsoft.graph.officeSuiteApp'
                            minimumSupportedOperatingSystem = @{
                                v11_0 = $true
                            }
                        }
                    }
                }
                Mock -CommandName Get-MgBetaDeviceAppManagementMobileAppAssignment -MockWith{
                    return $null
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
