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

    Configuration Master
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
        $Domain = $TenantId
        Node Localhost
        {
                IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicy 'My Account Protection LAPS Policy'
                {
                    DisplayName              = "Account Protection LAPS Policy";
                    Description              = "My revised description";
                    Ensure                   = "Present";
                    Assignments              = @(
                        MSFT_IntuneAccountProtectionLocalAdministratorPasswordSolutionPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    BackupDirectory          = "1";
                    PasswordAgeDays_AAD      = 10;
                    AdministratorAccountName = "Administrator";
                    PasswordAgeDays          = 20;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAccountProtectionLocalUserGroupMembershipPolicy 'My Account Protection Local User Group Membership Policy'
                {
                    DisplayName              = "Account Protection LUGM Policy";
                    Description              = "My revised description";
                    Ensure                   = "Present";
                    Assignments              = @(
                        MSFT_IntuneAccountProtectionLocalUserGroupMembershipPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    LocalUserGroupCollection = @(
                        MSFT_IntuneAccountProtectionLocalUserGroupCollection{
                            LocalGroups = @('administrators', 'users')
                            Members = @('S-1-12-1-1167842105-1150511762-402702254-1917434032')
                            Action = 'add_update'
                            UserSelectionType = 'users'
                        }
                    );
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAccountProtectionPolicy 'myAccountProtectionPolicy'
                {
                    DisplayName                                            = 'test'
                    deviceGuardLocalSystemAuthorityCredentialGuardSettings = "notConfigured"
                    WindowsHelloForBusinessBlocked                         = $false
                    PinMinimumLength                                       = 5
                    PinSpecialCharactersUsage                              = 'required'
                    Ensure                                                 = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAccountProtectionPolicyWindows10 'myAccountProtectionPolicy'
                {
                    DisplayName           = 'test'
                    DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneAccountProtectionPolicyWindows10
                    {
                        History = 10
                        EnablePinRecovery = 'true'
                    }
                    UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneAccountProtectionPolicyWindows10
                    {
                        History = 20
                        EnablePinRecovery = 'true'
                    }
                    Ensure                = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAntivirusPolicyWindows10SettingCatalog 'myAVWindows10Policy'
                {
                    DisplayName        = 'av exclusions'
                    Assignments        = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        })
                    Description        = ''
                    excludedextensions = @('.exe')
                    excludedpaths      = @('c:\folders\', 'c:\folders2\')
                    excludedprocesses  = @('processes.exe', 'process2.exe')
                    templateId         = '45fea5e9-280d-4da1-9792-fb5736da0ca9_1'
                    Ensure             = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAppAndBrowserIsolationPolicyWindows10 'ConfigureAppAndBrowserIsolationPolicyWindows10'
                {
                    Assignments              = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '11111111-1111-1111-1111-111111111111'
                        }
                    );
                    AllowCameraMicrophoneRedirection       = "1";
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    ClipboardFileType                      = "1";
                    ClipboardSettings                      = "0";
                    Description                            = 'Description'
                    DisplayName                            = "App and Browser Isolation";
                    Ensure                                 = "Present";
                    Id                                     = '00000000-0000-0000-0000-000000000000'
                    InstallWindowsDefenderApplicationGuard = "install";
                    SaveFilesToHost                        = "0";
                    RoleScopeTagIds                        = @("0");
                    ApplicationId                          = $ApplicationId;
                    TenantId                               = $TenantId;
                    CertificateThumbprint                  = $CertificateThumbprint;
                }
                IntuneAppAndBrowserIsolationPolicyWindows10ConfigMgr 'ConfigureAppAndBrowserIsolationPolicyWindows10ConfigMgr'
                {
                    Assignments              = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '11111111-1111-1111-1111-111111111111'
                        }
                    );
                    AllowCameraMicrophoneRedirection       = "1";
                    AllowPersistence                       = "0";
                    AllowVirtualGPU                        = "0";
                    AllowWindowsDefenderApplicationGuard   = "1";
                    ClipboardFileType                      = "1";
                    ClipboardSettings                      = "0";
                    Description                            = 'Description'
                    DisplayName                            = "App and Browser Isolation";
                    Ensure                                 = "Present";
                    Id                                     = '00000000-0000-0000-0000-000000000000'
                    InstallWindowsDefenderApplicationGuard = "install";
                    SaveFilesToHost                        = "0";
                    RoleScopeTagIds                        = @("0");
                    ApplicationId                          = $ApplicationId;
                    TenantId                               = $TenantId;
                    CertificateThumbprint                  = $CertificateThumbprint;
                }
                IntuneAppCategory 'IntuneAppCategory-Data Management'
                {
                    Id                   = "a1fc9fe2-728d-4867-9a72-a61e18f8c606";
                    DisplayName          = "Custom Data Management";
                    Ensure               = "Present";
                }
                IntuneAppConfigurationDevicePolicy 'IntuneAppConfigurationDevicePolicy-Example'
                {
                    Assignments           = @();
                    Description           = "";
                    DisplayName           = "Example";
                    Ensure                = "Present";
                    Id                    = "0000000-0000-0000-0000-000000000000";
                    ConnectedAppsEnabled  = $true;
                    PackageId             = "app:com.microsoft.office.outlook"
                    PayloadJson           = "Base64 encoded settings"
                    PermissionActions     = @()
                    ProfileApplicability  = "default"
                    RoleScopeTagIds       = @("0");
                    TargetedMobileApps    = @("<Mobile App Id>");
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAppConfigurationPolicy 'AddAppConfigPolicy'
                {
                    DisplayName          = 'ContosoNew'
                    Description          = 'New Contoso Policy'
                    CustomSettings       = @(
                        MSFT_IntuneAppConfigurationPolicyCustomSetting {
                            name  = 'com.microsoft.intune.mam.managedbrowser.BlockListURLs'
                            value = 'https://www.aol.com'
                        }
                        MSFT_IntuneAppConfigurationPolicyCustomSetting {
                            name  = 'com.microsoft.intune.mam.managedbrowser.bookmarks'
                            value = 'Outlook Web|https://outlook.office.com||Bing|https://www.bing.com'
                        }
                        MSFT_IntuneAppConfigurationPolicyCustomSetting {
                            name  = 'Test'
                            value = 'TestValue'
                        });
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAppleMDMPushNotificationCertificate 'IntuneAppleMDMPushNotificationCertificate-66f4ec83-754f-4a59-a73d-e3182cc636a5'
                {
                    AppleIdentifier          = "Apple ID";
        	        Certificate 	         = "FakeCertMIIFdjCCBF6gAwIBAgIIMVIk4qQ3QnQwDQYJKoZIhvcNAQELBQAwgYwxQDA+BgNVBAMMN0FwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIDIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0yNDEwMjUxODE0NThaFw0yNTEwMjUxODE0NTdaMIGPMUwwSgYKCZImiZPyLGQBAQw8Y29tLmFwcGxlLm1nbXQuRXh0ZXJuYWwuMDA1NWU3ZTktNDkyYi00ZDQ2LTk2N2EtMjhmYzVkNDllZGI2MTIwMAYDVQQDDClBUFNQOjAwNTVlN2U5LTQ5MmItNGQ0Ni05NjdhLTI4ZmM1ZDQ5ZWRiNjELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrEk6ojXS2lXZCW0P6Wtkv36ko7E1pDlu90IbKN+tesevGhghARFrGNJaRnCjjh7m430KMx2HmwuH08VHpevne2ANdSBOgbVD/8tbkfLN4GeO7Z+E0O5WvEKJ0h0IloV4PjhfZm367n7WDBGmAEXp/aUU91TDIGvAlwUB6M/s7WDypfKenpU7VI7BBNHOn/LwaeNyyTsr8/bn+D7CRDPb6UBYPc5wyQoEjgEjByprUB4qkICfjjvDqg0S+x/gkk4U6QDhjFcUb439EpUyUhbYFH/Opjq5uJ22xueTX3FLQII6ZFoPcC/NJLpwdEDGOOHEHb62ahrwTxzYNGoOG5v/NAgMBAAGjggHVMIIB0TAJBgNVHRMEAjAAMB8GA1UdIwQYMBaAFPe+fCFgkds9G3vYOjKBad+ebH+bMIIBHAYDVR0gBIIBEzCCAQ8wggELBgkqhkiG92NkBQEwgf0wgcMGCCsGAQUFBwICMIG2DIGzUmVsaWFuY2Ugb24gdGhpcyBjZXJ0aWZpY2F0ZSBieSBhbnkgcGFydHkgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIHRoZSB0aGVuIGFwcGxpY2FibGUgc3RhbmRhcmQgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgdXNlLCBjZXJ0aWZpY2F0ZSBwb2xpY3kgYW5kIGNlcnRpZmljYXRpb24gcHJhY3RpY2Ugc3RhdGVtZW50cy4wNQYIKwYBBQUHAgEWKWh0dHA6Ly93d3cuYXBwbGUuY29tL2NlcnRpZmljYXRlYXV0aG9yaXR5MBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuYXBwbGUuY29tL2FhaTJjYS5jcmwwHQYDVR0OBBYEFE1pV3J04vJkpwqxzg040WR6U/7IMAsGA1UdDwQEAwIHgDAQBgoqhkiG92NkBgMCBAIFADANBgkqhkiG9w0BAQsFAAOCAQEAPVKFj5stCpsUT+lcC36hzR2wh8/fys/QFNFuFn57x4oe9kBvvyAXqLBhPm/J3lC+0oU/AJf3EYXwTGNxo2gCiPhJcomX3WXnbYrZHU/TH8umhtVgGqd6Xlke9iFwypidHC9dHWmwud4V42oAMZ9FHItSwh5o6rQMoZop7uKD72vxSuunEWFymF9S22DJ0oums1Ya8JmUpNfMzkyGVMMZs1OCYpzQxYpuwC+sMAVfGucp1IRLutccRGYeSV4LTN4CwfWreCPnPGjkBEmGqmusn5t/THirGjRBykUARWFpthx1wmJqHFqeAv4nhbcR/+Fu4gQQQaayX0dauBcU0T57==";
                    DataSharingConsetGranted = $True;
        
                    Ensure                   = "Present";
                    ApplicationId            = $ApplicationId;
                    TenantId                 = $TenantId;
                    CertificateThumbprint    = $CertificateThumbprint;
                }
                IntuneApplicationControlPolicyWindows10 'ConfigureApplicationControlPolicyWindows10'
                {
                    DisplayName                      = 'Windows 10 Desktops'
                    Description                      = 'All windows 10 Desktops'
                    AppLockerApplicationControl      = 'enforceComponentsAndStoreApps'
                    SmartScreenBlockOverrideForFiles = $True
                    SmartScreenEnableInShell         = $True
                    Ensure                           = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAppProtectionPolicyAndroid 'ConfigureAppProtectionPolicyAndroid'
                {
                    DisplayName                             = 'My DSC Android App Protection Policy'
                    AllowedDataStorageLocations             = @('sharePoint')
                    AllowedInboundDataTransferSources       = 'managedApps'
                    AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
                    AllowedOutboundDataTransferDestinations = 'managedApps'
                    Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
                    ContactSyncBlocked                      = $false
                    DataBackupBlocked                       = $false
                    Description                             = ''
                    DeviceComplianceRequired                = $True
                    DisableAppPinIfDevicePinIsSet           = $True
                    FingerprintBlocked                      = $False
                    ManagedBrowserToOpenLinksRequired       = $True
                    MaximumPinRetries                       = 5
                    MinimumPinLength                        = 4
                    OrganizationalCredentialsRequired       = $false
                    PinRequired                             = $True
                    PrintBlocked                            = $True
                    SaveAsBlocked                           = $True
                    SimplePinBlocked                        = $True
                    Ensure                                  = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAppProtectionPolicyiOS 'MyCustomiOSPolicy'
                {
                    DisplayName                             = 'My DSC iOS App Protection Policy'
                    AllowedDataStorageLocations             = @('sharePoint')
                    AllowedInboundDataTransferSources       = 'managedApps'
                    AllowedOutboundClipboardSharingLevel    = 'managedAppsWithPasteIn'
                    AllowedOutboundDataTransferDestinations = 'managedApps'
                    AppDataEncryptionType                   = 'whenDeviceLocked'
                    Apps                                    = @('com.cisco.jabberimintune.ios', 'com.pervasent.boardpapers.ios', 'com.sharefile.mobile.intune.ios')
                    ContactSyncBlocked                      = $False
                    DataBackupBlocked                       = $False
                    Description                             = ''
                    DeviceComplianceRequired                = $True
                    FingerprintBlocked                      = $False
                    ManagedBrowserToOpenLinksRequired       = $True
                    MaximumPinRetries                       = 5
                    MinimumPinLength                        = 4
                    OrganizationalCredentialsRequired       = $False
                    PeriodOfflineBeforeAccessCheck          = 'PT12H'
                    PeriodOfflineBeforeWipeIsEnforced       = 'P90D'
                    PeriodOnlineBeforeAccessCheck           = 'PT30M'
                    PinCharacterSet                         = 'alphanumericAndSymbol'
                    PinRequired                             = $True
                    PrintBlocked                            = $False
                    SaveAsBlocked                           = $True
                    SimplePinBlocked                        = $False
                    Ensure                                  = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneASRRulesPolicyWindows10 'myASRRulesPolicy'
                {
                    DisplayName                                     = 'test'
                    AdditionalGuardedFolders                        = @()
                    AdobeReaderLaunchChildProcess                   = 'auditMode'
                    AdvancedRansomewareProtectionType               = 'enable'
                    Assignments                                     = @()
                    AttackSurfaceReductionExcludedPaths             = @('c:\Novo')
                    BlockPersistenceThroughWmiType                  = 'auditMode'
                    Description                                     = ''
                    EmailContentExecutionType                       = 'auditMode'
                    GuardedFoldersAllowedAppPaths                   = @()
                    GuardMyFoldersType                              = 'enable'
                    OfficeAppsExecutableContentCreationOrLaunchType = 'block'
                    OfficeAppsLaunchChildProcessType                = 'auditMode'
                    OfficeAppsOtherProcessInjectionType             = 'block'
                    OfficeCommunicationAppsLaunchChildProcess       = 'auditMode'
                    OfficeMacroCodeAllowWin32ImportsType            = 'block'
                    PreventCredentialStealingType                   = 'enable'
                    ProcessCreationType                             = 'block'
                    ScriptDownloadedPayloadExecutionType            = 'block'
                    ScriptObfuscatedMacroCodeType                   = 'block'
                    UntrustedExecutableType                         = 'block'
                    UntrustedUSBProcessType                         = 'block'
                    Ensure                                          = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneAttackSurfaceReductionRulesPolicyWindows10ConfigManager 'myASRReductionRules'
                {
                    DisplayName = 'asr ConfigMgr'
                    blockadobereaderfromcreatingchildprocesses = "block";
                    Description = 'My revised description'
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDerivedCredential 'IntuneDerivedCredential-K5'
                {
                    DisplayName          = "K5";
                    HelpUrl              = "http://www.ff.com/";
                    Id                   = "a409d85f-2a49-440d-884a-80fb52a557ab";
                    Issuer               = "purebred";
                    NotificationType     = "email";
                    Ensure               = "Present";
                }
                IntuneDeviceAndAppManagementAssignmentFilter 'AssignmentFilter'
                {
                    DisplayName = 'Test Device Filter'
                    Description = 'This is a new Filter'
                    Platform    = 'windows10AndLater'
                    Rule        = "(device.manufacturer -ne `"Microsoft Corporation`")"
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCategory 'ConfigureDeviceCategory'
                {
                    DisplayName = 'Contoso'
                    Description = 'Contoso Category'
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyAndroid 'AddDeviceCompliancePolicy'
                {
                    DisplayName                                        = 'Test Policy'
                    Description                                        = ''
                    DeviceThreatProtectionEnabled                      = $False
                    DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
                    osMinimumVersion                                   = '7'
                    PasswordExpirationDays                             = 90
                    PasswordMinimumLength                              = 6
                    PasswordMinutesOfInactivityBeforeLock              = 5
                    PasswordPreviousPasswordBlockCount                 = 10
                    PasswordRequired                                   = $True
                    PasswordRequiredType                               = 'deviceDefault'
                    SecurityBlockJailbrokenDevices                     = $False
                    SecurityDisableUsbDebugging                        = $False
                    SecurityPreventInstallAppsFromUnknownSources       = $False
                    SecurityRequireCompanyPortalAppIntegrity           = $False
                    SecurityRequireGooglePlayServices                  = $False
                    SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
                    SecurityRequireSafetyNetAttestationCertifiedDevice = $False
                    SecurityRequireUpToDateSecurityProviders           = $False
                    SecurityRequireVerifyApps                          = $False
                    StorageRequireEncryption                           = $True
                    Ensure                                             = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyAndroidDeviceOwner 'ConfigureAndroidDeviceCompliancePolicyOwner'
                {
                    DisplayName                                        = 'DeviceOwner'
                    Description                                        = ''
                    DeviceThreatProtectionEnabled                      = $False
                    DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
                    AdvancedThreatProtectionRequiredSecurityLevel      = 'unavailable'
                    SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
                    SecurityRequireSafetyNetAttestationCertifiedDevice = $False
                    OsMinimumVersion                                   = '10'
                    OsMaximumVersion                                   = '11'
                    PasswordRequired                                   = $True
                    PasswordMinimumLength                              = 6
                    PasswordRequiredType                               = 'numericComplex'
                    PasswordMinutesOfInactivityBeforeLock              = 5
                    PasswordExpirationDays                             = 90
                    PasswordPreviousPasswordCountToBlock               = 13
                    StorageRequireEncryption                           = $True
                    Ensure                                             = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyAndroidWorkProfile 'ConfigureAndroidDeviceCompliancePolicyWorkProfile'
                {
                    DisplayName                                        = 'Test Policy'
                    Description                                        = ''
                    DeviceThreatProtectionEnabled                      = $False
                    DeviceThreatProtectionRequiredSecurityLevel        = 'unavailable'
                    PasswordExpirationDays                             = 90
                    PasswordMinimumLength                              = 6
                    PasswordMinutesOfInactivityBeforeLock              = 5
                    PasswordRequired                                   = $True
                    PasswordRequiredType                               = 'numericComplex'
                    SecurityBlockJailbrokenDevices                     = $True
                    SecurityDisableUsbDebugging                        = $False
                    SecurityPreventInstallAppsFromUnknownSources       = $False
                    SecurityRequireCompanyPortalAppIntegrity           = $False
                    SecurityRequireGooglePlayServices                  = $False
                    SecurityRequireSafetyNetAttestationBasicIntegrity  = $False
                    SecurityRequireSafetyNetAttestationCertifiedDevice = $False
                    SecurityRequireUpToDateSecurityProviders           = $False
                    SecurityRequireVerifyApps                          = $False
                    StorageRequireEncryption                           = $True
                    Ensure                                             = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyiOs 'ConfigureDeviceCompliancePolicyiOS'
                {
                    DisplayName                                 = 'Test iOS Device Compliance Policy'
                    Description                                 = 'Test iOS Device Compliance Policy Description'
                    PasscodeBlockSimple                         = $True
                    PasscodeExpirationDays                      = 365
                    PasscodeMinimumLength                       = 6
                    PasscodeMinutesOfInactivityBeforeLock       = 5
                    PasscodePreviousPasscodeBlockCount          = 3
                    PasscodeMinimumCharacterSetCount            = 2
                    PasscodeRequiredType                        = 'numeric'
                    PasscodeRequired                            = $True
                    OsMinimumVersion                            = 10
                    OsMaximumVersion                            = 12
                    SecurityBlockJailbrokenDevices              = $True
                    DeviceThreatProtectionEnabled               = $True
                    DeviceThreatProtectionRequiredSecurityLevel = 'medium'
                    ManagedEmailProfileRequired                 = $True
                    Ensure                                      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyMacOS 'ConfigureDeviceCompliancePolicyMacOS'
                {
                    DisplayName                                 = 'MacOS DSC Policy'
                    Description                                 = 'Test policy'
                    PasswordRequired                            = $False
                    PasswordBlockSimple                         = $False
                    PasswordExpirationDays                      = 365
                    PasswordMinimumLength                       = 6
                    PasswordMinutesOfInactivityBeforeLock       = 5
                    PasswordPreviousPasswordBlockCount          = 13
                    PasswordMinimumCharacterSetCount            = 1
                    PasswordRequiredType                        = 'DeviceDefault'
                    OsMinimumVersion                            = 10
                    OsMaximumVersion                            = 13
                    SystemIntegrityProtectionEnabled            = $False
                    DeviceThreatProtectionEnabled               = $False
                    DeviceThreatProtectionRequiredSecurityLevel = 'Unavailable'
                    StorageRequireEncryption                    = $False
                    FirewallEnabled                             = $False
                    FirewallBlockAllIncoming                    = $False
                    FirewallEnableStealthMode                   = $False
                    Ensure                                      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceCompliancePolicyWindows10 'ConfigureDeviceCompliancePolicyWindows10'
                {
                    DisplayName                                 = 'Windows 10 DSC Policy'
                    Description                                 = 'Test policy'
                    PasswordRequired                            = $False
                    PasswordBlockSimple                         = $False
                    PasswordRequiredToUnlockFromIdle            = $True
                    PasswordMinutesOfInactivityBeforeLock       = 15
                    PasswordExpirationDays                      = 365
                    PasswordMinimumLength                       = 6
                    PasswordPreviousPasswordBlockCount          = 13
                    PasswordMinimumCharacterSetCount            = 1
                    PasswordRequiredType                        = 'Devicedefault'
                    RequireHealthyDeviceReport                  = $True
                    OsMinimumVersion                            = 10
                    OsMaximumVersion                            = 10.19
                    MobileOsMinimumVersion                      = 10
                    MobileOsMaximumVersion                      = 10.19
                    EarlyLaunchAntiMalwareDriverEnabled         = $False
                    BitLockerEnabled                            = $False
                    SecureBootEnabled                           = $True
                    CodeIntegrityEnabled                        = $True
                    StorageRequireEncryption                    = $True
                    ActiveFirewallRequired                      = $True
                    DefenderEnabled                             = $True
                    DefenderVersion                             = ''
                    SignatureOutOfDate                          = $True
                    RtpEnabled                                  = $True
                    AntivirusRequired                           = $True
                    AntiSpywareRequired                         = $True
                    DeviceThreatProtectionEnabled               = $True
                    DeviceThreatProtectionRequiredSecurityLevel = 'Medium'
                    ConfigurationManagerComplianceRequired      = $False
                    TPMRequired                                 = $False
                    deviceCompliancePolicyScript                = $null
                    ValidOperatingSystemBuildRanges             = @()
                    Ensure                                      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationAdministrativeTemplatePolicyWindows10 'Example'
                {
                    Assignments                      = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments
                        {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    DefinitionValues                 = @(
                        MSFT_IntuneGroupPolicyDefinitionValue
                        {
                            ConfigurationType = 'policy'
                            Id                = 'f41bbbec-0807-4ae3-8a61-5580a2f310f0'
                            Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                            {
                                Id           = '50b2626d-f092-4e71-8983-12a5c741ebe0'
                                DisplayName  = 'Do not display the lock screen'
                                CategoryPath = '\Control Panel\Personalization'
                                PolicyType   = 'admxBacked'
                                SupportedOn  = 'At least Windows Server 2012, Windows 8 or Windows RT'
                                ClassType    = 'machine'
                            }
                            Enabled           = $False
                        }
                        MSFT_IntuneGroupPolicyDefinitionValue
                        {
                            ConfigurationType  = 'policy'
                            PresentationValues = @(
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                                {
                                    presentationDefinitionId    = '98210829-af9b-4020-8d96-3e4108557a95'
                                    presentationDefinitionLabel = 'Types of extensions/apps that are allowed to be installed'
                                    KeyValuePairValues          = @(
                                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                        {
                                            Name = 'hosted_app'
                                        }
        
                                        MSFT_IntuneGroupPolicyDefinitionValuePresentationValueKeyValuePair
                                        {
                                            Name = 'user_script'
                                        }
                                    )
                                    Id                          = '7312a452-e087-4290-9b9f-3f14a304c18d'
                                    odataType                   = '#microsoft.graph.groupPolicyPresentationValueList'
                                }
                            )
                            Id                 = 'f3047f6a-550e-4b5e-b3da-48fc951b72fc'
                            Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                            {
                                Id           = '37ab8b81-47d7-46d8-8b99-81d9cecdcce9'
                                DisplayName  = 'Configure allowed app/extension types'
                                CategoryPath = '\Google\Google Chrome\Extensions'
                                PolicyType   = 'admxIngested'
                                SupportedOn  = 'Microsoft Windows 7 or later'
                                ClassType    = 'machine'
                            }
                            Enabled            = $True
                        }
                        MSFT_IntuneGroupPolicyDefinitionValue
                        {
                            ConfigurationType  = 'policy'
                            PresentationValues = @(
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                                {
                                    presentationDefinitionId    = 'a8a0ae11-58d9-41d5-b258-1c16d9f1e328'
                                    presentationDefinitionLabel = 'Password Length'
                                    DecimalValue                = 15
                                    Id                          = '14c48993-35af-4b77-a4f8-12de917b1bb9'
                                    odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                                }
        
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                                {
                                    presentationDefinitionId    = '98998e7f-cc2a-4d96-8c47-35dd4b2ce56b'
                                    presentationDefinitionLabel = 'Password Age (Days)'
                                    DecimalValue                = 30
                                    Id                          = '4d654df9-6826-470f-af4e-d37491663c76'
                                    odataType                   = '#microsoft.graph.groupPolicyPresentationValueDecimal'
                                }
        
                                MSFT_IntuneGroupPolicyDefinitionValuePresentationValue
                                {
                                    presentationDefinitionId    = '6900e752-4bc3-463b-9fc8-36d78c77bc3e'
                                    presentationDefinitionLabel = 'Password Complexity'
                                    StringValue                 = '4'
                                    Id                          = '17e2ff15-8573-4e7e-a6f9-64baebcb5312'
                                    odataType                   = '#microsoft.graph.groupPolicyPresentationValueText'
                                }
                            )
                            Id                 = '426c9e99-0084-443a-ae07-b8f40c11910f'
                            Definition         = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                            {
                                Id           = 'c4df131a-d415-44fc-9254-a717ff7dbee3'
                                DisplayName  = 'Password Settings'
                                CategoryPath = '\LAPS'
                                PolicyType   = 'admxBacked'
                                SupportedOn  = 'At least Microsoft Windows Vista or Windows Server 2003 family'
                                ClassType    = 'machine'
                            }
                            Enabled            = $True
                        }
                        MSFT_IntuneGroupPolicyDefinitionValue
                        {
                            ConfigurationType = 'policy'
                            Id                = 'a3577119-b240-4093-842c-d8e959dfe317'
                            Definition        = MSFT_IntuneGroupPolicyDefinitionValueDefinition
                            {
                                Id           = '986073b6-e149-495f-a131-aa0e3c697225'
                                DisplayName  = 'Ability to change properties of an all user remote access connection'
                                CategoryPath = '\Network\Network Connections'
                                PolicyType   = 'admxBacked'
                                SupportedOn  = 'At least Windows 2000 Service Pack 1'
                                ClassType    = 'user'
                            }
                            Enabled           = $True
                        }
                    )
                    Description                      = ''
                    DisplayName                      = 'admin template'
                    Ensure                           = 'Present'
                    PolicyConfigurationIngestionType = 'unknown'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationCustomPolicyWindows10 'Example'
                {
                    Assignments          = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisplayName          = "custom";
                    Ensure               = "Present";
                    OmaSettings          = @(
                        MSFT_MicrosoftGraphomaSetting{
                            Description = 'custom'
                            OmaUri = '/oma/custom'
                            odataType = '#microsoft.graph.omaSettingString'
                            SecretReferenceValueId = '5b0e1dba-4523-455e-9fdd-e36c833b57bf_e072d616-12bc-4ea3-9171-ab080e4c120d_1f958162-15d4-42ba-92c4-17c2544b2179'
                            Value = '****'
                            IsEncrypted = $True
                            DisplayName = 'oma'
                        }
                        MSFT_MicrosoftGraphomaSetting{
                            Description = 'custom 2'
                            OmaUri = '/oma/custom2'
                            odataType = '#microsoft.graph.omaSettingInteger'
                            Value = 2
                            IsReadOnly = $False
                            IsEncrypted = $False
                            DisplayName = 'custom 2'
                        }
                    );
                    SupportsScopeTags    = $True;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 'Example'
                {
                    AdvancedThreatProtectionAutoPopulateOnboardingBlob = $False;
                    AdvancedThreatProtectionOnboardingBlob             = "<EncryptedMessage xmlns=`"http://schemas.datacontract.org/2004/07/Microsoft.Management.Services.Common.Cryptography`" xmlns:i=`"http://www.w3.org/2001/XMLSchema-instance`"><EncryptedContent>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</EncryptedContent><RecipientCertThumbprints xmlns:a=`"http://schemas.microsoft.com/2003/10/Serialization/Arrays`"><a:string>D97F84CD027F883C2A6A7B4F1B8A194EF3042369</a:string></RecipientCertThumbprints></EncryptedMessage>";
                    AdvancedThreatProtectionOnboardingFilename         = "WindowsDefenderATP.onboarding";
                    AllowSampleSharing                                 = $True;
                    Assignments                                        = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisplayName                                        = "MDE onboarding Legacy";
                    EnableExpeditedTelemetryReporting                  = $True;
                    Ensure                                             = "Present";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationDeliveryOptimizationPolicyWindows10 'Example'
                {
                    Assignments                                               = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    BackgroundDownloadFromHttpDelayInSeconds                  = 4;
                    BandwidthMode                                             = MSFT_MicrosoftGraphdeliveryOptimizationBandwidth{
                        MaximumDownloadBandwidthInKilobytesPerSecond = 22
                        MaximumUploadBandwidthInKilobytesPerSecond = 33
                        odataType = '#microsoft.graph.deliveryOptimizationBandwidthAbsolute'
                    };
                    CacheServerBackgroundDownloadFallbackToHttpDelayInSeconds = 3;
                    CacheServerForegroundDownloadFallbackToHttpDelayInSeconds = 3;
                    CacheServerHostNames                                      = @("domain.com");
                    DeliveryOptimizationMode                                  = "httpWithPeeringPrivateGroup";
                    DisplayName                                               = "delivery optimisation";
                    Ensure                                                    = "Present";
                    ForegroundDownloadFromHttpDelayInSeconds                  = 234;
                    GroupIdSource                                             = MSFT_MicrosoftGraphdeliveryOptimizationGroupIdSource{
                        GroupIdSourceOption = 'adSite'
                        odataType = '#microsoft.graph.deliveryOptimizationGroupIdSourceOptions'
                    };
                    MaximumCacheAgeInDays                                     = 3;
                    MaximumCacheSize                                          = MSFT_MicrosoftGraphdeliveryOptimizationMaxCacheSize{
                        MaximumCacheSizeInGigabytes = 4
                        odataType = '#microsoft.graph.deliveryOptimizationMaxCacheSizeAbsolute'
                    };
                    MinimumBatteryPercentageAllowedToUpload                   = 4;
                    MinimumDiskSizeAllowedToPeerInGigabytes                   = 3;
                    MinimumFileSizeToCacheInMegabytes                         = 3;
                    MinimumRamAllowedToPeerInGigabytes                        = 3;
                    ModifyCacheLocation                                       = "%systemdrive%";
                    RestrictPeerSelectionBy                                   = "subnetMask";
                    SupportsScopeTags                                         = $True;
                    VpnPeerCaching                                            = "enabled";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationDomainJoinPolicyWindows10 'Example'
                {
                    ActiveDirectoryDomainName         = "domain.com";
                    Assignments                       = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    ComputerNameStaticPrefix          = "WK-";
                    ComputerNameSuffixRandomCharCount = 12;
                    DisplayName                       = "Domain Join";
                    Ensure                            = "Present";
                    OrganizationalUnit                = "OU=workstation,CN=domain,CN=com";
                    SupportsScopeTags                 = $True;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationEmailProfilePolicyWindows10 'Example'
                {
                    AccountName           = "Corp email2";
                    Assignments           = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    DisplayName           = "email";
                    DurationOfEmailToSync = "unlimited";
                    EmailAddressSource    = "primarySmtpAddress";
                    EmailSyncSchedule     = "fifteenMinutes";
                    Ensure                = "Present";
                    HostName              = "outlook.office365.com";
                    RequireSsl            = $True;
                    SyncCalendar          = $True;
                    SyncContacts          = $True;
                    SyncTasks             = $True;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationEndpointProtectionPolicyWindows10 'Example'
                {
                    ApplicationGuardAllowFileSaveOnHost                                          = $True;
                    ApplicationGuardAllowPersistence                                             = $True;
                    ApplicationGuardAllowPrintToLocalPrinters                                    = $True;
                    ApplicationGuardAllowPrintToNetworkPrinters                                  = $True;
                    ApplicationGuardAllowPrintToPDF                                              = $True;
                    ApplicationGuardAllowPrintToXPS                                              = $True;
                    ApplicationGuardAllowVirtualGPU                                              = $True;
                    ApplicationGuardBlockClipboardSharing                                        = "blockContainerToHost";
                    ApplicationGuardBlockFileTransfer                                            = "blockImageFile";
                    ApplicationGuardBlockNonEnterpriseContent                                    = $True;
                    ApplicationGuardCertificateThumbprints                                       = @();
                    ApplicationGuardEnabled                                                      = $True;
                    ApplicationGuardEnabledOptions                                               = "enabledForEdge";
                    ApplicationGuardForceAuditing                                                = $True;
                    AppLockerApplicationControl                                                  = "enforceComponentsStoreAppsAndSmartlocker";
                    Assignments                                                                  = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    BitLockerAllowStandardUserEncryption                                         = $True;
                    BitLockerDisableWarningForOtherDiskEncryption                                = $True;
                    BitLockerEnableStorageCardEncryptionOnMobile                                 = $True;
                    BitLockerEncryptDevice                                                       = $True;
                    BitLockerFixedDrivePolicy                                                    = MSFT_MicrosoftGraphbitLockerFixedDrivePolicy{
                        RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                            RecoveryInformationToStore = 'passwordAndKey'
                            HideRecoveryOptions = $True
                            BlockDataRecoveryAgent = $True
                            RecoveryKeyUsage = 'allowed'
                            EnableBitLockerAfterRecoveryInformationToStore = $True
                            EnableRecoveryInformationSaveToStore = $True
                            RecoveryPasswordUsage = 'allowed'
                        }
                                    RequireEncryptionForWriteAccess = $True
                        EncryptionMethod = 'xtsAes128'
                    };
                    BitLockerRecoveryPasswordRotation                                            = "notConfigured";
                    BitLockerRemovableDrivePolicy                                                = MSFT_MicrosoftGraphbitLockerRemovableDrivePolicy{
                        RequireEncryptionForWriteAccess = $True
                        BlockCrossOrganizationWriteAccess = $True
                        EncryptionMethod = 'aesCbc128'
                    };
                    BitLockerSystemDrivePolicy                                                   = MSFT_MicrosoftGraphbitLockerSystemDrivePolicy{
                        PrebootRecoveryEnableMessageAndUrl = $True
                        StartupAuthenticationTpmPinUsage = 'allowed'
                        EncryptionMethod = 'xtsAes128'
                        StartupAuthenticationTpmPinAndKeyUsage = 'allowed'
                        StartupAuthenticationRequired = $True
                        RecoveryOptions = MSFT_MicrosoftGraphBitLockerRecoveryOptions{
                            RecoveryInformationToStore = 'passwordAndKey'
                            HideRecoveryOptions = $False
                            BlockDataRecoveryAgent = $True
                            RecoveryKeyUsage = 'allowed'
                            EnableBitLockerAfterRecoveryInformationToStore = $True
                            EnableRecoveryInformationSaveToStore = $False
                            RecoveryPasswordUsage = 'allowed'
                        }
                                    StartupAuthenticationTpmUsage = 'allowed'
                        StartupAuthenticationTpmKeyUsage = 'allowed'
                        StartupAuthenticationBlockWithoutTpmChip = $False
                    };
                    DefenderAdditionalGuardedFolders                                             = @();
                    DefenderAdobeReaderLaunchChildProcess                                        = "notConfigured";
                    DefenderAdvancedRansomewareProtectionType                                    = "notConfigured";
                    DefenderAttackSurfaceReductionExcludedPaths                                  = @();
                    DefenderBlockPersistenceThroughWmiType                                       = "userDefined";
                    DefenderEmailContentExecution                                                = "userDefined";
                    DefenderEmailContentExecutionType                                            = "userDefined";
                    DefenderExploitProtectionXml                                                 = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxNaXRpZ2F0aW9uUG9saWN5Pg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IkFjcm9SZDMyLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJBY3JvUmQzMkluZm8uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImNsdmlldy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iY25mbm90MzIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImV4Y2VsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJleGNlbGNudi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iRXh0RXhwb3J0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJncmFwaC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iaWU0dWluaXQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllaW5zdGFsLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJpZWxvd3V0aWwuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImllVW5hdHQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9ImlleHBsb3JlLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJseW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2FjY2Vzcy5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNjb3JzdncuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zZmVlZHNzeW5jLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc2h0YS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvYWRmc2IuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb2FzYi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNvaHRtZWQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3NyZWMuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im1zb3htbGVkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJtc3B1Yi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ibXNxcnkzMi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iTXNTZW5zZS5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgICA8SW1hZ2VMb2FkIFByZWZlclN5c3RlbTMyPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VuLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJuZ2VudGFzay5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZS5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ib25lbm90ZW0uZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9Im9yZ2NoYXJ0LmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJvdXRsb29rLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJwb3dlcnBudC5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUHJlc2VudGF0aW9uSG9zdC5leGUiPg0KICAgIDxERVAgRW5hYmxlPSJ0cnVlIiBFbXVsYXRlQXRsVGh1bmtzPSJmYWxzZSIgLz4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIEJvdHRvbVVwPSJ0cnVlIiBIaWdoRW50cm9weT0idHJ1ZSIgLz4NCiAgICA8U0VIT1AgRW5hYmxlPSJ0cnVlIiBUZWxlbWV0cnlPbmx5PSJmYWxzZSIgLz4NCiAgICA8SGVhcCBUZXJtaW5hdGVPbkVycm9yPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJQcmludERpYWxvZy5leGUiPg0KICAgIDxFeHRlbnNpb25Qb2ludHMgRGlzYWJsZUV4dGVuc2lvblBvaW50cz0idHJ1ZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0iUmRyQ0VGLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJSZHJTZXJ2aWNlc1VwZGF0ZXIuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InJ1bnRpbWVicm9rZXIuZXhlIj4NCiAgICA8RXh0ZW5zaW9uUG9pbnRzIERpc2FibGVFeHRlbnNpb25Qb2ludHM9InRydWUiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5vc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNjYW5wc3QuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNkeGhlbHBlci5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQogIDxBcHBDb25maWcgRXhlY3V0YWJsZT0ic2VsZmNlcnQuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9InNldGxhbmcuZXhlIj4NCiAgICA8QVNMUiBGb3JjZVJlbG9jYXRlSW1hZ2VzPSJ0cnVlIiBSZXF1aXJlSW5mbz0iZmFsc2UiIC8+DQogIDwvQXBwQ29uZmlnPg0KICA8QXBwQ29uZmlnIEV4ZWN1dGFibGU9IlN5c3RlbVNldHRpbmdzLmV4ZSI+DQogICAgPEV4dGVuc2lvblBvaW50cyBEaXNhYmxlRXh0ZW5zaW9uUG9pbnRzPSJ0cnVlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3aW53b3JkLmV4ZSI+DQogICAgPEFTTFIgRm9yY2VSZWxvY2F0ZUltYWdlcz0idHJ1ZSIgUmVxdWlyZUluZm89ImZhbHNlIiAvPg0KICA8L0FwcENvbmZpZz4NCiAgPEFwcENvbmZpZyBFeGVjdXRhYmxlPSJ3b3JkY29udi5leGUiPg0KICAgIDxBU0xSIEZvcmNlUmVsb2NhdGVJbWFnZXM9InRydWUiIFJlcXVpcmVJbmZvPSJmYWxzZSIgLz4NCiAgPC9BcHBDb25maWc+DQo8L01pdGlnYXRpb25Qb2xpY3k+";
                    DefenderExploitProtectionXmlFileName                                         = "Settings.xml";
                    DefenderFileExtensionsToExclude                                              = @();
                    DefenderFilesAndFoldersToExclude                                             = @();
                    DefenderGuardedFoldersAllowedAppPaths                                        = @();
                    DefenderGuardMyFoldersType                                                   = "auditMode";
                    DefenderNetworkProtectionType                                                = "enable";
                    DefenderOfficeAppsExecutableContentCreationOrLaunch                          = "userDefined";
                    DefenderOfficeAppsExecutableContentCreationOrLaunchType                      = "userDefined";
                    DefenderOfficeAppsLaunchChildProcess                                         = "userDefined";
                    DefenderOfficeAppsLaunchChildProcessType                                     = "userDefined";
                    DefenderOfficeAppsOtherProcessInjection                                      = "userDefined";
                    DefenderOfficeAppsOtherProcessInjectionType                                  = "userDefined";
                    DefenderOfficeCommunicationAppsLaunchChildProcess                            = "notConfigured";
                    DefenderOfficeMacroCodeAllowWin32Imports                                     = "userDefined";
                    DefenderOfficeMacroCodeAllowWin32ImportsType                                 = "userDefined";
                    DefenderPreventCredentialStealingType                                        = "enable";
                    DefenderProcessCreation                                                      = "userDefined";
                    DefenderProcessCreationType                                                  = "userDefined";
                    DefenderProcessesToExclude                                                   = @();
                    DefenderScriptDownloadedPayloadExecution                                     = "userDefined";
                    DefenderScriptDownloadedPayloadExecutionType                                 = "userDefined";
                    DefenderScriptObfuscatedMacroCode                                            = "userDefined";
                    DefenderScriptObfuscatedMacroCodeType                                        = "userDefined";
                    DefenderSecurityCenterBlockExploitProtectionOverride                         = $False;
                    DefenderSecurityCenterDisableAccountUI                                       = $False;
                    DefenderSecurityCenterDisableClearTpmUI                                      = $True;
                    DefenderSecurityCenterDisableFamilyUI                                        = $False;
                    DefenderSecurityCenterDisableHardwareUI                                      = $True;
                    DefenderSecurityCenterDisableHealthUI                                        = $False;
                    DefenderSecurityCenterDisableNetworkUI                                       = $False;
                    DefenderSecurityCenterDisableNotificationAreaUI                              = $False;
                    DefenderSecurityCenterDisableRansomwareUI                                    = $False;
                    DefenderSecurityCenterDisableVirusUI                                         = $False;
                    DefenderSecurityCenterDisableVulnerableTpmFirmwareUpdateUI                   = $True;
                    DefenderSecurityCenterHelpEmail                                              = "me@domain.com";
                    DefenderSecurityCenterHelpPhone                                              = "yes";
                    DefenderSecurityCenterITContactDisplay                                       = "displayInAppAndInNotifications";
                    DefenderSecurityCenterNotificationsFromApp                                   = "blockNoncriticalNotifications";
                    DefenderSecurityCenterOrganizationDisplayName                                = "processes.exe";
                    DefenderUntrustedExecutable                                                  = "userDefined";
                    DefenderUntrustedExecutableType                                              = "userDefined";
                    DefenderUntrustedUSBProcess                                                  = "userDefined";
                    DefenderUntrustedUSBProcessType                                              = "userDefined";
                    DeviceGuardEnableSecureBootWithDMA                                           = $True;
                    DeviceGuardEnableVirtualizationBasedSecurity                                 = $True;
                    DeviceGuardLaunchSystemGuard                                                 = "notConfigured";
                    DeviceGuardLocalSystemAuthorityCredentialGuardSettings                       = "enableWithoutUEFILock";
                    DeviceGuardSecureBootWithDMA                                                 = "notConfigured";
                    DisplayName                                                                  = "endpoint protection legacy - dsc v2.0";
                    DmaGuardDeviceEnumerationPolicy                                              = "deviceDefault";
                    Ensure                                                                       = "Present";
                    FirewallCertificateRevocationListCheckMethod                                 = "deviceDefault";
                    FirewallIPSecExemptionsAllowDHCP                                             = $False;
                    FirewallIPSecExemptionsAllowICMP                                             = $False;
                    FirewallIPSecExemptionsAllowNeighborDiscovery                                = $False;
                    FirewallIPSecExemptionsAllowRouterDiscovery                                  = $False;
                    FirewallIPSecExemptionsNone                                                  = $False;
                    FirewallPacketQueueingMethod                                                 = "deviceDefault";
                    FirewallPreSharedKeyEncodingMethod                                           = "deviceDefault";
                    FirewallProfileDomain                                                        = MSFT_MicrosoftGraphwindowsFirewallNetworkProfile{
                        PolicyRulesFromGroupPolicyNotMerged = $False
                        InboundNotificationsBlocked = $True
                        OutboundConnectionsRequired = $True
                        GlobalPortRulesFromGroupPolicyNotMerged = $True
                        ConnectionSecurityRulesFromGroupPolicyNotMerged = $True
                        UnicastResponsesToMulticastBroadcastsRequired = $True
                        PolicyRulesFromGroupPolicyMerged = $False
                        UnicastResponsesToMulticastBroadcastsBlocked = $False
                        IncomingTrafficRequired = $False
                        IncomingTrafficBlocked = $True
                        ConnectionSecurityRulesFromGroupPolicyMerged = $False
                        StealthModeRequired = $False
                        InboundNotificationsRequired = $False
                        AuthorizedApplicationRulesFromGroupPolicyMerged = $False
                        InboundConnectionsBlocked = $True
                        OutboundConnectionsBlocked = $False
                        StealthModeBlocked = $True
                        GlobalPortRulesFromGroupPolicyMerged = $False
                        SecuredPacketExemptionBlocked = $False
                        SecuredPacketExemptionAllowed = $False
                        InboundConnectionsRequired = $False
                        FirewallEnabled = 'allowed'
                        AuthorizedApplicationRulesFromGroupPolicyNotMerged = $True
                    };
                    FirewallRules                                                                = @(
                        MSFT_MicrosoftGraphwindowsFirewallRule{
                            Action = 'allowed'
                            InterfaceTypes = 'notConfigured'
                            DisplayName = 'ICMP'
                            TrafficDirection = 'in'
                            ProfileTypes = 'domain'
                            EdgeTraversal = 'notConfigured'
                        }
                    );
                    LanManagerAuthenticationLevel                                                = "lmNtlmAndNtlmV2";
                    LanManagerWorkstationDisableInsecureGuestLogons                              = $False;
                    LocalSecurityOptionsAdministratorElevationPromptBehavior                     = "notConfigured";
                    LocalSecurityOptionsAllowAnonymousEnumerationOfSAMAccountsAndShares          = $False;
                    LocalSecurityOptionsAllowPKU2UAuthenticationRequests                         = $False;
                    LocalSecurityOptionsAllowRemoteCallsToSecurityAccountsManagerHelperBool      = $False;
                    LocalSecurityOptionsAllowSystemToBeShutDownWithoutHavingToLogOn              = $True;
                    LocalSecurityOptionsAllowUIAccessApplicationElevation                        = $False;
                    LocalSecurityOptionsAllowUIAccessApplicationsForSecureLocations              = $False;
                    LocalSecurityOptionsAllowUndockWithoutHavingToLogon                          = $True;
                    LocalSecurityOptionsBlockMicrosoftAccounts                                   = $True;
                    LocalSecurityOptionsBlockRemoteLogonWithBlankPassword                        = $True;
                    LocalSecurityOptionsBlockRemoteOpticalDriveAccess                            = $True;
                    LocalSecurityOptionsBlockUsersInstallingPrinterDrivers                       = $True;
                    LocalSecurityOptionsClearVirtualMemoryPageFile                               = $True;
                    LocalSecurityOptionsClientDigitallySignCommunicationsAlways                  = $False;
                    LocalSecurityOptionsClientSendUnencryptedPasswordToThirdPartySMBServers      = $False;
                    LocalSecurityOptionsDetectApplicationInstallationsAndPromptForElevation      = $False;
                    LocalSecurityOptionsDisableAdministratorAccount                              = $True;
                    LocalSecurityOptionsDisableClientDigitallySignCommunicationsIfServerAgrees   = $False;
                    LocalSecurityOptionsDisableGuestAccount                                      = $True;
                    LocalSecurityOptionsDisableServerDigitallySignCommunicationsAlways           = $False;
                    LocalSecurityOptionsDisableServerDigitallySignCommunicationsIfClientAgrees   = $False;
                    LocalSecurityOptionsDoNotAllowAnonymousEnumerationOfSAMAccounts              = $True;
                    LocalSecurityOptionsDoNotRequireCtrlAltDel                                   = $True;
                    LocalSecurityOptionsDoNotStoreLANManagerHashValueOnNextPasswordChange        = $False;
                    LocalSecurityOptionsFormatAndEjectOfRemovableMediaAllowedUser                = "administrators";
                    LocalSecurityOptionsHideLastSignedInUser                                     = $False;
                    LocalSecurityOptionsHideUsernameAtSignIn                                     = $False;
                    LocalSecurityOptionsInformationDisplayedOnLockScreen                         = "notConfigured";
                    LocalSecurityOptionsInformationShownOnLockScreen                             = "notConfigured";
                    LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedClients             = "none";
                    LocalSecurityOptionsMinimumSessionSecurityForNtlmSspBasedServers             = "none";
                    LocalSecurityOptionsOnlyElevateSignedExecutables                             = $False;
                    LocalSecurityOptionsRestrictAnonymousAccessToNamedPipesAndShares             = $True;
                    LocalSecurityOptionsSmartCardRemovalBehavior                                 = "lockWorkstation";
                    LocalSecurityOptionsStandardUserElevationPromptBehavior                      = "notConfigured";
                    LocalSecurityOptionsSwitchToSecureDesktopWhenPromptingForElevation           = $False;
                    LocalSecurityOptionsUseAdminApprovalMode                                     = $False;
                    LocalSecurityOptionsUseAdminApprovalModeForAdministrators                    = $False;
                    LocalSecurityOptionsVirtualizeFileAndRegistryWriteFailuresToPerUserLocations = $False;
                    SmartScreenBlockOverrideForFiles                                             = $True;
                    SmartScreenEnableInShell                                                     = $True;
                    SupportsScopeTags                                                            = $True;
                    UserRightsAccessCredentialManagerAsTrustedCaller                             = MSFT_MicrosoftGraphdeviceManagementUserRightsSetting{
                        State = 'allowed'
                        LocalUsersOrGroups = @(
                            MSFT_MicrosoftGraphDeviceManagementUserRightsLocalUserOrGroup{
                                Name = 'NT AUTHORITY\Local service'
                                SecurityIdentifier = '*S-1-5-19'
                            }
                        )
                    };
                    WindowsDefenderTamperProtection                                              = "enable";
                    XboxServicesAccessoryManagementServiceStartupMode                            = "manual";
                    XboxServicesEnableXboxGameSaveTask                                           = $True;
                    XboxServicesLiveAuthManagerServiceStartupMode                                = "manual";
                    XboxServicesLiveGameSaveServiceStartupMode                                   = "manual";
                    XboxServicesLiveNetworkingServiceStartupMode                                 = "manual";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationFirmwareInterfacePolicyWindows10 'Example'
                {
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    Bluetooth                      = "notConfigured";
                    BootFromBuiltInNetworkAdapters = "notConfigured";
                    BootFromExternalMedia          = "notConfigured";
                    Cameras                        = "enabled";
                    ChangeUefiSettingsPermission   = "notConfiguredOnly";
                    DisplayName                    = "firmware";
                    Ensure                         = "Present";
                    FrontCamera                    = "enabled";
                    InfraredCamera                 = "enabled";
                    Microphone                     = "notConfigured";
                    MicrophonesAndSpeakers         = "enabled";
                    NearFieldCommunication         = "notConfigured";
                    Radios                         = "enabled";
                    RearCamera                     = "enabled";
                    SdCard                         = "notConfigured";
                    SimultaneousMultiThreading     = "enabled";
                    SupportsScopeTags              = $True;
                    UsbTypeAPort                   = "notConfigured";
                    VirtualizationOfCpuAndIO       = "enabled";
                    WakeOnLAN                      = "notConfigured";
                    WakeOnPower                    = "notConfigured";
                    WiFi                           = "notConfigured";
                    WindowsPlatformBinaryTable     = "enabled";
                    WirelessWideAreaNetwork        = "notConfigured";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationHealthMonitoringConfigurationPolicyWindows10 'Example'
                {
                    AllowDeviceHealthMonitoring       = "enabled";
                    Assignments                       = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    ConfigDeviceHealthMonitoringScope = @("bootPerformance","windowsUpdates");
                    DisplayName                       = "Health Monitoring Configuration";
                    Ensure                            = "Present";
                    SupportsScopeTags                 = $True;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationIdentityProtectionPolicyWindows10 'Example'
                {
                    Assignments                                  = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    DisplayName                                  = "identity protection";
                    EnhancedAntiSpoofingForFacialFeaturesEnabled = $True;
                    Ensure                                       = "Present";
                    PinExpirationInDays                          = 5;
                    PinLowercaseCharactersUsage                  = "allowed";
                    PinMaximumLength                             = 4;
                    PinMinimumLength                             = 4;
                    PinPreviousBlockCount                        = 3;
                    PinRecoveryEnabled                           = $True;
                    PinSpecialCharactersUsage                    = "allowed";
                    PinUppercaseCharactersUsage                  = "allowed";
                    SecurityDeviceRequired                       = $True;
                    SupportsScopeTags                            = $True;
                    UnlockWithBiometricsEnabled                  = $True;
                    UseCertificatesForOnPremisesAuthEnabled      = $True;
                    UseSecurityKeyForSignin                      = $True;
                    WindowsHelloForBusinessBlocked               = $False;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationImportedPfxCertificatePolicyWindows10 'Example'
                {
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    CertificateValidityPeriodScale = "years";
                    CertificateValidityPeriodValue = 1;
                    DisplayName                    = "PKCS Imported";
                    Ensure                         = "Present";
                    IntendedPurpose                = "unassigned";
                    KeyStorageProvider             = "useSoftwareKsp";
                    RenewalThresholdPercentage     = 50;
                    SubjectAlternativeNameType     = "emailAddress";
                    SubjectNameFormat              = "commonName";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationKioskPolicyWindows10 'Example'
                {
                    Assignments                         = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    DisplayName                         = "kiosk";
                    EdgeKioskEnablePublicBrowsing       = $False;
                    Ensure                              = "Present";
                    KioskBrowserBlockedUrlExceptions    = @();
                    KioskBrowserBlockedURLs             = @();
                    KioskBrowserDefaultUrl              = "http://bing.com";
                    KioskBrowserEnableEndSessionButton  = $False;
                    KioskBrowserEnableHomeButton        = $True;
                    KioskBrowserEnableNavigationButtons = $False;
                    KioskProfiles                       = @(
                        MSFT_MicrosoftGraphwindowsKioskProfile{
                            ProfileId = '17f9e980-3435-4bd5-a7a1-ca3c06d0bf2c'
                            UserAccountsConfiguration = @(
                                MSFT_MicrosoftGraphWindowsKioskUser{
                                    odataType = '#microsoft.graph.windowsKioskAutologon'
                                }
                            )
                            ProfileName = 'profile'
                            AppConfiguration = MSFT_MicrosoftGraphWindowsKioskAppConfiguration{
                                Win32App = MSFT_MicrosoftGraphWindowsKioskWin32App{
                                    EdgeNoFirstRun = $True
                                    EdgeKiosk = 'https://domain.com'
                                    ClassicAppPath = 'msedge.exe'
                                    AutoLaunch = $False
                                    StartLayoutTileSize = 'hidden'
                                    AppType = 'unknown'
                                    EdgeKioskType = 'publicBrowsing'
                                }
                                odataType = '#microsoft.graph.windowsKioskSingleWin32App'
                            }
                        }
                    );
                    WindowsKioskForceUpdateSchedule     = MSFT_MicrosoftGraphwindowsKioskForceUpdateSchedule{
                        RunImmediatelyIfAfterStartDateTime = $False
                        StartDateTime = '2023-04-15T23:00:00.0000000+00:00'
                        DayofMonth = 1
                        Recurrence = 'daily'
                        DayofWeek = 'sunday'
                    };
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationNetworkBoundaryPolicyWindows10 'Example'
                {
                    Assignments                   = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisplayName                   = "network boundary";
                    Ensure                        = "Present";
                    SupportsScopeTags             = $True;
                    WindowsNetworkIsolationPolicy = MSFT_MicrosoftGraphwindowsNetworkIsolationPolicy{
                        EnterpriseProxyServers = @()
                        EnterpriseInternalProxyServers = @()
                        EnterpriseIPRangesAreAuthoritative = $True
                        EnterpriseProxyServersAreAuthoritative = $True
                        EnterpriseNetworkDomainNames = @('domain.com')
                        EnterpriseIPRanges = @(
                            MSFT_MicrosoftGraphIpRange1{
                                UpperAddress = '1.1.1.255'
                                LowerAddress = '1.1.1.0'
                                odataType = '#microsoft.graph.iPv4Range'
                            }
                        )
                        NeutralDomainResources = @()
                    };
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPkcsCertificatePolicyWindows10 'Example'
                {
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    CertificateStore               = "user";
                    CertificateTemplateName        = "Template DSC";
                    CertificateValidityPeriodScale = "years";
                    CertificateValidityPeriodValue = 1;
                    CertificationAuthority         = "CA=Name";
                    CertificationAuthorityName     = "Test";
                    CustomSubjectAlternativeNames  = @(
                        MSFT_MicrosoftGraphcustomSubjectAlternativeName{
                            SanType = 'domainNameService'
                            Name = 'certificate.com'
                        }
                    );
                    DisplayName                    = "PKCS";
                    Ensure                         = "Present";
                    KeyStorageProvider             = "usePassportForWorkKspOtherwiseFail";
                    RenewalThresholdPercentage     = 20;
                    SubjectAlternativeNameType     = "none";
                    SubjectNameFormat              = "custom";
                    SubjectNameFormatString        = "CN={{UserName}},E={{EmailAddress}}";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPlatformScriptMacOS 'Example'
                {
                    Assignments          = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisplayName          = "custom";
                    Ensure               = "Present";
                    BlockExecutionNotifications = $False;
                    Description                 = "";
                    ExecutionFrequency          = "00:00:00";
                    FileName                    = "shellscript.sh";
                    Id                          = "00000000-0000-0000-0000-000000000000";
                    RetryCount                  = 0;
                    RoleScopeTagIds             = @("0");
                    RunAsAccount                = "user";
                    ScriptContent               = "Base64 encoded script content";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPlatformScriptWindows 'Example'
                {
                    Assignments          = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisplayName           = "custom";
                    Ensure                = "Present";
                    EnforceSignatureCheck = $False;
                    FileName              = "script.ps1";
                    Id                    = "00000000-0000-0000-0000-000000000000";
                    RunAs32Bit            = $True;
                    RunAsAccount          = "system";
                    ScriptContent         = "Base64 encoded script content";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyAndroidDeviceAdministrator 'myAndroidDeviceAdmin'
                {
                    DisplayName                              = 'Android device admin'
                    AppsBlockClipboardSharing                = $True
                    AppsBlockCopyPaste                       = $True
                    AppsBlockYouTube                         = $False
                    Assignments                              = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    BluetoothBlocked                         = $True
                    CameraBlocked                            = $True
                    CellularBlockDataRoaming                 = $False
                    CellularBlockMessaging                   = $False
                    CellularBlockVoiceRoaming                = $False
                    CellularBlockWiFiTethering               = $False
                    CompliantAppListType                     = 'appsInListCompliant'
                    CompliantAppsList                        = @(
                        MSFT_MicrosoftGraphAppListitem {
                            name        = 'customApp'
                            publisher   = 'google2'
                            appStoreUrl = 'https://appUrl.com'
                            appId       = 'com.custom.google.com'
                        }
                    )
                    DateAndTimeBlockChanges                  = $True
                    DeviceSharingAllowed                     = $False
                    DiagnosticDataBlockSubmission            = $False
                    FactoryResetBlocked                      = $False
                    GoogleAccountBlockAutoSync               = $False
                    GooglePlayStoreBlocked                   = $False
                    KioskModeBlockSleepButton                = $False
                    KioskModeBlockVolumeButtons              = $True
                    LocationServicesBlocked                  = $False
                    NfcBlocked                               = $False
                    PasswordBlockFingerprintUnlock           = $False
                    PasswordBlockTrustAgents                 = $False
                    PasswordRequired                         = $True
                    PasswordRequiredType                     = 'numeric'
                    PowerOffBlocked                          = $False
                    RequiredPasswordComplexity               = 'low'
                    ScreenCaptureBlocked                     = $False
                    SecurityRequireVerifyApps                = $False
                    StorageBlockGoogleBackup                 = $False
                    StorageBlockRemovableStorage             = $False
                    StorageRequireDeviceEncryption           = $False
                    StorageRequireRemovableStorageEncryption = $True
                    VoiceAssistantBlocked                    = $False
                    VoiceDialingBlocked                      = $False
                    WebBrowserBlockAutofill                  = $False
                    WebBrowserBlocked                        = $False
                    WebBrowserBlockJavaScript                = $False
                    WebBrowserBlockPopups                    = $False
                    WebBrowserCookieSettings                 = 'allowAlways'
                    WiFiBlocked                              = $False
                    Ensure                                   = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyAndroidDeviceOwner 'myAndroidDeviceOwnerPolicy'
                {
                    DisplayName                           = 'general confi - AndroidDeviceOwner'
                    Assignments                           = @()
                    AzureAdSharedDeviceDataClearApps      = @()
                    CameraBlocked                         = $True
                    CrossProfilePoliciesAllowDataSharing  = 'notConfigured'
                    EnrollmentProfile                     = 'notConfigured'
                    FactoryResetDeviceAdministratorEmails = @()
                    GlobalProxy                           = MSFT_MicrosoftGraphandroiddeviceownerglobalproxy {
                        odataType = '#microsoft.graph.androidDeviceOwnerGlobalProxyDirect'
                        host      = 'myproxy.com'
                        port      = 8083
                    }
                    KioskCustomizationStatusBar           = 'notConfigured'
                    KioskCustomizationSystemNavigation    = 'notConfigured'
                    KioskModeAppPositions                 = @()
                    KioskModeApps                         = @()
                    KioskModeManagedFolders               = @()
                    KioskModeUseManagedHomeScreenApp      = 'notConfigured'
                    KioskModeWifiAllowedSsids             = @()
                    MicrophoneForceMute                   = $True
                    NfcBlockOutgoingBeam                  = $True
                    PasswordBlockKeyguardFeatures         = @()
                    PasswordRequiredType                  = 'deviceDefault'
                    PasswordRequireUnlock                 = 'deviceDefault'
                    PersonalProfilePersonalApplications   = @()
                    PersonalProfilePlayStoreMode          = 'notConfigured'
                    ScreenCaptureBlocked                  = $True
                    SecurityRequireVerifyApps             = $True
                    StayOnModes                           = @()
                    StorageBlockExternalMedia             = $True
                    SystemUpdateFreezePeriods             = @(
                        MSFT_MicrosoftGraphandroiddeviceownersystemupdatefreezeperiod {
                            startMonth = 12
                            startDay   = 23
                            endMonth   = 12
                            endDay     = 30
                        })
                    VpnAlwaysOnLockdownMode               = $False
                    VpnAlwaysOnPackageIdentifier          = ''
                    WorkProfilePasswordRequiredType       = 'deviceDefault'
                    WorkProfilePasswordRequireUnlock      = 'deviceDefault'
                    Ensure                                = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyAndroidOpenSourceProject 'myAndroidOpenSourceProjectPolicy'
                {
                    DisplayName               = 'aosp'
                    Assignments               = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    CameraBlocked             = $False
                    FactoryResetBlocked       = $True
                    PasswordRequiredType      = 'deviceDefault'
                    ScreenCaptureBlocked      = $True
                    StorageBlockExternalMedia = $True
                    Ensure                    = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyAndroidWorkProfile '97ed22e9-1429-40dc-ab3c-0055e538383b'
                {
                    DisplayName                                    = 'Android Work Profile - Device Restrictions - Standard'
                    PasswordBlockFingerprintUnlock                 = $False
                    PasswordBlockTrustAgents                       = $False
                    PasswordMinimumLength                          = 6
                    PasswordMinutesOfInactivityBeforeScreenTimeout = 15
                    PasswordRequiredType                           = 'atLeastNumeric'
                    SecurityRequireVerifyApps                      = $True
                    WorkProfileBlockAddingAccounts                 = $True
                    WorkProfileBlockCamera                         = $False
                    WorkProfileBlockCrossProfileCallerId           = $False
                    WorkProfileBlockCrossProfileContactsSearch     = $False
                    WorkProfileBlockCrossProfileCopyPaste          = $True
                    WorkProfileBlockNotificationsWhileDeviceLocked = $True
                    WorkProfileBlockScreenCapture                  = $True
                    WorkProfileBluetoothEnableContactSharing       = $False
                    WorkProfileDataSharingType                     = 'allowPersonalToWork'
                    WorkProfileDefaultAppPermissionPolicy          = 'deviceDefault'
                    WorkProfilePasswordBlockFingerprintUnlock      = $False
                    WorkProfilePasswordBlockTrustAgents            = $False
                    WorkProfilePasswordRequiredType                = 'deviceDefault'
                    WorkProfileRequirePassword                     = $False
                    Ensure                                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyiOS 'ConfigureDeviceConfigurationPolicyiOS'
                {
                    DisplayName                                    = 'iOS DSC Policy'
                    AccountBlockModification                       = $False
                    ActivationLockAllowWhenSupervised              = $False
                    AirDropBlocked                                 = $False
                    AirDropForceUnmanagedDropTarget                = $False
                    AirPlayForcePairingPasswordForOutgoingRequests = $False
                    AppleNewsBlocked                               = $False
                    AppleWatchBlockPairing                         = $False
                    AppleWatchForceWristDetection                  = $False
                    AppStoreBlockAutomaticDownloads                = $False
                    AppStoreBlocked                                = $False
                    AppStoreBlockInAppPurchases                    = $False
                    AppStoreBlockUIAppInstallation                 = $False
                    AppStoreRequirePassword                        = $False
                    AppsVisibilityList                             = @()
                    AppsVisibilityListType                         = 'none'
                    BluetoothBlockModification                     = $True
                    CameraBlocked                                  = $False
                    CellularBlockDataRoaming                       = $False
                    CellularBlockGlobalBackgroundFetchWhileRoaming = $False
                    CellularBlockPerAppDataModification            = $False
                    CellularBlockVoiceRoaming                      = $False
                    CertificatesBlockUntrustedTlsCertificates      = $False
                    ClassroomAppBlockRemoteScreenObservation       = $False
                    CompliantAppListType                           = 'none'
                    CompliantAppsList                              = @()
                    ConfigurationProfileBlockChanges               = $False
                    DefinitionLookupBlocked                        = $False
                    Description                                    = 'iOS Device Restriction Policy'
                    DeviceBlockEnableRestrictions                  = $True
                    DeviceBlockEraseContentAndSettings             = $False
                    DeviceBlockNameModification                    = $False
                    DiagnosticDataBlockSubmission                  = $False
                    DiagnosticDataBlockSubmissionModification      = $False
                    DocumentsBlockManagedDocumentsInUnmanagedApps  = $False
                    DocumentsBlockUnmanagedDocumentsInManagedApps  = $False
                    EmailInDomainSuffixes                          = @()
                    EnterpriseAppBlockTrust                        = $False
                    EnterpriseAppBlockTrustModification            = $False
                    FaceTimeBlocked                                = $False
                    FindMyFriendsBlocked                           = $False
                    GameCenterBlocked                              = $False
                    GamingBlockGameCenterFriends                   = $True
                    GamingBlockMultiplayer                         = $False
                    HostPairingBlocked                             = $False
                    iBooksStoreBlocked                             = $False
                    iBooksStoreBlockErotica                        = $False
                    iCloudBlockActivityContinuation                = $False
                    iCloudBlockBackup                              = $True
                    iCloudBlockDocumentSync                        = $True
                    iCloudBlockManagedAppsSync                     = $False
                    iCloudBlockPhotoLibrary                        = $False
                    iCloudBlockPhotoStreamSync                     = $True
                    iCloudBlockSharedPhotoStream                   = $False
                    iCloudRequireEncryptedBackup                   = $False
                    iTunesBlockExplicitContent                     = $False
                    iTunesBlockMusicService                        = $False
                    iTunesBlockRadio                               = $False
                    KeyboardBlockAutoCorrect                       = $False
                    KeyboardBlockPredictive                        = $False
                    KeyboardBlockShortcuts                         = $False
                    KeyboardBlockSpellCheck                        = $False
                    KioskModeAllowAssistiveSpeak                   = $False
                    KioskModeAllowAssistiveTouchSettings           = $False
                    KioskModeAllowAutoLock                         = $False
                    KioskModeAllowColorInversionSettings           = $False
                    KioskModeAllowRingerSwitch                     = $False
                    KioskModeAllowScreenRotation                   = $False
                    KioskModeAllowSleepButton                      = $False
                    KioskModeAllowTouchscreen                      = $False
                    KioskModeAllowVoiceOverSettings                = $False
                    KioskModeAllowVolumeButtons                    = $False
                    KioskModeAllowZoomSettings                     = $False
                    KioskModeRequireAssistiveTouch                 = $False
                    KioskModeRequireColorInversion                 = $False
                    KioskModeRequireMonoAudio                      = $False
                    KioskModeRequireVoiceOver                      = $False
                    KioskModeRequireZoom                           = $False
                    LockScreenBlockControlCenter                   = $False
                    LockScreenBlockNotificationView                = $False
                    LockScreenBlockPassbook                        = $False
                    LockScreenBlockTodayView                       = $False
                    MediaContentRatingApps                         = 'allAllowed'
                    messagesBlocked                                = $False
                    NotificationsBlockSettingsModification         = $False
                    PasscodeBlockFingerprintUnlock                 = $False
                    PasscodeBlockModification                      = $False
                    PasscodeBlockSimple                            = $True
                    PasscodeMinimumLength                          = 4
                    PasscodeRequired                               = $True
                    PasscodeRequiredType                           = 'deviceDefault'
                    PodcastsBlocked                                = $False
                    SafariBlockAutofill                            = $False
                    SafariBlocked                                  = $False
                    SafariBlockJavaScript                          = $False
                    SafariBlockPopups                              = $False
                    SafariCookieSettings                           = 'browserDefault'
                    SafariManagedDomains                           = @()
                    SafariPasswordAutoFillDomains                  = @()
                    SafariRequireFraudWarning                      = $False
                    ScreenCaptureBlocked                           = $False
                    SiriBlocked                                    = $False
                    SiriBlockedWhenLocked                          = $False
                    SiriBlockUserGeneratedContent                  = $False
                    SiriRequireProfanityFilter                     = $False
                    SpotlightBlockInternetResults                  = $False
                    VoiceDialingBlocked                            = $False
                    WallpaperBlockModification                     = $False
                    Ensure                                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyMacOS 'myMacOSDevicePolicy'
                {
                    DisplayName                                     = 'MacOS device restriction'
                    AddingGameCenterFriendsBlocked                  = $True
                    AirDropBlocked                                  = $False
                    AppleWatchBlockAutoUnlock                       = $False
                    Assignments                                     = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                            groupId                                    = 'e8cbd84d-be6a-4b72-87f0-0e677541fda0'
                        }
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.groupAssignmentTarget'
                            groupId                                    = 'ea9199b8-3e6e-407b-afdc-e0943e0d3c20'
                        })
                    CameraBlocked                                   = $False
                    ClassroomAppBlockRemoteScreenObservation        = $False
                    ClassroomAppForceUnpromptedScreenObservation    = $False
                    ClassroomForceAutomaticallyJoinClasses          = $False
                    ClassroomForceRequestPermissionToLeaveClasses   = $False
                    ClassroomForceUnpromptedAppAndDeviceLock        = $False
                    CompliantAppListType                            = 'appsNotInListCompliant'
                    CompliantAppsList                               = @(
                        MSFT_MicrosoftGraphapplistitemMacOS {
                            name      = 'appname2'
                            publisher = 'publisher'
                            appId     = 'bundle'
                        }
                    )
                    ContentCachingBlocked                           = $False
                    DefinitionLookupBlocked                         = $True
                    EmailInDomainSuffixes                           = @()
                    EraseContentAndSettingsBlocked                  = $False
                    GameCenterBlocked                               = $False
                    ICloudBlockActivityContinuation                 = $False
                    ICloudBlockAddressBook                          = $False
                    ICloudBlockBookmarks                            = $False
                    ICloudBlockCalendar                             = $False
                    ICloudBlockDocumentSync                         = $False
                    ICloudBlockMail                                 = $False
                    ICloudBlockNotes                                = $False
                    ICloudBlockPhotoLibrary                         = $False
                    ICloudBlockReminders                            = $False
                    ICloudDesktopAndDocumentsBlocked                = $False
                    ICloudPrivateRelayBlocked                       = $False
                    ITunesBlockFileSharing                          = $False
                    ITunesBlockMusicService                         = $False
                    KeyboardBlockDictation                          = $False
                    KeychainBlockCloudSync                          = $False
                    MultiplayerGamingBlocked                        = $False
                    PasswordBlockAirDropSharing                     = $False
                    PasswordBlockAutoFill                           = $False
                    PasswordBlockFingerprintUnlock                  = $False
                    PasswordBlockModification                       = $False
                    PasswordBlockProximityRequests                  = $False
                    PasswordBlockSimple                             = $False
                    PasswordRequired                                = $False
                    PasswordRequiredType                            = 'deviceDefault'
                    PrivacyAccessControls                           = @(
                        MSFT_MicrosoftGraphmacosprivacyaccesscontrolitem {
                            displayName                  = 'test'
                            identifier                   = 'test45'
                            identifierType               = 'path'
                            codeRequirement              = 'test'
                            blockCamera                  = $True
                            speechRecognition            = 'notConfigured'
                            accessibility                = 'notConfigured'
                            addressBook                  = 'enabled'
                            calendar                     = 'notConfigured'
                            reminders                    = 'notConfigured'
                            photos                       = 'notConfigured'
                            mediaLibrary                 = 'notConfigured'
                            fileProviderPresence         = 'notConfigured'
                            systemPolicyAllFiles         = 'notConfigured'
                            systemPolicySystemAdminFiles = 'notConfigured'
                            systemPolicyDesktopFolder    = 'notConfigured'
                            systemPolicyDocumentsFolder  = 'notConfigured'
                            systemPolicyDownloadsFolder  = 'notConfigured'
                            systemPolicyNetworkVolumes   = 'notConfigured'
                            systemPolicyRemovableVolumes = 'notConfigured'
                            postEvent                    = 'notConfigured'
                        }
                    )
                    SafariBlockAutofill                             = $False
                    ScreenCaptureBlocked                            = $False
                    SoftwareUpdateMajorOSDeferredInstallDelayInDays = 30
                    SoftwareUpdateMinorOSDeferredInstallDelayInDays = 30
                    SoftwareUpdateNonOSDeferredInstallDelayInDays   = 30
                    SoftwareUpdatesEnforcedDelayInDays              = 30
                    SpotlightBlockInternetResults                   = $False
                    UpdateDelayPolicy                               = @('delayOSUpdateVisibility', 'delayAppUpdateVisibility', 'delayMajorOsUpdateVisibility')
                    WallpaperModificationBlocked                    = $False
                    Ensure                                          = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationPolicyWindows10 'Example'
                {
                    AccountsBlockAddingNonMicrosoftAccountEmail          = $False;
                    ActivateAppsWithVoice                                = "notConfigured";
                    AntiTheftModeBlocked                                 = $False;
                    AppManagementMSIAllowUserControlOverInstall          = $False;
                    AppManagementMSIAlwaysInstallWithElevatedPrivileges  = $False;
                    AppManagementPackageFamilyNamesToLaunchAfterLogOn    = @();
                    AppsAllowTrustedAppsSideloading                      = "notConfigured";
                    AppsBlockWindowsStoreOriginatedApps                  = $False;
                    Assignments                                          = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    AuthenticationAllowSecondaryDevice                   = $False;
                    AuthenticationWebSignIn                              = "notConfigured";
                    BluetoothAllowedServices                             = @();
                    BluetoothBlockAdvertising                            = $True;
                    BluetoothBlockDiscoverableMode                       = $False;
                    BluetoothBlocked                                     = $True;
                    BluetoothBlockPrePairing                             = $True;
                    BluetoothBlockPromptedProximalConnections            = $False;
                    CameraBlocked                                        = $False;
                    CellularBlockDataWhenRoaming                         = $False;
                    CellularBlockVpn                                     = $True;
                    CellularBlockVpnWhenRoaming                          = $True;
                    CellularData                                         = "allowed";
                    CertificatesBlockManualRootCertificateInstallation   = $False;
                    ConnectedDevicesServiceBlocked                       = $False;
                    CopyPasteBlocked                                     = $False;
                    CortanaBlocked                                       = $False;
                    CryptographyAllowFipsAlgorithmPolicy                 = $False;
                    DefenderBlockEndUserAccess                           = $False;
                    DefenderBlockOnAccessProtection                      = $False;
                    DefenderCloudBlockLevel                              = "notConfigured";
                    DefenderDisableCatchupFullScan                       = $False;
                    DefenderDisableCatchupQuickScan                      = $False;
                    DefenderFileExtensionsToExclude                      = @();
                    DefenderFilesAndFoldersToExclude                     = @();
                    DefenderMonitorFileActivity                          = "userDefined";
                    DefenderPotentiallyUnwantedAppActionSetting          = "userDefined";
                    DefenderProcessesToExclude                           = @();
                    DefenderPromptForSampleSubmission                    = "userDefined";
                    DefenderRequireBehaviorMonitoring                    = $False;
                    DefenderRequireCloudProtection                       = $False;
                    DefenderRequireNetworkInspectionSystem               = $False;
                    DefenderRequireRealTimeMonitoring                    = $False;
                    DefenderScanArchiveFiles                             = $False;
                    DefenderScanDownloads                                = $False;
                    DefenderScanIncomingMail                             = $False;
                    DefenderScanMappedNetworkDrivesDuringFullScan        = $False;
                    DefenderScanNetworkFiles                             = $False;
                    DefenderScanRemovableDrivesDuringFullScan            = $False;
                    DefenderScanScriptsLoadedInInternetExplorer          = $False;
                    DefenderScanType                                     = "userDefined";
                    DefenderScheduleScanEnableLowCpuPriority             = $False;
                    DefenderSystemScanSchedule                           = "userDefined";
                    DeveloperUnlockSetting                               = "notConfigured";
                    DeviceManagementBlockFactoryResetOnMobile            = $False;
                    DeviceManagementBlockManualUnenroll                  = $False;
                    DiagnosticsDataSubmissionMode                        = "userDefined";
                    DisplayAppListWithGdiDPIScalingTurnedOff             = @();
                    DisplayAppListWithGdiDPIScalingTurnedOn              = @();
                    DisplayName                                          = "device config";
                    EdgeAllowStartPagesModification                      = $False;
                    EdgeBlockAccessToAboutFlags                          = $False;
                    EdgeBlockAddressBarDropdown                          = $False;
                    EdgeBlockAutofill                                    = $False;
                    EdgeBlockCompatibilityList                           = $False;
                    EdgeBlockDeveloperTools                              = $False;
                    EdgeBlocked                                          = $False;
                    EdgeBlockEditFavorites                               = $False;
                    EdgeBlockExtensions                                  = $False;
                    EdgeBlockFullScreenMode                              = $False;
                    EdgeBlockInPrivateBrowsing                           = $False;
                    EdgeBlockJavaScript                                  = $False;
                    EdgeBlockLiveTileDataCollection                      = $False;
                    EdgeBlockPasswordManager                             = $False;
                    EdgeBlockPopups                                      = $False;
                    EdgeBlockPrelaunch                                   = $False;
                    EdgeBlockPrinting                                    = $False;
                    EdgeBlockSavingHistory                               = $False;
                    EdgeBlockSearchEngineCustomization                   = $False;
                    EdgeBlockSearchSuggestions                           = $False;
                    EdgeBlockSendingDoNotTrackHeader                     = $False;
                    EdgeBlockSendingIntranetTrafficToInternetExplorer    = $False;
                    EdgeBlockSideloadingExtensions                       = $False;
                    EdgeBlockTabPreloading                               = $False;
                    EdgeBlockWebContentOnNewTabPage                      = $False;
                    EdgeClearBrowsingDataOnExit                          = $False;
                    EdgeCookiePolicy                                     = "userDefined";
                    EdgeDisableFirstRunPage                              = $False;
                    EdgeFavoritesBarVisibility                           = "notConfigured";
                    EdgeHomeButtonConfigurationEnabled                   = $False;
                    EdgeHomepageUrls                                     = @();
                    EdgeKioskModeRestriction                             = "notConfigured";
                    EdgeOpensWith                                        = "notConfigured";
                    EdgePreventCertificateErrorOverride                  = $False;
                    EdgeRequiredExtensionPackageFamilyNames              = @();
                    EdgeRequireSmartScreen                               = $False;
                    EdgeSendIntranetTrafficToInternetExplorer            = $False;
                    EdgeShowMessageWhenOpeningInternetExplorerSites      = "notConfigured";
                    EdgeSyncFavoritesWithInternetExplorer                = $False;
                    EdgeTelemetryForMicrosoft365Analytics                = "notConfigured";
                    EnableAutomaticRedeployment                          = $False;
                    Ensure                                               = "Present";
                    ExperienceBlockDeviceDiscovery                       = $False;
                    ExperienceBlockErrorDialogWhenNoSIM                  = $False;
                    ExperienceBlockTaskSwitcher                          = $False;
                    ExperienceDoNotSyncBrowserSettings                   = "notConfigured";
                    FindMyFiles                                          = "notConfigured";
                    GameDvrBlocked                                       = $True;
                    InkWorkspaceAccess                                   = "notConfigured";
                    InkWorkspaceAccessState                              = "notConfigured";
                    InkWorkspaceBlockSuggestedApps                       = $False;
                    InternetSharingBlocked                               = $False;
                    LocationServicesBlocked                              = $False;
                    LockScreenActivateAppsWithVoice                      = "notConfigured";
                    LockScreenAllowTimeoutConfiguration                  = $False;
                    LockScreenBlockActionCenterNotifications             = $False;
                    LockScreenBlockCortana                               = $False;
                    LockScreenBlockToastNotifications                    = $False;
                    LogonBlockFastUserSwitching                          = $False;
                    MessagingBlockMMS                                    = $False;
                    MessagingBlockRichCommunicationServices              = $False;
                    MessagingBlockSync                                   = $False;
                    MicrosoftAccountBlocked                              = $False;
                    MicrosoftAccountBlockSettingsSync                    = $False;
                    MicrosoftAccountSignInAssistantSettings              = "notConfigured";
                    NetworkProxyApplySettingsDeviceWide                  = $False;
                    NetworkProxyDisableAutoDetect                        = $True;
                    NetworkProxyServer                                   = MSFT_MicrosoftGraphwindows10NetworkProxyServer{
                        UseForLocalAddresses = $True
                        Exceptions = @('*.domain2.com')
                        Address = 'proxy.domain.com:8080'
                    };
                    NfcBlocked                                           = $False;
                    OneDriveDisableFileSync                              = $False;
                    PasswordBlockSimple                                  = $False;
                    PasswordRequired                                     = $False;
                    PasswordRequiredType                                 = "deviceDefault";
                    PasswordRequireWhenResumeFromIdleState               = $False;
                    PowerButtonActionOnBattery                           = "notConfigured";
                    PowerButtonActionPluggedIn                           = "notConfigured";
                    PowerHybridSleepOnBattery                            = "notConfigured";
                    PowerHybridSleepPluggedIn                            = "notConfigured";
                    PowerLidCloseActionOnBattery                         = "notConfigured";
                    PowerLidCloseActionPluggedIn                         = "notConfigured";
                    PowerSleepButtonActionOnBattery                      = "notConfigured";
                    PowerSleepButtonActionPluggedIn                      = "notConfigured";
                    PrinterBlockAddition                                 = $False;
                    PrinterNames                                         = @();
                    PrivacyAdvertisingId                                 = "notConfigured";
                    PrivacyAutoAcceptPairingAndConsentPrompts            = $False;
                    PrivacyBlockActivityFeed                             = $False;
                    PrivacyBlockInputPersonalization                     = $False;
                    PrivacyBlockPublishUserActivities                    = $False;
                    PrivacyDisableLaunchExperience                       = $False;
                    ResetProtectionModeBlocked                           = $False;
                    SafeSearchFilter                                     = "userDefined";
                    ScreenCaptureBlocked                                 = $False;
                    SearchBlockDiacritics                                = $False;
                    SearchBlockWebResults                                = $False;
                    SearchDisableAutoLanguageDetection                   = $False;
                    SearchDisableIndexerBackoff                          = $False;
                    SearchDisableIndexingEncryptedItems                  = $False;
                    SearchDisableIndexingRemovableDrive                  = $False;
                    SearchDisableLocation                                = $False;
                    SearchDisableUseLocation                             = $False;
                    SearchEnableAutomaticIndexSizeManangement            = $False;
                    SearchEnableRemoteQueries                            = $False;
                    SecurityBlockAzureADJoinedDevicesAutoEncryption      = $False;
                    SettingsBlockAccountsPage                            = $False;
                    SettingsBlockAddProvisioningPackage                  = $False;
                    SettingsBlockAppsPage                                = $False;
                    SettingsBlockChangeLanguage                          = $False;
                    SettingsBlockChangePowerSleep                        = $False;
                    SettingsBlockChangeRegion                            = $False;
                    SettingsBlockChangeSystemTime                        = $False;
                    SettingsBlockDevicesPage                             = $False;
                    SettingsBlockEaseOfAccessPage                        = $False;
                    SettingsBlockEditDeviceName                          = $False;
                    SettingsBlockGamingPage                              = $False;
                    SettingsBlockNetworkInternetPage                     = $False;
                    SettingsBlockPersonalizationPage                     = $False;
                    SettingsBlockPrivacyPage                             = $False;
                    SettingsBlockRemoveProvisioningPackage               = $False;
                    SettingsBlockSettingsApp                             = $False;
                    SettingsBlockSystemPage                              = $False;
                    SettingsBlockTimeLanguagePage                        = $False;
                    SettingsBlockUpdateSecurityPage                      = $False;
                    SharedUserAppDataAllowed                             = $False;
                    SmartScreenAppInstallControl                         = "notConfigured";
                    SmartScreenBlockPromptOverride                       = $False;
                    SmartScreenBlockPromptOverrideForFiles               = $False;
                    SmartScreenEnableAppInstallControl                   = $False;
                    StartBlockUnpinningAppsFromTaskbar                   = $False;
                    StartMenuAppListVisibility                           = "userDefined";
                    StartMenuHideChangeAccountSettings                   = $False;
                    StartMenuHideFrequentlyUsedApps                      = $False;
                    StartMenuHideHibernate                               = $False;
                    StartMenuHideLock                                    = $False;
                    StartMenuHidePowerButton                             = $False;
                    StartMenuHideRecentJumpLists                         = $False;
                    StartMenuHideRecentlyAddedApps                       = $False;
                    StartMenuHideRestartOptions                          = $False;
                    StartMenuHideShutDown                                = $False;
                    StartMenuHideSignOut                                 = $False;
                    StartMenuHideSleep                                   = $False;
                    StartMenuHideSwitchAccount                           = $False;
                    StartMenuHideUserTile                                = $False;
                    StartMenuMode                                        = "userDefined";
                    StartMenuPinnedFolderDocuments                       = "notConfigured";
                    StartMenuPinnedFolderDownloads                       = "notConfigured";
                    StartMenuPinnedFolderFileExplorer                    = "notConfigured";
                    StartMenuPinnedFolderHomeGroup                       = "notConfigured";
                    StartMenuPinnedFolderMusic                           = "notConfigured";
                    StartMenuPinnedFolderNetwork                         = "notConfigured";
                    StartMenuPinnedFolderPersonalFolder                  = "notConfigured";
                    StartMenuPinnedFolderPictures                        = "notConfigured";
                    StartMenuPinnedFolderSettings                        = "notConfigured";
                    StartMenuPinnedFolderVideos                          = "notConfigured";
                    StorageBlockRemovableStorage                         = $False;
                    StorageRequireMobileDeviceEncryption                 = $False;
                    StorageRestrictAppDataToSystemVolume                 = $False;
                    StorageRestrictAppInstallToSystemVolume              = $False;
                    SupportsScopeTags                                    = $True;
                    TaskManagerBlockEndTask                              = $False;
                    TenantLockdownRequireNetworkDuringOutOfBoxExperience = $False;
                    UninstallBuiltInApps                                 = $False;
                    UsbBlocked                                           = $False;
                    VoiceRecordingBlocked                                = $False;
                    WebRtcBlockLocalhostIpAddress                        = $False;
                    WiFiBlockAutomaticConnectHotspots                    = $False;
                    WiFiBlocked                                          = $True;
                    WiFiBlockManualConfiguration                         = $True;
                    WindowsSpotlightBlockConsumerSpecificFeatures        = $False;
                    WindowsSpotlightBlocked                              = $False;
                    WindowsSpotlightBlockOnActionCenter                  = $False;
                    WindowsSpotlightBlockTailoredExperiences             = $False;
                    WindowsSpotlightBlockThirdPartyNotifications         = $False;
                    WindowsSpotlightBlockWelcomeExperience               = $False;
                    WindowsSpotlightBlockWindowsTips                     = $False;
                    WindowsSpotlightConfigureOnLockScreen                = "notConfigured";
                    WindowsStoreBlockAutoUpdate                          = $False;
                    WindowsStoreBlocked                                  = $False;
                    WindowsStoreEnablePrivateStoreOnly                   = $False;
                    WirelessDisplayBlockProjectionToThisDevice           = $False;
                    WirelessDisplayBlockUserInputFromReceiver            = $False;
                    WirelessDisplayRequirePinForPairing                  = $False;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationScepCertificatePolicyWindows10 'Example'
                {
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    CertificateStore               = "user";
                    CertificateValidityPeriodScale = "years";
                    CertificateValidityPeriodValue = 5;
                    CustomSubjectAlternativeNames  = @(
                        MSFT_MicrosoftGraphcustomSubjectAlternativeName{
                            SanType = 'domainNameService'
                            Name = 'dns'
                        }
                    );
                    DisplayName                    = "SCEP";
                    Ensure                         = "Present";
                    ExtendedKeyUsages              = @(
                        MSFT_MicrosoftGraphextendedKeyUsage{
                            ObjectIdentifier = '1.3.6.1.5.5.7.3.2'
                            Name = 'Client Authentication'
                        }
                    );
                    HashAlgorithm                  = "sha2";
                    KeySize                        = "size2048";
                    KeyStorageProvider             = "useTpmKspOtherwiseUseSoftwareKsp";
                    KeyUsage                       = @("digitalSignature");
                    RenewalThresholdPercentage     = 25;
                    ScepServerUrls                 = @("https://mydomain.com/certsrv/mscep/mscep.dll");
                    SubjectAlternativeNameType     = "none";
                    SubjectNameFormat              = "custom";
                    SubjectNameFormatString        = "CN={{UserName}},E={{EmailAddress}}";
                    RootCertificateId              = "169bf4fc-5914-40f4-ad33-48c225396183";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationSecureAssessmentPolicyWindows10 'Example'
                {
                    AllowPrinting            = $True;
                    AllowScreenCapture       = $True;
                    AllowTextSuggestion      = $True;
                    AssessmentAppUserModelId = "";
                    Assignments              = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    ConfigurationAccount     = "user@domain.com";
                    ConfigurationAccountType = "azureADAccount";
                    DisplayName              = "Secure Assessment";
                    Ensure                   = "Present";
                    LaunchUri                = "https://assessment.domain.com";
                    LocalGuestAccountName    = "";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationSharedMultiDevicePolicyWindows10 'Example'
                {
                    AccountManagerPolicy         = MSFT_MicrosoftGraphsharedPCAccountManagerPolicy{
                        CacheAccountsAboveDiskFreePercentage = 50
                        AccountDeletionPolicy = 'diskSpaceThreshold'
                        RemoveAccountsBelowDiskFreePercentage = 20
                    };
                    AllowedAccounts              = @("guest","domain");
                    AllowLocalStorage            = $True;
                    Assignments                  = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    DisableAccountManager        = $False;
                    DisableEduPolicies           = $False;
                    DisablePowerPolicies         = $False;
                    DisableSignInOnResume        = $False;
                    DisplayName                  = "Shared Multi device";
                    Enabled                      = $True;
                    Ensure                       = "Present";
                    FastFirstSignIn              = "notConfigured";
                    IdleTimeBeforeSleepInSeconds = 60;
                    LocalStorage                 = "enabled";
                    MaintenanceStartTime         = "00:03:00";
                    SetAccountManager            = "enabled";
                    SetEduPolicies               = "enabled";
                    SetPowerPolicies             = "enabled";
                    SignInOnResume               = "enabled";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationTrustedCertificatePolicyWindows10 'Example'
                {
                    Assignments            = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    CertFileName           = "RootCA.cer";
                    DestinationStore       = "computerCertStoreRoot";
                    DisplayName            = "Trusted Cert";
                    Ensure                 = "Present";
                    TrustedRootCertificate = "MIIEEjCCAvqgAwIBAgIPAMEAizw8iBHRPvZj7N9AMA0GCSqGSIb3DQEBBAUAMHAxKzApBgNVBAsTIkNvcHlyaWdodCAoYykgMTk5NyBNaWNyb3NvZnQgQ29ycC4xHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8GA1UEAxMYTWljcm9zb2Z0IFJvb3QgQXV0aG9yaXR5MB4XDTk3MDExMDA3MDAwMFoXDTIwMTIzMTA3MDAwMFowcDErMCkGA1UECxMiQ29weXJpZ2h0IChjKSAxOTk3IE1pY3Jvc29mdCBDb3JwLjEeMBwGA1UECxMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgUm9vdCBBdXRob3JpdHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpAr3BcOY78k4bKJ+XeF4w6qKpjSVf+P6VTKO3/p2iID58UaKboo9gMmvRQmR57qx2yVTa8uuchhyPn4Rms8VremIj1h083g8BkuiWxL8tZpqaaCaZ0Dosvwy1WCbBRucKPjiWLKkoOajsSYNC44QPu5psVWGsgnyhYC13TOmZtGQ7mlAcMQgkFJ+p55ErGOY9mGMUYFgFZZ8dN1KH96fvlALGG9O/VUWziYC/OuxUlE6u/ad6bXROrxjMlgkoIQBXkGBpN7tLEgc8Vv9b+6RmCgim0oFWV++2O14WgXcE2va+roCV/rDNf9anGnJcPMq88AijIjCzBoXJsyB3E4XfAgMBAAGjgagwgaUwgaIGA1UdAQSBmjCBl4AQW9Bw72lyniNRfhSyTY7/y6FyMHAxKzApBgNVBAsTIkNvcHlyaWdodCAoYykgMTk5NyBNaWNyb3NvZnQgQ29ycC4xHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8GA1UEAxMYTWljcm9zb2Z0IFJvb3QgQXV0aG9yaXR5gg8AwQCLPDyIEdE+9mPs30AwDQYJKoZIhvcNAQEEBQADggEBAJXoC8CN85cYNe24ASTYdxHzXGAyn54Lyz4FkYiPyTrmIfLwV5MstaBHyGLv/NfMOztaqTZUaf4kbT/JzKreBXzdMY09nxBwarv+Ek8YacD80EPjEVogT+pie6+qGcgrNyUtvmWhEoolD2Oj91Qc+SHJ1hXzUqxuQzIH/YIX+OVnbA1R9r3xUse958Qw/CAxCYgdlSkaTdUdAqXxgOADtFv0sd3IV+5lScdSVLa0AygS/5DW8AiPfriXxas3LOR65Kh343agANBqP8HSNorgQRKoNWobats14dQcBOSoRQTIWjM4bk0cDWK3CqKM09VUP0bNHFWmcNsSOoeTdZ+n0qA=";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationVpnPolicyWindows10 'Example'
                {
                    Assignments                                = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    AuthenticationMethod                       = "usernameAndPassword";
                    ConnectionName                             = "Cisco VPN";
                    ConnectionType                             = "ciscoAnyConnect";
                    CustomXml                                  = "";
                    DisplayName                                = "VPN";
                    DnsRules                                   = @(
                        MSFT_MicrosoftGraphvpnDnsRule{
                            Servers = @('10.0.1.10')
                            Name = 'NRPT rule'
                            Persistent = $True
                            AutoTrigger = $True
                        }
                    );
                    DnsSuffixes                                = @("mydomain.com");
                    EnableAlwaysOn                             = $True;
                    EnableConditionalAccess                    = $True;
                    EnableDnsRegistration                      = $True;
                    EnableSingleSignOnWithAlternateCertificate = $False;
                    EnableSplitTunneling                       = $False;
                    Ensure                                     = "Present";
                    ProfileTarget                              = "user";
                    ProxyServer                                = MSFT_MicrosoftGraphwindows10VpnProxyServer{
                        Port = 8081
                        BypassProxyServerForLocalAddress = $True
                        AutomaticConfigurationScriptUrl = ''
                        Address = '10.0.10.100'
                    };
                    RememberUserCredentials                    = $True;
                    ServerCollection                           = @(
                        MSFT_MicrosoftGraphvpnServer{
                            IsDefaultServer = $True
                            Description = 'gateway1'
                            Address = '10.0.1.10'
                        }
                    );
                    TrafficRules                               = @(
                        MSFT_MicrosoftGraphvpnTrafficRule{
                            Name = 'VPN rule'
                            AppType = 'none'
                            LocalAddressRanges = @(
                                MSFT_MicrosoftGraphIPv4Range{
                                    UpperAddress = '10.0.2.240'
                                    LowerAddress = '10.0.2.0'
                                }
                            )
                            RoutingPolicyType = 'forceTunnel'
                            VpnTrafficDirection = 'outbound'
                        }
                    );
                    TrustedNetworkDomains                      = @();
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationWindowsTeamPolicyWindows10 'Example'
                {
                    Assignments                            = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    );
                    AzureOperationalInsightsBlockTelemetry = $True;
                    ConnectAppBlockAutoLaunch              = $True;
                    DisplayName                            = "Device restrictions (Windows 10 Team)";
                    Ensure                                 = "Present";
                    MaintenanceWindowBlocked               = $False;
                    MaintenanceWindowDurationInHours       = 1;
                    MaintenanceWindowStartTime             = "00:00:00";
                    MiracastBlocked                        = $True;
                    MiracastChannel                        = "oneHundredFortyNine";
                    MiracastRequirePin                     = $True;
                    SettingsBlockMyMeetingsAndFiles        = $True;
                    SettingsBlockSessionResume             = $True;
                    SettingsBlockSigninSuggestions         = $True;
                    SupportsScopeTags                      = $True;
                    WelcomeScreenBlockAutomaticWakeUp      = $True;
                    WelcomeScreenMeetingInformation        = "showOrganizerAndTimeOnly";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceConfigurationWiredNetworkPolicyWindows10 'Example'
                {
                    Assignments                                           = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments
                        {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    AuthenticationBlockPeriodInMinutes                    = 5
                    AuthenticationMethod                                  = 'usernameAndPassword'
                    AuthenticationPeriodInSeconds                         = 60
                    AuthenticationRetryDelayPeriodInSeconds               = 5
                    AuthenticationType                                    = 'machine'
                    CacheCredentials                                      = $True
                    DisplayName                                           = 'Wired Network'
                    EapolStartPeriodInSeconds                             = 5
                    EapType                                               = 'teap'
                    Enforce8021X                                          = $True
                    Ensure                                                = 'Present'
                    MaximumAuthenticationFailures                         = 5
                    MaximumEAPOLStartMessages                             = 5
                    SecondaryAuthenticationMethod                         = 'certificate'
                    TrustedServerCertificateNames                         = @('srv.domain.com')
                    RootCertificatesForServerValidationIds                = @('a485d322-13cd-43ef-beda-733f656f48ea', '169bf4fc-5914-40f4-ad33-48c225396183')
                    SecondaryIdentityCertificateForClientAuthenticationId = '0b9aef2f-1671-4260-8eb9-3ab3138e176a'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceControlPolicyWindows10 'ConfigureDeviceControlPolicy'
                {
                    AllowStorageCard      = "1";
                    Assignments           = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '11111111-1111-1111-1111-111111111111'
                        }
                    );
                    Description           = 'Description'
                    DisplayName           = "Device Control";
                    DeviceInstall_IDs_Allow      = "1";
                    DeviceInstall_IDs_Allow_List = @("1234");
                    PolicyRule                   = @(
                        MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRule{
                            Name = 'asdf'
                            Entry = @(
                                MSFT_MicrosoftGraphIntuneSettingsCatalogPolicyRuleEntry{
                                    AccessMask = @(
                                        '1'
                                        '2'
                                    )
                                    Sid = '1234'
                                    ComputerSid = '1234'
                                    Type = 'allow'
                                    Options = '4'
                                }
                            )
                        }
                    );
                    Ensure                = "Present";
                    Id                    = '00000000-0000-0000-0000-000000000000'
                    RoleScopeTagIds       = @("0");
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceEnrollmentLimitRestriction 'DeviceEnrollmentLimitRestriction'
                {
                    DisplayName = 'My DSC Limit'
                    Description = 'My Restriction'
                    Limit       = 12
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceEnrollmentPlatformRestriction 'DeviceEnrollmentPlatformRestriction'
                {
                    AndroidForWorkRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    AndroidRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    Assignments                       = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        });
                    Description                       = "This is the default Device Type Restriction applied with the lowest priority to all users regardless of group membership.";
                    DeviceEnrollmentConfigurationType = "platformRestrictions";
                    DisplayName                       = "All users and all devices";
                    Ensure                            = "Present";
                    Identity                          = "3868d43e-873e-4416-8fd1-fc3d67c7c15c_DefaultPlatformRestrictions";
                    IosRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    MacOSRestriction                  = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    MacRestriction                    = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    WindowsHomeSkuRestriction         = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    WindowsMobileRestriction          = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $True
                        personalDeviceEnrollmentBlocked = $False
                    };
                    WindowsRestriction                = MSFT_DeviceEnrollmentPlatformRestriction{
                        platformBlocked = $False
                        personalDeviceEnrollmentBlocked = $False
                    };
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceEnrollmentStatusPageWindows10 '6b43c039-c1d0-4a9f-aab9-48c5531acbd6'
                {
                    AllowDeviceResetOnInstallFailure        = $True;
                    AllowDeviceUseOnInstallFailure          = $True;
                    AllowLogCollectionOnInstallFailure      = $True;
                    AllowNonBlockingAppInstallation         = $False;
                    Assignments                             = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    BlockDeviceSetupRetryByUser             = $False;
                    CustomErrorMessage                      = "Setup could not be completed. Please try again or contact your support person for help.";
                    Description                             = "This is the default enrollment status screen configuration applied with the lowest priority to all users and all devices regardless of group membership.";
                    DisableUserStatusTrackingAfterFirstUser = $True;
                    DisplayName                             = "All users and all devices";
                    Ensure                                  = "Present";
                    InstallProgressTimeoutInMinutes         = 60;
                    InstallQualityUpdates                   = $False;
                    Priority                                = 0;
                    SelectedMobileAppIds                    = @();
                    ShowInstallationProgress                = $True;
                    TrackInstallProgressForAutopilotOnly    = $True;
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile 'IntuneDeviceManagmentAndroidDeviceOwnerEnrollmentProfile-MyTestEnrollmentProfile'
                {
                    AccountId                 = "8d2ac1fd-0ac9-4047-af2f-f1e6323c9a34e";
                    ApplicationId             = $ApplicationId;
                    CertificateThumbprint     = $CertificateThumbprint;
                    ConfigureWifi             = $True;
                    Description               = "This is my enrollment profile";
                    DisplayName               = "MyTestEnrollmentProfile";
                    EnrolledDeviceCount       = 0;
                    EnrollmentMode            = "corporateOwnedDedicatedDevice";
                    EnrollmentTokenType       = "default";
                    EnrollmentTokenUsageCount = 0;
                    Ensure                    = "Present";
                    IsTeamsDeviceProfile      = $False;
                    RoleScopeTagIds           = @("0");
                    TenantId                  = $TenantId;
                    TokenCreationDateTime     = "10/26/2024 1:02:29 AM";
                    TokenExpirationDateTime   = "10/31/2024 3:59:59 AM";
                    WifiHidden                = $False;
                    WifiSecurityType          = "none";
                }
                IntuneDeviceRemediation 'ConfigureDeviceRemediation'
                {
                    Assignments              = @(
                        MSFT_IntuneDeviceRemediationPolicyAssignments{
                            RunSchedule = MSFT_IntuneDeviceRemediationRunSchedule{
                                Date = '2024-01-01'
                                Time = '01:00:00'
                                Interval = 1
                                DataType = '#microsoft.graph.deviceHealthScriptRunOnceSchedule'
                                UseUtc = $False
                            }
                            RunRemediationScript = $False
                            Assignment = MSFT_DeviceManagementConfigurationPolicyAssignments{
                                deviceAndAppManagementAssignmentFilterType = 'none'
                                dataType = '#microsoft.graph.groupAssignmentTarget'
                                groupId = '11111111-1111-1111-1111-111111111111'
                            }
                        }
                    );
                    Description              = 'Description'
                    DetectionScriptContent   = "Base64 encoded script content";
                    DeviceHealthScriptType   = "deviceHealthScript";
                    DisplayName              = "Device remediation";
                    EnforceSignatureCheck    = $False;
                    Ensure                   = "Present";
                    Id                       = '00000000-0000-0000-0000-000000000000'
                    Publisher                = "Some Publisher";
                    RemediationScriptContent = "Base64 encoded script content";
                    RoleScopeTagIds          = @("0");
                    RunAs32Bit               = $True;
                    RunAsAccount             = "system";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDiskEncryptionMacOS 'IntuneDiskEncryptionMacOS'
                {
                    AllowDeferralUntilSignOut           = $True;
                    Assignments                         = @();
                    Description                         = "test";
                    DisplayName                         = "test";
                    Enabled                             = $True;
                    Ensure                              = "Present";
                    NumberOfTimesUserCanIgnore          = -1;
                    PersonalRecoveryKeyHelpMessage      = "eeee";
                    PersonalRecoveryKeyRotationInMonths = 2;
                    RoleScopeTagIds                     = @("0");
                    SelectedRecoveryKeyTypes            = @("personalRecoveryKey");
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneDiskEncryptionWindows10 'myDiskEncryption'
                {
                    DisplayName        = 'Disk Encryption'
                    Assignments        = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        })
                    Description        = ''
                    IdentificationField_Name = '1'
                    IdentificationField = 'IdentificationField'
                    SecIdentificationField = 'SecIdentificationField'
                    Ensure             = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneEndpointDetectionAndResponsePolicyLinux 'myEDRPolicy'
                {
                    DisplayName     = 'Edr Policy'
                    tags_item_key   = '0'
                    tags_item_value = 'tag'
                    Assignments     = @()
                    Description     = 'My revised description'
                    Ensure          = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
        
                }
                IntuneEndpointDetectionAndResponsePolicyMacOS 'myEDRPolicy'
                {
                    DisplayName     = 'Edr Policy'
                    tags_item_key   = '0'
                    tags_item_value = 'tag'
                    Assignments     = @()
                    Description     = 'My revised description'
                    Ensure          = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
        
                }
                IntuneEndpointDetectionAndResponsePolicyWindows10 'myEDRPolicy'
                {
                    DisplayName = 'Edr Policy'
                    Assignments = @()
                    Description = 'My revised description'
                    Ensure      = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                    ConfigurationBlob = "Blob"
                    ConfigurationType = "onboard"
                    SampleSharing = 1
                }
                IntuneExploitProtectionPolicyWindows10SettingCatalog 'myWindows10ExploitProtectionPolicy'
                {
                    DisplayName                       = 'exploit Protection policy with assignments'
                    Assignments                       = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId                                    = 'e8cbd84d-be6a-4b72-87f0-0e677541fda0'
                        })
                    Description                       = ''
                    disallowexploitprotectionoverride = '1'
                    exploitprotectionsettings         = "<?xml version=`"1.0`" encoding=`"UTF-8`"?>
        <MitigationPolicy>
          <AppConfig Executable=`"AcroRd32.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"AcroRd32Info.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"clview.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"cnfnot32.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"excel.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"excelcnv.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ExtExport.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"graph.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ie4uinit.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ieinstal.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ielowutil.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ieUnatt.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"iexplore.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"lync.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msaccess.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"mscorsvw.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"msfeedssync.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"mshta.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msoadfsb.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msoasb.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msohtmed.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msosrec.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msoxmled.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"mspub.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"msqry32.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"MsSense.exe`">
            <StrictHandle Enable=`"true`" />
            <SEHOP Enable=`"true`" TelemetryOnly=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"ngen.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"ngentask.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"onenote.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"onenotem.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"orgchart.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"outlook.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"powerpnt.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"PresentationHost.exe`">
            <DEP Enable=`"true`" EmulateAtlThunks=`"false`" />
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" BottomUp=`"true`" HighEntropy=`"true`" />
            <SEHOP Enable=`"true`" TelemetryOnly=`"false`" />
            <Heap TerminateOnError=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"PrintDialog.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"RdrCEF.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"RdrServicesUpdater.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"runtimebroker.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"scanost.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"scanpst.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"sdxhelper.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"selfcert.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"setlang.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"SystemSettings.exe`">
            <ExtensionPoints DisableExtensionPoints=`"true`" />
          </AppConfig>
          <AppConfig Executable=`"winword.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
          <AppConfig Executable=`"wordconv.exe`">
            <ASLR ForceRelocateImages=`"true`" RequireInfo=`"false`" />
          </AppConfig>
        </MitigationPolicy>"
                    Ensure                            = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneFirewallPolicyWindows10 'ConfigureIntuneFirewallPolicyWindows10'
                {
                    Assignments           = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '11111111-1111-1111-1111-111111111111'
                        }
                    );
                    Description           = 'Description'
                    DisplayName           = "Intune Firewall Policy Windows10";
                    DisableStatefulFtp    = "false";
                    DomainProfile_AllowLocalIpsecPolicyMerge      = "false";
                    DomainProfile_EnableFirewall                  = "true";
                    DomainProfile_LogFilePath                     = "%systemroot%\system32\LogFiles\Firewall\pfirewall.log";
                    DomainProfile_LogMaxFileSize                  = 1024;
                    ObjectAccess_AuditFilteringPlatformPacketDrop = "1";
                    PrivateProfile_EnableFirewall                 = "true";
                    PublicProfile_EnableFirewall                  = "true";
                    Target                                        = "wsl";
                    AllowHostPolicyMerge                          = "false";
                    Ensure                = "Present";
                    Id                    = '00000000-0000-0000-0000-000000000000'
                    RoleScopeTagIds       = @("0");
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneMobileAppsMacOSLobApp 'IntuneMobileAppsMacOSLobApp-TeamsForBusinessInstaller'
                {
                    Id                    = "8d027f94-0682-431e-97c1-827d1879fa79";
                    Description           = "TeamsForBusinessInstaller";
                    Developer             = "Contoso";
                    DisplayName           = "TeamsForBusinessInstaller";
                    Ensure                = "Present";
                    InformationUrl        = "";
                    IsFeatured            = $False;
                    MinimumSupportedOperatingSystem = MSFT_DeviceManagementMinimumOperatingSystem{
                        v11_0 = $true
                    }
                    Notes                 = "";
                    Owner                 = "";
                    PrivacyInformationUrl = "";
                    Publisher             = "Contoso";
                    Assignments          = @(
                            MSFT_DeviceManagementMobileAppAssignment {
                                groupDisplayName = 'All devices'
                                deviceAndAppManagementAssignmentFilterType = 'none'
                                dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                                intent = 'required'
                            }
                            MSFT_DeviceManagementMobileAppAssignment{
                                deviceAndAppManagementAssignmentFilterType = 'none'
                                dataType = '#microsoft.graph.groupAssignmentTarget'
                                groupId = '57b5e81c-85bb-4644-a4fd-33b03e451c89'
                                intent = 'required'
                            }
                        );
                    Categories           = @(
                        MSFT_DeviceManagementMobileAppCategory {
                            Id  = '1bff2652-03ec-4a48-941c-152e93736515'
                            DisplayName = 'Kajal 3'
                        });
                }
                IntuneMobileAppsWindowsOfficeSuiteApp 'IntuneMobileAppsWindowsOfficeSuiteApp-Microsoft 365 Apps for Windows 10 and later'
                {
                    Id                    = "8e683524-4ec1-4813-bb3e-6256b2f293d"
                    Description           = "Microsoft 365 Apps for Windows 10 and laterr"
                    DisplayName           = "Microsoft 365 Apps for Windows 10 and later"
                    Ensure                = "Present";
                    InformationUrl        = "";
                    IsFeatured            = $False;
                    Notes                 = ""
                    PrivacyInformationUrl = ""
                    RoleScopeTagIds       = @()
                    Assignments          = @(
                        MSFT_DeviceManagementMobileAppAssignment{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '42c02b60-f28c-4eef-b3e1-973184cc4a6c'
                            intent = 'required'
                        }
                    );
                    Categories           = @(
                        MSFT_DeviceManagementMobileAppCategory {
                            Id  = '8e683524-4ec1-4813-bb3e-6256b2f293d8'
                            DisplayName = 'Productivity'
                        });
                    ApplicationId         = $ApplicationId
                    TenantId              = $TenantId
                    CertificateThumbprint = $CertificateThumbprint
                }
                IntuneMobileThreatDefenseConnector 'IntuneMobileThreatDefenseConnector-Microsoft Defender for Endpoint'
                {
                    AllowPartnerToCollectIosApplicationMetadata         = $False;
                    AllowPartnerToCollectIosPersonalApplicationMetadata = $False;
                    AndroidDeviceBlockedOnMissingPartnerData            = $False;
                    AndroidEnabled                                      = $False;
                    AndroidMobileApplicationManagementEnabled           = $False;
                    DisplayName                                         = "Microsoft Defender for Endpoint";
                    Id                                                  = "fc780465-2017-40d4-a0c5-307022471b92";
                    IosDeviceBlockedOnMissingPartnerData                = $False;
                    IosEnabled                                          = $False;
                    IosMobileApplicationManagementEnabled               = $False;
                    LastHeartbeatDateTime                               = "1/1/0001 12:00:00 AM";
                    MicrosoftDefenderForEndpointAttachEnabled           = $False;
                    PartnerState                                        = "notSetUp";
                    PartnerUnresponsivenessThresholdInDays              = 7;
                    PartnerUnsupportedOSVersionBlocked                  = $False;
                    WindowsDeviceBlockedOnMissingPartnerData            = $False;
                    WindowsEnabled                                      = $False;
                    Ensure                                              = "Present";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntunePolicySets 'Example'
                {
                    Assignments          = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.groupAssignmentTarget'
                            groupId = '12345678-1234-1234-1234-1234567890ab'
                        }
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId = '12345678-4321-4321-4321-1234567890ab'
                        }
                    );
                    Description          = "Example";
                    DisplayName          = "Example";
                    Ensure               = "Present";
                    GuidedDeploymentTags = @();
                    Items                = @(
                        MSFT_DeviceManagementConfigurationPolicyItems{
                            guidedDeploymentTags = @()
                            payloadId = 'T_12345678-90ab-90ab-90ab-1234567890ab'
                            displayName = 'Example-Policy'
                            dataType = '#microsoft.graph.managedAppProtectionPolicySetItem'
                            itemType = '#microsoft.graph.androidManagedAppProtection'
                        }
                    );
                    RoleScopeTags        = @("0","1");
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneRoleAssignment 'IntuneRoleAssignment'
                {
                    DisplayName                = 'test2'
                    Description                = 'test2'
                    Members                    = @('')
                    MembersDisplayNames        = @('SecGroup2')
                    ResourceScopes             = @('6eb76881-f56f-470f-be0d-672145d3dcb1')
                    ResourceScopesDisplayNames = @('')
                    ScopeType                  = 'resourceScope'
                    RoleDefinition             = '2d00d0fd-45e9-4166-904f-b76ac5eed2c7'
                    RoleDefinitionDisplayName  = 'This is my role'
                    Ensure                     = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneRoleDefinition 'IntuneRoleDefinition'
                {
                    DisplayName               = 'This is my role'
                    allowedResourceActions    = @('Microsoft.Intune_Organization_Read', 'Microsoft.Intune_Roles_Create', 'Microsoft.Intune_Roles_Read', 'Microsoft.Intune_Roles_Update')
                    Description               = 'My role defined by me.'
                    IsBuiltIn                 = $False
                    notallowedResourceActions = @()
                    roleScopeTagIds           = @('0', '1')
                    Ensure                    = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneSecurityBaselineDefenderForEndpoint 'mySecurityBaselineDefenderForEndpoint'
                {
                    DisplayName           = 'test'
                    DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineDefenderForEndpoint
                    {
                        BlockExecutionOfPotentiallyObfuscatedScripts = 'off'
                        AllowRealtimeMonitoring = '1'
                        BlockWin32APICallsFromOfficeMacros = 'warn'
                        CloudBlockLevel = '2'
                    }
                    UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineDefenderForEndpoint
                    {
                        DisableSafetyFilterOverrideForAppRepUnknown = '1'
                    }
                    Ensure                = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneSecurityBaselineMicrosoft365AppsForEnterprise 'mySecurityBaselineMicrosoft365AppsForEnterprisePolicy'
                {
                    DisplayName           = 'test'
                    DeviceSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
                    {
                        L_ProtectionFromZoneElevation = '1'
                        L_grooveexe98 = '1'
                        L_excelexe99 = '1'
                        L_mspubexe100 = '1'
                        L_powerpntexe101 = '1'
                        L_pptviewexe102 = '1'
                        L_visioexe103 = '1'
                        L_winprojexe104 = '1'
                        L_winwordexe105 = '1'
                        L_outlookexe106 = '1'
                        L_spdesignexe107 = '1'
                        L_exprwdexe108 = '1'
                        L_msaccessexe109 = '1'
                        L_onenoteexe110 = '1'
                        L_mse7exe111 = '1'
                    }
                    UserSettings = MSFT_MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise
                    {
                        MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet = '1'
                        MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy = '1'
                        MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty = '3'
                    }
                    Ensure                = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneSecurityBaselineMicrosoftEdge 'mySecurityBaselineMicrosoftEdge'
                {
                    DisplayName           = 'test'
                    InsecurePrivateNetworkRequestsAllowed                   = "0";
                    InternetExplorerIntegrationReloadInIEModeAllowed        = "0";
                    InternetExplorerIntegrationZoneIdentifierMhtFileAllowed = "0";
                    InternetExplorerModeToolbarButtonEnabled                = "0";
                    Ensure                = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneSettingCatalogASRRulesPolicyWindows10 'myASRRulesPolicy'
                {
                    DisplayName                                                                = 'asr 2'
                    Assignments                                                                = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        })
                    attacksurfacereductiononlyexclusions                                       = @('Test 10', 'Test2', 'Test3')
                    blockabuseofexploitedvulnerablesigneddrivers                               = 'block'
                    blockexecutablefilesrunningunlesstheymeetprevalenceagetrustedlistcriterion = 'audit'
                    Description                                                                = 'Post'
                    Ensure                                                                     = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneSettingCatalogCustomPolicyWindows10 'Example'
                {
                    Assignments           = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    Description           = "";
                    Ensure                = "Present";
                    Name                  = "Setting Catalog Raw - DSC";
                    Platforms             = "windows10";
                    Settings              = @(
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                                    Value = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock_1'
                                }
                                SettingDefinitionId = 'device_vendor_msft_policy_config_abovelock_allowcortanaabovelock'
                                odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                            }
                        }
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_defaultassociationsconfiguration'
                                simpleSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationSimpleSettingValue{
                                    odataType = '#microsoft.graph.deviceManagementConfigurationStringSettingValue'
                                    StringValue = ''
                                }
                                odataType = '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
                            }
                        }
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                                    Value = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers_1'
                                }
                                SettingDefinitionId = 'device_vendor_msft_policy_config_applicationdefaults_enableappurihandlers'
                                odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                            }
                        }
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                                    Value = 'device_vendor_msft_policy_config_defender_allowarchivescanning_1'
                                }
                                SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowarchivescanning'
                                odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                            }
                        }
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                                    Value = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring_1'
                                }
                                SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowbehaviormonitoring'
                                odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                            }
                        }
                        MSFT_MicrosoftGraphdeviceManagementConfigurationSetting{
                            SettingInstance = MSFT_MicrosoftGraphDeviceManagementConfigurationSettingInstance{
                                choiceSettingValue = MSFT_MicrosoftGraphDeviceManagementConfigurationChoiceSettingValue{
                                    Value = 'device_vendor_msft_policy_config_defender_allowcloudprotection_1'
                                }
                                SettingDefinitionId = 'device_vendor_msft_policy_config_defender_allowcloudprotection'
                                odataType = '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
                            }
                        }
                    );
                    Technologies          = "mdm";
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWiFiConfigurationPolicyAndroidDeviceAdministrator 'myWifiConfigAndroidDevicePolicy'
                {
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $False
                    ConnectWhenNetworkNameIsHidden = $True
                    DisplayName                    = 'Wifi Configuration Androind Device'
                    NetworkName                    = 'b71f8c63-8140-4c7e-b818-f9b4aa98b79b'
                    Ssid                           = 'sf'
                    WiFiSecurityType               = 'wpaEnterprise'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyAndroidEnterpriseDeviceOwner 'myWifiConfigAndroidDeviceOwnerPolicy'
                {
                    DisplayName                    = 'Wifi - androidForWork'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments
                        {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $False
                    ConnectWhenNetworkNameIsHidden = $False
                    NetworkName                    = 'myNetwork'
                    PreSharedKeyIsSet              = $True
                    ProxySettings                  = 'none'
                    Ssid                           = 'MySSID - 3'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyAndroidEnterpriseWorkProfile 'myWifiConfigAndroidWorkProfilePolicy'
                {
                    DisplayName                    = 'wifi - android BYOD'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments
                        {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $False
                    ConnectWhenNetworkNameIsHidden = $False
                    NetworkName                    = 'f8b79489-84fc-4434-b964-2a18dfe08f88'
                    Ssid                           = 'MySSID'
                    WiFiSecurityType               = 'open'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyAndroidForWork 'Example'
                {
                    DisplayName                    = 'AndroindForWork'
                    Description                    = 'DSC'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                            deviceAndAppManagementAssignmentFilterType = 'include'
                            deviceAndAppManagementAssignmentFilterId   = '17cb2318-cd4f-4a66-b742-6b79d4966ac7'
                            groupId                                    = 'b9b732df-9f18-4c5f-99d1-682e151ec62b'
                            collectionId                               = '2a8ea71f-039a-4ec8-8e41-5fba3ef9efba'
                        }
                    )
                    ConnectAutomatically           = $true
                    ConnectWhenNetworkNameIsHidden = $true
                    NetworkName                    = 'CorpNet'
                    Ssid                           = 'WiFi'
                    WiFiSecurityType               = 'wpa2Enterprise'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyAndroidOpenSourceProject 'myWifiConfigAndroidOpensourcePolicy'
                {
                    DisplayName                    = 'wifi aosp'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $False
                    ConnectWhenNetworkNameIsHidden = $True
                    NetworkName                    = 'aaaa'
                    PreSharedKeyIsSet              = $True
                    Ssid                           = 'aaaaa'
                    WiFiSecurityType               = 'wpaPersonal'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyIOS 'myWifiConfigIOSPolicy'
                {
                    DisplayName                    = 'ios wifi'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $True
                    ConnectWhenNetworkNameIsHidden = $True
                    DisableMacAddressRandomization = $True
                    NetworkName                    = 'aaaaa'
                    ProxyAutomaticConfigurationUrl = 'THSCP.local'
                    ProxySettings                  = 'automatic'
                    Ssid                           = 'aaaaa'
                    WiFiSecurityType               = 'wpaPersonal'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyMacOS 'myWifiConfigMacOSPolicy'
                {
                    DisplayName                    = 'macos wifi'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $True
                    ConnectWhenNetworkNameIsHidden = $True
                    NetworkName                    = 'ea1cf5d7-8d3e-40ca-9cb8-b8c8a4c6170b'
                    ProxyAutomaticConfigurationUrl = 'AZ500PrivateEndpoint22'
                    ProxySettings                  = 'automatic'
                    Ssid                           = 'aaaaaaaaaaaaa'
                    WiFiSecurityType               = 'wpaPersonal'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWifiConfigurationPolicyWindows10 'myWifiConfigWindows10Policy'
                {
                    DisplayName                    = 'win10 wifi - revised'
                    Assignments                    = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    )
                    ConnectAutomatically           = $True
                    ConnectToPreferredNetwork      = $True
                    ConnectWhenNetworkNameIsHidden = $True
                    ForceFIPSCompliance            = $True
                    MeteredConnectionLimit         = 'fixed'
                    NetworkName                    = 'MyWifi'
                    ProxyAutomaticConfigurationUrl = 'https://proxy.contoso.com'
                    ProxySetting                   = 'automatic'
                    Ssid                           = 'ssid'
                    WifiSecurityType               = 'wpa2Personal'
                    Ensure                         = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsAutopilotDeploymentProfileAzureADHybridJoined 'Example'
                {
                    Assignments                            = @();
                    Description                            = "";
                    DeviceNameTemplate                     = "";
                    DeviceType                             = "windowsPc";
                    DisplayName                            = "hybrid";
                    EnableWhiteGlove                       = $True;
                    Ensure                                 = "Present";
                    ExtractHardwareHash                    = $False;
                    HybridAzureADJoinSkipConnectivityCheck = $True;
                    Language                               = "os-default";
                    OutOfBoxExperienceSettings             = MSFT_MicrosoftGraphoutOfBoxExperienceSettings{
                        HideEULA = $True
                        HideEscapeLink = $True
                        HidePrivacySettings = $True
                        DeviceUsageType = 'singleUser'
                        SkipKeyboardSelectionPage = $False
                        UserType = 'standard'
                    };
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsAutopilotDeploymentProfileAzureADJoined 'Example'
                {
                    Assignments                = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType = '#microsoft.graph.allDevicesAssignmentTarget'
                        }
                    );
                    Description                = "";
                    DeviceNameTemplate         = "test";
                    DeviceType                 = "windowsPc";
                    DisplayName                = "AAD";
                    EnableWhiteGlove           = $True;
                    Ensure                     = "Present";
                    ExtractHardwareHash        = $True;
                    Language                   = "";
                    OutOfBoxExperienceSettings = MSFT_MicrosoftGraphoutOfBoxExperienceSettings1{
                        HideEULA = $False
                        HideEscapeLink = $True
                        HidePrivacySettings = $True
                        DeviceUsageType = 'singleUser'
                        SkipKeyboardSelectionPage = $True
                        UserType = 'administrator'
                    };
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsInformationProtectionPolicyWindows10MdmEnrolled 'Example'
                {
                    DisplayName                            = 'WIP'
                    AzureRightsManagementServicesAllowed   = $False
                    Description                            = 'DSC'
                    EnforcementLevel                       = 'encryptAndAuditOnly'
                    EnterpriseDomain                       = 'domain.co.uk'
                    EnterpriseIPRanges                     = @(
                        MSFT_MicrosoftGraphwindowsInformationProtectionIPRangeCollection {
                            DisplayName = 'ipv4 range'
                            Ranges      = @(
                                MSFT_MicrosoftGraphIpRange {
                                    UpperAddress = '1.1.1.3'
                                    LowerAddress = '1.1.1.1'
                                    odataType    = '#microsoft.graph.iPv4Range'
                                }
                            )
                        }
                    )
                    EnterpriseIPRangesAreAuthoritative     = $True
                    EnterpriseProxyServersAreAuthoritative = $True
                    IconsVisible                           = $False
                    IndexingEncryptedStoresOrItemsBlocked  = $False
                    ProtectedApps                          = @(
                        MSFT_MicrosoftGraphwindowsInformationProtectionApp {
                            Description   = 'Microsoft.MicrosoftEdge'
                            odataType     = '#microsoft.graph.windowsInformationProtectionStoreApp'
                            Denied        = $False
                            PublisherName = 'CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US'
                            ProductName   = 'Microsoft.MicrosoftEdge'
                            DisplayName   = 'Microsoft Edge'
                        }
                    )
                    ProtectionUnderLockConfigRequired      = $False
                    RevokeOnUnenrollDisabled               = $False
                    Ensure                                 = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsUpdateForBusinessDriverUpdateProfileWindows10 'Example'
                {
                    DisplayName  = 'Driver Update Example'
                    Assignments  = @()
                    Description  = 'test 2'
                    approvalType = 'manual'
                    Ensure       = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsUpdateForBusinessFeatureUpdateProfileWindows10 'Example'
                {
                    DisplayName          = 'WUfB Feature -dsc'
                    Assignments          = @()
                    Description          = 'test 2'
                    FeatureUpdateVersion = 'Windows 10, version 22H2'
                    RolloutSettings = MSFT_MicrosoftGraphwindowsUpdateRolloutSettings {
                        OfferStartDateTimeInUTC = '2023-02-03T16:00:00.0000000+00:00'
                    }
                    Ensure               = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsUpdateForBusinessQualityUpdateProfileWindows10 'Example'
                {
                    Assignments             = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments{
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            groupDisplayName = 'Exclude'
                            dataType         = '#microsoft.graph.exclusionGroupAssignmentTarget'
                            groupId          = '258a1749-8408-4dd0-8028-fab6208a28d7'
                        }
                    );
                    DisplayName              = 'Windows Quality Update'
                    Description              = ''
                    ExpeditedUpdateSettings = MSFT_MicrosoftGraphexpeditedWindowsQualityUpdateSettings{
                        QualityUpdateRelease  = '2024-06-11T00:00:00Z'
                        DaysUntilForcedReboot = 0
                    }
                    RoleScopeTagIds           = @("0")
                    Ensure                    = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
                IntuneWindowsUpdateForBusinessRingUpdateProfileWindows10 'Example'
                {
                    DisplayName                         = 'WUfB Ring'
                    AllowWindows11Upgrade               = $False
                    Assignments                         = @(
                        MSFT_DeviceManagementConfigurationPolicyAssignments
                        {
                            deviceAndAppManagementAssignmentFilterType = 'none'
                            dataType                                   = '#microsoft.graph.allLicensedUsersAssignmentTarget'
                        }
                    )
                    AutomaticUpdateMode                 = 'autoInstallAtMaintenanceTime'
                    AutoRestartNotificationDismissal    = 'notConfigured'
                    BusinessReadyUpdatesOnly            = 'userDefined'
                    DeadlineForFeatureUpdatesInDays     = 1
                    DeadlineForQualityUpdatesInDays     = 2
                    DeadlineGracePeriodInDays           = 3
                    DeliveryOptimizationMode            = 'userDefined'
                    Description                         = ''
                    DriversExcluded                     = $False
                    FeatureUpdatesDeferralPeriodInDays  = 0
                    FeatureUpdatesPaused                = $False
                    FeatureUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
                    FeatureUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
                    FeatureUpdatesRollbackWindowInDays  = 10
                    InstallationSchedule = MSFT_MicrosoftGraphwindowsUpdateInstallScheduleType {
                        ActiveHoursStart = '08:00:00'
                        ActiveHoursEnd   = '17:00:00'
                        odataType        = '#microsoft.graph.windowsUpdateActiveHoursInstall'
                    }
                    MicrosoftUpdateServiceAllowed       = $True
                    PostponeRebootUntilAfterDeadline    = $False
                    PrereleaseFeatures                  = 'userDefined'
                    QualityUpdatesDeferralPeriodInDays  = 0
                    QualityUpdatesPaused                = $False
                    QualityUpdatesPauseExpiryDateTime   = '0001-01-01T00:00:00.0000000+00:00'
                    QualityUpdatesRollbackStartDateTime = '0001-01-01T00:00:00.0000000+00:00'
                    SkipChecksBeforeRestart             = $False
                    UpdateNotificationLevel             = 'defaultNotifications'
                    UserPauseAccess                     = 'enabled'
                    UserWindowsUpdateScanAccess         = 'enabled'
                    Ensure                              = 'Present'
                    ApplicationId         = $ApplicationId;
                    TenantId              = $TenantId;
                    CertificateThumbprint = $CertificateThumbprint;
                }
        }
    }

    $ConfigurationData = @{
        AllNodes = @(
            @{
                NodeName                    = "Localhost"
                PSDSCAllowPlaintextPassword = $true
            }
        )
    }

    # Compile and deploy configuration
    try
    {
        Master -ConfigurationData $ConfigurationData -ApplicationId $ApplicationId -TenantId $TenantId -CertificateThumbprint $CertificateThumbprint
        Start-DscConfiguration Master -Wait -Force -Verbose -ErrorAction Stop
    }
    catch
    {
        throw $_
    }
