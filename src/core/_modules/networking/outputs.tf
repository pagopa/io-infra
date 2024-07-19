output "vnet_common" {
  value = {
    id                  = data.azurerm_virtual_network.common.id
    name                = data.azurerm_virtual_network.common.name
    address_space       = data.azurerm_virtual_network.common.address_space
    resource_group_name = data.azurerm_virtual_network.common.resource_group_name
  }
}

output "pep_snet" {
  value = {
    id               = module.pep_snet.id
    name             = module.pep_snet.name
    address_prefixes = module.pep_snet.address_prefixes
  }
}
