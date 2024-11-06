function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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
        $getValue = Get-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Security Baseline Microsoft365 Apps For Enterprise with Id {$Id}"

            if (-not [System.String]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgBetaDeviceManagementConfigurationPolicy `
                    -Filter "Name eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Intune Security Baseline Microsoft365 Apps For Enterprise with Name {$DisplayName}."
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Intune Security Baseline Microsoft365 Apps For Enterprise with Id {$Id} and Name {$DisplayName} was found"

        # Retrieve policy specific settings
        [array]$settings = Get-MgBetaDeviceManagementConfigurationPolicySetting `
            -DeviceManagementConfigurationPolicyId $Id `
            -ExpandProperty 'settingDefinitions' `
            -All `
            -ErrorAction Stop

        $policySettings = @{}
        $policySettings = Export-IntuneSettingCatalogPolicySettings -Settings $settings -ReturnHashtable $policySettings -ContainsDeviceAndUserSettings

        #region resource generator code
        $complexDeviceSettings = @{}
        $complexDeviceSettings.Add('Pol_SecGuide_A001_Block_Flash', $policySettings.DeviceSettings.pol_SecGuide_A001_Block_Flash)
        $complexDeviceSettings.Add('Pol_SecGuide_Block_Flash', $policySettings.DeviceSettings.pol_SecGuide_Block_Flash)
        $complexDeviceSettings.Add('Pol_SecGuide_Legacy_JScript', $policySettings.DeviceSettings.pol_SecGuide_Legacy_JScript)
        $complexDeviceSettings.Add('POL_SG_powerpnt', $policySettings.DeviceSettings.pOL_SG_powerpnt)
        $complexDeviceSettings.Add('POL_SG_onenote', $policySettings.DeviceSettings.pOL_SG_onenote)
        $complexDeviceSettings.Add('POL_SG_mspub', $policySettings.DeviceSettings.pOL_SG_mspub)
        $complexDeviceSettings.Add('POL_SG_msaccess', $policySettings.DeviceSettings.pOL_SG_msaccess)
        $complexDeviceSettings.Add('POL_SG_winproj', $policySettings.DeviceSettings.pOL_SG_winproj)
        $complexDeviceSettings.Add('POL_SG_visio', $policySettings.DeviceSettings.pOL_SG_visio)
        $complexDeviceSettings.Add('POL_SG_outlook', $policySettings.DeviceSettings.pOL_SG_outlook)
        $complexDeviceSettings.Add('POL_SG_winword', $policySettings.DeviceSettings.pOL_SG_winword)
        $complexDeviceSettings.Add('POL_SG_excel', $policySettings.DeviceSettings.pOL_SG_excel)
        $complexDeviceSettings.Add('L_PolicyEnableSIPHighSecurityMode', $policySettings.DeviceSettings.l_PolicyEnableSIPHighSecurityMode)
        $complexDeviceSettings.Add('L_PolicyDisableHttpConnect', $policySettings.DeviceSettings.l_PolicyDisableHttpConnect)
        $complexDeviceSettings.Add('L_AddonManagement', $policySettings.DeviceSettings.l_AddonManagement)
        $complexDeviceSettings.Add('L_powerpntexe17', $policySettings.DeviceSettings.l_powerpntexe17)
        $complexDeviceSettings.Add('L_excelexe15', $policySettings.DeviceSettings.l_excelexe15)
        $complexDeviceSettings.Add('L_visioexe19', $policySettings.DeviceSettings.l_visioexe19)
        $complexDeviceSettings.Add('L_onenoteexe26', $policySettings.DeviceSettings.l_onenoteexe26)
        $complexDeviceSettings.Add('L_outlookexe22', $policySettings.DeviceSettings.l_outlookexe22)
        $complexDeviceSettings.Add('L_pptviewexe18', $policySettings.DeviceSettings.l_pptviewexe18)
        $complexDeviceSettings.Add('L_winwordexe21', $policySettings.DeviceSettings.l_winwordexe21)
        $complexDeviceSettings.Add('L_exprwdexe24', $policySettings.DeviceSettings.l_exprwdexe24)
        $complexDeviceSettings.Add('L_spdesignexe23', $policySettings.DeviceSettings.l_spdesignexe23)
        $complexDeviceSettings.Add('L_winprojexe20', $policySettings.DeviceSettings.l_winprojexe20)
        $complexDeviceSettings.Add('L_grooveexe14', $policySettings.DeviceSettings.l_grooveexe14)
        $complexDeviceSettings.Add('L_mspubexe16', $policySettings.DeviceSettings.l_mspubexe16)
        $complexDeviceSettings.Add('L_mse7exe27', $policySettings.DeviceSettings.l_mse7exe27)
        $complexDeviceSettings.Add('L_msaccessexe25', $policySettings.DeviceSettings.l_msaccessexe25)
        $complexDeviceSettings.Add('L_ConsistentMimeHandling', $policySettings.DeviceSettings.l_ConsistentMimeHandling)
        $complexDeviceSettings.Add('L_excelexe43', $policySettings.DeviceSettings.l_excelexe43)
        $complexDeviceSettings.Add('L_spdesignexe51', $policySettings.DeviceSettings.l_spdesignexe51)
        $complexDeviceSettings.Add('L_onenoteexe54', $policySettings.DeviceSettings.l_onenoteexe54)
        $complexDeviceSettings.Add('L_outlookexe50', $policySettings.DeviceSettings.l_outlookexe50)
        $complexDeviceSettings.Add('L_pptviewexe46', $policySettings.DeviceSettings.l_pptviewexe46)
        $complexDeviceSettings.Add('L_mspubexe44', $policySettings.DeviceSettings.l_mspubexe44)
        $complexDeviceSettings.Add('L_visioexe47', $policySettings.DeviceSettings.l_visioexe47)
        $complexDeviceSettings.Add('L_winprojexe48', $policySettings.DeviceSettings.l_winprojexe48)
        $complexDeviceSettings.Add('L_msaccessexe53', $policySettings.DeviceSettings.l_msaccessexe53)
        $complexDeviceSettings.Add('L_powerpntexe45', $policySettings.DeviceSettings.l_powerpntexe45)
        $complexDeviceSettings.Add('L_grooveexe42', $policySettings.DeviceSettings.l_grooveexe42)
        $complexDeviceSettings.Add('L_mse7exe55', $policySettings.DeviceSettings.l_mse7exe55)
        $complexDeviceSettings.Add('L_winwordexe49', $policySettings.DeviceSettings.l_winwordexe49)
        $complexDeviceSettings.Add('L_exprwdexe52', $policySettings.DeviceSettings.l_exprwdexe52)
        $complexDeviceSettings.Add('L_Disableusernameandpassword', $policySettings.DeviceSettings.l_Disableusernameandpassword)
        $complexDeviceSettings.Add('L_excelexe127', $policySettings.DeviceSettings.l_excelexe127)
        $complexDeviceSettings.Add('L_grooveexe126', $policySettings.DeviceSettings.l_grooveexe126)
        $complexDeviceSettings.Add('L_onenoteexe138', $policySettings.DeviceSettings.l_onenoteexe138)
        $complexDeviceSettings.Add('L_mse7exe139', $policySettings.DeviceSettings.l_mse7exe139)
        $complexDeviceSettings.Add('L_mspubexe128', $policySettings.DeviceSettings.l_mspubexe128)
        $complexDeviceSettings.Add('L_visioexe131', $policySettings.DeviceSettings.l_visioexe131)
        $complexDeviceSettings.Add('L_exprwdexe136', $policySettings.DeviceSettings.l_exprwdexe136)
        $complexDeviceSettings.Add('L_msaccessexe137', $policySettings.DeviceSettings.l_msaccessexe137)
        $complexDeviceSettings.Add('L_spdesignexe135', $policySettings.DeviceSettings.l_spdesignexe135)
        $complexDeviceSettings.Add('L_winwordexe133', $policySettings.DeviceSettings.l_winwordexe133)
        $complexDeviceSettings.Add('L_powerpntexe129', $policySettings.DeviceSettings.l_powerpntexe129)
        $complexDeviceSettings.Add('L_outlookexe134', $policySettings.DeviceSettings.l_outlookexe134)
        $complexDeviceSettings.Add('L_winprojexe132', $policySettings.DeviceSettings.l_winprojexe132)
        $complexDeviceSettings.Add('L_pptviewexe130', $policySettings.DeviceSettings.l_pptviewexe130)
        $complexDeviceSettings.Add('L_Informationbar', $policySettings.DeviceSettings.l_Informationbar)
        $complexDeviceSettings.Add('L_excelexe113', $policySettings.DeviceSettings.l_excelexe113)
        $complexDeviceSettings.Add('L_mspubexe114', $policySettings.DeviceSettings.l_mspubexe114)
        $complexDeviceSettings.Add('L_msaccessexe123', $policySettings.DeviceSettings.l_msaccessexe123)
        $complexDeviceSettings.Add('L_onenoteexe124', $policySettings.DeviceSettings.l_onenoteexe124)
        $complexDeviceSettings.Add('L_outlookexe120', $policySettings.DeviceSettings.l_outlookexe120)
        $complexDeviceSettings.Add('L_winprojexe118', $policySettings.DeviceSettings.l_winprojexe118)
        $complexDeviceSettings.Add('L_powerpntexe115', $policySettings.DeviceSettings.l_powerpntexe115)
        $complexDeviceSettings.Add('L_spdesignexe121', $policySettings.DeviceSettings.l_spdesignexe121)
        $complexDeviceSettings.Add('L_grooveexe112', $policySettings.DeviceSettings.l_grooveexe112)
        $complexDeviceSettings.Add('L_visioexe117', $policySettings.DeviceSettings.l_visioexe117)
        $complexDeviceSettings.Add('L_mse7exe125', $policySettings.DeviceSettings.l_mse7exe125)
        $complexDeviceSettings.Add('L_winwordexe119', $policySettings.DeviceSettings.l_winwordexe119)
        $complexDeviceSettings.Add('L_exprwdexe122', $policySettings.DeviceSettings.l_exprwdexe122)
        $complexDeviceSettings.Add('L_pptviewexe116', $policySettings.DeviceSettings.l_pptviewexe116)
        $complexDeviceSettings.Add('L_LocalMachineZoneLockdownSecurity', $policySettings.DeviceSettings.l_LocalMachineZoneLockdownSecurity)
        $complexDeviceSettings.Add('L_mse7exe41', $policySettings.DeviceSettings.l_mse7exe41)
        $complexDeviceSettings.Add('L_powerpntexe31', $policySettings.DeviceSettings.l_powerpntexe31)
        $complexDeviceSettings.Add('L_mspubexe30', $policySettings.DeviceSettings.l_mspubexe30)
        $complexDeviceSettings.Add('L_outlookexe36', $policySettings.DeviceSettings.l_outlookexe36)
        $complexDeviceSettings.Add('L_pptviewexe32', $policySettings.DeviceSettings.l_pptviewexe32)
        $complexDeviceSettings.Add('L_excelexe29', $policySettings.DeviceSettings.l_excelexe29)
        $complexDeviceSettings.Add('L_exprwdexe38', $policySettings.DeviceSettings.l_exprwdexe38)
        $complexDeviceSettings.Add('L_grooveexe28', $policySettings.DeviceSettings.l_grooveexe28)
        $complexDeviceSettings.Add('L_winwordexe35', $policySettings.DeviceSettings.l_winwordexe35)
        $complexDeviceSettings.Add('L_msaccessexe39', $policySettings.DeviceSettings.l_msaccessexe39)
        $complexDeviceSettings.Add('L_spdesignexe37', $policySettings.DeviceSettings.l_spdesignexe37)
        $complexDeviceSettings.Add('L_visioexe33', $policySettings.DeviceSettings.l_visioexe33)
        $complexDeviceSettings.Add('L_onenoteexe40', $policySettings.DeviceSettings.l_onenoteexe40)
        $complexDeviceSettings.Add('L_winprojexe34', $policySettings.DeviceSettings.l_winprojexe34)
        $complexDeviceSettings.Add('L_MimeSniffingSafetyFature', $policySettings.DeviceSettings.l_MimeSniffingSafetyFature)
        $complexDeviceSettings.Add('L_powerpntexe59', $policySettings.DeviceSettings.l_powerpntexe59)
        $complexDeviceSettings.Add('L_exprwdexe66', $policySettings.DeviceSettings.l_exprwdexe66)
        $complexDeviceSettings.Add('L_grooveexe56', $policySettings.DeviceSettings.l_grooveexe56)
        $complexDeviceSettings.Add('L_visioexe61', $policySettings.DeviceSettings.l_visioexe61)
        $complexDeviceSettings.Add('L_outlookexe64', $policySettings.DeviceSettings.l_outlookexe64)
        $complexDeviceSettings.Add('L_mspubexe58', $policySettings.DeviceSettings.l_mspubexe58)
        $complexDeviceSettings.Add('L_mse7exe69', $policySettings.DeviceSettings.l_mse7exe69)
        $complexDeviceSettings.Add('L_msaccessexe67', $policySettings.DeviceSettings.l_msaccessexe67)
        $complexDeviceSettings.Add('L_pptviewexe60', $policySettings.DeviceSettings.l_pptviewexe60)
        $complexDeviceSettings.Add('L_winprojexe62', $policySettings.DeviceSettings.l_winprojexe62)
        $complexDeviceSettings.Add('L_spdesignexe65', $policySettings.DeviceSettings.l_spdesignexe65)
        $complexDeviceSettings.Add('L_onenoteexe68', $policySettings.DeviceSettings.l_onenoteexe68)
        $complexDeviceSettings.Add('L_winwordexe63', $policySettings.DeviceSettings.l_winwordexe63)
        $complexDeviceSettings.Add('L_excelexe57', $policySettings.DeviceSettings.l_excelexe57)
        $complexDeviceSettings.Add('L_NavigateURL', $policySettings.DeviceSettings.l_NavigateURL)
        $complexDeviceSettings.Add('L_spdesignexe177', $policySettings.DeviceSettings.l_spdesignexe177)
        $complexDeviceSettings.Add('L_onenoteexe180', $policySettings.DeviceSettings.l_onenoteexe180)
        $complexDeviceSettings.Add('L_pptviewexe172', $policySettings.DeviceSettings.l_pptviewexe172)
        $complexDeviceSettings.Add('L_outlookexe176', $policySettings.DeviceSettings.l_outlookexe176)
        $complexDeviceSettings.Add('L_winprojexe174', $policySettings.DeviceSettings.l_winprojexe174)
        $complexDeviceSettings.Add('L_msaccessexe179', $policySettings.DeviceSettings.l_msaccessexe179)
        $complexDeviceSettings.Add('L_winwordexe175', $policySettings.DeviceSettings.l_winwordexe175)
        $complexDeviceSettings.Add('L_excelexe169', $policySettings.DeviceSettings.l_excelexe169)
        $complexDeviceSettings.Add('L_mspubexe170', $policySettings.DeviceSettings.l_mspubexe170)
        $complexDeviceSettings.Add('L_exprwdexe178', $policySettings.DeviceSettings.l_exprwdexe178)
        $complexDeviceSettings.Add('L_powerpntexe171', $policySettings.DeviceSettings.l_powerpntexe171)
        $complexDeviceSettings.Add('L_visioexe173', $policySettings.DeviceSettings.l_visioexe173)
        $complexDeviceSettings.Add('L_mse7exe181', $policySettings.DeviceSettings.l_mse7exe181)
        $complexDeviceSettings.Add('L_grooveexe168', $policySettings.DeviceSettings.l_grooveexe168)
        $complexDeviceSettings.Add('L_ObjectCachingProtection', $policySettings.DeviceSettings.l_ObjectCachingProtection)
        $complexDeviceSettings.Add('L_winwordexe77', $policySettings.DeviceSettings.l_winwordexe77)
        $complexDeviceSettings.Add('L_powerpntexe73', $policySettings.DeviceSettings.l_powerpntexe73)
        $complexDeviceSettings.Add('L_spdesignexe79', $policySettings.DeviceSettings.l_spdesignexe79)
        $complexDeviceSettings.Add('L_mse7exe83', $policySettings.DeviceSettings.l_mse7exe83)
        $complexDeviceSettings.Add('L_mspubexe72', $policySettings.DeviceSettings.l_mspubexe72)
        $complexDeviceSettings.Add('L_msaccessexe81', $policySettings.DeviceSettings.l_msaccessexe81)
        $complexDeviceSettings.Add('L_onenoteexe82', $policySettings.DeviceSettings.l_onenoteexe82)
        $complexDeviceSettings.Add('L_outlookexe78', $policySettings.DeviceSettings.l_outlookexe78)
        $complexDeviceSettings.Add('L_grooveexe70', $policySettings.DeviceSettings.l_grooveexe70)
        $complexDeviceSettings.Add('L_excelexe71', $policySettings.DeviceSettings.l_excelexe71)
        $complexDeviceSettings.Add('L_visioexe75', $policySettings.DeviceSettings.l_visioexe75)
        $complexDeviceSettings.Add('L_pptviewexe74', $policySettings.DeviceSettings.l_pptviewexe74)
        $complexDeviceSettings.Add('L_winprojexe76', $policySettings.DeviceSettings.l_winprojexe76)
        $complexDeviceSettings.Add('L_exprwdexe80', $policySettings.DeviceSettings.l_exprwdexe80)
        $complexDeviceSettings.Add('L_ProtectionFromZoneElevation', $policySettings.DeviceSettings.l_ProtectionFromZoneElevation)
        $complexDeviceSettings.Add('L_mspubexe100', $policySettings.DeviceSettings.l_mspubexe100)
        $complexDeviceSettings.Add('L_visioexe103', $policySettings.DeviceSettings.l_visioexe103)
        $complexDeviceSettings.Add('L_powerpntexe101', $policySettings.DeviceSettings.l_powerpntexe101)
        $complexDeviceSettings.Add('L_excelexe99', $policySettings.DeviceSettings.l_excelexe99)
        $complexDeviceSettings.Add('L_mse7exe111', $policySettings.DeviceSettings.l_mse7exe111)
        $complexDeviceSettings.Add('L_winwordexe105', $policySettings.DeviceSettings.l_winwordexe105)
        $complexDeviceSettings.Add('L_exprwdexe108', $policySettings.DeviceSettings.l_exprwdexe108)
        $complexDeviceSettings.Add('L_msaccessexe109', $policySettings.DeviceSettings.l_msaccessexe109)
        $complexDeviceSettings.Add('L_spdesignexe107', $policySettings.DeviceSettings.l_spdesignexe107)
        $complexDeviceSettings.Add('L_onenoteexe110', $policySettings.DeviceSettings.l_onenoteexe110)
        $complexDeviceSettings.Add('L_pptviewexe102', $policySettings.DeviceSettings.l_pptviewexe102)
        $complexDeviceSettings.Add('L_winprojexe104', $policySettings.DeviceSettings.l_winprojexe104)
        $complexDeviceSettings.Add('L_grooveexe98', $policySettings.DeviceSettings.l_grooveexe98)
        $complexDeviceSettings.Add('L_outlookexe106', $policySettings.DeviceSettings.l_outlookexe106)
        $complexDeviceSettings.Add('L_RestrictActiveXInstall', $policySettings.DeviceSettings.l_RestrictActiveXInstall)
        $complexDeviceSettings.Add('L_mse7exe', $policySettings.DeviceSettings.l_mse7exe)
        $complexDeviceSettings.Add('L_powerpntexe', $policySettings.DeviceSettings.l_powerpntexe)
        $complexDeviceSettings.Add('L_spDesignexe', $policySettings.DeviceSettings.l_spDesignexe)
        $complexDeviceSettings.Add('L_onenoteexe', $policySettings.DeviceSettings.l_onenoteexe)
        $complexDeviceSettings.Add('L_excelexe', $policySettings.DeviceSettings.l_excelexe)
        $complexDeviceSettings.Add('L_mspubexe', $policySettings.DeviceSettings.l_mspubexe)
        $complexDeviceSettings.Add('L_visioexe', $policySettings.DeviceSettings.l_visioexe)
        $complexDeviceSettings.Add('L_exprwdexe', $policySettings.DeviceSettings.l_exprwdexe)
        $complexDeviceSettings.Add('L_outlookexe', $policySettings.DeviceSettings.l_outlookexe)
        $complexDeviceSettings.Add('L_pptviewexe', $policySettings.DeviceSettings.l_pptviewexe)
        $complexDeviceSettings.Add('L_winprojexe', $policySettings.DeviceSettings.l_winprojexe)
        $complexDeviceSettings.Add('L_winwordexe', $policySettings.DeviceSettings.l_winwordexe)
        $complexDeviceSettings.Add('L_grooveexe', $policySettings.DeviceSettings.l_grooveexe)
        $complexDeviceSettings.Add('L_msaccessexe', $policySettings.DeviceSettings.l_msaccessexe)
        $complexDeviceSettings.Add('L_RestrictFileDownload', $policySettings.DeviceSettings.l_RestrictFileDownload)
        $complexDeviceSettings.Add('L_visioexe5', $policySettings.DeviceSettings.l_visioexe5)
        $complexDeviceSettings.Add('L_winprojexe6', $policySettings.DeviceSettings.l_winprojexe6)
        $complexDeviceSettings.Add('L_msaccessexe11', $policySettings.DeviceSettings.l_msaccessexe11)
        $complexDeviceSettings.Add('L_spdesignexe9', $policySettings.DeviceSettings.l_spdesignexe9)
        $complexDeviceSettings.Add('L_excelexe1', $policySettings.DeviceSettings.l_excelexe1)
        $complexDeviceSettings.Add('L_powerpntexe3', $policySettings.DeviceSettings.l_powerpntexe3)
        $complexDeviceSettings.Add('L_mspubexe2', $policySettings.DeviceSettings.l_mspubexe2)
        $complexDeviceSettings.Add('L_exprwdexe10', $policySettings.DeviceSettings.l_exprwdexe10)
        $complexDeviceSettings.Add('L_outlookexe8', $policySettings.DeviceSettings.l_outlookexe8)
        $complexDeviceSettings.Add('L_pptviewexe4', $policySettings.DeviceSettings.l_pptviewexe4)
        $complexDeviceSettings.Add('L_winwordexe7', $policySettings.DeviceSettings.l_winwordexe7)
        $complexDeviceSettings.Add('L_onenoteexe12', $policySettings.DeviceSettings.l_onenoteexe12)
        $complexDeviceSettings.Add('L_mse7exe13', $policySettings.DeviceSettings.l_mse7exe13)
        $complexDeviceSettings.Add('L_grooveexe0', $policySettings.DeviceSettings.l_grooveexe0)
        $complexDeviceSettings.Add('L_SavedfromURL', $policySettings.DeviceSettings.l_SavedfromURL)
        $complexDeviceSettings.Add('L_pptviewexe158', $policySettings.DeviceSettings.l_pptviewexe158)
        $complexDeviceSettings.Add('L_exprwdexe164', $policySettings.DeviceSettings.l_exprwdexe164)
        $complexDeviceSettings.Add('L_mse7exe167', $policySettings.DeviceSettings.l_mse7exe167)
        $complexDeviceSettings.Add('L_spdesignexe163', $policySettings.DeviceSettings.l_spdesignexe163)
        $complexDeviceSettings.Add('L_winprojexe160', $policySettings.DeviceSettings.l_winprojexe160)
        $complexDeviceSettings.Add('L_mspubexe156', $policySettings.DeviceSettings.l_mspubexe156)
        $complexDeviceSettings.Add('L_visioexe159', $policySettings.DeviceSettings.l_visioexe159)
        $complexDeviceSettings.Add('L_winwordexe161', $policySettings.DeviceSettings.l_winwordexe161)
        $complexDeviceSettings.Add('L_msaccessexe165', $policySettings.DeviceSettings.l_msaccessexe165)
        $complexDeviceSettings.Add('L_onenoteexe166', $policySettings.DeviceSettings.l_onenoteexe166)
        $complexDeviceSettings.Add('L_outlookexe162', $policySettings.DeviceSettings.l_outlookexe162)
        $complexDeviceSettings.Add('L_grooveexe154', $policySettings.DeviceSettings.l_grooveexe154)
        $complexDeviceSettings.Add('L_excelexe155', $policySettings.DeviceSettings.l_excelexe155)
        $complexDeviceSettings.Add('L_powerpntexe157', $policySettings.DeviceSettings.l_powerpntexe157)
        $complexDeviceSettings.Add('L_ScriptedWindowSecurityRestrictions', $policySettings.DeviceSettings.l_ScriptedWindowSecurityRestrictions)
        $complexDeviceSettings.Add('L_exprwdexe94', $policySettings.DeviceSettings.l_exprwdexe94)
        $complexDeviceSettings.Add('L_mse7exe97', $policySettings.DeviceSettings.l_mse7exe97)
        $complexDeviceSettings.Add('L_mspubexe86', $policySettings.DeviceSettings.l_mspubexe86)
        $complexDeviceSettings.Add('L_outlookexe92', $policySettings.DeviceSettings.l_outlookexe92)
        $complexDeviceSettings.Add('L_msaccessexe95', $policySettings.DeviceSettings.l_msaccessexe95)
        $complexDeviceSettings.Add('L_powerpntexe87', $policySettings.DeviceSettings.l_powerpntexe87)
        $complexDeviceSettings.Add('L_grooveexe84', $policySettings.DeviceSettings.l_grooveexe84)
        $complexDeviceSettings.Add('L_excelexe85', $policySettings.DeviceSettings.l_excelexe85)
        $complexDeviceSettings.Add('L_pptviewexe88', $policySettings.DeviceSettings.l_pptviewexe88)
        $complexDeviceSettings.Add('L_spdesignexe93', $policySettings.DeviceSettings.l_spdesignexe93)
        $complexDeviceSettings.Add('L_visioexe89', $policySettings.DeviceSettings.l_visioexe89)
        $complexDeviceSettings.Add('L_onenoteexe96', $policySettings.DeviceSettings.l_onenoteexe96)
        $complexDeviceSettings.Add('L_winprojexe90', $policySettings.DeviceSettings.l_winprojexe90)
        $complexDeviceSettings.Add('L_winwordexe91', $policySettings.DeviceSettings.l_winwordexe91)
        if ($complexDeviceSettings.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexDeviceSettings = $null
        }
        $policySettings.Remove('DeviceSettings') | Out-Null

        $complexUserSettings = @{}
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftAccess_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftAccess_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftAccess_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftAccess_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork)
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftAccess_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('MicrosoftAccess_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty', $policySettings.UserSettings.microsoftAccess_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty)
        $complexUserSettings.Add('L_Donotshowdataextractionoptionswhenopeningcorruptworkbooks', $policySettings.UserSettings.l_Donotshowdataextractionoptionswhenopeningcorruptworkbooks)
        $complexUserSettings.Add('L_Asktoupdateautomaticlinks', $policySettings.UserSettings.l_Asktoupdateautomaticlinks)
        $complexUserSettings.Add('L_LoadpicturesfromWebpagesnotcreatedinExcel', $policySettings.UserSettings.l_LoadpicturesfromWebpagesnotcreatedinExcel)
        $complexUserSettings.Add('L_DisableAutoRepublish', $policySettings.UserSettings.l_DisableAutoRepublish)
        $complexUserSettings.Add('L_DoNotShowAutoRepublishWarningAlert', $policySettings.UserSettings.l_DoNotShowAutoRepublishWarningAlert)
        $complexUserSettings.Add('L_Forcefileextenstionstomatch', $policySettings.UserSettings.l_Forcefileextenstionstomatch)
        $complexUserSettings.Add('L_Forcefileextenstionstomatch_L_Empty', $policySettings.UserSettings.l_Forcefileextenstionstomatch_L_Empty)
        $complexUserSettings.Add('L_DeterminewhethertoforceencryptedExcel', $policySettings.UserSettings.l_DeterminewhethertoforceencryptedExcel)
        $complexUserSettings.Add('L_DeterminewhethertoforceencryptedExcelDropID', $policySettings.UserSettings.l_DeterminewhethertoforceencryptedExcelDropID)
        $complexUserSettings.Add('L_BlockXLLFromInternet', $policySettings.UserSettings.l_BlockXLLFromInternet)
        $complexUserSettings.Add('L_BlockXLLFromInternetEnum', $policySettings.UserSettings.l_BlockXLLFromInternetEnum)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftExcel_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('L_EnableBlockUnsecureQueryFiles', $policySettings.UserSettings.l_EnableBlockUnsecureQueryFiles)
        $complexUserSettings.Add('L_DBaseIIIANDIVFiles', $policySettings.UserSettings.l_DBaseIIIANDIVFiles)
        $complexUserSettings.Add('L_DBaseIIIANDIVFilesDropID', $policySettings.UserSettings.l_DBaseIIIANDIVFilesDropID)
        $complexUserSettings.Add('L_DifAndSylkFiles', $policySettings.UserSettings.l_DifAndSylkFiles)
        $complexUserSettings.Add('L_DifAndSylkFilesDropID', $policySettings.UserSettings.l_DifAndSylkFilesDropID)
        $complexUserSettings.Add('L_Excel2MacrosheetsAndAddInFiles', $policySettings.UserSettings.l_Excel2MacrosheetsAndAddInFiles)
        $complexUserSettings.Add('L_Excel2MacrosheetsAndAddInFilesDropID', $policySettings.UserSettings.l_Excel2MacrosheetsAndAddInFilesDropID)
        $complexUserSettings.Add('L_Excel2Worksheets', $policySettings.UserSettings.l_Excel2Worksheets)
        $complexUserSettings.Add('L_Excel2WorksheetsDropID', $policySettings.UserSettings.l_Excel2WorksheetsDropID)
        $complexUserSettings.Add('L_Excel3MacrosheetsAndAddInFiles', $policySettings.UserSettings.l_Excel3MacrosheetsAndAddInFiles)
        $complexUserSettings.Add('L_Excel3MacrosheetsAndAddInFilesDropID', $policySettings.UserSettings.l_Excel3MacrosheetsAndAddInFilesDropID)
        $complexUserSettings.Add('L_Excel3Worksheets', $policySettings.UserSettings.l_Excel3Worksheets)
        $complexUserSettings.Add('L_Excel3WorksheetsDropID', $policySettings.UserSettings.l_Excel3WorksheetsDropID)
        $complexUserSettings.Add('L_Excel4MacrosheetsAndAddInFiles', $policySettings.UserSettings.l_Excel4MacrosheetsAndAddInFiles)
        $complexUserSettings.Add('L_Excel4MacrosheetsAndAddInFilesDropID', $policySettings.UserSettings.l_Excel4MacrosheetsAndAddInFilesDropID)
        $complexUserSettings.Add('L_Excel4Workbooks', $policySettings.UserSettings.l_Excel4Workbooks)
        $complexUserSettings.Add('L_Excel4WorkbooksDropID', $policySettings.UserSettings.l_Excel4WorkbooksDropID)
        $complexUserSettings.Add('L_Excel4Worksheets', $policySettings.UserSettings.l_Excel4Worksheets)
        $complexUserSettings.Add('L_Excel4WorksheetsDropID', $policySettings.UserSettings.l_Excel4WorksheetsDropID)
        $complexUserSettings.Add('L_Excel95Workbooks', $policySettings.UserSettings.l_Excel95Workbooks)
        $complexUserSettings.Add('L_Excel95WorkbooksDropID', $policySettings.UserSettings.l_Excel95WorkbooksDropID)
        $complexUserSettings.Add('L_Excel9597WorkbooksAndTemplates', $policySettings.UserSettings.l_Excel9597WorkbooksAndTemplates)
        $complexUserSettings.Add('L_Excel9597WorkbooksAndTemplatesDropID', $policySettings.UserSettings.l_Excel9597WorkbooksAndTemplatesDropID)
        $complexUserSettings.Add('L_Excel972003WorkbooksAndTemplates', $policySettings.UserSettings.l_Excel972003WorkbooksAndTemplates)
        $complexUserSettings.Add('L_Excel972003WorkbooksAndTemplatesDropID', $policySettings.UserSettings.l_Excel972003WorkbooksAndTemplatesDropID)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID)
        $complexUserSettings.Add('L_WebPagesAndExcel2003XMLSpreadsheets', $policySettings.UserSettings.l_WebPagesAndExcel2003XMLSpreadsheets)
        $complexUserSettings.Add('L_WebPagesAndExcel2003XMLSpreadsheetsDropID', $policySettings.UserSettings.l_WebPagesAndExcel2003XMLSpreadsheetsDropID)
        $complexUserSettings.Add('L_XL4KillSwitchPolicy', $policySettings.UserSettings.l_XL4KillSwitchPolicy)
        $complexUserSettings.Add('L_EnableDataBaseFileProtectedView', $policySettings.UserSettings.l_EnableDataBaseFileProtectedView)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftExcel_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftExcel_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftExcel_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork)
        $complexUserSettings.Add('MicrosoftExcel_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftExcel_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('L_empty4', $policySettings.UserSettings.l_empty4)
        $complexUserSettings.Add('MicrosoftExcel_Security_L_TurnOffFileValidation', $policySettings.UserSettings.microsoftExcel_Security_L_TurnOffFileValidation)
        $complexUserSettings.Add('L_WebContentWarningLevel', $policySettings.UserSettings.l_WebContentWarningLevel)
        $complexUserSettings.Add('L_WebContentWarningLevelValue', $policySettings.UserSettings.l_WebContentWarningLevelValue)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicy', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicy)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyWord', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyWord)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyExcel', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyExcel)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyVisio', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyVisio)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyPowerPoint', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyPowerPoint)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyPublisher', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyPublisher)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyOutlook', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyOutlook)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyProject', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyProject)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyAccess', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyAccess)
        $complexUserSettings.Add('L_NoExtensibilityCustomizationFromDocumentPolicyInfoPath', $policySettings.UserSettings.l_NoExtensibilityCustomizationFromDocumentPolicyInfoPath)
        $complexUserSettings.Add('L_ActiveXControlInitialization', $policySettings.UserSettings.l_ActiveXControlInitialization)
        $complexUserSettings.Add('L_ActiveXControlInitializationcolon', $policySettings.UserSettings.l_ActiveXControlInitializationcolon)
        $complexUserSettings.Add('L_BasicAuthProxyBehavior', $policySettings.UserSettings.l_BasicAuthProxyBehavior)
        $complexUserSettings.Add('L_AllowVbaIntranetRefs', $policySettings.UserSettings.l_AllowVbaIntranetRefs)
        $complexUserSettings.Add('L_AutomationSecurity', $policySettings.UserSettings.l_AutomationSecurity)
        $complexUserSettings.Add('L_SettheAutomationSecuritylevel', $policySettings.UserSettings.l_SettheAutomationSecuritylevel)
        $complexUserSettings.Add('L_AuthenticationFBABehavior', $policySettings.UserSettings.l_AuthenticationFBABehavior)
        $complexUserSettings.Add('L_AuthenticationFBAEnabledHostsID', $policySettings.UserSettings.l_AuthenticationFBAEnabledHostsID)
        $complexUserSettings.Add('L_authenticationFBABehaviorEnum', $policySettings.UserSettings.l_authenticationFBABehaviorEnum)
        $complexUserSettings.Add('L_DisableStrictVbaRefsSecurityPolicy', $policySettings.UserSettings.l_DisableStrictVbaRefsSecurityPolicy)
        $complexUserSettings.Add('L_DisableallTrustBarnotificationsfor', $policySettings.UserSettings.l_DisableallTrustBarnotificationsfor)
        $complexUserSettings.Add('L_Encryptiontypeforirm', $policySettings.UserSettings.l_Encryptiontypeforirm)
        $complexUserSettings.Add('L_Encryptiontypeforirmcolon', $policySettings.UserSettings.l_Encryptiontypeforirmcolon)
        $complexUserSettings.Add('L_Encryptiontypeforpasswordprotectedoffice972003', $policySettings.UserSettings.l_Encryptiontypeforpasswordprotectedoffice972003)
        $complexUserSettings.Add('L_encryptiontypecolon318', $policySettings.UserSettings.l_encryptiontypecolon318)
        $complexUserSettings.Add('L_Encryptiontypeforpasswordprotectedofficeopen', $policySettings.UserSettings.l_Encryptiontypeforpasswordprotectedofficeopen)
        $complexUserSettings.Add('L_Encryptiontypecolon', $policySettings.UserSettings.l_Encryptiontypecolon)
        $complexUserSettings.Add('L_LoadControlsinForms3', $policySettings.UserSettings.l_LoadControlsinForms3)
        $complexUserSettings.Add('L_LoadControlsinForms3colon', $policySettings.UserSettings.l_LoadControlsinForms3colon)
        $complexUserSettings.Add('L_MacroRuntimeScanScope', $policySettings.UserSettings.l_MacroRuntimeScanScope)
        $complexUserSettings.Add('L_MacroRuntimeScanScopeEnum', $policySettings.UserSettings.l_MacroRuntimeScanScopeEnum)
        $complexUserSettings.Add('L_Protectdocumentmetadataforrightsmanaged', $policySettings.UserSettings.l_Protectdocumentmetadataforrightsmanaged)
        $complexUserSettings.Add('L_Allowmixofpolicyanduserlocations', $policySettings.UserSettings.l_Allowmixofpolicyanduserlocations)
        $complexUserSettings.Add('L_DisabletheOfficeclientfrompolling', $policySettings.UserSettings.l_DisabletheOfficeclientfrompolling)
        $complexUserSettings.Add('L_DisableSmartDocumentsuseofmanifests', $policySettings.UserSettings.l_DisableSmartDocumentsuseofmanifests)
        $complexUserSettings.Add('L_OutlookSecurityMode', $policySettings.UserSettings.l_OutlookSecurityMode)
        $complexUserSettings.Add('L_OOMAddressAccess', $policySettings.UserSettings.l_OOMAddressAccess)
        $complexUserSettings.Add('L_OOMAddressAccess_Setting', $policySettings.UserSettings.l_OOMAddressAccess_Setting)
        $complexUserSettings.Add('L_OOMMeetingTaskRequest', $policySettings.UserSettings.l_OOMMeetingTaskRequest)
        $complexUserSettings.Add('L_OOMMeetingTaskRequest_Setting', $policySettings.UserSettings.l_OOMMeetingTaskRequest_Setting)
        $complexUserSettings.Add('L_OOMSend', $policySettings.UserSettings.l_OOMSend)
        $complexUserSettings.Add('L_OOMSend_Setting', $policySettings.UserSettings.l_OOMSend_Setting)
        $complexUserSettings.Add('L_Preventusersfromcustomizingattachmentsecuritysettings', $policySettings.UserSettings.l_Preventusersfromcustomizingattachmentsecuritysettings)
        $complexUserSettings.Add('L_RetrievingCRLsCertificateRevocationLists', $policySettings.UserSettings.l_RetrievingCRLsCertificateRevocationLists)
        $complexUserSettings.Add('L_empty31', $policySettings.UserSettings.l_empty31)
        $complexUserSettings.Add('L_OOMFormula', $policySettings.UserSettings.l_OOMFormula)
        $complexUserSettings.Add('L_OOMFormula_Setting', $policySettings.UserSettings.l_OOMFormula_Setting)
        $complexUserSettings.Add('L_AuthenticationwithExchangeServer', $policySettings.UserSettings.l_AuthenticationwithExchangeServer)
        $complexUserSettings.Add('L_SelecttheauthenticationwithExchangeserver', $policySettings.UserSettings.l_SelecttheauthenticationwithExchangeserver)
        $complexUserSettings.Add('L_EnableRPCEncryption', $policySettings.UserSettings.l_EnableRPCEncryption)
        $complexUserSettings.Add('L_Enablelinksinemailmessages', $policySettings.UserSettings.l_Enablelinksinemailmessages)
        $complexUserSettings.Add('L_OOMAddressBook', $policySettings.UserSettings.l_OOMAddressBook)
        $complexUserSettings.Add('L_OOMAddressBook_Setting', $policySettings.UserSettings.l_OOMAddressBook_Setting)
        $complexUserSettings.Add('L_OutlookSecurityPolicy', $policySettings.UserSettings.l_OutlookSecurityPolicy)
        $complexUserSettings.Add('L_AllowUsersToLowerAttachments', $policySettings.UserSettings.l_AllowUsersToLowerAttachments)
        $complexUserSettings.Add('L_AllowActiveXOneOffForms', $policySettings.UserSettings.l_AllowActiveXOneOffForms)
        $complexUserSettings.Add('L_empty29', $policySettings.UserSettings.l_empty29)
        $complexUserSettings.Add('L_EnableScriptsInOneOffForms', $policySettings.UserSettings.l_EnableScriptsInOneOffForms)
        $complexUserSettings.Add('L_Level2RemoveFilePolicy', $policySettings.UserSettings.l_Level2RemoveFilePolicy)
        $complexUserSettings.Add('L_removedextensions25', $policySettings.UserSettings.l_removedextensions25)
        $complexUserSettings.Add('L_MSGUnicodeformatwhendraggingtofilesystem', $policySettings.UserSettings.l_MSGUnicodeformatwhendraggingtofilesystem)
        $complexUserSettings.Add('L_OnExecuteCustomActionOOM', $policySettings.UserSettings.l_OnExecuteCustomActionOOM)
        $complexUserSettings.Add('L_OnExecuteCustomActionOOM_Setting', $policySettings.UserSettings.l_OnExecuteCustomActionOOM_Setting)
        $complexUserSettings.Add('L_DisableOutlookobjectmodelscriptsforpublicfolders', $policySettings.UserSettings.l_DisableOutlookobjectmodelscriptsforpublicfolders)
        $complexUserSettings.Add('L_BlockInternet', $policySettings.UserSettings.l_BlockInternet)
        $complexUserSettings.Add('L_SecurityLevelOutlook', $policySettings.UserSettings.l_SecurityLevelOutlook)
        $complexUserSettings.Add('L_SecurityLevel', $policySettings.UserSettings.l_SecurityLevel)
        $complexUserSettings.Add('L_Level1RemoveFilePolicy', $policySettings.UserSettings.l_Level1RemoveFilePolicy)
        $complexUserSettings.Add('L_RemovedExtensions', $policySettings.UserSettings.l_RemovedExtensions)
        $complexUserSettings.Add('L_SignatureWarning', $policySettings.UserSettings.l_SignatureWarning)
        $complexUserSettings.Add('L_signaturewarning30', $policySettings.UserSettings.l_signaturewarning30)
        $complexUserSettings.Add('L_Level1Attachments', $policySettings.UserSettings.l_Level1Attachments)
        $complexUserSettings.Add('L_Minimumencryptionsettings', $policySettings.UserSettings.l_Minimumencryptionsettings)
        $complexUserSettings.Add('L_Minimumkeysizeinbits', $policySettings.UserSettings.l_Minimumkeysizeinbits)
        $complexUserSettings.Add('L_DisableOutlookobjectmodelscripts', $policySettings.UserSettings.l_DisableOutlookobjectmodelscripts)
        $complexUserSettings.Add('L_OOMSaveAs', $policySettings.UserSettings.l_OOMSaveAs)
        $complexUserSettings.Add('L_OOMSaveAs_Setting', $policySettings.UserSettings.l_OOMSaveAs_Setting)
        $complexUserSettings.Add('L_JunkEmailprotectionlevel', $policySettings.UserSettings.l_JunkEmailprotectionlevel)
        $complexUserSettings.Add('L_Selectlevel', $policySettings.UserSettings.l_Selectlevel)
        $complexUserSettings.Add('L_RunPrograms', $policySettings.UserSettings.l_RunPrograms)
        $complexUserSettings.Add('L_RunPrograms_L_Empty', $policySettings.UserSettings.l_RunPrograms_L_Empty)
        $complexUserSettings.Add('L_Determinewhethertoforceencryptedppt', $policySettings.UserSettings.l_Determinewhethertoforceencryptedppt)
        $complexUserSettings.Add('L_DeterminewhethertoforceencryptedpptDropID', $policySettings.UserSettings.l_DeterminewhethertoforceencryptedpptDropID)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('L_PowerPoint972003PresentationsShowsTemplatesandAddInFiles', $policySettings.UserSettings.l_PowerPoint972003PresentationsShowsTemplatesandAddInFiles)
        $complexUserSettings.Add('L_PowerPoint972003PresentationsShowsTemplatesandAddInFilesDropID', $policySettings.UserSettings.l_PowerPoint972003PresentationsShowsTemplatesandAddInFilesDropID)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftPowerPoint_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('L_empty3', $policySettings.UserSettings.l_empty3)
        $complexUserSettings.Add('MicrosoftPowerPoint_Security_L_TurnOffFileValidation', $policySettings.UserSettings.microsoftPowerPoint_Security_L_TurnOffFileValidation)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('MicrosoftProject_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty', $policySettings.UserSettings.microsoftProject_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty)
        $complexUserSettings.Add('L_PublisherAutomationSecurityLevel', $policySettings.UserSettings.l_PublisherAutomationSecurityLevel)
        $complexUserSettings.Add('L_PublisherAutomationSecurityLevel_L_Empty', $policySettings.UserSettings.l_PublisherAutomationSecurityLevel_L_Empty)
        $complexUserSettings.Add('MicrosoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftPublisherV3_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('MicrosoftPublisherV2_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftPublisherV2_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftPublisherV2_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('MicrosoftPublisherV2_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftPublisherV2_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('L_empty0', $policySettings.UserSettings.l_empty0)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_AllowTrustedLocationsOnTheNetwork)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('L_Visio2000Files', $policySettings.UserSettings.l_Visio2000Files)
        $complexUserSettings.Add('L_Visio2000FilesDropID', $policySettings.UserSettings.l_Visio2000FilesDropID)
        $complexUserSettings.Add('L_Visio2003Files', $policySettings.UserSettings.l_Visio2003Files)
        $complexUserSettings.Add('L_Visio2003FilesDropID', $policySettings.UserSettings.l_Visio2003FilesDropID)
        $complexUserSettings.Add('L_Visio50AndEarlierFiles', $policySettings.UserSettings.l_Visio50AndEarlierFiles)
        $complexUserSettings.Add('L_Visio50AndEarlierFilesDropID', $policySettings.UserSettings.l_Visio50AndEarlierFilesDropID)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('MicrosoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty', $policySettings.UserSettings.microsoftVisio_Security_TrustCenter_L_VBAWarningsPolicy_L_Empty)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenter_L_BlockMacroExecutionFromInternet', $policySettings.UserSettings.microsoftWord_Security_TrustCenter_L_BlockMacroExecutionFromInternet)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned', $policySettings.UserSettings.microsoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned)
        $complexUserSettings.Add('L_AllowDDE', $policySettings.UserSettings.l_AllowDDE)
        $complexUserSettings.Add('L_AllowDDEDropID', $policySettings.UserSettings.l_AllowDDEDropID)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior', $policySettings.UserSettings.microsoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehavior)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID', $policySettings.UserSettings.microsoftWord_Security_TrustCenterFileBlockSettings_L_SetDefaultFileBlockBehaviorDropID)
        $complexUserSettings.Add('L_Word2AndEarlierBinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word2AndEarlierBinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word2AndEarlierBinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word2AndEarlierBinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word2000BinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word2000BinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word2000BinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word2000BinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word2003BinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word2003BinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word2003BinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word2003BinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word2007AndLaterBinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word2007AndLaterBinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word2007AndLaterBinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word2007AndLaterBinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word6Pt0BinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word6Pt0BinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word6Pt0BinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word6Pt0BinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word95BinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word95BinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word95BinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word95BinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_Word97BinaryDocumentsAndTemplates', $policySettings.UserSettings.l_Word97BinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_Word97BinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_Word97BinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('L_WordXPBinaryDocumentsAndTemplates', $policySettings.UserSettings.l_WordXPBinaryDocumentsAndTemplates)
        $complexUserSettings.Add('L_WordXPBinaryDocumentsAndTemplatesDropID', $policySettings.UserSettings.l_WordXPBinaryDocumentsAndTemplatesDropID)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesFromTheInternetZoneInProtectedView)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_DoNotOpenFilesInUnsafeLocationsInProtectedView)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFails)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsDropID)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_SetDocumentBehaviorIfFileValidationFailsStr3)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook', $policySettings.UserSettings.microsoftWord_Security_TrustCenterProtectedView_L_TurnOffProtectedViewForAttachmentsOpenedFromOutlook)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned', $policySettings.UserSettings.microsoftWord_Security_TrustCenter_L_RequirethatApplicationExtensionsaresigned)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2', $policySettings.UserSettings.microsoftWord_Security_TrustCenter_L_DisableTrustBarNotificationforunsigned_v2)
        $complexUserSettings.Add('L_DeterminewhethertoforceencryptedWord', $policySettings.UserSettings.l_DeterminewhethertoforceencryptedWord)
        $complexUserSettings.Add('L_DeterminewhethertoforceencryptedWordDropID', $policySettings.UserSettings.l_DeterminewhethertoforceencryptedWordDropID)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenter_L_VBAWarningsPolicy', $policySettings.UserSettings.microsoftWord_Security_TrustCenter_L_VBAWarningsPolicy)
        $complexUserSettings.Add('L_empty19', $policySettings.UserSettings.l_empty19)
        $complexUserSettings.Add('MicrosoftWord_Security_L_TurnOffFileValidation', $policySettings.UserSettings.microsoftWord_Security_L_TurnOffFileValidation)
        $complexUserSettings.Add('MicrosoftWord_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork', $policySettings.UserSettings.microsoftWord_Security_TrustCenterTrustedLocations_L_AllowTrustedLocationsOnTheNetwork)
        if ($complexUserSettings.values.Where({$null -ne $_}).Count -eq 0)
        {
            $complexUserSettings = $null
        }
        $policySettings.Remove('UserSettings') | Out-Null
        #endregion

        $results = @{
            #region resource generator code
            Description           = $getValue.Description
            DisplayName           = $getValue.Name
            RoleScopeTagIds       = $getValue.RoleScopeTagIds
            Id                    = $getValue.Id
            DeviceSettings        = $complexDeviceSettings
            UserSettings          = $complexUserSettings
            Ensure                = 'Present'
            Credential            = $Credential
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificateThumbprint = $CertificateThumbprint
            ManagedIdentity       = $ManagedIdentity.IsPresent
            #endregion
        }
        $results += $policySettings

        $assignmentsValues = Get-MgBetaDeviceManagementConfigurationPolicyAssignment -DeviceManagementConfigurationPolicyId $Id
        $assignmentResult = @()
        if ($assignmentsValues.Count -gt 0)
        {
            $assignmentResult += ConvertFrom-IntunePolicyAssignment -Assignments $assignmentsValues -IncludeDeviceFilter $true
        }
        $results.Add('Assignments', $assignmentResult)

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
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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

    $templateReferenceId = '90316f12-246d-44c6-a767-f87692e86083_2'
    $platforms = 'windows10'
    $technologies = 'mdm'

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Intune Security Baseline Microsoft365 Apps For Enterprise with Name {$DisplayName}"
        $BoundParameters.Remove("Assignments") | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId `
            -ContainsDeviceAndUserSettings

        $createParameters = @{
            Name              = $DisplayName
            Description       = $Description
            TemplateReference = @{ templateId = $templateReferenceId }
            Platforms         = $platforms
            Technologies      = $technologies
            Settings          = $settings
        }

        #region resource generator code
        $policy = New-MgBetaDeviceManagementConfigurationPolicy -BodyParameter $createParameters

        if ($policy.Id)
        {
            $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
            Update-DeviceConfigurationPolicyAssignment `
                -DeviceConfigurationPolicyId $policy.Id `
                -Targets $assignmentsHash `
                -Repository 'deviceManagement/configurationPolicies'
        }
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Intune Security Baseline Microsoft365 Apps For Enterprise with Id {$($currentInstance.Id)}"
        $BoundParameters.Remove("Assignments") | Out-Null

        $settings = Get-IntuneSettingCatalogPolicySetting `
            -DSCParams ([System.Collections.Hashtable]$BoundParameters) `
            -TemplateId $templateReferenceId `
            -ContainsDeviceAndUserSettings

        Update-IntuneDeviceConfigurationPolicy `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Name $DisplayName `
            -Description $Description `
            -TemplateReferenceId $templateReferenceId `
            -Platforms $platforms `
            -Technologies $technologies `
            -Settings $settings

        #region resource generator code
        $assignmentsHash = ConvertTo-IntunePolicyAssignment -IncludeDeviceFilter:$true -Assignments $Assignments
        Update-DeviceConfigurationPolicyAssignment `
            -DeviceConfigurationPolicyId $currentInstance.Id `
            -Targets $assignmentsHash `
            -Repository 'deviceManagement/configurationPolicies'
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Intune Security Baseline Microsoft365 Apps For Enterprise with Id {$($currentInstance.Id)}"
        #region resource generator code
        Remove-MgBetaDeviceManagementConfigurationPolicy -DeviceManagementConfigurationPolicyId $currentInstance.Id
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
        [Parameter()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String[]]
        $RoleScopeTagIds,

        [Parameter()]
        [System.String]
        $Id,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $DeviceSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $UserSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Assignments,
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

    Write-Verbose -Message "Testing configuration of the Intune Security Baseline Microsoft365 Apps For Enterprise with Id {$Id} and Name {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    [Hashtable]$ValuesToCheck = @{}
    $MyInvocation.MyCommand.Parameters.GetEnumerator() | ForEach-Object {
        if ($_.Key -notlike '*Variable' -or $_.Key -notin @('Verbose', 'Debug', 'ErrorAction', 'WarningAction', 'InformationAction'))
        {
            if ($null -ne $CurrentValues[$_.Key] -or $null -ne $PSBoundParameters[$_.Key])
            {
                $ValuesToCheck.Add($_.Key, $null)
                if (-not $PSBoundParameters.ContainsKey($_.Key))
                {
                    $PSBoundParameters.Add($_.Key, $null)
                }
            }
        }
    }

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
                Write-Verbose "$key is different"
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $ValuesToCheck.Remove('Id') | Out-Null
    $ValuesToCheck = Remove-M365DSCAuthenticationParameter -BoundParameters $ValuesToCheck

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    if ($testResult)
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
        $policyTemplateID = "90316f12-246d-44c6-a767-f87692e86083_2"
        [array]$getValue = Get-MgBetaDeviceManagementConfigurationPolicy `
            -Filter $Filter `
            -All `
            -ErrorAction Stop | Where-Object `
            -FilterScript {
                $_.TemplateReference.TemplateId -eq $policyTemplateID
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
            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            elseif (-not [string]::IsNullOrEmpty($config.name))
            {
                $displayedKey = $config.name
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                DisplayName = $config.Name
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
            if ($null -ne $Results.DeviceSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.DeviceSettings `
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogDeviceSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.DeviceSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('DeviceSettings') | Out-Null
                }
            }
            if ($null -ne $Results.UserSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.UserSettings `
                    -CIMInstanceName 'MicrosoftGraphIntuneSettingsCatalogUserSettings_IntuneSecurityBaselineMicrosoft365AppsForEnterprise'
                if (-not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.UserSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('UserSettings') | Out-Null
                }
            }

            if ($Results.Assignments)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString -ComplexObject $Results.Assignments -CIMInstanceName DeviceManagementConfigurationPolicyAssignments
                if ($complexTypeStringResult)
                {
                    $Results.Assignments = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Assignments') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.DeviceSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "DeviceSettings" -IsCIMArray:$False
            }
            if ($Results.UserSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "UserSettings" -IsCIMArray:$False
            }

            if ($Results.Assignments)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Assignments" -IsCIMArray:$true
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

Export-ModuleMember -Function *-TargetResource
