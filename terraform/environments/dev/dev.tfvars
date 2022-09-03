#############
project_name = "tacx-assignment"
environment = "dev"
create_resource_group = true
resource_group_name   = "tacx-assignment-rg"
location = "westeurope"
service_plan = {
  sku_name = "B1"
  kind     = "Linux"
}
app_service_name = "tacx-java-webapp"
health_check_path = "/login"
