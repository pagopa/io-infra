resource "azurerm_application_gateway" "assets_agw" {

  name                = local.name
  resource_group_name = var.resource_group_common
  location            = var.location

  zones        = ["1", "2", "3"]
  enable_http2 = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agw.id]
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = null
  }

  autoscale_configuration {
    min_capacity = var.autoscale_min_capacity
    max_capacity = var.autoscale_max_capacity
  }

  gateway_ip_configuration {
    name      = "${local.name}-snet-conf"
    subnet_id = azurerm_subnet.agw.id
  }

  frontend_ip_configuration {
    name                 = local.frontend_public_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = local.frontend_secure_port_name
    port = 443
  }

  # HTTP listeners used for redirect

  http_listener {
    name                           = local.assets_pagopa_http_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_name                      = "assets.cdn.io.pagopa.it"
  }

  http_listener {
    name                           = local.assets_italia_http_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_name                      = "assets.cdn.io.italia.it"
  }

  # HTTPS listeners

  http_listener {
    name                           = local.assets_pagopa_https_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_secure_port_name
    protocol                       = "Https"
    host_name                      = "assets.cdn.io.pagopa.it"
    require_sni                    = true
    ssl_certificate_name           = local.assets_pagopa_certificate_name
  }

  http_listener {
    name                           = local.assets_italia_https_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_secure_port_name
    protocol                       = "Https"
    host_name                      = "assets.cdn.io.italia.it"
    require_sni                    = true
    ssl_certificate_name           = local.assets_italia_certificate_name
  }

  # HTTP redirect rules

  request_routing_rule {
    name                        = local.assets_pagopa_routing_http_rule_name
    rule_type                   = "Basic"
    http_listener_name          = local.assets_pagopa_http_listener_name
    redirect_configuration_name = local.assets_pagopa_https_redirect_configuration_name
    priority                    = 1
  }

  request_routing_rule {
    name                        = local.assets_italia_routing_http_rule_name
    rule_type                   = "Basic"
    http_listener_name          = local.assets_italia_http_listener_name
    redirect_configuration_name = local.assets_italia_https_redirect_configuration_name
    priority                    = 2
  }

  redirect_configuration {
    name                 = local.assets_pagopa_https_redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = local.assets_pagopa_https_listener_name
  }

  redirect_configuration {
    name                 = local.assets_italia_https_redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = local.assets_italia_https_listener_name
  }

  # HTTPS rules

  request_routing_rule {
    name                       = local.assets_pagopa_routing_rule_name
    http_listener_name         = local.assets_pagopa_https_listener_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_settings_name
    priority                   = 3
  }

  request_routing_rule {
    name                       = local.assets_italia_routing_rule_name
    http_listener_name         = local.assets_italia_https_listener_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_settings_name
    priority                   = 4
  }

  ##### TEST domain block

  http_listener {
    name                           = local.test_http_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_name                      = "test.assets.cdn.io.pagopa.it"
  }


  http_listener {
    name                           = local.test_https_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_secure_port_name
    protocol                       = "Https"
    host_name                      = "test.assets.cdn.io.pagopa.it"
    require_sni                    = true
    ssl_certificate_name           = local.test_certificate_name
  }

  request_routing_rule {
    name                        = local.test_routing_http_rule_name
    rule_type                   = "Basic"
    http_listener_name          = local.test_http_listener_name
    redirect_configuration_name = local.test_https_redirect_configuration_name
    priority                    = 5
  }

  redirect_configuration {
    name                 = local.test_https_redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = local.test_https_listener_name
  }

  request_routing_rule {
    name                       = local.test_routing_rule_name
    http_listener_name         = local.test_https_listener_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_settings_name
    priority                   = 6
  }

  #################

  backend_address_pool {
    name  = local.backend_address_pool_name
    fqdns = [local.backend_address_pool_fqdn]
  }

  backend_http_settings {
    name                                = local.backend_settings_name
    port                                = 443
    protocol                            = "Https"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true
    probe_name                          = local.backend_probe_name
    request_timeout                     = 20
  }

  probe {
    name                                      = local.backend_probe_name
    protocol                                  = "Https"
    path                                      = "/probes/healthcheck.txt"
    timeout                                   = 5
    interval                                  = 10
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200"]
    }
  }

  ssl_certificate {
    name                = local.assets_pagopa_certificate_name
    key_vault_secret_id = local.assets_pagopa_certificate_kv_secret_id
  }

  ssl_certificate {
    name                = local.assets_italia_certificate_name
    key_vault_secret_id = local.assets_italia_certificate_kv_secret_id
  }

  ssl_certificate {
    name                = local.test_certificate_name
    key_vault_secret_id = local.test_certificate_kv_secret_id
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.agw.id

  global {
    request_buffering_enabled  = true
    response_buffering_enabled = true
  }

  tags = var.tags
}