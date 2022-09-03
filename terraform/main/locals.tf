
locals {
  environment = var.environment
  location    = var.location

  resource_group_general = {
    create_resource_group = var.create_resource_group
    resource_group_name   = "${var.resource_group_name}-${var.environment}"
    tags = {
      ProjectName = var.project_name
      environment = var.environment
    }
  }

  java_webapp_general = {
    app_service_name  = var.app_service_name
    service_plan      = var.service_plan
    health_check_path = var.health_check_path

  }
}