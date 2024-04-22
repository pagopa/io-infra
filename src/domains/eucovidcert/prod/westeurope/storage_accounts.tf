module "storage_accounts" {
  source = "../../_modules/storage_accounts"

  location            = local.location
  project             = local.project
  resource_group_name = module.resource_groups.resource_group_eucovidcert.name

  tags = local.tags
}
