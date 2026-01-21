
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

  application_insights_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled"                             = "1"
      "AzureWebJobs.CosmosApiMessageStatusChangeFeed.Disabled"                        = "1"
      "AzureWebJobs.CosmosApiMessagesChangeFeed.Disabled"                             = "1"
      "AzureWebJobs.AnalyticsMessagesChangeFeedInboundProcessorAdapter.Disabled"      = "1"
      "AzureWebJobs.AnalyticsMessagesStorageQueueInboundProcessorAdapter.Disabled"    = "1"
      "AzureWebJobs.AnalyticsMessageStatusChangeFeedInboundProcessorAdapter.Disabled" = "1"
      "AzureWebJobs.AnalyticsMessageStatusStorageQueueInbloundAdapter.Disabled"       = "1"
    }
  )

  slot_app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled"                                    = "1"
      "AzureWebJobs.CosmosApiMessageStatusChangeFeed.Disabled"                               = "1"
      "AzureWebJobs.CosmosApiMessagesChangeFeed.Disabled"                                    = "1"
      "AzureWebJobs.AnalyticsMessagesChangeFeedInboundProcessorAdapter.Disabled"             = "1"
      "AzureWebJobs.AnalyticsMessagesStorageQueueInboundProcessorAdapter.Disabled"           = "1"
      "AzureWebJobs.AnalyticsMessageStatusChangeFeedInboundProcessorAdapter.Disabled"        = "1"
      "AzureWebJobs.AnalyticsMessageStatusStorageQueueInbloundAdapter.Disabled"              = "1"
      "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled"              = "1"
      "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled"            = "1"
      "AzureWebJobs.AnalyticsServicePreferencesChangeFeedInboundProcessorAdapter.Disabled"   = "1"
      "AzureWebJobs.AnalyticsProfilesChangeFeedInboundProcessorAdapter.Disabled"             = "1"
      "AzureWebJobs.AnalyticsUserDataProcessingChangeFeedInboundProcessorAdapter.Disabled"   = "1"
      "AzureWebJobs.AnalyticsProfileStorageQueueInboundProcessorAdapter.Disabled"            = "1"
      "AzureWebJobs.AnalyticsServicePreferencesStorageQueueInboundProcessorAdapter.Disabled" = "1"
      "AzureWebJobs.AnalyticsUserDataProcessingStorageQueueInboundProcessorAdapter.Disabled" = "1"
      "AzureWebJobs.CosmosApiServicesImportEvent.Disabled"                                   = "1"
      "AzureWebJobs.CreateMessageReportTimeTrigger.Disabled"                                 = "1"
      "AzureWebJobs.EnrichMessagesReportBlobTrigger.Disabled"                                = "1"
    }
  )

  sticky_app_setting_names = [
    "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled",
    "AzureWebJobs.CosmosApiMessageStatusChangeFeed.Disabled",
    "AzureWebJobs.CosmosApiMessagesChangeFeed.Disabled",
    "AzureWebJobs.AnalyticsMessagesChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsMessagesStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsMessageStatusChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsMessageStatusStorageQueueInbloundAdapter.Disabled",
    "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServicePreferencesChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsProfilesChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsUserDataProcessingChangeFeedInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsProfileStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsServicePreferencesStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.AnalyticsUserDataProcessingStorageQueueInboundProcessorAdapter.Disabled",
    "AzureWebJobs.CosmosApiServicesImportEvent.Disabled",
    "AzureWebJobs.CreateMessageReportTimeTrigger.Disabled",
    "AzureWebJobs.EnrichMessagesReportBlobTrigger.Disabled",
  ]

  # Action groups for alerts
  action_group_ids = [data.azurerm_monitor_action_group.error_action_group.id, data.azurerm_monitor_action_group.io_com_action_group.id]

  tags = var.tags
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messages-failure" {
  name                 = "pdnd-io-cosmosdb-messages-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messages-failure-poison" {
  name                 = "pdnd-io-cosmosdb-messages-failure-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messagestatus-failure" {
  name                 = "pdnd-io-cosmosdb-messagestatus-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-messagestatus-failure-poison" {
  name                 = "pdnd-io-cosmosdb-messagestatus-failure-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-notificationstatus-failure" {
  name                 = "pdnd-io-cosmosdb-notificationstatus-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-notificationstatus-failure-poison" {
  name                 = "pdnd-io-cosmosdb-notificationstatus-failure-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-service-preferences-failure" {
  name                 = "pdnd-io-cosmosdb-service-preferences-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-service-preferences-failure-poison" {
  name                 = "pdnd-io-cosmosdb-service-preferences-failure-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profiles-failure" {
  name                 = "pdnd-io-cosmosdb-profiles-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profiles-failure-poison" {
  name                 = "pdnd-io-cosmosdb-profiles-failure-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profile-deletion-failure" {
  name                 = "pdnd-io-cosmosdb-profile-deletion-failure"
  storage_account_name = module.function_elt_itn.storage_account.name
}

resource "azurerm_storage_queue" "pdnd-io-cosmosdb-profile-deletion-poison" {
  name                 = "pdnd-io-cosmosdb-profile-deletion-poison"
  storage_account_name = module.function_elt_itn.storage_account.name
}
