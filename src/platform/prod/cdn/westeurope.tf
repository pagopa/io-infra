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
module "legacy_assets_cdn_storage_account" {

  source = "github.com/pagopa/terraform-azurerm-v4//storage_account?ref=v1.23.3"

  name                            = replace("${local.project_weu_legacy}stcdnassets", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  account_replication_type        = "GZRS"
  resource_group_name             = local.core.resource_groups.westeurope.common
  location                        = "westeurope"
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = true
  public_network_access_enabled   = true

  index_document     = "index.html"
  error_404_document = "index.html"

  tags = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "legacy_assets_cdn_storage_account_diagnostic_setting" {

  depends_on = [module.legacy_assets_cdn_storage_account]

  target_resource_id         = "${module.legacy_assets_cdn_storage_account.id}/blobServices/default"
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
