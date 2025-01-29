resource "azurerm_resource_group" "rg_itn_01" {
  name     = "${local.project}-rg-01"
  location = local.location

  tags = local.tags
}
