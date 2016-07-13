## Deployment Powershell scripts

The [deploy.ps](./deploy.ps1) script performs the following:
+ Create a resource group
+ Create a premium storage account for the SQL Server instances
+ Copies a user image to the new creates storage account. This is a mandatory step, since at the time of writing this, in ARM if you wish to provision a VM from a user image, the VHD have to be in the **same** storage account as the targeted VM.
+ Deploy the [sqlvm-alwayson-cluster](./sqlvm-alwayson-cluster) templates

Execution Example:
```ps
.\deploy.ps1 -DeploymentName dep01 -ResourceGroup RG01 -NewStorageAccountName test14aostore1307 -NewContainerName images -Location westeurope -SourceStorageAccount rg16986 -SourceStorageKey <source image storage account key> -SourceContainerName images -SourceBlobName image01.vhd -DestBlobName baseimage.vhd 
```

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

