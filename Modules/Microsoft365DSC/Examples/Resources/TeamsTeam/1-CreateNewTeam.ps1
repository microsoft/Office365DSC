<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
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
        TeamsTeam 'ConfigureTeam'
        {
            DisplayName                       = 'Sample3'
            Description                       = 'Sample'
            Visibility                        = 'Private'
            MailNickName                      = 'DSCTeam2'
            AllowUserEditMessages             = $false
            AllowUserDeleteMessages           = $false
            AllowOwnerDeleteMessages          = $false
            AllowTeamMentions                 = $false
            AllowChannelMentions              = $false
            allowCreateUpdateChannels         = $false
            AllowDeleteChannels               = $false
            AllowAddRemoveApps                = $false
            AllowCreateUpdateRemoveTabs       = $false
            AllowCreateUpdateRemoveConnectors = $false
            AllowGiphy                        = $True
            GiphyContentRating                = 'strict'
            AllowStickersAndMemes             = $True
            AllowCustomMemes                  = $True
            AllowGuestCreateUpdateChannels    = $true
            AllowGuestDeleteChannels          = $true
            Ensure                            = 'Present'
            ApplicationId                     = $ApplicationId
            TenantId                          = $TenantId
            CertificateThumbprint             = $CertificateThumbprint
        }
    }
}
