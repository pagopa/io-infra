output "subnet_name" {
  value       = module.subnet_runner.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = module.subnet_runner.id
  description = "Subnet id"
}

# output "cae_id" {
#   value       = module.github_runner.cae_id
#   description = "Container App Environment id"
# }

# output "cae_name" {
#   value       = module.github_runner.cae_name
#   description = "Container App Environment name"
# }

# output "ca_id" {
#   value       = module.github_runner.ca_id
#   description = "Container App job id"
# }

# output "ca_name" {
#   value       = module.github_runner.ca_name
#   description = "Container App job name"
# }
