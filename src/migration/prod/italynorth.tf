resource "azurerm_resource_group" "migration" {
  name     = "${local.project_itn}-migration-rg-01"
  location = "italynorth"

  tags = local.tags
}

# Create Azure Data Factory instances
# Enables system-assigned managed identity for secure access to resources
resource "azurerm_data_factory" "this" {
  name                = "${local.project_itn}-migration-adf-01"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.migration.name

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  name            = "${local.project_itn}-migration-adfir-01"
  location        = "italynorth"
  data_factory_id = azurerm_data_factory.this.id
}

module "migrate_storage_accounts" {
  for_each = local.storage_accounts
  source   = "../../_modules/data_factory_storage_account"

  environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = "italynorth"
    domain          = "eng"
    app_name        = "mig"
    instance_number = "01"
  }

  data_factory_id = azurerm_data_factory.this.id

  storage_accounts = {
    source = each.value.source
    target = each.value.target
  }

  what_to_migrate = {
    blob = {
      enabled    = each.value.blob.enabled
      containers = each.value.blob.containers
    }

    table = {
      enabled = each.value.table.enabled
      tables  = each.value.table.tables
    }
  }
}