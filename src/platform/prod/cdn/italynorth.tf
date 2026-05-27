module "ioapp" {
  source                                   = "./_modules/ioapp"
  location                                 = local.location_short.italynorth
  storage_account_location                 = local.location.westeurope
  resource_group_cdn                       = local.core.resource_groups.italynorth.common
  storage_account_resource_group           = local.resource_groups.weu.ioweb
  log_analytics_workspace_id               = local.common.monitoring.itn.law_id
  ioapp_apex_certificate_kv_name           = local.core.key_vault.weu.tlscert_itn_01.name
  ioapp_apex_certificate_kv_resource_group = local.core.key_vault.weu.tlscert_itn_01.resource_group_name
  ioapp_apex_certificate_name              = "ioapp-it"
  tags                                     = local.tags
}
