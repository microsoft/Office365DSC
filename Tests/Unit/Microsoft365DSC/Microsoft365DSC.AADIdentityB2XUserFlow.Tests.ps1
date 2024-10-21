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
    -DscResource "AADIdentityB2XUserFlow" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaIdentityB2XUserFlow -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityB2XUserFlow -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityB2XUserFlow -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityB2XUserFlowIdentityProviderByRef -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityB2XUserFlowIdentityProviderByRef -MockWith {
            }

            Mock -CommandName Remove-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
            }

            Mock -CommandName Update-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
            }

            Mock -CommandName New-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
            }

            Mock -CommandName Set-MgBetaIdentityB2XUserFlowPostAttributeCollectionByRef -MockWith {
            }

            Mock -CommandName Set-MgBetaIdentityB2XUserFlowPostFederationSignupByRef -MockWith {
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
        Context -Name "The AADIdentityB2XUserFlow should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    ApiConnectorConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration -Property @{
                        postAttributeCollectionConnectorName = 'FakeConnector1'
                        postFederationSignupConnectorName = 'FakeConnector2'
                    } -ClientOnly)
                    Id = "FakeStringValue"
                    IdentityProviders = @("Provider1", "Provider2")
                    UserAttributeAssignments = @((New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                        UserInputType = 'textBox'
                        IsOptional = $True
                        DisplayName = 'Email Address'
                        Id = 'emailReadonly'
                        UserAttributeValues = [CimInstance[]]@(
                            New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                                IsDefault = $True
                                Name = 'S'
                                Value = '2'
                            } -ClientOnly
                        )
                    } -ClientOnly))
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlow -MockWith {
                    return $null
                }

                Mock -CommandName Get-MgBetaIdentityApiConnector -MockWith {
                    return $null
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
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
                Should -Invoke -CommandName New-MgBetaIdentityB2XUserFlow -Exactly 1
                Should -Invoke -CommandName Get-MgBetaIdentityApiConnector -Exactly 2
                Should -Invoke -CommandName New-MgBetaIdentityB2XUserFlowIdentityProviderByRef -Exactly 2
                Should -Invoke -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -Exactly 1
                Should -Invoke -CommandName New-MgBetaIdentityB2XUserFlowUserAttributeAssignment -Exactly 1
            }
        }

        Context -Name "The AADIdentityB2XUserFlow exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    ApiConnectorConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration -Property @{
                        postAttributeCollectionConnectorName = 'FakeConnector1'
                        postFederationSignupConnectorName = 'FakeConnector2'
                    } -ClientOnly)
                    Id = "FakeStringValue"
                    IdentityProviders = @("Provider1", "Provider2")
                    UserAttributeAssignments = @((New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                        UserInputType = 'textBox'
                        IsOptional = $True
                        DisplayName = 'Email Address'
                        Id = 'emailReadonly'
                        UserAttributeValues = [CimInstance[]]@(
                            New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                                IsDefault = $True
                                Name = 'S'
                                Value = '2'
                            } -ClientOnly
                        )
                    } -ClientOnly))
                    Ensure = "Absent"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlow -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowIdentityProvider -MockWith {
                    return @(
                        @{
                            id = "Provider1"
                        },
                        @{
                            id = "Provider2"
                        }
                    )
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowApiConnectorConfiguration -MockWith {
                    return @{
                        PostFederationSignup = [PSCustomObject]@{
                            DisplayName = "FakeConnector2"
                        }
                        PostAttributeCollection = [PSCustomObject]@{
                            DisplayName = "FakeConnector1"
                        }
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
                    return @(
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'Email Address'
                            Id = 'emailReadonly'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        }
                    )
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
                Should -Invoke -CommandName Remove-MgBetaIdentityB2XUserFlow -Exactly 1
            }
        }
        Context -Name "The AADIdentityB2XUserFlow Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    ApiConnectorConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration -Property @{
                        postAttributeCollectionConnectorName = 'FakeConnector1'
                        postFederationSignupConnectorName = 'FakeConnector2'
                    } -ClientOnly)
                    Id = "FakeStringValue"
                    IdentityProviders = @("Provider1", "Provider2")
                    UserAttributeAssignments = @((New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                        UserInputType = 'textBox'
                        IsOptional = $True
                        DisplayName = 'Email Address'
                        Id = 'emailReadonly'
                        UserAttributeValues = [CimInstance[]]@(
                            New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                                IsDefault = $True
                                Name = 'S'
                                Value = '2'
                            } -ClientOnly
                        )
                    } -ClientOnly))
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlow -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowIdentityProvider -MockWith {
                    return @(
                        @{
                            id = "Provider1"
                        },
                        @{
                            id = "Provider2"
                        }
                    )
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowApiConnectorConfiguration -MockWith {
                    return @{
                        PostFederationSignup = [PSCustomObject]@{
                            DisplayName = "FakeConnector2"
                        }
                        PostAttributeCollection = [PSCustomObject]@{
                            DisplayName = "FakeConnector1"
                        }
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
                    return @(
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'Email Address'
                            Id = 'emailReadonly'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        }
                    )
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADIdentityB2XUserFlow exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    ApiConnectorConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration -Property @{
                        postAttributeCollectionConnectorName = 'FakeConnector1'
                        postFederationSignupConnectorName = 'FakeConnector2'
                    } -ClientOnly)
                    Id = "FakeStringValue"
                    IdentityProviders = @("Provider1", "Provider2")
                    UserAttributeAssignments = @((New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                        UserInputType = 'dropdownSingleSelect'
                        IsOptional = $True
                        DisplayName = 'Email Address'
                        Id = 'emailReadonly'
                        UserAttributeValues = [CimInstance[]]@(
                            New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                                IsDefault = $True
                                Name = 'Z'
                                Value = '2'
                            } -ClientOnly
                        )
                    } -ClientOnly),
                    (New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                        UserInputType = 'textBox'
                        IsOptional = $True
                        DisplayName = 'Surname'
                        Id = 'surname'
                        UserAttributeValues = [CimInstance[]]@(
                            New-CimInstance -ClassName MSFT_MicrosoftGraphuserFlowUserAttributeAssignment -Property @{
                                IsDefault = $True
                                Name = 'S'
                                Value = '2'
                            } -ClientOnly
                        )
                    } -ClientOnly))
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlow -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityApiConnector -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowIdentityProvider -MockWith {
                    return @(
                        @{
                            id = "Provider3"
                        },
                        @{
                            id = "Provider2"
                        }
                    )
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowApiConnectorConfiguration -MockWith {
                    return @{
                        PostFederationSignup = [PSCustomObject]@{
                            DisplayName = "FakeConnector2"
                        }
                        PostAttributeCollection = [PSCustomObject]@{
                            DisplayName = "FakeConnector1"
                        }
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
                    return @(
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'Email Address'
                            Id = 'emailReadonly'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        },
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'City'
                            Id = 'city'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        }
                    )
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
                Should -Invoke -CommandName New-MgBetaIdentityB2XUserFlowIdentityProviderByRef -Exactly 1
                Should -Invoke -CommandName Remove-MgBetaIdentityB2XUserFlowIdentityProviderByRef -Exactly 1
                Should -Invoke -CommandName Set-MgBetaIdentityB2XUserFlowPostFederationSignupByRef -Exactly 1
                Should -Invoke -CommandName Set-MgBetaIdentityB2XUserFlowPostAttributeCollectionByRef -Exactly 1
                Should -Invoke -CommandName New-MgBetaIdentityB2XUserFlowUserAttributeAssignment -Exactly 1
                Should -Invoke -CommandName Update-MgBetaIdentityB2XUserFlowUserAttributeAssignment -Exactly 1
                Should -Invoke -CommandName Remove-MgBetaIdentityB2XUserFlowUserAttributeAssignment -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlow -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityApiConnector -MockWith {
                    return @{
                        id = "FakeStringValue"
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowIdentityProvider -MockWith {
                    return @(
                        @{
                            id = "Provider3"
                        },
                        @{
                            id = "Provider2"
                        }
                    )
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowApiConnectorConfiguration -MockWith {
                    return @{
                        PostFederationSignup = [PSCustomObject]@{
                            DisplayName = "FakeConnector2"
                        }
                        PostAttributeCollection = [PSCustomObject]@{
                            DisplayName = "FakeConnector1"
                        }
                    }
                }

                Mock -CommandName Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -MockWith {
                    return @(
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'Email Address'
                            Id = 'emailReadonly'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        },
                        [PSCustomObject]@{
                            UserInputType = 'textBox'
                            IsOptional = $True
                            DisplayName = 'City'
                            Id = 'city'
                            UserAttributeValues = @(
                                [PSCustomObject]@{
                                    IsDefault = $True
                                    Name = 'S'
                                    Value = '2'
                                }
                            )
                        }
                    )
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
