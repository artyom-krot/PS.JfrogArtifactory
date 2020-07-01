<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR Artsiom Krot

.COPYRIGHT (c) 2020 Artsiom Krot

.PROJECTURI https://github.com/artyom-krot/PS.JfrogArtifactory

.RELEASENOTES 


Script file name:

    Set-ArtifactoryParameters.ps1

.DESCRIPTION

    The script is an integral part of PS.JfrogArtifactory solution (https://github.com/artyom-krot/PS.JfrogArtifactory)

#>

function Set-ArtifactoryParameters {
    <#
    .SYNOPSIS
        PowerShell script for setting up jfrog artifactory credentials, that can be used accross the whole PS.JfrogArtifactory module.
    .DESCRIPTION
        The function defines credentials and establish connection for validating those credentials.
        
    .INPUTS
        -artifactoryUrl <string[]>

        -artifactoryUser <string[]>
        
        -artifactoryUserToken <string[]>
    .OUTPUTS
        Information message

    .NOTES
        
    
    .EXAMPLE
        Set-ArtifactoryParameters -artifactoryUrl $ArtifactoryServer -artifactoryUser $ArtifactoryUser -artifactoryUserToken $ArtifactoryToken

    #>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]

    param(
        [parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $artifactoryUrl,

        [parameter(Position = 1, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $artifactoryUser,

        [parameter(Position = 3, Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $artifactoryUserToken = (Read-Host -Prompt 'Password' -AsSecureString | Get-PlaintextFromSecureString)
    )

    
    if ($Force -or $PSCmdlet.ShouldProcess("Set new credentials for artifactoryUrl '$artifactoryUrl' and artifactoryUser '$artifactoryUser'?")) {
        $script:artifactoryServer     = $artifactoryUrl
        $script:artifactoryUser       = $artifactoryUser
        $script:artifactoryUserToken  = $artifactoryUserToken
    }

    # Establish one-time connection to Jfro Artifactory to validate provided credentials 
    $validateConnection = Invoke-ArtifactoryRestApi -RestApiPath "/api/storageinfo" -Method Get -ErrorAction SilentlyContinue
    
    if ([string]::IsNullOrEmpty($validateConnection)) {
        Write-Error ("Connection to the artifactory can't be estalished")
        Write-Warning "Validate connectivity or set new credentials for artifactoryUrl '$artifactoryUrl' and artifactoryUser '$artifactoryUser'"
        
    }
    else {
        Write-Verbose "Connection to the jfrog artifactory '$artifactoryUrl' has been validated successfully."
    }
}
