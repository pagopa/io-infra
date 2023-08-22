resource "azurerm_resource_group" "base_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}
