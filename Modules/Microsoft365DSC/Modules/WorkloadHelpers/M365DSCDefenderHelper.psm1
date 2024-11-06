function Invoke-M365DSCDefenderREST
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $Uri,

        [Parameter()]
        [System.String]
        $Method = 'GET',

        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    $bodyJSON = ConvertTo-Json $Body -Depth 10 -Compress
    $headers = @{
        Authorization = $Global:MSCloudLoginConnectionProfile.DefenderForEndpoint.AccessToken
        "Content-Type" = "application/json"
    }
    $response = Invoke-WebRequest -Method $Method `
                                  -Uri $Uri `
                                  -Headers $headers `
                                  -Body $bodyJSON
    $result = ConvertFrom-Json $response.Content
    return $result
}
