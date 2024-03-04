module "functions" {
  source = "../../_modules/functions"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_be_cgn.name

  subnet_id                   = module.networking.subnet_cgn.id
  subnet_private_endpoints_id = module.networking.subnet_pendpoints.id

  cosmos_db = {
    endpoint    = module.cosmos.endpoint
    primary_key = module.cosmos.primary_key
  }

  redis = {
    hostname           = module.redis.hostname
    ssl_port           = module.redis.ssl_port
    primary_access_key = module.redis.primary_access_key
  }

  cgn_storage_account_connection_string = module.storage_accounts.storage_account_connection_string

  tags = local.tags

  depends_on = [
    module.cosmos,
    module.redis
  ]
}
