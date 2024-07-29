terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.113.0"
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

module "redis_common" {
  source = "github.com/pagopa/terraform-azurerm-v3//redis_cache?ref=v8.27.0"

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

  backup_configuration = {
    frequency                 = 60
    max_snapshot_count        = 1
    storage_connection_string = data.azurerm_storage_account.redis_common_backup.primary_connection_string
  }

  # when azure can apply patch?
  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]

  # only for this redis we use vnet integration (legacy configuration)
  # DO NOT COPY THIS CONFIGURATION FOR NEW REDIS CACHE
  private_endpoint = {
    enabled              = false
    virtual_network_id   = ""
    subnet_id            = ""
    private_dns_zone_ids = [""]
  }

  tags = {
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra"
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  }
}
