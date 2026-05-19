module "ioapp" {
  source                         = "./_modules/ioapp"
  location                       = local.location_short.italynorth
  storage_account_location       = local.location.westeurope
  resource_group_cdn             = local.core.resource_groups.italynorth.common
  storage_account_resource_group = local.resource_groups.weu.ioweb
  log_analytics_workspace_id     = local.common.monitoring.itn.law_id
  tags                           = local.tags
}
