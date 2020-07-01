| Download |
| :------: |
| [![Download](https://img.shields.io/powershellgallery/v/PS.JfrogArtifactory?color=green)](https://www.powershellgallery.com/packages/PS.JfrogArtifactory/0.2)

# PS.JfrogArtifactory
PowerShell Module provides helper routines which can be used in automation with Jfrog Artifactory.

# Contribution

Any feedback, [issues](https://github.com/artyom-krot/PS.JfrogArtifactory/issues) or [pull requests](https://github.com/artyom-krot/PS.JfrogArtifactory/pulls) are appreciated.

# Prerequisites

* PowerShell v5.1

# Module's current functionality

## Get-ArtifactoryParameters function

## Get-NotUsedSinceArtifacts function

Invoking rest api call to jfrog artifactory to get the list of artifacts, that has not been used for amount of days.

## Get-NotUsedSinceDockerImages

Invoking rest api call to jfrog artifactory to get the list of docker images, that has not been used for amount of days.

## Invoke-ArtifactoryRestApi

Invoking different kinds of rest api calls to Jfrog Artifactory.

## Remove-JfrogArtifact

For deleting jfrog artifactory artifacts with the help of rest api.

## Search-ArtifactoryParameters

## Set-ArtifactoryParameters

The function defines credentials and establish connection for validating those credentials.