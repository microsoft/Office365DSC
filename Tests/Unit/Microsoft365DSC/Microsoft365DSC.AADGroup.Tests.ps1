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
    -DscResource 'AADGroup' -GenericStubModule $GenericStubPath
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

            Mock -CommandName Get-MgGroupMember -MockWith {
            }

            Mock -CommandName Get-MgBetaGroupMember -MockWith {
            }

            Mock -CommandName Get-MgGroup -MockWith {
            }

            Mock -CommandName Restore-MgBetaDirectoryDeletedItem -MockWith {
            }
            Mock -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -MockWith {
            }

            Mock -CommandName Get-MgGroupMemberOf -MockWith {
            }

            Mock -CommandName Get-MgGroupOwner -MockWith {
            }

            Mock -CommandName Get-MgBetaGroupMemberOf -MockWith {
            }

            Mock -CommandName Get-MgBetaGroupOwner -MockWith {
            }

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
            }

            Mock -CommandName Update-MgGroup -MockWith {
            }

            Mock -CommandName Remove-MgGroup -MockWith {
            }

            Mock -CommandName New-MgGroup -MockWith {
            }

            Mock -CommandName New-MgGroupOwnerByRef -MockWith {
            }

            Mock -CommandName New-MgGroupMember -MockWith {
            }

            Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith {
            }

            Mock -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {
            }

            Mock -CommandName New-MgBetaGroupMember -MockWith {
            }

            Mock -CommandName New-MgBetaDirectoryRoleMemberByRef -MockWith {
            }

            Mock -CommandName New-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {
            }

            Mock -CommandName Remove-MgGroupOwnerDirectoryObjectByRef -MockWith {
            }

            Mock -CommandName Remove-MgGroupMemberDirectoryObjectByRef -MockWith {
            }

            Mock -CommandName Remove-MgBetaDirectoryRoleMemberDirectoryObjectByRef -MockWith {
            }

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
            }

            Mock -CommandName Set-MgGroupLicense -MockWith {
            }

            Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {
                return @{
                    RoleDefinitionId = "12345-12345-12345-12345-12345"
                }
            }

            Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleDefinition -MockWith {
                return @{
                    DisplayName = "AADRole"
                }
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name 'The Group should exist but it DOES NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    MailNickname    = 'M365DSC'
                    GroupTypes      = @('Unified')
                    Visibility      = 'Private'
                    Ensure          = 'Present'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgGroup' -Exactly 1
            }
        }

        Context -Name 'The Group exists but it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    MailNickname    = 'M365DSC'
                    GroupTypes      = @('Unified')
                    Visibility      = 'Private'
                    Ensure          = 'Absent'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName = 'DSCGroup'
                        ID          = '12345-12345-12345-12345-12345'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Remove-MgGroup' -Exactly 1
            }
        }

        Context -Name 'The Group Exists and Values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    ID              = '12345-12345-12345-12345'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    MailNickname    = 'M365DSC'
                    GroupTypes      = @('Unified')
                    Visibility      = 'Private'
                    Ensure          = 'Present'
                    Credential      = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName     = 'DSCGroup'
                        ID              = '12345-12345-12345-12345'
                        Description     = 'Microsoft DSC Group'
                        SecurityEnabled = $True
                        MailEnabled     = $True
                        MailNickname    = 'M365DSC'
                        GroupTypes      = @('Unified')
                        Visibility      = 'Private'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The Group Exists and is a member of another group. Values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    ID              = '12345-12345-12345-12345'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    GroupTypes      = @()
                    MailNickname    = 'M365DSC'
                    MemberOf        = 'DSCMemberOfGroup'
                    Ensure          = 'Present'
                    Credential      = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -ParameterFilter { $Id -eq '12345-12345-12345-12345' -or $Filter -eq "DisplayName eq 'DSCGroup'" } -MockWith {
                    return @{
                        DisplayName     = 'DSCGroup'
                        ID              = '12345-12345-12345-12345'
                        Description     = 'Microsoft DSC Group'
                        SecurityEnabled = $True
                        MailEnabled     = $true
                        MailNickname    = 'M365DSC'
                        GroupTypes      = @()
                    }
                }
                Mock -CommandName Get-MgBetaGroupMemberOf -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = '#microsoft.graph.group'
                            displayName   = 'DSCMemberOfGroup'
                        }
                    }
                }
                Mock -CommandName Get-MgGroup -ParameterFilter { $Id -eq '67890-67890-67890-67890' -or $Filter -eq "DisplayName -eq 'DSCMemberOfGroup'" } -MockWith {
                    $returnData = @{
                        DisplayName     = 'DSCMemberOfGroup'
                        ID              = '67890-67890-67890-67890'
                        Description     = 'Microsoft DSC MemberOf Group'
                        SecurityEnabled = $True
                        GroupTypes      = @()
                        MailEnabled     = $True
                        MailNickname    = 'M365DSCM'
                    }
                    # Set-TargetResource expects data-type of answer to contain 'group'
                    $returnData.psobject.TypeNames.insert(0, 'Group')
                    return $returnData
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaGroupMemberOf' -Exactly 1
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The Group Exists and is assigned to the correct role. Values are already in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $True
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    IsAssignableToRole = $true
                    AssignedToRole     = 'AADRole'
                    Ensure             = 'Present'
                    Credential         = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $true
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $true
                    }
                }
                Mock -CommandName Get-MgBetaGroupMemberOf -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = '#microsoft.graph.directoryRole'
                            displayName   = 'AADRole'
                        }
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaGroupMemberOf' -Exactly 1
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The Group exists and values are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $True
                    MailNickname    = 'M365DSC'
                    GroupTypes      = @('Unified')
                    Visibility      = 'Private'
                    Ensure          = 'Present'
                    Credential      = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName     = 'DSCGroup'
                        Description     = 'Microsoft DSC' #Drift
                        SecurityEnabled = $True
                        GroupTypes      = @('Unified')
                        MailEnabled     = $True
                        MailNickname    = 'M365DSC'
                        Visibility      = 'Private'
                        Id              = '12345-12345-12345-12345-12345'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Update-MgGroup' -Exactly 1
            }
        }

        Context -Name 'The Group Exists but is not a member of another group. Values are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName     = 'DSCGroup'
                    ID              = '12345-12345-12345-12345'
                    Description     = 'Microsoft DSC Group'
                    SecurityEnabled = $True
                    MailEnabled     = $true
                    GroupTypes      = @()
                    MailNickname    = 'M365DSC'
                    MemberOf        = 'DSCMemberOfGroup'
                    Ensure          = 'Present'
                    Credential      = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }
                Mock -CommandName Get-MgGroup -ParameterFilter { $Id -eq '12345-12345-12345-12345' -or $Filter -eq "DisplayName eq 'DSCGroup'" } -MockWith {
                    $returnData = @{
                        DisplayName     = 'DSCGroup'
                        ID              = '12345-12345-12345-12345'
                        Description     = 'Microsoft DSC Group'
                        SecurityEnabled = $True
                        MailEnabled = $true
                        MailNickname    = 'M365DSC'
                        GroupTypes      = @()
                    }

                    # Set-TargetResource expects object-type of answer to contain 'group'
                    $returnData.psobject.TypeNames.insert(0, 'Group')
                    return $returnData
                }
                Mock -CommandName Get-MgGroup -ParameterFilter { $Id -eq '67890-67890-67890-67890' -or $Filter -eq "DisplayName -eq 'DSCMemberOfGroup'" } -MockWith {
                    $returnData = @{
                        DisplayName     = 'DSCMemberOfGroup'
                        ID              = '67890-67890-67890-67890'
                        Description     = 'Microsoft DSC MemberOf Group'
                        SecurityEnabled = $True
                        MailEnabled     = $true
                        GroupTypes      = @()
                        MailNickname    = 'M365DSCM'
                    }
                    # Set-TargetResource expects object-type of answer to contain 'group'
                    $returnData.psobject.TypeNames.insert(0, 'Group')
                    return $returnData
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaGroupMemberOf' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 2
            }
        }

        Context -Name 'The Group Exists but is not assigned to a role. Values are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $true
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    IsAssignableToRole = $true
                    AssignedToRole     = 'AADRole'
                    Ensure             = 'Present'
                    Credential         = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $true
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $true
                        AssignedToRole     = @()
                        Ensure             = 'Present'
                    }
                }

                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return @{
                        DisplayName = 'AADRole'
                        ID          = '12345-12345-12345-12345'
                    }
                }
                Mock -CommandName Get-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {
                    return $null
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaRoleManagementDirectoryRoleAssignment' -Exactly 1
                Should -Invoke -CommandName 'New-MgBetaRoleManagementDirectoryRoleAssignment' -Exactly 1
            }
        }

        Context -Name 'The Group Exists but group is not assigned as member. Values are NOT in the desired state' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $true
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    IsAssignableToRole = $true
                    GroupAsMembers     = 'DSCGroupMember'
                    Ensure             = 'Present'
                    Credential         = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroupMember'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $true
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $true
                        AssignedToRole     = @()
                        Ensure             = 'Present'
                    }
                }

                Mock -CommandName New-MgBetaGroupMemberByRef -MockWith {
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 2
                Should -Invoke -CommandName 'New-MgBetaGroupMemberByRef' -Exactly 1
                #Should -Invoke -CommandName 'Remove-MgGroupMemberDirectoryObjectByRef' -Exactly 1
            }
        }

        Context -Name "The Group Exists and is assigned to a role but it shouldn't be. Values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $true
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    IsAssignableToRole = $true
                    AssignedToRole     = @()
                    Ensure             = 'Present'
                    Credential         = $Credential
                }


                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $true
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $true
                    }
                }
                Mock -CommandName Get-MgBetaGroupMemberOf -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = '#microsoft.graph.directoryRole'
                            displayName   = 'AADRole'
                        }
                    }
                }
                Mock -CommandName Get-MgBetaDirectoryRole -MockWith {
                    return @{
                        DisplayName = 'AADRole'
                        ID          = '12345-12345-12345-12345'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaGroupMemberOf' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Get-MgBetaRoleManagementDirectoryRoleDefinition' -Exactly 2
                Should -Invoke -CommandName 'Remove-MgBetaRoleManagementDirectoryRoleAssignment' -Exactly 1
            }
        }

        Context -Name "The Group does not exist and must be created and assigned a license. Values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    AssignedLicenses   = @(
                        (New-CimInstance -ClassName MSFT_AADGroupLicense -Property @{
                            DisabledPlans  = [string[]]@()
                            SkuId          = 'AAD_PREMIUM_P2'
                        } -ClientOnly)
                    )
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '56789-56789-56789-56789'
                                ServicePlanName = 'Something_P2'
                            }
                        )
                        SkuId                = '12345-12345-12345-12345'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Set-MgGroupLicense' -Exactly 1
            }
        }

        Context -Name "The Group exists and has been assigned the correct license. Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    AssignedLicenses   = @(
                        (New-CimInstance -ClassName MSFT_AADGroupLicense -Property @{
                            DisabledPlans  = [string[]]@()
                            SkuId          = 'AAD_PREMIUM_P2'
                        } -ClientOnly)
                    )
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $false
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        value = @{
                            DisabledPlans = @()
                            SkuId         = '12345-12345-12345'
                        }
                    }
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '67890-67890-67890'
                                ServicePlanName = 'Something_P2'
                            }
                        )
                        SkuId                = '12345-12345-12345'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Invoke-MgGraphRequest' -Exactly 1
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }
        Context -Name "The Group exists and has been assigned the correct license but DisabledPlans differ. Values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    AssignedLicenses   = @(
                        (New-CimInstance -ClassName MSFT_AADGroupLicense -Property @{
                            DisabledPlans  = [string[]]@()
                            SkuId          = 'AAD_PREMIUM_P2'  # is really the SkuPartNumber
                        } -ClientOnly)
                    )
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $false
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        value = @{
                            DisabledPlans = @('56789-56789-56789-56789')
                            SkuId         = '23456-23456-23456-23456'
                        }
                    }
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '56789-56789-56789-56789'
                                ServicePlanName = 'AAD_PREMIUM'
                            },
                            @{
                                ServicePlanId   = '67890-67890-67890-67890'
                                ServicePlanName = 'AAD_PREMIUM_P2'
                            }
                        )
                        SkuId                = '23456-23456-23456-23456'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Invoke-MgGraphRequest' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Update-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Set-MgGroupLicense' -Exactly 1
            }
        }
        Context -Name "The Group exists and is not assigned a license but it should be. Values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    AssignedLicenses   = @(
                        (New-CimInstance -ClassName MSFT_AADGroupLicense -Property @{
                            DisabledPlans  = [string[]]@()
                            SkuId          = 'AAD_PREMIUM_P2'
                        } -ClientOnly)
                    )
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $false
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '67890-67890-67890'
                                ServicePlanName = 'Something_P2'
                            }
                        )
                        SkuId                = '12345-12345-12345'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Invoke-MgGraphRequest' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Set-MgGroupLicense' -Exactly 1
            }
        }
        Context -Name "The Group exists and is assigned a license but it shouldn't be. Values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    AssignedLicenses   = @()
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $false
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        value = @{
                            DisabledPlans = @()
                            SkuId         = '12345-12345-12345'
                        }
                    }
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '67890-67890-67890'
                                ServicePlanName = 'Something_P2'
                            }
                        )
                        SkuId                = '12345-12345-12345'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Invoke-MgGraphRequest' -Exactly 1
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Set-MgGroupLicense' -Exactly 1
            }
        }

        Context -Name "The Group exists and is assigned a license. Tested values are in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName        = 'DSCGroup'
                    ID                 = '12345-12345-12345-12345'
                    Description        = 'Microsoft DSC Group'
                    SecurityEnabled    = $True
                    MailEnabled        = $false
                    GroupTypes         = @()
                    MailNickname       = 'M365DSC'
                    Ensure             = 'Present'
                    Credential         = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $false
                        GroupTypes         = @()
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $false
                    }
                }

                Mock -CommandName Invoke-MgGraphRequest -MockWith {
                    return @{
                        value = @{
                            DisabledPlans = @()
                            SkuId         = '12345-12345-12345'
                        }
                    }
                }

                Mock -CommandName Get-MgBetaSubscribedSku -MockWith {
                    return [pscustomobject]@{
                        ServicePlans         = @(
                            @{
                                ServicePlanId   = '67890-67890-67890'
                                ServicePlanName = 'Something_P2'
                            }
                        )
                        SkuId                = '12345-12345-12345'
                        SkuPartNumber        = 'AAD_PREMIUM_P2'
                    }
                }
            }

            It 'Should return Values from the Get method' {
                Get-TargetResource @testParams
                Should -Invoke -CommandName 'Get-MgGroup' -Exactly 1
                Should -Invoke -CommandName 'Invoke-MgGraphRequest' -Exactly 1
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName New-M365DSCConnection -MockWith {
                    return 'Credentials'
                }

                Mock -CommandName Get-MgGroup -MockWith {
                    return @{
                        DisplayName        = 'DSCGroup'
                        ID                 = '12345-12345-12345-12345'
                        Description        = 'Microsoft DSC Group'
                        SecurityEnabled    = $True
                        MailEnabled        = $False
                        GroupTypes         = @("Unified")
                        MailNickname       = 'M365DSC'
                        IsAssignableToRole = $true
                        Ensure             = 'Present'
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
