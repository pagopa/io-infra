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
# APIM
#
data "azurerm_subnet" "apim" {
  name                 = "apimv2api"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}

data "azurerm_api_management" "apim" {
  name                = "io-p-apim-v2-api"
  resource_group_name = "io-p-rg-internal"
}

#
# Logs resources
#

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.project), "-", "")
  resource_group_name = format("%s-rg-operations", local.project)
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

data "azurerm_resource_group" "lollipop_function_rg" {
  name = format("%s-itn-lollipop-rg-01", local.project)
}

data "azurerm_linux_function_app" "lollipop_function" {
  name                = format("%s-itn-lollipop-fn-01", local.project)
  resource_group_name = data.azurerm_resource_group.lollipop_function_rg.name
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_push_notifications = "push-notifications"
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
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}



#
# App Backend shared resources
#

data "azurerm_key_vault_secret" "app_backend_PRE_SHARED_KEY" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
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
    action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
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
    action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
    webhook_properties = {}
  }

  tags = var.tags
}

#
# Services App service and fn
#
data "azurerm_linux_web_app" "cms_backoffice_app_itn" {
  name                = "${local.project}-itn-svc-bo-app-01"
  resource_group_name = "${local.project}-itn-svc-rg-01"
}

data "azurerm_linux_function_app" "services_app_backend_function_app" {
  resource_group_name = format("%s-itn-svc-rg-01", local.project)
  name                = format("%s-itn-svc-app-be-func-01", local.project)
}

#
# CGN
#

data "azurerm_linux_function_app" "function_cgn" {
  resource_group_name = "${local.project}-cgn-be-rg"
  name                = format("%s-cgn-fn", local.project)
}

#
# SelfCare
#

data "azurerm_dns_a_record" "selfcare_cdn" {
  name                = "@"
  resource_group_name = data.azurerm_dns_zone.io_selfcare_pagopa_it[0].resource_group_name
  zone_name           = data.azurerm_dns_zone.io_selfcare_pagopa_it[0].name
}

#
# DevPortal
#

data "azurerm_linux_web_app" "appservice_devportal_be" {
  name                = "${local.project}-app-devportal-be"
  resource_group_name = "${local.project}-selfcare-be-rg"
}

data "azurerm_linux_web_app" "appservice_selfcare_be" {
  name                = "${local.project}-app-selfcare-be"
  resource_group_name = "${local.project}-selfcare-be-rg"
}

#
# Continua
#

data "azurerm_linux_web_app" "appservice_continua" {
  name                = "${local.project}-app-continua"
  resource_group_name = "${local.project}-continua-rg"
}

#
# EuCovid
#

data "azurerm_linux_function_app" "eucovidcert" {
  resource_group_name = "${local.project}-rg-eucovidcert"
  name                = format("%s-eucovidcert-fn", local.project)
}

#
# Messages
#

data "azurerm_linux_function_app" "app_messages_1" {
  resource_group_name = "${local.project}-app-messages-rg-1"
  name                = "${local.project}-app-messages-fn-1"
}

data "azurerm_linux_function_app" "app_messages_2" {
  resource_group_name = "${local.project}-app-messages-rg-2"
  name                = "${local.project}-app-messages-fn-2"
}

data "azurerm_linux_function_app" "citizen_func_01" {
  resource_group_name = "io-p-itn-msgs-rg-01"
  name                = "io-p-itn-msgs-citizen-func-01"
}

data "azurerm_linux_function_app" "citizen_func_02" {
  resource_group_name = "io-p-itn-msgs-rg-01"
  name                = "io-p-itn-msgs-citizen-func-02"
}

#
# ELT
#

data "azurerm_subnet" "function_let_snet" {
  name                 = "fn3eltout"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}

#
# Functions
#

data "azurerm_subnet" "admin_snet" {
  name                 = format("%s-admin-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}

data "azurerm_subnet" "services_snet" {
  count                = var.function_services_count
  name                 = format("%s-services-snet-%d", local.project, count.index + 1)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}

data "azurerm_linux_function_app" "function_app" {
  count               = var.function_app_count
  name                = format("%s-app-fn-%d", local.project, count.index + 1)
  resource_group_name = format("%s-app-rg-%d", local.project, count.index + 1)
}

data "azurerm_linux_function_app" "function_assets_cdn" {
  name                = format("%s-assets-cdn-fn", local.project)
  resource_group_name = format("%s-assets-cdn-rg", local.project)
}

data "azurerm_api_management" "trial_system" {
  provider            = azurerm.prod-trial
  name                = "ts-p-itn-apim-01"
  resource_group_name = "ts-p-itn-routing-rg-01"
}

### Network and DNS
# TO BE REMOVED WHEN RESOURCES ARE
# MOVED TO THE MODULAR FORM
data "azurerm_virtual_network" "common" {
  name                = "${local.project}-vnet-common"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_nat_gateway" "ng" {
  name                = "${local.project}-natgw"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "${local.project}-evt-rg"
}

data "azurerm_private_dns_zone" "privatelink_azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_dns_zone" "io_pagopa_it" {
  count               = (var.dns_zone_io == null || var.external_domain == null) ? 0 : 1
  name                = "io.pagopa.it"
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_zone" "io_italia_it" {
  name                = "io.italia.it"
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_zone" "io_selfcare_pagopa_it" {
  count               = (var.dns_zone_io_selfcare == null || var.external_domain == null) ? 0 : 1
  name                = "io.selfcare.pagopa.it"
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_zone" "firmaconio_selfcare_pagopa_it" {
  count               = (var.dns_zone_firmaconio_selfcare == null || var.external_domain == null) ? 0 : 1
  name                = "firmaconio.selfcare.pagopa.it"
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = "${local.project}-vnet-common"
  resource_group_name  = "${local.project}-rg-common"
}

data "azurerm_dns_a_record" "developerportal_backend_io_italia_it" {
  name                = "developerportal-backend"
  zone_name           = data.azurerm_dns_zone.io_italia_it.name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "app_backend_io_italia_it" {
  name                = "app-backend"
  zone_name           = data.azurerm_dns_zone.io_italia_it.name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_io_pagopa_it" {
  name                = "api"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_app_io_pagopa_it" {
  name                = "api-app"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_web_io_pagopa_it" {
  name                = "api-web"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_mtls_io_pagopa_it" {
  name                = "api-mtls"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "continua_io_pagopa_it" {
  name                = "continua"
  zone_name           = data.azurerm_dns_zone.io_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_io_selfcare_pagopa_it" {
  name                = "api"
  zone_name           = data.azurerm_dns_zone.io_selfcare_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "firmaconio_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = data.azurerm_dns_zone.firmaconio_selfcare_pagopa_it[0].name
  resource_group_name = "${local.project}-rg-external"
}

data "azurerm_dns_a_record" "api_io_italia_it" {
  name                = "api"
  zone_name           = data.azurerm_dns_zone.io_italia_it.name
  resource_group_name = "${local.project}-rg-external"
}

#
# AppGateway
#

data "azurerm_subnet" "appgateway_snet" {
  name                 = "${local.project}-appgateway-snet"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}

#
# Azure DevOps Agent
#

data "azurerm_subnet" "azdoa_snet" {
  name                 = "azure-devops"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = data.azurerm_virtual_network.common.name
}