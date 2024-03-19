output "subnet_be_common" {
  value = {
    id   = module.snet_selfcare_be_common.id
    name = module.snet_selfcare_be_common.name
  }
}
