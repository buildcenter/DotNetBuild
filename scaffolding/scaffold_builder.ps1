$repoDir = Split-Path $PSScriptRoot -Parent
$payloadDir = Join-Path $repoDir -ChildPath 'temp/payload'
$payloadZip = Join-Path $repoDir -ChildPath 'temp/payload.zip'
$scaffoldTemplate = Join-Path $PSScriptRoot -ChildPath 'scaffold_template.ps1'
$scaffoldOutput = Join-Path $repoDir -ChildPath 'temp/scaffold.ps1'
$scaffoldGlobalBsd = Join-Path $PSScriptRoot -ChildPath 'scaffold_global.bsd'
$scaffoldCsprojectBsd = Join-Path $PSScriptRoot -ChildPath 'csproject.bsd'

if (Test-Path $payloadDir)
{
	throw "Delete $payloadDir folder first!"
}

md $payloadDir

copy $repoDir\build.cmd $payloadDir
copy $repoDir\icon.png $payloadDir
copy $repoDir\.gitignore $payloadDir
copy $repoDir\tools $payloadDir -Recurse
copy $repoDir\src $payloadDir -Recurse

copy $PSScriptRoot\README.md $payloadDir
copy $PSScriptRoot\LICENSE $payloadDir
copy $PSScriptRoot\THIRD-PARTY-LICENSE.txt $payloadDir

copy $scaffoldGlobalBsd "$payloadDir\src\global.bsd" -Force
copy $scaffoldCsprojectBsd "$payloadDir\src\MyFoo.CSharpLib\project.bsd" -Force

del "$payloadDir\src\autobuildver.log"

Compress-Archive -Path "$payloadDir\*" -DestinationPath $payloadZip
$payloadBin = Get-Content $payloadZip -Encoding Byte
$payloadBase64 = [System.Convert]::ToBase64String($payloadBin)
$scaffold = (Get-Content -Path $scaffoldTemplate -Encoding UTF8) -join [Environment]::NewLine
$scaffold.Replace('{{ $payload }}', $payloadBase64) | Set-Content -Path $scaffoldOutput -Encoding UTF8
