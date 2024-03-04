output "app_service_plan_common" {
  value = {
    id       = azurerm_app_service_plan.app_service_plan_cgn_common.id
    name     = azurerm_app_service_plan.app_service_plan_cgn_common.name
    location = azurerm_app_service_plan.app_service_plan_cgn_common.location
  }
}

output "function_app_cgn_merchant" {
  value = {
    id   = module.function_cgn_merchant.id
    name = module.function_cgn_merchant.name
  }
}

output "function_app_cgn" {
  value = {
    id   = module.function_cgn.id
    name = module.function_cgn.name
  }
}
