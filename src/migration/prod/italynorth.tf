resource "azurerm_resource_group" "migration" {
  name     = "${local.project_itn}-${local.environment.app_name}-rg-${local.environment.instance_number}"
  location = "italynorth"

  tags = local.tags
}

# Create Azure Data Factory instances
# Enables system-assigned managed identity for secure access to resources
resource "azurerm_data_factory" "this" {
  name                = "${local.project_itn}-${local.environment.app_name}-adf-${local.environment.instance_number}"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.migration.name

  public_network_enabled          = false
  managed_virtual_network_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  name                    = "${local.project_itn}-${local.environment.app_name}-adfir-${local.environment.instance_number}"
  location                = "italynorth"
  data_factory_id         = azurerm_data_factory.this.id
  virtual_network_enabled = true
}

module "migrate_storage_accounts" {
  for_each = { for migration in local.storage_accounts : "${migration.source.name}|${migration.target.name}" => migration }
  source   = "../../_modules/data_factory_storage_account"

  environment = local.environment

  data_factory_id                       = azurerm_data_factory.this.id
  data_factory_principal_id             = azurerm_data_factory.this.identity[0].principal_id
  data_factory_integration_runtime_name = azurerm_data_factory_integration_runtime_azure.azure_runtime.name

  storage_accounts = {
    source = each.value.source
    target = each.value.target
  }

  what_to_migrate = {
    blob = {
      enabled    = try(each.value.blob.enabled, true)
      containers = try(each.value.blob.containers, [])
    }

    table = {
      enabled = try(each.value.table.enabled, true)
      tables  = try(each.value.table.tables, [])
    }
  }
}

module "migrate_cosmos_accounts" {
  for_each = { for migration in local.cosmos_accounts : "${migration.source.name}|${migration.target.name}" => migration }
  source   = "../../_modules/data_factory_cosmos"

  environment = local.environment

  data_factory_id                       = azurerm_data_factory.this.id
  data_factory_principal_id             = azurerm_data_factory.this.identity[0].principal_id
  data_factory_integration_runtime_name = azurerm_data_factory_integration_runtime_azure.azure_runtime.name

  cosmos_accounts = {
    source = each.value.source
    target = each.value.target
  }

  what_to_migrate = {
    databases = try(each.value.databases, [])
  }
}