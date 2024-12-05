# Update-M365DSCAzureAdApplication

## Description

This function creates or updates an application in Azure AD. It assigns permissions,
grants consent and creates a secret or uploads a certificate to the application.

This application can then be used for Application Authentication.

The provided permissions have to be as an array of hashtables, with Api=Graph, SharePoint
or Exchange and PermissionsName set to a list of permissions. See examples for more information.

NOTE:
Please make sure you have the following permissions for the 'Microsoft Graph Command Line Tools'
Enterprise Application in your tenant:

- Application.ReadWrite.All

You can add this scope to the 'Microsoft Graph Command Line Tools' Enterprise Application by running
the following command:

```powershell
Connect-MgGraph -Scopes 'Application.ReadWrite.All'
```

NOTE:
If consent cannot be given for whatever reason, make sure all these permissions are
given Admin Consent by browsing to the App Registration in Azure AD > API Permissions
and clicking the "Grant admin consent for <orgname>" button.

More information:
Graph API permissions: https://docs.microsoft.com/en-us/graph/permissions-reference
Exchange permissions: https://docs.microsoft.com/en-us/exchange/permissions-exo/permissions-exo

Note:
If you want to configure App-Only permission for Exchange, as described here:
https://docs.microsoft.com/en-us/powershell/exchange/app-only-auth-powershell-v2?view=exchange-ps#step-2-assign-api-permissions-to-the-application
Using the following permission will achieve exactly that: @{Api='Exchange';PermissionsName='Exchange.ManageAsApp'}

Note 2:
If you want to configure App-Only permission for Security and compliance, please refer to this information on how to setup the permissions:
https://microsoft365dsc.com/user-guide/get-started/authentication-and-permissions/#security-and-compliance-center-permissions

Note 3:
If you want to configure App-Only permission for Power Platform, please refer to this information on how to setup the permissions:
https://microsoft365dsc.com/user-guide/get-started/authentication-and-permissions/#power-apps-permissions

## Output

This function does not generate any output.

## Parameters

| Parameter | Required | DataType | Default Value | Allowed Values | Description |
| --- | --- | --- | --- | --- | --- |
| ApplicationName | False | String | Microsoft365DSC |  | The name of the application to create or update. Default value is 'Microsoft365DSC'. |
| Permissions | True True | Hashtable[] |  |  | The permissions to assign to the application. This has to be an array of hashtables, with Api=Graph, SharePoint or Exchange and PermissionsName set to a list of permissions. See examples for more information. |
| Type | False | String | Secret | Secret, Certificate | The type of credential to create. Default value is 'Secret'. Valid values are 'Secret' and 'Certificate'. |
| MonthsValid | False | Int32 | 12 |  | The number of months the certificate should be valid. Default value is 12. |
| CreateNewSecret | False | SwitchParameter |  |  | If specified, a new secret will be created for the application. -CreateNewSecret or -CertificatePath can be used, not both. |
| CertificatePath | False | String |  |  | The path to the certificate to be uploaded for the app registration. If using with -CreateSelfSignedCertificate - a file with this name will be created and uploaded (file must not exist). Otherwise the file must already exist. Cannot be used with -CreateNewSecret simultaneously. |
| CreateSelfSignedCertificate | False | SwitchParameter |  |  | If specified, a self-signed certificate will be created for the application. -CreateSelfSignedCertificate or -CertificatePath can be used, not both. |
| AdminConsent | False | SwitchParameter |  |  | If specified, admin consent will be granted for the application. |
| Credential | False | PSCredential |  |  | The credential to use for authenticating the request. Mutually exclusive with -TenantId. |
| ApplicationId | False | String |  |  | The ApplicationId to use for authenticating the request. -Credential or -ApplicationId can be used, not both. |
| TenantId | False | String |  |  | The name of the tenant to use for the request. Must be in the form of contoso.onmicrosoft.com. Mutually exclusive with -Credential. |
| ApplicationSecret | False | PSCredential |  |  | The ApplicationSecret to use for authenticating the request. -Credential or -ApplicationSecret can be used, not both. |
| CertificateThumbprint | False | String |  |  | Thumbprint of an existing auth certificate to use for authenticating the request. Mutually exclusive with -Credential. |
| ManagedIdentity | False | SwitchParameter |  |  | If specified, Managed Identity will be used for authenticating the request. -Credential or -ApplicationId or -ManagedIdentity can be used, only one of them. |
| Message | True | String |  |  |  |
| Type | False | String | Info | Error, Warning, Info | The type of credential to create. Default value is 'Secret'. Valid values are 'Secret' and 'Certificate'. |

## Examples

-------------------------- EXAMPLE 1 --------------------------

`Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='SharePoint';PermissionName='Sites.FullControl.All'}) -AdminConsent -Type Secret -Credential $creds`

-------------------------- EXAMPLE 2 --------------------------

`Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='Graph';PermissionName='Domain.Read.All'}) -AdminConsent  -Credential $creds -Type Certificate -CreateSelfSignedCertificate -CertificatePath c:\Temp\M365DSC.cer`

-------------------------- EXAMPLE 3 --------------------------

`Update-M365DSCAzureAdApplication -ApplicationName 'Microsoft365DSC' -Permissions @(@{Api='SharePoint';PermissionName='Sites.FullControl.All'},@{Api='Graph';PermissionName='Group.ReadWrite.All'},@{Api='Exchange';PermissionName='Exchange.ManageAsApp'}) -AdminConsent -Credential $creds -Type Certificate -CertificatePath c:\Temp\M365DSC.cer`

-------------------------- EXAMPLE 4 --------------------------

`Update-M365DSCAzureAdApplication -ApplicationName $Microsoft365DSC -Permissions $(Get-M365DSCCompiledPermissionList -ResourceNameList (Get-M365DSCAllResources) -PermissionType Application -AccessType Read) -Type Certificate -CreateSelfSignedCertificate -AdminConsent -MonthsValid 12 -Credential $creds -CertificatePath c:\Temp\M365DSC.cer`


