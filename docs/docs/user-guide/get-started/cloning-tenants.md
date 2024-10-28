This feature of Microsoft365DSC is not a true standalone feature. It is a combination of existing features to unlock a new scenario for users.

## Clone = Export/Deploy

Since Microsoft365DSC is able to take a snapshot of any Microsoft 365 tenant and can deploy a Microsoft365DSC configuration onto any tenant, we can easily clone the configuration of any tenant over another one (or another set of tenants).

When you take a snapshot of an existing tenant, the extracted configuration file doesn’t contain any information that is specific to the source tenant. It abstracts it all into variables, which make the configuration generic instead of unique for a particular tenant. It is then at compilation time that you provide information about the environment onto which this configuration will be applied to.

<figure markdown>
  ![Flow of the clone process](../../Images/SyncFlow.png)
  <figcaption>Flow of the clone process</figcaption>
</figure>

***For example:***

Let's assume you are trying to clone the configuration of Tenant A onto Tenant B. You would start by capturing the existing configuration of tenant A using credentials or a Service Principal that exists and has rights on Tenant A. This will generate the configuration file containing all the configuration settings for Tenant A. Then at compilation time, when trying to compile the extracted configuration into a MOF file, you will need to provide credentials or a Service Principal that has access to Tenant B. Then all that is left to do is to deploy the configuration onto Tenant B to have all the configurations settings from tenant A applied onto it.

### Full example script for cloning one resource

**IMPORTANT:** The specified credential should **NOT** have Multi-Factor Authentication enabled!!

```PowerShell
Install-Module Microsoft365Dsc

Update-M365DSCDependencies

$SourceCredential = Get-Credential

Update-M365DSCAllowedGraphScopes -ResourceNameList @("AADGroupsNamingPolicy") -Type Read

Export-M365DSCConfiguration -Components @("AADGroupsNamingPolicy") -Credential $SourceCredential -Path C:\Dsc
```

Now browse to the specified export folder and open the generated ConfigurationData.psd1 file. Update all tenant specific information in this file with the correct information for the target tenant. For example, a UPN suffix (tenantname.onmicrosoft.com) or the SharePoint URL (tenantname.sharepoint.com).

Then open the M365TenantConfig.ps1 file and replace all instances of tenant specific information in this file.

> **NOTE:** Our goal is to save all tenant specific information to just the ConfigurationData.psd1 file during export. Unfortunately, at the moment there are a couple of instances where this isn't implemented consistently and tenant specific information is also written in the M365TenantConfig.ps1 file.

```PowerShell
$TargetCredential = Get-Credential

Update-M365DSCAllowedGraphScopes -ResourceNameList @("AADGroupsNamingPolicy") -Type Update

C:\Dsc\M365TenantConfig.ps1 -Credential $TargetCredential

Start-DscConfiguration -Path C:\Dsc -Wait -Verbose
```
