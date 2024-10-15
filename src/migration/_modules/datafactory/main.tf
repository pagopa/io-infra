# Create Azure Data Factory instances
# Enables system-assigned managed identity for secure access to resources
resource "azurerm_data_factory" "this" {
  name     = "${var.project}-migration-adf-01"
  location = var.location
  resource_group_name = var.resource_group_name
  
  identity {
      type = "SystemAssigned"
  }

  tags     = var.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  name            = "${var.project}-adfir-${module.naming_convention.suffix}"
  data_factory_id = azurerm_data_factory.this.id
  location        = var.location
}
