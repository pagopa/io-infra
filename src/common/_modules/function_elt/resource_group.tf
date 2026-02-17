resource "azurerm_resource_group" "itn_elt" {
  name     = format("%s-elt-rg-01", local.project_itn)
  location = var.location_itn

  tags = var.tags
}