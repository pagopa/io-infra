output "function_app_elt" {
  value = {
    id                    = module.function_elt.id
    name                  = module.function_elt.name
    app_service_plan_name = module.function_elt.app_service_plan_name
    resource_group_name   = module.function_elt.resource_group_name
  }
}
