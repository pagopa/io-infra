output "vnet_common" {
  value = {
    id                  = data.azurerm_virtual_network.vnet_common.id
    name                = data.azurerm_virtual_network.vnet_common.name
    resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name
  }
}

output "subnet_elt" {
  value = {
    id   = module.function_elt_snet.id
    name = module.function_elt_snet.name
  }
}
