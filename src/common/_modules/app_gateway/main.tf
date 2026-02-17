#################################
###    Application Gateway    ###
#################################

resource "azurerm_application_gateway" "this" {
  name                = local.name
  resource_group_name = var.resource_group_common
  location            = var.location
  zones               = [1, 2, 3]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = var.capacity_settings.mode == "fixed" ? var.capacity_settings.capacity : null
  }

  gateway_ip_configuration {
    name      = "${local.name}-snet-conf"
    subnet_id = azurerm_subnet.agw.id
  }

  frontend_ip_configuration {
    name                 = "${local.name}-ip-conf"
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  dynamic "backend_address_pool" {
    for_each = local.backends
    iterator = backend
    content {
      name         = "${backend.key}-address-pool"
      fqdns        = backend.value.ip_addresses == null ? backend.value.fqdns : null
      ip_addresses = backend.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.backends
    iterator = backend

    content {
      name                                = "${backend.key}-http-settings"
      host_name                           = backend.value.host
      cookie_based_affinity               = "Disabled"
      affinity_cookie_name                = "ApplicationGatewayAffinity" # to avoid unwanted changes in terraform plan
      path                                = ""
      port                                = backend.value.port
      protocol                            = backend.value.protocol
      request_timeout                     = backend.value.request_timeout
      probe_name                          = backend.value.probe_name
      pick_host_name_from_backend_address = backend.value.pick_host_name_from_backend
    }
  }

  dynamic "probe" {
    for_each = local.backends
    iterator = backend

    content {
      host                                      = backend.value.host
      minimum_servers                           = 0
      name                                      = "probe-${backend.key}"
      path                                      = backend.value.probe
      pick_host_name_from_backend_http_settings = backend.value.pick_host_name_from_backend
      protocol                                  = backend.value.protocol
      timeout                                   = 30
      interval                                  = 30
      unhealthy_threshold                       = 3

      match {
        status_code = ["200-399"]
      }
    }
  }

  dynamic "frontend_port" {
    for_each = distinct([for listener in values(local.listeners) : listener.port])

    content {
      name = "${local.name}-${frontend_port.value}-port"
      port = frontend_port.value
    }
  }

  dynamic "ssl_certificate" {
    for_each = local.listeners
    iterator = listener

    content {
      name                = listener.value.certificate.name
      key_vault_secret_id = listener.value.certificate.id
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = local.trusted_client_certificates
    iterator = t
    content {
      name = t.value.secret_name
      data = data.azurerm_key_vault_secret.client_cert[t.value.secret_name].value
    }
  }

  dynamic "ssl_profile" {
    for_each = local.ssl_profiles
    iterator = p
    content {
      name                             = p.value.name
      trusted_client_certificate_names = p.value.trusted_client_certificate_names
      verify_client_cert_issuer_dn     = p.value.verify_client_cert_issuer_dn
      ssl_policy {
        disabled_protocols   = p.value.ssl_policy.disabled_protocols
        policy_type          = p.value.ssl_policy.policy_type
        policy_name          = p.value.ssl_policy.policy_name
        cipher_suites        = p.value.ssl_policy.cipher_suites
        min_protocol_version = p.value.ssl_policy.min_protocol_version
      }
    }
  }

  dynamic "http_listener" {
    for_each = local.listeners
    iterator = listener

    content {
      name                           = "${listener.key}-listener"
      frontend_ip_configuration_name = try(listener.value.type, "Public") == "Private" ? "${local.name}-private-ip-conf" : "${local.name}-ip-conf"
      frontend_port_name             = "${local.name}-${listener.value.port}-port"
      protocol                       = "Https"
      ssl_certificate_name           = listener.value.certificate.name
      require_sni                    = true
      host_name                      = listener.value.host
      ssl_profile_name               = listener.value.ssl_profile_name
      firewall_policy_id             = listener.value.firewall_policy_id
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.routes_path_based
    iterator = route

    content {
      name               = "${route.key}-reqs-routing-rule-by-path"
      rule_type          = "PathBasedRouting"
      http_listener_name = "${route.value.listener}-listener"
      url_path_map_name  = "${route.value.url_map_name}-url-map"
      priority           = route.value.priority
    }
  }

  dynamic "url_path_map" {
    for_each = local.url_path_map
    iterator = path

    content {
      name                               = "${path.key}-url-map"
      default_backend_address_pool_name  = "${path.value.default_backend}-address-pool"
      default_backend_http_settings_name = "${path.value.default_backend}-http-settings"
      default_rewrite_rule_set_name      = path.value.default_rewrite_rule_set_name

      dynamic "path_rule" {
        for_each = path.value.path_rule
        iterator = path_rule

        content {
          name                       = path_rule.key
          paths                      = path_rule.value.paths
          backend_address_pool_name  = "${path_rule.value.backend}-address-pool"
          backend_http_settings_name = "${path_rule.value.backend}-http-settings"
          rewrite_rule_set_name      = path_rule.value.rewrite_rule_set_name
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.routes
    iterator = route

    content {
      #⚠️ backend_address_pool_name, backend_http_settings_name, redirect_configuration_name, and rewrite_rule_set_name are applicable only when rule_type is Basic.
      name                       = "${route.key}-reqs-routing-rule"
      rule_type                  = "Basic" #(Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.
      http_listener_name         = "${route.value.listener}-listener"
      backend_address_pool_name  = "${route.value.backend}-address-pool"
      backend_http_settings_name = "${route.value.backend}-http-settings"
      rewrite_rule_set_name      = route.value.rewrite_rule_set_name
      priority                   = route.value.priority
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = local.rewrite_rule_sets
    iterator = rule_set
    content {
      name = rule_set.value.name

      dynamic "rewrite_rule" {
        for_each = rule_set.value.rewrite_rules
        content {
          name          = rewrite_rule.value.name
          rule_sequence = rewrite_rule.value.rule_sequence

          dynamic "condition" {
            for_each = rewrite_rule.value.conditions
            iterator = condition
            content {
              variable    = condition.value.variable
              pattern     = condition.value.pattern
              ignore_case = condition.value.ignore_case
              negate      = condition.value.negate
            }
          }

          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value.request_header_configurations
            iterator = req_header
            content {
              header_name  = req_header.value.header_name
              header_value = req_header.value.header_value
            }
          }

          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value.response_header_configurations
            iterator = res_header
            content {
              header_name  = res_header.value.header_name
              header_value = res_header.value.header_value
            }
          }

          dynamic "url" {
            for_each = rewrite_rule.value.url != null ? ["dummy"] : []

            content {
              path         = rewrite_rule.value.url.path
              query_string = rewrite_rule.value.url.query_string
              reroute      = rewrite_rule.value.url.reroute
              components   = rewrite_rule.value.url.components
            }
          }
        }
      }

    }
  }

  # see: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway#identity
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.appgateway.id]
  }

  ssl_policy {
    policy_type = "Custom"
    # this cipher suites are the defaults ones
    cipher_suites = [
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    ]
    min_protocol_version = "TLSv1_2"
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.agw.id

  dynamic "autoscale_configuration" {
    for_each = var.capacity_settings.mode == "autoscale" ? [1] : []
    content {
      min_capacity = var.capacity_settings.min_capacity
      max_capacity = var.capacity_settings.max_capacity
    }
  }

  tags = var.tags
}