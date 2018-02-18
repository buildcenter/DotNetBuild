$payload = '{{ $payload }}'

if ((dir $PWD) -ne $null)
{
	throw "You must run this script in an empty directory!"
}

$dotnetBuildScaffold = Join-Path $env:TEMP -ChildPath 'dotnetbuild-scaffold.zip'
[System.Convert]::FromBase64String($payload) | Set-Content -Path $dotnetBuildScaffold -Encoding Byte
Expand-Archive -Path $dotnetBuildScaffold -DestinationPath $PWD
del $dotnetBuildScaffold

$customProps = @{
	userName = $env:USERNAME
	company = $env:USERNAME
	repoFullName = (Get-Item $PWD).Name
}

$globalBsdContent = (Get-Content ./src/global.bsd -Encoding UTF8) -join [Environment]::NewLine

$customProps.Keys | ForEach-Object {
	$globalBsdContent = $globalBsdContent.Replace('{{ $' + $_ + ' }}', $customProps."$_")
}

$globalBsdContent | Set-Content -Path ./src/global.bsd -Encoding UTF8

Write-Output 'All set. Type "build configure" to create your working folder.'
