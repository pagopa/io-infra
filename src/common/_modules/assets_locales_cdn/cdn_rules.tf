resource "azurerm_cdn_frontdoor_rule_set" "primary_ruleset" {
  name                     = "primaryruleset"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_profile.id
}

resource "azurerm_cdn_frontdoor_rule" "assistancetoolszendesk" {
  name                      = "assistancetoolszendesk"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  order                     = 5

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = ["/assistanceTools/zendesk.json"]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "bonus" {
  name                      = "bonus"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  order                     = 3

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = ["/bonus"]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "global_cache" {
  name                      = "globalcache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  order                     = 1

  # Matches all requests
  conditions {
    request_uri_condition {
      operator     = "Any"
      match_values = ["*"]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "08:00:00" # 8 hours
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "servicesdata" {
  name                      = "servicesdata"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  order                     = 2

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = ["/services-data"]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "sign" {
  name                      = "sign"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
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

resource "azurerm_cdn_frontdoor_rule" "status" {
  name                      = "status"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.primary_ruleset.id
  order                     = 4

  conditions {
    request_uri_condition {
      operator     = "BeginsWith"
      match_values = ["/status"]
    }
  }

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
    }
  }
}