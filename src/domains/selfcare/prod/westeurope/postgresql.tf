module "postgresql" {
  source = "../../_modules/postgresql"

  location = local.location
  project  = local.project

  resource_group_name = module.resource_groups.resource_group_selfcare_be.name

  dev_portal_subnet_id = module.networking.subnet_developer_portal.id

  tags = local.tags
}
