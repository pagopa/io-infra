resource "azurerm_resource_group" "common_rg" {
  name     = "${local.project}-common-rg"
  location = var.location

  tags = var.tags
}
