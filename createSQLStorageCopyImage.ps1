param($ResourceGroup, $NewStorageAccountName, $NewContainerName, $Location, $SourceStorageAccount, $SourceStorageKey, $SourceContainerName, $SourceBlobName, $DestBlobName)

New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location
$storage = New-AzureRmStorageAccount -Location $Location -Name $NewStorageAccountName -ResourceGroupName $ResourceGroup -SkuName Premium_LRS
New-AzureStorageContainer -Name $NewContainerName -Context $storage.Context
$SourceStorageContext = New-AzureStorageContext  –StorageAccountName $SourceStorageAccount -StorageAccountKey $SourceStorageKey
$BlobCopy = Start-CopyAzureStorageBlob -Context $SourceStorageContext -SrcContainer $SourceContainerName -SrcBlob $SourceBlobName -DestContext $storage.Context -DestContainer $NewContainerName -DestBlob $DestBlobName

return $BlobCopy.ICloudBlob.SnapshotQualifiedStorageUri.PrimaryUri;

