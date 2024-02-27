module "redis" {
  source = "../../_modules/redis"

  env_short           = local.env_short
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_cgn.name

  tags = local.tags
}
