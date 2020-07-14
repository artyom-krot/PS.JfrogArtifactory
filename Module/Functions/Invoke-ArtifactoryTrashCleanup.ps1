<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Invoke-ArtifactoryTrashCleanup.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog ref documentation: https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-EmptyTrashCan

#>


function Invoke-ArtifactoryTrashCleanup {
    <#
    .SYNOPSIS
        PowerShell script for invoking rest api call to jfrog artifactory to empty the trash can.
        Permanently deleting all its current contents.

    .DESCRIPTION        
        
    .INPUTS

    .OUTPUTS
        Empties the trash can permanently deleting all its current contents.
        
    .NOTES
    
    .EXAMPLE
        

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [parameter(Position = 0, Mandatory = $false)]
        [switch]
        $Force
    )

    $artifactoryParameters = Get-ArtifactoryParameters

    if ($Force -or $PSCmdlet.ShouldProcess("Starting cleaning of the trash can for the '$($artifactoryParameters.serverUri)'")) {
        try {   
            $responseMessage =  (Invoke-ArtifactoryRestApi -RestApiPath "/api/trash/empty" `
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