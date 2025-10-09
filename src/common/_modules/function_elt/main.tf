
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

  resource_group_name = var.resource_group_name

  virtual_network = {
    name                = var.vnet_common_name_itn
    resource_group_name = var.common_resource_group_name_itn
  }

  subnet_cidr                          = var.elt_snet_cidr
  health_check_path                    = "/api/v1/info"
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.weu-common.name

  # TODO: change module to use connection string instead
  application_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  # app_service_plan_info = {
  #   kind                         = "elastic"
  #   sku_tier                     = "ElasticPremium"
  #   sku_size                     = "EP2"
  #   maximum_elastic_worker_count = 5
  #   worker_count                 = null
  #   zone_balancing_enabled       = null
  # }

  app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled"                                  = "1"
      "AzureWebJobs.CosmosApiMessageStatusChangeFeed.Disabled"                             = "1"
      "AzureWebJobs.CosmosApiMessagesChangeFeed.Disabled"                                  = "1"
      "AzureWebJobs.AnalyticsMessagesChangeFeedInboundProcessorAdapter.Disabled"           = "0"
      "AzureWebJobs.AnalyticsMessagesStorageQueueInboundProcessorAdapter.Disabled"         = "0"
      "AzureWebJobs.AnalyticsMessageStatusChangeFeedInboundProcessorAdapter.Disabled"      = "0"
      "AzureWebJobs.AnalyticsMessageStatusStorageQueueInbloundAdapter.Disabled"            = "0"
      "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled"            = "0"
      "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled"          = "0"
      "AzureWebJobs.AnalyticsServicePreferencesChangeFeedInboundProcessorAdapter.Disabled" = "0"
      "AzureWebJobs.AnalyticsProfilesChangeFeedInboundProcessorAdapter.Disabled"           = "0"
      "AzureWebJobs.AnalyticsUserDataProcessingChangeFeedInboundProcessorAdapter.Disabled" = "0"
    }
  )

  # Action groups for alerts
  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id, data.azurerm_monitor_action_group.io_com_action_group.id]

  tags = var.tags
}
