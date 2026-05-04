module "landing_cdn" {
  source              = "pagopa-dx/azure-cdn/azurerm"
  version             = "~> 0.0"
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name

  origins = {
    custom-origin = {

      host_name = "d2m1nc4792c1zk.cloudfront.net"
      priority  = 1

    }
  }

  custom_domains = [
    {
      host_name = "ioapp.it"
      # TODO: enable dns block / import txt validation records 
      /*
      dns = {
        zone_name                = data.azurerm_dns_zone.ioapp_it.name
        zone_resource_group_name = data.azurerm_resource_group.core_ext.name
      }
      */
    }
  ]

  diagnostic_settings = {
    enabled                    = true
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  }

  environment = {
    prefix          = "io"
    env_short       = "p"
    location        = local.itn_location
    app_name        = "ioweb"
    instance_number = "01"
  }
  tags = var.tags
}

resource "azurerm_cdn_frontdoor_rule" "landing_cdn_global_transport_security" {
  name                      = "GlobalTransportSecurity"
  cdn_frontdoor_rule_set_id = module.landing_cdn.rule_set_id
  order                     = 0

  actions {
    response_header_action {
      header_action = "Overwrite"
      header_name   = "Strict-Transport-Security"
      value         = "max-age=31536000"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "landing_cdn_global_cache" {
  name                      = "GlobalCache"
  cdn_frontdoor_rule_set_id = module.landing_cdn.rule_set_id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
    }

    response_header_action {
      header_action = "Overwrite"
      header_name   = "Cache-Control"
      value         = "no-cache"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "landing_cdn_spid_metadata_redirect" {
  name                      = "SpidMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.landing_cdn.rule_set_id
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

resource "azurerm_cdn_frontdoor_rule" "landing_cdn_cie_metadata_redirect" {
  name                      = "CieMetadataRedirect"
  cdn_frontdoor_rule_set_id = module.landing_cdn.rule_set_id
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

