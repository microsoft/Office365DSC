# EXOServicePrincipal

## Description

Use the ServicePrincipal cmdlets to create, change service principals in your cloud-based organization.

## Parameters

- Identity: The Identity parameter specifies the service principal that you want to modify. You can use any value that uniquely identifies the service principal. For example: Name, Distinguished name (DN), GUID, AppId, ObjectId
- AppName: The AppName parameter specifies the corresponding friendly name of the unique AppId GUID value for the service principal.
- DisplayName: The DisplayName parameter specifies the friendly name of the service principal. If the name contains spaces, enclose the name in quotation marks (").
- AppId: The AppId parameter specifies the unique AppId GUID value for the service principal.
- ObjectId: The ObjectId parameter specifies the unique ObjectId GUID value for the service principal.

## Examples

- Set-ServicePrincipal -Identity dc873ad4-0397-4d74-b5c0-897cd3a94731 -DisplayName "Another App Name"
- New-ServicePrincipal -AppId 71487acd-ec93-476d-bd0e-6c8b31831053 -ObjectId 6233fba6-0198-4277-892f-9275bf728bcc

## Parameters present in New and not in Set

- AppId
- ObjectId

## Parameters present in Set and not in New

- Identity
