terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform-state-rg" {
  name     = "terraform-state-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "assignmentstorageaccount"
  resource_group_name      = azurerm_resource_group.terraform-state-rg.name
  location                 = azurerm_resource_group.terraform-state-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "blob"
}