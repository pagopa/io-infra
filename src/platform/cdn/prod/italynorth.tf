module "ioapp" {
  source                         = "../_modules/ioapp"
  location                       = local.location_short.italynorth
  storage_account_location       = local.location.westeurope
  resource_group_cdn             = local.core.resource_groups.italynorth.common
  storage_account_resource_group = local.resource_groups.weu.ioweb
  # TODO: io-p-itn-common-log-01 - convert to terraform remote state once the monitoring infrastructure has been migrated to the new platform domain
  log_analytics_workspace_id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.OperationalInsights/workspaces/io-p-itn-common-log-01"
  tags                       = local.tags
}