#---------------------------------------------------------
# App Service Plan definition - Default is "true"
#----------------------------------------------------------
resource "azurerm_service_plan" "webapp" {
  name                = var.app_service_plan_name == "" ? format("plan-%s", lower(var.app_service_name)) : var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.0.name
  location            = var.location
  os_type             = var.service_plan.kind
  tags                = merge({ "ResourceName" = format("%s", var.app_service_plan_name) }, var.tags, )
  sku_name            = var.service_plan.sku_name
}

#---------------------------------------------------------
# App Service Definitions  - Default is "true"
#----------------------------------------------------------
# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                    = var.app_service_name
  resource_group_name     = azurerm_resource_group.rg.0.name
  location                = var.location
  service_plan_id         = azurerm_service_plan.webapp.id
  https_only              = var.enable_https
  tags                    = merge({ "ResourceName" = var.app_service_name }, var.tags, )

  site_config {
    minimum_tls_version         = "1.2"
    always_on                   = false
    app_command_line            = null
    health_check_path           = var.health_check_path

    application_stack{
      java_server   = "TOMCAT"
      java_server_version = "9.0"
      java_version = "Java11"
    }
  }

  dynamic "backup" {
    for_each = var.enable_backup ? [{}] : []
    content {
      name                = coalesce(var.backup_settings.name, "DefaultBackup")
      enabled             = var.backup_settings.enabled
      storage_account_url = format("https://${azurerm_storage_account.storageaccount.0.name}.blob.core.windows.net/${azurerm_storage_container.storagecontainer.0.name}%s", data.azurerm_storage_account_blob_container_sas.main.0.sas)
      schedule {
        frequency_interval       = var.backup_settings.frequency_interval
        frequency_unit           = var.backup_settings.frequency_unit
        start_time               = timestamp()
      }
    }
  }
  lifecycle {
    ignore_changes = [
      tags,
      site_config,
      backup,
      auth_settings,
      storage_account,
      identity,
      connection_string,
    ]
  }
}