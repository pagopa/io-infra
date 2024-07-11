output "vnet_common" {
  value = {
    id            = module.vnet_common.id
    name          = module.vnet_common.name
    address_space = module.vnet_common.address_space
  }
}

output "pep_snet" {
  value = {
    id               = module.pep_snet.id
    name             = module.pep_snet.name
    address_prefixes = module.pep_snet.address_prefixes
  }
}