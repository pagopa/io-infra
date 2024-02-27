output "subnet_pendpoints" {
  value = {
    id   = module.private_endpoints_subnet.id
    name = module.private_endpoints_subnet.name
  }
}

output "subnet_redis" {
  value = {
    id   = module.redis_cgn_snet.id
    name = module.redis_cgn_snet.name
  }
}

output "subnet_cgn" {
  value = {
    id   = module.cgn_snet.id
    name = module.cgn_snet.name
  }
}

output "private_dns_zones" {
  value = {
    privatelink_documents = {
      id = data.azurerm_private_dns_zone.privatelink_documents.id
    }
  }
}
