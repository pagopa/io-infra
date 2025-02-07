output "app_service_plan_common" {
  value = {
    id                  = azurerm_service_plan.selfcare_be_common.id
    resource_group_name = azurerm_service_plan.selfcare_be_common.resource_group_name
  }
}

output "app_service_common" {
  value = {
    devportal_be = {
      id                  = module.appservice_devportal_be.id
      resource_group_name = module.appservice_devportal_be.resource_group_name
      principal_id        = module.appservice_devportal_be.principal_id
    }
    selfcare_be = {
      id                  = module.appservice_selfcare_be.id
      resource_group_name = module.appservice_selfcare_be.resource_group_name
      principal_id        = module.appservice_selfcare_be.principal_id
    }
  }
}