resource "azurerm_virtual_network_peering" "source" {
  for_each = {
    for peering_key, target_vnet in var.target_vnets : peering_key => target_vnet
  }

  name                      = format("%s-to-%s", var.source_vnet.name, each.value.name)
  resource_group_name       = var.source_vnet.resource_group_name
  virtual_network_name      = var.source_vnet.name
  remote_virtual_network_id = each.value.id

  allow_virtual_network_access = var.source_vnet.allow_virtual_network_access
  allow_forwarded_traffic      = var.source_vnet.allow_forwarded_traffic
  allow_gateway_transit        = var.source_vnet.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "target" {
  for_each = {
    for peering_key, target_vnet in var.target_vnets : peering_key => target_vnet if target_vnet.symmetrical.enabled
  }

  name                      = format("%s-to-%s", each.value.name, var.source_vnet.name)
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.name
  remote_virtual_network_id = var.source_vnet.id

  allow_virtual_network_access = var.source_vnet.allow_virtual_network_access
  allow_forwarded_traffic      = var.source_vnet.allow_forwarded_traffic
  allow_gateway_transit        = each.value.symmetrical.allow_gateway_transit
  use_remote_gateways          = each.value.symmetrical.use_remote_gateways
}