param($DeploymentName, $ResourceGroup, $NewStorageAccountName, $NewContainerName, $Location, $SourceStorageAccount, $SourceStorageKey, $SourceContainerName, $SourceBlobName, $DestBlobName)

# create new resource group
$rg = New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location

# create new storage account for sql server VMs
$storage = New-AzureRmStorageAccount -Location $Location -Name $NewStorageAccountName -ResourceGroupName $ResourceGroup -SkuName Premium_LRS
New-AzureStorageContainer -Name $NewContainerName -Context $storage.Context
$SourceStorageContext = New-AzureStorageContext  –StorageAccountName $SourceStorageAccount -StorageAccountKey $SourceStorageKey
# copy base image to the new create storage
$BlobCopy = Start-CopyAzureStorageBlob -Context $SourceStorageContext -SrcContainer $SourceContainerName -SrcBlob $SourceBlobName -DestContext $storage.Context -DestContainer $NewContainerName -DestBlob $DestBlobName

# deploy alwaysOn templates
New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $rg.ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/navalev/Azure-SQL-AO/master/sqlvm-alwayson-cluster/azuredeploy.json" -sqlStorageAccountName $NewStorageAccountName -sqlImageUri $BlobCopy.ICloudBlob.SnapshotQualifiedStorageUri.PrimaryUri.AbsoluteUri
