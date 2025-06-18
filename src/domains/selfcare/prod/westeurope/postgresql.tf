module "postgresql" {
  source = "../../_modules/postgresql"

  location = local.location
  project  = local.project

  resource_group_name = module.resource_groups.resource_group_selfcare_be.name

  tags = local.tags
}
