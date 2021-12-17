### Common resources

locals {
  selfcare = {
    backend_hostname  = "api.${var.dns_zone_io_selfcare}.${var.external_domain}"
    frontend_hostname = "${var.dns_zone_io_selfcare}.${var.external_domain}"
  }
}

### Frontend common resources
resource "azurerm_resource_group" "selfcare_fe_rg" {
  name     = "${local.project}-selfcare-fe-rg"
  location = var.location

  tags = var.tags
}

### Frontend resources
module "selfcare_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.0.13"

  name                  = "selfcare"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.selfcare_fe_rg.name
  location              = azurerm_resource_group.selfcare_fe_rg.location
  hostname              = "${var.dns_zone_io_selfcare}.${var.external_domain}"
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "404.html"

  dns_zone_name                = azurerm_dns_zone.io_selfcare_pagopa_it[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.io_selfcare_pagopa_it[0].resource_group_name

  keyvault_vault_name          = module.key_vault.name
  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' https://www.google.com https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; worker-src 'none'; font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://assets.cdn.io.italia.it data:; "
      }
    ]
  }

  tags = var.tags
}

### Backend common resources
resource "azurerm_resource_group" "selfcare_be_rg" {
  name     = format("%s-selfcare-be-rg", local.project)
  location = var.location

  tags = var.tags
}

## key vault

data "azurerm_key_vault_secret" "selfcare_apim_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_client_id" {
  name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "selfcare_io_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_jira_token" {
  name         = "devportal-JIRA-TOKEN"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_app_service_plan" "selfcare_be_common" {
  name                = format("%s-plan-selfcare-be-common", local.project)
  location            = azurerm_resource_group.selfcare_be_rg.location
  resource_group_name = azurerm_resource_group.selfcare_be_rg.name

  kind     = "Linux"
  reserved = true

  sku {
    tier     = var.selfcare_plan_sku_tier
    size     = var.selfcare_plan_sku_size
    capacity = var.selfcare_plan_sku_capacity
  }

  tags = var.tags
}

# Subnet to host checkout function
module "selfcare_be_common_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-selfcare-be-common-snet", local.project)
  address_prefixes                               = var.cidr_subnet_selfcare_be
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Only 1 subnet can be associated to a service plan
# azurerm_app_service_virtual_network_swift_connection requires an app service id
# so we choose one of the app service in the app service plan
resource "azurerm_app_service_virtual_network_swift_connection" "selfcare_common" {
  app_service_id = module.appservice_selfcare_be.id
  subnet_id      = module.selfcare_be_common_snet.id
}

module "appservice_selfcare_be" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.13"

  name                = format("%s-app-selfcare-be", local.project)
  resource_group_name = azurerm_resource_group.selfcare_be_rg.name

  plan_type = "external"
  plan_id   = azurerm_app_service_plan.selfcare_be_common.id

  app_command_line  = "node /home/site/wwwroot/build/src/app.js"
  linux_fx_version  = "NODE|14-lts" # to try
  health_check_path = "/info"

  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION = "6.11.2"
    WEBSITE_NPM_DEFAULT_VERSION  = "6.1.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    LOG_LEVEL = "info"

    SANDBOX_FISCAL_CODE = data.azurerm_key_vault_secret.selfcare_io_sandbox_fiscal_code.value
    LOGO_URL            = "https://assets.cdn.io.italia.it/logos"

    # SelfCare configuration
    IDP = "selfcare"

    # Fn-Admin connection
    ADMIN_API_URL = "http://api-internal.io.italia.it"
    ADMIN_API_KEY = data.azurerm_key_vault_secret.selfcare_apim_io_service_key.value

    # Apim connection
    APIM_PRODUCT_NAME           = "io-services-api"
    APIM_USER_GROUPS            = "apilimitedmessagewrite,apiinforead,apimessageread,apilimitedprofileread"
    ARM_APIM                    = "io-p-apim-api"
    ARM_RESOURCE_GROUP          = "io-p-rg-internal"
    ARM_SUBSCRIPTION_ID         = data.azurerm_subscription.current.subscription_id
    ARM_TENANT_ID               = data.azurerm_client_config.current.tenant_id
    SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_client_id.value
    SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_secret.value
    SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_client_config.current.tenant_id
    USE_SERVICE_PRINCIPAL       = "1"

    FRONTEND_URL                          = "https://${local.selfcare.frontend_hostname}"
    BACKEND_URL                           = "https://${local.selfcare.backend_hostname}"
    LOGIN_URL                             = "https://${local.selfcare.frontend_hostname}/login"
    FAILURE_URL                           = "https://${local.selfcare.frontend_hostname}/500.html"
    SELFCARE_LOGIN_URL                    = "https://${var.selfcare_external_hostname}/auth/login"
    SELFCARE_IDP_ISSUER                   = "https://${var.selfcare_external_hostname}"
    SELFCARE_IDP_ISSUER_JWT_SIGNATURE_KEY = data.http.selfcare_well_known_jwks_json.body
    JWT_SIGNATURE_KEY                     = "anykey" # todo private key con to sign session tokens (internal)

    # JIRA integration for Service review workflow
    JIRA_USERNAME              = "github-bot@pagopa.it"
    JIRA_NAMESPACE_URL         = "https://pagopa.atlassian.net"
    JIRA_BOARD                 = "IES"
    JIRA_STATUS_COMPLETE       = "DONE"
    JIRA_STATUS_IN_PROGRESS    = "REVIEW"
    JIRA_STATUS_NEW            = "NEW"
    JIRA_STATUS_NEW_ID         = "11"
    JIRA_STATUS_REJECTED       = "REJECTED"
    JIRA_SERVICE_TAG_PREFIX    = "SERVICE-"
    JIRA_TRANSITION_START_ID   = "31"
    JIRA_TRANSITION_REJECT_ID  = "21"
    JIRA_TRANSITION_UPDATED_ID = "51"
    JIRA_DELEGATE_ID_FIELD     = "customfield_10087"
    JIRA_EMAIL_ID_FIELD        = "customfield_10084"
    JIRA_ORGANIZATION_ID_FIELD = "customfield_10088"
    JIRA_TOKEN                 = data.azurerm_key_vault_secret.selfcare_devportal_jira_token.value
  }

  allowed_subnets = [module.appgateway_snet.id]

  tags = var.tags
}

data "http" "selfcare_well_known_jwks_json" {
  url = "https://dev.${var.selfcare_external_hostname}/.well-known/jwks.json" # todo remove .dev

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}
