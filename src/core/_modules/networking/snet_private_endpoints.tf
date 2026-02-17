resource "azurerm_subnet" "pep" {
  name                 = try(local.nonstandard[var.location_short].pep-snet, "${var.project}-pep-snet-01")
  address_prefixes     = var.pep_snet_cidr
  virtual_network_name = azurerm_virtual_network.common.name
  resource_group_name  = var.resource_group_name
}
