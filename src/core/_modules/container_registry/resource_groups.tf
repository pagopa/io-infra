resource "azurerm_resource_group" "container_registry" {
  name     = local.nonstandard[var.location_short].rg
  location = var.location

  tags = var.tags
}
