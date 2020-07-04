<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Get-ArtifactoryStorageInfo.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog ref documentation: https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetStorageSummaryInfo

#>


function Get-ArtifactoryStorageInfo {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api call to jfrog artifactory to get the information about the storage.

    .DESCRIPTION        
        
    .INPUTS

    .OUTPUTS
        Returns storage summary information regarding binaries, file store and repositories in json format.
        
    .NOTES
    
    .EXAMPLE
        

    #>    
    $storageInfo =  Invoke-ArtifactoryRestApi -RestApiPath "/api/storageinfo" `
                                              -Method Get `
                                              -ContentType 'application/json'  | ConvertTo-Json
  
    return $storageInfo
}