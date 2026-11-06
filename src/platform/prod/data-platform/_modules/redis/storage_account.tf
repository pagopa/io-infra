#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0058
#trivy:ignore:AZU-0061
module "redis_common_backup_zrs" {
  source = "github.com/pagopa/terraform-azurerm-v4//storage_account?ref=v1.23.3"

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

resource "azurerm_monitor_diagnostic_setting" "redis_common_backup_zrs_diagnostic_setting" {

  depends_on = [module.redis_common_backup_zrs]

  target_resource_id         = "${module.redis_common_backup_zrs.id}/blobServices/default"
  name                       = try(local.nonstandard[var.location_short].storage_account, "${var.project}-redis-common-st-01")
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
