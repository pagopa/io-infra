module "redis_common_backup_zrs" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.27.0"

  name                            = try(local.nonstandard[var.location_short].storage_account, "${var.project}-redis-common-st-01")
  account_kind                    = "StorageV2"
  account_tier                    = "Premium"
  access_tier                     = "Hot"
  account_replication_type        = "ZRS"
  resource_group_name             = var.resource_group_common
  location                        = var.location
  advanced_threat_protection      = true
  use_legacy_defender_version     = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}
