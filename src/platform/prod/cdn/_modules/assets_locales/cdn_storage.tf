#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0058
#trivy:ignore:AZU-0061
module "cdn_storage" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0.0"

  resource_group_name = var.resource_group_common

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = "assets"
    instance_number = "01"
  }

  access_tier = "Hot"

  blob_features = {
    versioning = true
  }

  static_website = {
    enabled            = true
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  force_public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "legacy_assets_cdn_storage_account_diagnostic_setting" {

  depends_on = [module.cdn_storage]

  target_resource_id         = "${module.cdn_storage.id}/blobServices/default"
  name                       = "${var.prefix}${var.env_short}${var.location}assetsst01"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

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