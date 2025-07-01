resource "azurerm_dns_zone" "firmaconio_selfcare_pagopa_it" {
  name                = join(".", [var.dns_zones.firmaconio_selfcare, var.external_domain])
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

# application gateway records
# firmaconio.selfcare.pagopa.it
resource "azurerm_dns_a_record" "firmaconio_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firmaconio_selfcare_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = 30 #var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}

resource "azurerm_dns_caa_record" "firmaconio_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firmaconio_selfcare_pagopa_it.name
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

  tags = var.tags
}

output "dns_firmaconio_selfcare_pagopa_it_ns" {
  value = azurerm_dns_zone.firmaconio_selfcare_pagopa_it.name_servers
}
