#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_cgn_merchant" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.64.0"

  resource_group_name = var.resource_group_name
  name                = "${var.project}-cgn-merchant-fn"
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_cgn_common.id
  health_check_path   = "/api/v1/merchant/cgn/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn_merchant.app_settings_common,
  )

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_apim_v2.id
  ]

  tags = var.tags
}

module "function_cgn_merchant_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.64.0"

  name                = "staging"
  location            = var.location
  resource_group_name = var.resource_group_name
  function_app_id     = module.function_cgn_merchant.id
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_cgn_common.id
  health_check_path   = "/api/v1/merchant/cgn/info"

  storage_account_name       = module.function_cgn_merchant.storage_account_name
  storage_account_access_key = module.function_cgn_merchant.storage_account.primary_access_key

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn_merchant.app_settings_common,
  )

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_azdoa.id,
    data.azurerm_subnet.snet_apim_v2.id
  ]

  tags = var.tags
}
