module "function_eucovidcert" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  resource_group_name = var.resource_group_name
  name                = "${var.project}-eucovidcert-fn"
  location            = var.location
  health_check_path   = "/api/v1/info"

  node_version    = "14"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = "Linux"
    sku_size                     = "P1v3"
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  app_settings = merge(
    local.function_eucovidcert.app_settings,
    {
      "AzureWebJobs.NotifyNewProfileToDGC.Disabled" = "0"
    }
  )

  sticky_app_setting_names = [
    "AzureWebJobs.NotifyNewProfileToDGC.Disabled",
    "AzureWebJobs.OnProfileCreatedEvent.Disabled"
  ]

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_backendl1.id,
    data.azurerm_subnet.snet_backendl2.id,
    data.azurerm_subnet.snet_pblevtdispatcher.id,
    data.azurerm_subnet.snet_apim_v2.id,
  ]

  tags = var.tags
}

module "function_eucovidcert_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.69.1"

  name                = "staging"
  location            = var.location
  resource_group_name = var.resource_group_name
  function_app_id     = module.function_eucovidcert.id
  app_service_plan_id = module.function_eucovidcert.app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name       = module.function_eucovidcert.storage_account.name
  storage_account_access_key = module.function_eucovidcert.storage_account.primary_access_key

  node_version                             = "14"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_eucovidcert.app_settings,
    {
      "AzureWebJobs.NotifyNewProfileToDGC.Disabled" = "1"
    }
  )

  subnet_id = var.subnet_id

  allowed_subnets = [
    data.azurerm_subnet.snet_azdoa.id,
    var.subnet_id,
    data.azurerm_subnet.snet_backendl1.id,
    data.azurerm_subnet.snet_backendl2.id,
    data.azurerm_subnet.snet_pblevtdispatcher.id,
    data.azurerm_subnet.snet_apim_v2.id,
  ]

  tags = var.tags
}
