resource "azurerm_resource_group" "migration" {
  name     = "${local.project_itn}-${local.environment.domain}-${local.environment.app_name}-rg-01"
  location = "italynorth"

  tags = local.tags
}

# Create Azure Data Factory instances
# Enables system-assigned managed identity for secure access to resources
resource "azurerm_data_factory" "this" {
  name                = "${local.project_itn}-${local.environment.domain}-${local.environment.app_name}-adf-01"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.migration.name

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  name            = "${local.project_itn}-${local.environment.domain}-${local.environment.app_name}-adfir-01"
  location        = "italynorth"
  data_factory_id = azurerm_data_factory.this.id
}

module "migrate_storage_accounts" {
  for_each = { for migration in local.storage_accounts : "${migration.source.name}|${migration.target.name}" => migration }
  source   = "../../_modules/data_factory_storage_account"

  environment = local.environment

  data_factory_id           = azurerm_data_factory.this.id
  data_factory_principal_id = azurerm_data_factory.this.identity[0].principal_id

  storage_accounts = {
    source = each.value.source
    target = each.value.target
  }

  what_to_migrate = {
    blob = {
      enabled    = each.value.blob.enabled
      containers = try(each.value.blob.containers, [])
    }

    table = {
      enabled = each.value.table.enabled
      tables  = try(each.value.table.tables, [])
    }
  }
}