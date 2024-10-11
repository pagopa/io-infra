# Create Azure Data Factory instances
# Uses for_each to create multiple factories based on input variables
# Enables system-assigned managed identity for secure access to resources
resource "azurerm_data_factory" "this" {
    for_each = var.data_factories
    name     = "adf${each.value.name}"
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    tags     = each.value.tags
    
    identity {
        type = "SystemAssigned"
    }
}

# Define Data Factory pipelines
# Creates pipelines with custom variables and activities
# Dependencies ensure datasets are created before pipelines
resource "azurerm_data_factory_pipeline" "this" {
    for_each        = var.pipelines
    name            = each.value.name
    data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
    variables       = each.value.variables
    activities_json = each.value.activities_json
    
    depends_on = [
        azurerm_data_factory_custom_dataset.this
    ]
}

# Create Azure Integration Runtime
# Managed compute infrastructure for data movement and transformation
# Located in specific Azure regions
resource "azurerm_data_factory_integration_runtime_azure" "azure_runtime" {
    for_each        = var.azure_runtimes
    name            = "azure-runtime-${each.value.name}"
    data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
    location        = each.value.location
}

# Create Self-hosted Integration Runtime
# Enables data movement and transformation in private networks
# Requires manual installation of runtime on premises
resource "azurerm_data_factory_integration_runtime_self_hosted" "self_hosted_runtime" {
    for_each        = var.self_hosted_runtimes
    name            = "self-hosted-runtime-${each.value.name}"
    data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
}

# Retrieve existing Storage Account information
# Uses data source to get connection details for linked services
# Filters storage accounts based on provided configuration
data "azurerm_storage_account" "existing" {
    for_each = {
        for linked_service, details in var.linked_services : linked_service => details.storage_account
        if details.storage_account != ""
    }
    name                = each.value
    resource_group_name = var.storage_account_resource_groups[each.key]
}

# Create Linked Services for Data Factory
# Establishes connections to external data sources
# Uses storage account connection strings for authentication
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

# Create Custom Datasets in Data Factory
# Defines data structure and location for pipeline processing
# Supports various data formats and source types
resource "azurerm_data_factory_custom_dataset" "this" {
    for_each        = var.datasets
    name            = each.value.name
    data_factory_id = azurerm_data_factory.this[each.value.data_factory].id
    type            = each.value.type
    
    linked_service {
        name       = azurerm_data_factory_linked_custom_service.this[each.value.linked_service].name
        parameters = each.value.parameters
    }

    type_properties_json    = each.value.type_properties_json
    description            = each.value.description
    annotations           = each.value.annotations
    folder               = each.value.folder
    parameters           = each.value.parameters
    additional_properties = each.value.additional_properties
    schema_json          = each.value.schema_json
}