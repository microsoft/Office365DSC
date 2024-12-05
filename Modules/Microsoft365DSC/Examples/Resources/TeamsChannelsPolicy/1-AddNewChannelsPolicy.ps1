<#
This example adds a new Teams Channels Policy.
#>

Configuration Example
{
    param
    (
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        TeamsChannelsPolicy 'ConfigureChannelsPolicy'
        {
            Identity                                      = 'New Channels Policy'
            Description                                   = 'This is an example'
            AllowChannelSharingToExternalUser             = $True
            AllowOrgWideTeamCreation                      = $True
            EnablePrivateTeamDiscovery                    = $True
            AllowPrivateChannelCreation                   = $True
            AllowSharedChannelCreation                    = $True
            AllowUserToParticipateInExternalSharedChannel = $True
            Ensure                                        = 'Present'
            ApplicationId                                 = $ApplicationId
            TenantId                                      = $TenantId
            CertificateThumbprint                         = $CertificateThumbprint
        }
    }
}
