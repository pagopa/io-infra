module "app_services" {
  source = "../../_modules/app_services"

  location = local.location
  project  = local.project

  resource_group_name        = module.resource_groups.resource_group_selfcare_be.name
  subnet_id                  = module.networking.subnet_be_common.id
  private_endpoint_subnet_id = module.networking.subnet_pendpoints.id

  frontend_hostname              = local.frontend_hostname
  backend_hostname               = local.backend_hostname
  selfcare_external_hostname     = local.selfcare_external_hostname
  devportal_frontend_hostname    = local.devportal_frontend_hostname
  apim_hostname_api_app_internal = local.apim_hostname_api_app_internal

  dev_portal_db_data = {
    host     = module.postgresql.dev_portal_db_credentials.host
    username = module.postgresql.dev_portal_db_credentials.username
    password = module.postgresql.dev_portal_db_credentials.password
  }

  subsmigrations_db_data = {
    host     = module.postgresql.subsmigrations_db_credentials.host
    username = module.postgresql.subsmigrations_db_credentials.username
    password = module.postgresql.subsmigrations_db_credentials.password
  }

  app_insights_ips = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  app_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  tags = local.tags
}

# App Services

resource "azurerm_role_assignment" "devportal_be_apim_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.app_service_common.devportal_be.principal_id
}

resource "azurerm_role_assignment" "selfcare_be_apim_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.app_service_common.selfcare_be.principal_id
}

resource "azurerm_role_assignment" "devportal_be_apim_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.app_service_common.devportal_be.principal_id
}

resource "azurerm_role_assignment" "selfcare_be_apim_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.app_service_common.selfcare_be.principal_id
}

# Functions

resource "azurerm_role_assignment" "function_subscriptionmigrations_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.function_subscriptionmigrations.principal_id
}

resource "azurerm_role_assignment" "function_devportalservicedata_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.function_devportalservicedata.principal_id
}

resource "azurerm_role_assignment" "function_subscriptionmigrations_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.function_subscriptionmigrations.principal_id
}

resource "azurerm_role_assignment" "function_devportalservicedata_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.function_devportalservicedata.principal_id
}

# Functions Slots

resource "azurerm_role_assignment" "function_subscriptionmigrations_staging_slot_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.function_subscriptionmigrations.slot.principal_id
}

resource "azurerm_role_assignment" "function_devportalservicedata_staging_slot_v2" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_v2_api.id
  principal_id         = module.app_services.function_devportalservicedata.slot.principal_id
}

resource "azurerm_role_assignment" "function_subscriptionmigrations_staging_slot_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.function_subscriptionmigrations.slot.principal_id
}

resource "azurerm_role_assignment" "function_devportalservicedata_staging_slot_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.app_services.function_devportalservicedata.slot.principal_id
}


