#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  resource_group_name          = var.resource_group_name
  name                         = "${var.project}-cgn-fn"
  location                     = var.location
  app_service_plan_id          = azurerm_app_service_plan.app_service_plan_cgn_common.id
  health_check_path            = "/api/v1/cgn/info"
  health_check_maxpingfailures = 2

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "1",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "1",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "1"
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
    data.azurerm_subnet.snet_backendl1.id,
    data.azurerm_subnet.snet_backendl2.id,
    data.azurerm_subnet.snet_backendli.id,
    data.azurerm_subnet.snet_apim_v2.id,
    data.azurerm_subnet.snet_backendl3.id
  ]

  sticky_app_setting_names = [
    "AzureWebJobs.ContinueEycaActivation.Disabled",
    "AzureWebJobs.UpdateExpiredCgn.Disabled",
    "AzureWebJobs.UpdateExpiredEyca.Disabled"
  ]

  tags = var.tags
}

module "function_cgn_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.64.0"

  name                         = "staging"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  function_app_id              = module.function_cgn.id
  app_service_plan_id          = azurerm_app_service_plan.app_service_plan_cgn_common.id
  health_check_path            = "/api/v1/cgn/info"
  health_check_maxpingfailures = 2

  storage_account_name       = module.function_cgn.storage_account_name
  storage_account_access_key = module.function_cgn.storage_account.primary_access_key

  internal_storage_connection_string = module.function_cgn.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "1",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "1",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "1"
    }
  )

  subnet_id = var.subnet_id

  allowed_subnets = [
    var.subnet_id,
    data.azurerm_subnet.snet_azdoa.id,
    data.azurerm_subnet.snet_backendl1.id,
    data.azurerm_subnet.snet_backendl2.id,
    data.azurerm_subnet.snet_backendli.id,
    data.azurerm_subnet.snet_apim_v2.id,
    data.azurerm_subnet.snet_backendl3.id,
  ]

  tags = var.tags
}

resource "azurerm_private_endpoint" "function_sites" {
  name                = "${var.project}-cgn-fn-pep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${var.project}-cgn-fn-pep"
    private_connection_resource_id = module.function_cgn.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_sites" {
  name                = "${var.project}-cgn-fn-staging-pep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${var.project}-cgn-fn-pep"
    private_connection_resource_id = module.function_cgn.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_cgn_staging_slot.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}