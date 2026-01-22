$ErrorActionPreference = "Stop"

& "$PSScriptRoot\build_release.ps1"
if ($LASTEXITCODE -ne 0) { exit 1 }

$ExePath = Resolve-Path "$PSScriptRoot\..\..\build\release\zf_game_template.exe"
$ExeDir  = Split-Path $ExePath -Parent

Push-Location $ExeDir
& $ExePath
Pop-Location
