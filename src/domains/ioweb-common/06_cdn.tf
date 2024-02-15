# core domain external rg
data "azurerm_resource_group" "core_ext" {
  name = format("%s-rg-external", local.product)
}

data "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

module "landing_cdn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v7.2.1"

  name                             = "portal"
  prefix                           = local.project
  resource_group_name              = azurerm_resource_group.fe_rg.name
  location                         = azurerm_resource_group.fe_rg.location
  hostname                         = "ioapp.it"
  https_rewrite_enabled            = true
  storage_account_replication_type = "GZRS"

  index_document     = "index.html"
  error_404_document = "it/404/index.html"

  dns_zone_name                = data.azurerm_dns_zone.ioapp_it.name
  dns_zone_resource_group_name = data.azurerm_resource_group.core_ext.name

  keyvault_vault_name          = module.key_vault.name
  keyvault_resource_group_name = azurerm_resource_group.sec_rg.name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [
      {
        action = "Overwrite"
        name   = "Strict-Transport-Security"
        value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "script-src 'self' 'unsafe-inline'; worker-src 'none'; font-src data: 'self'; object-src 'none'; "
      }
    ]
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_cdn" {
  name                       = "${local.project}-cdn-diagnostic-settings"
  target_resource_id         = module.landing_cdn.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  enabled_log {
    category_group = "allLogs"
  }
}
