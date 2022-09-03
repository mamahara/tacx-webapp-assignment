#  Deploy code from GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://github.com/mamahara/tacx-webapp-assignment"
  branch             = "master"
  use_manual_integration = false
}