locals {

  resource_group_name_common = "${var.project}-rg-common"
  vnet_name_common           = "${var.project}-vnet-common"

  vnet_common_itn           = "${var.project_itn}-common-vnet-01"
  resource_group_common_itn = "${var.project_itn}-common-rg-01"
}

locals {
  continua_appsvc_settings = {
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    PORT = "3000"

    # Fallback
    FALLBACK_URL            = "https://ioapp.it/scarica-io"
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