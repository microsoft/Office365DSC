# AADIdentityB2XUserFlow

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **ApiConnectorConfiguration** | Write | MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration | Configuration for enabling an API connector for use as part of the self-service sign-up user flow. You can only obtain the value of this object using Get userFlowApiConnectorConfiguration. | |
| **Id** | Key | String | The unique identifier for an entity. Read-only. | |
| **IdentityProviders** | Write | StringArray[] | The identity providers included in the user flow. | |
| **UserAttributeAssignments** | Write | MSFT_MicrosoftGraphuserFlowUserAttributeAssignment[] | The user attribute assignments included in the user flow. | |
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. | `Present`, `Absent` |
| **Credential** | Write | PSCredential | Credentials of the Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |

### MSFT_MicrosoftGraphUserFlowApiConnectorConfiguration

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **postFederationSignupConnectorName** | Write | String | The name of the connector used for post federation signup step. | |
| **postAttributeCollectionConnectorName** | Write | String | The name of the connector used for post attribute collection step. | |

### MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Write | String | The display name of the property displayed to the end user in the user flow. | |
| **Value** | Write | String | The value that is set when this item is selected. | |
| **IsDefault** | Write | Boolean | Used to set the value as the default. | |

### MSFT_MicrosoftGraphuserFlowUserAttributeAssignment

#### Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Id** | Write | String | The unique identifier of identityUserFlowAttributeAssignment. | |
| **DisplayName** | Write | String | The display name of the identityUserFlowAttribute within a user flow. | |
| **IsOptional** | Write | Boolean | Determines whether the identityUserFlowAttribute is optional. | |
| **UserInputType** | Write | String | User Flow Attribute Input Type. | `textBox`, `dateTimeDropdown`, `radioSingleSelect`, `dropdownSingleSelect`, `emailBox`, `checkboxMultiSelect` |
| **UserAttributeValues** | Write | MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues[] | The list of user attribute values for this assignment. | |


## Description

Azure AD Identity B2 X User Flow

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - IdentityUserFlow.Read.All

- **Update**

    - None

#### Application permissions

- **Read**

    - IdentityUserFlow.Read.All

- **Update**

    - None

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
        AADIdentityB2XUserFlow "AADIdentityB2XUserFlow-B2X_1_TestFlow"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            ApiConnectorConfiguration = MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration
            {
                postAttributeCollectionConnectorName = 'RestApi_f6e8e73d-6b17-433e-948f-f578f12bd57c'
                postFederationSignupConnectorName = 'RestApi_beeb7152-673c-48b3-b143-9975949a93ca'
            };
            Credential                = $Credscredential;
            Ensure                    = "Present";
            Id                        = "B2X_1_TestFlow";
            IdentityProviders         = @("MSASignup-OAUTH","EmailOtpSignup-OAUTH");
            UserAttributeAssignments  = @(
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'textBox'
                    IsOptional = $True
                    DisplayName = 'Email Address'
                    Id = 'emailReadonly'

                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'dropdownSingleSelect'
                    IsOptional = $True
                    DisplayName = 'Random'
                    Id = 'city'
                    UserAttributeValues = @(
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'S'
                            Value = '2'
                        }
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'X'
                            Value = '1'
                        }
                    )
                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment{
                    UserInputType = 'textBox'
                    IsOptional = $False
                    DisplayName = 'Piyush1'
                    Id = 'extension_91d51274096941f786b07b9d723d93f4_Piyush1'

                }
            );
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
        AADIdentityB2XUserFlow "AADIdentityB2XUserFlow-B2X_1_TestFlow"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            ApiConnectorConfiguration = MSFT_MicrosoftGraphuserFlowApiConnectorConfiguration
            {
                postAttributeCollectionConnectorName = 'RestApi_f6e8e73d-6b17-433e-948f-f578f12bd57c'
                postFederationSignupConnectorName = 'RestApi_beeb7152-673c-48b3-b143-9975949a93ca'
            };
            Credential                = $Credscredential;
            Ensure                    = "Present";
            Id                        = "B2X_1_TestFlow";
            IdentityProviders         = @("MSASignup-OAUTH","EmailOtpSignup-OAUTH");
            UserAttributeAssignments  = @(
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'textBox'
                    IsOptional = $True
                    DisplayName = 'Email Address'
                    Id = 'emailReadonly'

                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment
                {
                    UserInputType = 'dropdownSingleSelect'
                    IsOptional = $True
                    DisplayName = 'Random'
                    Id = 'city'
                    UserAttributeValues = @(
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'S'
                            Value = '2'
                        }
                        MSFT_MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues
                        {
                            IsDefault = $True
                            Name = 'X'
                            Value = '1'
                        }
                    )
                }
                MSFT_MicrosoftGraphuserFlowUserAttributeAssignment{
                    UserInputType = 'textBox'
                    IsOptional = $False
                    DisplayName = 'Piyush1'
                    Id = 'extension_91d51274096941f786b07b9d723d93f4_Piyush1'

                }
            );
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
        AADIdentityB2XUserFlow "AADIdentityB2XUserFlow-B2X_1_TestFlow"
        {
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            CertificateThumbprint     = $CertificateThumbprint
            Id                        = "B2X_1_TestFlow";
        }
    }
}
```

