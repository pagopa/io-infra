locals {
  containers = length(var.what_to_migrate.blob.containers) > 0 ? var.what_to_migrate.blob.containers : [for container in data.azurerm_storage_containers.this[0].containers : container.name]
  tables = var.what_to_migrate.table.tables
}