function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ApiConnectorConfiguration,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $IdentityProviders,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UserAttributeAssignments,

        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters

        #Ensure the proper dependencies are installed in the current environment.
        Confirm-M365DSCDependencies

        #region Telemetry
        $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
        $CommandName = $MyInvocation.MyCommand
        $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
            -CommandName $CommandName `
            -Parameters $PSBoundParameters
        Add-M365DSCTelemetryEvent -Data $data
        #endregion

        $nullResult = $PSBoundParameters
        $nullResult.Ensure = 'Absent'

        $getValue = $null
        #region resource generator code
        $getValue = Get-MgBetaIdentityB2XUserFlow -B2XIdentityUserFlowId $Id -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Identity B2 X User Flow with Id {$Id}"
            return $nullResult
        }
        #endregion

        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Identity B2 X User Flow with Id {$Id} was found"

        #region Get ApiConnectorConfiguration
        $connectorConfiguration = Get-MgBetaIdentityB2XUserFlowApiConnectorConfiguration -B2xIdentityUserFlowId $Id -ExpandProperty "postFederationSignup,postAttributeCollection"

        $complexApiConnectorConfiguration = @{
            postFederationSignupConnectorName = Get-ConnectorName($connectorConfiguration.PostFederationSignup.DisplayName)
            postAttributeCollectionConnectorName = Get-ConnectorName($connectorConfiguration.PostAttributeCollection.DisplayName)
        }
        #endregion

        #region Get IdentityProviders
        $getIdentityProviders = Get-MgBetaIdentityB2XUserFlowIdentityProvider -B2XIdentityUserFlowId $Id | Select-Object Id
        if ($getIdentityProviders.Count -eq 0)
        {
            $getIdentityProviders = @()
        }
        #endregion

        $complexUserAttributeAssignments = @()
        $getUserAttributeAssignments = Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2XIdentityUserFlowId $Id -ExpandProperty UserAttribute
        foreach ($getUserAttributeAssignment in $getUserAttributeAssignments)
        {
            $getuserAttributeValues = @()
            foreach ($getUserAttributeAssignmentAttributeValue in $getUserAttributeAssignment.UserAttributeValues)
            {
                $getuserAttributeValues += @{
                    Name = $getUserAttributeAssignmentAttributeValue.Name
                    Value = $getUserAttributeAssignmentAttributeValue.Value
                    IsDefault = $getUserAttributeAssignmentAttributeValue.IsDefault
                }
            }
            $complexUserAttributeAssignments += @{
                Id = $getUserAttributeAssignment.Id
                DisplayName = $getUserAttributeAssignment.DisplayName
                IsOptional = $getUserAttributeAssignment.IsOptional
                UserInputType = $getUserAttributeAssignment.UserInputType
                UserAttributeValues = $getuserAttributeValues
            }
        }

        $results = @{
            #region resource generator code
            ApiConnectorConfiguration = $complexApiConnectorConfiguration
            Id                        = $getValue.Id
            IdentityProviders         = $getIdentityProviders
            UserAttributeAssignments  = $complexUserAttributeAssignments
            Ensure                    = 'Present'
            Credential                = $Credential
            ApplicationId             = $ApplicationId
            TenantId                  = $TenantId
            ApplicationSecret         = $ApplicationSecret
            CertificateThumbprint     = $CertificateThumbprint
            ManagedIdentity           = $ManagedIdentity.IsPresent
            #endregion
        }

        return [System.Collections.Hashtable] $results
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ApiConnectorConfiguration,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $IdentityProviders,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UserAttributeAssignments,

        #endregion
        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentInstance = Get-TargetResource @PSBoundParameters

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Azure AD Identity B2 X User Flow with Id {$Id}"

        #region Create ApiConnectorConfiguration object
        $newApiConnectorConfiguration = @{}
        if (-not [string]::IsNullOrEmpty($ApiConnectorConfiguration.postFederationSignupConnectorName))
        {
            $getConnector = Get-MgBetaIdentityApiConnector -Filter "DisplayName eq '$($ApiConnectorConfiguration.postFederationSignupConnectorName)'"
            $newApiConnectorConfiguration['PostFederationSignup'] = @{
                'Id' = $getConnector.Id
            }
        }

        if (-not [string]::IsNullOrEmpty($ApiConnectorConfiguration.postAttributeCollectionConnectorName))
        {
            $getConnector = Get-MgBetaIdentityApiConnector -Filter "DisplayName eq '$($ApiConnectorConfiguration.postAttributeCollectionConnectorName)'"
            $newApiConnectorConfiguration['PostAttributeCollection'] = @{
                'Id' = $getConnector.Id
            }
        }
        #endregion

        $params = @{
            id = $Id
            userFlowType = "signUpOrSignIn"
            userFlowTypeVersion = 1
            apiConnectorConfiguration = $newApiConnectorConfiguration
        }

        $newObj = New-MgBetaIdentityB2XUserFlow -BodyParameter $params

        #region Add IdentityProvider objects to the newly created object
        foreach ($provider in $IdentityProviders)
        {
            $params = @{
                "@odata.id" = "https://graph.microsoft.com/beta/identityProviders/$($provider)"
            }

            Write-Verbose -Message "Adding the Identity Provider with Id {$provider} to the newly created Azure AD Identity B2X User Flow with Id {$($newObj.Id)}"

            New-MgBetaIdentityB2XUserFlowIdentityProviderByRef -B2XIdentityUserFlowId $newObj.Id -BodyParameter $params
        }
        #endregion

        #region Add UserAtrributeAssignments to the newly created object
        $currentAttributes = Get-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2XIdentityUserFlowId $newObj.Id | Select-Object -ExpandProperty Id
        $attributesToAdd = $UserAttributeAssignments | Where-Object {$_.Id -notin $currentAttributes}

        foreach ($userAttributeAssignment in $attributesToAdd)
        {
            $params = @{
                displayName = $userAttributeAssignment.DisplayName
                isOptional = $userAttributeAssignment.IsOptional
                userInputType = $userAttributeAssignment.UserInputType
                userAttributeValues = @()
                userAttribute = @{
                    id = $userAttributeAssignment.Id
                }
            }

            foreach ($userAttributeValue in $userAttributeAssignment.UserAttributeValues)
            {
                $params['userAttributeValues'] += @{
                    "Name" = $userAttributeValue.Name
                    "Value" = $userAttributeValue.Value
                    "IsDefault" = $userAttributeValue.IsDefault
                }
            }

            Write-Verbose -Message "Adding the User Attribute Assignment with Id {$($userAttributeAssignment.Id)} to the newly created Azure AD Identity B2X User Flow with Id {$($newObj.Id)}"

            New-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2XIdentityUserFlowId $newObj.Id -BodyParameter $params
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

        #region Update ApiConnectorConfiguration object
        if (-not [string]::IsNullOrEmpty($ApiConnectorConfiguration.postFederationSignupConnectorName))
        {
            $getConnector = Get-MgBetaIdentityApiConnector -Filter "DisplayName eq '$($ApiConnectorConfiguration.postFederationSignupConnectorName)'"
            $params = @{
                "@odata.id" = "https://graph.microsoft.com/beta/identity/apiConnectors/$($getConnector.Id)"
            }

            Write-Verbose -Message "Updating the Post Federation Signup connector for Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

            Set-MgBetaIdentityB2XUserFlowPostFederationSignupByRef -B2xIdentityUserFlowId $currentInstance.Id -BodyParameter $params
        }

        if (-not [string]::IsNullOrEmpty($ApiConnectorConfiguration.postAttributeCollectionConnectorName))
        {
            $getConnector = Get-MgBetaIdentityApiConnector -Filter "DisplayName eq '$($ApiConnectorConfiguration.postAttributeCollectionConnectorName)'"
            $params = @{
                "@odata.id" = "https://graph.microsoft.com/beta/identity/apiConnectors/$($getConnector.Id)"
            }

            Write-Verbose -Message "Updating the Post Attribute Collection connector for Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

            Set-MgBetaIdentityB2XUserFlowPostAttributeCollectionByRef -B2xIdentityUserFlowId $currentInstance.Id -BodyParameter $params
        }
        #endregion

        #region Add or Remove Identity Providers on the current instance
        $providersToAdd = $IdentityProviders | Where-Object {$_ -notin $currentInstance.IdentityProviders}
        foreach ($provider in $providersToAdd)
        {
            $params = @{
                "@odata.id" = "https://graph.microsoft.com/beta/identityProviders/$($provider)"
            }

            Write-Verbose -Message "Adding the Identity Provider with Id {$provider} to the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

            New-MgBetaIdentityB2XUserFlowIdentityProviderByRef -B2XIdentityUserFlowId $currentInstance.Id -BodyParameter $params
        }

        $providersToRemove = $currentInstance.IdentityProviders |  Where-Object {$_ -notin $IdentityProviders}
        foreach ($provider in $providersToRemove)
        {
            Write-Verbose -Message "Removing the Identity Provider with Id {$provider} from the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

            Remove-MgBetaIdentityB2XUserFlowIdentityProviderByRef -B2XIdentityUserFlowId $currentInstance.Id -IdentityProviderBaseId $provider
        }
        #endregion

        #region Add, remove or update User Attribute Assignments on the current instance
        $attributesToRemove = $currentInstance.UserAttributeAssignments | Where-Object {$_.Id -notin $UserAttributeAssignments.Id}

        #Remove
        foreach ($userAttributeAssignment in $attributesToRemove)
        {
            Write-Verbose -Message "Removing the User Attribute Assignment with Id {$($userAttributeAssignment.Id)} from the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

            Remove-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2XIdentityUserFlowId $currentInstance.Id -IdentityUserFlowAttributeAssignmentId $userAttributeAssignment.Id
        }

        #Add/Update
        foreach ($userAttributeAssignment in $UserAttributeAssignments)
        {
            $params = @{
                displayName = $userAttributeAssignment.DisplayName
                isOptional = $userAttributeAssignment.IsOptional
                userInputType = $userAttributeAssignment.UserInputType
                userAttributeValues = @()
            }

            foreach ($userAttributeValue in $userAttributeAssignment.UserAttributeValues)
            {
                $params['userAttributeValues'] += @{
                    "Name" = $userAttributeValue.Name
                    "Value" = $userAttributeValue.Value
                    "IsDefault" = $userAttributeValue.IsDefault
                }
            }

            if ($userAttributeAssignment.Id -notin $currentInstance.UserAttributeAssignments.Id)
            {
                $params["userAttribute"] = @{
                    id = $userAttributeAssignment.Id
                }

                Write-Verbose -Message "Adding the User Attribute Assignment with Id {$($userAttributeAssignment.Id)} to the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

                New-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2XIdentityUserFlowId $currentInstance.Id -BodyParameter $params
            }
            else
            {
                Write-Verbose -Message "Updating the User Attribute Assignment with Id {$($userAttributeAssignment.Id)} in the Azure AD Identity B2X User Flow with Id {$($currentInstance.Id)}"

                Update-MgBetaIdentityB2XUserFlowUserAttributeAssignment -B2xIdentityUserFlowId $currentInstance.Id -IdentityUserFlowAttributeAssignmentId $userAttributeAssignment.Id -BodyParameter $params
            }
        }
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Azure AD Identity B2 X User Flow with Id {$($currentInstance.Id)}"
        Remove-MgBetaIdentityB2XUserFlow -B2XIdentityUserFlowId $currentInstance.Id
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ApiConnectorConfiguration,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        [Parameter()]
        [System.String[]]
        $IdentityProviders,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $UserAttributeAssignments,

        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of the Azure AD Identity B2 X User Flow with Id {$Id}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }

    $testResult = $true

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($null -ne $source -and $source.GetType().Name -like '*CimInstance*')
        {
            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-not $testResult)
            {
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    if ($ValuesToCheck.Count -gt 0 -and $testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
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
        [System.String]
        $Filter,

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
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity,

        [Parameter()]
        [System.String[]]
        $AccessTokens
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        #region resource generator code
        [array]$getValue = Get-MgBetaIdentityB2XUserFlow `
            -Filter $Filter `
            -All `
            -ErrorAction Stop
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
            $displayedKey = $config.Id
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                ManagedIdentity = $ManagedIdentity.IsPresent
                AccessTokens = $AccessTokens
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($null -ne $Results.ApiConnectorConfiguration)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ApiConnectorConfiguration `
                    -CIMInstanceName 'MicrosoftGraphuserFlowApiConnectorConfiguration'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ApiConnectorConfiguration = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ApiConnectorConfiguration') | Out-Null
                }
            }

            if ($null -ne $Results.UserAttributeAssignments)
            {
                $complexMapping = @(
                    @{
                        Name = 'UserAttributeValues'
                        CimInstanceName = 'MicrosoftGraphuserFlowUserAttributeAssignmentUserAttributeValues'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.UserAttributeAssignments `
                    -CIMInstanceName 'MicrosoftGraphuserFlowUserAttributeAssignment' `
                    -ComplexTypeMapping $complexMapping

                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.UserAttributeAssignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('UserAttributeAssignments') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.ApiConnectorConfiguration)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ApiConnectorConfiguration" -IsCIMArray:$False
            }
            if ($Results.UserAttributeAssignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "UserAttributeAssignments" -IsCIMArray:$True
            }

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

function Get-ConnectorName($connectorName) {
    if ($null -ne $connectorName) {
        return $connectorName
    } else {
        return ""
    }
}

Export-ModuleMember -Function *-TargetResource
