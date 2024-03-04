#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.63.0"

  resource_group_name = var.resource_group_name
  name                = format("%s-cgn-fn", var.project)
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/cgn/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "0",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "0",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "0"
    }
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = var.subnet_private_endpoints_id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_backendl1,
    data.azurerm_subnet.snet_backendl2,
    data.azurerm_subnet.snet_backendli,
    data.azurerm_subnet.snet_apim_v2.id,
  ]

  sticky_app_setting_names = [
    "AzureWebJobs.ContinueEycaActivation.Disabled",
    "AzureWebJobs.UpdateExpiredCgn.Disabled",
    "AzureWebJobs.UpdateExpiredEyca.Disabled"
  ]

  tags = var.tags
}

module "function_cgn_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.63.0"

  name                = "staging"
  location            = var.location
  resource_group_name = var.resource_group_name
  function_app_id     = module.function_cgn.id
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/cgn/info"

  storage_account_name       = module.function_cgn.storage_account.name
  storage_account_access_key = module.function_cgn.storage_account.primary_access_key

  internal_storage_connection_string = module.function_cgn.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "1",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "1",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "1"
    }
  )

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_azdoa.id,
    data.azurerm_subnet.snet_backendl1,
    data.azurerm_subnet.snet_backendl2,
    data.azurerm_subnet.snet_backendli,
    data.azurerm_subnet.snet_apim_v2.id,
  ]

  tags = var.tags
}
