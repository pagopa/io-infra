output "resource_group_eucovidcert" {
  value = {
    id   = module.resource_groups.resource_group_eucovidcert.id
    name = module.resource_groups.resource_group_eucovidcert.name
  }
}

output "function_app_eucovidcert" {
  value = {
    id   = module.function_apps.function_app_eucovidcert.id
    name = module.function_apps.function_app_eucovidcert.name
  }
}

output "storage_account_eucovidcert" {
  value = {
    id   = module.storage_accounts.storage_account_eucovidcert.id
    name = module.storage_accounts.storage_account_eucovidcert.name
  }
}
