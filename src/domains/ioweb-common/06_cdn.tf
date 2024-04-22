# core domain external rg
data "azurerm_resource_group" "core_ext" {
  name = format("%s-rg-external", local.product)
}

data "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

module "landing_cdn" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v7.59.0"

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
      },
      {
        action = "Overwrite"
        name   = "Cache-Control"
        value  = "no-cache"
      }
    ]
  }

  delivery_rule = [{
    name  = "TakeRootFilesFromStorage"
    order = 2
    request_uri_conditions = [{
      match_values = [
        "?",
      ]
      negate_condition = true
      operator         = "Contains"
      transforms       = []
      },
      {
        match_values = [
          "/",
        ]
        negate_condition = false
        operator         = "EndsWith"
        transforms       = []
      }
    ]

    url_redirect_actions = [{
      protocol      = "Https"
      query_string  = "refresh=true"
      redirect_type = "Found",
      fragment      = null
      hostname      = null
      path          = null
    }]

    cache_expiration_actions       = []
    cache_key_query_string_actions = []
    cookies_conditions             = []
    device_conditions              = []
    http_version_conditions        = []
    modify_request_header_actions  = []
    modify_response_header_actions = []
    post_arg_conditions            = []
    query_string_conditions        = []
    remote_address_conditions      = []
    request_body_conditions        = []
    request_header_conditions      = []
    request_method_conditions      = []
    request_scheme_conditions      = []
    url_file_extension_conditions  = []
    url_file_name_conditions       = []
    url_path_conditions            = []
    url_rewrite_actions            = []
  }]

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  tags = var.tags
}
