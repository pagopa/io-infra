output "storage_account_cgn" {
  value = {
    id                  = module.storage_account_cgn.id
    name                = module.storage_account_cgn.name
    resource_group_name = module.storage_account_cgn.resource_group_name
  }
}

output "storage_account_cgn_primary_connection_string" {
  value     = module.storage_account_cgn.primary_connection_string
  sensitive = true
}
