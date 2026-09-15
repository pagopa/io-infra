# CNAME

resource "azurerm_dns_cname_record" "assets_cdn_io_italia_it" {
  name                = "assets.cdn"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.assets_locales_endpoint.id
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "assets_cdn_io_pagopa_it" {
  name                = "assets.cdn"
  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.assets_locales_endpoint.id
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "assets_io_pagopa_it" {
  name                = "assets"
  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.assets_locales_endpoint.id
  tags                = var.tags
}

# TXT

resource "azurerm_dns_txt_record" "assets_cdn_io_italia_it" {
  name = "_dnsauth.assets.cdn"

  record {
    value = "_bpxubxwuwzevt64vxafxt2m9wakvhrg"
  }

  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  tags                = var.tags
}

resource "azurerm_dns_txt_record" "assets_cdn_io_pagopa_it" {
  name = "_dnsauth.assets.cdn"

  record {
    value = "_s7p50m2390ozbohdxdfdqhci51t7u9i"
  }

  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  tags                = var.tags
}

resource "azurerm_dns_txt_record" "assets_io_pagopa_it" {
  name = "_dnsauth.assets"

  record {
    value = "_bscb1oqgg1wlf9kwx1ny9aokp3mrhdo"
  }

  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  tags                = var.tags
}