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
    -DscResource 'AADAdministrativeUnit' -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Add-M365DSCTelemetryEvent -MockWith {
            }

            Mock -CommandName Get-MSCloudLoginConnectionProfile -MockWith {
            }

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
            }

            Mock -CommandName Update-MgDirectoryAdministrativeUnit -MockWith {
            }

            Mock -CommandName Remove-MgDirectoryAdministrativeUnit -MockWith {
            }

            Mock -CommandName New-MgDirectoryAdministrativeUnit -MockWith {
            }

            Mock -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -MockWith {
            }

            Mock -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
            }

            Mock -CommandName Remove-MgDirectoryAdministrativeUnit -MockWith {
            }

            Mock -CommandName Remove-MgDirectoryAdministrativeUnitMemberDirectoryObjectByRef -MockWith {
            }

            Mock -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
            }
            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name 'The AU should exist but it DOES NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description = 'FakeStringValue1'
                    DisplayName = 'FakeStringValue1'
                    Id          = 'FakeStringValue1'
                    Members     = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Type     = 'User'
                            Identity = 'john.smith@contoso.com'
                        } -ClientOnly)
                    )
                    Visibility  = 'Public'
                    Ensure      = 'Present'
                    Credential  = $Credential
                }

                Mock -CommandName Get-MgUser -MockWith {
                    return @{
                        Id = '123456'
                    }
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return $null
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return $null
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the AU from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnit -Exactly 1
            }
        }

        Context -Name 'The AU exists but it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description = 'FakeStringValue2'
                    DisplayName = 'FakeStringValue2'
                    Id          = 'FakeStringValue2'
                    Members     = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Type     = 'User'
                            Identity = 'john.smith@contoso.com'
                        } -ClientOnly)
                    )
                    Ensure      = 'Absent'
                    Credential  = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return @{
                        Description = 'FakeStringValue2'
                        DisplayName = 'FakeStringValue2'
                        Id          = 'FakeStringValue2'
                    }
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return $null
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return $null
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the AU from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Invoke-MgGraphRequest -Exactly 1
            }
        }

        Context -Name 'The AU exists and values are already in desired state - without ID/Ensure' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description = 'FakeStringValue2'
                    DisplayName = 'FakeStringValue2'
                    Credential  = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return @{
                        Description = 'FakeStringValue2'
                        DisplayName = 'FakeStringValue2'
                        Id          = 'FakeStringValue2'
                    }
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return $null
                }
                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return $null
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The AU Exists and Values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description                   = 'DSCAU'
                    DisplayName                   = 'DSCAU'
                    Id                            = 'DSCAU'
                    Members                       = @(
                                    (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Identity = 'John.Doe@mytenant.com'
                            Type     = 'User'
                        } -ClientOnly)
                    )
                    ScopedRoleMembers             = @(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphScopedRoleMembership -Property @{
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                                    Identity = 'John.Doe@mytenant.com'
                                    Type     = 'User'
                                } -ClientOnly)
                            #Identity = 'John.Doe@mytenant.com'
                            #Type     = 'User'
                        } -ClientOnly)
                    )
                    Visibility                    = 'Public'
                    MembershipType                = 'Assigned'
                    # MembershipRule and -ProcessingState params are only used when MembershipType is Dynamic
                    MembershipRule                = 'Canada'
                    MembershipRuleProcessingState = 'On'
                    Ensure                        = 'Present'
                    Credential                    = $Credential
                }

                # Note: It is in fact possible to update the AU MembershipRule with any invalid value, but in the AAD-portal, updates are not possible unless the rule is valid.

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return @{
                        Description          = 'DSCAU'
                        DisplayName          = 'DSCAU'
                        Id                   = 'DSCAU'
                        Visibility           = 'Public'
                        MembershipType                = 'Assigned'
                        MembershipRule                = 'Canada'
                        MembershipRuleProcessingState = 'On'
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        '@odata.type'     = '#microsoft.graph.user'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                        Id                = '1234567890'
                    }
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return @(@{
                            Id = '1234567890'
                        })
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return @(@{
                            RoleId         = '12345-67890'
                            RoleMemberInfo = @{
                                DisplayName = 'John Doe'
                                Id          = '1234567890'
                            }
                        })
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return @{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
                    }
                }

            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }
        Context -Name 'The AU Exists and specified Values are NOT in the desired state (leaving Members and ScopedRoleMembers as-is)' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description                   = 'DSCAU New Description'
                    DisplayName                   = 'DSCAU'
                    Id                            = 'DSCAU'
                    Ensure                        = 'Present'
                    Credential                    = $Credential
                }

                # Note: It is in fact possible to update the AU MembershipRule with any invalid value, but in the AAD-portal, updates are not possible unless the rule is valid.

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return @{
                        Description          = 'DSCAU Old Description'
                        DisplayName          = 'DSCAU'
                        Id                   = 'DSCAU'
                        MembershipType       = 'Assigned'
                    }
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return @(@{
                            Id = '1234567890'
                        })
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return @(@{
                            RoleId         = '12345-67890'
                            RoleMemberInfo = @{
                                DisplayName = 'John Doe'
                                Id          = '1234567890'
                            }
                        })
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        '@odata.type'     = '#microsoft.graph.user'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                        Id                = '1234567890'
                    }
                }

                Mock -CommandName Get-MgUser -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return @{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
                    }
                }

            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method without removing existing Members or ScopedRoleMembers' {
                Set-TargetResource @testParams
                Should -Not -Invoke -CommandName Remove-MgDirectoryAdministrativeUnitMemberDirectoryObjectByRef
                Should -Not -Invoke -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember
            }

        }
        Context -Name 'The AU exists and values (Members contains a User) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU2'
                    DisplayName       = 'DSCAU2'
                    Id                = 'DSCAU2'
                    Members           = @(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Identity = 'John.Doe@mytenant.com'
                            Type     = 'User'
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'

                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU2'
                        DisplayName = 'DSCAU2'
                        Id          = 'DSCAU2'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgUser -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -Exactly 1
            }
        }

        Context -Name 'The AU exists and values (Members contains a Group) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU2'
                    DisplayName       = 'DSCAU2'
                    Id                = 'DSCAU2'
                    Members           = @(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Identity = 'DSCAUMemberGroup'
                            Type     = 'Group'
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'

                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU2'
                        DisplayName = 'DSCAU2'
                        Id          = 'DSCAU2'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'DSCAUMemberGroup'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -Exactly 1
            }
        }

        Context -Name 'The AU exists and values (Members contains a Device) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU2'
                    DisplayName       = 'DSCAU2'
                    Id                = 'DSCAU2'
                    Members           = @(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                            Identity = 'DSCAUMemberDevice'
                            Type     = 'Device'
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'

                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU2'
                        DisplayName = 'DSCAU2'
                        Id          = 'DSCAU2'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgBetaDevice -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'DSCAUMemberDevice'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -Exactly 1
            }
        }

        Context -Name 'The AU exists and values (ScopedRoleMembers contains a User) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU'
                    DisplayName       = 'DSCAU'
                    Id                = 'DSCAU'
                    ScopedRoleMembers = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphScopedRoleMembership -Property @{
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                                    Identity = 'John.Doe@mytenant.com'
                                    Type     = 'User'
                                } -ClientOnly)
                            #Identity = 'John.Doe@mytenant.com'
                            #Type     = 'User'
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'
                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU'
                        DisplayName = 'DSCAU'
                        Id          = 'DSCAU'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgUser -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return [pscustomobject]@{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -Exactly 1
            }
        }

        Context -Name 'The AU exists and values (ScopedRoleMembers contains a Group) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU'
                    DisplayName       = 'DSCAU'
                    Id                = 'DSCAU'
                    ScopedRoleMembers = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphScopedRoleMembership -Property @{
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                                    Identity = 'DSCScopedRoleUserAdmins'
                                    Type     = 'Group'
                                } -ClientOnly)
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'
                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU'
                        DisplayName = 'DSCAU'
                        Id          = 'DSCAU'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'DSCScopedRoleUserAdmins'
                        IsAssignableToRole = $true
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return [pscustomobject]@{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -Exactly 1
            }
        }

        Context -Name 'The AU exists, attempt to add as a ScopedRoleMember a Group that is NOT role-enabled. Should throw' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU New Description'
                    DisplayName       = 'DSCAU'
                    Id                = 'DSCAU'
                    ScopedRoleMembers = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphScopedRoleMembership -Property @{
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                                    Identity = 'DSCNotARoleGroup'
                                    Type     = 'Group'
                                } -ClientOnly)
                        } -ClientOnly)
                    )
                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU Old Description'
                        DisplayName = 'DSCAU'
                        Id          = 'DSCAU'
                    }
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'DSCNotARoleGroup'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return [pscustomobject]@{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should call the Set method and throw' {
                {Set-TargetResource @testParams} | Should -Throw -ExpectedMessage '*scoped role group*is not role-enabled*'
            }
        }

        Context -Name 'The AU exists and values (ScopedRoleMembers contains an SPN) are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    Description       = 'DSCAU'
                    DisplayName       = 'DSCAU'
                    Id                = 'DSCAU'
                    ScopedRoleMembers = @(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphScopedRoleMembership -Property @{
                            RoleName       = 'User Administrator'
                            RoleMemberInfo = (New-CimInstance -ClassName MSFT_MicrosoftGraphMember -Property @{
                                    Identity = 'DSCScopedRoleSPN'
                                    Type     = 'ServicePrincipal'
                                } -ClientOnly)
                        } -ClientOnly)
                    )
                    Visibility        = 'Public'
                    Ensure            = 'Present'
                    Credential        = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return [pscustomobject]@{
                        Description = 'DSCAU'
                        DisplayName = 'DSCAU'
                        Id          = 'DSCAU'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgServicePrincipal -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'DSCScopedRoleSPN'
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return [pscustomobject]@{
                        '@odata.type'     = '#microsoft.graph.serviceprincipal'
                        DisplayName       = 'DSCScopedRoleSPN'
                        Id                = '1234567890'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return [pscustomobject]@{
                        Id          = '12345-67890'
                        DisplayName = 'User Administrator'
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
                Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {
                    return @{
                        Description = 'ExportDSCAU'
                        DisplayName = 'ExportDSCAU'
                        Id          = 'ExportDSCAU'
                        Visibility  = 'Public'
                    }
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {
                    return [pscustomobject]@{
                        Id = '1234567890'
                    }
                }

                Mock -CommandName Get-MgUser -MockWith {
                    return [pscustomobject]@{
                        Id                = '1234567890'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                    }
                }

                Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {
                    return @([pscustomobject]@{
                            RoleId         = '12345-67890'
                            RoleMemberInfo = @{
                                DisplayName = 'John Doe'
                                Id          = '1234567890'
                            }
                        },
                        [pscustomobject]@{
                            RoleId         = '09876-54321'
                            RoleMemberInfo = @{
                                DisplayName = 'FakeRoleGroup'
                                Id          = '0987654321'
                            }
                        })
                }

                Mock -CommandName Invoke-MgGraphRequest -ParameterFilter { $Uri -match '1234567890$' } -MockWith {
                    return [pscustomobject]@{
                        '@odata.type'     = '#microsoft.graph.user'
                        DisplayName       = 'John Doe'
                        UserPrincipalName = 'John.Doe@mytenant.com'
                        Id                = '1234567890'
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -ParameterFilter { $Uri -match '0987654321$' } -MockWith {
                    return [pscustomobject]@{
                        '@odata.type' = '#microsoft.graph.group'
                        DisplayName   = 'FakeRoleGroup'
                        Id            = '0987654321'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -ParameterFilter { $DirectoryRoleId -eq '12345-67890' } -MockWith {
                    return [pscustomobject]@{
                        Id          = '12345-67890'
                        DisplayName = 'DSC User Administrator'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -ParameterFilter { $DirectoryRoleId -eq '09876-54321' } -MockWith {
                    return [pscustomobject]@{
                        Id          = '09876-54321'
                        DisplayName = 'DSC Groups Administrator'
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
