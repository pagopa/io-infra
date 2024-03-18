output "cosmos_account_cgn" {
  value = {
    id                  = module.cosmos_account_cgn.id
    name                = module.cosmos_account_cgn.name
    resource_group_name = var.resource_group_name
  }
}

output "cosmos_account_cgn_endpoint" {
  value     = module.cosmos_account_cgn.endpoint
  sensitive = true
}

output "cosmos_account_cgn_primary_key" {
  value     = module.cosmos_account_cgn.primary_key
  sensitive = true
}
