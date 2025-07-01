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

# vehicles.ipatente.io.pagopa.it
resource "azurerm_dns_a_record" "vehicles_ipatente_io_pagopa_it" {
  name                = "vehicles"
  zone_name           = azurerm_dns_zone.ipatente_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 30 #var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# licences.ipatente.io.pagopa.it
resource "azurerm_dns_a_record" "licences_ipatente_io_pagopa_it" {
  name                = "licences"
  zone_name           = azurerm_dns_zone.ipatente_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 30 #var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# payments.ipatente.io.pagopa.it
resource "azurerm_dns_a_record" "payments_ipatente_io_pagopa_it" {
  name                = "payments"
  zone_name           = azurerm_dns_zone.ipatente_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 30 #var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

# practices.ipatente.io.pagopa.it
resource "azurerm_dns_a_record" "practices_ipatente_io_pagopa_it" {
  name                = "practices"
  zone_name           = azurerm_dns_zone.ipatente_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 30 #var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}