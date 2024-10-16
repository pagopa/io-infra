locals {
  containers = var.what_to_migrate.blob.enabled ? (length(var.what_to_migrate.blob.containers) > 0 ? var.what_to_migrate.blob.containers : [for container in data.azurerm_storage_containers.this[0].containers : container.name]) : []
  tables     = var.what_to_migrate.table.enabled ? (length(var.what_to_migrate.table.tables) > 0 ? var.what_to_migrate.table.tables : [for table in jsondecode(data.azapi_resource_list.tables.output).value : table.TableName]) : []
}