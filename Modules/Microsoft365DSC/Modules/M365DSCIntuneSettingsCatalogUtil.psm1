function Get-SettingsCatalogSettingName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $SettingDefinition,

        [Parameter(Mandatory = $true)]
        [System.Array]
        $AllSettingDefinitions
    )

    # Remove invalid characters
    $settingName = [regex]::Replace($SettingDefinition.Name, "[\{\}\$]", "")

    $settingsWithSameName = $AllSettingDefinitions | Where-Object -FilterScript { $_.Name -eq $settingName }

    # Edge case where the same setting is defined twice in the template, with the same name and id
    # Example is RDVAllowBDE_Name from the IntuneDiskEncryptionWindows10 resource
    if ($settingsWithSameName.Count -eq 2)
    {
        if ($settingsWithSameName[0].Id -eq $settingsWithSameName[1].Id -and `
            $settingsWithSameName[0].Name -eq $settingsWithSameName[1].Name)
        {
            $settingsWithSameName = $settingsWithSameName[0]
        }
    }

    if ($settingsWithSameName -is [array] -and $settingsWithSameName.Count -gt 1)
    {
        # Get the parent setting of the current setting
        $parentSetting = Get-ParentSettingDefinition -SettingDefinition $SettingDefinition -AllSettingDefinitions $AllSettingDefinitions
        if ($null -ne $parentSetting)
        {
            $combinationMatchesWithParent = @()
            $settingsWithSameName | ForEach-Object {
                $innerParentSetting = Get-ParentSettingDefinition -SettingDefinition $_ -AllSettingDefinitions $AllSettingDefinitions
                if ($null -ne $innerParentSetting)
                {
                    if ("$($innerParentSetting.Name)_$($_.Name)" -eq "$($parentSetting.Name)_$settingName")
                    {
                        $combinationMatchesWithParent += $_
                    }
                }
            }
            # If the combination of parent setting and setting name is unique, add the parent setting name to the setting name
            if ($combinationMatchesWithParent.Count -eq 1)
            {
                $settingName = $parentSetting.Name + "_" + $settingName
            }
            # If the combination of parent setting and setting name is still not unique, do it with the OffsetUri of the current setting
            else
            {
                $settingResult = Get-UniqueSettingDefinitionNameFromMultipleMatches -SettingDefinition $SettingDefinition -SettingName $settingName -SettingsWithSameName $settingsWithSameName
                if ($settingResult.Success)
                {
                    $settingName = $settingResult.SettingName
                }
                else
                {
                    # Alternative way if no unique setting name can be found
                    $parentSettingIdProperty = $parentSetting.Id.Split('_')[-1]
                    $parentSettingIdWithoutProperty = $parentSetting.Id.Replace("_$parentSettingIdProperty", "")
                    # We can't use the entire setting here, because the child setting id does not have to come after the parent setting id
                    $settingName = $SettingDefinition.Id.Replace($parentSettingIdWithoutProperty + "_", "").Replace($parentSettingIdProperty + "_", "")
                }
            }
        }

        # When there is no parent, we can't use the parent setting name to make the setting name unique
        # Instead, we traverse up the OffsetUri. 
        if ($null -eq $parentSetting)
        {
            $settingResult = Get-UniqueSettingDefinitionNameFromMultipleMatches -SettingDefinition $SettingDefinition -SettingName $settingName -SettingsWithSameName $settingsWithSameName
            if ($settingResult.Success)
            {
                $settingName = $settingResult.SettingName
            }
            else
            {
                # Can happen if both settings have the same name and the same OffsetUri, e.g. "enforcementLevel" in the IntuneAntivirusPolicyLinux resource
                # Potential risk of overwriting settings with the same name but different OffsetUri
                $settingIdWithoutName = $SettingDefinition.Id -replace "_$settingName", ""
                $settingIdWithoutNameSplitted = $settingIdWithoutName.Split("_")[-1]
                $settingName = $settingIdWithoutNameSplitted + "_" + $settingName
            }
        }

        # Simplify names from the OffsetUri. This is done to make the names more readable, especially in case of long and complex OffsetUris.
        switch -wildcard ($settingName)
        {
            'access16v2~Policy~L_MicrosoftOfficeaccess~L_ApplicationSettings~*' { $settingName = $settingName.Replace('access16v2~Policy~L_MicrosoftOfficeaccess~L_ApplicationSettings', 'MicrosoftAccess_') }
            'excel16v2~Policy~L_MicrosoftOfficeExcel~L_ExcelOptions~*' { $settingName = $settingName.Replace('excel16v2~Policy~L_MicrosoftOfficeExcel~L_ExcelOptions', 'MicrosoftExcel_') }
            'word16v2~Policy~L_MicrosoftOfficeWord~L_WordOptions~*' { $settingName = $settingName.Replace('word16v2~Policy~L_MicrosoftOfficeWord~L_WordOptions', 'MicrosoftWord_') }
            'ppt16v2~Policy~L_MicrosoftOfficePowerPoint~L_PowerPointOptions~*' { $settingName = $settingName.Replace('ppt16v2~Policy~L_MicrosoftOfficePowerPoint~L_PowerPointOptions', 'MicrosoftPowerPoint_') }
            'proj16v2~Policy~L_Proj~L_ProjectOptions~*' { $settingName = $settingName.Replace('proj16v2~Policy~L_Proj~L_ProjectOptions', 'MicrosoftProject_') }
            'visio16v2~Policy~L_MicrosoftVisio~L_VisioOptions~*' { $settingName = $settingName.Replace('visio16v2~Policy~L_MicrosoftVisio~L_VisioOptions', 'MicrosoftVisio_') }
            'pub16v2~Policy~L_MicrosoftOfficePublisher~*' { $settingName = $settingName.Replace('pub16v2~Policy~L_MicrosoftOfficePublisher', 'MicrosoftPublisherV2_') }
            'pub16v3~Policy~L_MicrosoftOfficePublisher~*' { $settingName = $settingName.Replace('pub16v3~Policy~L_MicrosoftOfficePublisher', 'MicrosoftPublisherV3_') }
            'microsoft_edge~Policy~microsoft_edge~*' { $settingName = $settingName.Replace('microsoft_edge~Policy~microsoft_edge', 'MicrosoftEdge_') }
            '*~L_Security~*' { $settingName = $settingName.Replace('~L_Security', 'Security') }
            '*~L_TrustCenter*' { $settingName = $settingName.Replace('~L_TrustCenter', '_TrustCenter') }
            '*~L_ProtectedView_*' { $settingName = $settingName.Replace('~L_ProtectedView', 'ProtectedView') }
            '*~L_FileBlockSettings_*' { $settingName = $settingName.Replace('~L_FileBlockSettings', 'FileBlockSettings') }
            '*~L_TrustedLocations*' { $settingName = $settingName.Replace('~L_TrustedLocations', 'TrustedLocations') }
            '*~HTTPAuthentication_*' { $settingName = $settingName.Replace('~HTTPAuthentication', 'HTTPAuthentication') }
        }
    }

    $settingName
}

function Get-ParentSettingDefinition {
    param(
        [Parameter(Mandatory = $true)]
        $SettingDefinition,

        [Parameter(Mandatory = $true)]
        $AllSettingDefinitions
    )

    $parentSetting = $null
    if ($SettingDefinition.AdditionalProperties.dependentOn.parentSettingId.Count -gt 0)
    {
        $parentSetting = $AllSettingDefinitions | Where-Object -FilterScript {
            $_.Id -eq ($SettingDefinition.AdditionalProperties.dependentOn.parentSettingId | Select-Object -Unique -First 1)
        }
    }
    elseif ($SettingDefinition.AdditionalProperties.options.dependentOn.parentSettingId.Count -gt 0)
    {
        $parentSetting = $AllSettingDefinitions | Where-Object -FilterScript {
            $_.Id -eq ($SettingDefinition.AdditionalProperties.options.dependentOn.parentSettingId | Select-Object -Unique -First 1)
        }
    }

    $parentSetting
}

function Get-UniqueSettingDefinitionNameFromMultipleMatches {
    param (
        [Parameter(Mandatory = $true)]
        $SettingDefinition,

        [Parameter(Mandatory = $true)]
        [System.String]
        $SettingName,

        [Parameter(Mandatory = $true)]
        [System.Array]
        $SettingsWithSameName
    )

    $skip = 0
    $breakCounter = 0
    $threshold = 8
    $newSettingName = $SettingName
    do {
        $previousSettingName = $newSettingName
        $newSettingName = Get-SettingDefinitionNameFromOffsetUri -OffsetUri $SettingDefinition.OffsetUri -SettingName $newSettingName -Skip $skip

        $combinationMatchesWithOffsetUri = @()
        $SettingsWithSameName | ForEach-Object {
            $newName = Get-SettingDefinitionNameFromOffsetUri -OffsetUri $_.OffsetUri -SettingName $previousSettingName -Skip $skip
            if ($newName -eq $newSettingName)
            {
                # Exclude v2 versions from the comparison
                if ($SettingDefinition.Id -like "*_v2" -and $_.Id -ne $SettingDefinition.Id.Replace('_v2', '') -or
                    $SettingDefinition.Id -notlike "*_v2" -and $_.Id -ne $SettingDefinition.Id + "_v2")
                {
                    $combinationMatchesWithOffsetUri += $_
                }
            }
        }
        $SettingsWithSameName = $combinationMatchesWithOffsetUri
        $skip++
        $breakCounter++
    } while ($combinationMatchesWithOffsetUri.Count -gt 1 -and $breakCounter -lt $threshold)

    $success = $false
    if ($breakCounter -lt $threshold)
    {
        if ($SettingDefinition.Id -like "*_v2" -and $newSettingName -notlike "*_v2")
        {
            $newSettingName += "_v2"
        }
        $settingName = $newSettingName
        $success = $true
    }

    @{
        Success = $success
        SettingName = $settingName
    }
}

function Get-SettingDefinitionNameFromOffsetUri {
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $OffsetUri,

        [Parameter(Mandatory = $true)]
        [System.String]
        $SettingName,

        [Parameter(Mandatory = $false)]
        [System.Int32]
        $Skip = 0
    )

    # If the last part of the OffsetUri is the same as the setting name or it contains invalid characters, we traverse up until we reach the first element
    # Invalid characters are { and } which are used in the OffsetUri to indicate a variable
    $splittedOffsetUri = $OffsetUri.Split("/")
    if ([string]::IsNullOrEmpty($splittedOffsetUri[0]))
    {
        $splittedOffsetUri = $splittedOffsetUri[1..($splittedOffsetUri.Length - 1)]
    }

    if ($Skip -gt $splittedOffsetUri.Length - 1)
    {
        return $SettingName
    }

    $splittedOffsetUri = $splittedOffsetUri[0..($splittedOffsetUri.Length - 1 - $Skip)]
    $traversed = $false
    while (-not $traversed -and $splittedOffsetUri.Length -gt 1) # Prevent adding the first element of the OffsetUri
    {
        $traversed = $true
        if ($splittedOffsetUri[-1] -eq $SettingName -or $splittedOffsetUri[-1] -match "[\{\}]" -or $SettingName.StartsWith($splittedOffsetUri[-1]))
        {
            $splittedOffsetUri = $splittedOffsetUri[0..($splittedOffsetUri.Length - 2)]
            $traversed = $false
        }
    }

    if ($splittedOffsetUri.Length -gt 1)
    {
        $splittedOffsetUri[-1] + "_" + $SettingName
    }
    else
    {
        $SettingName
    }
}
