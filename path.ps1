$rootDir = Get-Location
$targetDir = "$rootDir\python-3.12.9"

New-Item -Path $targetDir -ItemType Directory

Expand-Archive -Path .\python-3.12.9.zip -DestinationPath $targetDir