resource "azurerm_dns_zone" "uat_ioapp_it" {
  name                = "uat.ioapp.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "uat_ioapp_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
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

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

resource "azurerm_dns_ns_record" "uat_ioapp_it_delegation" {
  name                = "uat"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  records = azurerm_dns_zone.uat_ioapp_it.name_servers
}


# DMARC 

resource "azurerm_dns_txt_record" "dmarc_uat_ioapp_it" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=DMARC1; p=none;"
  }
  tags = var.tags
}

#

# DKIM

locals {
  uat_ioapp_it_dkim_records = {
    rhxsps73fjdvsgzpgba6m3u5cc2t4h5j = "rhxsps73fjdvsgzpgba6m3u5cc2t4h5j.dkim.eu-south-1.amazonses.com"
    p5l7nlscxrgukjuzhpun43wefqfste36 = "p5l7nlscxrgukjuzhpun43wefqfste36.dkim.eu-south-1.amazonses.com"
    wjtcf2j435u5i2ub375a7q4z456hzezu = "wjtcf2j435u5i2ub375a7q4z456hzezu.dkim.eu-south-1.amazonses.com"
  }
}

resource "azurerm_dns_cname_record" "dkim_uat_ioapp_it" {
  for_each = local.uat_ioapp_it_dkim_records

  name                = "${each.key}._domainkey"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = each.value
  tags                = var.tags
}

#

resource "azurerm_dns_mx_record" "bounce_uat_ioapp_it" {
  name                = "bounce"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-south-1.amazonses.com"
  }

  tags = var.tags
}

resource "azurerm_dns_txt_record" "bounce_uat_ioapp_it" {
  name                = "bounce"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    value = "v=spf1 include:amazonses.com ~all"
  }

  tags = var.tags
}