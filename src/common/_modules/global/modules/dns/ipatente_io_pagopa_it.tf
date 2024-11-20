resource "azurerm_dns_zone" "ipatente_io_pagopa_it" {
  name                = "ipatente.io.pagopa.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "ipatente_io_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ipatente_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
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