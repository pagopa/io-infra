output "name" {
  description = "Name of the Container App for the APIM smoke test."
  value       = module.app.name
}

output "url" {
  description = "FQDN of the Container App for the APIM smoke test."
  value       = module.app.url
}

output "principal_id" {
  description = "System-assigned managed identity principal ID of the Container App."
  value       = module.app.principal_id
}

output "environment_name" {
  description = "Name of the Container App Environment."
  value       = module.env.name
}
