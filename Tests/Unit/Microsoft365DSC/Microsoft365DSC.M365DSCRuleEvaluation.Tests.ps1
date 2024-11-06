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
    -DscResource 'M365DSCRuleEvaluation' -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString (New-Guid | Out-String) -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false

            Mock -CommandName MSFT_AADConditionalAccessPolicy\Export-TargetResource -MockWith {
                return "AADConditionalAccessPolicy 'FakeItem1'{`r`n    DisplayName='test';State = 'Enabled'`r`n}`r`nAADConditionalAccessPolicy 'FakeItem2'{`r`n    DisplayName='test';State = 'Disabled'`r`n}"
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return 'Credentials'
            }
        }

        # Test contexts
        Context -Name 'The Rules are successfully evaluated.' -Fixture {
            BeforeAll {
                $testParams = @{
                    ResourceTypeName    = 'AADConditionalAccessPolicy'
                    RuleDefinition      = "`$_.State -eq 'Enabled'"
                    AfterRuleCountQuery = '-eq 1'
                    Credential          = $Credential
                }
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name 'The Rules are NOT successfully evaluated.' -Fixture {
            BeforeAll {
                $testParams = @{
                    ResourceTypeName    = 'AADConditionalAccessPolicy'
                    RuleDefinition      = "`$_.State -eq 'Enabled'"
                    Credential          = $Credential
                }
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
