resource "azurerm_resource_group" "resource_group_cgn_be" {
  name     = format("%s-cgn-be-rg", var.project)
  location = var.location

  tags = var.tags
}
