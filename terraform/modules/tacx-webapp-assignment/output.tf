output "linux_webapp_name" {
  value = azurerm_linux_web_app.webapp.name
}

output "webapp_url" {
  value = azurerm_linux_web_app.webapp.connection_string
}