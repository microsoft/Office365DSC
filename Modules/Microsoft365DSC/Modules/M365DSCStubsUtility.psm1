<#
.Description
This function creates new stub files for all used M365 module dependencies

.Functionality
Internal
#>
function New-M365DSCStubFiles
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DestinationFilePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Collections.Hashtable[]]
        $Workloads,

        [Parameter()]
        [String[]]
        $CmdletsList
    )

    if ($null -eq $Credential)
    {
        $Credential = Get-Credential
        $PSBoundParameters.Add('Credential', $Credential)
    }

    if (Test-Path $DestinationFilePath)
    {
        $answer = $null
        do
        {
            $answer = Read-Host 'A file already exists at the specified location. Remove it? (y/n)'
        } while ($answer -ne 'y' -and $answer -ne 'n')

        if ($answer -eq 'y')
        {
            Remove-Item -Path $DestinationFilePath -Confirm:$false
        }
    }

    $Content = [System.Text.StringBuilder]::New()
    $folderPath = Join-Path $PSScriptRoot -ChildPath '../DSCResources'
    Write-Host $FolderPath
    if ($null -eq $Workloads)
    {
        $workloads = @(
            @{Name = 'ExchangeOnline'; ModuleName = 'ExchangeOnlineManagement';}, # This is the main EXO module with new cmdlets.
            @{Name = 'ExchangeOnline'; ModuleName = 'ExchangeOnlineManagement'; CommandName = 'Get-Mailbox' }, # This is the EXO Proxy
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Applications'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Authentication'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Applications'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.DeviceManagement'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Devices.CorporateManagement'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.DeviceManagement.Administration'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.DeviceManagement.Enrollment'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Identity.DirectoryManagement'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Identity.Governance'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Identity.SignIns'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Search'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Beta.Teams'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.DeviceManagement.Administration'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.DirectoryObjects'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Groups'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Identity.DirectoryManagement'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Planner'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Users'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Users.Actions'},
            @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.DirectoryObjects';},
            @{Name = 'SecurityComplianceCenter'; ModuleName = 'ExchangeOnlineManagement'; CommandName = 'Get-Label' },
            @{Name = 'PnP'; ModuleName = 'PnP.PowerShell'; },
            @{Name = 'PowerPlatforms'; ModuleName = 'Microsoft.PowerApps.Administration.PowerShell'; },
            @{Name = 'MicrosoftTeams'; ModuleName = 'MicrosoftTeams'; }
        )
    }
    if ($null -ne $CmdletsList -and $CmdletsList.Length -gt 0)
    {
        $workloads = @{Name = 'MicrosoftGraph'; ModuleName = 'Microsoft.Graph.Authentication'}
    }

    foreach ($Module in $workloads)
    {
        if ($null -eq $CmdletsList -or $CmdletsList.Length -eq 0)
        {
            Write-Host "Connecting to {$($Module.Name)}"
            $ConnectionMode = New-M365DSCConnection -Workload ($Module.Name) `
                -InboundParameters $PSBoundParameters

            Write-Host "Generating Stubs for {$($Module.ModuleName)}..."
            $CurrentModuleName = $Module.ModuleName

            if ($null -eq $CurrentModuleName -or $Module.CommandName)
            {
                Write-Host "Loading proxy for $($Module.ModuleName)"
                $foundModule = Get-Module | Where-Object -FilterScript { $_.ExportedCommands.Values.Name -ccontains $Module.CommandName }
                $CurrentModuleName = $foundModule.Name
                Import-Module $CurrentModuleName -Force -Global -ErrorAction SilentlyContinue
            }
            else
            {
                Import-Module $CurrentModuleName -Force -Global -ErrorAction SilentlyContinue
                $ConnectionMode = New-M365DSCConnection -Workload $Module.Name `
                    -InboundParameters $PSBoundParameters
            }

            $cmdlets = Get-Command -CommandType 'Cmdlet' | Where-Object -FilterScript { $_.Source -eq $CurrentModuleName }
            if ($null -eq $cmdlets -or $Module.ModuleName -eq 'MicrosoftTeams')
            {
                $cmdlets += Get-Command -CommandType 'Function' -Module $CurrentModuleName
            }

            try
            {
                $aliases = Get-Command -CommandType 'Alias' | Where-Object -FilterScript { $_.Source -eq $CurrentModuleName }
                $cmdlets += $aliases
                $cmdlets = $cmdlets | Select-Object -Unique
            }
            catch
            {
                Write-Verbose -Message $_
            }
        }
        else
        {
            $cmdlets = @()
            foreach ($entry in $CmdletsList)
            {
                $command = Get-Command $entry -ErrorAction SilentlyContinue
                if ($null -ne $command)
                {
                    $CurrentModuleName = $command.ModuleName
                    $cmdlets += $command
                }
            }
        }

        $StubContent = [System.Text.StringBuilder]::New()
        $i = 1
        foreach ($cmdlet in $cmdlets)
        {
            Write-Progress -Activity 'Generating Stubs' -Status $cmdlet.Name -PercentComplete (($i / $cmdlets.Length) * 100)
            $foundInFiles = Get-ChildItem -Path $folderPath `
                -Recurse | Select-String -Pattern $cmdlet.Name

            if ($null -eq $foundInFiles)
            {
                Write-Verbose -Message "No references found for $($cmdlet.Name)"
            }
            else
            {
                Write-Host $cmdlet

                try
                {
                    $metadata = New-Object -TypeName System.Management.Automation.CommandMetaData -ArgumentList $cmdlet
                    $parameters = $metadata.Parameters
                }
                catch
                {
                    Write-Verbose -Message $_
                }

                $invalidParameters = @('ErrorVariable', `
                        'ErrorAction', `
                        'InformationVariable', `
                        'InformationAction', `
                        'WarningVariable', `
                        'WarningAction', `
                        'OutVariable', `
                        'OutBuffer', `
                        'PipelineVariable', `
                        'Verbose', `
                        'WhatIf', `
                        'Debug')

                $additionalParameters = (Get-Command $cmdlet.Name).Parameters

                foreach ($additionalParam in $additionalParameters.Keys)
                {
                    if ($null -eq $parameters -or
                        (-not $parameters.ContainsKey($additionalParam) -and `
                            -not $invalidParameters.Contains($additionalParameter)))
                    {
                        $parameters += @{$additionalParam = $additionalParameters.$additionalParam }
                    }
                }
                $StubContent.Append("function $($cmdlet.Name)`n{`r`n    [CmdletBinding()]`r`n    param(`r`n") | Out-Null
                $invalidTypes = @('ActionPreference')

                $foundParamNames = @()

                # If the cmdlet has a property names
                if ($parameters.ContainsKey('Values'))
                {
                    $parameters.Remove('Values') | Out-Null
                    $foundParamNames += 'Values'
                    $StubContent.Append("        [Parameter()]`r`n") | Out-Null
                    $StubContent.Append("        [System.String[]]`r`n") | Out-Null
                    $StubContent.Append("        `$Values,`r`n`r`n") | Out-Null
                }
                foreach ($param in $parameters.Values)
                {
                    Write-Verbose -Message "    --> $($param.Name)"
                    if ($foundParamNames -notcontains $param.Name)
                    {
                        $foundParamNames += $param.Name
                        if ($param.ParameterType.Name -notin $invalidTypes -and `
                                $param.Name -notin $invalidParameters -and `
                                -not [System.String]::IsNullOrEmpty($param.Name))
                        {
                            $StubContent.Append("        [Parameter()]`r`n") | Out-Null
                            $ParamType = $param.ParameterType.ToString()
                            if ($ParamType -eq "System.Collections.Generic.List``1[System.String]")
                            {
                                $ParamType = 'System.String[]'
                            }
                            elseif ($ParamType -eq 'System.Nullable`1[System.Boolean]')
                            {
                                $ParamType = 'System.Boolean'
                            }
                            elseif ($ParamType.StartsWith("System.Collections.Generic.List``1[Microsoft."))
                            {
                                $ParamType = 'System.Object[]'
                            }
                            elseif ($ParamType.StartsWith('Microsoft.Graph.PowerShell.') -or `
                                    $ParamType.StartsWith('Microsoft.Graph.Beta.PowerShell.'))
                            {
                                $ParamType = 'PSObject'
                            }
                            elseif ($ParamType.StartsWith('Microsoft.Rtc.'))
                            {
                                $ParamType = 'PSObject'
                            }
                            elseif ($ParamType.StartsWith('Microsoft.') -or `
                                    $ParamType.StartsWith('PnP.') -or `
                                    $ParamType.StartsWith("System.Nullable``1[Microsoft.") -or `
                                    $ParamType.StartsWith("System.Nullable``1[PnP.") -or `
                                    $ParamType.StartsWith("System.Management.Automation.PSListModifier``1[Microsoft."))
                            {
                                $ParamType = 'PSObject'
                            }
                            $StubContent.Append("        [$ParamType]`r`n") | Out-Null
                            $StubContent.Append("        `$$($param.Name),`r`n`r`n") | Out-Null
                        }
                    }
                }
                if ($parameters.Values.Count -gt 0)
                {
                    $endOfString = $StubContent.ToString().SubString($StubContent.ToString().Length - 5, 5)
                    if ($endOfString -eq ",`r`n`r`n")
                    {
                        $StubContent = $StubContent.ToString().Remove($StubContent.Length - 5, 5)
                    }
                }
                $StubContent = [System.Text.StringBuilder]::New($StubContent.ToString())
                $StubContent.Append("`r`n    )`r`n}`n") | Out-Null
            }
            $i ++
        }
        Write-Progress -Activity 'Generating Stubs' -Completed

        $Content.Append("#region $($Module.ModuleName)`r`n") | Out-Null

        $TypesToConvert = @('Microsoft.Online.SharePoint.PowerShell.SpoHubSitePipeBind', `
                'Microsoft.Online.SharePoint.PowerShell.SpoSitePipeBind'
        )

        foreach ($type in $TypesToConvert)
        {
            $StubContent = $StubContent.Replace($type, 'Object')
        }
        $Content.Append($StubContent) | Out-Null
        $Content.Append("#endregion`r`n") | Out-Null
        $i++
        Remove-Module $CurrentModuleName -ErrorAction SilentlyContinue
    }
    $Content.ToString() | Out-File $DestinationFilePath -Encoding utf8
}

Export-ModuleMember -Function @(
    'New-M365DSCStubFiles'
)
