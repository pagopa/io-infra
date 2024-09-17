output "snet" {
  value = {
    id               = module.azdoa_snet.id
    name             = module.azdoa_snet.name
    address_prefixes = module.azdoa_snet.address_prefixes
  }
}