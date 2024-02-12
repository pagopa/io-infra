resource "azurerm_dns_zone" "firmaconio_selfcare_pagopa_it" {
  count               = (var.dns_zone_firmaconio_selfcare == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_firmaconio_selfcare, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_external.name

  tags = var.tags
}

# application gateway records
# firmaconio.selfcare.pagopa.it
resource "azurerm_dns_a_record" "firmaconio_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firmaconio_selfcare_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records = [
    # azurerm_public_ip.appgateway_public_ip.ip_address,
    azurerm_public_ip.appgateway_temp_public_ip.ip_address,
  ]

  tags = var.tags
}

resource "azurerm_dns_caa_record" "firmaconio_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firmaconio_selfcare_pagopa_it[0].name
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

output "dns_firmaconio_selfcare_pagopa_it_ns" {
  value = azurerm_dns_zone.firmaconio_selfcare_pagopa_it[0].name_servers
}
