output "storage_account_eucovidcert" {
  value = {
    id                  = module.storage_account_eucovidcert.id
    name                = module.storage_account_eucovidcert.name
    resource_group_name = var.resource_group_name
  }
}
