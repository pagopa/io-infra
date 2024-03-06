module "cdn" {
  source = "../../_modules/cdn"

  location = local.location
  project  = local.project

  resource_group_name = module.resource_groups.resource_group_selfcare_fe.name

  tags = local.tags
}
