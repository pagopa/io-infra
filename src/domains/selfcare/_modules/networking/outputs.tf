output "subnet_be_common" {
  value = {
    id   = module.snet_selfcare_be_common.id
    name = module.snet_selfcare_be_common.name
  }
}

output "subnet_developer_portal" {
  value = {
    id   = module.snet_developer_portal.id
    name = module.snet_developer_portal.name
  }
}

output "subnet_pendpoints" {
  value = {
    id   = data.azurerm_subnet.subnet_private_endpoints.id
    name = data.azurerm_subnet.subnet_private_endpoints.name
  }
}
