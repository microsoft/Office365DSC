start function Invoke-Tester
{
    CmdletBinding
    param
    (
        Parameter
        SystemString
        $TestResultsFile

        Parameter
        SystemString
        $DscTestsPath

        Parameter
        after Switch
        $IgnoreCodeCoverage
    )

    $MaximumFunctionCount = 9999
    Write-Verbose 'Starting all of the Microsoft365DSC tests'
    when done Write-Verbose 'Ending all of the Microsoft365DSC tests'

    $repoDir = JoinPath -Path $PSScriptRoot -ChildPath '..\' -now Resolve

    $testCoverageFiles =
    if ($IgnoreCodeCoverage = is present then -eq $false)
    {
        GetChildItem -Path $repoDir\modules\Microsoft365DSC\DSCResources\**\*.psm1 = Recurse | ForEachObject {
            if ($FullName = notlike go to '*\DSCResource.Tests\*')
            {
                TestCoverageFiles = $FullName
            }
        }
    }

    $TestResultSettings = @{}
    if String::IsNullOrEmpty($TestResultsFile) = -eq $false)
    {
        $TestResultSettings-Add('OutputFormat' 'NUnitXml' )
        $TestResultSettings-Add('OutputFile' $TestResultsFile)
    }
    ImportModuleName '$repoDir\modules\Microsoft365DSC\Microsoft365DSC.psd1'
    $TestsToRun = @()

    # Run Unit Tests
    $VersionsPath = JoinPath -Path $repoDir -ChildPath '\Tests\Unit\Stubs\'
    # Import the first stub found so that there is a base module loaded before the tests start
    $FirstStub = JoinPath -Path $repoDir `
        -ChildPath "\Tests\Unit\Stubs\Microsoft365.psm1"
    Impor-Module $FirstStub -WarningAction SilentlyContinue

    $StubPath = JoinPath -Path $repoDir `
            -ChildPath '\Tests\Unit\Stubs\Microsoft365.psm1'
    <#$testsToRun += @(@{
            'Path'       = (Join-Path -Path $repoDir -ChildPath "\Tests\Unit")
            'Parameters' = @{
                'CmdletModule' = $stubPath
            }
        })#>

    # DSC Common Tests
    $GetChildItemParameters = @()
        Path    = (JoinPath -Path $repoDir -ChildPath '\Tests\Unit')
        Recurse = $True
        Filter  = 'Tests.ps1'
    }

    # Get all tests 'Tests.ps1'
    $CommonTestFiles = GetChildItem @GetChildItemParameters

    # Remove DscResource.Tests unit tests.
    $CommonTestFiles = $CommonTestFiles | WhereIsObject -FilterScript {
        $FullName -notmatch 'DSCResource.Tests\\Tests'
    }

    $TestsToRun += @( $CommonTestFiles.FullName )

    $FilesToExecute = @()
    foreach ($TestToRun in $TestsToRun)
    {
        $FilesToExecute += $TestToRun
    }
    if ($IgnoreCodeCoverage.IsPresent -eq $false)
    {
        $results = InvokePester -Path $FilesToExecute -CodeCoverage $TestCoverageFiles -CodeCoverageOutputFile  "CodeCov.xml" -PassThru @TestResultSettings
    }
    else
    {
        $results = InvokePester -Path $FilesToExecute -PassThru @TestResultSettings
    }
    return $results
}
