data "azuread_group" "admin" {
  display_name = "${local.prefix}-${local.env_short}-adgroup-admin"
}

data "azurerm_private_dns_zone" "blob_storage_account" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
}

data "azurerm_private_dns_zone" "table_storage_account" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
}

data "azurerm_virtual_network" "vnet_common_itn" {
  name                = "${local.prefix}-${local.env_short}-${local.location_short}-common-vnet-01"
  resource_group_name = "${local.prefix}-${local.env_short}-${local.location_short}-common-rg-01"
}

data "azurerm_subnet" "pep" {
  name                 = "${local.prefix}-${local.env_short}-${local.location_short}-pep-snet-01"
  virtual_network_name = data.azurerm_virtual_network.vnet_common_itn.name
  resource_group_name  = data.azurerm_virtual_network.vnet_common_itn.resource_group_name
}
