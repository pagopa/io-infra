resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_cosmosdb_account" "cosmos_remote_content" {
  name                = "io-p-messages-remote-content"
  resource_group_name = "io-p-messages-data-rg"
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

data "azurerm_resource_group" "notifications_rg" {
  name = format("%s-weu-messages-notifications-rg", local.project)
}

data "azurerm_storage_account" "push_notifications_storage" {
  name                = replace(format("%s-weu-messages-notifst", local.project), "-", "")
  resource_group_name = data.azurerm_resource_group.notifications_rg.name
}

data "azurerm_storage_account" "notifications" {
  name                = replace(format("%s-stnotifications", local.project), "-", "")
  resource_group_name = format("%s-rg-internal", local.project)
}

#
# LOLLIPOP
#

data "azurerm_storage_account" "lollipop_assertions_storage" {
  name                = replace(format("%s-%s", var.citizen_auth_product, var.citizen_auth_assertion_storage_name), "-", "")
  resource_group_name = format("%s-%s-data-rg", var.citizen_auth_product, var.citizen_auth_domain)
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_push_notifications = "push-notifications"
}

# KeyVault values - start
data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
  key_vault_id = module.key_vault_common.id
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
  key_vault_id = module.key_vault_common.id
}

# MAILUP

data "azurerm_key_vault_secret" "common_MAILUP_USERNAME" {
  name         = "common-MAILUP2-USERNAME"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "common_MAILUP_SECRET" {
  name         = "common-MAILUP2-SECRET"
  key_vault_id = module.key_vault_common.id
}

#
# App Backend shared resources
#

data "azurerm_key_vault_secret" "app_backend_PRE_SHARED_KEY" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = module.key_vault_common.id
}


# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmos_api_throttling_alert" {

  name                = "[IO-COMMONS | ${data.azurerm_cosmosdb_account.cosmos_api.name}] Throttling"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [data.azurerm_cosmosdb_account.cosmos_api.id]
  # TODO: add Runbook for checking errors
  description   = "One or more collections consumed throughput (RU/s) exceed provisioned throughput. Please, consider to increase RU for these collections. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/723452380/CosmosDB+-+Increase+Max+RU"
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

  name                = "[IO-COMMONS | ${module.storage_api.name}] Low Availability"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [module.storage_api.id]
  # TODO: add Runbook for checking errors
  description   = "The average availability is less than 99.8%. Runbook: not needed."
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftstoragestorageaccounts
  criteria {
    metric_namespace       = "Microsoft.Storage/storageAccounts"
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

resource "azurerm_monitor_metric_alert" "cosmos_cgn_throttling_alert" {

  name                = "[CGN | ${data.azurerm_cosmosdb_account.cosmos_cgn.name}] Throttling"
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  scopes              = [data.azurerm_cosmosdb_account.cosmos_cgn.id]
  # TODO: add Runbook for checking errors
  description   = "One or more collections consumed throughput (RU/s) exceed provisioned throughput. Please, consider to increase RU for these collections. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/723452380/CosmosDB+-+Increase+Max+RU"
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

#
# IO Services CMS BackOffice App
#

data "azurerm_linux_web_app" "cms_backoffice_app" {
  name                = format("%s-services-cms-backoffice-app", local.project)
  resource_group_name = format("%s-services-cms-rg", local.project)
}


data "azurerm_subnet" "services_cms_backoffice_snet" {
  name                 = format("%s-services-cms-backoffice-snet", local.project)
  virtual_network_name = module.vnet_common.name
  resource_group_name  = azurerm_resource_group.rg_common.name
}

#
# UNIQUE EMAIL ENFORCEMENT
#

data "azurerm_storage_account" "citizen_auth_common" {
  name                = "iopweucitizenauthst"
  resource_group_name = "io-p-citizen-auth-data-rg"
}

#
# MANAGED IDENTITIES
#

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.project}-infra-github-ci-identity"
  resource_group_name = "${local.project}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.project}-infra-github-cd-identity"
  resource_group_name = "${local.project}-identity-rg"
}
