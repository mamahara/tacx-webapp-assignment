# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.21.1"
    }
  }
  required_version = ">= 0.14.9"
  backend "azurerm" {
    resource_group_name     = "terraform-state-rg"
    storage_account_name    = "assignmentstorageaccount"
    container_name          = "tfstate"
    key                     = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}
