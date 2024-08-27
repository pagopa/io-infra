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

output "function_app_cgn" {
  value = {
    id   = module.functions.function_app_cgn.id
    name = module.functions.function_app_cgn.name
  }
}

output "function_app_cgn_merchant" {
  value = {
    id   = module.functions.function_app_cgn_merchant.id
    name = module.functions.function_app_cgn_merchant.name
  }
}

output "redis" {
  value = {
    id   = module.redis.redis_cgn.id
    name = module.redis.redis_cgn.name
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
