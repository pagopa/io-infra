module "common" {
  source                  = "./_modules/common"
  resource_group_cdn      = local.core.resource_groups.westeurope.common
  resource_group_external = local.core.resource_groups.westeurope.external
  public_dns_zones        = local.platform_core.dns.zones.public_dns_zones
  tags                    = local.tags
}

#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0061
resource "azurerm_storage_account" "legacy_assets_cdn_storage_account" {

  name         = replace("${local.project_weu_legacy}stcdnassets", "-", "")
  account_kind = "StorageV2"
  account_tier = "Standard"
  access_tier  = "Hot"
  blob_properties {
    versioning_enabled = true
  }
  account_replication_type = "GZRS"
  resource_group_name      = local.core.resource_groups.westeurope.common
  location                 = "westeurope"
  #advanced_threat_protection      = false
  allow_nested_items_to_be_public = true

  #index_document     = "index.html"
  #error_404_document = "index.html"

  tags = local.tags

}

resource "azurerm_monitor_metric_alert" "legacy_assets_cdn_storage_account_low_availability" {
  name                = "[${azurerm_storage_account.legacy_assets_cdn_storage_account.name}] Low Availability"
  resource_group_name = local.core.resource_groups.westeurope.common
  scopes              = [azurerm_storage_account.legacy_assets_cdn_storage_account.id]
  description         = "The average availability is less than 99.8%. Runbook: not needed."
  severity            = 0
  window_size         = "PT5M"
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace       = "Microsoft.Storage/storageAccounts"
    metric_name            = "Availability"
    aggregation            = "Average"
    operator               = "LessThan"
    threshold              = 99.8
    skip_metric_validation = false
  }

  tags = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "legacy_assets_cdn_storage_account_diagnostic_setting" {

  depends_on = [azurerm_storage_account.legacy_assets_cdn_storage_account]

  target_resource_id         = "${azurerm_storage_account.legacy_assets_cdn_storage_account.id}/blobServices/default"
  name                       = replace("${local.project_weu_legacy}stcdnassets", "-", "")
  log_analytics_workspace_id = local.platform_observability.monitoring_italynorth.log.id

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
