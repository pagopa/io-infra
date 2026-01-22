## Caching Rules

resource "azurerm_cdn_frontdoor_rule" "global_cache" {
  name                      = "globalCache"
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "08:00:00" # 8 hours
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "caching_rules" {

  for_each = local.caching_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = each.value.order

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = [each.value.source_pattern]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = each.value.cache_behavior
      cache_duration = each.value.cache_duration
    }
  }
}

## Rewrite rules

resource "azurerm_cdn_frontdoor_rule" "rewrite_rules" {
  for_each = local.rewrite_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = each.value.order

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = [each.value.source_pattern]
    }
  }
  actions {
    url_rewrite_action {
      source_pattern = each.value.source_pattern
      destination    = each.value.rewrite_pattern
    }
  }
}

## Origin rules

resource "azurerm_cdn_frontdoor_rule" "sign" {
  name                      = "sign"
  cdn_frontdoor_rule_set_id = module.azure_cdn.rule_set_id
  order                     = 6

  conditions {
    request_uri_condition {
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