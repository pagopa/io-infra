resource "azurerm_dns_zone" "io_italia_it" {
  name                = join(".", [var.dns_zone_io, "italia.it"])
  resource_group_name = azurerm_resource_group.rg_external.name

  tags = var.tags
}

resource "azurerm_dns_caa_record" "io_italia_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
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

  tags = var.tags
}

# application gateway records
# developerportal-backend.io.italia.it
resource "azurerm_dns_a_record" "developerportal_backend_io_italia_it" {
  name                = "developerportal-backend"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}

# api.io.italia.it
resource "azurerm_dns_a_record" "api_io_italia_it" {
  name                = "api"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}

# app-backend.io.italia.it
resource "azurerm_dns_a_record" "app_backend_io_italia_it" {
  name                = "app-backend"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}

# TXT for zendeskverification.io.italia.it
resource "azurerm_dns_txt_record" "zendeskverification_io_italia_it" {
  name                = "zendeskverification"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
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
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:musvc.com include:_spf.google.com include:mail.zendesk.com -all"
  }
  tags = var.tags
}

# CNAME for mailup sender
resource "azurerm_dns_cname_record" "sender" {
  name                = "sender"
  zone_name           = azurerm_dns_zone.io_italia_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  record              = "bounce.musvc.com"
}