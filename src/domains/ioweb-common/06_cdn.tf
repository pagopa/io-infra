# module "landing_cdn" {
#   source = "github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v8.56.0"

#   name                             = "portal"
#   prefix                           = local.project
#   resource_group_name              = azurerm_resource_group.fe_rg.name
#   location                         = azurerm_resource_group.fe_rg.location
#   hostname                         = "ioapp.it"
#   https_rewrite_enabled            = true
#   storage_account_replication_type = "GZRS"

#   index_document     = "index.html"
#   error_404_document = "it/404/index.html"

#   advanced_threat_protection_enabled = false

#   dns_zone_name                = data.azurerm_dns_zone.ioapp_it.name
#   dns_zone_resource_group_name = data.azurerm_resource_group.core_ext.name

#   keyvault_vault_name          = module.key_vault.name
#   keyvault_resource_group_name = azurerm_resource_group.sec_rg.name
#   keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id

#   querystring_caching_behaviour = "BypassCaching"

#   global_delivery_rule = {
#     cache_expiration_action       = []
#     cache_key_query_string_action = []
#     modify_request_header_action  = []

#     # HSTS
#     modify_response_header_action = [
#       {
#         action = "Overwrite"
#         name   = "Strict-Transport-Security"
#         value  = "max-age=31536000"
#       },
#       # Content-Security-Policy (in Report mode)
#       {
#         action = "Append"
#         name   = "Content-Security-Policy"
#         value  = "script-src 'self' 'unsafe-inline'; worker-src 'none'; font-src data: 'self'; object-src 'none'; "
#       },
#       {
#         action = "Overwrite"
#         name   = "Cache-Control"
#         value  = "no-cache"
#       }
#     ]
#   }

#   delivery_rule = [{
#     name  = "TakeRootFilesFromStorage"
#     order = 2
#     request_uri_conditions = [{
#       match_values = [
#         "?",
#       ]
#       negate_condition = true
#       operator         = "Contains"
#       transforms       = []
#       },
#       {
#         match_values = [
#           "/",
#         ]
#         negate_condition = false
#         operator         = "EndsWith"
#         transforms       = []
#       }
#     ]

#     url_redirect_actions = [{
#       protocol      = "Https"
#       query_string  = "refresh=true"
#       redirect_type = "Found",
#       fragment      = null
#       hostname      = null
#       path          = null
#     }]

#     cache_expiration_actions       = []
#     cache_key_query_string_actions = []
#     cookies_conditions             = []
#     device_conditions              = []
#     http_version_conditions        = []
#     modify_request_header_actions  = []
#     modify_response_header_actions = []
#     post_arg_conditions            = []
#     query_string_conditions        = []
#     remote_address_conditions      = []
#     request_body_conditions        = []
#     request_header_conditions      = []
#     request_method_conditions      = []
#     request_scheme_conditions      = []
#     url_file_extension_conditions  = []
#     url_file_name_conditions       = []
#     url_path_conditions            = []
#     url_rewrite_actions            = []
#   }]

#   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

#   tags = var.tags
# }

moved {
  from = module.landing_cdn.azurerm_cdn_endpoint.this
  to = azurerm_cdn_endpoint.this
}

moved {
  from = module.landing_cdn.azurerm_cdn_profile.this
  to = azurerm_cdn_profile.this
}

moved {
  from = module.landing_cdn.azurerm_monitor_diagnostic_setting.diagnostic_settings_cdn_profile
  to = azurerm_monitor_diagnostic_setting.diagnostic_settings_cdn_profile
}


resource "azurerm_cdn_profile" "this" {
  location            = azurerm_resource_group.fe_rg.location
  name                = "${local.project}-portal-cdn-profile"
  resource_group_name = azurerm_resource_group.fe_rg.name
  sku                 = "Standard_Microsoft"
  tags = var.tags
}

resource "azurerm_cdn_endpoint" "this" {
  location                      = azurerm_resource_group.fe_rg.location
  name                          = "${local.project}-portal-cdn-endpoint"
  origin_host_header            = "ioapp.it"
  profile_name                  = azurerm_cdn_profile.this.name
  querystring_caching_behaviour = "BypassCaching"
  resource_group_name           = azurerm_resource_group.fe_rg.name
  tags = var.tags

  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1
    request_scheme_condition {
      match_values     = ["HTTP"]
      negate_condition = false
      operator         = "Equal"
    }
    url_redirect_action {
      protocol      = "Https"
      redirect_type = "Found"
    }
  }
  global_delivery_rule {
    modify_response_header_action {
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
    }
    modify_response_header_action {
      action = "Overwrite"
      name   = "Cache-Control"
      value  = "no-cache"
    }
  }
  origin {
    host_name  = "d2m1nc4792c1zk.cloudfront.net"
    http_port  = 80
    https_port = 443
    name       = "ioweb-aws-cloudfront"
  }
  origin {
    host_name  = "iopweuiowebportalsa.z6.web.core.windows.net"
    http_port  = 80
    https_port = 443
    name       = "primary"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_cdn_profile" {
  name                       = "${local.project}-portal-cdn-profile-diagnostic-settings"
  target_resource_id         = azurerm_cdn_profile.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"
  }
}

moved {
  from = module.landing_cdn.azurerm_dns_cname_record.apex_cdnverify[0]
  to = azurerm_dns_cname_record.apex_cdnverify
}

resource "azurerm_dns_cname_record" "apex_cdnverify" {
  name                = "cdnverify"
  record              = "cdnverify.${azurerm_cdn_endpoint.this.fqdn}"
  resource_group_name = data.azurerm_resource_group.core_ext.name
  zone_name           = data.azurerm_dns_zone.ioapp_it.name
  ttl                 = 3600
  tags                = var.tags
}

moved {
  from = module.landing_cdn.azurerm_dns_a_record.apex_hostname[0]
  to = azurerm_dns_a_record.apex_hostname
}

resource "azurerm_dns_a_record" "apex_hostname" {
  name                = "@"
  target_resource_id  = azurerm_cdn_endpoint.this.id
  zone_name           = data.azurerm_dns_zone.ioapp_it.name
  resource_group_name = data.azurerm_resource_group.core_ext.name
  tags                = var.tags
  ttl                 = 3600
}
