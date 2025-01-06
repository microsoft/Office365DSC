<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param
    (
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $credsGlobalAdmin
    )

    Import-DscResource -ModuleName Microsoft365DSC

    Node localhost
    {
        ExoMailboxStatistics "ExoMailboxStatistics-Adele Vance"
        {
            ApplicationId                              = $ConfigurationData.NonNodeData.ApplicationId;
            AssociatedItemCount                        = 86;
            AttachmentTableAvailableSize               = 0.25;
            AttachmentTableTotalSize                   = 4.56;
            CertificateThumbprint                      = $ConfigurationData.NonNodeData.CertificateThumbprint;
            DatabaseIssueWarningQuota                  = 1945;
            DatabaseName                               = "NAMPR11DG329-db080";
            DatabaseProhibitSendQuota                  = 2048;
            DatabaseProhibitSendReceiveQuota           = 2355;
            DeletedItemCount                           = 16;
            DisplayName                                = "Adele Vance";
            DumpsterMessagesPerFolderCountReceiveQuota = 3000000;
            DumpsterMessagesPerFolderCountWarningQuota = 2750000;
            Ensure                                     = "Present";
            ExternalDirectoryOrganizationId            = "f4e8115b-2acf-4c30-8d0a-8e5268c8174c";
            FolderHierarchyChildrenCountReceiveQuota   = 10000;
            FolderHierarchyChildrenCountWarningQuota   = 9000;
            FolderHierarchyDepthReceiveQuota           = 300;
            FolderHierarchyDepthWarningQuota           = 250;
            FoldersCountReceiveQuota                   = 250000;
            FoldersCountWarningQuota                   = 200000;
            IsAbandonedMoveDestination                 = $False;
            IsArchiveMailbox                           = $False;
            IsDatabaseCopyActive                       = $True;
            IsHighDensityShard                         = $False;
            IsMoveDestination                          = $False;
            IsQuarantined                              = $False;
            ItemCount                                  = 463;
            LastLogoffTime                             = "2023-11-01 3:05:02 PM";
            LastLogonTime                              = "2023-11-01 2:54:59 PM";
            LegacyDN                                   = "/o=ExchangeLabs/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=1fb25a9426e94b1d911f42361f133074-AdeleV";
            MailboxGuid                                = "00de9d65-ce46-4a2d-afca-73c2800d27ed";
            MailboxMessagesPerFolderCountReceiveQuota  = 1000000;
            MailboxMessagesPerFolderCountWarningQuota  = 900000;
            MailboxType                                = "Private";
            MailboxTypeDetail                          = "UserMailbox";
            MessageTableAvailableSize                  = 9.97;
            MessageTableTotalSize                      = 29.81;
            NamedPropertiesCountQuota                  = 16384;
            NeedsToMove                                = "None";
            OtherTablesAvailableSize                   = 0.56;
            OtherTablesTotalSize                       = 14.28;
            OwnerADGuid                                = "303f52c6-5943-4edb-a110-a99796365f61";
            QuarantineClients                          = "";
            ResourceUsageRollingAvgDatabaseReads       = 0;
            ResourceUsageRollingAvgRop                 = 0;
            ResourceUsageRollingClientTypes            = 2313161359686242346;
            ServerName                                 = "CH0PR11MB5249";
            SystemMessageCount                         = 2629;
            SystemMessageSize                          = 11.45;
            SystemMessageSizeShutoffQuota              = 51200;
            SystemMessageSizeWarningQuota              = 50176;
            TenantId                                   = $OrganizationName;
            TotalDeletedItemSize                       = 0.09;
            TotalItemSize                              = 23.39;
        }
    }
}
