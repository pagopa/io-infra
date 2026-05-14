resource "azurerm_application_gateway" "ioapp_agw" {

  name                = local.name
  resource_group_name = var.resource_group
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
    name                           = local.ioapp_it_http_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_name                      = "ioapp.it"
  }

  http_listener {
    name                           = local.www_ioapp_it_http_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_name                      = "www.ioapp.it"
  }

  # HTTPS listeners

  http_listener {
    name                           = local.ioapp_it_https_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_secure_port_name
    protocol                       = "Https"
    host_name                      = "ioapp.it"
    require_sni                    = true
    ssl_certificate_name           = local.ioapp_it_certificate_name
  }

  http_listener {
    name                           = local.www_ioapp_it_https_listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_secure_port_name
    protocol                       = "Https"
    host_name                      = "www.ioapp.it"
    require_sni                    = true
    ssl_certificate_name           = local.www_ioapp_it_certificate_name
  }

  # HTTP redirect rules

  request_routing_rule {
    name                        = local.ioapp_it_routing_http_rule_name
    rule_type                   = "Basic"
    http_listener_name          = local.ioapp_it_http_listener_name
    redirect_configuration_name = local.ioapp_it_https_redirect_configuration_name
    priority                    = 1
  }

  request_routing_rule {
    name                        = local.www_ioapp_it_routing_http_rule_name
    rule_type                   = "Basic"
    http_listener_name          = local.www_ioapp_it_http_listener_name
    redirect_configuration_name = local.www_ioapp_it_https_redirect_configuration_name
    priority                    = 2
  }

  redirect_configuration {
    name                 = local.ioapp_it_https_redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = local.ioapp_it_https_listener_name
  }

  redirect_configuration {
    name                 = local.www_ioapp_it_https_redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = local.www_ioapp_it_https_listener_name
  }

  # HTTPS rules

  request_routing_rule {
    name                       = local.ioapp_it_routing_rule_name
    http_listener_name         = local.ioapp_it_https_listener_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_settings_name
    priority                   = 3
  }

  request_routing_rule {
    name                       = local.www_ioapp_it_routing_rule_name
    http_listener_name         = local.www_ioapp_it_https_listener_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_settings_name
    priority                   = 4
  }

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
    path                                      = "/"
    timeout                                   = 5
    interval                                  = 10
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200"]
    }
  }

  ssl_certificate {
    name                = local.ioapp_it_certificate_name
    key_vault_secret_id = local.ioapp_it_certificate_kv_secret_id
  }

  ssl_certificate {
    name                = local.www_ioapp_it_certificate_name
    key_vault_secret_id = local.www_ioapp_it_certificate_kv_secret_id
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.agw.id

  global {
    request_buffering_enabled  = true
    response_buffering_enabled = true
  }

  tags = var.tags
}