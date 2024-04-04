resource "azurerm_resource_group" "eucovidcert" {
  name     = "${var.project}-rg-eucovidcert"
  location = var.location

  tags = var.tags
}
