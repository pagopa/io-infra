## Ruleset

resource "azurerm_cdn_frontdoor_rule_set" "assets_locales_ruleset" {
  name                     = "ruleset"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id
}

## Global cache

resource "azurerm_cdn_frontdoor_rule" "global_cache" {
  name                      = "globalCache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_locales_ruleset.id
  order                     = 1

  actions {
    route_configuration_override {
      caching {
        behaviour              = "OverrideAlways"
        duration               = "08:00:00" # 8 hours
        query_string_behaviour = "IgnoreQueryString"
      }
    }
  }
}

## Origin rules

resource "azurerm_cdn_frontdoor_rule" "sign_origin" {
  name                      = "signOrigin"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_locales_ruleset.id
  order                     = 2

  conditions {
    request_path {
      operator   = "BeginsWith"
      values     = ["/sign"]
      transforms = ["Lowercase"]
    }
  }

  actions {
    modify_response_header {
      operator     = "Append"
      header_name  = "Access-Control-Allow-Origin"
      header_value = "*"
    }
  }
}

## Caching rules

resource "azurerm_cdn_frontdoor_rule" "caching_rules" {

  for_each = local.caching_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_locales_ruleset.id
  order                     = each.value.order

  conditions {
    request_path {
      operator = "BeginsWith"
      values   = [each.value.source_pattern]
    }
  }

  actions {
    route_configuration_override {
      caching {
        behaviour              = each.value.cache_behavior
        duration               = each.value.cache_duration
        query_string_behaviour = "IgnoreQueryString"
      }
    }
  }
}

## Redirect rules

resource "azurerm_cdn_frontdoor_rule" "redirect_rules" {
  for_each = local.redirect_rules

  name                      = each.value.name
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_locales_ruleset.id
  order                     = each.value.order

  conditions {
    request_path {
      operator = "BeginsWith"
      values   = [each.value.source_pattern]
    }
  }

  actions {
    url_redirect {
      redirect_type         = "TemporaryRedirect"
      redirect_protocol     = "Https"
      destination_host_name = each.value.destination_host
      destination_path      = each.value.destination_path
    }
  }
}
