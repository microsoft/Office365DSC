<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
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
        DefenderDeviceAuthenticatedScanDefinition "DefenderDeviceAuthenticatedScanDefinition-MyScan"
        {
            ApplicationId            = $ApplicationId;
            CertificateThumbprint    = $CertificateThumbprint;
            Ensure                   = "Present";
            IntervalInHours          = 1;
            IsActive                 = $True;
            Name                     = "MyScan";
            ScanAuthenticationParams = MSFT_DefenderDeviceAuthenticatedScanDefinitionAuthenticationParams{
                Type = 'NoAuthNoPriv'
                DataType = '#microsoft.windowsDefenderATP.api.SnmpAuthParams'
            };
            ScannerAgent             = MSFT_DefenderDeviceAuthenticatedScanDefinitionScanAgent{
                machineId = '55c636a37ff1a21a3241437eb6ce15881xxxxxx'
                machineName = 'WIN-XXXXXXXXXX'
                id = 'c819dc6d-f9fe-4d05-8022-88a34766442d_55c636a37ff1a21a3241437eb6ce15881xxxxxxx'
            };
            ScanType                 = "Network";
            Target                   = "172.1.12.1";
            TenantId                 = $TenantId;
        }
    }
}
