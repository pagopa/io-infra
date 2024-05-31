data "azurerm_virtual_network" "weu_common" {
  name                = "${local.legacy_project}-vnet-common"
  resource_group_name = "${local.legacy_project}-rg-common"
}
