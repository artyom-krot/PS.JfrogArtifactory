<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Update-ArtifactoryStorageInfo.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog ref documentation: https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-RefreshStorageSummaryInfo

#>


function Update-ArtifactoryStorageInfo {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api call to jfrog artifactory to refresh the information about the storage.

    .DESCRIPTION        
        
    .INPUTS

    .OUTPUTS
        Refreshes storage summary information regarding binaries, file store and repositories.
        
    .NOTES
    
    .EXAMPLE
        

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [parameter(Position = 0, Mandatory = $false)]
        [switch]
        $Force
    )

    $artifactoryParameters = Get-ArtifactoryParameters

    if ($Force -or $PSCmdlet.ShouldProcess("Trigger update storage information job for the '$($artifactoryParameters.serverUri)'")) {
        try {   
            $responseMessage =  (Invoke-ArtifactoryRestApi -RestApiPath "/api/storageinfo/calculate" `
                                                          -Method POST `
                                                          -ContentType 'application/json').info
        } 
        catch [System.Net.WebException] {
            $response = $_.Exception.Response
            $responseMessage =  'Failed to trigger {0} due to status code {1} ({2}).' -f $response.ResponseUri, [int]($response.StatusCode), $response.StatusDescription
            Write-Error ($responseMessage)
        }
    }  
    return $responseMessage
}