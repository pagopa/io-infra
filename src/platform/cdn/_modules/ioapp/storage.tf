# CDN storage, not used as origin at the moment for module.ioapp since is all exposed from cloudfront

resource "azurerm_storage_account" "ioweb_portal" {
  name                     = "iopweuiowebportalsa"
  access_tier              = "Hot"
  location                 = var.storage_account_location
  account_replication_type = "GZRS"
  account_tier             = "Standard"
  resource_group_name      = var.storage_account_resource_group
  tags                     = var.tags

  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true

  blob_properties {
    versioning_enabled = true
  }

  static_website {
    error_404_document = "it/404/index.html"
    index_document     = "index.html"
  }
}

resource "azurerm_monitor_metric_alert" "ioweb_portal" {
  name                = "[iopweuiowebportalsa] Low Availability"
  resource_group_name = var.storage_account_resource_group
  scopes              = [azurerm_storage_account.ioweb_portal.id]
  description         = "The average availability is less than 99.8%. Runbook: not needed."
  auto_mitigate       = false
  frequency           = "PT5M"
  severity            = 0
  tags                = var.tags

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 99.8
  }
}