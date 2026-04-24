resource "azurerm_cdn_frontdoor_custom_domain" "io_italia_it" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "io.italia.it"

  tls {
    certificate_type        = "CustomerCertificate"
    cdn_frontdoor_secret_id = azurerm_cdn_frontdoor_secret.io_italia_it.id
  }
}

resource "azurerm_cdn_frontdoor_secret" "io_italia_it" {
  name                     = "MigratedSecret-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id

  secret {
    customer_certificate {
      key_vault_certificate_id = "TODO"
    }
  }
}

resource "azurerm_dns_txt_record" "io_italia_it" {
  name                = join(".", ["_dnsauth", azurerm_cdn_frontdoor_custom_domain.io_italia_it.host_name])
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600

  record {
    value = azurerm_cdn_frontdoor_custom_domain.common_cdn.validation_token
  }
}

resource "azurerm_dns_a_record" "io_italia_it" {
  name                = "@"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_custom_domain.io_italia_it.id
}

resource "azurerm_cdn_frontdoor_endpoint" "io_italia_it" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

resource "azurerm_cdn_frontdoor_origin_group" "io_italia_it" {
  name                     = "io-p-cdnendpoint-iowebsite-Default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  session_affinity_enabled = true

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 240
    path                = "/probes/healthcheck.txt"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "io_italia_it" {
  name                          = "primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name = "iopstcdniowebsite.z6.web.core.windows.net"
  priority  = 1
  weight    = 1
}

resource "azurerm_cdn_frontdoor_route" "io_italia_it" {
  name                          = "iopcdnendpointiowebsite"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.io_italia_it.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.io_italia_it.id]
  link_to_default_domain          = false
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "io_italia_it" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.io_italia_it.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.io_italia_it.id]
}

# Ruleset and rules #

resource "azurerm_cdn_frontdoor_rule_set" "io_italia_it" {
  name                     = "Migratediopcdnendpointiowebsite"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_global" {
  name                      = "Global"
  order                     = 0
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    response_header_action {
      header_action = "Overwrite"
      header_name   = "Strict-Transport-Security"
      value         = "max-age=31536000"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_enforce_https" {
  name                      = "EnforceHTTPS"
  order                     = 1
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Found"
      redirect_protocol    = "Https"
      destination_hostname = ""
    }
  }

  conditions {
    request_scheme_condition {
      match_values     = ["HTTP"]
      operator         = "Equal"
      negate_condition = false
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_fix_dots" {
  name                      = "FixDots"
  order                     = 2
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    response_header_action {
      header_action = "Append"
      header_name   = "x-azure-cdn-filename"
      value         = "dot"
    }
  }

  conditions {
    url_filename_condition {
      match_values     = ["."]
      operator         = "EndsWith"
      negate_condition = false
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_fix_dots2" {
  name                      = "FixDots2"
  order                     = 3
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    response_header_action {
      header_action = "Append"
      header_name   = "x-azure-cdn-ext"
      value         = "empty"
    }
  }

  conditions {
    url_file_extension_condition {
      match_values     = []
      operator         = "Any"
      negate_condition = true
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_redirect_firma" {
  name                      = "RedirectFirma"
  order                     = 4
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/firma-in-digitale"

    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/firma"]
      operator         = "BeginsWith"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_faq" {
  name                      = "Faq"
  order                     = 5
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/domande-frequenti#"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/faq/", "/faq"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_documenti_su_io_faq" {
  name                      = "DocumentiSuIoFaq"
  order                     = 6
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/domande-frequenti"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/documenti-su-io/faq/", "/documenti-su-io/faq"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_carta_giovani_faq" {
  name                      = "CartaGiovaniFaq"
  order                     = 7
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/carta-giovani-nazionale#domande-frequenti"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/carta-giovani-nazionale/faq/", "/carta-giovani-nazionale/faq"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_funzionalita_dismess" {
  name                      = "FunzionalitaDismess"
  order                     = 8
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/funzionalita-dismesse"
    }
  }

  conditions {
    url_path_condition {
      match_values = [
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
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_giornalisti" {
  name                      = "Giornalisti"
  order                     = 9
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/area-stampa"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/giornalisti/", "/giornalisti"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_pubbliche_amministrazioni" {
  name                      = "PubblicheAmministrazioni"
  order                     = 10
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/perche-aderire"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/pubbliche-amministrazioni/", "/pubbliche-amministrazioni"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_enti_nazionali" {
  name                      = "EntiNazionali"
  order                     = 11
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/enti"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/enti/", "/enti"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cittadini" {
  name                      = "Cittadini"
  order                     = 12
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/cittadini/", "/cittadini"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_guida_beneficiari" {
  name                      = "CGNGuidaBeneficiari"
  order                     = 13
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/cgn-guida-beneficiari"
    }
  }

  conditions {
    url_path_condition {
      match_values = [
        "/carta-giovani-nazionale/guida-beneficiari",
        "/carta-giovani-nazionale/guida-beneficiari/",
      ]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_informativa_beneficiari" {
  name                      = "CGNInformativaBeneficiari"
  order                     = 14
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/cgn-informativa-beneficiari"
    }
  }

  conditions {
    url_path_condition {
      match_values = [
        "/carta-giovani-nazionale/informativa-beneficiari",
        "/carta-giovani-nazionale/informativa-beneficiari/",
      ]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_cgn_informative_operatori" {
  name                      = "CGNInformativeOperatori"
  order                     = 15
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/cgn-informativa-operatori"
    }
  }

  conditions {
    url_path_condition {
      match_values = [
        "/carta-giovani-nazionale/informativa-operatori",
        "/carta-giovani-nazionale/informativa-operatori/",
      ]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_note_legali" {
  name                      = "NoteLegali"
  order                     = 16
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/note-legali"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/note-legali/", "/note-legali"]
      operator         = "Equal"
      negate_condition = false
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_privacy_policy" {
  name                      = "PrivacyPolicy"
  order                     = 17
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.io_italia_it.id

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
      destination_path     = "/informativa-privacy"
    }
  }

  conditions {
    url_path_condition {
      match_values     = ["/privacy-policy/", "/privacy-policy"]
      operator         = "Equal"
      negate_condition = false
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_informativa_newsletter" {
  name                      = "InformativaNewsletter"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_ruleset.io_italia_it.id
  order                     = 18
  behavior_on_match         = "Continue"

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"

      destination_path = "/informativa-newsletter"
    }
  }

  conditions {
    url_path_condition {
      operator         = "Equal"
      negate_condition = false
      match_values = [
        "/informativa-newsletter/",
        "/informativa-newsletter",
      ]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_same_path" {
  name                      = "SamePath"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_ruleset.io_italia_it.id
  order                     = 19
  behavior_on_match         = "Continue"

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
    }
  }

  conditions {
    url_path_condition {
      operator         = "Equal"
      negate_condition = false
      match_values = [
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
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_ruleset.io_italia_it.id
  order                     = 20
  behavior_on_match         = "Continue"

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"
    }
  }

  conditions {
    url_path_condition {
      operator         = "Equal"
      negate_condition = false
      match_values     = ["/"]
      transforms       = ["Lowercase"]
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "io_italia_it_io_web" {
  name                      = "IoWeb"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_ruleset.io_italia_it.id
  order                     = 21
  behavior_on_match         = "Continue"

  actions {
    url_redirect_action {
      redirect_type        = "Moved"
      redirect_protocol    = "Https"
      destination_hostname = "ioapp.it"

      destination_path = "/esci-da-io"
    }
  }

  conditions {
    url_path_condition {
      operator         = "Equal"
      negate_condition = false
      match_values = [
        "/io-web/",
        "/io-web",
      ]
    }
  }
}

