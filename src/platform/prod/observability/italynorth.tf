module "monitoring_italynorth" {
  source = "./_modules/monitoring"

  location              = "italynorth"
  location_short        = local.location_short.italynorth
  project               = local.project_itn
  resource_group_common = local.resource_groups.itn.common

  kv_id        = local.core.key_vault.weu.io_p_itn_platform_kv_01.id # Location into the KV module output should be updated to itn (at the moment is weu) after the migration to ITN is completed
  kv_common_id = local.core.key_vault.weu.io_p_itn_platform_kv_01.id # We are going to have only one platform KV containing every secret

  test_urls = [
    {
      # https://developerportal-backend.io.italia.it/info
      name                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.developer_portal_backend
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.developer_portal_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api.io.italia.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.api
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.api
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://app-backend.io.italia.it/info
      name                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://io.italia.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.name
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.name
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # https://assets.cdn.io.pagopa.it/status/backend.json
      name                              = "assets.cdn.io.pagopa.it",
      host                              = "assets.cdn.io.pagopa.it",
      path                              = "/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # CIE https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=xx_servizicie
      name                              = "CIE L2",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # CIE https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL3&entityID=xx_servizicie
      name                              = "CIE L3",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL3&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      name                              = "Spid-registry",
      host                              = "registry.spid.gov.it",
      path                              = "/metadata/idp/spid-entities-idps.xml",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-arubaid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=arubaid
      name                              = "SpidL2-arubaid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=arubaid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-infocertid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=infocertid
      name                              = "SpidL2-infocertid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=infocertid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-lepidaid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=lepidaid
      name                              = "SpidL2-lepidaid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=lepidaid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-namirialid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=namirialid
      name                              = "SpidL2-namirialid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=namirialid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-posteid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=posteid
      name                              = "SpidL2-posteid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=posteid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-sielteid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=sielteid
      name                              = "SpidL2-sielteid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=sielteid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-spiditalia https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=spiditalia
      name                              = "SpidL2-spiditalia",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=spiditalia",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-infocamere https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=infocamereid
      name                              = "SpidL2-infocamere",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=infocamereid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # SpidL2-timid https://app-backend.io.italia.it/api/auth/v1/login?authLevel=SpidL2&entityID=timid
      name                              = "SpidL2-timid",
      host                              = local.platform_core.dns.zones.public_dns_zones.io_italia_it.app_backend
      path                              = "/api/auth/v1/login?authLevel=SpidL2&entityID=timid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
      follow_redirects_enabled          = true
    },
    {
      # https://api.io.pagopa.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io.api
      host                              = local.platform_core.dns.zones.public_dns_zones.io.api
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-app.io.pagopa.it/info
      name                              = local.platform_core.dns.zones.public_dns_zones.io.api_app
      host                              = local.platform_core.dns.zones.public_dns_zones.io.api_app
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-web.io.pagopa.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io.api_web
      host                              = local.platform_core.dns.zones.public_dns_zones.io.api_web
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-mtls.io.pagopa.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io.api_mtls
      host                              = local.platform_core.dns.zones.public_dns_zones.io.api_mtls
      path                              = "",
      frequency                         = 900
      http_status                       = 400,
      ssl_cert_remaining_lifetime_check = 0,
      ssl_enabled                       = false
    },
    {
      # https://firmaconio.selfcare.pagopa.it
      name                              = "firmaconio.selfcare.pagopa.it"
      host                              = "firmaconio.selfcare.pagopa.it"
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://raw.githubusercontent.com/pagopa/io-services-metadata/master/status/backend.json
      name                              = "github-raw-status-backend",
      host                              = "raw.githubusercontent.com",
      path                              = "/pagopa/io-services-metadata/master/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://continua.io.pagopa.it
      name                              = local.platform_core.dns.zones.public_dns_zones.io.continua
      host                              = local.platform_core.dns.zones.public_dns_zones.io.continua
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
      follow_redirects_enabled          = true
    },
  ]

  tags = local.tags
}