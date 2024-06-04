## Application gateway ##
module "app_gw" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_gateway?ref=v8.20.0"

  resource_group_name = data.azurerm_resource_group.weu_external.name
  location            = data.azurerm_resource_group.weu_external.location
  name                = "${local.project}-appgateway"
  zones               = [1, 2, 3]

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = azurerm_subnet.app_gateway.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = {

    apim = {
      protocol                    = "Https"
      host                        = format("api-app.internal.%s.%s", local.dns_zone_io, local.external_domain)
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = [format("api-app.internal.%s.%s", local.dns_zone_io, local.external_domain)]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 180
      pick_host_name_from_backend = false
    }

    appbackend-app = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.backendl1.default_hostname,
        data.azurerm_linux_web_app.backendl2.default_hostname,
      ]
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
        data.azurerm_linux_web_app.session_manager.default_hostname
      ]
      probe                       = "/healthcheck"
      probe_name                  = "probe-session-manager-app"
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

    selfcare-backend = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.appservice_selfcare_be.default_hostname,
      ]
      probe                       = "/info"
      probe_name                  = "probe-selfcare-backend"
      request_timeout             = 180
      pick_host_name_from_backend = true
    }

    firmaconio-selfcare-backend = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        data.azurerm_linux_web_app.firmaconio_selfcare_web_app.default_hostname,
      ]
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
        data.azurerm_linux_web_app.cms_backoffice_app.default_hostname,
      ]
      probe                       = "/api/info"
      probe_name                  = "probe-selfcare-io-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }
  }

  ssl_profiles = [
    {
      name                             = "${local.project}-api-mtls-profile"
      trusted_client_certificate_names = ["${local.prefix}-issuer-chain"]
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
      name                             = "${local.project}-ssl-profile"
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
      secret_name  = format("%s-issuer-chain", local.prefix)
      key_vault_id = data.azurerm_key_vault.weu.id
    }
  ]

  # Configure listeners
  listeners = {

    api-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_api.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api.version}",
          ""
        )
      }
    }

    api-mtls-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-mtls.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-api-mtls-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_api_mtls.name
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
        name = data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.version}",
          ""
        )
      }
    }

    api-app-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-app.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_api_app.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_app.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_app.version}",
          ""
        )
      }
    }

    api-web-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-web.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_api_web.name
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
        name = data.azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it.version}",
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
        name = data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.version}",
          ""
        )
      }
    }

    api-io-selfcare-pagopa-it = {
      protocol           = "Https"
      host               = "api.${local.dns_zone_io_selfcare}.${local.external_domain}"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_api_io_selfcare_pagopa_it.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_io_selfcare_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_io_selfcare_pagopa_it.version}",
          ""
        )
      }
    }

    firmaconio-selfcare-pagopa-it = {
      protocol           = "Https"
      host               = format("%s.%s", local.dns_zone_firmaconio_selfcare, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.version}",
          ""
        )
      }
    }

    continua-io-pagopa-it = {
      protocol           = "Https"
      host               = format("continua.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_continua.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_continua.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_continua.version}",
          ""
        )
      }
    }

    selfcare-io-pagopa-it = {
      protocol           = "Https"
      host               = format("selfcare.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_selfcare_io.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_selfcare_io.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_selfcare_io.version}",
          ""
        )
      }
    }

    openid-provider-io-pagopa-it = {
      protocol           = "Https"
      host               = format("openid-provider.%s.%s", local.dns_zone_io, local.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = data.azurerm_key_vault_certificate.app_gw_openid_provider_io.name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_openid_provider_io.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_openid_provider_io.version}",
          ""
        )
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

    api-io-selfcare-pagopa-it = {
      listener              = "api-io-selfcare-pagopa-it"
      backend               = "selfcare-backend"
      rewrite_rule_set_name = "rewrite-rule-set-selfcare-backend"
      priority              = 60
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

    openid-provider-io-pagopa-it = {
      listener              = "openid-provider-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-openid-provider-io"
      priority              = 120
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
        session-manager = {
          paths                 = ["/session-manager/*"]
          backend               = "session-manager-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-remove-base-path-session-manager"
        },
        healthcheck = {
          paths                 = ["/healthcheck"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        test-login = {
          paths                 = ["/test-login"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        login = {
          paths                 = ["/login"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        acs = {
          paths                 = ["/assertionConsumerService"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        fast-login = {
          paths                 = ["/api/v1/fast-login"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        nonce-fast-login = {
          paths                 = ["/api/v1/fast-login/nonce/generate"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        logout = {
          paths                 = ["/logout"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        session = {
          paths                 = ["/api/v1/session"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        bpd-user = {
          paths                 = ["/bpd/api/v1/user"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        zendesk-user = {
          paths                 = ["/api/backend/zendesk/v1/jwt"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
        },
        pagopa-user = {
          paths                 = ["/pagopa/api/v1/user"]
          backend               = "appbackend-app",
          rewrite_rule_set_name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
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
      name = "rewrite-rule-set-api-app-rewrite-to-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "rewrite-if-cookie-present"
          rule_sequence = 200
          conditions = [{
            variable    = "http_req_Cookie"
            pattern     = "test-session-manager"
            ignore_case = true
            negate      = false
          }]
          url = {
            path         = "/session-manager{var_uri_path}"
            query_string = null
            reroute      = true
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    },
    {
      name = "rewrite-rule-set-api-app-remove-base-path-session-manager"
      rewrite_rules = [
        local.io_backend_ip_headers_rule,
        {
          name          = "strip_base_session_manager_path"
          rule_sequence = 200
          conditions = [{
            variable    = "var_uri_path"
            pattern     = "/session-manager/(.*)"
            ignore_case = true
            negate      = false
          }]
          url = {
            path         = "/{var_uri_path_1}"
            query_string = null
            reroute      = false
          }
          request_header_configurations  = []
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
      name = "rewrite-rule-set-selfcare-backend"
      rewrite_rules = [{
        name          = "http-headers-selfcare-backend"
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
      name = "rewrite-rule-set-openid-provider-io"
      rewrite_rules = [
        {
          name          = "http-headers-api-openid-provider"
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
            }
          ]
          response_header_configurations = []
        },
        {
          name          = "url-rewrite-openid-provider-private"
          rule_sequence = 200
          conditions = [
            {
              ignore_case = true
              pattern     = join("|", ["\\/admin\\/(.*)"])
              negate      = false
              variable    = "var_uri_path"
          }]
          url = {
            path         = "notfound"
            query_string = null
          }
          request_header_configurations  = []
          response_header_configurations = []
        },
        {
          name          = "url-rewrite-openid-provider-public"
          rule_sequence = 201
          conditions    = []
          url = {
            path         = "fims/{var_uri_path}"
            query_string = "{var_query_string}"
          }
          request_header_configurations  = []
          response_header_configurations = []
        }
      ]
    }
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = 10 # 4 capacity=baseline, 10 capacity=high volume event, 15 capacity=very high volume event
  app_gateway_max_capacity = 50

  alerts_enabled = true

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
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

  tags = local.tags
}
