# IntuneDeviceConfigurationScepCertificatePolicyWindows10

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **CertificateStore** | Write | String | Target store certificate. Possible values are: user, machine. | `user`, `machine` |
| **HashAlgorithm** | Write | String | SCEP Hash Algorithm. Possible values are: sha1, sha2. | `sha1`, `sha2` |
| **KeySize** | Write | String | SCEP Key Size. Possible values are: size1024, size2048, size4096. | `size1024`, `size2048`, `size4096` |
| **KeyUsage** | Write | StringArray[] | SCEP Key Usage. Possible values are: keyEncipherment, digitalSignature. | `keyEncipherment`, `digitalSignature` |
| **ScepServerUrls** | Write | StringArray[] | SCEP Server Url(s). | |
| **SubjectAlternativeNameFormatString** | Write | String | Custom String that defines the AAD Attribute. | |
| **SubjectNameFormatString** | Write | String | Custom format to use with SubjectNameFormat = Custom. Example: CN={{UserName}},E={{EmailAddress}},OU=Enterprise Users,O=Contoso Corporation,L=Redmond,ST=WA,C=US | |
| **CustomSubjectAlternativeNames** | Write | MSFT_MicrosoftGraphcustomSubjectAlternativeName[] | Custom Subject Alternative Name Settings. This collection can contain a maximum of 500 elements. | |
| **ExtendedKeyUsages** | Write | MSFT_MicrosoftGraphextendedKeyUsage[] | Extended Key Usage (EKU) settings. This collection can contain a maximum of 500 elements. | |
| **CertificateValidityPeriodScale** | Write | String | Scale for the Certificate Validity Period. Possible values are: days, months, years. | `days`, `months`, `years` |
| **CertificateValidityPeriodValue** | Write | UInt32 | Value for the Certificate Validity Period | |
| **KeyStorageProvider** | Write | String | Key Storage Provider (KSP). Possible values are: useTpmKspOtherwiseUseSoftwareKsp, useTpmKspOtherwiseFail, usePassportForWorkKspOtherwiseFail, useSoftwareKsp. | `useTpmKspOtherwiseUseSoftwareKsp`, `useTpmKspOtherwiseFail`, `usePassportForWorkKspOtherwiseFail`, `useSoftwareKsp` |
| **RenewalThresholdPercentage** | Write | UInt32 | Certificate renewal threshold percentage. Valid values 1 to 99 | |
| **SubjectAlternativeNameType** | Write | String | Certificate Subject Alternative Name Type. Possible values are: none, emailAddress, userPrincipalName, customAzureADAttribute, domainNameService, universalResourceIdentifier. | `none`, `emailAddress`, `userPrincipalName`, `customAzureADAttribute`, `domainNameService`, `universalResourceIdentifier` |
| **SubjectNameFormat** | Write | String | Certificate Subject Name Format. Possible values are: commonName, commonNameIncludingEmail, commonNameAsEmail, custom, commonNameAsIMEI, commonNameAsSerialNumber, commonNameAsAadDeviceId, commonNameAsIntuneDeviceId, commonNameAsDurableDeviceId. | `commonName`, `commonNameIncludingEmail`, `commonNameAsEmail`, `custom`, `commonNameAsIMEI`, `commonNameAsSerialNumber`, `commonNameAsAadDeviceId`, `commonNameAsIntuneDeviceId`, `commonNameAsDurableDeviceId` |
| **RootCertificateDisplayName** | Write | String | Trusted Root Certificate DisplayName | |
| **RootCertificateId** | Write | String | Trusted Root Certificate Id | |
| **Description** | Write | String | Admin provided description of the Device Configuration. | |
| **DisplayName** | Key | String | Admin provided name of the device configuration. | |
| **Id** | Write | String | The unique identifier for an entity. Read-only. | |
| **Assignments** | Write | MSFT_DeviceManagementConfigurationPolicyAssignments[] | Represents the assignment to the Intune policy. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_DeviceManagementConfigurationPolicyAssignments

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. | `#microsoft.graph.groupAssignmentTarget`, `#microsoft.graph.allLicensedUsersAssignmentTarget`, `#microsoft.graph.allDevicesAssignmentTarget`, `#microsoft.graph.exclusionGroupAssignmentTarget`, `#microsoft.graph.configurationManagerCollectionAssignmentTarget` |
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. | `none`, `include`, `exclude` |
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. | |
| **groupId** | Write | String | The group Id that is the target of the assignment. | |
| **groupDisplayName** | Write | String | The group Display Name that is the target of the assignment. | |
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) | |

### MSFT_MicrosoftGraphCustomSubjectAlternativeName

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Custom SAN Name | |
| **SanType** | Write | String | Custom SAN Type. Possible values are: none, emailAddress, userPrincipalName, customAzureADAttribute, domainNameService, universalResourceIdentifier. | `none`, `emailAddress`, `userPrincipalName`, `customAzureADAttribute`, `domainNameService`, `universalResourceIdentifier` |

### MSFT_MicrosoftGraphExtendedKeyUsage

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | Extended Key Usage Name | |
| **ObjectIdentifier** | Write | String | Extended Key Usage Object Identifier | |


## Description

Intune Device Configuration Scep Certificate Policy for Windows10

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

#### Application permissions

- **Read**

    - Group.Read.All, DeviceManagementConfiguration.Read.All

- **Update**

    - Group.Read.All, DeviceManagementConfiguration.ReadWrite.All

## Examples

### Example 1

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
    }
}
```

### Example 2

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
            RenewalThresholdPercentage     = 30; # Updated Property
            ScepServerUrls                 = @("https://mydomain.com/certsrv/mscep/mscep.dll");
            SubjectAlternativeNameType     = "none";
            SubjectNameFormat              = "custom";
            SubjectNameFormatString        = "CN={{UserName}},E={{EmailAddress}}";
            RootCertificateId              = "169bf4fc-5914-40f4-ad33-48c225396183";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

### Example 3

This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.

```powershell
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
        IntuneDeviceConfigurationScepCertificatePolicyWindows10 'Example'
        {
            DisplayName                    = "SCEP";
            Ensure                         = "Absent";
            ApplicationId         = $ApplicationId;
            TenantId              = $TenantId;
            CertificateThumbprint = $CertificateThumbprint;
        }
    }
}
```

