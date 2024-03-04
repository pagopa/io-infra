data "azurerm_key_vault" "key_vault" {
  name                = "${var.project}-kv"
  resource_group_name = "${var.project}-sec-rg"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.resource_group_name_common
}
