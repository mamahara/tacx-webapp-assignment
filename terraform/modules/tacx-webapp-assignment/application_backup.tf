#---------------------------------------------------------
# Generating Storage SAS URL for app backup - Default is "false"
#----------------------------------------------------------
resource "azurerm_storage_account" "storageaccount" {
  count                    = var.enable_backup ? 1 : 0
  name                     = "backupstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.0.name
  location                 = azurerm_resource_group.rg.0.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storagecontainer" {
  count                 = var.enable_backup ? 1 : 0
  name                  = var.storage_container_name == null ? "appservice-backup" : var.storage_container_name
  storage_account_name  = azurerm_storage_account.storageaccount.0.name
  container_access_type = "private"
}

data "azurerm_storage_account_blob_container_sas" "main" {
  count             = var.enable_backup ? 1 : 0
  connection_string = azurerm_storage_account.storageaccount.0.primary_connection_string
  container_name    = azurerm_storage_container.storagecontainer.0.name
  https_only        = true

  start  = timestamp()
  expiry = "2023-09-01"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}