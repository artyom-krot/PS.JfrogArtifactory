<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

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
        Information about download statistics for the docker images.
        Docker image layers are stored as separate artifacts within an "image" folder. 
        If a layer is already in most Docker clients, it won’t get downloaded often. 
        So search based on the "manifest.json" file, which is what will be changed only when that specific image/tag are downloaded/used. 
        If a layer is shared between two different tags and if one of the tag is a candidate for the delete in your case above, then the layer will NOT be deleted in the binary storage since it will be still referenced by the other tag.

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