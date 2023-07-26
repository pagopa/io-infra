resource "azurerm_dns_zone" "ioweb_it" {
  name                = "ioapp.it"
  resource_group_name = azurerm_resource_group.rg_external.name

  tags = var.tags
}

resource "azurerm_dns_caa_record" "ioweb_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec

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

# api.ioapp.it (api)
resource "azurerm_dns_a_record" "api_ioweb_it" {
  name                = "api"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}


# auth.ioapp.it (hub-spid-login)
resource "azurerm_dns_a_record" "app_backend_ioweb_it" {
  name                = "auth"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}