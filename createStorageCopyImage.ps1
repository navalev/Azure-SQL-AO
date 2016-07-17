﻿param($DeploymentName, $ResourceGroup, $NewStorageAccountName, $NewContainerName, $Location, $SourceStorageAccount, $SourceStorageKey, $SourceContainerName, $SourceBlobName, $DestBlobName)

# create new resource group
$rg = New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location

# create new storage account for sql server VMs
$storage = New-AzureRmStorageAccount -Location $Location -Name $NewStorageAccountName -ResourceGroupName $ResourceGroup -SkuName Premium_LRS
New-AzureStorageContainer -Name $NewContainerName -Context $storage.Context
$SourceStorageContext = New-AzureStorageContext  –StorageAccountName $SourceStorageAccount -StorageAccountKey $SourceStorageKey
# copy base image to the new create storage
$BlobCopy = Start-CopyAzureStorageBlob -Context $SourceStorageContext -SrcContainer $SourceContainerName -SrcBlob $SourceBlobName -DestContext $storage.Context -DestContainer $NewContainerName -DestBlob $DestBlobName

### Retrieve the current status of the copy operation ###
$status = $BlobCopy | Get-AzureStorageBlobCopyState 
 
### Print out status ### 
$status 
 
### Loop until complete ###                                    
While($status.Status -eq "Pending"){
  $status = $BlobCopy | Get-AzureStorageBlobCopyState 
  Start-Sleep 10
  ### Print out status ###
  $status
}

