output "storage_account_eucovidcert" {
  value = {
    id                  = module.storage_account_eucovidcert.id
    name                = module.storage_account_eucovidcert.name
    resource_group_name = var.resource_group_name
  }
}

output "storage_account_eucovidcert_primary_connection_string" {
  value     = module.storage_account_eucovidcert.primary_connection_string
  sensitive = true
}
