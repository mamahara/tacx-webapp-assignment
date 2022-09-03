variable "environment" {
  description = "Environment where all resource and application would be deployed"
  default = "dev"
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = true
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = "tacx-webapp-rg"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "eu-west"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_backup" {
  description = "bool to to setup backup for app service "
  default     = false
}

variable "storage_account_name" {
  description = "The name of the azure storage account"
  default     = ""
}

variable "storage_container_name" {
  description = "The name of the storage container to keep backups"
  default     = null
}

variable "backup_settings" {
  description = "Backup settings for App service"
  type = object({
    name                     = string
    enabled                  = bool
    frequency_interval       = number
    frequency_unit           = string
    retention_period_in_days = number
  })
  default = {
    enabled                  = false
    name                     = "DefaultBackup"
    frequency_interval       = 1
    frequency_unit           = "Day"
    retention_period_in_days = 1
  }
}

variable "app_service_name" {
  description = "Specifies the name of the App Service."
}

variable "app_service_plan_name" {
  description = "Specifies the name of the App Service Plan component"
  default     = ""
}

variable "service_plan" {
  description = "Definition of the dedicated plan to use"
  type = object({
    sku_name  = string
    kind      = string
  })
}

variable "enable_https" {
  description = "Can the App Service only be accessed via HTTPS?"
  default     = true
}

variable "health_check_path" {
  description = "health check url for the application"
  default = ""
}
