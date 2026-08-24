module "ioapp" {
  source                                   = "./_modules/ioapp"
  location                                 = local.location_short.italynorth
  storage_account_location                 = local.location.westeurope
  resource_group_cdn                       = local.core.resource_groups.italynorth.common
  storage_account_resource_group           = local.resource_groups.weu.ioweb
  log_analytics_workspace_id               = local.platform_observability.monitoring_italynorth.log.id
  ioapp_apex_certificate_kv_name           = local.core.key_vault.weu.tlscert_itn_01.name
  ioapp_apex_certificate_kv_resource_group = local.core.key_vault.weu.tlscert_itn_01.resource_group_name
  ioapp_apex_certificate_name              = "ioapp-it"
  resource_group_external                  = local.core.resource_groups.westeurope.external
  public_dns_zones                         = local.platform_core.dns.zones.public_dns_zones
  tags                                     = local.tags
}

module "assets_locales" {
  source = "./_modules/assets_locales"

  location                = local.location.italynorth
  project                 = local.project_itn
  subscription_id         = data.azurerm_subscription.current.subscription_id
  resource_group_common   = local.core.resource_groups.italynorth.common
  resource_group_cdn      = local.core.resource_groups.italynorth.assets_cdn
  resource_group_external = local.core.resource_groups.westeurope.external

  public_dns_zones                       = local.common.public_dns_zones
  log_analytics_workspace_id             = local.common.monitoring.itn.law_id
  diagnostic_settings_storage_account_id = local.common.storage_accounts.logs_itn.id

  azure_adgroups_roles = {
    svc_devs = {
      azureadgroup_id = data.azuread_group.svc_devs.object_id
      role            = "writer"
    }
  }

  tags = local.tags
}
