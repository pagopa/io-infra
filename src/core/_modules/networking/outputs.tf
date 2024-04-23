output "vnet_itn_common" {
  value = {
    id            = module.vnet_itn_common.id
    name          = module.vnet_itn_common.name
    address_space = module.vnet_itn_common.address_space
  }
}

output "pep_snet" {
  value = {
    id               = module.pep_snet.id
    name             = module.pep_snet.name
    address_prefixes = module.pep_snet.address_prefixes
  }
}