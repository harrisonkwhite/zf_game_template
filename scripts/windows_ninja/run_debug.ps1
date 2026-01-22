$ErrorActionPreference = "Stop"

& "$PSScriptRoot\build_debug.ps1"
if ($LASTEXITCODE -ne 0) { exit 1 }

$ExePath = Resolve-Path "$PSScriptRoot\..\..\build\debug\zf_game_template.exe"
$ExeDir  = Split-Path $ExePath -Parent

Push-Location $ExeDir
& $ExePath
Pop-Location
