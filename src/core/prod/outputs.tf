output "networking_itn" {
  value = {
    name = module.networking_itn.vnet_common.name
  }
}

output "networking_weu" {
  value = {
    name = module.networking_weu.vnet_common.name
  }
}
