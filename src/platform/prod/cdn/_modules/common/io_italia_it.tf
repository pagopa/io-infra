resource "azurerm_cdn_frontdoor_custom_domain" "io_italia_it" {
  name                     = "io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "io.italia.it"

  tls {
    # Cannot switch to ManagedCertificate since the auto rotation with Apex Domains is not fully automated (requires manual domain revalidation):
    # https://learn.microsoft.com/en-gb/azure/frontdoor/apex-domain?WT.mc_id=Portal-Microsoft_Azure_AFDX#azure-front-door-managed-tls-certificate-rotation
    certificate_type        = "CustomerCertificate"
    cdn_frontdoor_secret_id = azurerm_cdn_frontdoor_secret.io_italia_it.id
  }
}

resource "azurerm_cdn_frontdoor_secret" "io_italia_it" {
  name                     = "MigratedSecret-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common.id

  secret {
    customer_certificate {
      key_vault_certificate_id = "https://io-p-kv-common.vault.azure.net/certificates/io-italia-it"
    }
  }
}

resource "azurerm_dns_a_record" "io_italia_it" {
  name                = "@"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 300
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.io_italia_it.id
  tags                = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "io_italia_it" {
  name                     = "io-p-cdnendpoint-iowebsite"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common.id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "io_italia_it" {
  name                     = "io-p-cdnendpoint-iowebsite-Default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common.id
  session_affinity_enabled = false

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 240
    path                = "/probes/healthcheck.txt"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

resource "azurerm_cdn_frontdoor_origin" "io_italia_it" {
  name                          = "primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "iopstcdniowebsite.z6.web.core.windows.net"
  origin_host_header = "iopstcdniowebsite.z6.web.core.windows.net"
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_route" "io_italia_it" {
  name                          = "iopcdnendpointiowebsite"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.io_italia_it.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.io_italia_it.id
  ]
  link_to_default_domain = true

  cache {
    compression_enabled           = false
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

/*

# TODO: the association on the import will be recreated due to missing ids on Azure (stale records after forced migration from Classic to Standard), 
  decide if it's worth importing the resource or not since the recreation may cause downtime

resource "azurerm_cdn_frontdoor_custom_domain_association" "io_italia_it" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.io_italia_it.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.io_italia_it.id]
}

*/

# Ruleset and rules #

resource "azurerm_cdn_frontdoor_rule_set" "io_italia_it" {
  name                     = "Migratediopcdnendpointiowebsite"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common.id
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_global" {
  name                      = "Global"
  order                     = 0
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    modify_response_header {
      operator     = "Overwrite"
      header_name  = "Strict-Transport-Security"
      header_value = "max-age=31536000"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_fix_dots" {
  name                      = "FixDots"
  order                     = 1
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    modify_response_header {
      operator     = "Append"
      header_name  = "x-azure-cdn-filename"
      header_value = "dot"
    }
  }

  conditions {
    request_filename {
      operator = "EndsWith"
      values   = ["."]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_fix_dots2" {
  name                      = "FixDots2"
  order                     = 2
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    modify_response_header {
      operator     = "Append"
      header_name  = "x-azure-cdn-ext"
      header_value = "empty"
    }
  }

  conditions {
    request_file_extension {
      operator = "NotAny"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_redirect_firma" {
  name                      = "RedirectFirma"
  order                     = 3
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/firma-in-digitale"
    }
  }

  conditions {
    request_path {
      operator   = "BeginsWith"
      values     = ["/firma"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_faq" {
  name                      = "Faq"
  order                     = 4
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/domande-frequenti#"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/faq/", "/faq"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_documenti_su_io_faq" {
  name                      = "DocumentiSuIoFaq"
  order                     = 5
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/domande-frequenti"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/documenti-su-io/faq/", "/documenti-su-io/faq"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_carta_giovani_faq" {
  name                      = "CartaGiovaniFaq"
  order                     = 6
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/carta-giovani-nazionale#domande-frequenti"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/carta-giovani-nazionale/faq/", "/carta-giovani-nazionale/faq"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_funzionalita_dismessa" {
  name                      = "FunzionalitaDismess"
  order                     = 7
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/funzionalita-dismesse"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/bonus-vacanze/",
        "/bonus-vacanze/faq/",
        "/certificato-verde-green-pass-covid/faq/",
        "/cashback/",
        "/cashback/faq/",
        "/bonus-vacanze",
        "/bonus-vacanze/faq",
        "/certificato-verde-green-pass-covid/faq",
        "/cashback",
        "/cashback/faq",
      ]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_giornalisti" {
  name                      = "Giornalisti"
  order                     = 8
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/area-stampa"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/giornalisti/", "/giornalisti"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_pubbliche_amministrazioni" {
  name                      = "PubblicheAmministrazioni"
  order                     = 9
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/perche-aderire"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/pubbliche-amministrazioni/", "/pubbliche-amministrazioni"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_enti_nazionali" {
  name                      = "EntiNazionali"
  order                     = 10
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/enti"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/enti/", "/enti"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cittadini" {
  name                      = "Cittadini"
  order                     = 11
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/cittadini/", "/cittadini"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_guida_beneficiari" {
  name                      = "CGNGuidaBeneficiari"
  order                     = 12
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/cgn-guida-beneficiari"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/carta-giovani-nazionale/guida-beneficiari",
        "/carta-giovani-nazionale/guida-beneficiari/",
      ]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_informativa_beneficiari" {
  name                      = "CGNInformativaBeneficiari"
  order                     = 13
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/cgn-informativa-beneficiari"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/carta-giovani-nazionale/informativa-beneficiari",
        "/carta-giovani-nazionale/informativa-beneficiari/",
      ]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_informative_operatori" {
  name                      = "CGNInformativeOperatori"
  order                     = 14
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/cgn-informativa-operatori"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/carta-giovani-nazionale/informativa-operatori",
        "/carta-giovani-nazionale/informativa-operatori/",
      ]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_note_legali" {
  name                      = "NoteLegali"
  order                     = 15
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/note-legali"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/note-legali/", "/note-legali"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_privacy_policy" {
  name                      = "PrivacyPolicy"
  order                     = 16
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/informativa-privacy"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values   = ["/privacy-policy/", "/privacy-policy"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_informativa_newsletter" {
  name                      = "InformativaNewsletter"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id
  order                     = 17
  behaviour_on_match        = "Continue"

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/informativa-newsletter"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/informativa-newsletter/",
        "/informativa-newsletter",
      ]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_same_path" {
  name                      = "SamePath"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id
  order                     = 18
  behaviour_on_match        = "Continue"

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/documenti-su-io",
        "/documenti-su-io/",
        "/carta-giovani-nazionale",
        "/carta-giovani-nazionale/",
        "/numeri/",
        "/numeri",
        "/sviluppatori",
        "/sviluppatori/",
      ]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_homepage" {
  name                      = "Homepage"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id
  order                     = 19
  behaviour_on_match        = "Continue"

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
    }
  }

  conditions {
    request_path {
      operator   = "Equal"
      values     = ["/"]
      transforms = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_io_web" {
  name                      = "IoWeb"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id
  order                     = 20
  behaviour_on_match        = "Continue"

  actions {
    url_redirect {
      redirect_type         = "Moved"
      redirect_protocol     = "Https"
      destination_host_name = "ioapp.it"
      destination_path      = "/esci-da-io"
    }
  }

  conditions {
    request_path {
      operator = "Equal"
      values = [
        "/io-web/",
        "/io-web",
      ]
    }
  }
}

