function Get-StringFirstCharacterToUpper
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Value
    )

    return $Value.Substring(0,1).ToUpper() + $Value.Substring(1,$Value.length-1)
}

function Get-StringFirstCharacterToLower
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Value
    )

    return $Value.Substring(0,1).ToLower() + $Value.Substring(1,$Value.length-1)
}

function Remove-M365DSCCimInstanceTrailingCharacterFromExport
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $DSCBlock
    )

    $DSCBlock = $DSCBlock.replace("    ,`r`n" , "    `r`n" )
    $DSCBlock = $DSCBlock.replace("`r`n;`r`n" , "`r`n" )
    $DSCBlock = $DSCBlock.replace("`r`n,`r`n" , "`r`n" )

    return $DSCBlock
}
function Rename-M365DSCCimInstanceParameter
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable], [System.Collections.Hashtable[]])]
    param(
        [Parameter(Mandatory = $true)]
        $Properties,

        [Parameter(Mandatory = $false)]
        [System.Collections.Hashtable]
        $KeyMapping = @{'odataType' = '@odata.type'}
    )

    $result = $Properties
    $type = $Properties.getType().FullName
    #region Array
    if ($type -like '*[[\]]')
    {
        $values = @()
        foreach ($item in $Properties)
        {
            try
            {
                $values += Rename-M365DSCCimInstanceParameter $item -KeyMapping $KeyMapping
            }
            catch
            {
                Write-Verbose -Message "Error getting values for item {$item}"
            }
        }
        $result = $values

        return , $result
    }
    #endregion

    #region Single
    if ($type -like '*Hashtable')
    {
        $result = ([Hashtable]$Properties).clone()
    }

    if ($type -like '*CimInstance*' -or $type -like '*Hashtable*' -or $type -like '*Object*')
    {
        $hashProperties = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $result
        $keys = ($hashProperties.clone()).keys

        foreach ($key in $keys)
        {
            $keyName = $key.substring(0, 1).tolower() + $key.substring(1, $key.length - 1)
            if ($key -in $KeyMapping.Keys)
            {
                $keyName = $KeyMapping.$key
            }

            $property = $hashProperties.$key

            if ($null -ne $property)
            {
                $hashProperties.Remove($key)
                try
                {
                    $subValue = Rename-M365DSCCimInstanceParameter $property -KeyMapping $KeyMapping
                    if ($null -ne $subValue)
                    {
                        $hashProperties.Add($keyName, $subValue)
                    }
                }
                catch
                {
                    Write-Verbose -Message "Error adding $property"
                }
            }
        }
        $result = $hashProperties
    }
    return $result
    #endregion
}

function Get-M365DSCDRGComplexTypeToHashtable
{
    [CmdletBinding()]
    [OutputType([hashtable], [hashtable[]])]
    param(
        [Parameter()]
        $ComplexObject
    )

    if ($null -eq $ComplexObject)
    {
        return $null
    }

    if ($ComplexObject.gettype().fullname -like '*[[\]]')
    {
        $results = @()

        foreach ($item in $ComplexObject)
        {
            if ($item)
            {
                $hash = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
                $results += $hash
            }
        }

        # PowerShell returns all non-captured stream output, not just the argument of the return statement.
        #An empty array is mangled into $null in the process.
        #However, an array can be preserved on return by prepending it with the array construction operator (,)
        return , [hashtable[]]$results
    }


    if ($ComplexObject.getType().fullname -like '*Dictionary*')
    {
        $results = @{}

        $ComplexObject = [hashtable]::new($ComplexObject)
        $keys = $ComplexObject.Keys

        foreach ($key in $keys)
        {
            if ($null -ne $ComplexObject.$key)
            {
                $keyName = $key
                $keyType = $ComplexObject.$key.gettype().fullname
                if ($keyType -like '*CimInstance*' -or $keyType -like '*Dictionary*' -or $keyType -like 'Microsoft.Graph.PowerShell.Models.*' -or $keyType -like 'Microsoft.Graph.Beta.PowerShell.Models.*' -or $keyType -like '*[[\]]')
                {
                    $hash = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject.$key

                    $results.Add($keyName, $hash)
                }
                else
                {
                    $results.Add($keyName, $ComplexObject.$key)
                }
            }
        }
        return [hashtable]$results
    }

    $results = @{}

    if ($ComplexObject.getType().Fullname -like '*hashtable')
    {
        $keys = $ComplexObject.keys
    }
    else
    {
        $keys = $ComplexObject | Get-Member | Where-Object -FilterScript { $_.MemberType -eq 'Property' }
    }

    foreach ($key in $keys)
    {
        $keyName = $key
        if ($ComplexObject.getType().Fullname -notlike '*hashtable')
        {
            $keyName = $key.Name
        }

        if ($null -ne $ComplexObject.$keyName)
        {
            $keyType = $ComplexObject.$keyName.gettype().fullname
            if ($keyType -like '*CimInstance*' -or $keyType -like '*Dictionary*' -or $keyType -like 'Microsoft.Graph.*PowerShell.Models.*')
            {
                $hash = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject.$keyName

                if ($null -ne $hash -and $hash.Keys.Count -gt 0)
                {
                    $results.Add($keyName, $hash)
                }
            }
            else
            {
                $results.Add($keyName, $ComplexObject.$keyName)
            }
        }
    }
    return [hashtable]$results
}

<#
    Use ComplexTypeMapping to overwrite the type of nested CIM
    Example
    $complexMapping=@(
                    @{
                        Name="ApprovalStages"
                        CimInstanceName="MSFT_MicrosoftGraphapprovalstage1"
                        IsRequired=$false
                    }
                    @{
                        Name="PrimaryApprovers"
                        CimInstanceName="MicrosoftGraphuserset"
                        IsRequired=$false
                    }
                    @{
                        Name="EscalationApprovers"
                        CimInstanceName="MicrosoftGraphuserset"
                        IsRequired=$false
                    }
                )
    With
    Name: the name of the parameter to be overwritten
    CimInstanceName: The type of the CIM instance (can include or not the prefix MSFT_)
    IsRequired: If isRequired equals true, an empty hashtable or array will be returned. Some of the Graph parameters are required even though they are empty
#>
function Get-M365DSCDRGComplexTypeToString
{
    [CmdletBinding()]
    param(
        [Parameter()]
        $ComplexObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $CIMInstanceName,

        [Parameter()]
        [Array]
        $ComplexTypeMapping,

        [Parameter()]
        [System.String]
        $Whitespace = '',

        [Parameter()]
        [System.uint32]
        $IndentLevel = 3,

        [Parameter()]
        [switch]
        $IsArray
    )

    if ($null -eq $ComplexObject)
    {
        return $null
    }

    $indent = ''
    for ($i = 0; $i -lt $IndentLevel; $i++)
    {
        $indent += '    '
    }

    #If ComplexObject is an Array
    if ($ComplexObject.GetType().FullName -like '*[[\]]')
    {
        $currentProperty = @()
        $IndentLevel++
        foreach ($item in $ComplexObject)
        {
            $splat = @{
                'ComplexObject'   = $item
                'CIMInstanceName' = $CIMInstanceName
                'IndentLevel'     = $IndentLevel
            }
            if ($ComplexTypeMapping)
            {
                $splat.Add('ComplexTypeMapping', $ComplexTypeMapping)
            }

            $currentProperty += Get-M365DSCDRGComplexTypeToString -IsArray @splat
        }

        #PowerShell returns all non-captured stream output, not just the argument of the return statement.
        #An empty array is mangled into $null in the process.
        #However, an array can be preserved on return by prepending it with the array construction operator (,)
        return , $currentProperty
    }

    $currentProperty = ''
    if ($IsArray)
    {
        $currentProperty += "`r`n"
        $currentProperty += $indent
    }

    $CIMInstanceName = $CIMInstanceName.Replace('MSFT_', '')
    $currentProperty += "MSFT_$CIMInstanceName{`r`n"
    $IndentLevel++
    $indent = '    ' * $IndentLevel
    $keyNotNull = 0

    if ($ComplexObject.Keys.Count -eq 0)
    {
        return $null
    }

    foreach ($key in $ComplexObject.Keys)
    {
        if ($null -ne $ComplexObject.$key)
        {
            $keyNotNull++
            if ($ComplexObject.$key.GetType().FullName -like 'Microsoft.Graph.PowerShell.Models.*' -or $key -in $ComplexTypeMapping.Name)
            {
                $hashPropertyType = $ComplexObject[$key].GetType().Name.ToLower()

                $IsArray = $false
                if ($ComplexObject[$key].GetType().FullName -like '*[[\]]')
                {
                    $IsArray = $true
                }
                #overwrite type if object defined in mapping complextypemapping
                if ($key -in $ComplexTypeMapping.Name)
                {
                    $hashPropertyType = ([Array]($ComplexTypeMapping | Where-Object -FilterScript { $_.Name -eq $key }).CimInstanceName)[0]
                    $hashProperty = $ComplexObject[$key]
                    #$currentProperty += "`r`n"
                }
                else
                {
                    $hashProperty = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject[$key]
                }

                if (-not $IsArray)
                {
                    $currentProperty += $indent + $key + ' = '
                }

                if ($IsArray -and $key -in $ComplexTypeMapping.Name)
                {
                    if ($ComplexObject.$key.Count -gt 0)
                    {
                        $currentProperty += $indent + $key + ' = '
                        $currentProperty += '@('
                    }
                }

                if ($IsArray)
                {
                    $IndentLevel++
                    for ($i = 0; $i -lt $ComplexObject[$key].Count; $i++)
                    {
                        $item = $ComplexObject.$key[$i]
                        if ($ComplexObject.$key.GetType().FullName -like 'Microsoft.Graph.PowerShell.Models.*')
                        {
                            $item = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
                        }
                        $nestedPropertyString = Get-M365DSCDRGComplexTypeToString `
                            -ComplexObject $item `
                            -CIMInstanceName $hashPropertyType `
                            -IndentLevel $IndentLevel `
                            -ComplexTypeMapping $ComplexTypeMapping `
                            -IsArray
                        if ([string]::IsNullOrWhiteSpace($nestedPropertyString))
                        {
                            $nestedPropertyString = "@()`r`n"
                        }
                        if ($i -ne 0)
                        {
                            # Remove the line break at the start because every item contains a trailing line break
                            # which would lead to two line breaks between each item
                            $nestedPropertyString = $nestedPropertyString.Substring(2)
                        }
                        $currentProperty += $nestedPropertyString
                    }
                    $IndentLevel--
                }
                else
                {
                    $nestedPropertyString = Get-M365DSCDRGComplexTypeToString `
                        -ComplexObject $hashProperty `
                        -CIMInstanceName $hashPropertyType `
                        -IndentLevel $IndentLevel `
                        -ComplexTypeMapping $ComplexTypeMapping
                    if ([string]::IsNullOrWhiteSpace($nestedPropertyString))
                    {
                        $nestedPropertyString = "`$null`r`n"
                    }
                    $currentProperty += $nestedPropertyString
                }
                if ($IsArray)
                {
                    if ($ComplexObject.$key.Count -gt 0)
                    {
                        $currentProperty += $indent
                        $currentProperty += ')'
                        $currentProperty += "`r`n"
                    }
                }
                $IsArray = $PSBoundParameters.IsArray
            }
            else
            {
                $currentValue = $ComplexObject[$key]
                if ($currentValue.GetType().Name -eq 'String')
                {
                     $currentValue = $ComplexObject[$key].Replace("'", "''").Replace("�", "''")
                }
                $currentProperty += Get-M365DSCDRGSimpleObjectTypeToString -Key $key -Value $currentValue -Space ($indent)
            }
        }
        else
        {
            $mappedKey = $ComplexTypeMapping | Where-Object -FilterScript { $_.name -eq $key }

            if ($mappedKey -and $mappedKey.isRequired)
            {
                if ($mappedKey.IsArray)
                {
                    $currentProperty += "$indent$key = @()`r`n"
                }
                else
                {
                    $currentProperty += "$indent$key = `$null`r`n"
                }
            }
        }
    }
    $indent = ''
    $indent = '    ' * ($IndentLevel -1)
    if ($key -in $ComplexTypeMapping.Name)
    {
        $currentProperty += "`r`n"
    }

    $currentProperty += "$indent}"
    if ($IsArray -or $IndentLevel -gt 4)
    {
        $currentProperty += "`r`n"
    }

    #Indenting last parenthesis when the cim instance is an array
    if ($IndentLevel -eq 5)
    {
        $indent = '    ' * ($IndentLevel -2)
        $currentProperty += $indent
    }

    $emptyCIM = $currentProperty.Replace(' ', '').Replace("`r`n", '')
    if ($emptyCIM -eq "MSFT_$CIMInstanceName{}")
    {
        $currentProperty = $null
    }

    if ($null -ne $currentProperty)
    {
        $fancySingleQuotes = "[\u2019\u2018]"
        $fancyDoubleQuotes = "[\u201C\u201D]"
        $currentProperty = [regex]::Replace($currentProperty, $fancySingleQuotes, "''")
        $currentProperty = [regex]::Replace($currentProperty, $fancyDoubleQuotes, '"')
    }
    return $currentProperty
}

function Get-M365DSCDRGSimpleObjectTypeToString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $Key,

        [Parameter(Mandatory = $true)]
        $Value,

        [Parameter()]
        [System.String]
        $Space = '                '
    )

    $returnValue = ''
    switch -Wildcard ($Value.GetType().Fullname )
    {
        '*.Boolean'
        {
            $returnValue = $Space + $Key + " = `$" + $Value.ToString() + "`r`n"
        }
        '*.String'
        {
            if ($key -eq '@odata.type')
            {
                $key = 'odataType'
            }
            $returnValue = $Space + $Key + " = '" + $Value + "'`r`n"
        }
        '*.DateTime'
        {
            $returnValue = $Space + $Key + " = '" + $Value + "'`r`n"
        }
        '*[[\]]'
        {
            $returnValue = $Space + $key + ' = @('
            $whitespace = ''
            $newline = ''
            if ($Value.count -gt 1)
            {
                $returnValue += "`r`n"
                $whitespace = $Space + '    '
                $newline = "`r`n"
            }
            foreach ($item in ($Value | Where-Object -FilterScript { $null -ne $_ }))
            {
                switch -Wildcard ($item.GetType().Fullname)
                {
                    '*.String'
                    {
                        $returnValue += "$whitespace'$item'$newline"
                    }
                    '*.DateTime'
                    {
                        $returnValue += "$whitespace'$item'$newline"
                    }
                    Default
                    {
                        $returnValue += "$whitespace$item$newline"
                    }
                }
            }
            if ($Value.count -gt 1)
            {
                $returnValue += "$Space)`r`n"
            }
            else
            {
                $returnValue += ")`r`n"

            }
        }
        Default
        {
            $returnValue = $Space + $Key + ' = ' + $Value + "`r`n"
        }
    }
    return $returnValue
}

function Compare-M365DSCComplexObject
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [Parameter()]
        $Source,
        [Parameter()]
        $Target
    )

    #Comparing full objects
    if ($null -eq $Source -and $null -eq $Target)
    {
        return $true
    }

    $sourceValue = ''
    $targetValue = ''
    if (($null -eq $Source) -xor ($null -eq $Target))
    {
        if ($null -eq $Source)
        {
            $sourceValue = 'Source is null'
        }

        if ($null -eq $Target)
        {
            $targetValue = 'Target is null'
        }
        Write-Verbose -Message "Configuration drift - Complex object: {$sourceValue$targetValue}"
        return $false
    }

    if ($Source.GetType().FullName -like '*CimInstance[[\]]' -or $Source.GetType().FullName -like '*Hashtable[[\]]')
    {
        if ($Source.Count -ne $Target.Count)
        {
            Write-Verbose -Message "Configuration drift - The complex array have different number of items: Source {$($Source.Count)} Target {$($Target.Count)}"
            return $false
        }
        if ($Source.Count -eq 0)
        {
            return $true
        }

        if ($Source[0].CimClass.CimClassName -eq 'MSFT_DeviceManagementConfigurationPolicyAssignments' -or
            $Source[0].CimClass.CimClassName -eq 'MSFT_DeviceManagementMobileAppAssignment' -or
            ($Source[0].CimClass.CimClassName -like 'MSFT_Intune*Assignments' -and
            $Source[0].CimClass.CimClassName -ne 'MSFT_IntuneDeviceRemediationPolicyAssignments'))
        {
            $compareResult = Compare-M365DSCIntunePolicyAssignment `
                -Source @($Source) `
                -Target @($Target)

            if (-not $compareResult)
            {
                Write-Verbose -Message "Configuration drift - Intune Policy Assignment: $key Source {$Source} Target {$Target}"
                return $false
            }

            return $true
        }

        foreach ($item in $Source)
        {
            foreach ($targetItem in $Target)
            {
                $compareResult = Compare-M365DSCComplexObject `
                    -Source $item `
                    -Target $targetItem

                if ($compareResult)
                {
                    break
                }
            }

            if (-not $compareResult)
            {
                Write-Verbose -Message 'Configuration drift - The complex array items are not identical'
                return $false
            }
        }

        return $true
    }

    if ($Source.GetType().FullName -like "*CimInstance")
    {
        $keys = @()
        $Source.CimInstanceProperties | Foreach-Object {
            if ($_.Name -notin @('PSComputerName', 'CimClass', 'CimInstanceProperties', 'CimSystemProperties') `
                -and $_.IsValueModified)
            {
                $keys += $_.Name
            }
        }
    }
    else
    {
        $keys = $Source.Keys | Where-Object -FilterScript { $_ -ne 'PSComputerName' }
    }

    if ($Target.GetType().FullName -like "*CimInstance")
    {
        $targetKeys = @()
        $Target.CimInstanceProperties | Foreach-Object {
            if ($_.Name -notin @('PSComputerName', 'CimClass', 'CimInstanceProperties', 'CimSystemProperties') `
                -and $_.IsValueModified)
            {
                $targetKeys += $_.Name
            }
        }
    }
    elseif ($Target.GetType().FullName -like "*Hashtable")
    {
        $targetKeys = $Target.Keys | Where-Object -FilterScript { $_ -ne 'PSComputerName' }
    }
    else # Most likely a Microsoft Graph Model
    {
        $Target = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $Target
        $targetKeys = $Target.Keys | Where-Object -FilterScript { $_ -ne 'PSComputerName' }
    }

    foreach ($key in $keys)
    {
        #Matching possible key names between Source and Target
        $sourceValue = $Source.$key

        # Some classes might contain default properties that have the same name as the key,
        # so we need to check if the key is present in the target object --> Hashtable <-> IsReadOnly property
        if ($key -in $targetKeys)
        {
            $targetValue = $Target.$key
        }
        else
        {
            $targetValue = $null
        }

        #One of the item is null and not the other
        if (($null -eq $Source.$key) -xor ($null -eq $targetValue))
        {
            if ($null -eq $Source.$key)
            {
                $sourceValue = 'null'
            }

            if ($null -eq $targetValue)
            {
                $targetValue = 'null'
            }

            Write-Verbose -Message "Configuration drift - key: $key Source {$sourceValue} Target {$targetValue}"
            return $false
        }

        #Both keys aren't null or empty
        if (($null -ne $Source.$key) -and ($null -ne $Target.$key))
        {
            if ($Source.$key.GetType().FullName -like '*CimInstance*' -or $Source.$key.GetType().FullName -like '*hashtable*')
            {
                if ($Source.$key.GetType().FullName -like '*CimInstance' -and (
                        $Source.$key.CimClass.CimClassName -eq 'MSFT_DeviceManagementConfigurationPolicyAssignments' -or
                        $Source.$key.CimClass.CimClassName -like 'MSFT_DeviceManagementMobileAppAssignment' -or
                        $Source.$key.CimClass.CimClassName -like 'MSFT_Intune*Assignments'
                    ))
                {
                    $compareResult = Compare-M365DSCIntunePolicyAssignment `
                        -Source @($Source.$key) `
                        -Target @($Target.$key)
                }
                else
                {
                    #Recursive call for complex object
                    $compareResult = Compare-M365DSCComplexObject `
                        -Source $Source.$key `
                        -Target $Target.$key
                }

                if (-not $compareResult)
                {
                    Write-Verbose -Message "Configuration drift - complex object key: $key Source {$sourceValue} Target {$targetValue}"
                    return $false
                }
            }
            else
            {
                #Simple object comparison
                $referenceObject = $Target.$key
                $differenceObject = $Source.$key

                #Identifying date from the current values
                $targetType = ($Target.$key.GetType()).Name
                if ($targetType -like '*Date*')
                {
                    $compareResult = $true
                    $sourceDate = [DateTime]$Source.$key
                    if ($sourceDate -ne $targetType)
                    {
                        $compareResult = $null
                    }
                }
                else
                {
                    $compareResult = Compare-Object `
                        -ReferenceObject ($referenceObject) `
                        -DifferenceObject ($differenceObject)
                }

                if ($null -ne $compareResult)
                {
                    Write-Verbose -Message "Configuration drift - simple object key: $key Source {$sourceValue} Target {$targetValue}"
                    return $false
                }
            }
        }
    }
    return $true
}

function Convert-M365DSCDRGComplexTypeToHashtable
{
    [CmdletBinding()]
    [OutputType([hashtable], [hashtable[]])]
    param(
        [Parameter(Mandatory = $true)]
        [AllowNull()]
        $ComplexObject,

        [Parameter()]
        [switch]
        $SingleLevel
    )

    if ($null -eq $ComplexObject)
    {
        return @{}
    }

    if ($ComplexObject.GetType().Fullname -like '*[[\]]')
    {
        $results = @()
        foreach ($item in $ComplexObject)
        {
            $hash = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
            $results += $hash
        }

        #Write-Verbose -Message ("Convert-M365DSCDRGComplexTypeToHashtable >>> results: "+(convertTo-JSON $results -Depth 20))
        # PowerShell returns all non-captured stream output, not just the argument of the return statement.
        #An empty array is mangled into $null in the process.
        #However, an array can be preserved on return by prepending it with the array construction operator (,)
        return , [hashtable[]]$results
    }
    $hashComplexObject = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject

    if ($null -ne $hashComplexObject)
    {
        $results = $hashComplexObject.Clone()
        if ($SingleLevel)
        {
            return [hashtable]$results
        }

        $keys = $hashComplexObject.Keys | Where-Object -FilterScript { $_ -ne 'PSComputerName' }
        foreach ($key in $keys)
        {
            if ($hashComplexObject[$key] -and $hashComplexObject[$key].GetType().Fullname -like '*CimInstance*')
            {
                $results[$key] = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $hashComplexObject[$key]
            }
            else
            {
                $propertyName = $key[0].ToString().ToLower() + $key.Substring(1, $key.Length - 1)
                $propertyValue = $results[$key]
                $results.Remove($key) | Out-Null
                $results.Add($propertyName, $propertyValue)
            }
        }
    }

    return [hashtable]$results
}

function ConvertFrom-IntunePolicyAssignment
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable[]])]
    param (
        [Parameter(Mandatory = $true)]
        [Array]
        $Assignments,
        [Parameter()]
        [System.Boolean]
        $IncludeDeviceFilter = $true
    )

    $assignmentResult = @()
    foreach ($assignment in $Assignments)
    {
        $hashAssignment = @{}
        if ($null -ne $assignment.Target.'@odata.type')
        {
            $dataType = $assignment.Target.'@odata.type'
        }
        else
        {
            $dataType = $assignment.Target.AdditionalProperties.'@odata.type'
        }

        if ($null -ne $assignment.Target.groupId)
        {
            $groupId = $assignment.Target.groupId
        }
        else
        {
            $groupId = $assignment.Target.AdditionalProperties.groupId
        }

        if ($null -ne $assignment.Target.collectionId)
        {
            $collectionId = $assignment.Target.collectionId
        }
        else
        {
            $collectionId = $assignment.Target.AdditionalProperties.collectionId
        }

        $hashAssignment.Add('dataType',$dataType)
        if (-not [string]::IsNullOrEmpty($groupId))
        {
            $hashAssignment.Add('groupId', $groupId)

            $group = Get-MgGroup -GroupId ($groupId) -ErrorAction SilentlyContinue
            if ($null -ne $group)
            {
                $groupDisplayName = $group.DisplayName
            }
        }
        if (-not [string]::IsNullOrEmpty($collectionId))
        {
            $hashAssignment.Add('collectionId', $collectionId)
        }
        if ($dataType -eq '#microsoft.graph.allLicensedUsersAssignmentTarget')
        {
            $groupDisplayName = 'All users'
        }
        if ($dataType -eq '#microsoft.graph.allDevicesAssignmentTarget')
        {
            $groupDisplayName = 'All devices'
        }
        if ($null -ne $groupDisplayName)
        {
            $hashAssignment.Add('groupDisplayName', $groupDisplayName)
        }
        if ($IncludeDeviceFilter)
        {
            if ($null -ne $assignment.Target.DeviceAndAppManagementAssignmentFilterType)
            {
                $hashAssignment.Add('deviceAndAppManagementAssignmentFilterType', $assignment.Target.DeviceAndAppManagementAssignmentFilterType.ToString())
            }
            if ($null -ne $assignment.Target.DeviceAndAppManagementAssignmentFilterId)
            {
                $hashAssignment.Add('deviceAndAppManagementAssignmentFilterId', $assignment.Target.DeviceAndAppManagementAssignmentFilterId)
            }
        }

        $assignmentResult += $hashAssignment
    }

    return ,$assignmentResult
}

function ConvertTo-IntunePolicyAssignment
{
    [CmdletBinding()]
    [OutputType([Hashtable[]])]
    param (
        [Parameter(Mandatory = $true)]
        [AllowNull()]
        $Assignments,

        [Parameter()]
        [System.Boolean]
        $IncludeDeviceFilter = $true
    )

    if ($null -eq $Assignments)
    {
        return ,@()
    }

    $assignmentResult = @()
    foreach ($assignment in $Assignments)
    {
        $target = @{"@odata.type" = $assignment.dataType}
        if ($IncludeDeviceFilter)
        {
            if ($null -ne $assignment.DeviceAndAppManagementAssignmentFilterType)
            {
                $target.Add('deviceAndAppManagementAssignmentFilterType', $assignment.DeviceAndAppManagementAssignmentFilterType)
                $target.Add('deviceAndAppManagementAssignmentFilterId', $assignment.DeviceAndAppManagementAssignmentFilterId)
            }
        }
        if ($assignment.dataType -like '*CollectionAssignmentTarget')
        {
            $target.Add('collectionId', $assignment.collectionId)
        }
        elseif ($assignment.dataType -like '*GroupAssignmentTarget')
        {
            $group = Get-MgGroup -GroupId ($assignment.groupId) -ErrorAction SilentlyContinue
            if ($null -eq $group)
            {
                if ($assignment.groupDisplayName)
                {
                    $group = Get-MgGroup -Filter "DisplayName eq '$($assignment.groupDisplayName)'" -ErrorAction SilentlyContinue
                    if ($null -eq $group)
                    {
                        $message = "Skipping assignment for the group with DisplayName {$($assignment.groupDisplayName)} as it could not be found in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or groupDisplayName."
                        Write-Verbose -Message $message
                        $target = $null
                    }
                    if ($group -and $group.Count -gt 1)
                    {
                        $message = "Skipping assignment for the group with DisplayName {$($assignment.groupDisplayName)} as it is not unique in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                        Write-Verbose -Message $message
                        $group = $null
                        $target = $null
                    }
                }
                else
                {
                    $message = "Skipping assignment for the group with Id {$($assignment.groupId)} as it could not be found in the directory.`r`n"
                    $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                    Write-Verbose -Message $message
                    $target = $null
                }
            }
            #Skipping assignment if group not found from either groupId or groupDisplayName
            if ($null -ne $group)
            {
                $target.Add('groupId', $group.Id)
            }
        }

        if ($target)
        {
            $assignmentResult += @{target = $target}
        }
    }

    return ,$assignmentResult
}

function ConvertFrom-IntuneMobileAppAssignment
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable[]])]
    param (
        [Parameter(Mandatory = $true)]
        [Array]
        $Assignments,
        [Parameter()]
        [System.Boolean]
        $IncludeDeviceFilter = $true
    )

    $assignmentResult = @()
    foreach ($assignment in $Assignments)
    {
        $hashAssignment = @{}
        if ($null -ne $assignment.Target.'@odata.type')
        {
            $dataType = $assignment.Target.'@odata.type'
        }
        else
        {
            $dataType = $assignment.Target.AdditionalProperties.'@odata.type'
        }

        if ($null -ne $assignment.Target.groupId)
        {
            $groupId = $assignment.Target.groupId
        }
        else
        {
            $groupId = $assignment.Target.AdditionalProperties.groupId
        }

        $hashAssignment.Add('dataType', $dataType)
        if (-not [string]::IsNullOrEmpty($groupId))
        {
            $hashAssignment.Add('groupId', $groupId)

            $group = Get-MgGroup -GroupId ($groupId) -ErrorAction SilentlyContinue
            if ($null -ne $group)
            {
                $groupDisplayName = $group.DisplayName
            }
        }

        if ($dataType -eq '#microsoft.graph.allLicensedUsersAssignmentTarget')
        {
            $groupDisplayName = 'All users'
        }
        if ($dataType -eq '#microsoft.graph.allDevicesAssignmentTarget')
        {
            $groupDisplayName = 'All devices'
        }
        if ($null -ne $groupDisplayName)
        {
            $hashAssignment.Add('groupDisplayName', $groupDisplayName)
        }

        $hashAssignment.Add('intent', $assignment.intent.ToString())

        # $concatenatedSettings = $assignment.settings.ToString() -join ','
        # $hashAssignment.Add('settings', $concatenatedSettings)
        # $hashSettings = @{}
        # foreach ($setting in $assignment.Settings)
        # {
        #   $hashSettings.Add('datatype', $setting.dataType)
        #   $hashSettings.Add('uninstallOnDeviceRemoval', $setting.uninstallOnDeviceRemoval)
        # }
        # $hashAssignment.Add('settings', $hashSettings)

        if ($IncludeDeviceFilter)
        {
            if ($null -ne $assignment.Target.DeviceAndAppManagementAssignmentFilterType)
            {
                $hashAssignment.Add('deviceAndAppManagementAssignmentFilterType', $assignment.Target.DeviceAndAppManagementAssignmentFilterType.ToString())
            }
            if ($null -ne $assignment.Target.DeviceAndAppManagementAssignmentFilterId)
            {
                $hashAssignment.Add('deviceAndAppManagementAssignmentFilterId', $assignment.Target.DeviceAndAppManagementAssignmentFilterId)
            }
        }

        $assignmentResult += $hashAssignment
    }

    return ,$assignmentResult
}

function ConvertTo-IntuneMobileAppAssignment
{
    [CmdletBinding()]
    [OutputType([Hashtable[]])]
    param (
        [Parameter(Mandatory = $true)]
        [AllowNull()]
        $Assignments,

        [Parameter()]
        [System.Boolean]
        $IncludeDeviceFilter = $true
    )

    if ($null -eq $Assignments)
    {
        return ,@()
    }

    $assignmentResult = @()
    foreach ($assignment in $Assignments)
    {
        $formattedAssignment = @{}
        $target = @{"@odata.type" = $assignment.dataType}
        if ($IncludeDeviceFilter)
        {
            if ($null -ne $assignment.DeviceAndAppManagementAssignmentFilterType)
            {
                $target.Add('deviceAndAppManagementAssignmentFilterType', $assignment.DeviceAndAppManagementAssignmentFilterType)
                $target.Add('deviceAndAppManagementAssignmentFilterId', $assignment.DeviceAndAppManagementAssignmentFilterId)
            }
        }

        $formattedAssignment.Add('intent', $assignment.intent)

        if ($assignment.dataType -like '*groupAssignmentTarget')
        {
            $group = Get-MgGroup -GroupId ($assignment.groupId) -ErrorAction SilentlyContinue
            if ($null -eq $group)
            {
                if ($assignment.groupDisplayName)
                {
                    $group = Get-MgGroup -Filter "DisplayName eq '$($assignment.groupDisplayName)'" -ErrorAction SilentlyContinue
                    if ($null -eq $group)
                    {
                        $message = "Skipping assignment for the group with DisplayName {$($assignment.groupDisplayName)} as it could not be found in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or groupDisplayName."
                        Write-Verbose -Message $message
                        $target = $null
                    }
                    if ($group -and $group.Count -gt 1)
                    {
                        $message = "Skipping assignment for the group with DisplayName {$($assignment.groupDisplayName)} as it is not unique in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                        Write-Verbose -Message $message
                        $group = $null
                        $target = $null
                    }
                }
                else
                {
                    $message = "Skipping assignment for the group with Id {$($assignment.groupId)} as it could not be found in the directory.`r`n"
                    $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                    Write-Verbose -Message $message
                    $target = $null
                }
            }
            else {
                #Skipping assignment if group not found from either groupId or groupDisplayName
                $target.Add('groupId', $group.Id)
            }
        }

        if ($target)
        {
            $formattedAssignment.Add('target', $target)
        }
        $assignmentResult += $formattedAssignment
    }

    return ,$assignmentResult
}

function Compare-M365DSCIntunePolicyAssignment
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [Parameter()]
        [array]$Source,
        [Parameter()]
        [array]$Target
    )

    $testResult = $Source.Count -eq $Target.Count
    Write-Verbose "Count: $($Source.Count) - $($Target.Count)"
    if ($testResult)
    {
        foreach ($assignment in $Source)
        {
            if ($assignment.dataType -like '*AssignmentTarget')
            {
                $assignmentTarget = $Target | Where-Object -FilterScript { $_.dataType -eq $assignment.DataType -and $_.groupId -eq $assignment.groupId }
                $testResult = $null -ne $assignmentTarget
                # Check for mobile app assignments with intent
                $testResult = $assignment.intent -eq $assignmentTarget.intent
                # Using assignment groupDisplayName only if the groupId is not found in the directory otherwise groupId should be the key
                if (-not $testResult)
                {
                    Write-Verbose 'Group not found by groupId, checking if group exists by id'
                    $groupNotFound =  $null -eq (Get-MgGroup -GroupId ($assignment.groupId) -ErrorAction SilentlyContinue)
                }
                if (-not $testResult -and $groupNotFound)
                {
                    Write-Verbose 'Group not found by groupId, looking for group by groupDisplayName'
                    $assignmentTarget = $Target | Where-Object -FilterScript { $_.dataType -eq $assignment.DataType -and $_.groupDisplayName -eq $assignment.groupDisplayName }
                    $testResult = $null -ne $assignmentTarget
                }

                if ($testResult)
                {
                    Write-Verbose 'Group found by groupId or groupDisplayName, checking filters'
                    $isFilterTypeSpecified = ($null -ne $assignment.deviceAndAppManagementAssignmentFilterType -and $assignment.deviceAndAppManagementAssignmentFilterType -ne 'none') -or `
                        ($null -ne $assignmentTarget.deviceAndAppManagementAssignmentFilterType -and $assignmentTarget.deviceAndAppManagementAssignmentFilterType -ne 'none')
                    $isFilterIdSpecified = ($null -ne $assignment.deviceAndAppManagementAssignmentFilterId -and $assignment.deviceAndAppManagementAssignmentFilterId -ne '00000000-0000-0000-0000-000000000000') -or `
                        ($null -ne $assignmentTarget.deviceAndAppManagementAssignmentFilterId -and $assignmentTarget.deviceAndAppManagementAssignmentFilterId -ne '00000000-0000-0000-0000-000000000000')
                    if ($isFilterTypeSpecified)
                    {
                        Write-Verbose 'FilterType specified, checking filterType'
                        $testResult = $assignment.deviceAndAppManagementAssignmentFilterType -eq $assignmentTarget.deviceAndAppManagementAssignmentFilterType
                    }
                    if ($testResult -and $isFilterTypeSpecified -and $isFilterIdSpecified)
                    {
                        Write-Verbose 'FilterId specified, checking filterId'
                        $testResult = $assignment.deviceAndAppManagementAssignmentFilterId -eq $assignmentTarget.deviceAndAppManagementAssignmentFilterId
                    }
                }

                if ($testResult)
                {
                    Write-Verbose 'Group and filters match, checking collectionId'
                    $testResult = $assignment.collectionId -eq $assignmentTarget.collectionId
                }
            }
            else
            {
                $testResult = $null -ne ($Target | Where-Object -FilterScript { $_.dataType -eq $assignment.DataType })
            }
            if (-not $testResult) { break }
        }
    }

    return $testResult
}

function Update-DeviceConfigurationPolicyAssignment
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter()]
        [Array]
        $Targets,

        [Parameter()]
        [System.String]
        $Repository = 'deviceManagement/configurationPolicies',

        [Parameter()]
        [ValidateSet('v1.0','beta')]
        [System.String]
        $APIVersion = 'beta',

        [Parameter()]
        [System.String]
        $RootIdentifier = 'assignments'
    )

    try
    {
        $deviceManagementPolicyAssignments = @()
        $Uri = "/$APIVersion/$Repository/$DeviceConfigurationPolicyId/assign"

        foreach ($target in $targets)
        {
            if ($target.target -is [hashtable])
            {
                $target = $target.target
            }

            $formattedTarget = @{"@odata.type" = $target.dataType}
            if(-not $formattedTarget."@odata.type" -and $target."@odata.type")
            {
                $formattedTarget."@odata.type" = $target."@odata.type"
            }
            if ($target.groupId)
            {
                $group = Get-MgGroup -GroupId ($target.groupId) -ErrorAction SilentlyContinue
                if ($null -eq $group)
                {
                    if ($target.groupDisplayName)
                    {
                        $group = Get-MgGroup -Filter "DisplayName eq '$($target.groupDisplayName)'" -ErrorAction SilentlyContinue
                        if ($null -eq $group)
                        {
                            $message = "Skipping assignment for the group with DisplayName {$($target.groupDisplayName)} as it could not be found in the directory.`r`n"
                            $message += "Please update your DSC resource extract with the correct groupId or groupDisplayName."
                            Write-Verbose -Message $message
                            $target = $null
                        }
                        if ($group -and $group.count -gt 1)
                        {
                            $message = "Skipping assignment for the group with DisplayName {$($target.groupDisplayName)} as it is not unique in the directory.`r`n"
                            $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                            Write-Verbose -Message $message
                            $group = $null
                            $target = $null
                        }
                    }
                    else
                    {
                        $message = "Skipping assignment for the group with Id {$($target.groupId)} as it could not be found in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                        Write-Verbose -Message $message
                        $target = $null
                    }
                }
                #Skipping assignment if group not found from either groupId or groupDisplayName
                if ($null -ne $group)
                {
                    $formattedTarget.Add('groupId',$group.Id)
                }
            }
            if ($target.collectionId)
            {
                $formattedTarget.Add('collectionId',$target.collectionId)
            }
            if ($target.deviceAndAppManagementAssignmentFilterType)
            {
                $formattedTarget.Add('deviceAndAppManagementAssignmentFilterType',$target.deviceAndAppManagementAssignmentFilterType)
            }
            if ($target.deviceAndAppManagementAssignmentFilterId)
            {
                $formattedTarget.Add('deviceAndAppManagementAssignmentFilterId',$target.deviceAndAppManagementAssignmentFilterId)
            }
            $deviceManagementPolicyAssignments += @{'target' = $formattedTarget}
        }

        $body = @{$RootIdentifier = $deviceManagementPolicyAssignments} | ConvertTo-Json -Depth 20
        Write-Verbose -Message $body

        Invoke-MgGraphRequest -Method POST -Uri $Uri -Body $body -ErrorAction Stop
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error updating data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $null
    }
}

function Update-DeviceAppManagementPolicyAssignment
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $AppManagementPolicyId,

        [Parameter()]
        [Array]
        $Assignments,

        [Parameter()]
        [System.String]
        $Repository = 'deviceAppManagement/mobileApps',

        [Parameter()]
        [ValidateSet('v1.0','beta')]
        [System.String]
        $APIVersion = 'beta',

        [Parameter()]
        [System.String]
        $RootIdentifier = 'mobileAppAssignments'
    )

    try
    {
        $appManagementPolicyAssignments = @()
        $Uri = "/$APIVersion/$Repository/$AppManagementPolicyId/assign"

        foreach ($assignment in $Assignments)
        {
            $formattedAssignment = @{
                '@odata.type' = '#microsoft.graph.mobileAppAssignment'
                intent = $assignment.intent
            }
            if ($assigment.settings)
            {
                $formattedAssignment.Add('settings', $assignment.settings)
            }

            if ($assignment.target -is [hashtable])
            {
                $target = $assignment.target
            }

            $formattedTarget = @{"@odata.type" = $target.dataType}
            if(-not $formattedTarget."@odata.type" -and $target."@odata.type")
            {
                $formattedTarget."@odata.type" = $target."@odata.type"
            }
            if ($target.groupId)
            {
                $group = Get-MgGroup -GroupId ($target.groupId) -ErrorAction SilentlyContinue
                if ($null -eq $group)
                {
                    if ($target.groupDisplayName)
                    {
                        $group = Get-MgGroup -Filter "DisplayName eq '$($target.groupDisplayName)'" -ErrorAction SilentlyContinue
                        if ($null -eq $group)
                        {
                            $message = "Skipping assignment for the group with DisplayName {$($target.groupDisplayName)} as it could not be found in the directory.`r`n"
                            $message += "Please update your DSC resource extract with the correct groupId or groupDisplayName."
                            Write-Verbose -Message $message
                            $target = $null
                        }
                        if ($group -and $group.count -gt 1)
                        {
                            $message = "Skipping assignment for the group with DisplayName {$($target.groupDisplayName)} as it is not unique in the directory.`r`n"
                            $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                            Write-Verbose -Message $message
                            $group = $null
                            $target = $null
                        }
                    }
                    else
                    {
                        $message = "Skipping assignment for the group with Id {$($target.groupId)} as it could not be found in the directory.`r`n"
                        $message += "Please update your DSC resource extract with the correct groupId or a unique group DisplayName."
                        Write-Verbose -Message $message
                        $target = $null
                    }
                }
                #Skipping assignment if group not found from either groupId or groupDisplayName
                if ($null -ne $group)
                {
                    $formattedTarget.Add('groupId',$group.Id)
                }
            }
            if ($target.deviceAndAppManagementAssignmentFilterType)
            {
                $formattedTarget.Add('deviceAndAppManagementAssignmentFilterType',$target.deviceAndAppManagementAssignmentFilterType)
            }
            if ($target.deviceAndAppManagementAssignmentFilterId)
            {
                $formattedTarget.Add('deviceAndAppManagementAssignmentFilterId',$target.deviceAndAppManagementAssignmentFilterId)
            }
            $formattedAssignment.Add('target', $formattedTarget)
            $appManagementPolicyAssignments += $formattedAssignment
        }

        $body = @{$RootIdentifier = $appManagementPolicyAssignments} | ConvertTo-Json -Depth 20
        Write-Verbose -Message $body

        Invoke-MgGraphRequest -Method POST -Uri $Uri -Body $body -ErrorAction Stop
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error updating data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $null
    }
}

function Get-OmaSettingPlainTextValue
{
    [CmdletBinding()]
    [OutputType([System.String])]
    Param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $SecretReferenceValueId,

        [Parameter()]
        [ValidateSet('v1.0', 'beta')]
        [System.String]
        $APIVersion = 'beta'
    )

    try
    {
        <#
            e.g. PolicyId for SecretReferenceValueId '35ea58ec-2a79-471d-8eea-7e28e6cd2722_bdf6c690-05fb-4d02-835d-5a7406c35d58_abe32712-2255-445f-a35e-0c6f143d82ca'
            is 'bdf6c690-05fb-4d02-835d-5a7406c35d58'
        #>
        $SplitSecretReferenceValueId = $SecretReferenceValueId.Split("_")
        if ($SplitSecretReferenceValueId.Count -eq 3)
        {
            $PolicyId = $SplitSecretReferenceValueId[1]
        }
        else
        {
            return $null
        }
    }
    catch
    {
        return $null
    }

    $Repository = 'deviceManagement/deviceConfigurations'
    $Uri = "/{0}/{1}/{2}/getOmaSettingPlainTextValue(secretReferenceValueId='{3}')" -f $APIVersion, $Repository, $PolicyId, $SecretReferenceValueId

    try
    {
        $Result = Invoke-MgGraphRequest -Method GET -Uri $Uri -ErrorAction Stop
    }
    catch
    {
        $Message = "Error decrypting OmaSetting with SecretReferenceValueId {0}:" -f $SecretReferenceValueId
        New-M365DSCLogEntry -Message $Message `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $null
    }

    if (![String]::IsNullOrEmpty($Result.Value))
    {
        return $Result.Value
    } else {
        return $null
    }
}

function Get-IntuneSettingCatalogPolicySetting
{
    [CmdletBinding()]
    [OutputType([System.Array])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $DSCParams,

        [Parameter(
            Mandatory = 'true',
            ParameterSetName = 'Start'
        )]
        [System.String]
        $TemplateId,

        [Parameter(
            Mandatory = 'true',
            ParameterSetName = 'DeviceAndUserSettings'
        )]
        [System.Array]
        $SettingTemplates,

        [Parameter(ParameterSetName = 'Start')]
        [switch]
        $ContainsDeviceAndUserSettings
    )

    $global:excludedDefinitionIds = @()

    $DSCParams.Remove('Identity') | Out-Null
    $DSCParams.Remove('DisplayName') | Out-Null
    $DSCParams.Remove('Description') | Out-Null

    $settingInstances = @()
    if ($PSCmdlet.ParameterSetName -eq 'Start')
    {
        # Prepare setting definitions mapping
        $SettingTemplates = Get-MgBetaDeviceManagementConfigurationPolicyTemplateSettingTemplate `
            -DeviceManagementConfigurationPolicyTemplateId $TemplateId `
            -ExpandProperty 'SettingDefinitions' `
            -All

        if ($ContainsDeviceAndUserSettings)
        {
            $deviceSettingTemplates = $SettingTemplates | Where-object -FilterScript {
                $_.SettingInstanceTemplate.SettingDefinitionId.StartsWith("device_")
            }
            $userSettingTemplates = $SettingTemplates | Where-object -FilterScript {
                $_.SettingInstanceTemplate.SettingDefinitionId.StartsWith("user_")
            }
            $deviceDscParams = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $DSCParams.DeviceSettings -SingleLevel
            $userDscParams = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $DSCParams.UserSettings -SingleLevel
            $combinedSettingInstances = @()
            $combinedSettingInstances += Get-IntuneSettingCatalogPolicySetting -DSCParams $deviceDscParams -SettingTemplates $deviceSettingTemplates
            $combinedSettingInstances += Get-IntuneSettingCatalogPolicySetting -DSCParams $userDscParams -SettingTemplates $userSettingTemplates

            return ,$combinedSettingInstances
        }
    }

    # Iterate over all setting instance templates in the setting template
    foreach ($settingInstanceTemplate in $SettingTemplates.SettingInstanceTemplate)
    {
        $settingInstance = @{}
        $settingDefinition = $SettingTemplates.SettingDefinitions | Where-Object {
            $_.Id -eq $settingInstanceTemplate.SettingDefinitionId -and `
            ($_.AdditionalProperties.dependentOn.Count -eq 0 -and $_.AdditionalProperties.options.dependentOn.Count -eq 0)
        }
        if ($null -eq $settingDefinition)
        {
            continue
        }
        if ($settingDefinition -is [System.Array])
        {
            $settingDefinition = $settingDefinition[0]
        }
        $settingName = $settingDefinition.Name
        $settingType = $settingInstanceTemplate.AdditionalProperties.'@odata.type'.Replace('InstanceTemplate', 'Instance')
        $settingInstance.Add('@odata.type', $settingType)
        if (-not [string]::IsNullOrEmpty($settingInstanceTemplate.settingInstanceTemplateId))
        {
            $settingInstance.Add('settingInstanceTemplateReference', @{'settingInstanceTemplateId' = $settingInstanceTemplate.settingInstanceTemplateId })
        }
        $settingValueName = $settingType.Replace('#microsoft.graph.deviceManagementConfiguration', '').Replace('Instance', 'Value')
        $settingValueName = $settingValueName.Substring(0, 1).ToLower() + $settingValueName.Substring(1, $settingValueName.length - 1 )
        $settingValueType = $settingInstanceTemplate.AdditionalProperties."$($settingValueName)Template".'@odata.type'
        if ($null -ne $settingValueType)
        {
            $settingValueType = $settingValueType.Replace('ValueTemplate', 'Value')
        }
        $settingValueTemplateId = $settingInstanceTemplate.AdditionalProperties."$($settingValueName)Template".settingValueTemplateId

        # Get all the values in the setting instance
        $settingValue = Get-IntuneSettingCatalogPolicySettingInstanceValue `
            -DSCParams $DSCParams `
            -SettingDefinition $settingDefinition `
            -SettingTemplates $settingTemplates `
            -SettingName $settingName `
            -SettingType $settingType `
            -SettingValueName $settingValueName `
            -SettingValueType $settingValueType `
            -SettingValueTemplateId $settingValueTemplateId

        if ($settingValue.Count -gt 0)
        {
            if ($settingValue.Keys -contains 'groupSettingCollectionValue' -and $settingValue.groupSettingCollectionValue.children.Count -eq 0)
            {
                continue
            }

            $settingInstance += [Hashtable]$settingValue
            if ($settingInstance.Keys -notcontains 'settingDefinitionId')
            {
                $settingInstance.Add('settingDefinitionId', $settingInstanceTemplate.settingDefinitionId)
            }
            $settingInstances += @{
                '@odata.type'     = '#microsoft.graph.deviceManagementConfigurationSetting'
                'settingInstance' = $settingInstance
            }
        }
    }

    return ,$settingInstances
}

function Get-IntuneSettingCatalogPolicySettingInstanceValue
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $DSCParams,

        [Parameter()]
        $SettingDefinition,

        [Parameter()]
        $SettingTemplates,

        [Parameter()]
        [System.String]
        $SettingType,

        [Parameter()]
        [System.String]
        $SettingName,

        [Parameter()]
        [System.String]
        $SettingValueName,

        [Parameter()]
        [System.String]
        $SettingValueType,

        [Parameter()]
        [System.String]
        $SettingValueTemplateId,

        [Parameter()]
        [System.String]
        $SettingInstanceName = 'MSFT_MicrosoftGraphIntuneSettingsCatalog',

        [Parameter()]
        [System.Int32]
        $Level = 1
    )

    $settingValuesToReturn = @{}
    if ($null -eq $global:excludedDefinitionIds)
    {
        $global:excludedDefinitionIds = @()
    }
    if ($null -eq $global:excludedDscParams)
    {
        $global:excludedDscParams = @()
    }

    # Depending on the setting type, there is other logic involved
    switch ($SettingType)
    {
        # GroupSettingCollections are a collection of settings without a value of their own
        { $_ -eq '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance' -or $_ -eq '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition' }
        {
            $groupSettingCollectionValue = @()
            $groupSettingCollectionDefinitionChildren = @()

            $templates = $SettingTemplates | Where-Object {
                $_.settingInstanceTemplate.settingDefinitionId -eq $SettingDefinition.RootDefinitionId
            }
            $groupSettingCollectionDefinitionChildren += $templates.SettingDefinitions | Where-Object {
                ($_.AdditionalProperties.dependentOn.Count -gt 0 -and $_.AdditionalProperties.dependentOn.parentSettingId -contains $SettingDefinition.Id) -or
                ($_.AdditionalProperties.options.dependentOn.Count -gt 0 -and $_.AdditionalProperties.options.dependentOn.parentSettingId -contains $SettingDefinition.Id)
            }

            $instanceCount = 1
            if ($Level -ge 2 -and $groupSettingCollectionDefinitionChildren.Count -gt 1)
            {
                $SettingInstanceName += $SettingDefinition.Name
                $cimDSCParams = @()
                $cimDSCParamsName = ""
                $DSCParams.GetEnumerator() | Where-Object -FilterScript {
                    $_.Value.CimClass.CimClassName -contains $SettingInstanceName
                } | Foreach-Object -Process {
                    $cimDSCParams += $_.Value
                    $cimDSCParamsName = $_.Key
                }
                $newDSCParams = @{
                    $cimDSCParamsName = @()
                }
                foreach ($instance in $cimDSCParams) {
                    $newInstanceDSCParams = @{}
                    # Preserve CIM instances when converting to hashtable
                    foreach ($property in $instance.CimInstanceProperties) {
                        $newInstanceDSCParams.Add($property.Name, $property.Value)
                    }
                    $newDSCParams.$cimDSCParamsName += $newInstanceDSCParams
                }
                $instanceCount = $newDSCParams.$cimDSCParamsName.Count
                $DSCParams = @{
                    $cimDSCParamsName = if ($instanceCount -eq 1) { $newDSCParams.$cimDSCParamsName[0] } else { $newDSCParams.$cimDSCParamsName }
                }
            }

            for ($i = 0; $i -lt $instanceCount; $i++)
            {
                $groupSettingCollectionValueChildren = @()
                $currentDSCParams = if ($instanceCount -eq 1) {
                    if (-not [System.String]::IsNullOrEmpty($cimDSCParamsName)) {
                        $DSCParams.$cimDSCParamsName
                    } else {
                        $DSCParams
                    }
                } else {
                    if (-not [System.String]::IsNullOrEmpty($cimDSCParamsName)) {
                        $DSCParams.$cimDSCParamsName[$i]
                    } else {
                        $DSCParams[$i]
                    }
                }
                if ($null -eq $currentDSCParams)
                {
                    # Should we continue? Let's try out
                    $currentDSCParams = @{}
                }

                foreach ($childDefinition in $groupSettingCollectionDefinitionChildren)
                {
                    $childSettingName = $childDefinition.Name
                    $childSettingType = $childDefinition.AdditionalProperties.'@odata.type'.Replace('Definition', 'Instance').Replace('SettingGroup', 'GroupSetting')
                    $childSettingValueName = $childSettingType.Replace('#microsoft.graph.deviceManagementConfiguration', '').Replace('Instance', 'Value')
                    $childSettingValueType = "#microsoft.graph.deviceManagementConfiguration$($childSettingValueName)"
                    $childSettingValueName = $childSettingValueName.Substring(0, 1).ToLower() + $childSettingValueName.Substring(1, $childSettingValueName.length - 1 )
                    $childSettingInstanceTemplate = $SettingTemplates.SettingInstanceTemplate | Where-Object { $_.SettingDefinitionId -eq $childDefinition.Id }
                    $childSettingValueTemplateId = $childSettingInstanceTemplate.AdditionalProperties."$($childSettingValueName)Template".settingValueTemplateId
                    $childSettingValue = Get-IntuneSettingCatalogPolicySettingInstanceValue `
                        -DSCParams $currentDSCParams `
                        -SettingDefinition $childDefinition `
                        -SettingTemplates $SettingTemplates `
                        -SettingName $childSettingName `
                        -SettingType $childDefinition.AdditionalProperties.'@odata.type' `
                        -SettingValueName $childSettingValueName `
                        -SettingValueType $childSettingValueType `
                        -SettingValueTemplateId $childSettingValueTemplateId `
                        -SettingInstanceName $SettingInstanceName `
                        -Level ($Level + 1)

                    if ($childSettingValue.Keys.Count -gt 0)
                    {
                        # If only one child item is allowed but we have multiple values, we need to create an object for each child
                        # Happens e.g. for the IntuneDeviceControlPolicyWindows10 resource --> {ruleid} and {ruleid}_ruledata definitions
                        if ($childSettingValue.groupSettingCollectionValue.Count -gt 1 -and
                            $childDefinition.AdditionalProperties.maximumCount -eq 1 -and
                            $groupSettingCollectionDefinitionChildren.Count -eq 1)
                        {
                            $childSettingValueOld = $childSettingValue
                            $childSettingValue = @()
                            foreach ($childSettingValueItem in $childSettingValueOld.groupSettingCollectionValue)
                            {
                                $childSettingValueInner = @{
                                    children = @()
                                }
                                $childSettingValueItem.Add('@odata.type', $childSettingType)
                                $childSettingValueInner.children += @{
                                    '@odata.type' = '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
                                    groupSettingCollectionValue = @(
                                        @{
                                            children = $childSettingValueItem.children
                                        }
                                    )
                                    settingDefinitionId = $childDefinition.Id
                                }
                                if (-not [string]::IsNullOrEmpty($childSettingInstanceTemplate.settingInstanceTemplateId))
                                {
                                    $childSettingValueInner.children[0].groupSettingCollectionValue.settingInstanceTemplateReference = @{
                                        'settingInstanceTemplateId' = $childSettingInstanceTemplate.settingInstanceTemplateId
                                    }
                                }
                                $childSettingValue += $childSettingValueInner
                            }
                            $groupSettingCollectionValue += $childSettingValue
                        }
                        else
                        {
                            if ($childSettingValue.Keys -notcontains 'settingDefinitionId')
                            {
                                $childSettingValue.Add('settingDefinitionId', $childDefinition.Id)
                            }
                            if (-not [string]::IsNullOrEmpty($childSettingInstanceTemplate.settingInstanceTemplateId))
                            {
                                $childSettingValue.Add('settingInstanceTemplateReference', @{'settingInstanceTemplateId' = $childSettingInstanceTemplate.settingInstanceTemplateId })
                            }
                            $childSettingValue.Add('@odata.type', $childSettingType)
                            $groupSettingCollectionValueChildren += $childSettingValue
                        }
                    }
                }

                # Does not happen for wrapped children elements
                if ($groupSettingCollectionValueChildren.Count -gt 0)
                {
                    $groupSettingCollectionValue += @{
                        children = @($groupSettingCollectionValueChildren)
                    }
                }
            }

            if ($groupSettingCollectionDefinitionChildren.Count -gt 0 -and $groupSettingCollectionValue.Count -gt 0) {
                $settingValuesToReturn.Add('groupSettingCollectionValue', @($groupSettingCollectionValue))
            }
        }
        # ChoiceSetting is a choice (e.g. dropdown) setting that, depending on the choice, can have children settings
        { $_ -eq '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance' -or $_ -eq '#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition' }
        {
            $choiceSettingValue = @{}
            $choiceSettingValueChildren = @()
            $choiceSettingDefinitionChildren = @()

            # Choice settings almost always have child settings, so we need to fetch those
            if ($null -ne $SettingDefinition)
            {
                $templates = $SettingTemplates | Where-Object {
                    $_.settingInstanceTemplate.settingDefinitionId -eq $SettingDefinition.RootDefinitionId
                }
                $choiceSettingDefinitionChildren += $templates.SettingDefinitions | Where-Object {
                    ($_.AdditionalProperties.dependentOn.Count -gt 0 -and $_.AdditionalProperties.dependentOn.parentSettingId.Contains($SettingDefinition.Id)) -or
                    ($_.AdditionalProperties.options.dependentOn.Count -gt 0 -and $_.AdditionalProperties.options.dependentOn.parentSettingId.Contains($SettingDefinition.Id))
                }
            }
            foreach ($childDefinition in $choiceSettingDefinitionChildren)
            {
                $childSettingName = $childDefinition.Name
                $childSettingType = $childDefinition.AdditionalProperties.'@odata.type'.Replace('Definition', 'Instance')
                $childSettingValueName = $childSettingType.Replace('#microsoft.graph.deviceManagementConfiguration', '').Replace('Instance', 'Value')
                $childSettingValueType = "#microsoft.graph.deviceManagementConfiguration$($childSettingValueName)"
                $childSettingValueName = $childSettingValueName.Substring(0, 1).ToLower() + $childSettingValueName.Substring(1, $childSettingValueName.Length - 1 )
                $childSettingInstanceTemplate = $SettingTemplates.SettingInstanceTemplate | Where-Object { $_.SettingDefinitionId -eq $childDefinition.Id }
                $childSettingValueTemplateId = $childSettingInstanceTemplate.AdditionalProperties."$($childSettingValueName)Template".settingValueTemplateId
                $childSettingValue = Get-IntuneSettingCatalogPolicySettingInstanceValue `
                    -DSCParams $DSCParams `
                    -SettingDefinition $childDefinition `
                    -SettingTemplates $SettingTemplates `
                    -SettingName $childSettingName `
                    -SettingType $childDefinition.AdditionalProperties.'@odata.type' `
                    -SettingValueName $childSettingValueName `
                    -SettingValueType $childSettingValueType `
                    -SettingValueTemplateId $childSettingValueTemplateId `
                    -SettingInstanceName $SettingInstanceName

                if ($childSettingValue.Keys.Count -gt 0)
                {
                    if ($childSettingValue.Keys -notcontains 'settingDefinitionId')
                    {
                        $childSettingValue.Add('settingDefinitionId', $childDefinition.Id)
                    }
                    if (-not [string]::IsNullOrEmpty($childSettingInstanceTemplate.settingInstanceTemplateId))
                    {
                        $childSettingValue.Add('settingInstanceTemplateReference', @{'settingInstanceTemplateId' = $childSettingInstanceTemplate.settingInstanceTemplateId })
                    }
                    $childSettingValue.Add('@odata.type', $childSettingType)
                    $choiceSettingValueChildren += $childSettingValue
                }
            }

            # Depending on the children count, we add the children to the choice setting or an empty array since the children property is required
            if ($choiceSettingDefinitionChildren.Count -gt 0) {
                $choiceSettingValue.Add('children', $choiceSettingValueChildren)
            } else {
                $choiceSettingValue.Add('children', @())
            }

            $valueResult = Get-IntuneSettingCatalogPolicySettingDSCValue `
                -SettingName $SettingName `
                -SettingValueType $SettingValueType `
                -SettingTemplates $SettingTemplates `
                -SettingDefinition $SettingDefinition `
                -DSCParams $DSCParams

            $value = $valueResult.Value

            # If there is a value in the DSC params, we add that to the choice setting
            if ($null -ne $value)
            {
                $value = $value
                $choiceSettingValue.Add('value', $value)
                $odataType = $SettingType.Replace('Definition', 'Value').Replace('Instance', 'Value')
                $choiceSettingValue.Add('@odata.type', $odataType)
                if (-not [string]::IsNullOrEmpty($SettingValueTemplateId))
                {
                    $choiceSettingValue.Add('settingValueTemplateReference', @{'settingValueTemplateId' = $SettingValueTemplateId })
                }
            }

            # If there are children or a value is configured, we add the choice setting to the return values
            if ($choiceSettingValue.Children.Count -gt 0 -or $null -ne $choiceSettingValue.value)
            {
                $settingValuesToReturn.Add('choiceSettingValue', $choiceSettingValue)
            }
        }
        # ChoiceSettingCollection is a collection of ChoiceSettings
        { $_ -eq '#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance' -or $_ -eq '#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionDefinition' }
        {
            $choiceSettingValueCollection = @()
            $valueResult = Get-IntuneSettingCatalogPolicySettingDSCValue `
                -SettingName $SettingName `
                -SettingValueType $SettingValueType `
                -SettingTemplates $SettingTemplates `
                -SettingDefinition $SettingDefinition `
                -DSCParams $DSCParams

            $values = $valueResult.Value

            if ($null -ne $values)
            {
                # We iterate over all the values in the DSC params and add them to the choice setting collection
                foreach ($value in $values)
                {
                    $choiceSettingValueCollection += @{
                        value    = $value
                        children = @()
                        '@odata.type' = '#microsoft.graph.deviceManagementConfigurationChoiceSettingValue'
                    }
                }

                $settingValuesToReturn.Add('choiceSettingCollectionValue', $choiceSettingValueCollection)
            }
        }
        # SimpleSettingCollections are collections of simple settings, e.g. strings or integers
        { $_ -eq '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance' -or $_ -eq '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionDefinition' }
        {
            $valuesResult = Get-IntuneSettingCatalogPolicySettingDSCValue `
                -SettingName $SettingName `
                -SettingValueType $SettingValueType `
                -SettingTemplates $SettingTemplates `
                -SettingDefinition $SettingDefinition `
                -DSCParams $DSCParams

            if ($null -eq $valuesResult)
            {
                return $null
            }

            $values = $valuesResult.Value
            $SettingValueType = $valuesResult.SettingDefinition.AdditionalProperties.valueDefinition.'@odata.type'.Replace('Definition', '')

            $settingValueCollection = @()
            foreach ($v in $values)
            {
                $settingValueCollection += @{
                    value         = $v
                    '@odata.type' = $SettingValueType
                }
            }
            if ($settingValueCollection.Count -gt 0) {
                $settingValuesToReturn.Add($SettingValueName, $settingValueCollection)
            }
        }
        # For all other types, e.g. Integer or String, we add the value directly
        Default
        {
            $valueResult = Get-IntuneSettingCatalogPolicySettingDSCValue `
                -SettingName $SettingName `
                -SettingValueType $SettingValueType `
                -SettingTemplates $SettingTemplates `
                -SettingDefinition $SettingDefinition `
                -DSCParams $DSCParams

            $value = $valueResult.Value
            $SettingValueType = $valueResult.SettingValueType
            $SettingDefinition = $valueResult.SettingDefinition

            if ($null -eq $value)
            {
                return $null
            }

            $settingValue = @{}
            if (-not [string]::IsNullOrEmpty($SettingValueType))
            {
                if ($SettingDefinition.AdditionalProperties.valueDefinition.isSecret)
                {
                    $SettingValueType = "#microsoft.graph.deviceManagementConfigurationSecretSettingValue"
                    $settingValue.Add('valueState', 'NotEncrypted')
                }
                $settingValue.Add('@odata.type', $SettingValueType)
            }
            if (-not [string]::IsNullOrEmpty($settingValueTemplateId))
            {
                $settingValue.Add('settingValueTemplateReference', @{'settingValueTemplateId' = $settingValueTemplateId })
            }
            $settingValue.Add('value', $value)

            $settingValuesToReturn.Add($SettingValueName, $settingValue)
            $settingValuesToReturn.Add('settingDefinitionId', $SettingDefinition.Id)
        }
    }
    return $settingValuesToReturn
}

function Get-IntuneSettingCatalogPolicySettingDSCValue
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $SettingName,

        [Parameter()]
        [System.String]
        $SettingValueType = "",

        [Parameter(Mandatory = $true)]
        [System.Array]
        $SettingTemplates,

        [Parameter()]
        $SettingDefinition,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $DSCParams
    )

    # Go over all the values that have not yet been processed
    foreach ($key in ($DSCParams.Keys | Where-Object { $_ -notin $global:excludedDscParams }))
    {
        $matchCombined = $false
        $matchesId = $false
        $matchesOffsetUri = $false
        $offsetUriFound = $false
        $settingDefinitions = $SettingTemplates.SettingDefinitions `
            | Where-Object -FilterScript { $_.Name -eq $key }

        # Edge case where the same setting is defined twice in the template, with the same name and id
        if ($settingDefinitions.Count -eq 2)
        {
            if ($settingDefinitions[0].Id -eq $settingDefinitions[1].Id -and `
                $settingDefinitions[0].Name -eq $settingDefinitions[1].Name)
            {
                $settingDefinitions = $settingDefinitions[0]
            }
        }
        $name = $settingDefinitions.Name

        if ($name.Count -ne 1)
        {
            # Key might have been combined with parent setting, try to split it
            if ($key -like "*_*")
            {
                $parentSettingName = $key.Split('_')[0]
                $parentDefinition = $SettingTemplates.SettingDefinitions | Where-Object -FilterScript { $_.Name -eq $parentSettingName }

                # If no parent definition is found, it might have been combined with the OffsetUri
                if ($null -eq $parentDefinition)
                {
                    $newKey = $key
                    switch -wildcard ($newKey)
                    {
                        '*_HTTPAuthentication_*' { $newKey = $newKey.Replace('HTTPAuthentication', '~HTTPAuthentication') }
                        '*TrustCenterTrustedLocations_*' { $newKey = $newKey.Replace('TrustCenterTrustedLocations', 'TrustCenter~L_TrustedLocations') }
                        '*TrustCenterFileBlockSettings_*' { $newKey = $newKey.Replace('TrustCenterFileBlockSettings', 'TrustCenter~L_FileBlockSettings') }
                        '*TrustCenterProtectedView_*' { $newKey = $newKey.Replace('TrustCenterProtectedView', 'TrustCenter~L_ProtectedView') }
                        '*_TrustCenter*' { $newKey = $newKey.Replace('_TrustCenter', '~L_TrustCenter') }
                        '*_Security_*' { $newKey = $newKey.Replace('Security', '~L_Security') }
                        'MicrosoftEdge_*' { $newKey = $newKey.Replace('MicrosoftEdge_', 'microsoft_edge~Policy~microsoft_edge') }
                        'MicrosoftPublisherV3_*' { $newKey = $newKey.Replace('MicrosoftPublisherV3_', 'pub16v3~Policy~L_MicrosoftOfficePublisher') }
                        'MicrosoftPublisherV2_*' { $newKey = $newKey.Replace('MicrosoftPublisherV2_', 'pub16v2~Policy~L_MicrosoftOfficePublisher') }
                        'MicrosoftVisio_*' { $newKey = $newKey.Replace('MicrosoftVisio_', 'visio16v2~Policy~L_MicrosoftVisio~L_VisioOptions') }
                        'MicrosoftProject_*' { $newKey = $newKey.Replace('MicrosoftProject_', 'proj16v2~Policy~L_Proj~L_ProjectOptions') }
                        'MicrosoftPowerPoint_*' { $newKey = $newKey.Replace('MicrosoftPowerPoint_', 'ppt16v2~Policy~L_MicrosoftOfficePowerPoint~L_PowerPointOptions') }
                        'MicrosoftWord_*' { $newKey = $newKey.Replace('MicrosoftWord_', 'word16v2~Policy~L_MicrosoftOfficeWord~L_WordOptions') }
                        'MicrosoftExcel_*' { $newKey = $newKey.Replace('MicrosoftExcel_', 'excel16v2~Policy~L_MicrosoftOfficeExcel~L_ExcelOptions') }
                        'MicrosoftAccess_*' { $newKey = $newKey.Replace('MicrosoftAccess_', 'access16v2~Policy~L_MicrosoftOfficeaccess~L_ApplicationSettings') }
                    }
                    $definition = Get-SettingDefinitionFromNameWithParentFromOffsetUri -OffsetUriName $newKey -SettingDefinitions $SettingTemplates.SettingDefinitions
                    if ($null -ne $definition)
                    {
                        $offsetUriFound = $true
                        if ($SettingDefinition.Id -eq $definition.Id)
                        {
                            $matchesOffsetUri = $true
                        }
                    }
                }
                $childDefinition = $SettingTemplates.SettingDefinitions | Where-Object -FilterScript {
                    $_.Name -eq $SettingName -and
                    (($_.AdditionalProperties.dependentOn.Count -gt 0 -and $_.AdditionalProperties.dependentOn.parentSettingId -contains $parentDefinition.Id) -or
                    ($_.AdditionalProperties.options.dependentOn.Count -gt 0 -and $_.AdditionalProperties.options.dependentOn.parentSettingId -contains $parentDefinition.Id)
                    )
                }
                if ($null -ne $parentDefinition -and $null -ne $childDefinition -and $childDefinition.Id -eq $SettingDefinition.Id)
                {
                    # Parent was combined with child setting. Since there can be multiple settings with the same Name, we need to check the Id as well
                    if ($SettingDefinition.Id -eq $childDefinition.Id)
                    {
                        # Only exclude the combined setting if it is not part of a group setting collection (which could be of a separate CIM type)
                        if ($parentDefinition.AdditionalProperties.'@odata.type' -ne '#microsoft.graph.deviceManagementConfigurationSettingGroupCollectionDefinition')
                        {
                            $global:excludedDscParams += $key
                        }
                        $matchCombined = $true
                    }
                }
            }

            if (-not $matchCombined -and -not $offsetUriFound)
            {
                # Parent was not combined, look for the combination of name and id
                $SettingTemplates.SettingDefinitions | ForEach-Object {
                    if ($_.Id -notin $global:excludedDefinitionIds -and $_.Name -eq $SettingName -and $_.Id -like "*$key")
                    {
                        $global:excludedDefinitionIds += $_.Id
                        $global:excludedDscParams += $key
                        $matchesId = $true
                        $SettingDefinition = $_
                    }
                }

                if (-not $matchesId)
                {
                    $definition = Get-SettingDefinitionFromNameWithParentFromOffsetUri -OffsetUriName $key -SettingDefinitions $SettingTemplates.SettingDefinitions
                    if ($null -ne $definition)
                    {
                        $offsetUriFound = $true
                        if ($SettingDefinition.Id -eq $definition.Id)
                        {
                            $matchesOffsetUri = $true
                        }
                    }
                }
            }
        }

        # If there is exactly one setting with the name, the setting is combined or the id matches, we get the DSC value and update the real setting value type
        if (($name.Count -eq 1 -and $SettingName -eq $key) -or $matchCombined -or $matchesId -or $matchesOffsetUri)
        {
            $isArray = $false
            if ($SettingValueType -like "*Simple*")
            {
                if ($DSCParams[$key] -is [System.String])
                {
                    $SettingValueType = "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                }
                elseif ($DSCParams[$key] -is [System.Int32])
                {
                    $SettingValueType = "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue"
                }
                elseif ($DSCParams[$key] -is [System.String[]])
                {
                    $SettingValueType = "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                    $isArray = $true
                }
                elseif ($DSCParams[$key] -is [System.Int32[]])
                {
                    $SettingValueType = "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue"
                    $isArray = $true
                }
            }

            if ($SettingValueType -like "*Simple*" -or $SettingValueType -in @("#microsoft.graph.deviceManagementConfigurationIntegerSettingValue", "#microsoft.graph.deviceManagementConfigurationStringSettingValue"))
            {
                return @{
                    SettingDefinition = $SettingDefinition
                    SettingValueType = $SettingValueType
                    Value = if ($isArray) { ,$DSCParams[$key] } else { $DSCParams[$key] }
                }
            }
            elseif ($SettingValueType -like "*ChoiceSettingCollection*")
            {
                $values = @()
                foreach ($value in $DSCParams[$key])
                {
                    $values += "$($SettingDefinition.Id)_$value"
                }

                return @{
                    Value = $values
                }
            }
            else
            {
                return @{
                    SettingDefinition = $SettingDefinition
                    SettingValueType = $SettingValueType
                    Value = "$($SettingDefinition.Id)_$($DSCParams[$key])"
                }
            }
            break
        }
    }
}

function Get-SettingDefinitionFromNameWithParentFromOffsetUri
{
    param(
        [Parameter(Mandatory = $true)]
        [System.String]
        $OffsetUriName,

        [Parameter(Mandatory = $true)]
        [System.Array]
        $SettingDefinitions
    )

    $offsetUriParts = [System.Collections.ArrayList]::new()
    $SettingDefinitions | ForEach-Object {
        $splittedOffsetUri = $_.OffsetUri.Split('/')
        # Remove first element since it is always empty
        $splittedOffsetUri = $splittedOffsetUri[1..($splittedOffsetUri.Length - 1)]
        foreach ($part in $splittedOffsetUri)
        {
            if (-not $offsetUriParts.Contains($part))
            {
                $offsetUriParts.Add($part) | Out-Null
            }
        }
    }

    $settingName = $OffsetUriName
    $offsetUriPrefix = ""
    for ($i = 0; $i -lt $offsetUriParts.Count; $i++)
    {
        $part = $offsetUriParts[$i]
        if ($settingName -like "$($part)_*")
        {
            $settingName = $settingName.Replace("$($part)_", "")
            # Add wildcards to match removed parts with invalid characters
            $offsetUriPrefix += "*$($part)*"
            $i = 0
        }
    }

    if ($settingName -eq "v2")
    {
        $settingName = $offsetUriPrefix.Split("*")[-2] + "_v2" # Add the last element of the offset Uri parts before the v2
        $filteredDefinitions = $SettingDefinitions | Where-Object -FilterScript {
            ($_.Id -like "*$settingName" -and $_.Name -eq $settingName.Replace('_v2', '') -and $_.OffsetUri -like "*$offsetUriPrefix*") -or
            ($_.Name -eq $settingName -and $_.OffsetUri -like "*$offsetUriPrefix*")
        }
    }
    else
    {
        $filteredDefinitions = $SettingDefinitions | Where-Object -FilterScript {
            $_.Name -eq $settingName -and $_.OffsetUri -like "*$offsetUriPrefix*"
        }
    }

    if ($filteredDefinitions.Count -eq 1)
    {
        return $filteredDefinitions
    }
    else
    {
        $settingsWithSameName = $filteredDefinitions
        foreach ($definition in $filteredDefinitions)
        {
            $parentSetting = Get-ParentSettingDefinition -SettingDefinition $definition -AllSettingDefinitions $SettingDefinitions
            $skip = 0
            $breakCounter = 0
            $newSettingName = $settingName
            do {
                $previousSettingName = $newSettingName
                $newSettingName = Get-SettingDefinitionNameWithParentFromOffsetUri -OffsetUri $definition.OffsetUri -SettingName $newSettingName -Skip $skip

                $combinationMatchesWithOffsetUri = @()
                $settingsWithSameName | ForEach-Object {
                    $newName = Get-SettingDefinitionNameWithParentFromOffsetUri -OffsetUri $_.OffsetUri -SettingName $previousSettingName -Skip $skip
                    if ($newName -eq $newSettingName)
                    {
                        # Exclude v2 versions from the comparison
                        if ($definition.Id -like "*_v2" -and $_.Id -ne $definition.Id.Replace('_v2', '') -or
                            $definition.Id -notlike "*_v2" -and $_.Id -ne $definition.Id + "_v2")
                        {
                            $combinationMatchesWithOffsetUri += $_
                        }
                    }
                }
                $settingsWithSameName = $combinationMatchesWithOffsetUri
                $breakCounter++
                $skip++
            } while ($combinationMatchesWithOffsetUri.Count -gt 1 -and $breakCounter -lt 8)

            if ($breakCounter -eq 8)
            {
                if ($null -ne $parentSetting)
                {
                    # Alternative way if no unique setting name can be found
                    $parentSettingIdProperty = $parentSetting.Id.Split('_')[-1]
                    $parentSettingIdWithoutProperty = $parentSetting.Id.Replace("_$parentSettingIdProperty", "")
                    # We can't use the entire setting here, because the child setting id does not have to come after the parent setting id
                    $settingNameV2 = $definition.Id.Replace($parentSettingIdWithoutProperty + "_", "").Replace($parentSettingIdProperty + "_", "")
                    if ($settingNameV2 -eq $OffsetUriName)
                    {
                        $newSettingName = $settingNameV2
                    }
                }
            }

            if ($newSettingName -eq $OffsetUriName)
            {
                return $definition
            }
        }
    }
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

<#
    This function also exists in M365DSCResourceGenerator.psm1. Changes here must be added there as well for compatibility.
#>
function Get-SettingDefinitionNameWithParentFromOffsetUri {
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

function Export-IntuneSettingCatalogPolicySettings
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'Start'
        )]
        $Settings,

        [Parameter(
            Mandatory = $true
        )]
        [System.Collections.Hashtable]$ReturnHashtable,

        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'Setting'
        )]
        $SettingInstance,

        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'Setting'
        )]
        $SettingDefinitions,

        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'Setting'
        )]
        [System.Array]
        $AllSettingDefinitions,

        [Parameter(
            ParameterSetName = 'Setting'
        )]
        [switch]$IsRoot,

        [Parameter(
            ParameterSetName = 'Start'
        )]
        [switch]$ContainsDeviceAndUserSettings
    )

    if ($PSCmdlet.ParameterSetName -eq 'Start')
    {
        if ($ContainsDeviceAndUserSettings)
        {
            $deviceSettingsReturnHashtable = @{}
            $deviceSettings = $Settings | Where-Object -FilterScript {
                $_.SettingInstance.settingDefinitionId.StartsWith("device_")
            }
            foreach ($setting in $deviceSettings)
            {
                Export-IntuneSettingCatalogPolicySettings -SettingInstance $setting.SettingInstance -SettingDefinitions $setting.SettingDefinitions -ReturnHashtable $deviceSettingsReturnHashtable -AllSettingDefinitions $deviceSettings.SettingDefinitions -IsRoot
            }

            $userSettings = $Settings | Where-Object -FilterScript {
                $_.SettingInstance.settingDefinitionId.StartsWith("user_")
            }
            $userSettingsReturnHashtable = @{}
            foreach ($setting in $userSettings)
            {
                Export-IntuneSettingCatalogPolicySettings -SettingInstance $setting.SettingInstance -SettingDefinitions $setting.SettingDefinitions -ReturnHashtable $userSettingsReturnHashtable -AllSettingDefinitions $userSettings.SettingDefinitions -IsRoot
            }

            if ($deviceSettingsReturnHashtable.Keys.Count -gt 0)
            {
                $ReturnHashtable.Add('DeviceSettings', $deviceSettingsReturnHashtable)
            }
            if ($userSettingsReturnHashtable.Keys.Count -gt 0)
            {
                $ReturnHashtable.Add('UserSettings', $userSettingsReturnHashtable)
            }
        }
        else
        {
            foreach ($setting in $Settings)
            {
                Export-IntuneSettingCatalogPolicySettings -SettingInstance $setting.SettingInstance -SettingDefinitions $setting.SettingDefinitions -ReturnHashtable $ReturnHashtable -AllSettingDefinitions $Settings.SettingDefinitions -IsRoot
            }
        }
        return $ReturnHashtable
    }

    $addToParameters = $true
    $settingDefinition = $SettingDefinitions | Where-Object -FilterScript { $_.Id -eq $SettingInstance.settingDefinitionId }
    $settingName = $settingDefinition.Name

    # Check if the name is unique
    $settingsWithSameName = @($AllSettingDefinitions | Where-Object -FilterScript { $_.Name -eq $settingName })
    if ($settingsWithSameName.Count -gt 1)
    {
        $parentSetting = Get-ParentSettingDefinition -SettingDefinition $settingDefinition -AllSettingDefinitions $AllSettingDefinitions

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
                $settingName = $($parentSetting.Name) + "_" + $settingName
            }
            # If the combination of parent setting and setting name is still not unique, do it with the OffsetUri of the current setting
            else
            {
                $skip = 0
                $breakCounter = 0
                $newSettingName = $settingName
                do {
                    $previousSettingName = $newSettingName
                    $newSettingName = Get-SettingDefinitionNameWithParentFromOffsetUri -OffsetUri $settingDefinition.OffsetUri -SettingName $newSettingName -Skip $skip

                    $combinationMatchesWithOffsetUri = @()
                    $settingsWithSameName | ForEach-Object {
                        $newName = Get-SettingDefinitionNameWithParentFromOffsetUri -OffsetUri $_.OffsetUri -SettingName $previousSettingName -Skip $skip
                        if ($newName -eq $newSettingName)
                        {
                            # Exclude v2 versions from the comparison
                            if ($settingDefinition.Id -like "*_v2" -and $_.Id -ne $settingDefinition.Id.Replace('_v2', '') -or
                                $settingDefinition.Id -notlike "*_v2" -and $_.Id -ne $settingDefinition.Id + "_v2")
                            {
                                $combinationMatchesWithOffsetUri += $_
                            }
                        }
                    }
                    $settingsWithSameName = $combinationMatchesWithOffsetUri
                    $skip++
                    $breakCounter++
                } while ($combinationMatchesWithOffsetUri.Count -gt 1 -and $breakCounter -lt 8)

                if ($breakCounter -lt 8)
                {
                    if ($settingDefinition.Id -like "*_v2" -and $newSettingName -notlike "*_v2")
                    {
                        $newSettingName += "_v2"
                    }
                    $settingName = $newSettingName
                }
                else
                {
                    # Alternative way if no unique setting name can be found
                    $parentSettingIdProperty = $parentSetting.Id.Split('_')[-1]
                    $parentSettingIdWithoutProperty = $parentSetting.Id.Replace("_$parentSettingIdProperty", "")
                    # We can't use the entire setting here, because the child setting id does not have to come after the parent setting id
                    $settingName = $settingDefinition.Id.Replace($parentSettingIdWithoutProperty + "_", "").Replace($parentSettingIdProperty + "_", "")
                }
            }
        }

        # When there is no parent, we can't use the parent setting name to make the setting name unique
        # Instead, we traverse up the OffsetUri. Since no parent setting can only happen at the root level, the result
        # of Get-SettingDefinitionNameWithParentFromOffsetUri is absolute and cannot change. There cannot be multiple settings with the same name
        # in the same level of OffsetUri
        if ($null -eq $parentSetting)
        {
            $settingName = Get-SettingDefinitionNameWithParentFromOffsetUri -OffsetUri $settingDefinition.OffsetUri -SettingName $settingName
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

    $odataType = if ($IsRoot) { $SettingInstance.AdditionalProperties.'@odata.type' } else { $SettingInstance.'@odata.type' }
    switch ($odataType)
    {
        '#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance'
        {
            $settingValue = if ($IsRoot) { $SettingInstance.AdditionalProperties.simpleSettingValue.value } else { $SettingInstance.simpleSettingValue.value }
        }
        '#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance'
        {
            $settingValue = if ($IsRoot) { $SettingInstance.AdditionalProperties.choiceSettingValue.value } else { $SettingInstance.choiceSettingValue.value }
            $settingValue = $settingValue.Split('_') | Select-Object -Last 1
            $childSettings = if ($IsRoot) { $SettingInstance.AdditionalProperties.choiceSettingValue.children } else { $SettingInstance.choiceSettingValue.children }
            foreach ($childSetting in $childSettings)
            {
                Export-IntuneSettingCatalogPolicySettings -SettingInstance $childSetting -SettingDefinitions $SettingDefinitions -ReturnHashtable $ReturnHashtable -AllSettingDefinitions $AllSettingDefinitions
            }
        }
        '#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance'
        {
            $values = @()
            $childValues = if ($IsRoot) { $SettingInstance.AdditionalProperties.choiceSettingCollectionValue.value } else { $SettingInstance.choiceSettingCollectionValue.value }
            foreach ($value in $childValues)
            {
                $values += $value.Split('_') | Select-Object -Last 1
            }
            $settingValue = $values
        }
        '#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance'
        {
            $groupSettingCollectionValue = if ($IsRoot) { $SettingInstance.AdditionalProperties.groupSettingCollectionValue } else { $SettingInstance.groupSettingCollectionValue }
            $childSettingDefinitions = $SettingDefinitions | Where-Object -FilterScript {
                $settingDefinition.AdditionalProperties.childIds -contains $_.Id
            }

            if ($settingDefinition.AdditionalProperties.maximumCount -gt 1 -and $childSettingDefinitions.Count -eq 1)
            {
                # Skip GroupSettingCollection with only one child, go straight to the child property
                foreach ($child in $groupSettingCollectionValue)
                {
                    $childInstances = $child.children
                    foreach ($childInstance in $childInstances)
                    {
                        Export-IntuneSettingCatalogPolicySettings -SettingInstance $childInstance -SettingDefinitions $SettingDefinitions -ReturnHashtable $ReturnHashtable -AllSettingDefinitions $AllSettingDefinitions
                    }
                }
                $addToParameters = $false
            }
            elseif (-not $IsRoot -and $childSettingDefinitions.Count -gt 1)
            {
                $childValue = $null
                $parentSettingDefinition = $SettingDefinitions | Where-Object -FilterScript { $_.Id -eq $settingDefinition.AdditionalProperties.dependentOn.parentSettingId }
                if ($settingDefinition.AdditionalProperties.maximumCount -gt 1 -or
                    $parentSettingDefinition.AdditionalProperties.maximumCount -gt 1)
                {
                    $childValue = @()
                }
                foreach ($child in $groupSettingCollectionValue)
                {
                    $childHashtable = @{}
                    foreach ($childInstance in $child.children)
                    {
                        Export-IntuneSettingCatalogPolicySettings -SettingInstance $childInstance -SettingDefinitions $SettingDefinitions -ReturnHashtable $childHashtable -AllSettingDefinitions $AllSettingDefinitions
                    }
                    $childValue += $childHashtable
                }
                $settingValue = if ($null -eq $childValue) { $childHashtable } else { ,$childValue }
            }
            else
            {
                $childSettings = $groupSettingCollectionValue.children
                foreach ($value in $childSettings)
                {
                    Export-IntuneSettingCatalogPolicySettings -SettingInstance $value -SettingDefinitions $SettingDefinitions -ReturnHashtable $ReturnHashtable -AllSettingDefinitions $AllSettingDefinitions
                    $addToParameters = $false
                }
            }
        }
        '#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance'
        {
            $values = @()
            $childValues = if ($IsRoot) { $SettingInstance.AdditionalProperties.simpleSettingCollectionValue.value } else { $SettingInstance.simpleSettingCollectionValue.value }
            foreach ($value in $childValues)
            {
                $values += $value
            }
            $settingValue = $values
        }
        Default
        {
            $settingValue = $SettingInstance.value
        }
    }

    if ($addToParameters)
    {
        if (-not $ReturnHashtable.ContainsKey($settingName))
        {
            $ReturnHashtable.Add($settingName, $settingValue)
        }
        else
        {
            # Only happens when it's a GroupCollection(Collection) with multiple entries
            $ReturnHashtable[$settingName] = @($ReturnHashtable[$settingName]) + $settingValue
        }
    }
}

function Update-IntuneDeviceConfigurationPolicy
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = 'true')]
        [System.String]
        $DeviceConfigurationPolicyId,

        [Parameter()]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $Platforms,

        [Parameter()]
        [System.String]
        $Technologies,

        [Parameter()]
        [System.String]
        $TemplateReferenceId,

        [Parameter()]
        [Array]
        $Settings
    )

    try
    {
        $Uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies/$DeviceConfigurationPolicyId"

        $policy = @{
            'name'              = $Name
            'description'       = $Description
            'platforms'         = $Platforms
            'templateReference' = @{'templateId' = $TemplateReferenceId }
            'technologies'      = $Technologies
            'settings'          = $Settings
        }
        $body = $policy | ConvertTo-Json -Depth 20
        #Write-Verbose -Message $body
        Invoke-MgGraphRequest -Method PUT -Uri $Uri -Body $body -ErrorAction Stop
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error updating data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        throw
    }
}

function Get-ComplexFunctionsFromFilterQuery {
    [CmdletBinding()]
    [OutputType([System.Array])]
    param (
        [string]$FilterQuery
    )

    $complexFunctionsRegex = "startswith\((.*?),\s*'(.*?)'\)|endswith\((.*?),\s*'(.*?)'\)|contains\((.*?),\s*'(.*?)'\)"
    [array]$complexFunctions = [regex]::Matches($FilterQuery, $complexFunctionsRegex) | ForEach-Object {
        $_.Value
    }

    return $complexFunctions
}

function Remove-ComplexFunctionsFromFilterQuery {
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        [string]$FilterQuery
    )

    $complexFunctionsRegex = "startswith\((.*?),\s*'(.*?)'\)|endswith\((.*?),\s*'(.*?)'\)|contains\((.*?),\s*'(.*?)'\)"
    $basicFilterQuery = [regex]::Replace($FilterQuery, $complexFunctionsRegex, "").Trim()
    $basicFilterQuery = $basicFilterQuery -replace "^and\s","" -replace "\sand$","" -replace "\sand\s+", " and " -replace "\sor\s+", " or "

    return $basicFilterQuery
}

function Find-GraphDataUsingComplexFunctions {
    [CmdletBinding()]
    [OutputType([System.Array])]
    param (
        [array]$Policies,
        [array]$ComplexFunctions
    )

    foreach ($function in $ComplexFunctions) {
        if ($function -match "startswith\((.*?),\s*'(.*?)'") {
            $property = $matches[1]
            $value = $matches[2]
            $Policies = $Policies | Where-Object { $_.$property -like "$value*" }
        } elseif ($function -match "endswith\((.*?),\s*'(.*?)'") {
            $property = $matches[1]
            $value = $matches[2]
            $Policies = $Policies | Where-Object { $_.$property -like "*$value" }
        } elseif ($function -match "contains\((.*?),\s*'(.*?)'") {
            $property = $matches[1]
            $value = $matches[2]
            $Policies = $Policies | Where-Object { $_.$property -like "*$value*" }
        }
    }

    return $Policies
}
