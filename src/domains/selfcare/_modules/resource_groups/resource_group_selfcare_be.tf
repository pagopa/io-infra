resource "azurerm_resource_group" "resource_group_selfcare_be" {
  name     = "${var.project}-selfcare-be-rg"
  location = var.location

  tags = var.tags
}
