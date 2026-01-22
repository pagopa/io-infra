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
      name            = "organization-logos-rewrite-rule"
      source_pattern  = "/logos/organizations"
      rewrite_pattern = "/services"
      order           = 2
    }
    service_logos = {
      name            = "service-logos-rewrite-rule"
      source_pattern  = "/logos/services"
      rewrite_pattern = "/services"
      order           = 3
    }
    services_webview = {
      name            = "services-webview-rewrite-rule"
      source_pattern  = "/services-webview"
      rewrite_pattern = "/services/services-webview"
      order           = 4
    }
  }
  caching_rules = {
    assistance_tools_zendesk = {
      name           = "assistance-tools-zendesk-cache-rule"
      source_pattern = "/assistanceTools/zendesk.json"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 5
    }
    bonus = {
      name           = "bonus-cache-rule"
      source_pattern = "/bonus"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 6
    }
    servicesdata = {
      name           = "services-data-cache-rule"
      source_pattern = "/services-data"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 7
    }
    bonus = {
      name           = "status-cache-rule"
      source_pattern = "/status"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 8
    }
  }
}
