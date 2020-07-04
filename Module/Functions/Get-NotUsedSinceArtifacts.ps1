<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Get-NotUsedSinceArtifacts.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog ref documentation: https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-ArtifactsNotDownloadedSince

#>


function Get-NotUsedSinceArtifacts {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api call to jfrog artifactory to get the list of artifacts, that has not been used for amount of days.

    .DESCRIPTION
        
        
    .INPUTS
        -Repository <string[]>

        -NotUsedSinceInDays <int[]>

    .OUTPUTS
        Array of objects, containing information about the artifact (artifact uri, downloadCount, lastDownloaded date, remoteDownloadCount, remoteLastDownloaded date)

    .NOTES
        
    
    .EXAMPLE
        Get-NotUsedSinceArtifacts -Repository nuget-prod -NotUsedSinceInDays 90

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

    # Convert required date to Unix Epoch format
    $notUsedSince = [int64]((([datetime]::UtcNow).AddDays(-$NotUsedSinceInDays))-(get-date "1/1/1970")).TotalMilliseconds

    $response = Invoke-ArtifactoryRestApi -RestApiPath "/api/search/usage?notUsedSince=$notUsedSince&repos=$Repository" `
                                          -ContentType 'application/json'
    
    return $response.results
}