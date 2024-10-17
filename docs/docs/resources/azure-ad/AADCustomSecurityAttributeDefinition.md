# AADCustomSecurityAttributeDefinition

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Name of the custom security attribute. Must be unique within an attribute set. Can be up to 32 characters long and include Unicode characters. Can't contain spaces or special characters. Can't be changed later. Case sensitive. | |
| **AttributeSet** | Key | String | Name of the attribute set. Case sensitive. | |
| **Id** | Write | String | Unique identifier of the Attribute Definition. | |
| **Description** | Write | String | Description of the custom security attribute. Can be up to 128 characters long and include Unicode characters. Can't contain spaces or special characters. Can be changed later.  | |
| **IsCollection** | Write | Boolean | Indicates whether multiple values can be assigned to the custom security attribute. Can't be changed later. If type is set to Boolean, isCollection can't be set to true. | |
| **IsSearchable** | Write | Boolean | Indicates whether custom security attribute values are indexed for searching on objects that are assigned attribute values. Can't be changed later. | |
| **Status** | Write | String | Specifies whether the custom security attribute is active or deactivated. Acceptable values are Available and Deprecated. Can be changed later. | |
| **Type** | Write | String | Data type for the custom security attribute values. Supported types are: Boolean, Integer, and String. Can't be changed later. | |
| **UsePreDefinedValuesOnly** | Write | Boolean | Indicates whether only predefined values can be assigned to the custom security attribute. If set to false, free-form values are allowed. Can later be changed from true to false, but can't be changed from false to true. If type is set to Boolean, usePreDefinedValuesOnly can't be set to true. | |
| **Ensure** | Write | String | Present ensures the instance exists, absent ensures it is removed. | `Absent`, `Present` |
| **Credential** | Write | PSCredential | Credentials of the workload's Admin | |
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. | |
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. | |
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. | |
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. | |
| **AccessTokens** | Write | StringArray[] | Access token used for authentication. | |


## Description

Configures custom security attribute definitions in Entra Id.

## Permissions

### Microsoft Graph

To authenticate with the Microsoft Graph API, this resource required the following permissions:

#### Delegated permissions

- **Read**

    - None

- **Update**

    - None

#### Application permissions

- **Read**

    - CustomSecAttributeDefinition.Read.All

- **Update**

    - CustomSecAttributeDefinition.ReadWrite.All

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
        AADCustomSecurityAttributeDefinition "AADCustomSecurityAttributeDefinition-ShoeSize"
        {
            ApplicationId           = $ApplicationId;
            AttributeSet            = "TestAttributeSet";
            CertificateThumbprint   = $CertificateThumbprint;
            Ensure                  = "Present";
            IsCollection            = $False;
            IsSearchable            = $True;
            Name                    = "ShoeSize";
            Status                  = "Available";
            TenantId                = $TenantId;
            Type                    = "String";
            UsePreDefinedValuesOnly = $False;
            Description             = "What size of shoe is the person wearing?"
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
        AADCustomSecurityAttributeDefinition "AADCustomSecurityAttributeDefinition-ShoeSize"
        {
            ApplicationId           = $ApplicationId;
            AttributeSet            = "TestAttributeSet";
            CertificateThumbprint   = $CertificateThumbprint;
            Ensure                  = "Present";
            IsCollection            = $False;
            IsSearchable            = $True;
            Name                    = "ShoeSize";
            Status                  = "Available";
            TenantId                = $TenantId;
            Type                    = "String";
            UsePreDefinedValuesOnly = $False;
            Description             = "What size of shoe is the person wearing? Drifted" # Drift
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
        AADCustomSecurityAttributeDefinition "AADCustomSecurityAttributeDefinition-ShoeSize"
        {
            ApplicationId           = $ApplicationId;
            AttributeSet            = "TestAttributeSet";
            CertificateThumbprint   = $CertificateThumbprint;
            Ensure                  = "Absent";
            IsCollection            = $False;
            IsSearchable            = $True;
            Name                    = "ShoeSize";
            Status                  = "Available";
            TenantId                = $TenantId;
            Type                    = "String";
            UsePreDefinedValuesOnly = $False;
            Description             = "What size of shoe is the person wearing?"
        }
    }
}
```

