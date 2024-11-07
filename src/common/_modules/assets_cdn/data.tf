data "azurerm_key_vault_secret" "assets_cdn_fn_key_cdn" {
  name         = "${var.assets_cdn_fn.name}-KEY-CDN"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${var.project}-itn-common-vnet-01"
  resource_group_name = "${var.project}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_private_endpoints_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}