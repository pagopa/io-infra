locals {
  containers = length(var.containers) > 0 ? var.containers : [for container in data.azurerm_storage_containers.this[0].containers : container.name]
}