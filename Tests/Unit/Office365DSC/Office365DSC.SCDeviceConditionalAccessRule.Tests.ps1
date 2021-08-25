[CmdletBinding()]
param(
    [Parameter()]
    [string]
    $CmdletModule = (Join-Path -Path $PSScriptRoot `
            -ChildPath "..\Stubs\Office365.psm1" `
            -Resolve)
)
$GenericStubPath = (Join-Path -Path $PSScriptRoot `
    -ChildPath "..\Stubs\Generic.psm1" `
    -Resolve)
Import-Module -Name (Join-Path -Path $PSScriptRoot `
        -ChildPath "..\UnitTestHelper.psm1" `
        -Resolve)

$Global:DscHelper = New-O365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource "SCDeviceConditionalAccessRule" -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        $secpasswd = ConvertTo-SecureString "test@password1" -AsPlainText -Force
        $GlobalAdminAccount = New-Object System.Management.Automation.PSCredential ("tenantadmin", $secpasswd)

        Mock -CommandName Test-MSCloudLogin -MockWith {

        }

        Mock -CommandName Import-PSSession -MockWith {

        }

        Mock -CommandName New-PSSession -MockWith {

        }

        Mock -CommandName Remove-DeviceConditionalAccessRule -MockWith {
            # This mock should not return anything. Remove-* are normally void methods without any return types
        }

        Mock -CommandName Set-DeviceConditionalAccessRule -MockWith {

        }

        Mock -CommandName New-DeviceConditionalAccessRule -MockWith {
            return @{
                # This mock can simply return an empty object for the purpose of these tests.
            }
        }

        # Test contexts
        Context -Name "The Device Conditional Access Rule doesn't already exist and it should" -Fixture {
            $testParams = @{
                Name                  = "TestRule"
                Policy                = "TestPolicy"
                AllowConvenienceLogon = $true
                AllowJailbroken       = $true
                AllowVoiceAssistant   = $true
                BluetoothEnabled      = $true
                PasswordMinimumLength = 6
                GlobalAdminAccount    = $GlobalAdminAccount
                Ensure                = "Present"
            }

            Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                return $null # Policy Not found, therefore return null
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should Be $false
            }

            It 'Should return Absent from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should Be "Absent"
            }

            It "Should call the Set method" {
                Set-TargetResource @testParams

                # Because the policy was not found, the set method should attempt to create it;
                # Therefore we want to assess that the New-* method was called exactly once;
                Assert-MockCalled -CommandName 'New-DeviceConditionalAccessRule' -Exactly 1
            }
        }

        Context -Name "The Device Conditional Access Rule already exists and it is already in the Desired State" -Fixture {
            $testParams = @{
                Name                  = "TestRule"
                Policy                = "TestPolicy"
                AllowConvenienceLogon = $true
                AllowJailbroken       = $true
                AllowVoiceAssistant   = $true
                BluetoothEnabled      = $true
                PasswordMinimumLength = 6
                GlobalAdminAccount    = $GlobalAdminAccount
                Ensure                = "Present"
            }

            Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                return @{
                    Name                  = "TestRule"
                    Policy                = "12345-12345-12345-12345-12345"
                    AllowConvenienceLogon = $true
                    AllowJailbroken       = $true
                    AllowVoiceAssistant   = $true
                    BluetoothEnabled      = $true
                    PasswordMinimumLength = 6
                }
            }

            Mock -CommandName Get-DeviceConditionalAccessPolicy -MockWith {
                return @{
                    Name     = "TestPolicy"
                    Identity = "12345-12345-12345-12345-12345"
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should Be $true
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should Be "Present"
            }
        }

        Context -Name "The Device Conditional Access Rule already exists and it is NOT in the Desired State" -Fixture {
            $testParams = @{
                Name                  = "TestRule"
                Policy                = "TestPolicy"
                AllowConvenienceLogon = $true
                AllowJailbroken       = $true
                AllowVoiceAssistant   = $true
                BluetoothEnabled      = $true
                PasswordMinimumLength = 6
                Ensure                = 'Present'
                GlobalAdminAccount    = $GlobalAdminAccount
            }

            Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                return @{
                    Name                  = "TestRule"
                    Policy                = "12345-12345-12345-12345-12345"
                    # Returns a drift in the comments property because it needs to not be in desired state
                    AllowConvenienceLogon = $false
                    AllowJailbroken       = $false
                    AllowVoiceAssistant   = $false
                    BluetoothEnabled      = $false
                    PasswordMinimumLength = 9
                }
            }

            Mock -CommandName Get-DeviceConditionalAccessPolicy -MockWith {
                return @{
                    Name     = "TestPolicy"
                    Identity = "12345-12345-12345-12345-12345"
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should Be "Present"
            }
            It 'Should update the policy in the Set method' {
                Set-TargetResource @testParams
                Assert-MockCalled -CommandName "Set-DeviceConditionalAccessRule" -Exactly 1
            }
        }

        Context -Name "The Device Conditional Access Rule Exists but it Should NOT" -Fixture {
            $testParams = @{
                Name                  = "TestRule"
                Policy                = "TestPolicy"
                AllowConvenienceLogon = $true
                AllowJailbroken       = $true
                AllowVoiceAssistant   = $true
                BluetoothEnabled      = $true
                PasswordMinimumLength = 6
                Ensure                = 'Absent'
                GlobalAdminAccount    = $GlobalAdminAccount
            }

            Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                return @{
                    Name              = "TestRule"
                    Policy            = "12345-12345-12345-12345-12345"
                    Disabled          = $true
                }
            }

            Mock -CommandName Get-DeviceConditionalAccessPolicy -MockWith {
                return @{
                    Name     = "TestPolicy"
                    Identity = "12345-12345-12345-12345-12345"
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should Be $false
            }

            It 'Should return Present from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should Be "Present"
            }

            It 'Should Delete from the Set method' {
                Set-TargetResource @testParams
            # Because the policy was not found, the set method should attempt to delete it;
            # Therefore we want to assess that the Remove-* method was called exactly once;
                Assert-MockCalled -CommandName 'Remove-DeviceConditionalAccessRule' -Exactly 1
            }


        }

        Context -Name "ReverseDSC Tests" -Fixture {
            $testParams = @{
                GlobalAdminAccount = $GlobalAdminAccount
            }

            $testRule1 = @{
                Name              = "TestRule1"
                Policy            = "12345-12345-12345-12345-12345"
                Disabled          = $true
            }

            $testRule2 = @{
                Name              = "TestRule2"
                Policy            = "12345-12345-12345-12345-12345"
                Disabled          = $true
            }

            Mock -CommandName Get-DeviceConditionalAccessPolicy -MockWith {
                return @{
                    Name    = 'TestPolicy'
                    Identity = "12345-12345-12345-12345-12345"
                }
            }

            It "Should Reverse Engineer resource from the Export method when single" {
                Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                    return $testRule1
                }

                $exported = Export-TargetResource @testParams
                ([regex]::Matches($exported, " SCDeviceConditionalAccessRule " )).Count | Should Be 1
                $exported.Contains("TestRule1") | Should Be $true
            }

            It "Should Reverse Engineer resource from the Export method when multiple" {
                Mock -CommandName Get-DeviceConditionalAccessRule -MockWith {
                    return @($testRule1, $testRule2)
                }

                $exported = Export-TargetResource @testParams
                ([regex]::Matches($exported, " SCDeviceConditionalAccessRule " )).Count | Should Be 2
                $exported.Contains("TestRule1") | Should Be $true
                $exported.Contains("TestRule2") | Should Be $true
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
