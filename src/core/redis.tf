module "redis_common_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"

  name                                      = "rediscommon"
  address_prefixes                          = var.cidr_subnet_redis_common
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = data.azurerm_virtual_network.common.name
  private_endpoint_network_policies_enabled = true
}

module "redis_common_backup_zrs" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.27.0"

  name                            = replace(format("%s-stredisbackup", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Premium"
  access_tier                     = "Hot"
  account_replication_type        = "ZRS"
  resource_group_name             = azurerm_resource_group.rg_common.name
  location                        = azurerm_resource_group.rg_common.location
  advanced_threat_protection      = true
  use_legacy_defender_version     = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

data "azurerm_redis_cache" "redis_common" {
  name                = format("%s-redis-common", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
}
