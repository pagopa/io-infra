module "postgresql" {
  source = "../../_modules/postgresql"

  location = local.location
  project  = local.project

  resource_group_name = module.resource_groups.resource_group_selfcare_be.name

  vnet_id                    = module.networking.vnet_common.id
  dev_portal_subnet_id       = module.networking.subnet_developer_portal.id
  private_endpoint_subnet_id = module.networking.subnet_pendpoints.id

  tags = local.tags
}
