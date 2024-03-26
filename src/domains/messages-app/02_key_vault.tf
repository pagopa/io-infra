data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault" "kv_common" {
  name                = "${local.product}-kv-common"
  resource_group_name = "${local.product}-rg-common"
}
