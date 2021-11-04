resource "azurerm_resource_group" "rg_internal" {
  name     = format("%s-rg-internal", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "rg_external" {
  name     = format("%s-rg-external", local.project)
  location = var.location

  tags = var.tags
}
