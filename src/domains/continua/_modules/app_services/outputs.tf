output "app_service_plan_continua" {
  value = {
    id   = azurerm_service_plan.continua.id
    name = azurerm_service_plan.continua.name
  }
}

output "app_service_continua" {
  value = {
    id                  = module.appservice_continua.id
    name                = module.appservice_continua.name
    resource_group_name = module.appservice_continua.resource_group_name
    hostname            = module.appservice_continua.default_site_hostname
  }
}
