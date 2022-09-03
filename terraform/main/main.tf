module "tacx-webapp-assignment" {
  source  = "../modules/tacx-webapp-assignment"
  create_resource_group = local.resource_group_general.create_resource_group
  environment = local.environment
  resource_group_name = local.resource_group_general.resource_group_name
  location = local.location
  tags     = local.resource_group_general.tags
  app_service_name  = var.app_service_name
  service_plan = var.service_plan
  health_check_path = var.health_check_path
}