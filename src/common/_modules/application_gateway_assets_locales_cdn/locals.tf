locals {

  assets_cdn_prefix    = "assets-afd-01"
  assets_pagopa_prefix = "assets-cdn-io-pagopa-it"
  assets_italia_prefix = "assets-cdn-io-italia-it"

  name = "${var.project}-assets-agw-01"

  backend_address_pool_name = "io-p-itn-assets-afd-01"
  backend_address_pool_fqdn = "assets.io.pagopa.it"

  frontend_port_name        = "appGatewayFrontendPort"
  frontend_secure_port_name = "appGatewayFrontendSecurePort"

  frontend_public_ip_configuration_name = "appGwPublicFrontendIpIPv4"

  # HTTP
  assets_pagopa_http_listener_name                = "${local.assets_pagopa_prefix}-http-listener"
  assets_italia_http_listener_name                = "${local.assets_italia_prefix}-http-listener"
  assets_pagopa_routing_http_rule_name            = "${local.assets_pagopa_prefix}-http-rule"
  assets_italia_routing_http_rule_name            = "${local.assets_italia_prefix}-http-rule"
  assets_pagopa_https_redirect_configuration_name = "${local.assets_pagopa_prefix}-https-redirect-conf"
  assets_italia_https_redirect_configuration_name = "${local.assets_italia_prefix}-https-redirect-conf"
  assets_pagopa_https_redirect_name               = "${local.assets_pagopa_prefix}-https-redirect"
  assets_italia_https_redirect_name               = "${local.assets_italia_prefix}-https-redirect"

  # HTTPS
  assets_pagopa_listener_name     = "${local.assets_pagopa_prefix}-listener"
  assets_italia_listener_name     = "${local.assets_italia_prefix}-listener"
  assets_pagopa_routing_rule_name = "${local.assets_pagopa_prefix}-rule"
  assets_italia_routing_rule_name = "${local.assets_italia_prefix}-rule"

  assets_pagopa_certificate_name         = "" # TODO: add certificate name
  assets_pagopa_certificate_kv_secret_id = "https://${var.custom_domains_certificate_kv_name}.vault.azure.net:443/secrets/${local.assets_pagopa_certificate_name}/"
  assets_italia_certificate_name         = "" # TODO: add certificate name
  assets_italia_certificate_kv_secret_id = "https://${var.custom_domains_certificate_kv_name}.vault.azure.net:443/secrets/${local.assets_italia_certificate_name}/"

  backend_settings_name = "${local.assets_cdn_prefix}-backend-pool-settings"
  backend_probe_name    = "${local.assets_cdn_prefix}-probe"

}