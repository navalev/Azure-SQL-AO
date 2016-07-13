## Templates
1.[Capture an Azure VM](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-capture-image/)

2.Copy Azure blob with Powershell:
```powershell
$srcUri = "uri for source blob"
$storageAccount = "destination storage acocunt name"
$storageKey = "destination storage account key"
$containerName = "destination container name"
$destBlob = "destination blob name"

$destContext = New-AzureStorageContext  –StorageAccountName $storageAccount -StorageAccountKey $storageKey  
New-AzureStorageContainer -Name $containerName -Context $destContext 
$blob1 = Start-AzureStorageBlobCopy -srcUri $srcUri -DestContainer $containerName -DestBlob $destBlob -DestContext $destContext
```
3.[Create a VM from an image - select if to create new vnet or use existing](https://github.com/Azure/azure-quickstart-templates/tree/master/101-vm-from-user-image)

4.[Create a Virtual Network with 2 subnets](https://github.com/Azure/azure-quickstart-templates/tree/master/101-vnet-two-subnets)

5.[Create a VM from an existing VHD in an exsiting VNET](./vm-from-vhd-existing-vnet.json)

## How-to
[Deploy templates](https://azure.microsoft.com/en-us/documentation/articles/resource-group-template-deploy/)

