| Download |
| :------: |
| [![Download](https://img.shields.io/powershellgallery/v/PS.JfrogArtifactory?color=green&label=PowerShell%20gallery%3A%20PS.JfrogArtifactory)](https://www.powershellgallery.com/packages/PS.JfrogArtifactory/)

# PS.JfrogArtifactory
PowerShell Module provides helper routines which can be used in automation with Jfrog Artifactory.

Inspired from [PowerShell-Artifactory](https://github.com/nicholasdille/PowerShell-Artifactory) by [Nicholas Dille](http://dille.name/blog).

I wrote my own module because I need to have more flexibility for the specific cases I met
  
# Contribution

Any feedback, [issues](https://github.com/artyom-krot/PS.JfrogArtifactory/issues) or [pull requests](https://github.com/artyom-krot/PS.JfrogArtifactory/pulls) are appreciated.

# Prerequisites

* PowerShell v5.1

# Module's current functionality

## Get-ArtifactoryParameters function

## Get-ArtifactoryStorageInfo

Returns storage summary information regarding binaries, file store and repositories in json format.

## Get-NotUsedSinceArtifacts function

Invoking rest api call to jfrog artifactory to get the list of artifacts, that has not been used for amount of days.

## Get-NotUsedSinceDockerImages

Invoking rest api call to jfrog artifactory to get the list of docker images, that has not been used for amount of days.
Reference documentation: [How to clean up old Docker images](https://jfrog.com/knowledge-base/how-to-clean-up-old-docker-images/) and [How can I delete Docker images older than a certain time period?](https://jfrog.com/knowledge-base/how-can-i-delete-docker-images-older-than-a-certain-time-period/)

Info: Docker image layers are stored as separate artifacts within an “image” folder. If a layer is already in most Docker clients, it won’t get downloaded often. So search based on the manifest.json file, which is what will be changed only when that specific image/tag are downloaded/used. If a layer is shared between two different tags and if one of the tag is a candidate for the delete in your case above, then the layer will NOT be deleted in the binary storage since it will be still referenced by the other tag.

## Invoke-ArtifactoryRestApi

Invoking different kinds of rest api calls to Jfrog Artifactory.

## Invoke-ArtifactoryTrashCleanup

Empties the trash can. Permanently deleting all its current contents.

## Remove-JfrogArtifact

For deleting jfrog artifactory artifacts with the help of rest api.

## Set-ArtifactoryParameters

The function defines credentials and establish connection for validating those credentials.

## Update-ArtifactoryStorageInfo

Refreshes storage summary information regarding binaries, file store and repositories.