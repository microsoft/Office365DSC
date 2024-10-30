# AzureDiagnosticSettingsCustomSecurityAttribute

## Description

Configures Diagnostics settings custom security attributes in Azure.

Users will need to grant permissions to the associated scope by running the following command in Azure Cloud Shell:
```Powershell
New-AzRoleAssignment -ObjectId "<Service Principal Object ID>" -Scope "/providers/microsoft.AadCustomSecurityAttributesDiagnosticSettings" -RoleDefinitionName 'Contributor' -ObjectType 'ServicePrincipal'
```
