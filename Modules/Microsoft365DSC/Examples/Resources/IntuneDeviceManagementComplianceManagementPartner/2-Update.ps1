<#
This example updates an existing Device Management Compliance Management Partner.
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
        IntuneDeviceManagementComplianceManagementPartner '6b43c039-c1d0-4a9f-aab9-48c5531acbd6'
        {
            AndroidEnrollmentAssignments = @(
                MSFT_IntunecomplianceManagementPartnerAssignment @{
                    Target = MSFT_IntunedeviceAndAppManagementAssignmentTarget @{
                        DeviceAndAppManagementAssignmentFilterId = "FakeStringValue"
                        GroupId = '11111111-2222-2222-2222-111111111111'
                        CollectionId = '22222222-2222-2222-2222-222222222222'
                        odataType = "#microsoft.graph.allDevicesAssignmentTarget"
                        DeviceAndAppManagementAssignmentFilterType = "none"
                    }
                }
            )
            AndroidOnboarded      = $True
            DisplayName           = "3rdPartyPartnerAndroidManagement"
            PartnerState          = "enabled"
            Ensure                = "Present"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint;
        }
