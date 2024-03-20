output "app_service_plan_common" {
  value = {
    id                  = azurerm_service_plan.selfcare_be_common.id
    resource_group_name = azurerm_service_plan.selfcare_be_common.resource_group_name
  }
}
