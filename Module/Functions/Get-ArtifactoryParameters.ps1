<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR Artsiom Krot

.COPYRIGHT (c) 2020 Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Get-ArtifactoryParameters.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

#>

function Get-ArtifactoryParameters {
    [CmdletBinding()]
    param()

    if (-Not (Search-ArtifactoryParameters)) {
        Write-Error 'Artifactory credentials could not be found. Please use cmdlet Set-ArtifactoryConnection first.'
        break
    }

    @{
        server = $script:artifactoryServer
        user   = $script:artifactoryUser
        token  = $script:artifactoryUserToken
    }
}