resource "azurerm_data_factory" "this" {
  for_each            = var.data_factories
  name                = "adf${each.value.name}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_data_factory_pipeline" "this" {
  for_each        = var.pipelines
  name            = each.value.name
  data_factory_id = azurerm_data_factory.this[each.value.data_factory].id

  variables = each.value.variables

  activities_json = each.value.activities_json
    # Dipendenza sui dataset
  depends_on = [
    azurerm_data_factory_custom_dataset.this
  ]
}


resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
  for_each        = var.azure_runtimes
  name            = "azure-runtime-${each.value.name}"
  data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
  location        = each.value.location
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "self_hosted_runtime" {
  for_each        = var.self_hosted_runtimes
  name            = "self-hosted-runtime-${each.value.name}"
  data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
}

data "azurerm_storage_account" "existing" {
  for_each            = { for linked_service, details in var.linked_services : linked_service => details.storage_account if details.storage_account != "" }
  name                = each.value
  resource_group_name = var.storage_account_resource_groups[each.key]
}

# Linked service per Azure Data Factory
resource "azurerm_data_factory_linked_custom_service" "this" {
  for_each        = var.linked_services
  name            = each.value.name
  data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
  type            = each.value.type
  
  type_properties_json = <<JSON
{
  "connectionString": "${data.azurerm_storage_account.existing[each.key].primary_connection_string}"
}
JSON
}


# Dataset JSON
resource "azurerm_data_factory_custom_dataset" "this" {
  for_each            = var.datasets
  name                = each.value.name
  data_factory_id     = azurerm_data_factory.this[each.value.data_factory].id
  type                = each.value.type

  linked_service {
    name       = azurerm_data_factory_linked_custom_service.this[each.value.linked_service].name
    parameters = each.value.parameters
  }

  type_properties_json = each.value.type_properties_json
  description          = each.value.description
  annotations          = each.value.annotations
  folder               = each.value.folder
  parameters           = each.value.parameters
  additional_properties = each.value.additional_properties
  schema_json          = each.value.schema_json
}
