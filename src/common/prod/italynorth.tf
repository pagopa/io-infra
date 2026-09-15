module "assets_locales_cdn" {
  source = "../_modules/assets_locales_cdn"

  location                = "italynorth"
  project                 = local.project_itn
  subscription_id         = data.azurerm_subscription.current.subscription_id
  resource_group_common   = local.core.resource_groups.italynorth.common
  resource_group_cdn      = local.core.resource_groups.italynorth.assets_cdn
  resource_group_external = "io-p-rg-external"

  public_dns_zones                       = local.platform_core.dns.zones.public_dns_zones
  log_analytics_workspace_id             = local.platform_observability.monitoring_italynorth.log.id
  diagnostic_settings_storage_account_id = local.platform_observability.storage_accounts.itn.logs.id

  azure_adgroups_roles = {
    svc_devs = {
      azureadgroup_id = data.azuread_group.svc_devs.object_id
      role            = "writer"
    }
  }

  tags = local.tags
}
