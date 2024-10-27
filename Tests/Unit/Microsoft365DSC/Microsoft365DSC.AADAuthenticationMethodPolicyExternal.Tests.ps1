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
    -DscResource "AADAuthenticationMethodPolicyExternal" -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -MockWith {
            }

            Mock -CommandName Update-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -MockWith {
            }

            Mock -CommandName Remove-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -MockWith {
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
        Context -Name "The AADAuthenticationMethodPolicyExternal should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    ExcludeTargets = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFTAADAuthenticationMethodPolicyExternalExcludeTarget -Property @{
                            TargetType = "group"
                            Id = "Fakegroup"
                        } -ClientOnly)
                    )
                    IncludeTargets        = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget -Property @{
                            TargetType = 'group'
                            Id         = 'Fakegroup'
                        } -ClientOnly)
                    )
                    OpenIdConnectSetting  = (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting -Property @{
                        discoveryUrl = 'https://graph.microsoft.com/'
                        clientId = '00000000-0000-0000-0000-000000000001'
                    } -ClientOnly);
                    DisplayName = "ExternalOath"
                    State  = "enabled"
                    Ensure = "Present"
                    AppId  = "00000000-0000-0000-0000-000000000002"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        Id = "00000000-0000-0000-0000-000000000000"
                        DisplayName = "Fakegroup"
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
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
                Should -Invoke -CommandName New-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -Exactly 1
            }
        }

        Context -Name "The AADAuthenticationMethodPolicyExternal exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    ExcludeTargets = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFTAADAuthenticationMethodPolicyExternalExcludeTarget -Property @{
                            TargetType = "group"
                            Id = "Fakegroup"
                        } -ClientOnly)
                    )
                    IncludeTargets        = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget -Property @{
                            TargetType = 'group'
                            Id         = 'Fakegroup'
                        } -ClientOnly)
                    )
                    OpenIdConnectSetting  = (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting -Property @{
                        discoveryUrl = 'https://graph.microsoft.com/'
                        clientId = '00000000-0000-0000-0000-000000000001'
                    } -ClientOnly);
                    DisplayName = "ExternalOath"
                    State  = "enabled"
                    Ensure = "Absent"
                    AppId  = "00000000-0000-0000-0000-000000000002"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        Id = "00000000-0000-0000-0000-000000000000"
                        DisplayName = "Fakegroup"
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        authenticationMethodConfigurations = @{
                            IncludeTargets = @(
                                @{
                                    TargetType = 'group'
                                    Id         = 'Fakegroup'
                                }
                            )
                            ExcludeTargets = @(
                                @{
                                    TargetType = "group"
                                    Id = "00000000-0000-0000-0000-000000000000"
                                }
                            )
                            OpenIdConnectSetting  = @{
                                discoveryUrl = 'https://graph.microsoft.com/'
                                clientId = '00000000-0000-0000-0000-000000000001'
                            }
                            DisplayName = "ExternalOath"
                            AppId  = "00000000-0000-0000-0000-000000000002"
                            State = "enabled"
                            '@odata.type' = "#microsoft.graph.externalAuthenticationMethodConfiguration"
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
                Should -Invoke -CommandName Remove-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -Exactly 1
            }
        }
        Context -Name "The AADAuthenticationMethodPolicyExternal Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    ExcludeTargets = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFTAADAuthenticationMethodPolicyExternalExcludeTarget -Property @{
                            TargetType = "group"
                            Id = "Fakegroup"
                        } -ClientOnly)
                    )
                    IncludeTargets        = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget -Property @{
                            TargetType = 'group'
                            Id         = 'Fakegroup'
                        } -ClientOnly)
                    )
                    OpenIdConnectSetting  = (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting -Property @{
                        discoveryUrl = 'https://graph.microsoft.com/'
                        clientId = '00000000-0000-0000-0000-000000000001'
                    } -ClientOnly);
                    DisplayName = "ExternalOath"
                    State  = "enabled"
                    Ensure = "Present"
                    AppId  = "00000000-0000-0000-0000-000000000002"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        Id = "00000000-0000-0000-0000-000000000000"
                        DisplayName = "Fakegroup"
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        authenticationMethodConfigurations = @{
                            IncludeTargets = @(
                                @{
                                    TargetType = 'group'
                                    Id         = 'Fakegroup'
                                }
                            )
                            ExcludeTargets = @(
                                @{
                                    TargetType = "group"
                                    Id = "00000000-0000-0000-0000-000000000000"
                                }
                            )
                            OpenIdConnectSetting  = @{
                                discoveryUrl = 'https://graph.microsoft.com/'
                                clientId = '00000000-0000-0000-0000-000000000001'
                            }
                            DisplayName = "ExternalOath"
                            AppId  = "00000000-0000-0000-0000-000000000002"
                            State = "enabled"
                            '@odata.type' = "#microsoft.graph.externalAuthenticationMethodConfiguration"
                        }
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADAuthenticationMethodPolicyExternal exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    ExcludeTargets = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFTAADAuthenticationMethodPolicyExternalExcludeTarget -Property @{
                            TargetType = "group"
                            Id = "Fakegroup"
                        } -ClientOnly)
                    )
                    IncludeTargets        = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalIncludeTarget -Property @{
                            TargetType = 'group'
                            Id         = 'Fakegroup'
                        } -ClientOnly)
                    )
                    OpenIdConnectSetting  = (New-CimInstance -ClassName MSFT_AADAuthenticationMethodPolicyExternalOpenIdConnectSetting -Property @{
                        discoveryUrl = 'https://microsoft.com/'
                        clientId = '00000000-0000-0000-0000-000000000001'
                    } -ClientOnly);
                    DisplayName = "ExternalOath"
                    State  = "enabled"
                    Ensure = "Present"
                    AppId  = "00000000-0000-0000-0000-000000000003"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        Id = "00000000-0000-0000-0000-000000000000"
                        DisplayName = "Fakegroup"
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        authenticationMethodConfigurations = @{
                            IncludeTargets = @(
                                @{
                                    TargetType = 'group'
                                    Id         = 'Fakegroup'
                                }
                            )
                            ExcludeTargets = @(
                                @{
                                    TargetType = "group"
                                    Id = "00000000-0000-0000-0000-000000000000"
                                }
                            )
                            OpenIdConnectSetting  = @{
                                discoveryUrl = 'https://graph.microsoft.com/'
                                clientId = '00000000-0000-0000-0000-000000000001'
                            }
                            DisplayName = "ExternalOath"
                            AppId  = "00000000-0000-0000-0000-000000000002"
                            State = "enabled"
                            '@odata.type' = "#microsoft.graph.externalAuthenticationMethodConfiguration"
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
                Should -Invoke -CommandName Update-MgBetaPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        Id = "00000000-0000-0000-0000-000000000000"
                        DisplayName = "Fakegroup"
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        authenticationMethodConfigurations = @{
                            IncludeTargets = @(
                                @{
                                    TargetType = 'group'
                                    Id         = 'Fakegroup'
                                }
                            )
                            ExcludeTargets = @(
                                @{
                                    TargetType = "group"
                                    Id = "00000000-0000-0000-0000-000000000000"
                                }
                            )
                            OpenIdConnectSetting  = @{
                                discoveryUrl = 'https://graph.microsoft.com/'
                                clientId = '00000000-0000-0000-0000-000000000001'
                            }
                            DisplayName = "ExternalOath"
                            AppId  = "00000000-0000-0000-0000-000000000002"
                            State = "enabled"
                            '@odata.type' = "#microsoft.graph.externalAuthenticationMethodConfiguration"
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
