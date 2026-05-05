import {
  to = module.ioapp_cdn.azurerm_storage_account.ioweb_portal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-weu-ioweb-fe-rg/providers/Microsoft.Storage/storageAccounts/iopweuiowebportalsa"
}

import {
  to = module.ioapp_cdn.azurerm_monitor_metric_alert.ioweb_portal
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-weu-ioweb-fe-rg/providers/Microsoft.Insights/metricAlerts/[iopweuiowebportalsa] Low Availability"
}

module "ioapp_cdn" {
  source                         = "../_modules/ioapp_cdn"
  location                       = local.location_short.italynorth
  storage_account_location       = local.location.westeurope
  resource_group_cdn             = local.core.resource_groups.italynorth.common
  storage_account_resource_group = local.resource_groups.weu.ioweb
  # TODO: io-p-itn-common-log-01 - convert to terraform remote state once the monitoring infrastructure has been migrated to the new platform domain
  log_analytics_workspace_id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/microsoft.operationalinsights/workspaces/io-p-itn-common-log-01"
  tags                       = local.tags
}