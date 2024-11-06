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
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The instance should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    IntervalInHours          = 1;
                    IsActive                 = $True;
                    Name                     = "MyScan";
                    ScanAuthenticationParams = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionAuthenticationParams -Property @{
                        Type = 'NoAuthNoPriv'
                        DataType = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                    } -ClientOnly)
                    ScannerAgent             = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionScanAgent -Property @{
                        machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                        machineName = 'WIN-XXXXXXXXXX'
                        id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                    } -ClientOnly)
                    ScanType                 = "Network";
                    Target                   = "172.1.12.1";
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Invoke-M365DSCDefenderREST -MockWith {
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
                Should -Invoke -CommandName Invoke-M365DSCDefenderREST -Exactly 2
            }
        }

        Context -Name "The instance exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    IntervalInHours          = 1;
                    IsActive                 = $True;
                    Name                     = "MyScan";
                    ScanAuthenticationParams = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionAuthenticationParams -Property @{
                        Type = 'NoAuthNoPriv'
                        DataType = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                    } -ClientOnly)
                    ScannerAgent             = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionScanAgent -Property @{
                        machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                        machineName = 'WIN-XXXXXXXXXX'
                        id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                    } -ClientOnly)
                    ScanType                 = "Network";
                    Target                   = "172.1.12.1";
                    Ensure              = 'Absent'
                    Credential          = $Credential;
                }

                Mock -CommandName Invoke-M365DSCDefenderREST -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "12345-12345-12345-12345-12345"
                                scannerAgent = @{
                                    machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                                    machineName = 'WIN-XXXXXXXXXX'
                                    id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                                }
                                scanAuthenticationParams = @{
                                    Type = 'NoAuthNoPriv'
                                    "@odata.type" = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                                }
                                IntervalInHours          = 1;
                                IsActive                 = $True;
                                scanName                 = "MyScan";
                                ScanType                 = "Network";
                                Target                   = "172.1.12.1"; 
                            }                   
                        )
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
                Should -Invoke -CommandName Invoke-M365DSCDefenderREST -Exactly 2
            }
        }

        Context -Name "The instance exists and values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    IntervalInHours          = 1;
                    IsActive                 = $True;
                    Name                     = "MyScan";
                    ScanAuthenticationParams = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionAuthenticationParams -Property @{
                        Type = 'NoAuthNoPriv'
                        DataType = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                    } -ClientOnly)
                    ScannerAgent             = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionScanAgent -Property @{
                        machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                        machineName = 'WIN-XXXXXXXXXX'
                        id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                    } -ClientOnly)
                    ScanType                 = "Network";
                    Target                   = "172.1.12.1";
                    Ensure              = 'Present'
                    Credential          = $Credential;
                }

                Mock -CommandName Invoke-M365DSCDefenderREST -MockWith {
                    return @{
                        value = 
                            @{
                                id = "12345-12345-12345-12345-12345"
                                scannerAgent = @{
                                    machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                                    machineName = 'WIN-XXXXXXXXXX'
                                    id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                                }
                                scanAuthenticationParams = @{
                                    Type = 'NoAuthNoPriv'
                                    "@odata.type" = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                                }
                                IntervalInHours          = 1
                                IsActive                 = $True;
                                scanName                 = "MyScan";
                                ScanType                 = "Network";
                                Target                   = "172.1.12.1"; 
                            }  
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
                    IntervalInHours          = 1;
                    IsActive                 = $True;
                    Name                     = "MyScan";
                    ScanAuthenticationParams = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionAuthenticationParams -Property @{
                        Type = 'NoAuthNoPriv'
                        DataType = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                    } -ClientOnly)
                    ScannerAgent             = (New-CimInstance -ClassName MSFT_DefenderDeviceAuthenticatedScanDefinitionScanAgent -Property @{
                        machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                        machineName = 'WIN-XXXXXXXXXX'
                        id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                    } -ClientOnly)
                    ScanType                 = "Network";
                    Target                   = "172.1.12.1";
                    Ensure              = 'Absent'
                    Credential          = $Credential;
                }

                Mock -CommandName Invoke-M365DSCDefenderREST -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "12345-12345-12345-12345-12345"
                                scannerAgent = @{
                                    machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                                    machineName = 'WIN-XXXXXXXXXX'
                                    id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                                }
                                scanAuthenticationParams = @{
                                    Type = 'NoAuthNoPriv'
                                    "@odata.type" = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                                }
                                IntervalInHours          = 24; #Drift
                                IsActive                 = $True;
                                scanName                 = "MyScan";
                                ScanType                 = "Network";
                                Target                   = "172.1.12.1"; 
                            }                   
                        )
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
                Should -Invoke -CommandName Invoke-M365DSCDefenderREST -Exactly 2
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential  = $Credential;
                }

                Mock -CommandName Invoke-M365DSCDefenderREST -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "12345-12345-12345-12345-12345"
                                scannerAgent = @{
                                    machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                                    machineName = 'WIN-XXXXXXXXXX'
                                    id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
                                }
                                scanAuthenticationParams = @{
                                    Type = 'NoAuthNoPriv'
                                    "@odata.type" = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
                                }
                                IntervalInHours          = 1;
                                IsActive                 = $True;
                                scanName                 = "MyScan";
                                ScanType                 = "Network";
                                Target                   = "172.1.12.1"; 
                            }                   
                        )
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
