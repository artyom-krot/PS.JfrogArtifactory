<#PSScriptInfo

.VERSION 1.0.0

.GUID 

.AUTHOR Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Remove-JfrogArtifact.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

    Jfrog reference documentation: 
    https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-ArtifactsNotDownloadedSince

#>

function Remove-JfrogArtifact {
    <#
    .SYNOPSIS
        PowerShell script for deleting jfrog artifactory artifacts with the help of rest api.
        
        Jfrog reference documentation about used restapi method: 
        https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-ArtifactsNotDownloadedSince

    .DESCRIPTION
        
        
    .INPUTS
        -ArtifactFullPath <string[]> /repo-name/artifact-folder/artifact-name

        -Force <switch>
        

    .OUTPUTS
        Information message in case of success or error message in case of failure.

    .NOTES
        
    
    .EXAMPLE
        Remove-JfrogArtifact -ArtifactFullPath /docker-prod/my-image-name/image-tag -Force

    #>
    
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ArtifactFullPath,

        [parameter(Position = 1, Mandatory = $false)]
        [switch]
        $Force
    )
    
    begin {
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        Write-Verbose ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f $MyInvocation.MyCommand, $Confirm, $ConfirmPreference, $WhatIf, $WhatIfPreference)
    }

    process {
        try {   
            if ($Force -or $PSCmdlet.ShouldProcess("Confirm removal of the artifact '/$ArtifactFullPath'?")) {
                
                Invoke-ArtifactoryRestApi -RestApiPath "/$ArtifactFullPath" -Method Delete
                $responseMessage = "Remove artifact /$ArtifactFullPath. Success!"
            }
        } 
        catch [System.Net.WebException] {
            $response = $_.Exception.Response
            $responseMessage =  'Failed to remove {0} due to status code {1} ({2}).' -f $response.ResponseUri, [int]($response.StatusCode), $response.StatusDescription
            Write-Error ($responseMessage)
        }
        return $responseMessage
    }

}