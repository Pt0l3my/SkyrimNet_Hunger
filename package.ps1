$ErrorActionPreference = 'Stop'

$ModRoot = $PSScriptRoot
$ModName = Split-Path -Leaf $ModRoot
$Version = (Get-Content (Join-Path $ModRoot 'VERSION') -Raw).Trim()
$ZipPath = Join-Path (Split-Path -Parent $ModRoot) "$ModName-$Version.zip"

$Exclude = @('.claude', '.vscode', '.mcp.json', '.git', '.gitignore', '.gitattributes', 'package.ps1', 'SkyrimSE.code-workspace', 'skyrimse.ppj')

if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }

$items = Get-ChildItem -Path $ModRoot -Force |
    Where-Object { $Exclude -notcontains $_.Name }

Compress-Archive -Path $items.FullName -DestinationPath $ZipPath -Force

Write-Output "Packaged -> $ZipPath"
