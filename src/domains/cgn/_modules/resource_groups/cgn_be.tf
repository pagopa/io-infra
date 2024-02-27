resource "azurerm_resource_group" "rg_be_cgn" {
  name     = format("%s-cgn-be-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "rg_cgn" {
  name     = format("%s-rg-cgn", local.project)
  location = var.location

  tags = var.tags
}
