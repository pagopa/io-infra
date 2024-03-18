output "redis_cgn" {
  value = {
    id                  = module.redis_cgn.id
    name                = module.redis_cgn.name
    resource_group_name = module.redis_cgn.resource_group_name
    location            = module.redis_cgn.location
    hostname            = module.redis_cgn.hostname
    ssl_port            = module.redis_cgn.ssl_port
  }
}

output "redis_cgn_primary_access_key" {
  value     = module.redis_cgn.primary_access_key
  sensitive = true
}
