resource "azurerm_resource_group" "resource_group_cgn_be" {
  name     = "${var.project}-cgn-be-rg"
  location = var.location

  tags = var.tags
}
