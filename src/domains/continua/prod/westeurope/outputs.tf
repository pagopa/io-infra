output "app_service_plan_continua" {
  value = {
    id   = module.app_services.app_service_plan_continua.id
    name = module.app_services.app_service_plan_continua.name
  }
}

output "app_service_continua" {
  value = {
    id                  = module.app_services.app_service_continua.id
    name                = module.app_services.app_service_continua.name
    resource_group_name = module.app_services.app_service_continua.resource_group_name
  }
}
