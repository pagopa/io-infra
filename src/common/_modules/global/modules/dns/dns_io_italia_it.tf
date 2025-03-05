resource "azurerm_dns_zone" "io_italia_it" {
  name                = join(".", [var.dns_zones.io, "italia.it"])
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "io_italia_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazon.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazontrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "awstrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazonaws.com"
  }

  tags = var.tags
}

# application gateway records
# developerportal-backend.io.italia.it
resource "azurerm_dns_a_record" "developerportal_backend_io_italia_it" {
  name                = "developerportal-backend"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# api.io.italia.it
resource "azurerm_dns_a_record" "api_io_italia_it" {
  name                = "api"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# app-backend.io.italia.it
resource "azurerm_dns_a_record" "app_backend_io_italia_it" {
  name                = "app-backend"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# api-internal.io.italia.it
resource "azurerm_dns_a_record" "api_internal_io_italia_it" {
  name                = "api-internal"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 10 # var.dns_default_ttl_sec
  records             = [var.apim_v2_private_ip]

  tags = var.tags
}

# TXT for zendeskverification.io.italia.it
resource "azurerm_dns_txt_record" "zendeskverification_io_italia_it" {
  name                = "zendeskverification"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "1da62a0d3c1426ec"
  }
  tags = var.tags
}

# TXT for io.italia.it
resource "azurerm_dns_txt_record" "io_italia_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:musvc.com include:_spf.google.com include:mail.zendesk.com -all"
  }

  record {
    value = "google-site-verification=mCszyWBbGJY2zYcNJ7nJenQwuaSebRDYnsBaeN2vVGw"
  }
  tags = var.tags
}

# CNAME for mailup sender
resource "azurerm_dns_cname_record" "sender" {
  name                = "sender"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "bounce.musvc.com"
}

# CNAME for firma con io AWS certificate
resource "azurerm_dns_cname_record" "firmaconio" {
  name                = "_c8fedcbb95e9a1a9970e790248192e40.firma"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "_cb7cf3d1c765ecd7191512dc77371b57.djqtsrsxkq.acm-validations.aws."
}