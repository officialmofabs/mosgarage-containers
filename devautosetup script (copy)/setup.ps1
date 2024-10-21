#!/bin/pwsh

Install-Module -Name Get-ChildItemColor, oh-my-posh, posh-git, nvm -Force

md ~\.config\powershell
"Set-Theme -name Darkblood" | Out-File $Profile -Append


Install-NodeVersion 8
Install-NodeVersion 10
Install-NodeVersion 11

Remove-Module PSDesiredStateConfiguration -Force
# Set active Node version in PATH to v11
Set-NodeVersion 11

'Remove-Module PSDesiredStateConfiguration -Force' >> $PROFILE
'Set-NodeVersion 11' >> $PROFILE
