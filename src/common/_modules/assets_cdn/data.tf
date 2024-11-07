data "azurerm_key_vault_secret" "assets_cdn_fn_key_cdn" {
  name         = "${var.assets_cdn_fn.name}-KEY-CDN"
  key_vault_id = var.key_vault_common.id
}

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${local.prefix}-${local.env_short}-itn-common-vnet-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}