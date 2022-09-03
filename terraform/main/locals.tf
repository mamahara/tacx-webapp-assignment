
locals {
  environment = var.environment
  location    = var.location

  resource_group_general = {
    create_resource_group = var.create_resource_group
    resource_group_name = "${var.resource_group_name}-${var.environment}"
    tags = {
      ProjectName  = var.project_name
      environment  = var.environment
    }
  }

}