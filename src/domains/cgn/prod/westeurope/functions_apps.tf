module "functions" {
  source = "../../_modules/functions_apps"

  project             = local.project
  location            = local.location
  resource_group_name = module.resource_groups.resource_group_cgn_be.name

  subnet_id                   = module.networking.subnet_cgn.id
  subnet_private_endpoints_id = module.networking.subnet_pendpoints.id

  cosmos_db = {
    endpoint    = module.cosmos.cosmos_account_cgn_endpoint
    primary_key = module.cosmos.cosmos_account_cgn_primary_key
  }

  redis = {
    hostname           = module.redis.redis_cgn.hostname
    ssl_port           = module.redis.redis_cgn.ssl_port
    primary_access_key = module.redis.redis_cgn_primary_access_key
  }

  cgn_storage_account_connection_string = module.storage_accounts.storage_account_cgn_primary_connection_string

  tags = local.tags
}
