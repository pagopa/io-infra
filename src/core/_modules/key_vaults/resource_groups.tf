resource "azurerm_resource_group" "sec" {
  name     = local.nonstandard[var.location_short].rg
  location = var.location

  tags = var.tags
}
