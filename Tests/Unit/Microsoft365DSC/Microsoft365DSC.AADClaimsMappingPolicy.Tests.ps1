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
    -DscResource "AADClaimsMappingPolicy" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Update-MgBetaPolicyClaimMappingPolicy -MockWith {
            }

            Mock -CommandName New-MgBetaPolicyClaimMappingPolicy -MockWith {
            }

            Mock -CommandName Remove-MgBetaPolicyClaimMappingPolicy -MockWith {
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
        Context -Name "The AADClaimsMappingPolicy should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinition -Property @{
                            ClaimsMappingPolicy = New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy -Property @{
                                ClaimsSchema = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema -Property @{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    } -ClientOnly
                                )
                                ClaimsTransformation = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation -Property @{
                                        OutputClaims = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims -Property @{
                                                ClaimTypeReferenceId = 'TOS'
                                                TransformationClaimType = 'createdClaim'
                                            } -ClientOnly
                                        )
                                        Id = 'CreateTermsOfService'
                                        InputParameters = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter -Property @{
                                                DataType = 'string'
                                                Id = 'value'
                                                Value = 'sandbox'
                                            } -ClientOnly
                                        )
                                        TransformationMethod = 'CreateStringClaim'
                                    } -ClientOnly
                                )
                                IncludeBasicClaimSet = $True
                                Version = 1
                            } -ClientOnly
                        } -ClientOnly
                    );

                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyClaimMappingPolicy -MockWith {
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
                Should -Invoke -CommandName New-MgBetaPolicyClaimMappingPolicy -Exactly 1
            }
        }

        Context -Name "The AADClaimsMappingPolicy exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinition -Property @{
                            ClaimsMappingPolicy = New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy -Property @{
                                ClaimsSchema = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema -Property @{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    } -ClientOnly
                                )
                                ClaimsTransformation = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation -Property @{
                                        OutputClaims = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims -Property @{
                                                ClaimTypeReferenceId = 'TOS'
                                                TransformationClaimType = 'createdClaim'
                                            } -ClientOnly
                                        )
                                        Id = 'CreateTermsOfService'
                                        InputParameters = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter -Property @{
                                                DataType = 'string'
                                                Id = 'value'
                                                Value = 'sandbox'
                                            } -ClientOnly
                                        )
                                        TransformationMethod = 'CreateStringClaim'
                                    } -ClientOnly
                                )
                                IncludeBasicClaimSet = $True
                                Version = 1
                            } -ClientOnly
                        } -ClientOnly
                    );

                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = "Absent"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyClaimMappingPolicy -MockWith {
                    return @{
                        Definition = @("{`"ClaimsMappingPolicy`":{`"Version`":1,`"IncludeBasicClaimSet`":`"true`",`"ClaimsSchema`":[{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`"},{`"Source`":`"user`",`"ID`":`"givenname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`"},{`"Source`":`"user`",`"ID`":`"displayname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`"},{`"Source`":`"user`",`"ID`":`"surname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`"},{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"username`"}],`"ClaimsTransformation`":[{`"ID`":`"CreateTermsOfService`",`"TransformationMethod`":`"CreateStringClaim`",`"InputParameters`":[{`"ID`":`"value`",`"DataType`":`"string`", `"Value`":`"sandbox`"}],`"OutputClaims`":[{`"ClaimTypeReferenceId`":`"TOS`",`"TransformationClaimType`":`"createdClaim`"}]}]}}")
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IsOrganizationDefault = $True
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
                Should -Invoke -CommandName Remove-MgBetaPolicyClaimMappingPolicy -Exactly 1
            }
        }
        Context -Name "The AADClaimsMappingPolicy Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinition -Property @{
                            ClaimsMappingPolicy = New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy -Property @{
                                ClaimsSchema = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema -Property @{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    } -ClientOnly
                                )
                                ClaimsTransformation = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation -Property @{
                                        OutputClaims = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims -Property @{
                                                ClaimTypeReferenceId = 'TOS'
                                                TransformationClaimType = 'createdClaim'
                                            } -ClientOnly
                                        )
                                        Id = 'CreateTermsOfService'
                                        InputParameters = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter -Property @{
                                                DataType = 'string'
                                                Id = 'value'
                                                Value = 'sandbox'
                                            } -ClientOnly
                                        )
                                        TransformationMethod = 'CreateStringClaim'
                                    } -ClientOnly
                                )
                                IncludeBasicClaimSet = $True
                                Version = 1
                            } -ClientOnly
                        } -ClientOnly
                    );

                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyClaimMappingPolicy -MockWith {
                    return @{
                        Definition = @("{`"ClaimsMappingPolicy`":{`"Version`":1,`"IncludeBasicClaimSet`":`"true`",`"ClaimsSchema`":[{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`"}],`"ClaimsTransformation`":[{`"ID`":`"CreateTermsOfService`",`"TransformationMethod`":`"CreateStringClaim`",`"InputParameters`":[{`"ID`":`"value`",`"DataType`":`"string`", `"Value`":`"sandbox`"}],`"OutputClaims`":[{`"ClaimTypeReferenceId`":`"TOS`",`"TransformationClaimType`":`"createdClaim`"}]}]}}")
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IsOrganizationDefault = $True
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADClaimsMappingPolicy exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Definition = [CimInstance[]]@(
                        New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinition -Property @{
                            ClaimsMappingPolicy = New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicy -Property @{
                                ClaimsSchema = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsSchema -Property @{
                                        SamlClaimType = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'
                                        Source = 'user'
                                        Id = 'userprincipalname'
                                    } -ClientOnly
                                )
                                ClaimsTransformation = [CimInstance[]]@(
                                    New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformation -Property @{
                                        OutputClaims = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationOutputClaims -Property @{
                                                ClaimTypeReferenceId = 'TOS'
                                                TransformationClaimType = 'createdClaim'
                                            } -ClientOnly
                                        )
                                        Id = 'CreateTermsOfService'
                                        InputParameters = [CimInstance[]]@(
                                            New-CimInstance -ClassName MSFT_AADClaimsMappingPolicyDefinitionMappingPolicyClaimsTransformationInputParameter -Property @{
                                                DataType = 'string'
                                                Id = 'value'
                                                Value = 'sandbox'
                                            } -ClientOnly
                                        )
                                        TransformationMethod = 'CreateStringClaim'
                                    } -ClientOnly
                                )
                                IncludeBasicClaimSet = $True
                                Version = 1
                            } -ClientOnly
                        } -ClientOnly
                    );

                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    Id = "FakeStringValue"
                    IsOrganizationDefault = $True
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgBetaPolicyClaimMappingPolicy -MockWith {
                    return @{
                        Definition = @("{`"ClaimsMappingPolicy`":{`"Version`":1,`"IncludeBasicClaimSet`":`"true`",`"ClaimsSchema`":[{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`"},{`"Source`":`"user`",`"ID`":`"givenname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`"},{`"Source`":`"user`",`"ID`":`"displayname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`"},{`"Source`":`"user`",`"ID`":`"surname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`"},{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"username`"}],`"ClaimsTransformation`":[{`"ID`":`"CreateTermsOfService`",`"TransformationMethod`":`"CreateStringClaim`",`"InputParameters`":[{`"ID`":`"value`",`"DataType`":`"string`", `"Value`":`"sandbox`"}],`"OutputClaims`":[{`"ClaimTypeReferenceId`":`"TOS`",`"TransformationClaimType`":`"createdClaim`"}]}]}}")
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IsOrganizationDefault = $True
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
                Should -Invoke -CommandName Update-MgBetaPolicyClaimMappingPolicy -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaPolicyClaimMappingPolicy -MockWith {
                    return @{
                        Definition = @("{`"ClaimsMappingPolicy`":{`"Version`":1,`"IncludeBasicClaimSet`":`"true`",`"ClaimsSchema`":[{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`"},{`"Source`":`"user`",`"ID`":`"givenname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`"},{`"Source`":`"user`",`"ID`":`"displayname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`"},{`"Source`":`"user`",`"ID`":`"surname`",`"SamlClaimType`":`"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`"},{`"Source`":`"user`",`"ID`":`"userprincipalname`",`"SamlClaimType`":`"username`"}],`"ClaimsTransformation`":[{`"ID`":`"CreateTermsOfService`",`"TransformationMethod`":`"CreateStringClaim`",`"InputParameters`":[{`"ID`":`"value`",`"DataType`":`"string`", `"Value`":`"sandbox`"}],`"OutputClaims`":[{`"ClaimTypeReferenceId`":`"TOS`",`"TransformationClaimType`":`"createdClaim`"}]}]}}")
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                        IsOrganizationDefault = $True
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
