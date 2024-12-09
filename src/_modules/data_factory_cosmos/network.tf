resource "azurerm_data_factory_managed_private_endpoint" "cosmos_source" {
  name               = "${module.naming_convention.prefix}-adf-${var.cosmos_accounts.source.name}-cosmos-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_cosmosdb_account.source.id
  subresource_name   = "Sql"
}

resource "azurerm_data_factory_managed_private_endpoint" "cosmos_target" {
  name               = "${module.naming_convention.prefix}-adf-${var.cosmos_accounts.target.name}-cosmos-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_cosmosdb_account.target.id
  subresource_name   = "Sql"
}
