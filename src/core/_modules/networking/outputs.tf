output "vnet_itn_common" {
  value = {
    id            = module.vnet_itn_common.id
    name          = module.vnet_itn_common.name
    address_space = module.vnet_itn_common.address_space
  }
}
