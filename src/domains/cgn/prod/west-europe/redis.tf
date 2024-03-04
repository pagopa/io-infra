module "redis" {
  source = "../../_modules/redis"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_cgn.name

  vnet_redis_id   = module.networking.vnet_common.id
  subnet_redis_id = module.networking.subnet_cgn.id

  tags = local.tags
}
