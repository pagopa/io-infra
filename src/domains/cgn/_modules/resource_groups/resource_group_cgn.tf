resource "azurerm_resource_group" "resource_group_cgn" {
  name     = format("%s-rg-cgn", var.project)
  location = var.location

  tags = var.tags
}
