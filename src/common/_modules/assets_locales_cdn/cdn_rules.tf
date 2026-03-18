## Global cache

resource "azurerm_cdn_frontdoor_rule" "global_cache" {
  name                      = "globalCache"
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior                = "OverrideAlways"
      cache_duration                = "08:00:00" # 8 hours
      query_string_caching_behavior = "IgnoreQueryString"
    }
  }
}

## Origin rules

resource "azurerm_cdn_frontdoor_rule" "sign_origin" {
  name                      = "signOrigin"
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = 2

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/sign"]
      transforms   = ["Lowercase"]
    }
  }

  actions {
    response_header_action {
      header_action = "Append"
      header_name   = "Access-Control-Allow-Origin"
      value         = "*"
    }
  }
}

## Caching rules

resource "azurerm_cdn_frontdoor_rule" "caching_rules" {

  for_each = local.caching_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = each.value.order

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = [each.value.source_pattern]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior                = each.value.cache_behavior
      cache_duration                = each.value.cache_duration
      query_string_caching_behavior = "IgnoreQueryString"
    }
  }
}

## Redirect rules

resource "azurerm_cdn_frontdoor_rule" "redirect_rules" {
  for_each = local.redirect_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = each.value.order

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = [each.value.source_pattern]
    }
  }

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = each.value.destination_host
      destination_path     = each.value.destination_path
    }
  }
}
