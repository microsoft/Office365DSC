<#
This example demonstrates how to assign users to a Teams Upgrade Policy.
#>

Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credscredential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        TeamsUpgradePolicy 'ConfigureIslandsPolicy'
        {
            Identity               = 'Islands'
            MigrateMeetingsToTeams = $true
            Credential             = $Credscredential
        }
    }
}
