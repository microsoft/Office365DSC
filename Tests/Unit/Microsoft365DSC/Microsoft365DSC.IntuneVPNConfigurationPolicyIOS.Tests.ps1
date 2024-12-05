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
    -DscResource 'IntuneVPNConfigurationPolicyIOS' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {
            $secpasswd = ConvertTo-SecureString ((New-Guid).ToString()) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }

            Mock -CommandName Update-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName New-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName Remove-MgBetaDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName Get-MgBetaDeviceManagementDeviceCompliancePolicyAssignment -MockWith {

                return @()
            }
            Mock -CommandName Update-DeviceConfigurationPolicyAssignment -MockWith {
            }
            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }

        # Test contexts
        Context -Name "When the IntuneVPNConfigurationPolicyIOS doesn't already exist" -Fixture {
            BeforeAll {
               $testParams = @{
                    connectionName                             = 'FakeStringValue'
                    connectionType                             = 'ciscoAnyConnectV2'
                    Description                                = 'FakeStringValue'
                    DisplayName                                = 'FakeStringValue'
                    enableSplitTunneling                       = $False
                    enablePerApp                               = $False
                    Id                                         = 'FakeStringValue'
                    optInToDeviceIdSharing                     = $True
                    proxyServer                                = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftvpnProxyServer `
                        -Property @{
                            port                               = 80
                            automaticConfigurationScriptUrl    = 'https://www.test.com'
                            address                            = 'proxy.test.com'
                        } -ClientOnly)
                    )
                    server                                     = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftGraphvpnServer `
                        -Property @{
                            isDefaultServer                    = $True
                            description                        = 'server'
                            address                            = 'vpn.test.com'
                        } -ClientOnly)
                    )
                    safariDomains                              = @{}                                                                                      
                    associatedDomains                          = @{}                                                                                      
                    excludedDomains                            = @{}                                                                                                                                                                          
                    excludeList                                = @{}                                                                                            
                    customData                                 = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                            key                                = 'FakeStringValue'
                            value                              = 'FakeStringValue'
                        } -ClientOnly)
                    )     
                    customKeyValueData                         = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                            name                               = 'FakeStringValue'
                            value                              = 'FakeStringValue'
                        } -ClientOnly)
                    )                                                                                                                                                                   
                    onDemandRules                              = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_DeviceManagementConfigurationPolicyVpnOnDemandRule `
                        -Property @{
                            ssids                              = 'FakeStringValue'
                            dnsSearchDomains                   = 'FakeStringValue'
                            probeUrl                           = 'FakeStringValue'
                            action                             = 'ignore'
                            domainAction                       = 'neverConnect'
                            domains                            = 'FakeStringValue'
                            probeRequiredUrl                   = 'FakeStringValue'
                            interfaceTypeMatch                 = 'notConfigured'
                            dnsServerAddressMatch              = 'FakeStringValue'
                        } -ClientOnly)
                    )                  
                     targetedMobileApps                      = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_targetedMobileApps `
                        -Property @{
                            name                               = 'FakeStringValue'
                            publisher                          = 'FakeStringValue'
                            appStoreUrl                        = 'FakeStringValue'
                            appId                              = 'FakeStringValue'
                        } -ClientOnly)
                    )
                    Ensure                                     = 'Present'
                    Credential                                 = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                    return $null
                }
            }

            It 'Should return absent from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should create the IntuneVPNConfigurationPolicyIOS from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName 'New-MgBetaDeviceManagementDeviceConfiguration' -Exactly 1
            }
        }

        Context -Name 'When the IntuneVPNConfigurationPolicyIOS already exists and is NOT in the Desired State' -Fixture {
            BeforeAll {
               $testParams = @{
                    DisplayName                               = 'FakeStringValue'
                    Description                               = 'FakeStringValue'
                    Id                                        = 'FakeStringValue'
                    authenticationMethod                      = 'usernameAndPassword'
                    connectionName                            = 'FakeStringValue'
                    connectionType                            = 'ciscoAnyConnectV2'
                    enableSplitTunneling                      = $False
                    enablePerApp                              = $False
                    optInToDeviceIdSharing                    = $True
                    proxyServer                               = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftvpnProxyServer `
                        -Property @{
                            port                              = 80
                            automaticConfigurationScriptUrl   = 'https://www.test.com'
                            address                           = 'proxy.test.com'
                        } -ClientOnly)
                    )
                    server                                    = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftGraphvpnServer `
                        -Property @{
                            isDefaultServer                   = $True
                            description                       = 'server'
                            address                           = 'vpn.test.com'
                        } -ClientOnly)
                    )
                    safariDomains                             = @{}                                                                                      
                    associatedDomains                         = @{}                                                                                      
                    excludedDomains                           = @{}                                                                                                                                                                          
                    excludeList                               = @{}                                                                                            
                    customData                                = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                           key                                = 'FakeStringValue'
                            value                             = 'FakeStringValue'
                        } -ClientOnly)
                    )     
                    customKeyValueData                        = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                            name                              = 'FakeStringValue'
                            value                             = 'FakeStringValue'
                        } -ClientOnly)
                    )                                                                                                                                                                      
                    onDemandRules      = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_DeviceManagementConfigurationPolicyVpnOnDemandRule `
                        -Property @{
                            ssids                             = 'FakeStringValue'
                            dnsSearchDomains                  = 'FakeStringValue'
                            probeUrl                          = 'FakeStringValue'
                            action                            = 'ignore'
                            domainAction                      = 'neverConnect'
                            domains                           = 'FakeStringValue'
                            probeRequiredUrl                  = 'FakeStringValue'
                            interfaceTypeMatch                = 'notConfigured'
                            dnsServerAddressMatch             = 'FakeStringValue'
                        } -ClientOnly)
                    )                    
                    targetedMobileApps                      = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_targetedMobileApps `
                        -Property @{
                            name                             = 'FakeStringValue'
                            publisher                        = 'FakeStringValue'
                            appStoreUrl                      = 'FakeStringValue'
                            appId                            = 'FakeStringValue'
                        } -ClientOnly)
                    )
                    Ensure                                   = 'Present'
                    Credential                               = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                   return  @{
                        DisplayName                                 = 'FakeStringValue'
                        Description                                 = 'FakeStringValue'
                        Id                              = 'FakeStringValue'
                        AdditionalProperties                        = @{
                            '@odata.type'                           = '#microsoft.graph.iosVpnConfiguration'
                            authenticationMethod                    = 'usernameAndPassword'
                            connectionName                          = 'FakeStringValue'
                            connectionType                          = 'ciscoAnyConnectV2'
                            customData             = @(
                                @{
                                    key                  = 'FakeStringValue'
                                    value                = 'FakeStringValue'
                                }
                            )     
                            customKeyValueData      = @(
                                @{
                                    name                  = 'FakeStringValue'
                                    value                = 'FakeStringValue'
                                }
                            )      
                            enableSplitTunneling                    = $False
                            enablePerApp                            = $False
                            disableOnDemandUserOverride             = $True   
                            disconnectOnIdle                        = $True  
                            optInToDeviceIdSharing                  = $True
                            onDemandRules      = @(`
                                @{
                                    ssids                    = 'FakeStringValue'
                                    dnsSearchDomains         = 'FakeStringValue'
                                    probeUrl                 = 'FakeStringValue'
                                    action                   = 'ignore'
                                    domainAction             = 'neverConnect'
                                    domains                  = 'FakeStringValue'
                                    probeRequiredUrl         = 'FakeStringValue'
                                    interfaceTypeMatch       = 'notConfigured'
                                    dnsServerAddressMatch    = 'FakeStringValue'
                                }
                            )                                                                                                                                                                        
                            server                                   = @(
                                @{
                                    isDefaultServer                  = $True
                                    description                      = 'server'
                                    address                          = 'vpn.CHANGED.com' #changed value
                                }
                            )    
                            proxyServer                              = @(
                                 @{
                                    port                             = 80
                                    automaticConfigurationScriptUrl  = 'https://www.test.com'
                                    address                          = 'proxy.test.com'
                                 }
                            )
                            targetedMobileApps                      = @(
                                @{
                                    name                            = 'FakeStringValue'
                                    publisher                       = 'FakeStringValue'
                                    appStoreUrl                     = 'FakeStringValue'
                                    appId                           = 'FakeStringValue'
                                }
                            )                                                                                      
                        }
                    }
                }
            }

            It 'Should return Present from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Present' #-Displayname 'FakeStringValue').Ensure | Should -Be 'Present' #
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should update the IntuneVPNConfigurationPolicyIOS from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgBetaDeviceManagementDeviceConfiguration -Exactly 1
               
            }
        }

       Context -Name 'When the policy already exists and IS in the Desired State' -Fixture {
            BeforeAll {
               $testParams = @{
                    DisplayName                              = 'FakeStringValue'
                    Description                              = 'FakeStringValue'
                    authenticationMethod                     = 'usernameAndPassword'
                    connectionName                           = 'FakeStringValue'
                    connectionType                           = 'ciscoAnyConnectV2'
                    enableSplitTunneling                     = $False
                    enablePerApp                             = $False
                    optInToDeviceIdSharing                   = $True
                    proxyServer                              = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftvpnProxyServer `
                        -Property @{
                            port                             = 80
                            automaticConfigurationScriptUrl  = 'https://www.test.com'
                            address                          = 'proxy.test.com'
                        } -ClientOnly)
                    )
                    server                                   = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftGraphvpnServer `
                        -Property @{
                            isDefaultServer                  = $True
                            description                      = 'server'
                            address                          = 'vpn.test.com'
                        } -ClientOnly)
                    )
                    customData                               = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                            key                              = 'FakeStringValue'
                            value                            = 'FakeStringValue'
                        } -ClientOnly)
                    )  
                    customKeyValueData      = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_CustomData `
                        -Property @{
                            name                            = 'FakeStringValue'
                            value                           = 'FakeStringValue'
                        } -ClientOnly)
                    )                                                                                                                                                                      
                    onDemandRules      = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_DeviceManagementConfigurationPolicyVpnOnDemandRule `
                        -Property @{
                            ssids                           = 'FakeStringValue'
                            dnsSearchDomains                = 'FakeStringValue'
                            probeUrl                        = 'FakeStringValue'
                            action                          = 'ignore'
                            domainAction                    = 'neverConnect'
                            domains                         = 'FakeStringValue'
                            probeRequiredUrl                = 'FakeStringValue'
                            interfaceTypeMatch              = 'notConfigured'
                            dnsServerAddressMatch           = 'FakeStringValue'
                        } -ClientOnly)
                    )  
                    targetedMobileApps                    = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_targetedMobileApps `
                        -Property @{
                            name                            = 'FakeStringValue'
                            publisher                       = 'FakeStringValue'
                            appStoreUrl                     = 'FakeStringValue'
                            appId                           = 'FakeStringValue'
                        } -ClientOnly)
                    )  
                    safariDomains                           = @{}
                    associatedDomains                       = @{}
                    excludedDomains                         = @{}
                    excludeList                             = @{}
                    Ensure                                  = 'Present'
                    Credential                              = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                   return  @{
                        DisplayName                                 = 'FakeStringValue'
                        Description                                 = 'FakeStringValue'
                        AdditionalProperties                        = @{
                            '@odata.type'                           = '#microsoft.graph.iosVpnConfiguration'
                            authenticationMethod                    = 'usernameAndPassword'
                            connectionName                          = 'FakeStringValue'
                            connectionType                          = 'ciscoAnyConnectV2'
                            enableSplitTunneling                    = $False
                            enablePerApp                            = $False
                            optInToDeviceIdSharing                  = $True
                            proxyServer                             = @(
                                @{
                                    port                            = 80
                                    automaticConfigurationScriptUrl = 'https://www.test.com'
                                    address                         = 'proxy.test.com'
                                }
                            )
                            server                                  = @(
                                @{
                                    isDefaultServer                 = $True
                                    description                     = 'server'
                                    address                         = 'vpn.test.com'
                                }
                            )
                            customData                              = @(
                                @{
                                    key                             = 'FakeStringValue'
                                    value                           = 'FakeStringValue'
                                }
                            )
                            customKeyValueData                      = @(
                                @{
                                    name                            = 'FakeStringValue'
                                    value                           = 'FakeStringValue'
                                }
                            )
                            onDemandRules                           = @(
                                @{
                                    ssids                           = 'FakeStringValue'
                                    dnsSearchDomains                = 'FakeStringValue'
                                    probeUrl                        = 'FakeStringValue'
                                    action                          = 'ignore'
                                    domainAction                    = 'neverConnect'
                                    domains                         = 'FakeStringValue'
                                    probeRequiredUrl                = 'FakeStringValue'
                                    interfaceTypeMatch              = 'notConfigured'
                                    dnsServerAddressMatch           = 'FakeStringValue'
                                }
                            )
                            targetedMobileApps                    = @(
                                @{
                                    name                            = 'FakeStringValue'
                                    publisher                       = 'FakeStringValue'
                                    appStoreUrl                     = 'FakeStringValue'
                                    appId                           = 'FakeStringValue'
                                }
                            )
                            safariDomains                           = @{}
                            associatedDomains                       = @{}
                            excludedDomains                         = @{}
                            excludeList                             = @{}
                        }
                    }
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'When the policy exists and it SHOULD NOT' -Fixture {
            BeforeAll {
                $testParams = @{
                    DisplayName                             = 'FakeStringValue'
                    Description                             = 'FakeStringValue'
                    authenticationMethod                    = 'usernameAndPassword'
                    connectionName                          = 'FakeStringValue'
                    connectionType                          = 'ciscoAnyConnectV2'
                    enableSplitTunneling                    = $False
                    enablePerApp                            = $False
                    optInToDeviceIdSharing                  = $True
                    proxyServer                             = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftvpnProxyServer `
                        -Property @{
                            port = 80
                            automaticConfigurationScriptUrl = 'https://www.test.com'
                            address                         = 'proxy.test.com'
                        } -ClientOnly)
                    )
                    server                                  = [CimInstance[]]@(
                        (New-CimInstance `
                        -ClassName MSFT_MicrosoftGraphvpnServer `
                        -Property @{
                            isDefaultServer                 = $True
                            description                     = 'server'
                            address                         = 'vpn.test.com'
                        } -ClientOnly)
                    )
                    Ensure                                  = 'Absent'
                    Credential                              = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                   return @{
                        DisplayName                                  = 'FakeStringValue'
                        Description                                  = 'FakeStringValue'
                        AdditionalProperties                         = @{
                            '@odata.type'                           = '#microsoft.graph.iosVpnConfiguration'
                            authenticationMethod                     = 'usernameAndPassword'
                            connectionName                           = 'FakeStringValue'
                            connectionType                           = 'ciscoAnyConnectV2'
                            enableSplitTunneling                     = $False
                            enablePerApp                             = $False
                            optInToDeviceIdSharing                   = $True
                            proxyServer                              = @(
                                @{
                                    port                             = 80
                                    automaticConfigurationScriptUrl  = 'https://www.test.com'
                                    address                          = 'proxy.test.com'
                                }
                            )
                            server                                   = @(
                                @{
                                    isDefaultServer                  = $True
                                    description                      = 'server'
                                    address                          = 'vpn.test.com'
                                }
                            )
                        }
                    }
                }
            }

            It 'Should return Present from the Get method' {
                    (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should remove the IntuneVPNConfigurationPolicyIOS from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgBetaDeviceManagementDeviceConfiguration -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgBetaDeviceManagementDeviceConfiguration -MockWith {
                   return @{
                        DisplayName                                 = 'FakeStringValue'
                        Description                                 = 'FakeStringValue'
                        AdditionalProperties                        = @{
                            '@odata.type'                           = '#microsoft.graph.iosVpnConfiguration'
                            authenticationMethod                    = 'usernameAndPassword'
                            connectionName                          = 'FakeStringValue'
                            connectionType                          = 'ciscoAnyConnectV2'
                            enableSplitTunneling                    = $False
                            enablePerApp                            = $False
                            optInToDeviceIdSharing                  = $True
                            proxyServer                             = @(
                                @{
                                    port                            = 80
                                    automaticConfigurationScriptUrl = 'https://www.test.com'
                                    address                         = 'proxy.test.com'
                                }
                            )
                            server                                  = @(
                                @{
                                    isDefaultServer                 = $True
                                    description                     = 'server'
                                    address                         = 'vpn.test.com'
                                }
                            )
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