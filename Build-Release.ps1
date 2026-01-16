$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Cleanup/Create release directory
if (Test-Path release) {
    Remove-Item release\* -Recurse -Force
} else {
    New-Item .\release -ItemType Directory | Out-Null
}

## Salty Chat ##

# Create build directory for Salty Chat
if ((Test-Path .\release\saltychat) -eq $false) {
    New-Item .\release\saltychat -ItemType Directory | Out-Null
}

# Build Salty Chat Solution (dotnet msbuild = résolution SDK OK)
$solutionPath = Join-Path $PSScriptRoot "saltychat\SaltyChat-RedM.sln"

$buildOutput = & dotnet msbuild $solutionPath /p:Configuration=Release /m 2>&1
if ($LASTEXITCODE -ne 0) {
    throw ($buildOutput -join [System.Environment]::NewLine)
}

# Copy all necessary items to the release directory
Copy-Item .\saltychat\NUI -Recurse -Destination .\release\saltychat
Copy-Item .\saltychat\config.json -Destination .\release\saltychat
Copy-Item .\saltychat\Newtonsoft.Json.dll -Destination .\release\saltychat
Copy-Item .\saltychat\SaltyClient\bin\Release\SaltyClient.net.dll -Destination .\release\saltychat
Copy-Item .\saltychat\SaltyClient\bin\Release\SaltyClient.net.pdb -Destination .\release\saltychat
Copy-Item .\saltychat\SaltyServer\bin\Release\netstandard2.0\SaltyServer.net.dll -Destination .\release\saltychat
Copy-Item .\saltychat\SaltyServer\bin\Release\netstandard2.0\SaltyServer.net.pdb -Destination .\release\saltychat

# Adjust paths in fxmanifest
$scFxmanifest = Get-Content .\saltychat\fxmanifest.lua
$scFxmanifest = $scFxmanifest -replace 'Salty(Client|Server)\/bin\/Debug\/.*Salty(Client|Server).net.(dll|pdb)', 'Salty$2.net.$3'
$scFxmanifest | Set-Content .\release\saltychat\fxmanifest.lua

# Zip directory which will be used as release on GitHub
Compress-Archive .\release\saltychat\* -DestinationPath .\release\saltychat-redm.zip -CompressionLevel Optimal
