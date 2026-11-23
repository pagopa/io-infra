resource "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "ioapp_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioapp_it.name
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

# DMARC record for ioapp.it
resource "azurerm_dns_txt_record" "dmarc_ioapp_it" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=DMARC1; p=reject; rua=mailto:dmarc@0f1qy7b5.uriports.com; aspf=s; adkim=s"
  }
  tags = var.tags
}

# set SPF to "empty" for ioapp.it
resource "azurerm_dns_txt_record" "spf_ioapp_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 -all"
  }

  record {
    value = "google-site-verification=5hl_cVSx7flbf8w3CtMRXNHYlXtjtmzjNBuSX7SEyhg"
  }

  tags = var.tags
}

# CNAME for continua
resource "azurerm_dns_cname_record" "continua" {
  name                = "continua"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "continua.io.pagopa.it"
  tags                = var.tags
}

# CNAME for zendesk help center
resource "azurerm_dns_cname_record" "zendesk" {
  name                = "assistenza"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "hc-io.zendesk.com"
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "aws_cert_validation_ioweb" {
  name                = "_1b96136662809f31f497b4fcd6b32a8d"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "_2de3fc7bfdb25e6a4e58c29dc8b4dba6.zfyfvmchrl.acm-validations.aws."
  tags                = var.tags
}

# CNAME - MX - TXT records for news.ioapp.it

locals {
  news_ioapp_it = {
    cname = {
      domainkey_1 = {
        name         = "wt5c4qmfo42l4chu24tre2jfo5cllqee._domainkey.news",
        record_value = "wt5c4qmfo42l4chu24tre2jfo5cllqee.dkim.eu-south-1.amazonses.com"
      },
      domainkey_2 = {
        name         = "ns4gtwzbjcogjjnrqrged5qd77qbh4qj._domainkey.news",
        record_value = "ns4gtwzbjcogjjnrqrged5qd77qbh4qj.dkim.eu-south-1.amazonses.com"
      },
      domainkey_3 = {
        name         = "mkjxo5ins2xpl4rzxaddbbqmusjl2sgs._domainkey.news",
        record_value = "mkjxo5ins2xpl4rzxaddbbqmusjl2sgs.dkim.eu-south-1.amazonses.com"
      }
    },

    mx = {
      news = {
        name       = "bounce.news",
        preference = "10",
        exchange   = "feedback-smtp.eu-south-1.amazonses.com"
      },
      euc1_news = {
        name       = "bounce.euc1.news",
        preference = "10",
        exchange   = "feedback-smtp.eu-central-1.amazonses.com"
      }
    },

    txt = {
      news = {
        name         = "bounce.news",
        record_value = "v=spf1 include:amazonses.com ~all"
      },
      euc1_news = {
        name         = "bounce.euc1.news",
        record_value = "v=spf1 include:amazonses.com ~all"
      },
      dmarc = {
        name         = "_dmarc.news"
        record_value = "v=DMARC1; p=reject; adkim=s; aspf=r; fo=1; rua=mailto:dmarc@0f1qy7b5.uriports.com"
      },
      site_verification = {
        name         = "news",
        record_value = "google-site-verification=jw98Ap7piXcFLcgIoepCuyzoPk_m_IfRhFYCU5ELq3c"
      }
    }
  }
}

resource "azurerm_dns_cname_record" "news_ioapp_it_cname" {
  for_each            = local.news_ioapp_it.cname
  name                = each.value.name
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.record_value
  tags                = var.tags
}

resource "azurerm_dns_mx_record" "news_ioapp_it_mx" {
  for_each            = local.news_ioapp_it.mx
  name                = each.value.name
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  tags                = var.tags

  record {
    preference = each.value.preference
    exchange   = each.value.exchange
  }
}

resource "azurerm_dns_txt_record" "news_ioapp_it_txt" {
  for_each            = local.news_ioapp_it.txt
  name                = each.value.name
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  tags                = var.tags

  record {
    value = each.value.record_value
  }
}