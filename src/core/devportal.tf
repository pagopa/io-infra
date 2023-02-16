### Common resources

locals {
  devportal = {
    backend_hostname  = trimsuffix(azurerm_dns_a_record.developerportal_backend_io_italia_it.fqdn, ".")
    frontend_hostname = "developer.${var.dns_zone_io}.italia.it"
  }
}

## key vault

data "azurerm_key_vault_secret" "devportal_apim_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_service_principal_client_id" {
  name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_service_principal_secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_io_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_jira_token" {
  name         = "devportal-JIRA-TOKEN"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_client_id" {
  name         = "devportal-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_client_secret" {
  name         = "devportal-CLIENT-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_cookie_iv" {
  name         = "devportal-COOKIE-IV"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_cookie_key" {
  name         = "devportal-COOKIE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

# Only 1 subnet can be associated to a service plan
# azurerm_app_service_virtual_network_swift_connection requires an app service id
# so we choose one of the app service in the app service plan
resource "azurerm_app_service_virtual_network_swift_connection" "devportal_be" {
  app_service_id = module.appservice_devportal_be.id
  subnet_id      = module.selfcare_be_common_snet.id
}

#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_devportal_be" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v4.1.15"

  name                = format("%s-app-devportal-be", local.project)
  resource_group_name = azurerm_resource_group.selfcare_be_rg.name

  plan_type = "external"
  plan_id   = azurerm_app_service_plan.selfcare_be_common.id

  app_command_line  = "node /home/site/wwwroot/build/src/app.js"
  linux_fx_version  = "NODE|14-lts"
  health_check_path = "/info"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    LOG_LEVEL = "info"

    IDP = "azure-ad"

    SANDBOX_FISCAL_CODE = data.azurerm_key_vault_secret.devportal_io_sandbox_fiscal_code.value
    LOGO_URL            = "https://assets.cdn.io.pagopa.it/logos"

    # Fn-Admin connection
    ADMIN_API_URL = "https://${local.apim_hostname_api_app_internal}"
    ADMIN_API_KEY = data.azurerm_key_vault_secret.devportal_apim_io_service_key.value

    # Apim connection
    APIM_PRODUCT_NAME           = "io-services-api"
    APIM_USER_GROUPS            = "apilimitedmessagewrite,apiinforead,apimessageread,apilimitedprofileread"
    ARM_APIM                    = "io-p-apim-api"
    ARM_RESOURCE_GROUP          = "io-p-rg-internal"
    ARM_SUBSCRIPTION_ID         = data.azurerm_subscription.current.subscription_id
    ARM_TENANT_ID               = data.azurerm_client_config.current.tenant_id
    SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.devportal_service_principal_client_id.value
    SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.devportal_service_principal_secret.value
    SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_client_config.current.tenant_id
    USE_SERVICE_PRINCIPAL       = "1"

    # devportal configs
    CLIENT_NAME                = "io-p-developer-portal-app"
    POLICY_NAME                = "B2C_1_SignUpIn"
    RESET_PASSWORD_POLICY_NAME = "B2C_1_PasswordReset"
    POST_LOGIN_URL             = "https://${local.devportal.frontend_hostname}"
    POST_LOGOUT_URL            = "https://${local.devportal.frontend_hostname}"
    REPLY_URL                  = "https://${local.devportal.frontend_hostname}"
    TENANT_NAME                = "agidweb"
    CLIENT_ID                  = data.azurerm_key_vault_secret.devportal_client_id.value
    CLIENT_SECRET              = data.azurerm_key_vault_secret.devportal_client_secret.value
    COOKIE_IV                  = data.azurerm_key_vault_secret.devportal_cookie_iv.value
    COOKIE_KEY                 = data.azurerm_key_vault_secret.devportal_cookie_key.value

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
    JIRA_TOKEN                 = data.azurerm_key_vault_secret.devportal_jira_token.value

    # Feature Flags
    MANAGE_FLOW_ENABLE_USER_LIST = ""
  }

  allowed_subnets = [module.appgateway_snet.id]

  tags = var.tags
}
