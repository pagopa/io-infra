resource "azurerm_cdn_frontdoor_rule" "ioapp_global_transport_security" {
  name                      = "GlobalTransportSecurity"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 0

  actions {
    response_header_action {
      header_action = "Overwrite"
      header_name   = "Strict-Transport-Security"
      value         = "max-age=31536000"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_global_cache" {
  name                      = "GlobalCache"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior                = "OverrideAlways"
      cache_duration                = "00:15:00"
      query_string_caching_behavior = "IgnoreQueryString"
    }

    response_header_action {
      header_action = "Overwrite"
      header_name   = "Cache-Control"
      value         = "no-cache"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_spid_metadata_redirect" {
  name                      = "SpidMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 2

  conditions {
    url_path_condition {
      operator         = "Equal"
      match_values     = ["login/spid-metadata.xml"]
      negate_condition = false
    }
  }

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "MatchRequest"
      destination_hostname = "account.ioapp.it"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_cie_metadata_redirect" {
  name                      = "CieMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 3

  conditions {
    url_path_condition {
      operator         = "Equal"
      match_values     = ["login/cie-metadata.xml"]
      negate_condition = false
    }
  }

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "MatchRequest"
      destination_hostname = "account.ioapp.it"
    }
  }
}