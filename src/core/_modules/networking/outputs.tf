output "vnet_common" {
  value = {
    id                  = azurerm_virtual_network.common.id
    name                = azurerm_virtual_network.common.name
    address_space       = azurerm_virtual_network.common.address_space
    resource_group_name = azurerm_virtual_network.common.resource_group_name
  }
}

output "pep_snet" {
  value = {
    id               = azurerm_subnet.pep.id
    name             = azurerm_subnet.pep.name
    address_prefixes = azurerm_subnet.pep.address_prefixes
  }
}

output "nat_gateways" {
  value = [for key, ng in azurerm_nat_gateway.this : {
    id                  = azurerm_nat_gateway.this[key].id
    name                = azurerm_nat_gateway.this[key].name
    resource_group_name = azurerm_nat_gateway.this[key].resource_group_name
  }]
}
