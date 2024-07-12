module "vnet_peering" {
  source = "github.com/pagopa/terraform-azurerm-v3//virtual_network_peering?ref=v8.7.0"
  for_each = {
    for peering_key, target_vnet in var.target_vnets : peering_key => target_vnet
  }

  source_resource_group_name       = var.source_vnet.resource_group_name
  source_virtual_network_name      = var.source_vnet.name
  source_remote_virtual_network_id = var.source_vnet.id
  source_allow_gateway_transit     = var.source_vnet.allow_gateway_transit # needed by vpn gateway for enabling routing from vnet to vnet_integration

  target_resource_group_name       = each.value.resource_group_name
  target_virtual_network_name      = each.value.name
  target_remote_virtual_network_id = each.value.id
  target_use_remote_gateways       = each.value.use_remote_gateways # needed by vpn gateway for enabling routing from vnet to vnet_integration
}
