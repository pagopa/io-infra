output "vnet_common" {
  value = {
    id                  = data.azurerm_virtual_network.vnet_common.id
    name                = data.azurerm_virtual_network.vnet_common.name
    resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name
  }
}

output "subnet_continua" {
  value = {
    id   = module.continua_common_snet.id
    name = module.continua_common_snet.name
  }
}
