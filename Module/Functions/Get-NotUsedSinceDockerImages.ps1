<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR Artsiom Krot

.COPYRIGHT (c) 2020 Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Get-NotUsedSinceDockerImages.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog ref documentation: https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-ArtifactsNotDownloadedSince

#>


function Get-NotUsedSinceDockerImages {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api call to jfrog artifactory to get the list of docker images, that has not been used for amount of days.

    .DESCRIPTION
        
        
    .INPUTS
        -Repository <string[]>

        -NotUsedSinceInDays <int[]>

    .OUTPUTS
        Information about download statistics for the docker images

    .NOTES
        
    
    .EXAMPLE
        Get-NotUsedSinceDockerImages -Repository docker-prod -NotUsedSinceInDays 90

    #>

    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Repository,

        [parameter(Position = 1, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [int]
        $NotUsedSinceInDays
    )

    $usageData = Get-NotUsedSinceArtifacts @PSBoundParameters
       
    $dockerImagesDownloadStatistic = $usageData | Where-Object {$_.uri -like "*/manifest.json" } `
    | ForEach-Object {

        $searchPattern = '/api/storage/'
        
        $dockerImagePath = ($_.uri.Substring($_.uri.IndexOf($searchPattern))).Replace($searchPattern, '').Replace('/manifest.json', '')

        [pscustomobject]@{
            artifactFullPath  = $dockerImagePath
            lastDownloaded    = $_.lastDownloaded
            downloadCount     = $_.downloadCount
        }
    }

    return $dockerImagesDownloadStatistic
}