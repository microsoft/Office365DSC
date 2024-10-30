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
    -DscResource "AADVerifiedIdAuthority" -GenericStubModule $GenericStubPath
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

            Mock -CommandName Invoke-WebRequest -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The AADVerifiedIdAuthority should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id = "FakeStringValue"
                    Name = "FakeStringValue"
                    LinkedDomainUrl = "FakeStringValue"
                    DidMethod = "FakeStringValue"
                    KeyVaultMetadata = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityKeyVaultMetadata -Property @{
                        SubscriptionId = "FakeStringValue"
                        ResourceGroup = "FakeStringValue"
                        ResourceName = "FakeStringValue"
                        ResourceUrl = "FakeStringValue"
                    } -ClientOnly)
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    return @()
                }

            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams -Verbose).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the id from the Set method' {
                Set-TargetResource @testParams 
                Should -Invoke -CommandName Invoke-M365DSCVerifiedIdWebRequest -Exactly 2
            }
        }

        Context -Name "The AADVerifiedIdAuthority exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id = "FakeStringValue"
                    Name = "FakeStringValue"
                    LinkedDomainUrl = "FakeStringValue"
                    DidMethod = "FakeStringValue"
                    KeyVaultMetadata = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityKeyVaultMetadata -Property @{
                        SubscriptionId = "FakeStringValue"
                        ResourceGroup = "FakeStringValue"
                        ResourceName = "FakeStringValue"
                        ResourceUrl = "FakeStringValue"
                    } -ClientOnly)
                    Ensure = 'Absent'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                name = "FakeStringValue"
                                didModel = @{
                                    linkedDomainUrls = @("FakeStringValue")
                                    did = "did:FakeStringValue"
                                }
                            }
                        )
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
                Should -Invoke -CommandName Invoke-M365DSCVerifiedIdWebRequest -Exactly 2
            }
        }
        Context -Name "The AADVerifiedIdAuthority Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id = "FakeStringValue"
                    Name = "FakeStringValue"
                    LinkedDomainUrl = "FakeStringValue"
                    DidMethod = "FakeStringValue"
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                name = "FakeStringValue"
                                didModel = @{
                                    linkedDomainUrls = @("FakeStringValue")
                                    did = "did:FakeStringValue"
                                }
                            }
                        )
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADVerifiedIdAuthority exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    Id = "FakeStringValue"
                    Name = "FakeStringValue2"
                    LinkedDomainUrl = "FakeStringValue"
                    DidMethod = "FakeStringValue"
                    KeyVaultMetadata = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityKeyVaultMetadata -Property @{
                        SubscriptionId = "FakeStringValue"
                        ResourceGroup = "FakeStringValue"
                        ResourceName = "FakeStringValue"
                        ResourceUrl = "FakeStringValue"
                    } -ClientOnly)
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                name = "FakeStringValue"
                                didModel = @{
                                    linkedDomainUrls = @("FakeStringValue")
                                    did = "did:FakeStringValue"
                                }
                                keyVaultMetadata = @{
                                    subscriptionId = "FakeStringValue"
                                    resourceGroup = "FakeStringValue"
                                    resourceName = "FakeStringValue"
                                    resourceUrl = "FakeStringValue"
                                }
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
                Should -Invoke -CommandName Invoke-M365DSCVerifiedIdWebRequest -Exactly 2
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                name = "FakeStringValue"
                                didModel = @{
                                    linkedDomainUrls = @("FakeStringValue")
                                    did = "did:FakeStringValue"
                                }
                                keyVaultMetadata = @{
                                    subscriptionId = "FakeStringValue"
                                    resourceGroup = "FakeStringValue"
                                    resourceName = "FakeStringValue"
                                    resourceUrl = "FakeStringValue"
                                }
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
