module "cdn_selfcare" {
  source = "github.com/pagopa/terraform-azurerm-v3//cdn?ref=v7.69.1"

  name                  = "selfcare"
  prefix                = var.project
  resource_group_name   = var.resource_group_name
  location              = var.location
  hostname              = var.dns_zone_name
  https_rewrite_enabled = true

  index_document     = "index.html"
  error_404_document = "404.html"

  storage_account_replication_type = "GZRS"

  dns_zone_name                = data.azurerm_dns_zone.io_selfcare_pagopa_it.name
  dns_zone_resource_group_name = data.azurerm_dns_zone.io_selfcare_pagopa_it.resource_group_name

  keyvault_vault_name          = data.azurerm_key_vault.key_vault_io.name
  keyvault_resource_group_name = data.azurerm_key_vault.key_vault_io.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' https://www.google.com https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; worker-src 'none'; font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://assets.cdn.io.italia.it data:; "
      }
    ]
  }

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law_common.id

  tags = var.tags
}
