output "data_factory" {
  value = {
    id                  = azurerm_data_factory.this.id
    name                = azurerm_data_factory.this.name
    resource_group_name = azurerm_data_factory.this.resource_group_name
  }
}

output "data_factory_st_pipelines" {
  value = { for migration in local.storage_accounts : "${migration.source.name}|${migration.target.name}" => module.migrate_storage_accounts["${migration.source.name}|${migration.target.name}"].pipelines }
}

output "data_factory_cosmos_pipelines" {
  value = { for migration in local.cosmos_accounts : "${migration.source.name}|${migration.target.name}" => module.migrate_cosmos_accounts["${migration.source.name}|${migration.target.name}"].pipelines }
}
