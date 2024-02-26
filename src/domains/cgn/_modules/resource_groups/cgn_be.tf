resource "azurerm_resource_group" "cgn_be_rg" {
  name     = format("%s-cgn-be-rg", local.project)
  location = var.location

  tags = var.tags
}
