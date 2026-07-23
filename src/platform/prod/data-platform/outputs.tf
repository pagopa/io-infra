output "redis" {
  value = {
    weu = module.redis_weu
  }
}

output "cosmos_api" {
  value = {
    weu = module.cosmos_api_weu
  }
}