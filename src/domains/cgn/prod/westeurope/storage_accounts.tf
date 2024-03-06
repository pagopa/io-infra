module "storage_accounts" {
  source = "../../_modules/storage_accounts"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_cgn.name

  subnet_pendpoints = module.networking.subnet_pendpoints.id

  tags = local.tags
}
