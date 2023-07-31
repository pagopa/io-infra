resource "azurerm_dns_zone" "firma_io_pagopa_it" {
  count = var.env_short == "p" ? 1 : 0

  name                = var.dns_zone_names.website
  resource_group_name = azurerm_resource_group.integration_rg.name

  tags = var.tags
}

resource "azurerm_dns_mx_record" "ses_mx_firma_io_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "inbound-smtp.eu-west-1.amazonaws.com."
  }
}

resource "azurerm_dns_cname_record" "ses_validation_firma_io_pagopa_it" {
  for_each = { for v in var.dns_ses_validation : v.name => v }

  name                = each.value.name
  record              = each.value.record
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec
}

resource "azurerm_dns_txt_record" "spf1_mailup_firma_io_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec

  record {
    value = "v=spf1 include:musvc.com -all"
  }
}

resource "azurerm_dns_cname_record" "dkim1_mailup_firma_io_pagopa_it" {
  name                = "ml01._domainkey"
  record              = "ml01.dkim.musvc.com."
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec
}

resource "azurerm_dns_cname_record" "dkim2_mailup_firma_io_pagopa_it" {
  name                = "ml02._domainkey"
  record              = "ml02.dkim.musvc.com."
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec
}

resource "azurerm_dns_txt_record" "dmarc_mailup_firma_io_pagopa_it" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec

  record {
    value = "v=DMARC1; p=reject; pct=100; adkim=s; aspf=s"
  }
}