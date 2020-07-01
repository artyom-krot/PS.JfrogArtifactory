<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR Artsiom Krot

.COPYRIGHT (c) 2020 Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Search-ArtifactoryParameters.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

#>

function Search-ArtifactoryParameters {
    [CmdletBinding()]
    param()

    if ([string]::IsNullOrEmpty($script:artifactoryServer)) {
        Write-Error "artifactoryServer variable is not defined. Please use cmdlet Set-ArtifactoryConnection first.'"
        $exit = $false
    } 
    elseif ([string]::IsNullOrEmpty($script:artifactoryUser)) {
        Write-Error "artifactoryUser variable is not defined. Please use cmdlet Set-ArtifactoryConnection first.'"
        $exit = $false
    }
    elseif ([string]::IsNullOrEmpty($script:artifactoryUserToken)) {
        Write-Error "artifactoryUserToken variable is not defined. Please use cmdlet Set-ArtifactoryConnection first.'"
        $exit = $false
    }
    else {
        $exit = $true
    }
    
    return $exit
}