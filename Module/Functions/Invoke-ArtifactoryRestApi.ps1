<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Invoke-ArtifactoryRestApi.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

#>



function Invoke-ArtifactoryRestApi {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api calls to Jfrog Artifactory.
        
        Jfrog reference documentation about rest api functionality: 
        https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API

    .DESCRIPTION
        
        
    .INPUTS
        -RestApiPath <string[]>

        -Method <[Get], [Post], [Put], [Delete]>

        -ContentType <string[]>
        
    .OUTPUTS
        Web response content from Jfrog Artifactory api in JSON format

    .NOTES
        
    
    .EXAMPLE
        Invoke-ArtifactoryRestApi -RestApiPath '/api/storageinfo' -Method Get -ContentType 'application/json'    
    
        Invoke-ArtifactoryRestApi -RestApiPath '/docker/dockerimagename/dockertag1.2.3' -Method Delete

    #>

    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $RestApiPath,

        [parameter(Position = 1, Mandatory = $false)]
        [ValidateSet('Get', 'Post', 'Put', 'Delete')]
        [string]
        $Method = 'Get',

        [parameter(Position = 2, Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ContentType = 'application/json'
    )

    $artifactoryParameters = Get-ArtifactoryParameters

    $authString = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($artifactoryParameters.userName):$($artifactoryParameters.userToken)"))

    $InvokeUri = "$($artifactoryParameters.serverUri)$RestApiPath"

    $Headers = @{
        Authorization = "Basic $authString"
        Accept        = $ContentType
    }
  
    $webContent = Invoke-WebRequest -Uri $InvokeUri `
                                    -Headers $Headers `
                                    -Method $Method | Select-Object -ExpandProperty Content | ConvertFrom-Json
    
    return $webContent
}