$rootDir = (Get-Location).Path
$pythonDir = Join-Path $rootDir 'python-3.12.9'

if (Test-Path $pythonDir) {
    Remove-Item -LiteralPath $pythonDir -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\agentic") {
    Remove-Item -LiteralPath "$rootDir\agentic" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\config") {
    Remove-Item -LiteralPath "$rootDir\config" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\handlers") {
    Remove-Item -LiteralPath "$rootDir\handlers" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\logs") {
    Remove-Item -LiteralPath "$rootDir\logs" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\resources") {
    Remove-Item -LiteralPath "$rootDir\resources" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\templates") {
    Remove-Item -LiteralPath "$rootDir\templates" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\.gitignore") {
    Remove-Item -LiteralPath "$rootDir\.gitignore" -Force -ErrorAction SilentlyContinue -Confirm:$false
}
if (Test-Path "$rootDir\app.py") {
    Remove-Item -LiteralPath "$rootDir\app.py" -Force -ErrorAction SilentlyContinue -Confirm:$false
}
New-Item -Path $pythonDir -ItemType Directory -Force | Out-Null

Clear-Host
Write-Host "Downloading python312.dll"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/python312/python312.dll' -OutFile "$pythonDir\python312.dll"
Write-Host "Downloading python312.zip"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/python312/python312.zip' -OutFile "$pythonDir\python312.zip"
Write-Host "Downloading libcrypto-3.dll"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/python312/libcrypto-3.dll' -OutFile "$pythonDir\libcrypto-3.dll"
Write-Host "Downloading python-3.12.9.zip"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/python312/python-3.12.9.zip' -OutFile "$rootDir\python-3.12.9.zip"
Expand-Archive -Path "$rootDir\python-3.12.9.zip" -DestinationPath $pythonDir -Force
Remove-Item -LiteralPath "$rootDir\python-3.12.9.zip" -Force -ErrorAction SilentlyContinue -Confirm:$false

Clear-Host
Write-Host "Downloading SoundTech-Release.zip"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/V2.0.0-Windows.zip' -OutFile "$rootDir\SoundTech-Release.zip"
Expand-Archive -Path "$rootDir\SoundTech-Release.zip" -DestinationPath $rootDir -Force
Write-Host "Downloading database.zip"
Remove-Item -LiteralPath "$rootDir\SoundTech-Release.zip" -Force -ErrorAction SilentlyContinue -Confirm:$false
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/database.zip' -OutFile "$rootDir\static\database.zip"
Expand-Archive -Path "$rootDir\static\database.zip" -DestinationPath "$rootDir\static" -Force
Remove-Item -LiteralPath "$rootDir\static\database.zip" -Force -ErrorAction SilentlyContinue -Confirm:$false
Write-Host "Downloading chroma.zip"
Invoke-WebRequest -Uri 'https://gitee.com/dingdust/SoundTech-Release/raw/main/chroma.zip' -OutFile "$rootDir\static\chroma.zip"
Expand-Archive -Path "$rootDir\static\chroma.zip" -DestinationPath "$rootDir\static" -Force
Remove-Item -LiteralPath "$rootDir\static\chroma.zip" -Force -ErrorAction SilentlyContinue -Confirm:$false

Clear-Host
$env:Path = "$pythonDir;$env:Path"
python .\python-3.12.9\get-pip.py --no-warn-script-location
Remove-Item -LiteralPath "$pythonDir\get-pip.py" -Force -ErrorAction SilentlyContinue -Confirm:$false

Clear-Host
$env:Path = "$pythonDir\Scripts;$env:Path"
pip install agentuniverse==0.0.17 --index-url https://mirrors.aliyun.com/pypi/simple/ --no-warn-script-location

Clear-Host
$api_key = Read-Host "Please enter your API key"
Set-Content -Path "$rootDir\config\custom_key.toml" -Encoding ascii -Value @"
[KEY_LIST]
DASHSCOPE_API_KEY='$api_key'
DASHSCOPE_API_BASE='https://dashscope.aliyuncs.com/compatible-mode/v1'
"@

Clear-Host
python app.py