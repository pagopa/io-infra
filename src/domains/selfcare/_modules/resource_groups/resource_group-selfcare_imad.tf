resource "azurerm_resource_group" "resource_group_selfcare_imad" {
  name     = "${var.project}-selfcare-importadesioni-rg"
  location = var.location

  tags = var.tags
}
