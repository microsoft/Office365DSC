function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter(Mandatory=$true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $IsPerDeviceAcceptanceRequired,

        [Parameter()]
        [System.Boolean]
        $IsViewingBeforeAcceptanceRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TermsExpiration,

        [Parameter()]
        [system.timespan]
        $UserReacceptRequiredFrequency,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Acceptances,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $File,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Files,
        #endregion

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'v1.0'
        $context=Get-MgContext
        if($null -eq $context)
        {
            $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                -InboundParameters $PSBoundParameters -ProfileName 'beta'
        }
        Select-MgProfile 'v1.0' -ErrorAction Stop
    }
    catch
    {
        Write-Verbose -Message "Reloading1"
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $nullResult = $PSBoundParameters
    $nullResult.Ensure = 'Absent'
    try
    {
        $getValue=$null

        #region resource generator code
        if(-Not [string]::IsNullOrEmpty($DisplayName))
        {
            $getValue = Get-MgAgreement `
                -ErrorAction Stop | Where-Object `
                -FilterScript { `
                    $_.DisplayName -eq "$($DisplayName)" `
                }
        }

        if (-not $getValue)
        {
            $getValue = Get-MgAgreement `
                -ErrorAction Stop | Where-Object `
            -FilterScript { `
                $_.id -eq $id `
            }
        }
        #endregion

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Nothing with id {$id} was found"
            return $nullResult
        }

        Write-Verbose -Message "Found something with id {$id}"
        $results = @{
            #region resource generator code
            Id                                = $getValue.Id
            DisplayName                       = $getValue.DisplayName
            IsPerDeviceAcceptanceRequired     = $getValue.IsPerDeviceAcceptanceRequired
            IsViewingBeforeAcceptanceRequired = $getValue.IsViewingBeforeAcceptanceRequired
            UserReacceptRequiredFrequency     = $getValue.UserReacceptRequiredFrequency
            Ensure                            = 'Present'
            Credential                        = $Credential
            ApplicationId                     = $ApplicationId
            TenantId                          = $TenantId
            ApplicationSecret                 = $ApplicationSecret
            CertificateThumbprint             = $CertificateThumbprint
        }

        #Require call to addtional methods
        if ($getValue.TermsExpiration)
        {
            $results.Add("TermsExpiration", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.TermsExpiration))
        }

        #Removing Acceptances because it is Read-Only
        <#$currentAcceptances= Get-MgAgreementAcceptance -AgreementId $getValue.Id -all -ErrorAction SilentlyContinue
        if($currentAcceptances)
        {
            $getValue.Acceptances=$currentAcceptances
            $results.Add("Acceptances", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.Acceptances))
        }#>

        $currentFile= get-MgAgreementFile -AgreementId $getValue.Id -ErrorAction SilentlyContinue
        if($currentFile)
        {
            $getValue.File=$currentFile
            $results.Add("File", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.File))
            #$results.File.filedata=@{'data'=(get-MgAgreementFileData -AgreementId $getValue.Id -FileId $currentFile.Id)}
        }

        $currentFiles= Get-MgAgreementFileLocalization -AgreementId $getValue.Id -ErrorAction SilentlyContinue
        if($currentFiles)
        {
            $getValue.Files=$currentFiles
            $results.Add("Files", (Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $getValue.Files))

            $curFiles = [array]$results.Files
            foreach($myFile in $curFiles)
            {
                $myFile.remove('fileData')|out-null
                $myFile.CreatedDateTime = $myFile.CreatedDateTime.tostring("MM/dd/yyyy HH:mm:ss")
                [Array]$myFileVersions= Get-MgAgreementFileLocalizationVersion -AgreementId $getValue.Id -AgreementFileLocalizationId $myfile.Id
                $versionsAsHash = @()

                foreach($version in $myFileVersions)
                {
                    $versionAsHash=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $version
                    #$versionAsHash.fileData=@{'data'=(get-MgAgreementFileData -AgreementId $getValue.Id -FileId $version.Id)}
                    $versionAsHash.fileData=@{'data'=""}
                    $versionsAsHash+=$versionAsHash
                }
                [Array]$myfile.Versions=$versionsAsHash
            }
        }
        return [System.Collections.Hashtable] $results
    }
    catch
    {
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return $nullResult
    }
}
function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        #region resource generator code
        [Parameter(Mandatory=$true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $IsPerDeviceAcceptanceRequired,

        [Parameter()]
        [System.Boolean]
        $IsViewingBeforeAcceptanceRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TermsExpiration,

        [Parameter()]
        [system.timespan]
        $UserReacceptRequiredFrequency,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Acceptances,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $File,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Files,
        #endregion

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters `
            -ProfileName 'v1.0'
        $context=Get-MgContext
        if($null -eq $context)
        {
            $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
                -InboundParameters $PSBoundParameters -ProfileName 'beta'
        }
        Select-MgProfile 'v1.0' -ErrorAction Stop
    }
    catch
    {
        Write-Verbose -Message $_
    }

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentInstance = Get-TargetResource @PSBoundParameters

    $PSBoundParameters.Remove('Ensure') | Out-Null
    $PSBoundParameters.Remove('Credential') | Out-Null
    $PSBoundParameters.Remove('ApplicationId') | Out-Null
    $PSBoundParameters.Remove('ApplicationSecret') | Out-Null
    $PSBoundParameters.Remove('TenantId') | Out-Null
    $PSBoundParameters.Remove('CertificateThumbprint') | Out-Null

    #The following parameters cannot be updated or configured: https://docs.microsoft.com/en-us/graph/api/agreement-update?view=graph-rest-1.0&tabs=http
    $PSBoundParameters.Remove("Acceptances") | Out-Null
    $PSBoundParameters.Remove("File") | Out-Null
    $PSBoundParameters.Remove("TermsExpiration") | Out-Null
    $PSBoundParameters.Remove("IsPerDeviceAcceptanceRequired") | Out-Null
    $PSBoundParameters.Remove("UserReacceptRequiredFrequency") | Out-Null

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating {$DisplayName}"

        $CreateParameters = ([Hashtable]$PSBoundParameters).clone()
        $CreateParameters.Remove("Id") | Out-Null
        $CreateParameters.Remove("Verbose") | Out-Null

        #Formatting Files for creation
        $CreateParameters['Files'] = @()
        foreach($myFile in $Files)
        {
            $hashFile = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $myFile
            $hashFile.Remove('Id') | Out-Null
            $hashFile.Remove('Versions') | Out-Null
            $hashFile.Remove('CreatedDateTime') | Out-Null

            if($myFile.Versions.count -gt 0)
            {
                $myData = $myFile.Versions | Where-Object -FilterScript {$_.id -eq $myFile.id}
                $hashFile.add('fileData', @{'data'= $myData.FileData.Content})
            }

            if(-not ([String]::IsNullOrEmpty($hashFile.fileData.Content)))
            {
                $CreateParameters['Files'] += $hashFile
            }
        }

        if($CreateParameters['Files'].count -eq 0)
        {
            $CreateParameters.Remove("Files") | Out-Null
        }

        $(Convert-M365DscHashtableToString -Hashtable $CreateParameters) | Out-File C:\DSC\nik.txt
        #region resource generator code
        New-MgAgreement @CreateParameters
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating {$DisplayName}"
        $UpdateParameters = ([Hashtable]$PSBoundParameters).clone()
        $UpdateParameters.Remove("Id") | Out-Null
        $UpdateParameters.Remove("Verbose") | Out-Null
        $UpdateParameters.Remove("Files") | Out-Null

        #region resource generator code
        Update-MgAgreement @UpdateParameters `
            -AgreementId $currentInstance.Id
        #endregion

        if($Files)
        {
            $currentLocalizations = Get-MgAgreementFileLocalization -AgreementId $currentInstance.Id
            foreach ($myFile in $Files)
            {
                $needUpload=$false
                $currentLocalization=$currentLocalizations|Where-Object -FilterScript {$_.id -eq $myfile.id}
                if($null -eq $currentLocalization)
                {
                    $needUpload=$true
                }

                if ($currentLocalization.language -ne $myFile.language)
                {
                    $needUpload=$true
                }

                $myFileData = ($myFile.Versions | Where-Object -FilterScript {$_.id -eq $myFile.id}).FileData.Content
                if(-not $needUpload)
                {
                    $currentFileData = Get-MgAgreementFileData -AgreementId $Id -FileId $myFile.id
                    if($myFileData -ne $currentFileData)
                    {
                        $needUpload=$true
                    }
                }

                if($null -ne $myFileData -and $needUpload)
                {
                    $uploadFileParameters = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $myFile
                    $uploadFileParameters.Remove('PsComputerName') | Out-Null
                    $uploadFileParameters.Remove('CreatedDateTime') | Out-Null
                    $uploadFileParameters.Remove('Id') | Out-Null
                    $uploadFileParameters.Remove('Versions')
                    $uploadFileParameters.Add('fileData',@{'data'=$myFileData})

                    #write-verbose -message ($body|out-string)
                    $URI="https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements/$($currentInstance.Id)/file/localizations"
                    $body=$uploadFileParameters.clone()
                    foreach($key in $uploadFileParameters.keys)
                    {
                        $newkey = $key.Substring(0,1).ToLower() + $key.substring(1,$key.length - 1)
                        $value = $body[$key]
                        $body.Remove($key) | Out-Null
                        $body.Add($newkey,$value)
                    }
                    $body = $body | convertTo-Json -depth 20
                    Invoke-MgGraphRequest -Method POST -Uri $URI -Body $body
                }
            }
        }
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing {$DisplayName}"

        #region resource generator code
        Remove-MgAgreement -AgreementId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter(Mandatory=$true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.Boolean]
        $IsPerDeviceAcceptanceRequired,

        [Parameter()]
        [System.Boolean]
        $IsViewingBeforeAcceptanceRequired,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $TermsExpiration,

        [Parameter()]
        [system.timespan]
        $UserReacceptRequiredFrequency,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Acceptances,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $File,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Files,
        #endregion

        [Parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of {$id}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if($CurrentValues.Ensure -eq "Absent")
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult=$true

    #Removing Read-Only and non populated parameters
    $PSBoundParameters.Remove("Acceptances") | Out-Null
    $PSBoundParameters.Remove("File") | Out-Null
    $PSBoundParameters.Remove("TermsExpiration") | Out-Null
    $PSBoundParameters.Remove("IsPerDeviceAcceptanceRequired") | Out-Null
    $PSBoundParameters.Remove("UserReacceptRequiredFrequency") | Out-Null

    $currentLocalizations=$CurrentValues.Files
    foreach($myFile in $Files)
    {
        $currentLocalization=$currentLocalizations | Where-Object -FilterScript {$_.id -eq $myfile.id}
        if($null -eq $currentLocalization)
        {
            Write-Verbose -Message "The file $($myfile.Id) was not found in the current localizations"
            $testResult=$false
            break
        }
        if ($currentLocalization.language -ne $myFile.language)
        {
            Write-Verbose -Message "The file $($myfile.Id) is not defined with the same culture"
            $testResult=$false
            break
        }
        $myFileData=($myFile.Versions | Where-Object -FilterScript {$_.id -eq $myFile.id}).FileData.data
        $currentFileData = Get-MgAgreementFileData -AgreementId $Id -FileId $myFile.id
        if($myFileData -ne $currentFileData)
        {
            Write-Verbose -Message "The file $($myfile.Id) has a different fileData."
            $testResult=$false
            break
        }
    }

    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null
    $ValuesToCheck.Remove('Files') | Out-Null

    #Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    #Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"
    Write-Verbose -Message "TestResult after ComplexObject check: $testResult"

    #Convert any DateTime to String
    foreach ($key in $ValuesToCheck.Keys)
    {
        if(($null -ne $CurrentValues[$key]) `
            -and ($CurrentValues[$key].getType().Name -eq 'DateTime'))
        {
            $CurrentValues[$key]=$CurrentValues[$key].toString()
        }
    }

    if($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys -verbose
    }

    Write-Verbose -Message "Test-TargetResource returned $testResult"
    return $testResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters `
        -ProfileName 'v1.0'
    $context=Get-MgContext
    if($null -eq $context)
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters -ProfileName 'beta'
    }
    Select-MgProfile 'v1.0' -ErrorAction Stop

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace("MSFT_", "")
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        #region resource generator code
        [array]$getValue = Get-MgAgreement `
            -ErrorAction Stop | Where-Object `
            -FilterScript { `
                $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.agreement'  `
            }

        if (-not $getValue)
        {
            [array]$getValue = Get-MgAgreement `
                -ErrorAction Stop
        }
        #endregion

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            Write-Host "    |---[$i/$($getValue.Count)] $($config.DisplayName)" -NoNewline
            $params = @{
                id           = $config.id
                Ensure                = 'Present'
                Credential            = $Credential
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                ApplicationSecret     = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results

            if ($Results.TermsExpiration)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.TermsExpiration -CIMInstanceName MicrosoftGraphtermsexpiration
                if ($complexTypeStringResult)
                {
                    $Results.TermsExpiration = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('TermsExpiration') | Out-Null
                }
            }
            if ($Results.Acceptances)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Acceptances -CIMInstanceName MicrosoftGraphagreementacceptance
                if ($complexTypeStringResult)
                {
                    $Results.Acceptances = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Acceptances') | Out-Null
                }
            }

            if ($Results.File)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.File -CIMInstanceName MicrosoftGraphagreementfile
                if ($complexTypeStringResult)
                {
                    $Results.File = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('File') | Out-Null
                }
            }

            if ($Results.Files)
            {
                if ($Results.Files.count -eq 0)
                {
                    Write-Host $Global:M365DSCEmojiGreenCheckMark
                }
                else
                {
                    Write-Host "`r`n" -NoNewline
                }

                $iLocalizations=1
                $curFiles = [Array]$Results.Files
                foreach($myFile in $curFiles)
                {
                    Write-Host "        |---[$iLocalizations/$($curFiles.count)] Extracting Localization $($myFile.language) " -NoNewline
                    if($myFile.Versions)
                    {
                        if ($myFile.Versions.count -eq 0)
                        {
                            Write-Host $Global:M365DSCEmojiGreenCheckMark
                        }
                        else
                        {
                            Write-Host "`r`n" -NoNewline
                        }
                        $iVersions=1
                        $curVersions = [Array]$myfile.Versions
                        foreach ($version in $curVersions)
                        {
                            Write-Host "            |---[$iVersions/$($curVersions.Count)] Extracting Version $($version.id) " -NoNewline
                            $version.fileData.data=get-MgAgreementFileData -AgreementId $getValue.Id -FileId $version.Id
                            $version.FileData=Get-M365DSCDRGComplexTypeToString -ComplexObject $version.FileData -CIMInstanceName MicrosoftGraphagreementfiledata
                            Write-Host $Global:M365DSCEmojiGreenCheckMark
                            $iVersions++
                        }
                        [Array]$myFile.Versions=Get-M365DSCDRGComplexTypeToString -ComplexObject $myFile.Versions -CIMInstanceName MicrosoftGraphagreementfileversion
                    }
                    $iLocalizations++
                }

                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Files -CIMInstanceName MicrosoftGraphagreementfilelocalization
                if ($complexTypeStringResult)
                {
                    $Results.Files = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Files') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential

            if ($Results.TermsExpiration)
            {
                $isCIMArray=$false
                if($Results.TermsExpiration.getType().Fullname -like "*[[\]]")
                {
                    $isCIMArray=$true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "TermsExpiration" -isCIMArray:$isCIMArray
            }
            if ($Results.Acceptances)
            {
                $isCIMArray=$false
                if($Results.Acceptances.getType().Fullname -like "*[[\]]")
                {
                    $isCIMArray=$true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Acceptances" -isCIMArray:$isCIMArray
            }
            if ($Results.File)
            {
                $isCIMArray=$false
                if($Results.File.getType().Fullname -like "*[[\]]")
                {
                    $isCIMArray=$true
                }

                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "File" -isCIMArray:$isCIMArray
            }
            if ($Results.Files)
            {
                $isCIMArray=$false
                if($Results.Files.getType().Fullname -like "*[[\]]")
                {
                    $isCIMArray=$true
                }
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Files" -isCIMArray:$isCIMArray
            }
            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiGreenCheckMark
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return ""
    }
}

function Get-MgAgreementFileData
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        $AgreementId,

        [Parameter(Mandatory=$true)]
        [System.String]
        $FileId
    )

    $URI="https://graph.microsoft.com/v1.0/agreements('$AgreementId')/file/localizations('$FileId')/fileData/data"
    $response=invoke-mgGraphRequest -Method GET -Uri $URI

    return $response.value
}
function Get-M365DSCDRGComplexTypeToHashtable
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter()]
        $ComplexObject
    )

    if($null -eq $ComplexObject)
    {
        return $null
    }

    if($ComplexObject.gettype().fullname -like "*[[\]]")
    {
        $results=@()

        foreach($item in $ComplexObject)
        {
            if($item)
            {
                $hash = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
                $results+=$hash
            }
        }
        if($results.count -eq 0)
        {
            return $null
        }
        return $results
    }

    $results = @{}
    $keys = $ComplexObject | Get-Member | Where-Object -FilterScript {$_.MemberType -eq 'Property' -and $_.Name -ne 'AdditionalProperties'}

    foreach ($key in $keys)
    {
        if($ComplexObject.$($key.Name))
        {
            $results.Add($key.Name, $ComplexObject.$($key.Name))
        }
    }
    if($results.count -eq 0)
    {
        return $null
    }
    return $results
}

function Get-M365DSCDRGComplexTypeToString
{
    [CmdletBinding()]
    #[OutputType([System.String])]
    param(
        [Parameter()]
        $ComplexObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $CIMInstanceName,

        [System.String]
        $Whitespace="",

        [switch]
        $isArray=$false
    )
    if ($null -eq $ComplexObject)
    {
        return $null
    }

    #If ComplexObject  is an Array
    if ($ComplexObject.GetType().FullName -like "*[[\]]")
    {
        $currentProperty=@()
        foreach ($item in $ComplexObject)
        {
            $currentProperty += Get-M365DSCDRGComplexTypeToString `
                -ComplexObject $item `
                -isArray:$true `
                -CIMInstanceName $CIMInstanceName `
                -Whitespace "            "

        }
        if ([string]::IsNullOrEmpty($currentProperty))
        {
            return $null
        }
        return $currentProperty

    }

    #If ComplexObject is a single CIM Instance
    if(-Not (Test-M365DSCComplexObjectHasValues -ComplexObject $ComplexObject))
    {
        return $null
    }
    $currentProperty = "MSFT_$CIMInstanceName{`r`n"
    $keyNotNull = 0
    foreach ($key in $ComplexObject.Keys)
    {
        if ($ComplexObject[$key])
        {
            $keyNotNull++

            if ($ComplexObject[$key].GetType().FullName -like "Microsoft.Graph.PowerShell.Models.*")
            {
                $hashPropertyType=$ComplexObject[$key].GetType().Name.tolower()
                $hashProperty=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject[$key]

                if (Test-M365DSCComplexObjectHasValues -ComplexObject $hashProperty)
                {
                    $Whitespace+="            "
                    if(-not $isArray)
                    {
                        $currentProperty += "                " + $key + " = "
                    }
                    $currentProperty += Get-M365DSCDRGComplexTypeToString `
                                    -ComplexObject $hashProperty `
                                    -CIMInstanceName $hashPropertyType `
                                    -Whitespace $Whitespace
                }
            }
            else
            {
                $currentProperty += Get-M365DSCDRGSimpleObjectTypeToString -Key $key -Value $ComplexObject[$key]
            }
        }
    }
    $currentProperty += "            }`r`n"

    if ($keyNotNull -eq 0)
    {
        $currentProperty = $null
    }

    return $currentProperty
}

function Test-M365DSCComplexObjectHasValues
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [System.Collections.Hashtable]
        [Parameter()]
        $ComplexObject
    )
    if(-Not $ComplexObject)
    {
        return $false
    }

    $keys=$ComplexObject.keys
    $hasValue=$false
    foreach($key in $keys)
    {
        if($ComplexObject[$key])
        {
            if($ComplexObject[$key].GetType().FullName -like "Microsoft.Graph.PowerShell.Models.*")
            {
                $hash=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject[$key]
                if(-Not $hash)
                {
                    return $false
                }
                $hasValue=Test-M365DSCComplexObjectHasValues -ComplexObject ($hash)
            }
            else
            {
                $hasValue=$true
                return $hasValue
            }
        }
    }
    return $hasValue
}
function Get-M365DSCDRGSimpleObjectTypeToString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.String]
        $Key,

        [Parameter(Mandatory = 'true')]
        $Value
    )

    $returnValue=""
    switch -Wildcard ($Value.GetType().Fullname )
    {
        "*.Boolean"
        {
            $returnValue= "                " + $Key + " = `$" + $Value.ToString() + "`r`n"
        }
        "*.String"
        {
            $delimeter="'"
            if($Value.startswith("MSFT_"))
            {
                $delimeter=""
            }
            $returnValue= "                " + $Key + " = $delimeter" + $Value + "$delimeter`r`n"
        }
        "*.DateTime"
        {
            $returnValue= "                " + $Key + " = '" + $Value + "'`r`n"
        }
        "*.Hashtable"
        {
            if($Value.keys.count -eq 0)
            {
                return ""
            }

            $returnValue= "                " + $key + " = @{`r`n"
            $whitespace="                     "
            $newline="`r`n"
            foreach($k in $Value.keys)
            {
                switch -Wildcard ($Value[$k].GetType().Fullname )
                {
                    "*.String"
                    {
                        $returnValue += "$whitespace$k = '$($Value[$k])'$newline"
                    }
                    "*.DateTime"
                    {
                        $returnValue += "$whitespace$k = '$($Value[$k])'$newline"
                    }
                    Default
                    {
                        $returnValue += "$whitespace$k = $($Value[$k])$newline"
                    }
                }
            }

            $returnValue += "                }`r`n"
        }
        "*[[\]]"
        {
            $returnValue= "                " + $key + " = @("
            $whitespace=""
            $newline=""
            if($Value.count -gt 1)
            {
                $returnValue += "`r`n"
                $whitespace="                    "
                $newline="`r`n"
            }
            foreach ($item in $Value)
            {
                switch -Wildcard ($item.GetType().Fullname )
                {
                    "*.String"
                    {
                        $delimeter="'"
                        if($Value.startswith("MSFT_"))
                        {
                            $delimeter=""
                        }
                        $returnValue += "$whitespace$delimeter$item$delimeter$newline"
                    }
                    "*.DateTime"
                    {
                        $returnValue += "$whitespace'$item'$newline"
                    }
                    Default
                    {
                        $returnValue += "$whitespace$item$newline"
                    }
                }
            }
            if($Value.count -gt 1)
            {
                $returnValue += "                )`r`n"
            }
            else
            {
                $returnValue += ")`r`n"

            }
        }
        Default
        {
            $returnValue= "                " + $Key + " = " + $Value + "`r`n"
        }
    }
    return $returnValue
}
function Get-M365DSCAdditionalProperties
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param(
        [Parameter(Mandatory = 'true')]
        [System.Collections.Hashtable]
        $Properties
    )

    $results = @{"@odata.type" = "#microsoft.graph.agreement" }
    foreach ($property in $properties.Keys)
    {
        if ($property -ne 'Verbose')
        {
            $propertyName = $property[0].ToString().ToLower() + $property.Substring(1, $property.Length - 1)
            $propertyValue = $properties.$property
            $results.Add($propertyName, $propertyValue)
        }
    }
    return $results
}
function Compare-M365DSCComplexObject
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [Parameter()]
        [System.Collections.Hashtable]
        $Source,

        [Parameter()]
        [System.Collections.Hashtable]
        $Target
    )

    if (($null -eq $Source) -and ($null -eq $Target))
    {
        return $true
    }

    $keys= $Source.Keys|Where-Object -FilterScript {$_ -ne "PSComputerName"}
    foreach ($key in $keys)
    {
        #Marking Target[key] to null if empty complex object or array
        if($null -ne $Target[$key])
        {
            switch -Wildcard ($Target[$key].getType().Fullname )
            {
                "Microsoft.Graph.PowerShell.Models.*"
                {
                    $hashProperty=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $Target[$key]
                    if(-not (Test-M365DSCComplexObjectHasValues -ComplexObject $hashProperty))
                    {
                        $Target[$key]=$null
                    }
                }
                "*[[\]]"
                {
                    if($Target[$key].count -eq 0)
                    {
                        $Target[$key]=$null
                    }
                }
                "*DateTime"
                {
                    $Target[$key]=$Target[$key].tostring("MM/dd/yyyy HH:mm:ss")
                }
            }
        }

        #One of the item is null
        if (($null -eq $Source[$key]) -xor ($null -eq $Target[$key]))
        {
            Write-Verbose -Message "Configuration drift key: $key - one of the object null and not the other"
            return $false
        }
        #Both source and target aren't null or empty
        if(($null -ne $Source[$key]) -and ($null -ne $Target[$key]))
        {
            if($Source[$key].getType().FullName -like "*CimInstance*")
            {
                #Recursive call for complex object
                $itemSource=@()
                $itemSource+= $Source[$key]
                $itemTarget= @()
                $itemTarget+= $Target[$key]

                $i=0
                foreach($item in $itemSource)
                {
                    if(-not ($itemSource[$i].getType().Fullname -like "*.Hashtable"))
                    {
                        $itemSource[$i]=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $itemSource[$i]
                    }
                    if(-not ($itemTarget[$i].getType().Fullname -like "*.Hashtable"))
                    {
                        $itemTarget[$i]=Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $itemTarget[$i]
                    }

                    #Recursive call for complex object
                    $compareResult= Compare-M365DSCComplexObject `
                        -Source ($itemSource[$i]) `
                        -Target ($itemTarget[$i])


                    if(-not $compareResult)
                    {
                        Write-Verbose -Message "Complex Object drift key: $key - Source $($itemSource[$i]|out-string)"
                        Write-Verbose -Message "Complex Object drift key: $key - Target $($itemTarget[$i]|out-string)"
                        return $false
                    }
                    $i++
                }
            }
            else
            {
                #Simple object comparison
                $referenceObject=$Target[$key]
                $differenceObject=$Source[$key]

                $compareResult = Compare-Object `
                    -ReferenceObject ($referenceObject) `
                    -DifferenceObject ($differenceObject)

                if ($null -ne $compareResult)
                {
                    Write-Verbose -Message "Simple Object drift key: $key - Source $($referenceObject|out-string)"
                    Write-Verbose -Message "Simple Object drift key: $key - Target $($differenceObject|out-string)"
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
    param(
        [Parameter(Mandatory = 'true')]
        $ComplexObject
    )

    if($ComplexObject.getType().Fullname -like "*[[\]]")
    {
        $results=@()
        foreach($item in $ComplexObject)
        {
            $hash=Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $item
            if(Test-M365DSCComplexObjectHasValues -ComplexObject $hash)
            {
                $results+=$hash
            }
        }
        if($results.count -eq 0)
        {
            return $null
        }
        return $Results
    }
    $hashComplexObject = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $ComplexObject
    $results=$hashComplexObject.clone()
    $keys=$hashComplexObject.Keys|Where-Object -FilterScript {$_ -ne 'PSComputerName'}
    foreach ($key in $keys)
    {
        if(($null -ne $hashComplexObject[$key]) -and ($hashComplexObject[$key].getType().Fullname -like "*CimInstance*"))
        {
            $results[$key]=Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $hashComplexObject[$key]
        }
        if($null -eq $results[$key])
        {
            $results.remove($key)|out-null
        }

    }
    return $results
}
Export-ModuleMember -Function *-TargetResource
