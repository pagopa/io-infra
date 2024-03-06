resource "azurerm_resource_group" "resource_group_selfcare_fe" {
  name     = "${var.project}-selfcare-fe-rg"
  location = var.location

  tags = var.tags
}
