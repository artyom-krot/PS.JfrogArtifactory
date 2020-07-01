<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR Artsiom Krot

.COPYRIGHT (c) 2020 Artsiom Krot

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
        
        Jfrog reference  documentation about used rest api methods: 
        https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API

    .DESCRIPTION
        
        
    .INPUTS
        -RestApiPath <string[]>

        -Method <[Delete], [Get], [Post], [Put]>

        -Headers <hashtable{}>

        -Accept <string[]>
        

    .OUTPUTS
        Web response content from Jfrog Artifactory api in JSON format

    .NOTES
        
    
    .EXAMPLE
        Invoke-ArtifactoryRestApi -RestApiPath "/docker/dockerimagename/dockertag1.2.3" -Method Delete

        Invoke-ArtifactoryRestApi -RestApiPath "/api/storageinfo" -Method Get

    #>

    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $RestApiPath,

        [parameter(Position = 1, Mandatory = $false)]
        [ValidateSet('Delete', 'Get', 'Post', 'Put')]
        [string]
        $Method = 'Get',

        [parameter(Position = 2, Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers = @{},

        [parameter(Position = 3, Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Accept = 'application/json'
    )

    if ($Headers.ContainsKey('Accept')) {
        $Headers.Accept = $Accept
    } 
    else {
        $Headers.Add('Accept', $Accept)
    }

    $artifactory = Get-ArtifactoryParameters

    $authString = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($artifactory.user):$($artifactory.token)"))
    
    $invokeParameters = @{
        Uri     = "$($artifactory.server)$RestApiPath"
        Method  = $Method
        Headers = @{
            Authorization = "Basic $authString"
            Accept        = 'application/json'
        }
    }

    $webResponse = Invoke-WebRequest -UseBasicParsing @invokeParameters | Select-Object -ExpandProperty Content | ConvertFrom-Json
    return $webResponse
}
