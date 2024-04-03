locals {
  continua_appsvc_settings = {
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    NODE_ENV = "production"
    PORT     = "3000"

    # Fallback
    FALLBACK_URL            = "https://io.italia.it"
    FALLBACK_URL_ON_IOS     = "https://apps.apple.com/it/app/io/id1501681835"
    FALLBACK_URL_ON_ANDROID = "https://play.google.com/store/apps/details?id=it.pagopa.io.app"

    # iOS
    IOS_APP_ID     = "M2X5YQ4BJ7"
    IOS_BUNDLE_ID  = "it.pagopa.app.io"
    IOS_APP_SCHEME = "ioit://"

    # Android
    ANDROID_PACKAGE_NAME              = "it.pagopa.io.app"
    ANDROID_SHA_256_CERT_FINGERPRINTS = "7D:E4:FE:3E:AA:E0:83:FF:CD:8B:07:03:01:E8:65:02:D3:F1:EA:D1:DD:66:AC:14:2B:AD:7C:54:47:55:4F:82"
  }
}

module "appservice_continua" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v7.67.1"

  name                = format("%s-app-continua", var.project)
  resource_group_name = var.resource_group_name
  location            = var.location

  app_command_line             = "yarn start"
  health_check_path            = "/health"
  health_check_maxpingfailures = 3
  node_version                 = "18-lts"
  app_settings                 = local.continua_appsvc_settings
  sticky_settings              = []

  always_on = true
  plan_id   = azurerm_service_plan.continua.id
  plan_type = "external"

  vnet_integration = true
  subnet_id        = var.subnet_id
  allowed_subnets = [
    data.azurerm_subnet.snet_appgw.id,
  ]

  tags = var.tags
}

module "appservice_continua_slot_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v7.67.1"

  name                = "staging"
  resource_group_name = var.resource_group_name
  location            = var.location

  always_on        = true
  app_service_id   = module.appservice_continua.id
  app_service_name = module.appservice_continua.name

  app_command_line  = "yarn start"
  app_settings      = local.continua_appsvc_settings
  health_check_path = "/health"
  node_version      = "18-lts"

  vnet_integration = true
  subnet_id        = var.subnet_id
  allowed_subnets = [
    data.azurerm_subnet.snet_appgw.id,
  ]

  tags = var.tags
}
