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
    -DscResource "AADVerifiedIdAuthorityContract" -GenericStubModule $GenericStubPath
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
        Context -Name "The AADVerifiedIdAuthorityContract should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    authorityId = "FakeStringValue"
                    name = "FakeStringValue"
                    linkedDomainUrl = "FakeStringValue"
                    displays = @()
                    rules = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractRulesModel -Property @{
                        validityInterval = 15552000
                        vc = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractVcType -Property @{
                            type = @("FakeStringValue")
                        } -ClientOnly)
                        attestations = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestations -Property @{
                            required = $True
                        } -ClientOnly) 

                    } -ClientOnly)
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    param ($Uri)
                    switch ($Uri) {
                        "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities" {
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
                        default { 
                            return @{
                                value = @()
                            }
                        }
                    }
                }

            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the id from the Set method' {
                Set-TargetResource @testParams 
                Should -Invoke -CommandName Invoke-M365DSCVerifiedIdWebRequest -Exactly 4
            }
        }

        Context -Name "The AADVerifiedIdAuthorityContract exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    authorityId = "FakeStringValue"
                    name = "FakeStringValue"
                    linkedDomainUrl = "FakeStringValue"
                    displays =  [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayModel -Property @{
                                consent = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayConsent -Property @{
                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                } -ClientOnly)
                                card = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCard -Property @{
                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                    issuedBy = "Contoso"
                                    backgroundColor = "#000000"
                                    textColor = "#FFFFFA"
                                    logo = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo -Property @{
                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                        description = "Default verified employee logo"
                                    } -ClientOnly)
                                    title = "Verified Employee"
                                } -ClientOnly)
                                locale = "en-US"
                                claims =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayClaims -Property @{
                                        label = "Revocation id"
                                        claim = "vc.credentialSubject.revocationId"
                                        type = "String"
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        )
                    rules = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractRulesModel -Property @{
                            validityInterval = 15552000
                            vc = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractVcType -Property @{
                                type = @("VerifiedEmployee")
                            } -ClientOnly)
                            attestations = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestations -Property @{
                                accessTokens =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestationValues -Property @{
                                        mapping =  [CimInstance[]]@(
                                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractClaimMapping -Property @{
                                                inputClaim = "photo"
                                                indexed = $False
                                                outputClaim = "photo"
                                                required = $False
                                            } -ClientOnly)
                                        )
                                        required = $True
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        } -ClientOnly)
                    Ensure = 'Absent'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    param ($Uri)
                    switch ($Uri) {
                        "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities" {
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
                        default { 
                            return @{
                                value = @(
                                    @{
                                        id = "FakeStringValue"
                                        authorityId = "FakeStringValue"
                                        name = "FakeStringValue"
                                        linkedDomainUrl = "FakeStringValue"
                                        displays = @(
                                            @{
                                                consent = @{
                                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                                }
                                                card = @{
                                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                                    issuedBy = "Contoso"
                                                    backgroundColor = "#000000"
                                                    textColor = "#FFFFFA"
                                                    logo = @{
                                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                        description = "Default verified employee logo"
                                                    }
                                                    title = "Verified Employee"
                                                }
                                                locale = "en-US"
                                                claims = @(
                                                    @{
                                                        label = "Revocation id"
                                                        claim = "vc.credentialSubject.revocationId"
                                                        type = "String"
                                                    }
                                                )
                                            }
                                        )
                                        rules = @{
                                            validityInterval = 15552000
                                            vc = @{
                                                type = @("VerifiedEmployee")
                                            }
                                            attestations = @{
                                                accessTokens = @(
                                                    @{
                                                        mapping = @(
                                                            @{
                                                                inputClaim = "photo"
                                                                indexed = $False
                                                                outputClaim = "photo"
                                                                required = $False
                                                            }
                                                        )
                                                        required = $True
                                                    }
                                                )
                                            }
                                        }
                                        Ensure = 'Present'
                                    }
                                )
                            }
                        }
                    }
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                authorityId = "FakeStringValue"
                                name = "FakeStringValue"
                                linkedDomainUrl = "FakeStringValue"
                                displays = @(
                                    @{
                                        consent = @{
                                            instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                            title = "Do you really want to accept the verified employee credential from Contoso."
                                        }
                                        card = @{
                                            description = "This verifiable credential is issued to all members of the Contoso org."
                                            issuedBy = "Contoso"
                                            backgroundColor = "#000000"
                                            textColor = "#FFFFFA"
                                            logo = @{
                                                uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                description = "Default verified employee logo"
                                            }
                                            title = "Verified Employee"
                                        }
                                        locale = "en-US"
                                        claims = @(
                                            @{
                                                label = "Revocation id"
                                                claim = "vc.credentialSubject.revocationId"
                                                type = "String"
                                            }
                                        )
                                    }
                                )
                                rules = @{
                                    validityInterval = 15552000
                                    vc = @{
                                        type = @("VerifiedEmployee")
                                    }
                                    attestations = @{
                                        accessTokens = @(
                                            @{
                                                mapping = @(
                                                    @{
                                                        inputClaim = "photo"
                                                        indexed = $False
                                                        outputClaim = "photo"
                                                        required = $False
                                                    }
                                                )
                                                required = $True
                                            }
                                        )
                                    }
                                }
                                Ensure = 'Present'
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
        Context -Name "The AADVerifiedIdAuthorityContract Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    authorityId = "FakeStringValue"
                    name = "FakeStringValue"
                    linkedDomainUrl = "FakeStringValue"
                    displays =  [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayModel -Property @{
                                consent = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayConsent -Property @{
                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                } -ClientOnly)
                                card = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCard -Property @{
                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                    issuedBy = "Contoso"
                                    backgroundColor = "#000000"
                                    textColor = "#FFFFFA"
                                    logo = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo -Property @{
                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                        description = "Default verified employee logo"
                                    } -ClientOnly)
                                    title = "Verified Employee"
                                } -ClientOnly)
                                locale = "en-US"
                                claims =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayClaims -Property @{
                                        label = "Revocation id"
                                        claim = "vc.credentialSubject.revocationId"
                                        type = "String"
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        )
                    rules = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractRulesModel -Property @{
                            validityInterval = 15552000
                            vc = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractVcType -Property @{
                                type = @("VerifiedEmployee")
                            } -ClientOnly)
                            attestations = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestations -Property @{
                                accessTokens =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestationValues -Property @{
                                        mapping =  [CimInstance[]]@(
                                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractClaimMapping -Property @{
                                                inputClaim = "photo"
                                                indexed = $False
                                                outputClaim = "photo"
                                                required = $False
                                            } -ClientOnly)
                                        )
                                        required = $True
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        } -ClientOnly)
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    param ($Uri)
                    switch ($Uri) {
                        "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities" {
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
                        default { 
                            return @{
                                value = @(
                                    @{
                                        id = "FakeStringValue"
                                        authorityId = "FakeStringValue"
                                        name = "FakeStringValue"
                                        linkedDomainUrl = "FakeStringValue"
                                        displays = @(
                                            @{
                                                consent = @{
                                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                                }
                                                card = @{
                                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                                    issuedBy = "Contoso"
                                                    backgroundColor = "#000000"
                                                    textColor = "#FFFFFA"
                                                    logo = @{
                                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                        description = "Default verified employee logo"
                                                    }
                                                    title = "Verified Employee"
                                                }
                                                locale = "en-US"
                                                claims = @(
                                                    @{
                                                        label = "Revocation id"
                                                        claim = "vc.credentialSubject.revocationId"
                                                        type = "String"
                                                    }
                                                )
                                            }
                                        )
                                        rules = @{
                                            validityInterval = 15552000
                                            vc = @{
                                                type = @("VerifiedEmployee")
                                            }
                                            attestations = @{
                                                accessTokens = @(
                                                    @{
                                                        mapping = @(
                                                            @{
                                                                inputClaim = "photo"
                                                                indexed = $False
                                                                outputClaim = "photo"
                                                                required = $False
                                                            }
                                                        )
                                                        required = $True
                                                    }
                                                )
                                            }
                                        }
                                        Ensure = 'Present'
                                    }
                                )
                            }
                        }
                    }
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                authorityId = "FakeStringValue"
                                name = "FakeStringValue"
                                linkedDomainUrl = "FakeStringValue"
                                displays = @(
                                    @{
                                        consent = @{
                                            instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                            title = "Do you really want to accept the verified employee credential from Contoso."
                                        }
                                        card = @{
                                            description = "This verifiable credential is issued to all members of the Contoso org."
                                            issuedBy = "Contoso"
                                            backgroundColor = "#000000"
                                            textColor = "#FFFFFA"
                                            logo = @{
                                                uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                description = "Default verified employee logo"
                                            }
                                            title = "Verified Employee"
                                        }
                                        locale = "en-US"
                                        claims = @(
                                            @{
                                                label = "Revocation id"
                                                claim = "vc.credentialSubject.revocationId"
                                                type = "String"
                                            }
                                        )
                                    }
                                )
                                rules = @{
                                    validityInterval = 15552000
                                    vc = @{
                                        type = @("VerifiedEmployee")
                                    }
                                    attestations = @{
                                        accessTokens = @(
                                            @{
                                                mapping = @(
                                                    @{
                                                        inputClaim = "photo"
                                                        indexed = $False
                                                        outputClaim = "photo"
                                                        required = $False
                                                    }
                                                )
                                                required = $True
                                            }
                                        )
                                    }
                                }
                                Ensure = 'Present'
                            }
                        )
                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADVerifiedIdAuthorityContract exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    id = "FakeStringValue"
                    authorityId = "FakeStringValue"
                    name = "FakeStringValue"
                    linkedDomainUrl = "FakeStringValue"
                    displays =  [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayModel -Property @{
                                consent = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayConsent -Property @{
                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                    title = "Do you want to accept the verified employee credential from Contoso." #drift
                                } -ClientOnly)
                                card = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCard -Property @{
                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                    issuedBy = "Contoso"
                                    backgroundColor = "#000000"
                                    textColor = "#FFFFFA"
                                    logo = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayCredentialLogo -Property @{
                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                        description = "Default verified employee logo"
                                    } -ClientOnly)
                                    title = "Verified Employee"
                                } -ClientOnly)
                                locale = "en-US"
                                claims =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractDisplayClaims -Property @{
                                        label = "Revocation id"
                                        claim = "vc.credentialSubject.revocationId"
                                        type = "String"
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        )
                    rules = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractRulesModel -Property @{
                            validityInterval = 15552000
                            vc = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractVcType -Property @{
                                type = @("VerifiedEmployee")
                            } -ClientOnly)
                            attestations = (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestations -Property @{
                                accessTokens =  [CimInstance[]]@(
                                    (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractAttestationValues -Property @{
                                        mapping =  [CimInstance[]]@(
                                            (New-CimInstance -ClassName MSFT_AADVerifiedIdAuthorityContractClaimMapping -Property @{
                                                inputClaim = "photo"
                                                indexed = $False
                                                outputClaim = "photo"
                                                required = $False
                                            } -ClientOnly)
                                        )
                                        required = $True
                                    } -ClientOnly)
                                )
                            } -ClientOnly)
                        } -ClientOnly)
                    Ensure = 'Present'
                }

                Mock -CommandName Invoke-M365DSCVerifiedIdWebRequest -MockWith {
                    param ($Uri)
                    switch ($Uri) {
                        "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities" {
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
                        default { 
                            return @{
                                value = @(
                                    @{
                                        id = "FakeStringValue"
                                        authorityId = "FakeStringValue"
                                        name = "FakeStringValue"
                                        linkedDomainUrl = "FakeStringValue"
                                        displays = @(
                                            @{
                                                consent = @{
                                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                                }
                                                card = @{
                                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                                    issuedBy = "Contoso"
                                                    backgroundColor = "#000000"
                                                    textColor = "#FFFFFA"
                                                    logo = @{
                                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                        description = "Default verified employee logo"
                                                    }
                                                    title = "Verified Employee"
                                                }
                                                locale = "en-US"
                                                claims = @(
                                                    @{
                                                        label = "Revocation id"
                                                        claim = "vc.credentialSubject.revocationId"
                                                        type = "String"
                                                    }
                                                )
                                            }
                                        )
                                        rules = @{
                                            validityInterval = 15552000
                                            vc = @{
                                                type = @("VerifiedEmployee")
                                            }
                                            attestations = @{
                                                accessTokens = @(
                                                    @{
                                                        mapping = @(
                                                            @{
                                                                inputClaim = "photo"
                                                                indexed = $False
                                                                outputClaim = "photo"
                                                                required = $False
                                                            }
                                                        )
                                                        required = $True
                                                    }
                                                )
                                            }
                                        }
                                        Ensure = 'Present'
                                    }
                                )
                            }
                        }
                    }
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                authorityId = "FakeStringValue"
                                name = "FakeStringValue"
                                linkedDomainUrl = "FakeStringValue"
                                displays = @(
                                    @{
                                        consent = @{
                                            instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                            title = "Do you really want to accept the verified employee credential from Contoso."
                                        }
                                        card = @{
                                            description = "This verifiable credential is issued to all members of the Contoso org."
                                            issuedBy = "Contoso"
                                            backgroundColor = "#000000"
                                            textColor = "#FFFFFA"
                                            logo = @{
                                                uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                description = "Default verified employee logo"
                                            }
                                            title = "Verified Employee"
                                        }
                                        locale = "en-US"
                                        claims = @(
                                            @{
                                                label = "Revocation id"
                                                claim = "vc.credentialSubject.revocationId"
                                                type = "String"
                                            }
                                        )
                                    }
                                )
                                rules = @{
                                    validityInterval = 15552000
                                    vc = @{
                                        type = @("VerifiedEmployee")
                                    }
                                    attestations = @{
                                        accessTokens = @(
                                            @{
                                                mapping = @(
                                                    @{
                                                        inputClaim = "photo"
                                                        indexed = $False
                                                        outputClaim = "photo"
                                                        required = $False
                                                    }
                                                )
                                                required = $True
                                            }
                                        )
                                    }
                                }
                                Ensure = 'Present'
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
                Should -Invoke -CommandName Invoke-M365DSCVerifiedIdWebRequest -Exactly 3
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
                    param ($Uri)
                    switch ($Uri) {
                        "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/authorities" {
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
                        default { 
                            return @{
                                value = @(
                                    @{
                                        id = "FakeStringValue"
                                        authorityId = "FakeStringValue"
                                        name = "FakeStringValue"
                                        linkedDomainUrl = "FakeStringValue"
                                        displays = @(
                                            @{
                                                consent = @{
                                                    instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                                    title = "Do you really want to accept the verified employee credential from Contoso."
                                                }
                                                card = @{
                                                    description = "This verifiable credential is issued to all members of the Contoso org."
                                                    issuedBy = "Contoso"
                                                    backgroundColor = "#000000"
                                                    textColor = "#FFFFFA"
                                                    logo = @{
                                                        uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                        description = "Default verified employee logo"
                                                    }
                                                    title = "Verified Employee"
                                                }
                                                locale = "en-US"
                                                claims = @(
                                                    @{
                                                        label = "Revocation id"
                                                        claim = "vc.credentialSubject.revocationId"
                                                        type = "String"
                                                    }
                                                )
                                            }
                                        )
                                        rules = @{
                                            validityInterval = 15552000
                                            vc = @{
                                                type = @("VerifiedEmployee")
                                            }
                                            attestations = @{
                                                accessTokens = @(
                                                    @{
                                                        mapping = @(
                                                            @{
                                                                inputClaim = "photo"
                                                                indexed = $False
                                                                outputClaim = "photo"
                                                                required = $False
                                                            }
                                                        )
                                                        required = $True
                                                    }
                                                )
                                            }
                                        }
                                        Ensure = 'Present'
                                    }
                                )
                            }
                        }
                    }
                    return @{
                        value = @(
                            @{
                                id = "FakeStringValue"
                                authorityId = "FakeStringValue"
                                name = "FakeStringValue"
                                linkedDomainUrl = "FakeStringValue"
                                displays = @(
                                    @{
                                        consent = @{
                                            instructions = "Verify your identity and workplace the easy way. Add this ID for online and in-person use."
                                            title = "Do you really want to accept the verified employee credential from Contoso."
                                        }
                                        card = @{
                                            description = "This verifiable credential is issued to all members of the Contoso org."
                                            issuedBy = "Contoso"
                                            backgroundColor = "#000000"
                                            textColor = "#FFFFFA"
                                            logo = @{
                                                uri = "https://proddideussg1.z13.web.core.windows.net/systemgeneratedcontractlogo.png"
                                                description = "Default verified employee logo"
                                            }
                                            title = "Verified Employee"
                                        }
                                        locale = "en-US"
                                        claims = @(
                                            @{
                                                label = "Revocation id"
                                                claim = "vc.credentialSubject.revocationId"
                                                type = "String"
                                            }
                                        )
                                    }
                                )
                                rules = @{
                                    validityInterval = 15552000
                                    vc = @{
                                        type = @("VerifiedEmployee")
                                    }
                                    attestations = @{
                                        accessTokens = @(
                                            @{
                                                mapping = @(
                                                    @{
                                                        inputClaim = "photo"
                                                        indexed = $False
                                                        outputClaim = "photo"
                                                        required = $False
                                                    }
                                                )
                                                required = $True
                                            }
                                        )
                                    }
                                }
                                Ensure = 'Present'
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
