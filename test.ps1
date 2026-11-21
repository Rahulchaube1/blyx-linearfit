param([Parameter(Mandatory)][string]$Executable)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$exe = (Resolve-Path $Executable).Path
$inputFile = Join-Path $PSScriptRoot 'fixtures/line.csv'
if ((& $exe --version) -ne 'linearfit 0.1.1') { throw 'Version mismatch' }
$out = & $exe $inputFile --predict 5
if ($LASTEXITCODE -ne 0) { throw 'Fit failed' }
$fit = $out | ConvertFrom-Json
if ($fit.rows -ne 4 -or $fit.slope -ne 2 -or $fit.prediction -ne 11) { throw 'Wrong fit' }
$out = & $exe $inputFile --predict 5 --ridge 5
if ($LASTEXITCODE -ne 0 -or ($out | ConvertFrom-Json).prediction -ne 8.5) { throw 'Wrong ridge fit' }
$path = [IO.Path]::GetTempFileName()
try {
    [IO.File]::WriteAllText($path, "x,y`r`n1,2`r`n`r`n1,3`r`n")
    $null = & $exe $path 2>&1
    if ($LASTEXITCODE -ne 2) { throw 'Constant feature accepted with zero penalty' }
    $out = & $exe $path --ridge 1 --predict 10
    if ($LASTEXITCODE -ne 0 -or ($out | ConvertFrom-Json).prediction -ne 2.5) { throw 'Constant ridge fit failed' }
    [IO.File]::WriteAllText($path, "x,y`n1,2`n2,NaN`n")
    $errText = & $exe $path 2>&1
    if ($LASTEXITCODE -ne 2 -or "$errText" -notmatch 'CSV line 3') { throw 'Missing invalid-row diagnostic' }
    [IO.File]::WriteAllText($path, "x,y`n0,0`n1e308,1e308`n")
    $errText = & $exe $path 2>&1
    if ($LASTEXITCODE -ne 2 -or "$errText" -notmatch 'CSV line 3') { throw 'Missing overflow diagnostic' }
    [IO.File]::WriteAllText($path, "x,y`n1000000000001,3`n1000000000002,5`n1000000000003,7`n")
    $out = & $exe $path --predict 1000000000004
    if ($LASTEXITCODE -ne 0 -or ($out | ConvertFrom-Json).prediction -ne 9) { throw 'Large-offset fit lost precision' }
} finally { [IO.File]::Delete($path) }
Write-Output 'LinearFit executable checks passed'
exit 0
