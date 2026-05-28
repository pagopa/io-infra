locals {

  ioapp_cdn_prefix    = "ioapp-afd-01"
  ioapp_it_prefix     = "cdn-io-app-it"
  www_ioapp_it_prefix = "cdn-www-io-app-it"

  name = "${var.project}-ioapp-agw-01"

  backend_address_pool_name = "io-p-itn-ioapp-afd-01"
  backend_address_pool_fqdn = "io-p-itn-ioapp-fde-01-dghmgydmfsfthzde.a01.azurefd.net" # io-p-itn-ioapp-afd-01 endpoint

  frontend_port_name        = "appGatewayFrontendPort"
  frontend_secure_port_name = "appGatewayFrontendSecurePort"

  frontend_public_ip_configuration_name = "${local.name}-ip-conf"

  # HTTP
  ioapp_it_http_listener_name                    = "${local.ioapp_it_prefix}-http-listener"
  www_ioapp_it_http_listener_name                = "${local.www_ioapp_it_prefix}-http-listener"
  ioapp_it_routing_http_rule_name                = "${local.ioapp_it_prefix}-http-rule"
  www_ioapp_it_routing_http_rule_name            = "${local.www_ioapp_it_prefix}-http-rule"
  ioapp_it_https_redirect_configuration_name     = "${local.ioapp_it_prefix}-https-redirect"
  www_ioapp_it_https_redirect_configuration_name = "${local.www_ioapp_it_prefix}-https-redirect"

  # HTTPS
  ioapp_it_https_listener_name     = "${local.ioapp_it_prefix}-https-listener"
  www_ioapp_it_https_listener_name = "${local.www_ioapp_it_prefix}-https-listener"
  ioapp_it_routing_rule_name       = "${local.ioapp_it_prefix}-rule"
  www_ioapp_it_routing_rule_name   = "${local.www_ioapp_it_prefix}-rule"

  ioapp_it_certificate_name             = "ioapp-it"
  ioapp_it_certificate_kv_secret_id     = "https://${var.custom_domains_certificate_kv_name}.vault.azure.net/secrets/${local.ioapp_it_certificate_name}/"
  www_ioapp_it_certificate_name         = "www-ioapp-it"
  www_ioapp_it_certificate_kv_secret_id = "https://${var.custom_domains_certificate_kv_name}.vault.azure.net/secrets/${local.www_ioapp_it_certificate_name}/"

  backend_settings_name = "${local.ioapp_cdn_prefix}-backend-pool-settings"
  backend_probe_name    = "${local.ioapp_cdn_prefix}-probe"

}