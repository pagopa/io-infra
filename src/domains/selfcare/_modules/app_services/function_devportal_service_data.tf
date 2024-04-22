module "function_devportalservicedata" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  name                = "${var.project}-devportalsrvdata-fn"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.selfcare_be_common.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = var.private_endpoint_subnet_id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core.id],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
    "queues"                     = []
    use_legacy_defender_version  = true
  }

  runtime_version   = "~3"
  health_check_path = "/api/v1/info"
  node_version      = "14"

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
  }

  internal_storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }

  subnet_id   = var.subnet_id
  allowed_ips = var.app_insights_ips
  allowed_subnets = [
    var.subnet_id,
  ]

  app_settings = merge(local.function_devportalservicedata.app_settings, {
    // those are slot configs
    "AzureWebJobs.OnServiceChange.Disabled"                 = "0"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "0"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "0"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "0"
  })

  sticky_app_setting_names = [
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled",
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled",
    "AzureWebJobs.OnServiceChange.Disabled",
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"
  ]

  tags = var.tags
}

module "function_devportalservicedata_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.69.1"

  name                = "staging"
  location            = var.location
  resource_group_name = module.function_subscriptionmigrations.resource_group_name
  function_app_id     = module.function_devportalservicedata.id
  app_service_plan_id = azurerm_service_plan.selfcare_be_common.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name               = module.function_devportalservicedata.storage_account_name
  storage_account_access_key         = module.function_devportalservicedata.storage_account.primary_access_key
  internal_storage_connection_string = module.function_devportalservicedata.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  health_check_path = "/api/v1/info"
  node_version      = "14"
  always_on         = "true"

  subnet_id = var.subnet_id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    data.azurerm_subnet.snet_azdoa.id
  ]

  app_settings = merge(local.function_devportalservicedata.app_settings, {
    // disable listeners on staging slot
    "AzureWebJobs.OnServiceChange.Disabled"                 = "1"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "1"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "1"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "1"
  })

  tags = var.tags
}
