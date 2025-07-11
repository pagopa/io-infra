data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault" "kv_common" {
  name                = "${local.product}-kv-common"
  resource_group_name = "${local.product}-rg-common"
}

data "azurerm_key_vault" "auth" {
  name                = "${local.short_project_itn}-kv-01"
  resource_group_name = "${local.short_project_itn}-main-rg-01"
}

data "azurerm_key_vault_certificate_data" "lollipop_certificate_v1" {
  name         = "lollipop-certificate-v1"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault" "ioweb_kv" {
  name                = format("%s-ioweb-kv", local.product)
  resource_group_name = format("%s-ioweb-sec-rg", local.product)
}
