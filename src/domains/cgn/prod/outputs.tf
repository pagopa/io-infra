output "resource_group_cgn" {
  value = {
    id   = module.resource_groups.resource_group_cgn.id
    name = module.resource_groups.resource_group_cgn.name
  }
}

output "resource_group_cgn_be" {
  value = {
    id   = module.resource_groups.resource_group_cgn_be.id
    name = module.resource_groups.resource_group_cgn_be.name
  }
}

output "cosmos_cgn" {
  value = {
    id   = module.cosmos.cosmos_account_cgn.id
    name = module.cosmos.cosmos_account_cgn.name
  }
}

output "storage_account_cgn" {
  value = {
    id   = module.storage_accounts.storage_account_cgn.id
    name = module.storage_accounts.storage_account_cgn.name
  }
}

output "storage_account_legal_backup" {
  value = {
    id   = module.storage_accounts.storage_account_legal_backup.id
    name = module.storage_accounts.storage_account_legal_backup.name
  }
}
