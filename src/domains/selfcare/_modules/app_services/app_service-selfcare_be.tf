#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_selfcare_be" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v7.64.0"

  name                = "${var.project}-app-selfcare-be"
  resource_group_name = var.resource_group_name

  plan_type = "external"
  plan_id   = azurerm_service_plan.selfcare_be_common.id

  app_command_line = "node /home/site/wwwroot/build/src/app.js"
  node_version     = "14-lts"

  health_check_path = "/info"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    LOG_LEVEL = "info"

    SANDBOX_FISCAL_CODE = data.azurerm_key_vault_secret.selfcare_io_sandbox_fiscal_code.value
    LOGO_URL            = "https://assets.cdn.io.italia.it/logos"

    # SelfCare configuration
    IDP = "selfcare"

    # Fn-Admin connection
    ADMIN_API_URL = "https://${var.apim_hostname_api_app_internal}"
    ADMIN_API_KEY = data.azurerm_key_vault_secret.selfcare_apim_io_service_key.value

    # Apim connection
    APIM_PRODUCT_NAME           = "io-services-api"
    APIM_USER_GROUPS            = "apimessagewrite,apiinforead,apimessageread,apilimitedprofileread"
    ARM_APIM                    = "io-p-apim-v2-api"
    ARM_RESOURCE_GROUP          = "io-p-rg-internal"
    ARM_SUBSCRIPTION_ID         = data.azurerm_subscription.current.subscription_id
    ARM_TENANT_ID               = data.azurerm_client_config.current.tenant_id
    SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_client_id.value
    SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_secret.value
    SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_client_config.current.tenant_id
    USE_SERVICE_PRINCIPAL       = "1"

    FRONTEND_URL        = "https://${var.frontend_hostname}"
    BACKEND_URL         = "${var.backend_hostname}"
    LOGIN_URL           = "https://${var.frontend_hostname}/login"
    FAILURE_URL         = "https://${var.frontend_hostname}/500.html"
    SELFCARE_LOGIN_URL  = "https://${var.selfcare_external_hostname}/auth/login"
    SELFCARE_IDP_ISSUER = "https://${var.selfcare_external_hostname}"
    SELFCARE_JWKS_URL   = "https://${var.selfcare_external_hostname}/.well-known/jwks.json"
    JWT_SIGNATURE_KEY   = trimspace(module.selfcare_jwt.jwt_private_key_pem) # to avoid unwanted changes

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

    SUBSCRIPTION_MIGRATIONS_URL    = format("https://%s.azurewebsites.net/api/v1", data.azurerm_linux_function_app.fn_subscription_migration.name)
    SUBSCRIPTION_MIGRATIONS_APIKEY = data.azurerm_key_vault_secret.selfcare_subsmigrations_apikey.value

    # Request Review Legacy Queue
    REQUEST_REVIEW_LEGACY_QUEUE_CONNECTIONSTRING = data.azurerm_key_vault_secret.devportal_request_review_legacy_queue_connectionstring.value
    REQUEST_REVIEW_LEGACY_QUEUE_NAME             = "request-review-legacy"

    # Feature Flags
    #
    # List of (comma separated) APIM userId for whom we want to enable Manage Flow on Service Management.
    # All users not listed below, will not be able to get (and also create) the manage subscription.
    # The "Manage Flow" allows the use of a specific subscription (Manage Subscription) keys as API Key for Service create/update.
    # Note: The list below is for the user IDs only, not the full path APIM.id.
    # UPDATE: The new feature is that "If one of such strings is "*", we suddenly open the feature to everyone.".
    MANAGE_FLOW_ENABLE_USER_LIST = "*"

    # Lock the creation of a new APIM user, when resolve SelfCareIdentity.
    LOCK_SELFCARE_CREATE_NEW_APIM_USER = "false"

    API_SERVICES_CMS_URL       = "https://${data.azurerm_linux_function_app.webapp_functions_app.default_hostname}"
    API_SERVICES_CMS_BASE_PATH = "/api/v1"

  }

  allowed_subnets = [
    data.azurerm_subnet.snet_app_gw.id,
  ]

  tags = var.tags
}

# Only 1 subnet can be associated to a service plan
# azurerm_app_service_virtual_network_swift_connection requires an app service id
# so we choose one of the app service in the app service plan
resource "azurerm_app_service_virtual_network_swift_connection" "selfcare_be" {
  app_service_id = module.appservice_selfcare_be.id
  subnet_id      = var.subnet_id
}

