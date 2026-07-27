output "redis" {
  sensitive = true
  value = {
    weu = module.redis_weu
  }
}

output "cosmos_api" {
  sensitive = true
  value = {
    weu = module.cosmos_api_weu
  }
}