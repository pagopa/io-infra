resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_redis_cache" "redis_common" {
  name                = format("%s-redis-common", local.project)
  resource_group_name = format("%s-rg-common", local.project)
}

#
# Function cgn
#

data "azurerm_redis_cache" "redis_cgn" {
  name                = format("%s-redis-cgn-std", local.project)
  resource_group_name = format("%s-rg-cgn", local.project)
}

data "azurerm_cosmosdb_account" "cosmos_cgn" {
  name                = format("%s-cosmos-cgn", local.project)
  resource_group_name = format("%s-rg-cgn", local.project)
}

#
# Function services resources
#

data "azurerm_function_app" "fnapp_services" {
  name                = format("%s-fn3-services", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_subnet" "fnapp_services_subnet_out" {
  name                 = "fn3services"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Function admin resources
#

data "azurerm_function_app" "fnapp_admin" {
  name                = format("%s-fn3-admin", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_subnet" "fnapp_admin_subnet_out" {
  name                 = "fn3admin"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Bonus vacanze resources
#

data "azurerm_function_app" "fnapp_bonus" {
  name                = format("%s-func-bonus", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

#
# EUCovicCert resources
#

data "azurerm_function_app" "fnapp_eucovidcert" {
  name                = format("%s-fn3-eucovidcert", local.project)
  resource_group_name = format("%s-rg-eucovidcert", local.project)
}

data "azurerm_key_vault_secret" "fnapp_eucovidcert_authtoken" {
  name         = "funceucovidcert-KEY-PUBLICIOEVENTDISPATCHER"
  key_vault_id = module.key_vault.id
}

data "azurerm_subnet" "fnapp_eucovidcert_subnet_out" {
  name                 = "fn3eucovidcert"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Logs resources
#

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.project), "-", "")
  resource_group_name = format("%s-rg-operations", local.project)
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_spidmsgitems = "spidmsgitems"
  storage_account_notifications_queue_userslogin   = "userslogin"
}

#
# Notifications resources
#

data "azurerm_storage_account" "notifications" {
  name                = replace(format("%s-stnotifications", local.project), "-", "")
  resource_group_name = format("%s-rg-internal", local.project)
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_push_notifications = "push-notifications"
}

#
# Private subnet
#

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Private dns zones
#

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = format("%s-rg-common", local.project)
}

# KeyVault values - start
data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# Storage Accounts
#
data "azurerm_storage_account" "api" {
  name                = "iopstapi"
  resource_group_name = azurerm_resource_group.rg_internal.name
}

# CDN Assets storage account
data "azurerm_storage_account" "cdnassets" {
  name                = "iopstcdnassets"
  resource_group_name = var.common_rg
}

# Event hubs

data "azurerm_eventhub_authorization_rule" "io-p-payments-weu-prod01-evh-ns_payment-updates_io-fn-messages-cqrs" {
  name                = "io-fn-messages-cqrs"
  namespace_name      = "${local.project}-payments-weu-prod01-evh-ns"
  eventhub_name       = "payment-updates"
  resource_group_name = "${local.project}-payments-weu-prod01-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "io-p-messages-weu-prod01-evh-ns_messages_io-fn-messages-cqrs" {
  name                = "io-fn-messages-cqrs"
  namespace_name      = "${local.project}-messages-weu-prod01-evh-ns"
  eventhub_name       = "messages"
  resource_group_name = "${local.project}-messages-weu-prod01-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "io-p-messages-weu-prod01-evh-ns_message-status_io-fn-messages-cqrs" {
  name                = "io-fn-messages-cqrs"
  namespace_name      = "${local.project}-messages-weu-prod01-evh-ns"
  eventhub_name       = "message-status"
  resource_group_name = "${local.project}-messages-weu-prod01-evt-rg"
}

data "azurerm_key_vault_secret" "apim_services_subscription_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}


# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmos_api_throttling_alert" {

  name                = "[IO-COMMONS | ${data.azurerm_cosmosdb_account.cosmos_api.name}] Throttling"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [data.azurerm_cosmosdb_account.cosmos_api.id]
  # TODO: add Runbook for checking errors
  description   = "One or more collections consumed throughput (RU/s) exceed provisioned throughput. Please, consider to increase RU for these collections. Runbook: not needed."
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftdocumentdbdatabaseaccounts
  criteria {
    metric_namespace       = "Microsoft.DocumentDB/databaseAccounts"
    metric_name            = "TotalRequestUnits"
    aggregation            = "Total"
    operator               = "GreaterThan"
    threshold              = 0
    skip_metric_validation = false


    dimension {
      name     = "Region"
      operator = "Include"
      values   = ["West Europe"]
    }
    dimension {
      name     = "StatusCode"
      operator = "Include"
      values   = ["429"]
    }
    dimension {
      name     = "CollectionName"
      operator = "Include"
      values   = ["*"]
    }

  }

  action {
    action_group_id    = azurerm_monitor_action_group.error_action_group.id
    webhook_properties = {}
  }

  tags = var.tags
}


resource "azurerm_monitor_metric_alert" "iopstapi_throttling_low_availability" {

  name                = "[IO-COMMONS | ${data.azurerm_storage_account.api.name}] Low Availability"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [data.azurerm_storage_account.api.id]
  # TODO: add Runbook for checking errors
  description   = "The average availability is less than 99.8%. Runbook: not needed."
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftclassicstoragestorageaccountsblobservices
  criteria {
    metric_namespace       = "Microsoft.ClassicStorage/storageAccounts"
    metric_name            = "Availability"
    aggregation            = "Average"
    operator               = "LessThan"
    threshold              = 99.8
    skip_metric_validation = false
  }

  action {
    action_group_id    = azurerm_monitor_action_group.error_action_group.id
    webhook_properties = {}
  }

  tags = var.tags
}