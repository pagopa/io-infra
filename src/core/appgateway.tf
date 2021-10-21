## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.76"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
}

## Application gateway ##
module "app_gw" {
  source = "git::https://github.com/pagopa/azurerm.git//app_gateway?ref=app-gateway-improvements"

  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
  location            = data.azurerm_resource_group.vnet_common_rg.location
  name                = format("%s-app-gw", local.project)

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = module.appgateway_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = {
    apim = {
      protocol     = "Https"
      host         = "api-internal.io.italia.it"
      port         = 443
      ip_addresses = null # with null value use host
      probe        = "/status-0123456789abcdef"
      probe_name   = "probe-apim"
    }
    apim-app = {
      protocol     = "Https"
      host         = "api-app.internal.io.pagopa.it"
      port         = 443
      ip_addresses = null # with null value use host
      probe        = "/status-0123456789abcdef"
      probe_name   = "probe-apim"
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
        "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
        "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
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

    api = {
      protocol         = "Https"
      host             = format("api.%s.%s", var.dns_zone_io, var.external_domain)
      port             = 443
      ssl_profile_name = null

      certificate = {
        name = var.app_gateway_api_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.app_gw_api.secret_id,
          data.azurerm_key_vault_certificate.app_gw_api.version
        )
      }
    }

    api-app = {
      protocol         = "Https"
      host             = format("api-app.%s.%s", var.dns_zone_io, var.external_domain)
      port             = 443
      ssl_profile_name = null

      certificate = {
        name = var.app_gateway_api_app_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.app_gw_api_app.secret_id,
          data.azurerm_key_vault_certificate.app_gw_api_app.version
        )
      }
    }

    api-mtls = {
      protocol         = "Https"
      host             = format("api-mtls.%s.%s", var.dns_zone_io, var.external_domain)
      port             = 443
      ssl_profile_name = format("%s-api-mtls-profile", local.project)

      certificate = {
        name = var.app_gateway_api_mtls_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.app_gw_api_mtls.secret_id,
          data.azurerm_key_vault_certificate.app_gw_api_mtls.version
        )
      }
    }
  }

  # maps listener to backend
  routes = {
    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }

    api-app = {
      listener              = "api-app"
      backend               = "apim-app"
      rewrite_rule_set_name = "rewrite-rule-set-api-app"
    }

    api-mtls = {
      listener              = "api-mtls"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api-mtls"
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
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  # Logs
  # todo enable
  # sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  # sec_storage_id                 = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  tags = var.tags
}

## user assined identity: (application gateway) ##
resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.project)

  tags = var.tags
}

data "azurerm_key_vault_certificate" "app_gw_api" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_app" {
  name         = var.app_gateway_api_app_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_mtls" {
  name         = var.app_gateway_api_mtls_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "app_gw_mtls_header_name" {
  name         = "mtls-header-name"
  key_vault_id = module.key_vault.id
}
