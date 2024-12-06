resource "azurerm_dns_zone" "account_ioapp_it" {
  name                = "account.ioapp.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "account_ioapp_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.account_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

# A record for account.ioapp.it
data "azurerm_cdn_frontdoor_profile" "io_web_profile_itn_cdn_profile" {
  name                = format("%s-ioweb-profile-portal-afd-01", var.project)
  resource_group_name = format("%s-itn-ioweb-fe-rg-01", var.project)
}

data "azurerm_cdn_frontdoor_endpoint" "io_web_profile_itn_cdn_endpoint" {
  name                = format("%s-itn-ioweb-profile-fde-01", var.project)
  resource_group_name = format("%s-itn-ioweb-fe-rg-01", var.project)
  profile_name        = data.azurerm_cdn_frontdoor_profile.io_web_profile_itn_cdn_profile.name
}

data "azurerm_cdn_frontdoor_custom_domain" "portal_custom_domain" {
  name                = format("%s-itn-ioweb-profile-portal-fdd-01", var.project)
  resource_group_name = format("%s-itn-ioweb-fe-rg-01", var.project)
  profile_name        = data.azurerm_cdn_frontdoor_profile.io_web_profile_itn_cdn_profile.name
}

resource "azurerm_dns_a_record" "account" {
  name                = "@"
  zone_name           = azurerm_dns_zone.account_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  target_resource_id  = data.azurerm_cdn_frontdoor_endpoint.io_web_profile_itn_cdn_endpoint.id
}

resource "azurerm_dns_txt_record" "dns_txt" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = data.azurerm_cdn_frontdoor_custom_domain.portal_custom_domain.validation_token
  }
  tags = var.tags
}
