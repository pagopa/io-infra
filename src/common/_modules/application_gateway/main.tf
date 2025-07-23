## Application gateway ##
module "app_gw" {
  source = "github.com/pagopa/terraform-azurerm-v4//app_gateway?ref=v1.23.3"

  resource_group_name = var.resource_group_external
  location            = var.location
  name                = try(local.nonstandard[var.location_short].agw, "${var.project}-agw-01")
  zones               = [1, 2, 3]

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = azurerm_subnet.agw_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = {

    apim = {
      protocol                    = "Https"
      host                        = format("api-app.internal.%s", var.public_dns_zones.io.name)
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = [format("api-app.internal.%s", var.public_dns_zones.io.name)]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 180
      pick_host_name_from_backend = false
    }

    # TODO: change the backend to the new FQDN when api.internal.io.pagopa.it will be available
    platform-api-gateway = {
      protocol                    = "Https"
      host                        = "io-p-itn-platform-api-gateway-apim-01.azure-api.net"
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = ["io-p-itn-platform-api-gateway-apim-01.azure-api.net"]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-platform-api-gateway"
      request_timeout             = 10
      pick_host_name_from_backend = false
    }

    appbackend-app = {
      protocol                    = "Https"
      host                        = null
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = var.backend_hostnames.app_backends
      probe                       = "/info"
      probe_name                  = "probe-appbackend-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    session-manager-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.session_manager_03.default_hostname,
      ]
      probe                       = "/healthcheck"
      probe_name                  = "probe-session-manager-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    fims-op-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.fims_op_app.default_hostname
      ]
      probe                       = "/health"
      probe_name                  = "probe-fims-op-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    developerportal-backend = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.appservice_devportal_be.default_hostname,
      ]
      probe                       = "/info"
      probe_name                  = "probe-developerportal-backend"
      request_timeout             = 180
      pick_host_name_from_backend = true
    }

    firmaconio-selfcare-backend = {
      protocol                    = "Https"
      host                        = null
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = var.backend_hostnames.firmaconio_selfcare_web_app
      probe                       = "/health"
      probe_name                  = "probe-firmaconio-selfcare-backend"
      request_timeout             = 180
      pick_host_name_from_backend = true
    }

    continua-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.appservice_continua.default_hostname,
      ]
      probe                       = "/info"
      probe_name                  = "probe-continua-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    selfcare-io-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.cms_backoffice_app_itn.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-selfcare-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    vehicles-ipatente-io-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.ipatente_vehicles_app_itn.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-vehicles-ipatente-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    licences-ipatente-io-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.ipatente_licences_app_itn.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-licences-ipatente-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    payments-ipatente-io-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.ipatente_payments_app_itn.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-payments-ipatente-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    practices-ipatente-io-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.ipatente_practices_app_itn.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-practices-ipatente-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }
  }

  ssl_profiles = [{
    name                             = format("%s-api-mtls-profile", var.project)
    trusted_client_certificate_names = [format("%s-issuer-chain", var.prefix)]
    verify_client_cert_issuer_dn     = true
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Custom"
      policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
      cipher_suites = [
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      ]
      min_protocol_version = "TLSv1_2"
    }
    },
    {
      name                             = format("%s-ssl-profile", var.project)
      trusted_client_certificate_names = null
      verify_client_cert_issuer_dn     = false
      ssl_policy = {
        disabled_protocols = []
        policy_type        = "Custom"
        policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
        cipher_suites = [
          "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
          "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
        ]
        min_protocol_version = "TLSv1_2"
      }
  }]

  trusted_client_certificates = [
    {
      secret_name  = format("%s-issuer-chain", var.prefix)
      key_vault_id = var.key_vault.id
    }
  ]

  # Configure listeners
  listeners = {
    api-mtls-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-mtls.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = format("%s-api-mtls-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.api_mtls
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_mtls.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_mtls.version}",
          ""
        )
      }
    }

    api-io-italia-it = {
      protocol           = "Https"
      host               = "api.io.italia.it"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.api_io_italia_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.version}",
          ""
        )
      }
    }

    api-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.api
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api.version}",
          ""
        )
      }
    }

    continua-io-pagopa-it = {
      protocol           = "Https"
      host               = format("continua.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.continua_io_pagopa_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_continua.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_continua.version}",
          ""
        )
      }
    }

    developerportal-backend-io-italia-it = {
      protocol           = "Https"
      host               = "developerportal-backend.io.italia.it"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.developerportal_backend_io_italia_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.version}",
          ""
        )
      }
    }

    firmaconio-selfcare-pagopa-it = {
      protocol           = "Https"
      host               = var.public_dns_zones.firmaconio_selfcare_pagopa_it.name
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.firmaconio_selfcare_pagopa_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.version}",
          ""
        )
      }
    }

    oauth-io-pagopa-it = {
      protocol           = "Https"
      host               = format("oauth.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.certificates.oauth_io_pagopa_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_oauth.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_oauth.version}",
          ""
        )
      }
    }

    selfcare-io-pagopa-it = {
      protocol           = "Https"
      host               = format("selfcare.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.selfcare_io_pagopa_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_selfcare_io.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_selfcare_io.version}",
          ""
        )
      }
    }

    api-app-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-app.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = var.certificates.api_app
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_app.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_app.version}",
          ""
        )
      }
    }

    api-web-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-web.%s", var.public_dns_zones.io.name)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = var.certificates.api_web
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_web.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_web.version}",
          ""
        )
      }
    }

    app-backend-io-italia-it = {
      protocol           = "Https"
      host               = "app-backend.io.italia.it"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = var.certificates.app_backend_io_italia_it
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it.version}",
          ""
        )
      }
    }

    vehicles-ipatente-io-pagopa-it = {
      protocol           = "Https"
      host               = format("vehicles.%s", var.public_dns_zones.ipatente_io_pagopa_it.name)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.vehicles_ipatente_io_pagopa_it
        id   = data.azurerm_key_vault_certificate.app_gw_vehicles_ipatente_io.versionless_secret_id
      }
    }

    licences-ipatente-io-pagopa-it = {
      protocol           = "Https"
      host               = format("licences.%s", var.public_dns_zones.ipatente_io_pagopa_it.name)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.licences_ipatente_io_pagopa_it
        id   = data.azurerm_key_vault_certificate.app_gw_licences_ipatente_io.versionless_secret_id
      }
    }

    payments-ipatente-io-pagopa-it = {
      protocol           = "Https"
      host               = format("payments.%s", var.public_dns_zones.ipatente_io_pagopa_it.name)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.payments_ipatente_io_pagopa_it
        id   = data.azurerm_key_vault_certificate.app_gw_payments_ipatente_io.versionless_secret_id
      }
    }

    practices-ipatente-io-pagopa-it = {
      protocol           = "Https"
      host               = format("practices.%s", var.public_dns_zones.ipatente_io_pagopa_it.name)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", var.project)
      firewall_policy_id = null

      certificate = {
        name = var.certificates.practices_ipatente_io_pagopa_it
        id   = data.azurerm_key_vault_certificate.app_gw_practices_ipatente_io.versionless_secret_id
      }
    }
  }

  # maps listener to backend
  routes = {

    api-io-pagopa-it = {
      listener              = "api-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 50
    }

    api-io-italia-it = {
      listener              = "api-io-italia-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 30
    }

    api-mtls-io-pagopa-it = {
      listener              = "api-mtls-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api-mtls"
      priority              = 10
    }


    api-web-io-pagopa-it = {
      listener              = "api-web-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api-web"
      priority              = 100
    }

    developerportal-backend-io-italia-it = {
      listener              = "developerportal-backend-io-italia-it"
      backend               = "developerportal-backend"
      rewrite_rule_set_name = "rewrite-rule-set-developerportal-backend"
      priority              = 20
    }

    firmaconio-selfcare-pagopa-it = {
      listener              = "firmaconio-selfcare-pagopa-it"
      backend               = "firmaconio-selfcare-backend"
      rewrite_rule_set_name = "rewrite-rule-set-firmaconio-selfcare-backend"
      priority              = 90
    }

    continua-io-pagopa-it = {
      listener              = "continua-io-pagopa-it"
      backend               = "continua-app"
      rewrite_rule_set_name = "rewrite-rule-set-continua"
      priority              = 80
    }

    selfcare-io-pagopa-it = {
      listener              = "selfcare-io-pagopa-it"
      backend               = "selfcare-io-app"
      rewrite_rule_set_name = "rewrite-rule-set-selfcare-io"
      priority              = 110
    }

    oauth-io-pagopa-it = {
      listener              = "oauth-io-pagopa-it"
      backend               = "fims-op-app"
      rewrite_rule_set_name = "rewrite-rule-set-fims-op-app"
      priority              = 120
    }

    vehicles-ipatente-io-pagopa-it = {
      listener              = "vehicles-ipatente-io-pagopa-it"
      backend               = "vehicles-ipatente-io-app"
      rewrite_rule_set_name = "rewrite-rule-set-ipatente-io-app"
      priority              = 130
    }

    licences-ipatente-io-pagopa-it = {
      listener              = "licences-ipatente-io-pagopa-it"
      backend               = "licences-ipatente-io-app"
      rewrite_rule_set_name = "rewrite-rule-set-ipatente-io-app"
      priority              = 131
    }

    payments-ipatente-io-pagopa-it = {
      listener              = "payments-ipatente-io-pagopa-it"
      backend               = "payments-ipatente-io-app"
      rewrite_rule_set_name = "rewrite-rule-set-ipatente-io-app"
      priority              = 132
    }

    practices-ipatente-io-pagopa-it = {
      listener              = "practices-ipatente-io-pagopa-it"
      backend               = "practices-ipatente-io-app"
      rewrite_rule_set_name = "rewrite-rule-set-ipatente-io-app"
      priority              = 133
    }
  }

  routes_path_based = {
    app-backend-io-italia-it = {
      listener     = "app-backend-io-italia-it"
      url_map_name = "io-backend-path-based-rule"
      priority     = 40
    }

    api-app-io-pagopa-it = {
      listener     = "api-app-io-pagopa-it"
      url_map_name = "io-backend-path-based-rule"
      priority     = 70
    }
  }

  url_path_map = {
    io-backend-path-based-rule = {
      default_backend               = "appbackend-app"
      default_rewrite_rule_set_name = "rewrite-rule-set-api-app"
      path_rule = {
        api-gateway-platform-info = {
          paths                 = ["/info"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-platform-legacy-root"
        },
        api-gateway-platform-ping = {
          paths                 = ["/api/v1/ping"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-platform-legacy"
        },
        api-gateway-platform-status = {
          paths                 = ["/api/v1/status"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-platform-legacy"
        },
        api-gateway-platform-trials = {
          paths                 = ["/api/v1/trials/*"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-platform-legacy"
        },
        api-gateway-platform-identity = {
          paths                 = ["/api/identity/*"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app"
        },
        api-gateway-cdc = {
          paths                 = ["/api/cdc/*"]
          backend               = "platform-api-gateway",
          rewrite_rule_set_name = "rewrite-rule-set-api-app"
        },
        session-manager = {
          paths                 = ["/api/auth/v1/*", "/api/sso/bpd/v1/user", "/api/sso/pagopa/v1/user", "/api/sso/zendesk/v1/jwt"]
          backend               = "platform-api-gateway"
          rewrite_rule_set_name = "rewrite-rule-set-api-app"
        },
        healthcheck = {
          paths                 = ["/healthcheck"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        test-login = {
          paths                 = ["/test-login"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        login = {
          paths                 = ["/login"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        # NOTE: Do NOT remove rewrite rule from metadata endpoint, as it cannot be switched to new basepath
        metadata = {
          paths                 = ["/metadata"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        # NOTE: Do NOT remove rewrite rule from acs endpoint, as it cannot be switched to new basepath
        acs = {
          paths                 = ["/assertionConsumerService"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        fast-login = {
          paths                 = ["/api/v1/fast-login"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        nonce-fast-login = {
          paths                 = ["/api/v1/fast-login/nonce/generate"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        logout = {
          paths                 = ["/logout"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        session = {
          paths                 = ["/api/v1/session"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        bpd-user = {
          paths                 = ["/bpd/api/v1/user"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-bpd-session-manager"
        },
        zendesk-user = {
          paths                 = ["/api/backend/zendesk/v1/jwt"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-zendesk-session-manager"
        },
        pagopa-user = {
          paths                 = ["/pagopa/api/v1/user"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-pagopa-session-manager"
        },
      }
    }
  }

  rewrite_rule_sets = [
    {
      name = "rewrite-rule-set-api"
      rewrite_rules = [{
        name          = "http-headers-api"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
          {
            # this header will be checked in apim policy (only for MTLS check)
            header_name  = data.azurerm_key_vault_secret.app_gw_mtls_header_name.value
            header_value = "false"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-api-mtls"
      rewrite_rules = [{
        name          = "http-headers-api-mtls"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
          {
            # this header will be checked in apim policy (only for MTLS check)
            header_name  = data.azurerm_key_vault_secret.app_gw_mtls_header_name.value
            header_value = "true"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name          = "rewrite-rule-set-api-app"
      rewrite_rules = [local.io_backend_ip_headers_rule]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-platform-legacy-root"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-url-to-platform-legacy"
          rule_sequence = 200
          conditions    = []
          url = {
            path         = "/api/platform-legacy{var_uri_path}"
            query_string = null
            reroute      = false
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-platform-legacy"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-url-to-api-platform-legacy"
          rule_sequence = 100

          # Condition to capture requests directed to any endpoint under /api/v1/
          conditions = [
            {
              variable    = "var_uri_path"
              pattern     = "^/api/v1/(.*)$"
              ignore_case = true
              negate      = false
            }
          ]

          # URL rewriting preserving the specific endpoint
          url = {
            path         = "/api/platform-legacy/v1/{var_uri_path_1}"
            query_string = null
            reroute      = false
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        # if endpoint has /api/v1 prefix(e.g. /api/v1/session)
        # then it should be stripped away before proceding
        {
          name          = "strip-base-path"
          rule_sequence = 150
          conditions = [
            {
              variable    = "var_uri_path"
              pattern     = "/api/v1/(.*)"
              ignore_case = true
              negate      = false
            }
          ]
          url = {
            path         = "/{var_uri_path_1}"
            query_string = null
            reroute      = false
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        },
        {
          name          = "rewrite-path"
          rule_sequence = 200
          conditions    = []
          url = {
            path         = "/api/auth/v1{var_uri_path}"
            query_string = null
            reroute      = true
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-to-bpd-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-path"
          rule_sequence = 200
          conditions    = []
          url = {
            # only 1 operation present for this API
            path         = "/api/sso/bpd/v1/user"
            query_string = null
            reroute      = true
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-to-pagopa-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-path"
          rule_sequence = 200
          conditions    = []
          url = {
            # only 1 operation present for this API
            path         = "/api/sso/pagopa/v1/user"
            query_string = null
            reroute      = true
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-rewrite-to-zendesk-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-path"
          rule_sequence = 200
          conditions    = []
          url = {
            # only 1 operation present for this API
            path         = "/api/sso/zendesk/v1/jwt"
            query_string = null
            reroute      = true
            components   = "path_only"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-fims-op-app"
      rewrite_rules = [{
        name          = "http-headers-fims-op-app"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Forwarded-Host"
            header_value = "{var_host}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-api-web"
      rewrite_rules = [{
        name          = "http-headers-api-web"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-developerportal-backend"
      rewrite_rules = [{
        name          = "http-headers-developerportal-backend"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-firmaconio-selfcare-backend"
      rewrite_rules = [{
        name          = "http-headers-firmaconio-selfcare-backend"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-continua"
      rewrite_rules = [{
        name          = "http-headers-continua"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Forwarded-Host"
            header_value = "{var_host}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-selfcare-io"
      rewrite_rules = [{
        name          = "http-headers-selfcare-io"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
    {
      name = "rewrite-rule-set-ipatente-io-app"
      rewrite_rules = [{
        name          = "http-headers-fims-op-app"
        rule_sequence = 100
        conditions    = []
        url           = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Forwarded-Host"
            header_value = "{var_host}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    },
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.min_capacity
  app_gateway_max_capacity = var.max_capacity

  alerts_enabled = var.alerts_enabled

  action = [
    {
      action_group_id    = var.error_action_group_id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkapplicationgateways
  monitor_metric_alert_criteria = {

    compute_units_usage = {
      description   = "Abnormal compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "ComputeUnits"
          operator                 = "GreaterOrLessThan"
          alert_sensitivity        = "Low" # todo after api app migration change to High
          evaluation_total_count   = 3
          evaluation_failure_count = 3
          dimension                = []
        }
      ]
    }

    backend_pools_status = {
      description   = "One or more backend pools are down, see Dimension value or check Backend Health on Azure portal. Runbook https://pagopa.atlassian.net/wiki/spaces/IC/pages/914161665/Application+Gateway+-+Backend+Status"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 0
      auto_mitigate = true

      criteria = [
        {
          aggregation = "Average"
          metric_name = "UnhealthyHostCount"
          operator    = "GreaterThan"
          threshold   = 0
          dimension = [
            {
              name     = "BackendSettingsPool"
              operator = "Include"
              values   = ["*"]
            }
          ]
        }
      ]
      dynamic_criteria = []
    }

    response_time = {
      description   = "Backends response time is too high. See Dimension value to check the Listener unhealty."
      frequency     = "PT5M"
      window_size   = "PT15M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "BackendLastByteResponseTime"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension = [
            {
              name     = "Listener"
              operator = "Include"
              values   = ["*"]
          }]
        }
      ]
    }

    total_requests = {
      description   = "Traffic is raising"
      frequency     = "PT5M"
      window_size   = "PT15M"
      severity      = 3
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "TotalRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 1
          evaluation_failure_count = 1
          dimension                = []
        }
      ]
    }

    failed_requests = {
      description   = "Abnormal failed requests. See Dimension value to check the Backend Pool unhealty"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "FailedRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 4
          evaluation_failure_count = 4
          dimension = [
            {
              name     = "BackendSettingsPool"
              operator = "Include"
              values   = ["*"]
            }
          ]
        }
      ]
    }

  }

  tags = var.tags
}
