module "storage_accounts" {
  source = "../_modules/storage_accounts"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_cgn.name

  subnet_pendpoints_id = module.networking.subnet_pendpoints.id

  environment   = local.itn_environment
  resource_group_common = module.common_values.resource_groups.weu.common

  tags = local.tags
}
