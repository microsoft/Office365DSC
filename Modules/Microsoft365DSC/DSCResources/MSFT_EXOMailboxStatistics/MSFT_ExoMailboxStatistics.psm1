function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        ########################
        #Minimum property set
        ########################
        [Parameter()]
        [System.String]
        $DeletedItemCount,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $ItemCount,

        [Parameter()]
        [System.String]
        $MailboxGuid,

        [Parameter()]
        [System.String]
        $TotalDeletedItemSize,

        [Parameter()]
        [System.String]
        $TotalItemSize,

        ########################
        #All property set
        ########################
        [Parameter()]
        [System.String]
        $AssociatedItemCount,

        [Parameter()]
        [System.String]
        $AttachmentTableAvailableSize,

        [Parameter()]
        [System.String]
        $AttachmentTableTotalSize,

        [Parameter()]
        [System.String]
        $DatabaseIssueWarningQuota,

        [Parameter()]
        [System.String]
        $DatabaseName,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendQuota,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendReceiveQuota,

        [Parameter()]
        [System.String]
        $DisconnectDate,

        [Parameter()]
        [System.String]
        $DisconnectReason,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $ExternalDirectoryOrganizationId,

        [Parameter()]
        [System.String]
        $FastIsEnabled,
        
        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountWarningQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthWarningQuota,

        [Parameter()]
        [System.String]
        $FoldersCountReceiveQuota,
        
        [Parameter()]
        [System.String]
        $FoldersCountWarningQuota,

        [Parameter()]
        [System.String]
        $IsAbandonedMoveDestination,

        [Parameter()]
        [System.String]
        $IsArchiveMailbox,

        [Parameter()]
        [System.String]
        $IsDatabaseCopyActive,

        [Parameter()]
        [System.String]
        $IsHighDensityShard,

        [Parameter()]
        [System.String]
        $IsMoveDestination,

        [Parameter()]
        [System.String]
        $IsQuarantined,

        [Parameter()]
        [System.String]
        $LastLoggedOnUserAccount,

        [Parameter()]
        [System.String]
        $LastLogoffTime,

        [Parameter()]
        [System.String]
        $LastLogonTime,

        [Parameter()]
        [System.String]
        $LegacyDN,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $MailboxType,

        [Parameter()]
        [System.String]
        $MailboxTypeDetail,

        [Parameter()]
        [System.String]
        $MessageTableAvailableSize,

        [Parameter()]
        [System.String]
        $MessageTableTotalSize,

        [Parameter()]
        [System.String]
        $NamedPropertiesCountQuota,

        [Parameter()]
        [System.String]
        $NeedsToMove,

        [Parameter()]
        [System.String]
        $OtherTablesAvailableSize,

        [Parameter()]
        [System.String]
        $OtherTablesTotalSize,

        [Parameter()]
        [System.String]
        $OwnerADGuid,

        [Parameter()]
        [System.String]
        $QuarantineClients,

        [Parameter()]
        [System.String]
        $QuarantineDescription,

        [Parameter()]
        [System.String]
        $QuarantineEnd,

        [Parameter()]
        [System.String]
        $QuarantineFileVersion,

        [Parameter()]
        [System.String]
        $QuarantineLastCrash,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgDatabaseReads,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgRop,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingClientTypes,

        [Parameter()]
        [System.String]
        $ServerName,

        [Parameter()]
        [System.String]
        $StorageLimitStatus,

        [Parameter()]
        [System.String]
        $SystemMessageCount,

        [Parameter()]
        [System.String]
        $SystemMessageSize,

        [Parameter()]
        [System.String]
        $SystemMessageSizeShutoffQuota,

        [Parameter()]
        [System.String]
        $SystemMessageSizeWarningQuota,

        ########################
        #Common parameters  
        ########################
        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    Write-Verbose -Message "Getting configuration of Office 365 Mailbox Statistics $DisplayName"
    if ($Script:ExportMode)
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters `
            -SkipModuleReload $true
    }
    else
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
            -InboundParameters $PSBoundParameters
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = 'Absent'

    try
    {

        if ($null -ne $Script:MailboxStatistics -and $Script:ExportMode)
        {
            $mailboxStatistic = $Script:MailboxStatistics | Where-Object -FilterScript {$_.DisplayName -eq $DisplayName} 
        }
        else
        {
            #Could include a switch for the different propertySets to retrieve https://learn.microsoft.com/en-us/powershell/exchange/cmdlet-property-sets?view=exchange-ps#get-exomailbox-property-sets
            #Could include a switch for the different recipientTypeDetails to retrieve
            $mailboxStatistic = Get-EXOMailbox -Identity $DisplayName `
                                               -RecipientTypeDetails 'RoomMailbox,SharedMailbox,UserMailbox' `
                                               -ErrorAction Stop `
                                               | Get-EXOMailboxStatistics -PropertySets All
        }

        if ($null -eq $mailboxStatistic)
        {
            Write-Verbose -Message "The specified Mailbox Statistic doesn't already exist."
            return $nullReturn
        }

        $result = @{
            AssociatedItemCount                         = $mailboxStatistic.AssociatedItemCount
            AttachmentTableAvailableSize                = [math]::Round(($mailboxStatistic.AttachmentTableAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            AttachmentTableTotalSize                    = [math]::Round(($mailboxStatistic.AttachmentTableTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            DatabaseIssueWarningQuota                   = [math]::Round(($mailboxStatistic.DatabaseIssueWarningQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            DatabaseName                                = $mailboxStatistic.DatabaseName
            DatabaseProhibitSendQuota                   = [math]::Round(($mailboxStatistic.DatabaseProhibitSendQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            DatabaseProhibitSendReceiveQuota            = [math]::Round(($mailboxStatistic.DatabaseProhibitSendReceiveQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            DeletedItemCount                            = $mailboxStatistic.DeletedItemCount
            DisconnectDate                              = $mailboxStatistic.DisconnectDate
            DisconnectReason                            = $mailboxStatistic.DisconnectReason
            DisplayName                                 = $mailboxStatistic.DisplayName
            DumpsterMessagesPerFolderCountReceiveQuota  = $mailboxStatistic.DumpsterMessagesPerFolderCountReceiveQuota
            DumpsterMessagesPerFolderCountWarningQuota  = $mailboxStatistic.DumpsterMessagesPerFolderCountWarningQuota
            ExternalDirectoryOrganizationId             = $mailboxStatistic.ExternalDirectoryOrganizationId
            FastIsEnabled                               = $mailboxStatistic.FastIsEnabled
            FolderHierarchyChildrenCountReceiveQuota    = $mailboxStatistic.FolderHierarchyChildrenCountReceiveQuota
            FolderHierarchyChildrenCountWarningQuota    = $mailboxStatistic.FolderHierarchyChildrenCountWarningQuota
            FolderHierarchyDepthReceiveQuota            = $mailboxStatistic.FolderHierarchyDepthReceiveQuota
            FolderHierarchyDepthWarningQuota            = $mailboxStatistic.FolderHierarchyDepthWarningQuota
            FoldersCountReceiveQuota                    = $mailboxStatistic.FoldersCountReceiveQuota
            FoldersCountWarningQuota                    = $mailboxStatistic.FoldersCountWarningQuota
            IsAbandonedMoveDestination                  = $mailboxStatistic.IsAbandonedMoveDestination
            IsArchiveMailbox                            = $mailboxStatistic.IsArchiveMailbox
            IsDatabaseCopyActive                        = $mailboxStatistic.IsDatabaseCopyActive
            IsHighDensityShard                          = $mailboxStatistic.IsHighDensityShard
            IsMoveDestination                           = $mailboxStatistic.IsMoveDestination
            IsQuarantined                               = $mailboxStatistic.IsQuarantined
            ItemCount                                   = $mailboxStatistic.ItemCount
            LastLoggedOnUserAccount                     = $mailboxStatistic.LastLoggedOnUserAccount
            LastLogoffTime                              = $mailboxStatistic.LastLogoffTime
            LastLogonTime                               = $mailboxStatistic.LastLogonTime
            LegacyDN                                    = $mailboxStatistic.LegacyDN
            MailboxGuid                                 = $mailboxStatistic.MailboxGuid
            MailboxMessagesPerFolderCountReceiveQuota   = $mailboxStatistic.MailboxMessagesPerFolderCountReceiveQuota
            MailboxMessagesPerFolderCountWarningQuota   = $mailboxStatistic.MailboxMessagesPerFolderCountWarningQuota
            MailboxType                                 = $mailboxStatistic.MailboxType
            MailboxTypeDetail                           = $mailboxStatistic.MailboxTypeDetail
            MessageTableAvailableSize                   = [math]::Round(($mailboxStatistic.MessageTableAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            MessageTableTotalSize                       = [math]::Round(($mailboxStatistic.MessageTableTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            NamedPropertiesCountQuota                   = $mailboxStatistic.NamedPropertiesCountQuota
            NeedsToMove                                 = $mailboxStatistic.NeedsToMove
            OtherTablesAvailableSize                    = [math]::Round(($mailboxStatistic.OtherTablesAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            OtherTablesTotalSize                        = [math]::Round(($mailboxStatistic.OtherTablesTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            OwnerADGuid                                 = $mailboxStatistic.OwnerADGuid
            QuarantineClients                           = $mailboxStatistic.QuarantineClients
            QuarantineDescription                       = $mailboxStatistic.QuarantineDescription
            QuarantineEnd                               = $mailboxStatistic.QuarantineEnd
            QuarantineFileVersion                       = $mailboxStatistic.QuarantineFileVersion
            QuarantineLastCrash                         = $mailboxStatistic.QuarantineLastCrash
            ResourceUsageRollingAvgDatabaseReads        = $mailboxStatistic.ResourceUsageRollingAvgDatabaseReads
            ResourceUsageRollingAvgRop                  = $mailboxStatistic.ResourceUsageRollingAvgRop
            ResourceUsageRollingClientTypes             = $mailboxStatistic.ResourceUsageRollingClientTypes
            ServerName                                  = $mailboxStatistic.ServerName
            StorageLimitStatus                          = $mailboxStatistic.StorageLimitStatus
            SystemMessageCount                          = $mailboxStatistic.SystemMessageCount
            SystemMessageSize                           = [math]::Round(($mailboxStatistic.SystemMessageSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            SystemMessageSizeShutoffQuota               = [math]::Round(($mailboxStatistic.SystemMessageSizeShutoffQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            SystemMessageSizeWarningQuota               = [math]::Round(($mailboxStatistic.SystemMessageSizeWarningQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            TotalDeletedItemSize                        = [math]::Round(($mailboxStatistic.TotalDeletedItemSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
            TotalItemSize                               = [math]::Round(($mailboxStatistic.TotalItemSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
 
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            CertificateThumbprint = $CertificateThumbprint
            CertificatePath       = $CertificatePath
            CertificatePassword   = $CertificatePassword
            Managedidentity       = $ManagedIdentity.IsPresent
            TenantId              = $TenantId
        }

        Write-Verbose -Message "Found an existing instance of Mailbox Statistics '$($DisplayName)'"
        return $result
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullReturn
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        ########################
        #Minimum property set
        ########################
        [Parameter()]
        [System.String]
        $DeletedItemCount,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $ItemCount,

        [Parameter()]
        [System.String]
        $MailboxGuid,

        [Parameter()]
        [System.String]
        $TotalDeletedItemSize,

        [Parameter()]
        [System.String]
        $TotalItemSize,

        ########################
        #All property set
        ########################
        [Parameter()]
        [System.String]
        $AssociatedItemCount,

        [Parameter()]
        [System.String]
        $AttachmentTableAvailableSize,

        [Parameter()]
        [System.String]
        $AttachmentTableTotalSize,

        [Parameter()]
        [System.String]
        $DatabaseIssueWarningQuota,

        [Parameter()]
        [System.String]
        $DatabaseName,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendQuota,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendReceiveQuota,

        [Parameter()]
        [System.String]
        $DisconnectDate,

        [Parameter()]
        [System.String]
        $DisconnectReason,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $ExternalDirectoryOrganizationId,

        [Parameter()]
        [System.String]
        $FastIsEnabled,
        
        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountWarningQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthWarningQuota,

        [Parameter()]
        [System.String]
        $FoldersCountReceiveQuota,
        
        [Parameter()]
        [System.String]
        $FoldersCountWarningQuota,

        [Parameter()]
        [System.String]
        $IsAbandonedMoveDestination,

        [Parameter()]
        [System.String]
        $IsArchiveMailbox,

        [Parameter()]
        [System.String]
        $IsDatabaseCopyActive,

        [Parameter()]
        [System.String]
        $IsHighDensityShard,

        [Parameter()]
        [System.String]
        $IsMoveDestination,

        [Parameter()]
        [System.String]
        $IsQuarantined,

        [Parameter()]
        [System.String]
        $LastLoggedOnUserAccount,

        [Parameter()]
        [System.String]
        $LastLogoffTime,

        [Parameter()]
        [System.String]
        $LastLogonTime,

        [Parameter()]
        [System.String]
        $LegacyDN,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $MailboxType,

        [Parameter()]
        [System.String]
        $MailboxTypeDetail,

        [Parameter()]
        [System.String]
        $MessageTableAvailableSize,

        [Parameter()]
        [System.String]
        $MessageTableTotalSize,

        [Parameter()]
        [System.String]
        $NamedPropertiesCountQuota,

        [Parameter()]
        [System.String]
        $NeedsToMove,

        [Parameter()]
        [System.String]
        $OtherTablesAvailableSize,

        [Parameter()]
        [System.String]
        $OtherTablesTotalSize,

        [Parameter()]
        [System.String]
        $OwnerADGuid,

        [Parameter()]
        [System.String]
        $QuarantineClients,

        [Parameter()]
        [System.String]
        $QuarantineDescription,

        [Parameter()]
        [System.String]
        $QuarantineEnd,

        [Parameter()]
        [System.String]
        $QuarantineFileVersion,

        [Parameter()]
        [System.String]
        $QuarantineLastCrash,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgDatabaseReads,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgRop,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingClientTypes,

        [Parameter()]
        [System.String]
        $ServerName,

        [Parameter()]
        [System.String]
        $StorageLimitStatus,

        [Parameter()]
        [System.String]
        $SystemMessageCount,

        [Parameter()]
        [System.String]
        $SystemMessageSize,

        [Parameter()]
        [System.String]
        $SystemMessageSizeShutoffQuota,

        [Parameter()]
        [System.String]
        $SystemMessageSizeWarningQuota,

        ########################
        #Common parameters  
        ########################
        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    throw 'Updating Mailbox Statistics is not supported.'
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        ########################
        #Minimum property set
        ########################
        [Parameter()]
        [System.String]
        $DeletedItemCount,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $ItemCount,

        [Parameter()]
        [System.String]
        $MailboxGuid,

        [Parameter()]
        [System.String]
        $TotalDeletedItemSize,

        [Parameter()]
        [System.String]
        $TotalItemSize,

        ########################
        #All property set
        ########################
        [Parameter()]
        [System.String]
        $AssociatedItemCount,

        [Parameter()]
        [System.String]
        $AttachmentTableAvailableSize,

        [Parameter()]
        [System.String]
        $AttachmentTableTotalSize,

        [Parameter()]
        [System.String]
        $DatabaseIssueWarningQuota,

        [Parameter()]
        [System.String]
        $DatabaseName,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendQuota,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendReceiveQuota,

        [Parameter()]
        [System.String]
        $DisconnectDate,

        [Parameter()]
        [System.String]
        $DisconnectReason,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $ExternalDirectoryOrganizationId,

        [Parameter()]
        [System.String]
        $FastIsEnabled,
        
        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountWarningQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthWarningQuota,

        [Parameter()]
        [System.String]
        $FoldersCountReceiveQuota,
        
        [Parameter()]
        [System.String]
        $FoldersCountWarningQuota,

        [Parameter()]
        [System.String]
        $IsAbandonedMoveDestination,

        [Parameter()]
        [System.String]
        $IsArchiveMailbox,

        [Parameter()]
        [System.String]
        $IsDatabaseCopyActive,

        [Parameter()]
        [System.String]
        $IsHighDensityShard,

        [Parameter()]
        [System.String]
        $IsMoveDestination,

        [Parameter()]
        [System.String]
        $IsQuarantined,

        [Parameter()]
        [System.String]
        $LastLoggedOnUserAccount,

        [Parameter()]
        [System.String]
        $LastLogoffTime,

        [Parameter()]
        [System.String]
        $LastLogonTime,

        [Parameter()]
        [System.String]
        $LegacyDN,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $MailboxType,

        [Parameter()]
        [System.String]
        $MailboxTypeDetail,

        [Parameter()]
        [System.String]
        $MessageTableAvailableSize,

        [Parameter()]
        [System.String]
        $MessageTableTotalSize,

        [Parameter()]
        [System.String]
        $NamedPropertiesCountQuota,

        [Parameter()]
        [System.String]
        $NeedsToMove,

        [Parameter()]
        [System.String]
        $OtherTablesAvailableSize,

        [Parameter()]
        [System.String]
        $OtherTablesTotalSize,

        [Parameter()]
        [System.String]
        $OwnerADGuid,

        [Parameter()]
        [System.String]
        $QuarantineClients,

        [Parameter()]
        [System.String]
        $QuarantineDescription,

        [Parameter()]
        [System.String]
        $QuarantineEnd,

        [Parameter()]
        [System.String]
        $QuarantineFileVersion,

        [Parameter()]
        [System.String]
        $QuarantineLastCrash,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgDatabaseReads,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgRop,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingClientTypes,

        [Parameter()]
        [System.String]
        $ServerName,

        [Parameter()]
        [System.String]
        $StorageLimitStatus,

        [Parameter()]
        [System.String]
        $SystemMessageCount,

        [Parameter()]
        [System.String]
        $SystemMessageSize,

        [Parameter()]
        [System.String]
        $SystemMessageSizeShutoffQuota,

        [Parameter()]
        [System.String]
        $SystemMessageSizeWarningQuota,

        ########################
        #Common parameters  
        ########################
        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of Office 365 Mailbox Statistics $DisplayName"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @('Ensure', `
            'DisplayName')

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
        param
    (
        ########################
        #Minimum property set
        ########################
        [Parameter()]
        [System.String]
        $DeletedItemCount,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $ItemCount,

        [Parameter()]
        [System.String]
        $MailboxGuid,

        [Parameter()]
        [System.String]
        $TotalDeletedItemSize,

        [Parameter()]
        [System.String]
        $TotalItemSize,

        ########################
        #All property set
        ########################
        [Parameter()]
        [System.String]
        $AssociatedItemCount,

        [Parameter()]
        [System.String]
        $AttachmentTableAvailableSize,

        [Parameter()]
        [System.String]
        $AttachmentTableTotalSize,

        [Parameter()]
        [System.String]
        $DatabaseIssueWarningQuota,

        [Parameter()]
        [System.String]
        $DatabaseName,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendQuota,

        [Parameter()]
        [System.String]
        $DatabaseProhibitSendReceiveQuota,

        [Parameter()]
        [System.String]
        $DisconnectDate,

        [Parameter()]
        [System.String]
        $DisconnectReason,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $DumpsterMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $ExternalDirectoryOrganizationId,

        [Parameter()]
        [System.String]
        $FastIsEnabled,
        
        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyChildrenCountWarningQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthReceiveQuota,

        [Parameter()]
        [System.String]
        $FolderHierarchyDepthWarningQuota,

        [Parameter()]
        [System.String]
        $FoldersCountReceiveQuota,
        
        [Parameter()]
        [System.String]
        $FoldersCountWarningQuota,

        [Parameter()]
        [System.String]
        $IsAbandonedMoveDestination,

        [Parameter()]
        [System.String]
        $IsArchiveMailbox,

        [Parameter()]
        [System.String]
        $IsDatabaseCopyActive,

        [Parameter()]
        [System.String]
        $IsHighDensityShard,

        [Parameter()]
        [System.String]
        $IsMoveDestination,

        [Parameter()]
        [System.String]
        $IsQuarantined,

        [Parameter()]
        [System.String]
        $LastLoggedOnUserAccount,

        [Parameter()]
        [System.String]
        $LastLogoffTime,

        [Parameter()]
        [System.String]
        $LastLogonTime,

        [Parameter()]
        [System.String]
        $LegacyDN,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountReceiveQuota,

        [Parameter()]
        [System.String]
        $MailboxMessagesPerFolderCountWarningQuota,

        [Parameter()]
        [System.String]
        $MailboxType,

        [Parameter()]
        [System.String]
        $MailboxTypeDetail,

        [Parameter()]
        [System.String]
        $MessageTableAvailableSize,

        [Parameter()]
        [System.String]
        $MessageTableTotalSize,

        [Parameter()]
        [System.String]
        $NamedPropertiesCountQuota,

        [Parameter()]
        [System.String]
        $NeedsToMove,

        [Parameter()]
        [System.String]
        $OtherTablesAvailableSize,

        [Parameter()]
        [System.String]
        $OtherTablesTotalSize,

        [Parameter()]
        [System.String]
        $OwnerADGuid,

        [Parameter()]
        [System.String]
        $QuarantineClients,

        [Parameter()]
        [System.String]
        $QuarantineDescription,

        [Parameter()]
        [System.String]
        $QuarantineEnd,

        [Parameter()]
        [System.String]
        $QuarantineFileVersion,

        [Parameter()]
        [System.String]
        $QuarantineLastCrash,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgDatabaseReads,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingAvgRop,

        [Parameter()]
        [System.String]
        $ResourceUsageRollingClientTypes,

        [Parameter()]
        [System.String]
        $ServerName,

        [Parameter()]
        [System.String]
        $StorageLimitStatus,

        [Parameter()]
        [System.String]
        $SystemMessageCount,

        [Parameter()]
        [System.String]
        $SystemMessageSize,

        [Parameter()]
        [System.String]
        $SystemMessageSizeShutoffQuota,

        [Parameter()]
        [System.String]
        $SystemMessageSizeWarningQuota,

        ########################
        #Common parameters  
        ########################
        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'ExchangeOnline' `
        -InboundParameters $PSBoundParameters `
        -SkipModuleReload $true

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace 'MSFT_', ''
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        $Script:ExportMode = $true

        [array]$Script:MailboxStatistics = Get-EXOMailbox -ResultSize Unlimited -RecipientTypeDetails 'RoomMailbox,SharedMailbox,UserMailbox' | Get-EXOMailboxStatistics -PropertySets All
        
        $dscContent = ''
        $i = 1
        if ($MailboxStatistics.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($mailboxStatistic in $MailboxStatistics)
        {
            Write-Host "    |---[$i/$($mailboxStatistics.Length)] $($mailboxStatistic.DisplayName)" -NoNewline
            $mailboxStatisticDisplayName = $mailboxStatistic.DisplayName
            if ($mailboxStatisticDisplayName)
            {
                $params = @{
                    AssociatedItemCount                         = $mailboxStatistic.AssociatedItemCount
                    AttachmentTableAvailableSize                = [math]::Round(($mailboxStatistic.AttachmentTableAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    AttachmentTableTotalSize                    = [math]::Round(($mailboxStatistic.AttachmentTableTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    DatabaseIssueWarningQuota                   = [math]::Round(($mailboxStatistic.DatabaseIssueWarningQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    DatabaseName                                = $mailboxStatistic.DatabaseName
                    DatabaseProhibitSendQuota                   = [math]::Round(($mailboxStatistic.DatabaseProhibitSendQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    DatabaseProhibitSendReceiveQuota            = [math]::Round(($mailboxStatistic.DatabaseProhibitSendReceiveQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    DeletedItemCount                            = $mailboxStatistic.DeletedItemCount
                    DisconnectDate                              = $mailboxStatistic.DisconnectDate
                    DisconnectReason                            = $mailboxStatistic.DisconnectReason
                    DisplayName                                 = $mailboxStatistic.DisplayName
                    DumpsterMessagesPerFolderCountReceiveQuota  = $mailboxStatistic.DumpsterMessagesPerFolderCountReceiveQuota
                    DumpsterMessagesPerFolderCountWarningQuota  = $mailboxStatistic.DumpsterMessagesPerFolderCountWarningQuota
                    ExternalDirectoryOrganizationId             = $mailboxStatistic.ExternalDirectoryOrganizationId
                    FastIsEnabled                               = $mailboxStatistic.FastIsEnabled
                    FolderHierarchyChildrenCountReceiveQuota    = $mailboxStatistic.FolderHierarchyChildrenCountReceiveQuota
                    FolderHierarchyChildrenCountWarningQuota    = $mailboxStatistic.FolderHierarchyChildrenCountWarningQuota
                    FolderHierarchyDepthReceiveQuota            = $mailboxStatistic.FolderHierarchyDepthReceiveQuota
                    FolderHierarchyDepthWarningQuota            = $mailboxStatistic.FolderHierarchyDepthWarningQuota
                    FoldersCountReceiveQuota                    = $mailboxStatistic.FoldersCountReceiveQuota
                    FoldersCountWarningQuota                    = $mailboxStatistic.FoldersCountWarningQuota
                    IsAbandonedMoveDestination                  = $mailboxStatistic.IsAbandonedMoveDestination
                    IsArchiveMailbox                            = $mailboxStatistic.IsArchiveMailbox
                    IsDatabaseCopyActive                        = $mailboxStatistic.IsDatabaseCopyActive
                    IsHighDensityShard                          = $mailboxStatistic.IsHighDensityShard
                    IsMoveDestination                           = $mailboxStatistic.IsMoveDestination
                    IsQuarantined                               = $mailboxStatistic.IsQuarantined
                    ItemCount                                   = $mailboxStatistic.ItemCount
                    LastLoggedOnUserAccount                     = $mailboxStatistic.LastLoggedOnUserAccount
                    LastLogoffTime                              = $mailboxStatistic.LastLogoffTime
                    LastLogonTime                               = $mailboxStatistic.LastLogonTime
                    LegacyDN                                    = $mailboxStatistic.LegacyDN
                    MailboxGuid                                 = $mailboxStatistic.MailboxGuid
                    MailboxMessagesPerFolderCountReceiveQuota   = $mailboxStatistic.MailboxMessagesPerFolderCountReceiveQuota
                    MailboxMessagesPerFolderCountWarningQuota   = $mailboxStatistic.MailboxMessagesPerFolderCountWarningQuota
                    MailboxType                                 = $mailboxStatistic.MailboxType
                    MailboxTypeDetail                           = $mailboxStatistic.MailboxTypeDetail
                    MessageTableAvailableSize                   = [math]::Round(($mailboxStatistic.MessageTableAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    MessageTableTotalSize                       = [math]::Round(($mailboxStatistic.MessageTableTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    NamedPropertiesCountQuota                   = $mailboxStatistic.NamedPropertiesCountQuota
                    NeedsToMove                                 = $mailboxStatistic.NeedsToMove
                    OtherTablesAvailableSize                    = [math]::Round(($mailboxStatistic.OtherTablesAvailableSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    OtherTablesTotalSize                        = [math]::Round(($mailboxStatistic.OtherTablesTotalSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    OwnerADGuid                                 = $mailboxStatistic.OwnerADGuid
                    QuarantineClients                           = $mailboxStatistic.QuarantineClients
                    QuarantineDescription                       = $mailboxStatistic.QuarantineDescription
                    QuarantineEnd                               = $mailboxStatistic.QuarantineEnd
                    QuarantineFileVersion                       = $mailboxStatistic.QuarantineFileVersion
                    QuarantineLastCrash                         = $mailboxStatistic.QuarantineLastCrash
                    ResourceUsageRollingAvgDatabaseReads        = $mailboxStatistic.ResourceUsageRollingAvgDatabaseReads
                    ResourceUsageRollingAvgRop                  = $mailboxStatistic.ResourceUsageRollingAvgRop
                    ResourceUsageRollingClientTypes             = $mailboxStatistic.ResourceUsageRollingClientTypes
                    ServerName                                  = $mailboxStatistic.ServerName
                    StorageLimitStatus                          = $mailboxStatistic.StorageLimitStatus
                    SystemMessageCount                          = $mailboxStatistic.SystemMessageCount
                    SystemMessageSize                           = [math]::Round(($mailboxStatistic.SystemMessageSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    SystemMessageSizeShutoffQuota               = [math]::Round(($mailboxStatistic.SystemMessageSizeShutoffQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    SystemMessageSizeWarningQuota               = [math]::Round(($mailboxStatistic.SystemMessageSizeWarningQuota.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    TotalDeletedItemSize                        = [math]::Round(($mailboxStatistic.TotalDeletedItemSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
                    TotalItemSize                               = [math]::Round(($mailboxStatistic.TotalItemSize.ToString().Split('(')[1].Split(' ')[0].Replace(',','')/1MB),2)
        
                    Ensure                = 'Present'
                    Credential            = $Credential
                    ApplicationId         = $ApplicationId
                    CertificateThumbprint = $CertificateThumbprint
                    CertificatePath       = $CertificatePath
                    CertificatePassword   = $CertificatePassword
                    Managedidentity       = $ManagedIdentity.IsPresent
                    TenantId              = $TenantId
                }

                $Results = Get-TargetResource @Params

                if ($Results -is [System.Collections.Hashtable] -and $Results.Count -gt 1)
                {
                    $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                        -Results $Results
                    $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                        -ConnectionMode $ConnectionMode `
                        -ModulePath $PSScriptRoot `
                        -Results $Results `
                        -Credential $Credential
                    $dscContent += $currentDSCBlock

                    Save-M365DSCPartialExport -Content $currentDSCBlock `
                        -FileName $Global:PartialExportFileName

                    Write-Host $Global:M365DSCEmojiGreenCheckMark
                }
                else
                {
                    Write-Host $Global:M365DSCEmojiRedX
                }

                $i++
            }
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

Export-ModuleMember -Function *-TargetResource
