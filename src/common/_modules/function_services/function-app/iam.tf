module "function_services_role_assignments" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.3"

  principal_id    = module.function_services.function_app.function_app.principal_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  key_vault = [
    {
      name                = data.azurerm_key_vault.io_com.name
      resource_group_name = data.azurerm_key_vault.io_com.resource_group_name
      description         = "Allow function_services to read secrets from key vault"
      roles = {
        secrets = "reader"
      }
    }
  ]
}

module "function_services_staging_slot_role_assignments" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.3"

  principal_id    = module.function_services.function_app.function_app.slot.principal_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  key_vault = [
    {
      name                = data.azurerm_key_vault.io_com.name
      resource_group_name = data.azurerm_key_vault.io_com.resource_group_name
      description         = "Allow function_services staging slot to read secrets from key vault"
      roles = {
        secrets = "reader"
      }
    }
  ]
}
