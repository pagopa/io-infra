output "endpoint" {
  value = module.cosmos_cgn.endpoint
}

output "primary_key" {
  value     = module.cosmos_cgn.primary_key
  sensitive = true
}
