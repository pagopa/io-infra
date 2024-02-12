## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_temp_public_ip" {
  name                = format("%s-temp-appgateway-pip", local.project)
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_temp_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.28.0"
  name                                      = format("%s-temp-appgateway-snet", local.project)
  address_prefixes                          = var.cidr_subnet_temp_appgateway
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}

## Application gateway ##
module "app_gw_temp" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway?ref=v7.28.0"

  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location
  name                = format("%s-temp-appgateway", local.project)
  zones               = [1, 2, 3]

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = module.appgateway_temp_snet.id
  public_ip_id = azurerm_public_ip.appgateway_temp_public_ip.id

  # Configure backends
  backends = {

    apim = {
      protocol                    = "Https"
      host                        = format("api-app.internal.%s.%s", var.dns_zone_io, var.external_domain)
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = [format("api-app.internal.%s.%s", var.dns_zone_io, var.external_domain)]
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
        module.appservice_app_backendl1.default_site_hostname,
        module.appservice_app_backendl2.default_site_hostname,
      ]
      probe                       = "/info"
      probe_name                  = "probe-appbackend-app"
      request_timeout             = 10
      pick_host_name_from_backend = true
    }

    developerportal-backend = {
      protocol     = "Https"
      host         = null
      port         = 443
      ip_addresses = null # with null value use fqdns
      fqdns = [
        module.appservice_devportal_be.default_site_hostname,
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
        module.appservice_selfcare_be.default_site_hostname,
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
        module.appservice_continua.default_site_hostname,
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

  ssl_profiles = [{
    name                             = format("%s-api-mtls-profile", local.project)
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
      name                             = format("%s-ssl-profile", local.project)
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
      key_vault_id = module.key_vault.id
    }
  ]

  # Configure listeners
  listeners = {

    api-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_api_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api.version}",
          ""
        )
      }
    }

    api-mtls-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-mtls.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-api-mtls-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_api_mtls_certificate_name
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
        name = var.app_gateway_api_io_italia_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_io_italia_it.version}",
          ""
        )
      }
    }

    api-app-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-app.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = var.app_gateway_api_app_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_app.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_app.version}",
          ""
        )
      }
    }

    api-web-io-pagopa-it = {
      protocol           = "Https"
      host               = format("api-web.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = azurerm_web_application_firewall_policy.api_app.id

      certificate = {
        name = var.app_gateway_api_web_certificate_name
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
        name = var.app_gateway_app_backend_io_italia_it_certificate_name
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
        name = var.app_gateway_developerportal_backend_io_italia_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it.version}",
          ""
        )
      }
    }

    api-io-selfcare-pagopa-it = {
      protocol           = "Https"
      host               = local.selfcare_io.backend_hostname
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_api_io_selfcare_pagopa_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_api_io_selfcare_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_api_io_selfcare_pagopa_it.version}",
          ""
        )
      }
    }

    firmaconio-selfcare-pagopa-it = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_firmaconio_selfcare, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_firmaconio_selfcare_pagopa_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_firmaconio_selfcare_pagopa_it.version}",
          ""
        )
      }
    }

    continua-io-pagopa-it = {
      protocol           = "Https"
      host               = format("continua.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_continua_io_pagopa_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_continua.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_continua.version}",
          ""
        )
      }
    }

    selfcare-io-pagopa-it = {
      protocol           = "Https"
      host               = format("selfcare.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_selfcare_io_pagopa_it_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_selfcare_io.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_selfcare_io.version}",
          ""
        )
      }
    }

    openid-provider-io-pagopa-it = {
      protocol           = "Https"
      host               = format("openid-provider.%s.%s", var.dns_zone_io, var.external_domain)
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_openid_provider_io_pagopa_it_certificate_name
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

    api-app-io-pagopa-it = {
      listener              = "api-app-io-pagopa-it"
      backend               = "appbackend-app"
      rewrite_rule_set_name = "rewrite-rule-set-api-app"
      priority              = 70
    }

    api-web-io-pagopa-it = {
      listener              = "api-web-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api-web"
      priority              = 100
    }

    app-backend-io-italia-it = {
      listener              = "app-backend-io-italia-it"
      backend               = "appbackend-app"
      rewrite_rule_set_name = "rewrite-rule-set-api-app"
      priority              = 40
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
      name = "rewrite-rule-set-api-app"
      rewrite_rules = [{
        name          = "http-headers-api-app"
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
              pattern     = join("|", var.app_gateway_deny_paths)
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
            query_string = null
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
  app_gateway_min_capacity = "10"
  app_gateway_max_capacity = var.app_gateway_max_capacity

  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
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
      description   = "One or more backend pools are down, check Backend Health on Azure portal"
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
          dimension   = []
        }
      ]
      dynamic_criteria = []
    }

    response_time = {
      description   = "Backends response time is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "BackendLastByteResponseTime"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
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
      description   = "Abnormal failed requests"
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
          dimension                = []
        }
      ]
    }

  }

  tags = var.tags
}
