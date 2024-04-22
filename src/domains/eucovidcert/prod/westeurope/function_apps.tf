module "function_apps" {
  source = "../../_modules/function_apps"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_eucovidcert.name

  subnet_id                                             = module.networking.subnet_eucovidcert.id
  storage_account_eucovidcert_primary_connection_string = module.storage_accounts.storage_account_eucovidcert_primary_connection_string

  tags = local.tags
}
