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
  -DscResource 'PPTenantSettings' -GenericStubModule $GenericStubPath

Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
  InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
    Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

    BeforeAll {
      $secpasswd = ConvertTo-SecureString 'test@password1' -AsPlainText -Force
      $GlobalAdminAccount = New-Object System.Management.Automation.PSCredential ('tenantadmin', $secpasswd)

      Mock -CommandName Update-M365DSCExportAuthenticationResults -MockWith {
        return @{}
      }

      Mock -CommandName Get-M365DSCExportContentForResource -MockWith {

      }

      Mock -CommandName New-M365DSCConnection -MockWith {
        return 'Credential'
      }
    }

    # Test contexts
    Context -Name 'PP Tenant settings are not configured' -Fixture {
      BeforeAll {
        $testParams = @{
          IsSingleInstance                               = 'Yes'
          WalkMeOptOut                                   = $false
          DisableNPSCommentsReachout                     = $false
          DisableNewsletterSendout                       = $false
          DisableEnvironmentCreationByNonAdminUsers      = $false
          DisablePortalsCreationByNonAdminUsers          = $false
          DisableSurveyFeedback                          = $false
          DisableTrialEnvironmentCreationByNonAdminUsers = $false
          DisableCapacityAllocationByEnvironmentAdmins   = $false
          DisableSupportTicketsVisibleByAllUsers         = $false
          DisableDocsSearch                              = $false
          DisableCommunitySearch                         = $false
          DisableBingVideoSearch                         = $false
          DisableShareWithEveryone                       = $false
          EnableGuestsToMake                             = $false
          ShareWithColleaguesUserLimit                   = 10000
          GlobalAdminAccount                             = $GlobalAdminAccount
        }

        Mock -CommandName Set-TenantSettings -MockWith {
          return @{
            TenantSettings = @{
              WalkMeOptOut                                   = $testParams.WalkMeOptOut
              DisableNPSCommentsReachout                     = $testParams.DisableNPSCommentsReachout
              DisableNewsletterSendout                       = $testParams.DisableNewsletterSendout
              DisableEnvironmentCreationByNonAdminUsers      = $testParams.DisableEnvironmentCreationByNonAdminUsers
              DisablePortalsCreationByNonAdminUsers          = $testParams.DisablePortalsCreationByNonAdminUsers
              DisableSurveyFeedback                          = $testParams.DisableSurveyFeedback
              DisableTrialEnvironmentCreationByNonAdminUsers = $testParams.DisableTrialEnvironmentCreationByNonAdminUsers
              DisableCapacityAllocationByEnvironmentAdmins   = $testParams.DisableCapacityAllocationByEnvironmentAdmins
              DisableSupportTicketsVisibleByAllUsers         = $testParams.DisableSupportTicketsVisibleByAllUsers
              powerPlatform                                  = @(
                @{
                  search = @{
                    DisableDocsSearch      = $testParams.DisableDocsSearch
                    DisableCommunitySearch = $testParams.DisableCommunitySearch
                    DisableBingVideoSearch = $testParams.DisableBingVideoSearch
                  }
                },
                @{
                  powerApps = @{
                    DisableShareWithEveryone = $testParams.DisableShareWithEveryone
                    EnableGuestsToMake       = $testParams.EnableGuestsToMake
                  }
                },
                @{
                  teamsIntegration = @{
                    ShareWithColleaguesUserLimit = $testParams.ShareWithColleaguesUserLimit
                  }
                }
              )
            }
          }

          Mock -CommandName Get-TenantSettings -MockWith {
            return @{
              TenantSettings = @{
                WalkMeOptOut                                   = $testParams.WalkMeOptOut
                DisableNPSCommentsReachout                     = $testParams.DisableNPSCommentsReachout
                DisableNewsletterSendout                       = $testParams.DisableNewsletterSendout
                DisableEnvironmentCreationByNonAdminUsers      = $testParams.DisableEnvironmentCreationByNonAdminUsers
                DisablePortalsCreationByNonAdminUsers          = $testParams.DisablePortalsCreationByNonAdminUsers
                DisableSurveyFeedback                          = $testParams.DisableSurveyFeedback
                DisableTrialEnvironmentCreationByNonAdminUsers = $testParams.DisableTrialEnvironmentCreationByNonAdminUsers
                DisableCapacityAllocationByEnvironmentAdmins   = $testParams.DisableCapacityAllocationByEnvironmentAdmins
                DisableSupportTicketsVisibleByAllUsers         = $testParams.DisableSupportTicketsVisibleByAllUsers
                powerPlatform                                  = @(
                  @{
                    search = @{
                      DisableDocsSearch      = $testParams.DisableDocsSearch
                      DisableCommunitySearch = $testParams.DisableCommunitySearch
                      DisableBingVideoSearch = $testParams.DisableBingVideoSearch
                    }
                  },
                  @{
                    powerApps = @{
                      DisableShareWithEveryone = $testParams.DisableShareWithEveryone
                      EnableGuestsToMake       = $testParams.EnableGuestsToMake
                    }
                  },
                  @{
                    teamsIntegration = @{
                      ShareWithColleaguesUserLimit = $testParams.ShareWithColleaguesUserLimit
                    }
                  }
                )
              }
            }
          }
        }

        It 'Should return false from the Test method' {
          Test-TargetResource @testParams | Should -Be $false
        }

        It 'Sets the tenant settings in Set method' {
          Set-TargetResource @testParams
        }
      }
    }

    Context -Name 'ReverseDSC Tests' -Fixture {
      BeforeAll {
        $testParams = @{
          GlobalAdminAccount = $GlobalAdminAccount
        }

        Mock -CommandName Get-TenantSettings -MockWith {
          return @{
            TenantSettings = @{
              WalkMeOptOut                                   = $testParams.WalkMeOptOut
              DisableNPSCommentsReachout                     = $testParams.DisableNPSCommentsReachout
              DisableNewsletterSendout                       = $testParams.DisableNewsletterSendout
              DisableEnvironmentCreationByNonAdminUsers      = $testParams.DisableEnvironmentCreationByNonAdminUsers
              DisablePortalsCreationByNonAdminUsers          = $testParams.DisablePortalsCreationByNonAdminUsers
              DisableSurveyFeedback                          = $testParams.DisableSurveyFeedback
              DisableTrialEnvironmentCreationByNonAdminUsers = $testParams.DisableTrialEnvironmentCreationByNonAdminUsers
              DisableCapacityAllocationByEnvironmentAdmins   = $testParams.DisableCapacityAllocationByEnvironmentAdmins
              DisableSupportTicketsVisibleByAllUsers         = $testParams.DisableSupportTicketsVisibleByAllUsers
              powerPlatform                                  = @(
                @{
                  search = @{
                    DisableDocsSearch      = $testParams.DisableDocsSearch
                    DisableCommunitySearch = $testParams.DisableCommunitySearch
                    DisableBingVideoSearch = $testParams.DisableBingVideoSearch
                  }
                },
                @{
                  powerApps = @{
                    DisableShareWithEveryone = $testParams.DisableShareWithEveryone
                    EnableGuestsToMake       = $testParams.EnableGuestsToMake
                  }
                },
                @{
                  teamsIntegration = @{
                    ShareWithColleaguesUserLimit = $testParams.ShareWithColleaguesUserLimit
                  }
                }
              )
            }
          }
        }
      }

      It 'Should Reverse Engineer resource from the Export method' {
        Export-TargetResource @testParams
      }
    }
  }#inmodulescope
}#describe

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
