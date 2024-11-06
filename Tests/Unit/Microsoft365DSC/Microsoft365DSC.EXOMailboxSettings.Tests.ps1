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
    -DscResource 'EXOMailboxSettings' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        BeforeAll {
            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Set-Mailbox -MockWith {}

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        Context -Name 'Specified TimeZone is Invalid' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = 'Admin@contoso.com'
                    TimeZone    = 'Non-Existing'
                    Ensure      = 'Present'
                    Credential  = $Credential
                }

                Mock -CommandName Get-MailboxRegionalConfiguration -MockWith {
                    return @{
                        TimeZone = 'Eastern Standard Time'
                    }
                }

                Mock -CommandName Set-MailboxRegionalConfiguration -MockWith {
                    return $null
                }
            }

            It 'Should return the current TimeZone from the Get method' {
                (Get-TargetResource @testParams).TimeZone | Should -Be 'Eastern Standard Time'
            }

            It 'Should return False from the Test method' {
                Test-TargetResource @testParams | Should -Be $False
            }
        }

        Context -Name 'Specified Parameters are all valid' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName = 'Admin@contoso.com'
                    TimeZone    = 'Eastern Standard Time'
                    Locale      = 'en-US'
                    Ensure      = 'Present'
                    Credential  = $Credential
                }

                Mock -CommandName Get-MailboxRegionalConfiguration -MockWith {
                    return @{
                        TimeZone = 'Eastern Standard Time'
                        Language = @{
                            Name = 'en-US'
                        }
                    }
                }

                Mock -CommandName Set-MailboxRegionalConfiguration -MockWith {
                    return $null
                }
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
            }

            It 'Should return True from the Test method' {
                Test-TargetResource @testParams | Should -Be $True
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-Mailbox -MockWith {
                    return @(
                        @{
                            Name = 'John.Smith'
                        }
                    )
                }

                Mock -CommandName Get-MailboxRegionalConfiguration -MockWith {
                    return @{
                        TimeZone = 'Eastern Standard Time'
                        Language = @{
                            Name = 'en-US'
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
