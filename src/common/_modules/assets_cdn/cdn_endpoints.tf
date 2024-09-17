resource "azurerm_cdn_endpoint" "assets_cdn_endpoint" {
  name                          = try(local.nonstandard[var.location_short].cdne, "${var.project}-assets-cdne-01")
  resource_group_name           = azurerm_resource_group.assets_cdn_rg.name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.assets_cdn_profile.name
  is_https_allowed              = true
  is_http_allowed               = false
  querystring_caching_behaviour = "IgnoreQueryString"
  origin_host_header            = var.assets_cdn_fn.hostname

  origin {
    name      = "primary"
    host_name = var.assets_cdn_fn.hostname
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

  delivery_rule {
    name  = "sign"
    order = 5
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/sign"]
      transforms   = ["Lowercase"]
    }
    modify_response_header_action {
      action = "Append"
      name   = "Access-Control-Allow-Origin"
      value  = "*"
    }
  }

  tags = var.tags
}

