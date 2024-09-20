terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfinfprodio"
    container_name       = "terraform-state"
    key                  = "io-infra.redis-common.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

data "azurerm_storage_account" "redis_common_backup" {
  name                = "iopstredisbackup"
  resource_group_name = "io-p-rg-common"
}

resource "azurerm_redis_cache" "common" {
  name                          = "io-p-redis-common"
  resource_group_name           = "io-p-rg-common"
  location                      = "westeurope"
  capacity                      = 2
  shard_count                   = 4
  family                        = "P"
  sku_name                      = "Premium"
  subnet_id                     = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/rediscommon"
  public_network_access_enabled = true
  redis_version                 = "6"
  zones                         = null

  redis_configuration {
    authentication_enabled        = true
    rdb_backup_enabled            = true
    rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = data.azurerm_storage_account.redis_common_backup.primary_blob_connection_string

    data_persistence_authentication_method = "SAS"

    storage_account_subscription_id = "ec285037-c673-4f58-b594-d7c480da4e8b"
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

  lifecycle {
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }

  tags = {
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra"
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  }
}
