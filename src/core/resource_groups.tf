resource "azurerm_resource_group" "rg_internal" {
  name     = format("%s-rg-internal", local.project)
  location = var.location

  tags = var.tags
}
