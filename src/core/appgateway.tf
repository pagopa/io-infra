## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.project)
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  service_endpoints = [
    "Microsoft.Web",
  ]
}

## Application gateway ##
module "app_gw" {
  source = "git::https://github.com/pagopa/azurerm.git//app_gateway?ref=v2.0.9"

  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location
  name                = format("%s-appgateway", local.project)

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = module.appgateway_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = {

    apim = {
      protocol                    = "Https"
      host                        = "api-internal.io.italia.it"
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = ["api-internal.io.italia.it"]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 180
      pick_host_name_from_backend = false
    }

    apim-app = {
      protocol                    = "Https"
      host                        = "api-app.internal.io.pagopa.it"
      port                        = 443
      ip_addresses                = null # with null value use fqdns
      fqdns                       = ["api-app.internal.io.pagopa.it"]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim-app"
      request_timeout             = 10
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
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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
  }

  # maps listener to backend
  routes = {

    api-io-pagopa-it = {
      listener              = "api-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }

    api-io-italia-it = {
      listener              = "api-io-italia-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }

    api-mtls-io-pagopa-it = {
      listener              = "api-mtls-io-pagopa-it"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api-mtls"
    }

    api-app-io-pagopa-it = {
      listener              = "api-app-io-pagopa-it"
      backend               = "apim-app"
      rewrite_rule_set_name = "rewrite-rule-set-api-app"
    }

    app-backend-io-italia-it = {
      listener              = "app-backend-io-italia-it"
      backend               = "appbackend-app"
      rewrite_rule_set_name = "rewrite-rule-set-api-app"
    }

    developerportal-backend-io-italia-it = {
      listener              = "developerportal-backend-io-italia-it"
      backend               = "developerportal-backend"
      rewrite_rule_set_name = "rewrite-rule-set-developerportal-backend"
    }

    api-io-selfcare-pagopa-it = {
      listener              = "api-io-selfcare-pagopa-it"
      backend               = "selfcare-backend"
      rewrite_rule_set_name = "rewrite-rule-set-selfcare-backend"
    }

  }

  rewrite_rule_sets = [
    {
      name = "rewrite-rule-set-api"
      rewrite_rules = [{
        name          = "http-headers-api"
        rule_sequence = 100
        condition     = null
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
            # this header will be checked in apim policy
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
        condition     = null
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
            # this header will be checked in apim policy
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
        condition     = null
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
        condition     = null
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
        condition     = null
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
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  # Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_storage_id                 = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
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
          evaluation_total_count   = 2
          evaluation_failure_count = 2
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
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

  }

  tags = var.tags
}

## user assined identity: (application gateway) ##
resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.project)

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy_common" {
  key_vault_id            = data.azurerm_key_vault.common.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## user assined identity: (old application gateway) ##
data "azuread_service_principal" "app_gw_uai_kvreader" {
  display_name = format("%s-uai-kvreader", local.project)
}

resource "azurerm_key_vault_access_policy" "app_gw_uai_kvreader_common" {
  key_vault_id            = data.azurerm_key_vault.common.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_service_principal.app_gw_uai_kvreader.object_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

data "azurerm_key_vault_certificate" "app_gw_api" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_mtls" {
  name         = var.app_gateway_api_mtls_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_app" {
  name         = var.app_gateway_api_app_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_io_italia_it" {
  name         = var.app_gateway_api_io_italia_it_certificate_name
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_certificate" "app_gw_app_backend_io_italia_it" {
  name         = var.app_gateway_app_backend_io_italia_it_certificate_name
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_certificate" "app_gw_developerportal_backend_io_italia_it" {
  name         = var.app_gateway_developerportal_backend_io_italia_it_certificate_name
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_certificate" "app_gw_api_io_selfcare_pagopa_it" {
  name         = var.app_gateway_api_io_selfcare_pagopa_it_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "app_gw_mtls_header_name" {
  name         = "mtls-header-name"
  key_vault_id = module.key_vault.id
}

resource "azurerm_web_application_firewall_policy" "api_app" {
  name                = format("%s-waf-appgateway-api-app-policy", local.project)
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {

    managed_rule_set {
      type    = "OWASP"
      version = "3.1"

      rule_group_override {
        rule_group_name = "REQUEST-913-SCANNER-DETECTION"
        disabled_rules = [
          "913100",
          "913101",
          "913102",
          "913110",
          "913120",
        ]
      }

      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        disabled_rules = [
          "920300",
          "920320",
        ]
      }

      rule_group_override {
        rule_group_name = "REQUEST-930-APPLICATION-ATTACK-LFI"
        disabled_rules = [
          "930120",
        ]
      }

      rule_group_override {
        rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        disabled_rules = [
          "932150",
        ]
      }

      rule_group_override {
        rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
        disabled_rules = [
          "941130",
        ]
      }

      rule_group_override {
        rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
        disabled_rules = [
          "942100",
          "942120",
          "942190",
          "942200",
          "942210",
          "942240",
          "942250",
          "942260",
          "942330",
          "942340",
          "942370",
          "942380",
          "942430",
          "942440",
          "942450",
        ]
      }

    }
  }

  tags = var.tags
}
