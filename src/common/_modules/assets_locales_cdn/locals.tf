locals {
  redirect_rules = {
    organization_logos = {
      name             = "organizationlogosRewrite"
      source_pattern   = "/logos/organizations/"
      destination_host = "iopstcdnassets.blob.core.windows.net"
      destination_path = "/services/{url_path:seg2}"
      order            = 3
    }
    service_logos = {
      name             = "serviceslogosRewrite"
      source_pattern   = "/logos/services/"
      destination_host = "iopstcdnassets.blob.core.windows.net"
      destination_path = "/services/{url_path:seg2}"
      order            = 4
    }
    services_webview = {
      name             = "serviceswebviewRewrite"
      source_pattern   = "/services-webview/"
      destination_host = "iopstcdnassets.blob.core.windows.net"
      destination_path = "/services/{url_path}"
      order            = 5
    }
  }
  caching_rules = {
    assistance_tools_zendesk = {
      name           = "assistancetoolszendeskCache"
      source_pattern = "/assistanceTools/zendesk.json"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 6
    }
    bonus = {
      name           = "bonusCache"
      source_pattern = "/bonus"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 7
    }
    servicesdata = {
      name           = "servicesdataCache"
      source_pattern = "/services-data"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:15:00"
      order          = 8
    }
    status = {
      name           = "statusCache"
      source_pattern = "/status"
      cache_behavior = "OverrideAlways"
      cache_duration = "00:05:00"
      order          = 9
    }
  }
}
