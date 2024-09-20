output "resource_group_elt" {
  value = {
    id   = azurerm_resource_group.elt_rg.id
    name = azurerm_resource_group.elt_rg.name
  }
}

output "function_app_elt" {
  value = {
    id                    = module.function_apps.function_app_elt.id
    name                  = module.function_apps.function_app_elt.name
    app_service_plan_name = module.function_apps.function_app_elt.app_service_plan_name
  }
}

output "storage_account_elt" {
  value = {
    id   = module.storage_accounts.storage_account_elt.id
    name = module.storage_accounts.storage_account_elt.name
  }
}
