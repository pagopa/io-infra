output "storage_account_legal_backup" {
  value = {
    id                  = module.storage_account_legal_backup.id
    name                = module.storage_account_legal_backup.name
    resource_group_name = module.storage_account_legal_backup.resource_group_name
  }
}

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

output "storage_account_legal_backup_primary_connection_string" {
  value     = module.storage_account_legal_backup.primary_connection_string
  sensitive = true
}
