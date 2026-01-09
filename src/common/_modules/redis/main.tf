resource "azurerm_redis_cache" "common" {
  name                          = try(local.nonstandard[var.location_short].redis_common, "${var.project}-common-redis-01")
  resource_group_name           = var.resource_group_common
  location                      = var.location
  capacity                      = 2
  shard_count                   = 4
  family                        = "P"
  sku_name                      = "Premium"
  subnet_id                     = azurerm_subnet.redis.id
  public_network_access_enabled = true
  redis_version                 = "6"
  zones                         = null

  redis_configuration {
    authentication_enabled                 = true
    rdb_backup_enabled                     = true
    rdb_backup_frequency                   = 60
    rdb_backup_max_snapshot_count          = 1
    rdb_storage_connection_string          = module.redis_common_backup_zrs.primary_blob_connection_string
    data_persistence_authentication_method = "SAS"
    storage_account_subscription_id        = "ec285037-c673-4f58-b594-d7c480da4e8b"
  }

  patch_schedule {
    day_of_week    = "Sunday"
    start_hour_utc = 23
  }
  patch_schedule {
    day_of_week    = "Monday"
    start_hour_utc = 23
  }
  patch_schedule {
    day_of_week    = "Tuesday"
    start_hour_utc = 23
  }
  patch_schedule {
    day_of_week    = "Wednesday"
    start_hour_utc = 23
  }
  patch_schedule {
    day_of_week    = "Thursday"
    start_hour_utc = 23
  }

  # NOTE: There's a bug in the Redis API where the original storage connection string isn't being returned,
  # which is being tracked here [https://github.com/Azure/azure-rest-api-specs/issues/3037].
  # At first import/creation, apply without the lifecyle, add it later. Connection string
  # should be about the blob storage
  lifecycle {
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }

  tags = var.tags
}


module "common_values" {
  source = "github.com/pagopa/io-infra//src/_modules/common_values?ref=main"
}