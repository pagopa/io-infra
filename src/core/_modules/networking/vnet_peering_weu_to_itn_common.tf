module "vnet_peering_weu_common_itn_common" {
  source = "github.com/pagopa/terraform-azurerm-v3//virtual_network_peering?ref=v8.7.0"

  source_resource_group_name       = data.azurerm_virtual_network.weu_common.resource_group_name
  source_virtual_network_name      = data.azurerm_virtual_network.weu_common.name
  source_remote_virtual_network_id = data.azurerm_virtual_network.weu_common.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration

  target_resource_group_name       = module.vnet_itn_common.resource_group_name
  target_virtual_network_name      = module.vnet_itn_common.name
  target_remote_virtual_network_id = module.vnet_itn_common.id
  target_use_remote_gateways       = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
}
