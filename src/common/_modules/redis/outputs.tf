output "snet" {
  value = {
    id               = azurerm_subnet.redis.id
    name             = azurerm_subnet.redis.name
    address_prefixes = azurerm_subnet.redis.address_prefixes
  }
}

output "primary_access_key" {
  value     = azurerm_redis_cache.common.primary_access_key
  sensitive = true
}

output "hostname" {
  value     = azurerm_redis_cache.common.hostname
  sensitive = true
}

output "ssl_port" {
  value = azurerm_redis_cache.common.ssl_port
}