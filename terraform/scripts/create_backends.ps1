$RESOURCE_GROUP_NAME='terraform-state-rg'
$STORAGE_ACCOUNT_NAME="assignment-terraform-sa"
$CONTAINER_NAME='tfstate'

# Create resource group
New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location eu-west

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location eu-west -AllowBlobPublicAccess $true

# Create blob container
New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context -Permission blob