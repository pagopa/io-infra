module "ioapp" {
  source                                   = "./_modules/ioapp"
  location                                 = local.location_short.italynorth
  storage_account_location                 = local.location.westeurope
  resource_group_cdn                       = local.core.resource_groups.italynorth.common
  storage_account_resource_group           = local.resource_groups.weu.ioweb
  log_analytics_workspace_id               = local.common.monitoring.itn.law_id
  resource_group_external                  = local.core.resource_groups.westeurope.external
  public_dns_zones                         = local.common.public_dns_zones
  ioapp_apex_certificate_kv_name           = "io-p-ioweb-kv"     # TODO: switch to remote state
  ioapp_apex_certificate_kv_resource_group = "io-p-ioweb-sec-rg" # TODO: switch to remote state
  ioapp_apex_certificate_versionless_id    = ""                  # TODO: add id
  tags                                     = local.tags
}
