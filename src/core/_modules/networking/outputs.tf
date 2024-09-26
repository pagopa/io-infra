output "vnet_common" {
  value = {
    id                  = module.vnet_common.id
    name                = module.vnet_common.name
    address_space       = module.vnet_common.address_space
    resource_group_name = module.vnet_common.resource_group_name
  }
}

output "pep_snet" {
  value = {
    id               = module.pep_snet.id
    name             = module.pep_snet.name
    address_prefixes = module.pep_snet.address_prefixes
  }
}

output "nat_gateways" {
  value = [for key, ng in azurerm_nat_gateway.this : {
    id                  = azurerm_nat_gateway.this[key].id
    name                = azurerm_nat_gateway.this[key].name
    resource_group_name = azurerm_nat_gateway.this[key].resource_group_name
  }]
}
