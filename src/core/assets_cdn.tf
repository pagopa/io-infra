resource "azurerm_resource_group" "assets_cdn_rg" {
  name     = "${local.project}-assets-cdn-rg"
  location = var.location

  tags = var.tags
}

module "assets_cdn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v4.1.15"

  name                            = replace(format("%s-stcdnassets", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  account_replication_type        = "GRS"
  resource_group_name             = azurerm_resource_group.rg_common.name
  location                        = azurerm_resource_group.rg_common.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = true

  tags = var.tags
}

resource "azurerm_cdn_profile" "assets_cdn_profile" {
  name                = "${local.project}-assets-cdn-profile"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

data "azurerm_key_vault_secret" "assets_cdn_fn_key_cdn" {
  name         = "${module.function_assets_cdn.name}-KEY-CDN"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_cdn_endpoint" "assets_cdn_endpoint" {
  name                          = "${local.project}-assets-cdn-endpoint"
  resource_group_name           = azurerm_resource_group.assets_cdn_rg.name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.assets_cdn_profile.name
  is_https_allowed              = true
  is_http_allowed               = false
  querystring_caching_behaviour = "IgnoreQueryString"
  origin_host_header            = module.function_assets_cdn.default_hostname

  origin {
    name      = "primary"
    host_name = module.function_assets_cdn.default_hostname
  }

  global_delivery_rule {
    cache_expiration_action {
      behavior = "Override"
      duration = "08:00:00"
    }

    modify_request_header_action {
      action = "Append"
      name   = "x-functions-key"
      value  = data.azurerm_key_vault_secret.assets_cdn_fn_key_cdn.value
    }
  }

  delivery_rule {
    name  = "servicesdata"
    order = 1
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/services-data"]
    }
    cache_expiration_action {
      behavior = "Override"
      duration = "00:15:00"
    }
  }

  delivery_rule {
    name  = "bonus"
    order = 2
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/bonus"]
    }
    cache_expiration_action {
      behavior = "Override"
      duration = "00:15:00"
    }
  }

  delivery_rule {
    name  = "status"
    order = 3
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/status"]
    }
    cache_expiration_action {
      behavior = "Override"
      duration = "00:05:00"
    }
  }

  delivery_rule {
    name  = "assistancetoolszendesk"
    order = 4
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/assistanceTools/zendesk.json"]
    }
    cache_expiration_action {
      behavior = "Override"
      duration = "00:05:00"
    }
  }

  tags = var.tags
}

resource "azurerm_dns_cname_record" "assets_cdn_io_pagopa_it" {
  name                = "assets.cdn"
  zone_name           = azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  record              = azurerm_cdn_endpoint.assets_cdn_endpoint.fqdn

  tags = var.tags
}

resource "azurerm_cdn_endpoint_custom_domain" "assets_cdn" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_pagopa_it,
  ]

  name            = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, var.external_domain])}", ".", "-")
  cdn_endpoint_id = azurerm_cdn_endpoint.assets_cdn_endpoint.id
  host_name       = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, var.external_domain])}"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}

resource "azurerm_dns_cname_record" "assets_cdn_io_italia_it" {
  name                = "assets.cdn"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  record              = azurerm_cdn_endpoint.assets_cdn_endpoint.fqdn

  tags = var.tags
}

resource "azurerm_cdn_endpoint_custom_domain" "assets_cdn_io_italia_it" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_italia_it,
  ]

  name            = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, "italia.it"])}", ".", "-")
  cdn_endpoint_id = azurerm_cdn_endpoint.assets_cdn_endpoint.id
  host_name       = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${join(".", [var.dns_zone_io, "italia.it"])}"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}
