
############################
## App service spid login ##
############################
module "spid_login" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v4.1.15"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-spid-login", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.spid_login_plan_sku_tier
  plan_sku_size = var.spid_login_plan_sku_size

  # App service
  name                = format("%s-spid-login", local.project)
  resource_group_name = azurerm_resource_group.common_rg.name
  location            = azurerm_resource_group.common_rg.location


  always_on         = true
  linux_fx_version  = "NODE|18-lts"
  app_command_line  = "npm run start"
  health_check_path = "/healthcheck"

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    WEBSITE_NODE_DEFAULT_VERSION = "18.13.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_VNET_ROUTE_ALL       = "1"
    WEBSITE_DNS_SERVER           = "168.63.129.16"

    // ENVIRONMENT
    NODE_ENV = "production"

    FETCH_KEEPALIVE_ENABLED = "true"
    // see https://github.com/MicrosoftDocs/azure-docs/issues/29600#issuecomment-607990556
    // and https://docs.microsoft.com/it-it/azure/app-service/app-service-web-nodejs-best-practices-and-troubleshoot-guide#scenarios-and-recommendationstroubleshooting
    // FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL should not exceed 120000 (app service socket timeout)
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL = "110000"
    // (FETCH_KEEPALIVE_MAX_SOCKETS * number_of_node_processes) should not exceed 160 (max sockets per VM)
    FETCH_KEEPALIVE_MAX_SOCKETS         = "128"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"


    # REDIS
    REDIS_URL      = module.redis_spid_login.hostname
    REDIS_PORT     = module.redis_spid_login.ssl_port
    REDIS_PASSWORD = module.redis_spid_login.primary_access_key

    # SPID
    ORG_ISSUER       = "https://api-web.pagopa.it/ioweb/auth"
    ORG_URL          = "https://pagopa.gov.it"
    ACS_BASE_URL     = format("https://%s/%s", var.app_gateway_host_name, local.spid_login_base_path)
    ORG_DISPLAY_NAME = "PagoPA S.p.A"
    ORG_NAME         = "PagoPA"

    AUTH_N_CONTEXT = "https://www.spid.gov.it/SpidL2"

    ENDPOINT_ACS      = "/acs"
    ENDPOINT_ERROR    = "/error"
    #TODO
    ENDPOINT_SUCCESS  = var.enable_custom_dns ? local.custom_dns_frontend_url : local.cdn_frontend_url
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES = "name,familyName,fiscalNumber"

    REQUIRED_ATTRIBUTES_SERVICE_NAME = "IO Web Onboarding Portal"
    ENABLE_FULL_OPERATOR_METADATA    = true
    COMPANY_EMAIL                    = "pagopa@pec.governo.it"
    COMPANY_FISCAL_CODE              = 15376371009
    COMPANY_IPA_CODE                 = "PagoPA"
    COMPANY_NAME                     = "PagoPA S.p.A"
    COMPANY_VAT_NUMBER               = 15376371009

    # TODO
    METADATA_PUBLIC_CERT  = var.agid_spid_public_cert != null ? trimspace(data.azurerm_key_vault_secret.agid_spid_cert[0].value) : trimspace(tls_self_signed_cert.spid_self.cert_pem)
    METADATA_PRIVATE_CERT = var.agid_spid_private_key != null ? trimspace(data.azurerm_key_vault_secret.agid_spid_private_key[0].value) : trimspace(tls_private_key.spid.private_key_pem)

    ENABLE_JWT                         = "true"
    INCLUDE_SPID_USER_ON_INTROSPECTION = "true"

    TOKEN_EXPIRATION = "3600"
    JWT_TOKEN_ISSUER = "SPID"
    # TODO
    JWT_TOKEN_PRIVATE_KEY = trimspace(tls_private_key.jwt.private_key_pem)
    TOKEN_EXPIRATION      = 3600

    # ADE
    ENABLE_ADE_AA = "false"

    # application insights key
    APPINSIGHTS_DISABLED           = false
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    # Spid logs
    #TODO: enable logs
    ENABLE_SPID_ACCESS_LOGS = false
    # SPID_LOGS_STORAGE_CONNECTION_STRING = "DefaultEndpointsProtocol=https;AccountName=${module.storage_account.name};AccountKey=${module.storage_account.primary_access_key};BlobEndpoint=${module.storage_account.primary_blob_endpoint};"
    # SPID_LOGS_STORAGE_CONTAINER_NAME    = azurerm_storage_container.spid_logs.name
    # SPID_LOGS_PUBLIC_KEY                = trimspace(data.azurerm_key_vault_secret.spid_logs_public_key.value)
  }

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_id   = module.subnet_spid_login.id

  tags = var.tags
}
