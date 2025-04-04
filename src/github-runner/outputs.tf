output "subnet_name" {
  value       = module.subnet_runner.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = module.subnet_runner.id
  description = "Subnet id"
}

output "cae_id" {
  value       = module.container_app_environment_runner.id
  description = "Container App Environment id"
}

output "cae_name" {
  value       = module.container_app_environment_runner.name
  description = "Container App Environment name"
}
