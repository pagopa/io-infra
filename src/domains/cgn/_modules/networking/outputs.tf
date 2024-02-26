output "subnet" {
  value = {
    id   = module.private_endpoints_subnet.id
    name = module.private_endpoints_subnet.name
  }
}

output "private_dns_zones" {
  value = {
    privatelink_documents = {
      id = data.azurerm_private_dns_zone.privatelink_documents.id
    }
  }
}
