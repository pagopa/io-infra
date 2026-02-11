
module "function_elt_itn" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 3.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "elt"
    instance_number = "01"
  }

  resource_group_name = azurerm_resource_group.itn_elt.name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.elt_snet_cidr
  health_check_path                    = "/api/v1/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name

  application_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled" = "1"
    }
  )

  slot_app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled"                                    = "1"
      "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled"              = "1"
      "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled"            = "1"
      "AzureWebJobs.AnalyticsServicePreferencesChangeFeedInboundProcessorAdapter.Disabled"   = "1"
      "AzureWebJobs.AnalyticsProfilesChangeFeedInboundProcessorAdapter.Disabled"             = "1"
      "AzureWebJobs.AnalyticsUserDataProcessingChangeFeedInboundProcessorAdapter.Disabled"   = "1"
      "AzureWebJobs.AnalyticsProfileStorageQueueInboundProcessorAdapter.Disabled"            = "1"
      "AzureWebJobs.AnalyticsServicePreferencesStorageQueueInboundProcessorAdapter.Disabled" = "1"
      "AzureWebJobs.AnalyticsUserDataProcessingStorageQueueInboundProcessorAdapter.Disabled" = "1"
      "AzureWebJobs.CosmosApiServicesImportEvent.Disabled"                                   = "1"
    }
  )

  sticky_app_setting_names = [
    "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled",
    "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServicePreferencesChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsProfilesChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsUserDataProcessingChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsProfileStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServicePreferencesStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsUserDataProcessingStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.CosmosApiServicesImportEvent.Disabled",
  ]

  # Action groups for alerts
  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id]

  tags = var.tags
}
