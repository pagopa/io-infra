locals {
  nonstandard = {
    weu = {
      cdne = "${var.project}-assets-cdn-endpoint"
    }
    itn = {
      cdne = "${var.project}-assets-cdn-endpoint"
    }
  }
  rewrite_rules = {
    organization_logos = {
      name            = "organizationlogosRewrite"
      source_pattern  = "/logos/organizations"
      rewrite_pattern = "/services"
      order           = 2
    }
    service_logos = {
      name            = "serviceslogosRewrite"
      source_pattern  = "/logos/services"
      rewrite_pattern = "/services"
      order           = 3
    }
    services_webview = {
      name            = "serviceswebviewRewrite"
      source_pattern  = "/services-webview"
      rewrite_pattern = "/services/services-webview"
      order           = 4
    }
  }
  caching_rules = {
    assistance_tools_zendesk = {
      name           = "assistancetoolszendeskCache"
      source_pattern = "/assistanceTools/zendesk.json"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 5
    }
    bonus = {
      name           = "bonusCache"
      source_pattern = "/bonus"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 6
    }
    servicesdata = {
      name           = "servicesdataCache"
      source_pattern = "/services-data"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 7
    }
    bonus = {
      name           = "statusCache"
      source_pattern = "/status"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 8
    }
  }
}
