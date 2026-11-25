resource "azurerm_cdn_frontdoor_rule" "ioapp_global_transport_security" {
  name                      = "GlobalTransportSecurity"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 0

  actions {
    modify_response_header {
      operator     = "Overwrite"
      header_name  = "Strict-Transport-Security"
      header_value = "max-age=31536000"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_global_cache" {
  name                      = "GlobalCache"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 1

  actions {
    route_configuration_override {
      caching {
        behaviour              = "OverrideAlways"
        duration               = "00:15:00"
        query_string_behaviour = "IgnoreQueryString"
      }
    }

    modify_response_header {
      operator     = "Overwrite"
      header_name  = "Cache-Control"
      header_value = "no-cache"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_spid_metadata_redirect" {
  name                      = "SpidMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 2

  conditions {
    request_path {
      operator = "Equal"
      values   = ["login/spid-metadata.xml"]
    }
  }

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "MatchRequest"
      destination_host_name = "account.ioapp.it"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "ioapp_cie_metadata_redirect" {
  name                      = "CieMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.ioapp.rule_set_id
  order                     = 3

  conditions {
    request_path {
      operator = "Equal"
      values   = ["login/cie-metadata.xml"]
    }
  }

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "MatchRequest"
      destination_host_name = "account.ioapp.it"
    }
  }
}