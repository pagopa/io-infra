output "hostname" {
  value = module.redis_cgn.hostname
}

output "ssl_port" {
  value = module.redis_cgn.ssl_port
}

output "primary_access_key" {
  value     = module.redis_cgn.primary_access_key
  sensitive = true
}
