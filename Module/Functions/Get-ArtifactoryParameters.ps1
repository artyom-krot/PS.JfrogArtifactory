<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

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

    if ([string]::IsNullOrEmpty($script:artifactoryUrl)) {
        Write-Error "Variable artifactoryUrl is not defined. Please use cmdlet Set-ArtifactoryConnection first!'";
        Exit 1
    } 
    elseif ([string]::IsNullOrEmpty($script:artifactoryUser)) {
        Write-Error "Variable artifactoryUser is not defined. Please use cmdlet Set-ArtifactoryConnection first!'";
        Exit 1
    }
    elseif ([string]::IsNullOrEmpty($script:artifactoryUserToken)) {
        Write-Error "Variable  artifactoryUserToken is not defined. Please use cmdlet Set-ArtifactoryConnection first!'";
        Exit 1
    }
    else {
        @{
            serverUri  = $script:artifactoryUrl
            userName   = $script:artifactoryUser
            userToken  = $script:artifactoryUserToken
        }
    }
}