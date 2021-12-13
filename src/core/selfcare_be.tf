module "selfcare_be" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.2"

  name = "${var.location}-${var.environment}"

  ftps_state = "AllAllowed"

  plan_name     = "${var.location}-plan"
  plan_sku_size = var.app_service_plan_sku
  plan_sku_tier = var.app_service_plan_sku_tier
  plan_kind     = var.app_service_plan_kind
  plan_reserved = var.app_service_plan_reserved

  resource_group_name = data.azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  linux_fx_version = "${var.runtime_name}|${var.runtime_version}"

  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION = "6.11.2"
    WEBSITE_NPM_DEFAULT_VERSION  = "6.1.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

    LOG_LEVEL     = "info"
    
    LOGO_URL            = "https://assets.cdn.io.italia.it/logos"
    SANDBOX_FISCAL_CODE = data.azurerm_key_vault_secret.io_sandbox_fiscal_code.value

    # SelfCare configuration
    IDP = "selfcare"
    

    # Fn-Admin connection
    ADMIN_API_URL   = "http://api-internal.io.italia.it"
    ADMIN_API_KEY   = data.azurerm_key_vault_secret.apim_io_service_key.value

    # Apim connection
    APIM_PRODUCT_NAME           = "io-services-api"
    APIM_USER_GROUPS            = "apilimitedmessagewrite,apiinforead,apimessageread,apilimitedprofileread"
    ARM_APIM                    = "io-p-apim-api"
    ARM_RESOURCE_GROUP          = "io-p-rg-internal"
    ARM_SUBSCRIPTION_ID         = data.azurerm_key_vault_secret.devportal_arm_subscription_id.value
    ARM_TENANT_ID               = data.azurerm_key_vault_secret.devportal_arm_tenant_id.value
    SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.devportal_service_principal_client_id.value
    SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.devportal_service_principal_secret.value
    SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_key_vault_secret.devportal_service_principal_tenant_id.value
    USE_SERVICE_PRINCIPAL       = "1"

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





  }

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  tags = {
    environment = var.environment
  }
}


resource "azurerm_app_service_virtual_network_swift_connection" "swift" {
  depends_on     = [module.selfcare_be, azurerm_subnet.subnet]
  app_service_id = module.selfcare_be.id
  subnet_id      = azurerm_subnet.subnet.id
}

#
# KeyVault values
#

data "azurerm_key_vault_secret" "apim_io-service-key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_arm-subscription-id" {
  name         = "devportal-ARM-SUBSCRIPTION-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_arm-tenant-id" {
  name         = "devportal-ARM-TENANT-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_client-id" {
  name         = "devportal-CLIENT-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_client-secret" {
  name         = "devportal-CLIENT-SECRET"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_cookie-iv" {
  name         = "devportal-COOKIE-IV"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_cookie-key" {
  name         = "devportal-COOKIE-KEY"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_service-principal-client-id" {
  name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_service-principal-secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_service-principal-tenant-id" {
  name         = "devportal-SERVICE-PRINCIPAL-TENANT-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "io_sandbox-fiscal-code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "devportal_jira_token" {
  name         = "devportal-JIRA-TOKEN"
  key_vault_id = module.key_vault.id
}




