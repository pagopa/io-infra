data "azurerm_key_vault" "kv_common" {
  name                = "${local.product}-kv-common"
  resource_group_name = "${local.product}-rg-common"
}

data "azurerm_key_vault" "auth" {
  name                = "${local.short_project_itn}-kv-01"
  resource_group_name = "${local.short_project_itn}-main-rg-01"
}
