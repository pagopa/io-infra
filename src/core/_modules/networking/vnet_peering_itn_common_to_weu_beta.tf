module "vnet_peering_itn_common_weu_beta" {
  source = "github.com/pagopa/terraform-azurerm-v3//virtual_network_peering?ref=v7.76.0"

  source_resource_group_name       = module.vnet_itn_common.resource_group_name
  source_virtual_network_name      = module.vnet_itn_common.name
  source_remote_virtual_network_id = module.vnet_itn_common.id
  source_allow_gateway_transit     = false # needed by vpn gateway for enabling routing from vnet to vnet_integration

  target_resource_group_name       = data.azurerm_virtual_network.weu_beta.resource_group_name
  target_virtual_network_name      = data.azurerm_virtual_network.weu_beta.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.weu_beta.id
  target_use_remote_gateways       = false # needed by vpn gateway for enabling routing from vnet to vnet_integration
}
