<#

Copyright (c) 2020 Artsiom Krot

Module Name:

    PS.JfrogArtifactory

Description:

    Module provides helper routines which can be used in automation with Jfrog Artifactory.

#>

# export functions
. $PSScriptRoot\Functions\Get-ArtifactoryParameters.ps1
. $PSScriptRoot\Functions\Get-NotUsedSinceArtifacts.ps1
. $PSScriptRoot\Functions\Get-NotUsedSinceDockerImages.ps1
. $PSScriptRoot\Functions\Invoke-ArtifactoryRestApi.ps1
. $PSScriptRoot\Functions\Remove-JfrogArtifact.ps1
. $PSScriptRoot\Functions\Search-ArtifactoryParameters.ps1
. $PSScriptRoot\Functions\Set-ArtifactoryParameters.ps1

Export-ModuleMember -Function *