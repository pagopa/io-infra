data "azurerm_key_vault" "key_vault" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${local.project}-kv-common"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_storage_account" "iopstcgn" {
  name                = "iopstcgn"
  resource_group_name = var.resource_group_name
}
